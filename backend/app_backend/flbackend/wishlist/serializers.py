from rest_framework import serializers
from .import models

class WishListSerializer(serializers.ModelSerializer):
    id = serializers.IntegerField(source='product.id')
    title = serializers.CharField(source='product.title')
    description = serializers.CharField(source='product.description')
    price = serializers.DecimalField(source='product.price', max_digits=10, decimal_places=2)
    isFeatured = serializers.BooleanField(source='product.isFeatured')
    category = serializers.IntegerField(source='product.category.id')
    brand = serializers.IntegerField(source='product.brand.id')
    rating = serializers.DecimalField(source='product.rating', max_digits=2, decimal_places=1)
    discount = serializers.DecimalField(source='product.discount', max_digits=5, decimal_places=1)
    stock = serializers.IntegerField(source='product.stock')
    itemType = serializers.CharField(source='product.itemType')
    colors = serializers.JSONField(source='product.colors')
    imageURLS = serializers.JSONField(source='product.imageURLS')
    sizes = serializers.JSONField(source='product.sizes')
    created_at = serializers.DateTimeField(source='product.created_at')

    class Meta:
      model = models.Wishlist
      fields = ['id', 'title', 'description', 'price', 'isFeatured', 'category', 'brand',
                  'rating', 'discount', 'stock', 'itemType', 'colors', 'imageURLS', 'sizes', 'created_at']