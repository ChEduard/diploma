from django.contrib import admin
from .models import ProcedureStatus, Procedure, Role, ProcedureStep, Comment, StepStatus

admin.site.register(ProcedureStatus)
admin.site.register(Procedure)
admin.site.register(Role)
admin.site.register(ProcedureStep)
admin.site.register(Comment)
admin.site.register(StepStatus)




