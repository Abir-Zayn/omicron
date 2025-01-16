from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from core.models import Product

# Create your models here.
class Cart(models.Model):
    userId = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='cart_items'
    )
    product = models.ForeignKey(
        Product, 
        on_delete=models.CASCADE,
        related_name='cart_entries'
    )
    quantity = models.PositiveIntegerField(default=1)
    size = models.JSONField(blank=True)
    color = models.JSONField(blank=True)
    created_at = models.DateTimeField(default=timezone.now)
    updated_at = models.DateTimeField(auto_now=True)  # Fixed typo from update_at

    def __str__(self):
        return '{}/{}'.format(self.userId.username, self.product.title)
