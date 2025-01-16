from rest_framework import serializers
from .models import Cart
from core.serializers import ProductSerializer

class CartSerializer(serializers.ModelSerializer):
    product = ProductSerializer(read_only = True)

    class Meta:
        model = Cart
        exclude = ['userId', 'created_at', 'updated_at']
