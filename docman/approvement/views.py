from django.shortcuts import render, get_object_or_404
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from doc_manager.models import Project, Document, AttachedFile, DocumentStatus
from doc_manager.views import document_detail
from .models import Role, Procedure, ProcedureStatus, ProcedureStep, StepStatus, Comment


@login_required
def open_procedure_creation_form(request, code):
    '''
    Открытие формы создания процедуры согласования
    Переменные: code - уникальный код документа
    '''
    document = get_object_or_404(Document, code=code)
    users = User.objects.exclude(username='admin').order_by('last_name')
    roles = Role.objects.order_by('priority')
    return render(request,
                  'approvement/procedure_creation_form.html',
                  {'projects': Project.objects.all(), 'document': document, 'roles': roles, 'users':users})

@login_required
def start_procedure(request, code):
    '''
    Присвоение документу новой процедуры согласования. Перевод документа в статус "На согласовании"
    Переменные: code - уникальный код документа
    '''
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

@login_required
def procedure_detail(request, code, id):
    '''
    Открытие деталей процедуры согласования (просмотр шагов процедуры)
    Переменные: code - уникальный код документа
                id - id процедуры согласования
    '''
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

@login_required
def delete_procedure(request, code, id):
    '''
    Удаление процедуры согласования
    Переменные: code - уникальный код документа
                id - id процедуры согласования
    '''
    current_procedure = Procedure.objects.get(id=id)
    current_procedure.delete()
    document = Document.objects.get(code=code)
    return document_detail(request, document.id)


@login_required
def show_comments(request, code, id, step_id):
    '''
    Открытие списка замечаний. Если метод POST - добавление нового замечания.
    Переменные: code - уникальный код документа
                id - id процедуры согласования
                step_id - id шага процедуры согласования
    '''
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

@login_required
def comment_response(request, code, id, step_id, comment_id):
    '''
    Ответ на замечания.
    Переменные: code - уникальный код документа
                id - id процедуры согласования
                step_id - id шага процедуры согласования
                comment_id - id замечания
    '''
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

@login_required
def accept_procedure_step(request, code, id, step_id):
    '''
    Согласование шага процедуры. Статус шага меняется на "Согласовано". Если все шаги имеют статус "Согласовано", документ приобретает статус "Согласован"
    Переменные: code - уникальный код документа
                id - id процедуры согласования
                step_id - id шага процедуры согласования
    '''
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



