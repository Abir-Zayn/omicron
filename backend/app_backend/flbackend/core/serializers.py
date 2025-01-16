from rest_framework import serializers
from .import models

# The serializers.py file in the core module defines serializers for the Django REST framework. 
# These serializers convert complex data types, such as Django models, 
# into native Python data types that can then be easily rendered into JSON, XML, or other content types. 



# Defines a serializer for the Category model. It inherits from serializers.ModelSerializer,
# which provides a shortcut for creating serializers that deal with model instances and querysets.
# class Meta: A nested class that defines metadata for the serializer.
# model = models.Category: Specifies that this serializer is for the Category model.
# fields = '__all__': Indicates that all fields of the Category model should be included in the serialization. 
# Alternatively, you could specify specific fields like ['title', 'imageURL']
class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Category
        fields = '__all__'  # ['title', 'imageURL'] for specific fields


class BrandSerializer(serializers.ModelSerializer):
    imageUrl = serializers.URLField(source='imageURL') #source is used to map the field name in the model to the field name in the serializer

    class Meta:
        model = models.Brand
        fields =  ['id', 'title', 'imageUrl'] # ['title', 'imageURL'] for specific fields

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Product
        fields = '__all__'  # ['title', 'imageURL'] for specific fields