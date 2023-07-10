from django.contrib import admin
from .models import Project, Building, Document, DocumentStatus

admin.site.register(Project)
admin.site.register(Building)
admin.site.register(DocumentStatus)

@admin.register(Document)
class DocumentAdmin(admin.ModelAdmin):
    list_display = ['code', 'name', 'developer', 'date_creation', 'date_update']
    list_filter = ['date_creation', 'date_update', 'status']
    search_fields = ['code', 'developer']
    raw_id_fields = ['developer']