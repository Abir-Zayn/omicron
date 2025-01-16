from django.db import models
from django.utils import timezone

# Objective
# These models represent the structure of the data stored 
# in the database for an e-commerce application.



# Create your models here.
class Category (models.Model):
    title = models.CharField(max_length=100)
    imageURL = models.URLField(max_length=200, blank=False)

    def __str__(self) -> str:
        return self.title

class Brand(models.Model):
    title = models.CharField(max_length=100)
    imageURL = models.URLField(max_length=200, blank=False)

    def __str__(self) -> str:
        return self.title

class Product(models.Model):
    title = models.CharField(max_length=100)
    description = models.TextField(max_length=500)
    price = models.DecimalField(max_digits=10, decimal_places=2, blank=False, default=0.00)
    isFeatured = models.BooleanField(default=False)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)   
    brand = models.ForeignKey(Brand, on_delete=models.CASCADE)
    rating = models.DecimalField(max_digits=2, decimal_places=1, blank=False, default=0.0)
    discount = models.DecimalField(max_digits=5, decimal_places=1, blank=False, default=0.0)
    stock = models.IntegerField(default=0)
    itemType = models.CharField(
           max_length=20, 
        blank=False, 
        default='men',
       
    )
    colors = models.JSONField(blank=True)
    imageURLS = models.JSONField(blank=True)
    sizes = models.JSONField(blank=True)
    created_at = models.DateTimeField(default=timezone.now, blank = False)

    def __str__(self) -> str:
        return self.title

