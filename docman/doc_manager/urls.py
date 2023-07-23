from django.urls import path
from . import views

app_name = 'doc_manager'

urlpatterns = [
    path('', views.project_list, name='project_list'),
    path('projects/<str:code>/', views.document_by_project, name='document_by_project'),
    path('search/', views.find_documents, name='find_documents'),
    path('documents/', views.document_list, name='document_list'),
    path('projects/<str:code>/documents/new/', views.create_new_document, name='document_create'),
    path('documents/new/save/', views.save_new_document, name='document_new_save'),
    path('documents/<int:id>/', views.document_detail, name='document_detail'),
    path('documents/<int:id>/add_file/', views.add_file_to_document, name='add_file_to_document'),
    path('documents/files/', views.show_all_files, name='show_all_files'),
    path('documents/files/<int:id>/', views.open_file, name='open_file'),
]
