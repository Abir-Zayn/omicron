from django.shortcuts import render
from django.db import models
from .models import Cart , Product
from .serializers import CartSerializer
from rest_framework.permissions import IsAuthenticated
from django.shortcuts import get_object_or_404
from rest_framework import status, generics
from rest_framework.views import APIView
from rest_framework.response import Response

# Create your views here.

class AddItemToCart(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        try:
            user = request.user
            data = request.data
            
            # Validate required fields
            if not all(key in data for key in ['product', 'size', 'color']):
                return Response(
                    {'error': 'Missing required fields'},
                    status=status.HTTP_400_BAD_REQUEST
                )

            # Get the product
            product = get_object_or_404(Product, id=data['product'])

            # Ensure size and color are lists
            size = data.get('size', [])
            color = data.get('color', [])
            quantity = data.get('quantity', 1)

            # Try to find an existing cart item
            try:
                # Attempt to find an existing cart item
                cart_item = Cart.objects.get(
                    userId=user,
                    product=product,
                    size=size,
                    color=color
                )
                
                # If found, increment quantity
                cart_item.quantity += quantity
                cart_item.save()
                created = False
            except Cart.DoesNotExist:
                # If not found, create a new cart item
                cart_item = Cart.objects.create(
                    userId=user,
                    product=product,
                    size=size,
                    color=color,
                    quantity=quantity
                )
                created = True

            # Prepare response
            status_code = status.HTTP_201_CREATED if created else status.HTTP_200_OK
            return Response({
                'message': 'Product added to cart successfully',
                'created': created,
                'cart_item_id': cart_item.id
            }, status=status_code)

        except Exception as e:
            # Catch and log any unexpected errors
            return Response({
                'error': str(e),
                'message': 'An unexpected error occurred'
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class RemoveItemFromCart(APIView):
    permission_classes = [IsAuthenticated]

    def delete(self, request):
        user = request.user
        cart_id = request.query_params.get('id')

        if not cart_id:
            return Response({'error': 'Cart id is required'}, status=status.HTTP_400_BAD_REQUEST)

        cart_item = get_object_or_404(Cart, id=cart_id, userId=user)
        cart_item.delete()
        return Response({'message': 'Cart item removed successfully'}, status=status.HTTP_204_NO_CONTENT)

class CartCount(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user = request.user
        cart_count =Cart.objects.filter(userId=user).count()
        return Response({'cart count': cart_count}, status=status.HTTP_200_OK)

class UpdateCartItemQuantity(APIView):
    permission_classes = [IsAuthenticated]

    def patch(self, request):
        item_id = request.query_params.get('id')
        count = request.query_params.get('count')

        cart_item = get_object_or_404(Cart, id=item_id, userId=request.user)
        cart_item.quantity = count
        cart_item.save()

        return Response({'message': 'Cart item updated successfully'}, status=status.HTTP_200_OK)

class GetUserCart(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = CartSerializer

    def get(self, request):
        user = request.user
        cart_items = Cart.objects.filter(userId=user).order_by('-created_at')

        serializer = CartSerializer(cart_items, many=True)
        return Response(
                serializer.data 
        )