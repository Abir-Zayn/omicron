from django.contrib import admin
from .models import Address
from .models import Extras

# Register your models here.
admin.site.register(Address)
admin.site.register(Extras)