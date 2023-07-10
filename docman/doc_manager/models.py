from django.db import models
from django.contrib.auth.models import User


class Project(models.Model):
    name_short = models.CharField(max_length=45)
    name_full = models.CharField(max_length=120)
    country = models.CharField(max_length=120)
    code = models.CharField(max_length=5, blank=True, null=True)

    def __str__(self):
        return self.name_short

    class Meta:
        ordering = ['name_short']

class Building(models.Model):
    code = models.CharField(max_length=5)
    name = models.CharField(max_length=45)
    project = models.ForeignKey(Project,
                                on_delete=models.DO_NOTHING)

    def __str__(self):
        return self.code

    class Meta:
        ordering = ['code']

class DocumentStatus(models.Model):
    name = models.CharField(max_length=45)

    def __str__(self):
        return self.name

class Document(models.Model):
    code = models.CharField(max_length=45)
    name = models.CharField(max_length=255)
    date_creation = models.DateTimeField(auto_now_add=True)
    date_update = models.DateTimeField(auto_now=True, blank=True, null=True)
    status = models.ForeignKey(DocumentStatus,
                               on_delete=models.DO_NOTHING)
    building = models.ForeignKey(Building,
                                 on_delete=models.DO_NOTHING)
    developer = models.ForeignKey(User,
                                  on_delete=models.DO_NOTHING,
                                  related_name='developed_documents')

    def __str__(self):
        return self.code


