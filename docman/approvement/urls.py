from django.urls import path
from . import views

app_name = 'approvement'

urlpatterns = [
    path('create/<str:code>/', views.open_procedure_creation_form, name='open_procedure_creation_form'),
    path('create/<str:code>/started/', views.start_procedure, name='start_procedure'),
    path('<str:code>/procedure/<int:id>/', views.procedure_detail, name='procedure_detail'),
    path('<str:code>/procedure/<int:id>/deleted/', views.delete_procedure, name='delete_procedure'),
    path('<str:code>/procedure/<int:id>/comments/<int:step_id>/', views.show_comments, name='show_comments'),
    path('<str:code>/procedure/<int:id>/comments/<int:step_id>/accepted/', views.accept_procedure_step, name='accept_procedure_step'),
    path('<str:code>/procedure/<int:id>/comments/<int:step_id>/<int:comment_id>/', views.comment_response, name='comment_response'),
]
