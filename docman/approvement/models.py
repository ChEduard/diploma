from django.db import models
from django.contrib.auth.models import User
from doc_manager.models import Document


class ProcedureStatus(models.Model):
    name = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250, null=True, unique=True)
    def __str__ (self):
        return self.name

class StepStatus(models.Model):
    name = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250, null=True, unique=True)
    def __str__ (self):
        return self.name

class Procedure(models.Model):
    document = models.ForeignKey(Document,
                                 on_delete=models.CASCADE,
                                 related_name='procedure')
    status = models.ForeignKey(ProcedureStatus,
                               on_delete=models.DO_NOTHING)
    date_creation = models.DateTimeField(auto_now_add=True)
    date_update = models.DateTimeField(auto_now=True, blank=True, null=True)

class Role(models.Model):
    name = models.CharField(max_length=250)
    priority = models.PositiveSmallIntegerField()
    slug = models.SlugField(max_length=250, null=True, unique=True)
    def __str__ (self):
        return self.name

class ProcedureStep(models.Model):
    procedure = models.ForeignKey(Procedure,
                                  on_delete=models.CASCADE,
                                  related_name='step')
    user = models.ForeignKey(User,
                             on_delete=models.DO_NOTHING)
    role = models.ForeignKey(Role,
                             on_delete=models.DO_NOTHING)
    status = models.ForeignKey(StepStatus,
                               default=1,
                               on_delete=models.DO_NOTHING,
                               related_name='step')
    date_creation = models.DateTimeField(auto_now_add=True)
    date_update = models.DateTimeField(auto_now=True, blank=True, null=True)


class Comment(models.Model):
    procedure_step = models.ForeignKey(ProcedureStep,
                                       on_delete=models.CASCADE,
                                       related_name='comment')
    comment_text = models.CharField(max_length=1000)
    response_text = models.CharField(max_length=1000, blank=True, null=True)
    comment_author = models.ForeignKey(User,
                                       on_delete=models.DO_NOTHING,
                                       related_name='given_comment')
    response_author = models.ForeignKey(User, blank=True, null=True,
                                       on_delete=models.DO_NOTHING,
                                       related_name='given_response')
    is_corrected = models.BooleanField(default=False)
    date_creation = models.DateTimeField(auto_now_add=True)
    date_update = models.DateTimeField(auto_now=True, blank=True, null=True)