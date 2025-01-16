from django.db import models
from django.contrib.auth.models import User
# Create your models here.
class Address(models.Model):
    HOME = 'Home'
    OFFICE = 'Office'
    OTHER = 'Other'
    ADDRESS_TYPE_CHOICES = (
        (HOME, 'Home'),
        (OFFICE, 'Office'),
        (OTHER, 'Other'),
    )

    # lattitude and longitude
    lat = models.FloatField()
    lng = models.FloatField()
    isDeafult = models.BooleanField(default=False)
    address = models.CharField(max_length=255, blank=False) 
    phone = models.CharField(max_length=15, blank=False)
    userID = models.ForeignKey(User, on_delete=models.CASCADE)

    addressType = models.CharField(choices=ADDRESS_TYPE_CHOICES, max_length=10, default=HOME)

    def __str__(self) -> str:
        return "{} - {}".format(self.userID.username, self.addressType, self.phone)


class Extras(models.Model):
    isVerified = models.BooleanField(default=False)
    otp = models.CharField(max_length=6, default='')
    userId = models.ForeignKey(User, on_delete=models.CASCADE)
    
    def __str__(self):
        return '{} - {}'.format(self.userId.username, self.isVerified)
    