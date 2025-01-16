from django.contrib import admin 
from django.urls import path

from core import views 

urlpatterns = [
    path('/brands', views.BrandsList.as_view(), name = "brands-list"),
    path('/brands/home', views.HomeBrandsList.as_view(), name = "home-brands-list"),
    
    path('', views.ProductList.as_view(), name="product-list"),
    path('/popular', views.PopularProductsList.as_view(), name="popular-list"),

    path('/deals', views.ProductsListDeals.as_view(), name="deals-list"),

    path('/byType', views.ProductListByGender.as_view(), name="list-by-type"),
    
    path('/search', views.SearchProducts.as_view(), name="search"),
    path('/filter-by-brand/', views.FilterProductsByBrand.as_view(), name="filter-products-by-brand"),

    path('/recommended', views.SimilarProducts.as_view(), name="similar-products"),
    
]
