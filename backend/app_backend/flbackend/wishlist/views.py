from django.shortcuts import render
from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from . import models, serializers

# Create your views here.
class GetWishList(generics.ListAPIView):
    serializer_class = serializers.WishListSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return models.Wishlist.objects.filter(userId=self.request.user)


class ToggleWishList(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
       user_id = request.user.id
       product_id = request.data.get('id')

       if not user_id or not product_id:
           return Response({'error': 'Invalid request'}, status=status.HTTP_400_BAD_REQUEST)
       
       try :
           product = models.Product.objects.get(id=product_id)
       except models.Product.DoesNotExist:
              return Response({'error': 'Product not found'}, status=status.HTTP_404_NOT_FOUND)
       
       wishList_item , created = models.Wishlist.objects.get_or_create(userId=request.user, product=product)

       if created:
               return Response({'message': 'Product added to wishlist'}, status=status.HTTP_201_CREATED)
       else:
              wishList_item.delete()
              return Response({'message': 'Product removed from wishlist'}, status=status.HTTP_200_OK)