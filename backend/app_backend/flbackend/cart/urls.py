from django.urls import path
from . import views

urlpatterns = [
    path('me/', views.GetUserCart.as_view(), name='get_user_cart'),
    path('add/', views.AddItemToCart.as_view(), name='add_to_cart'),
    path('remove/', views.RemoveItemFromCart.as_view(), name='remove_from_cart'),
    path('update/', views.UpdateCartItemQuantity.as_view(), name='update_cart_item'),
    path('count/', views.CartCount.as_view(), name='get_cart_count'), 
]

