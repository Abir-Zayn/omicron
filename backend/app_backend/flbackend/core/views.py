from django.shortcuts import render
from rest_framework import generics, status
from . import models, serializers
from  rest_framework.response import Response
from rest_framework.views import APIView

from django.db.models import Count
import random 
# Create your views here.

#Considering the brands as categories
class BrandsList(generics.ListAPIView):
    serializer_class = serializers.BrandSerializer
    queryset = models.Brand.objects.all()

class HomeBrandsList(generics.ListAPIView):
    serializer_class = serializers.BrandSerializer
    
    def get_queryset(self):
        queryset = models.Brand.objects.all()
        queryset = queryset.annotate(random_order=Count('id')).order_by('random_order') #extra mod -> random order
        queryset = list(queryset)
        random.shuffle(queryset)

        return queryset[:5]


class ProductList(generics.ListAPIView):
    serializer_class = serializers.ProductSerializer
    
    def get_queryset(self):
        queryset = models.Product.objects.all()
        queryset = queryset.annotate(random_order=Count('id')).order_by('random_order') #extra mod -> random order
        queryset = list(queryset)
        random.shuffle(queryset)

        return queryset[:15]


class PopularProductsList(generics.ListAPIView):
    serializer_class = serializers.ProductSerializer
    
    def get_queryset(self):
        queryset = models.Product.objects.filter(rating__gte=4.0, rating__lte=5.0)
        queryset = queryset.annotate(random_order=Count('id'))
        queryset = list(queryset)
        random.shuffle(queryset)

        return queryset[:15]


class ProductsListDeals(generics.ListAPIView):
    serializer_class = serializers.ProductSerializer
    
    def get_queryset(self):
        #The queryset will return products which discount is greater than 50
        queryset = models.Product.objects.filter(discount__gte=50)
        queryset = queryset.annotate(random_order=Count('id'))
        queryset = list(queryset)
        random.shuffle(queryset)

        return queryset[:15]

class ProductListByGender(APIView): #ProductListByGender = ProductListByClothes
    serializer_class = serializers.ProductSerializer

    def get(self, request):
        query = next((value for key, value in request.query_params.items() 
                      if key.lower() == 'itemtype'), None)

        if query and query.lower() in ['men','women','kids']:
            queryset = models.Product.objects.filter(itemType__iexact=query)
            queryset = queryset.annotate(random_order=Count('id'))
            
            product_list = list(queryset)
            random.shuffle(product_list)

            limited_products = product_list[:15]
            serializer = serializers.ProductSerializer(limited_products, many=True)
            return Response(serializer.data, status=status.HTTP_200_OK) #Extra mod -> status code
        else:
            return Response({'message':'No Query Provided'},status=status.HTTP_400_BAD_REQUEST)


class SimilarProducts(APIView):

    def get(self, request):
        query = request.query_params.get('brand', None)

        if query :
            products = models.Product.objects.filter(brand_id = query)
            product_list = list(products)
            random.shuffle(product_list)

            limited_products = product_list[:6]
            serializer = serializers.ProductSerializer(limited_products, many=True)

            return Response(serializer.data, status=status.HTTP_200_OK) #Extra mod -> status code
        else:
            return Response({'message':'No Query Provided'},status=status.HTTP_400_BAD_REQUEST)


class SearchProducts(APIView):

    def get(self, request):
        query = request.query_params.get('q', None)

        if query:
            products = models.Product.objects.filter(title__icontains=query)
            serializer = serializers.ProductSerializer(products, many=True)

            return Response(serializer.data, status=status.HTTP_200_OK) #Extra mod -> status code
        else:
            return Response({'message':'No Query Provided'},status=status.HTTP_400_BAD_REQUEST)


class FilterProductsByBrand(APIView):

    def get(self, request):
        brand_id = request.query_params.get('brand', None)

        if brand_id is not None:
            try:
                brand_id = int(brand_id)
                #check if the brand exists
                brand = models.Brand.objects.get(id=brand_id)

                if not brand:
                    return Response({'message':'Brand not found'},status=status.HTTP_404_NOT_FOUND)
                
                 # Get products for this brand
                products = models.Product.objects.filter(brand_id=brand_id).select_related('category', 'brand')

                 # Add some useful metadata to the response
                response_data = {
                    'brand': {
                        'id': brand.id,
                        'title': brand.title,
                        'imageURL': brand.imageURL
                    },
                    'products': serializers.ProductSerializer(products, many=True).data,
                    'total_products': products.count()
                }
                return Response(response_data, status=status.HTTP_200_OK)
            except ValueError:
                return Response(
                    {'message':'Invalid brand id'},status=status.HTTP_400_BAD_REQUEST
                    )
        else:
            return Response({'message':'No brand id provided'},status=status.HTTP_400_BAD_REQUEST)
            
            
