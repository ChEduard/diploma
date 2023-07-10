from django.urls import path
from . import views

app_name = 'doc_manager'

urlpatterns = [
    path('', views.project_list, name='project_list'),
    path('projects/<str:code>/', views.document_by_project, name='document_by_project'),
    path('search/', views.find_documents, name='find_documents'),
    path('documents/', views.document_list, name='document_list'),
    path('documents/<int:id>/', views.document_detail, name='document_detail'),
    path('documents/?search=<int:id>/', views.document_detail, name='document_detail'),
]
