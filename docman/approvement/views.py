from django.shortcuts import render, get_object_or_404
from django.contrib.auth.models import User
from doc_manager.models import Project, Document, AttachedFile, DocumentStatus
from doc_manager.views import document_detail
from .models import Role, Procedure, ProcedureStatus, ProcedureStep, StepStatus, Comment


def open_procedure_creation_form(request, code):
    document = get_object_or_404(Document, code=code)
    users = User.objects.exclude(username='admin').order_by('last_name')
    roles = Role.objects.order_by('priority')
    return render(request,
                  'approvement/procedure_creation_form.html',
                  {'projects': Project.objects.all(), 'document': document, 'roles': roles, 'users':users})

def start_procedure(request, code):
    current_document = get_object_or_404(Document, code=code)
    users = User.objects.exclude(username='admin').order_by('last_name')
    roles = Role.objects.order_by('priority')
    procedure = Procedure(document=current_document, status=ProcedureStatus.objects.get(slug='approvement'))
    procedure.save()
    current_document.status = DocumentStatus.objects.get(name='На согласовании')
    current_document.save()

    procedure_users = request.POST
    for role in roles:
        step_user = get_object_or_404(User, id=procedure_users[role.slug]) #Определение выбранного пользователя по его роли из QueryDict по ключу role.slug
        procedure_step = ProcedureStep(procedure=procedure, user=step_user, role=role)
        procedure_step.save()

    return document_detail(request, current_document.id)

def procedure_detail(request, code, id):
    procedure = Procedure.objects.get(id=id)
    document = Document.objects.get(code=code)
    procedure_steps = ProcedureStep.objects.filter(procedure=procedure)
    #Создаётся список согласователей, чтобы только им были доступны функции "Выставить замечание" и "Согласовать"
    active_users = list(map(lambda step: step.user, procedure_steps))

    try:
        procedures = Procedure.objects.filter(document=document)
    except:
        procedures = ''

    try:
        files = AttachedFile.objects.filter(document=document)
    except: files = ''

    return render(request,
                  'approvement/procedure_detail.html',
                  {'projects': Project.objects.all(), 'document': document, 'files': files,
                   'procedures': procedures, 'procedure': procedure,'steps': procedure_steps, 'active_users': active_users})


def delete_procedure(request, code, id):
    current_procedure = Procedure.objects.get(id=id)
    current_procedure.delete()
    document = Document.objects.get(code=code)
    return document_detail(request, document.id)

def open_comment_form(request, code, id):
    procedure = Procedure.objects.get(id=id)
    document = Document.objects.get(code=code)
    procedure_steps = ProcedureStep.objects.filter(procedure=procedure)
    pass

def show_comments(request, code, id, step_id):
    step = ProcedureStep.objects.get(id=step_id)
    if request.method == 'POST':
        comment = Comment(procedure_step=ProcedureStep.objects.get(id=step_id),
                          comment_text=request.POST.get('comment_text'),
                          comment_author=request.user)
        comment.save()
        step.status = StepStatus.objects.get(name='Получены замечания')
        step.save()

    return render(request,
                  'approvement/procedure_comments.html',
                  {'projects': Project.objects.all(),
                   'document': Document.objects.get(code=code),
                   'procedure': Procedure.objects.get(id=id),
                   'step': step,
                   'comments': Comment.objects.filter(procedure_step=step)})

def comment_response(request, code, id, step_id, comment_id):
    step = ProcedureStep.objects.get(id=step_id)
    comment = Comment.objects.get(id=comment_id)
    comments = Comment.objects.filter(procedure_step=step)

    if request.method == 'POST':
        comment.response_text = request.POST.get('response_text')
        comment.response_author = request.user
        comment.save()
    elif request.method == 'GET':
        comment.is_corrected = True
        comment.save()
        all_comments_corrected = True
        for each_comment in comments:
            if each_comment.is_corrected == False:
                all_comments_corrected = False
        if all_comments_corrected:
            step.status = StepStatus.objects.get(name='Замечания исправлены')
            step.save()
    return render(request,
                  'approvement/procedure_comments.html',
                  {'projects': Project.objects.all(),
                   'document': Document.objects.get(code=code),
                   'procedure': Procedure.objects.get(id=id),
                   'step': step,
                   'comments': comments})

def accept_procedure_step(request, code, id, step_id):
    procedure = Procedure.objects.get(id=id)
    document = Document.objects.get(code=code)
    step = ProcedureStep.objects.get(id=step_id)
    step.status = StepStatus.objects.get(name='Согласовано')
    step.save()
    all_steps_accepted = True
    for each_step in ProcedureStep.objects.filter(procedure=procedure):
        if each_step.status.name != 'Согласовано':
            all_steps_accepted = False
    if all_steps_accepted:
        procedure.status = ProcedureStatus.objects.get(name='Согласовано')
        document.status = DocumentStatus.objects.get(name='Согласован')
        procedure.save()
        document.save()
    return procedure_detail(request, code, id)



