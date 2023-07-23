from django.shortcuts import render, get_object_or_404
from django.db.models import Q
from django.contrib.auth.models import User
from django.core.files.storage import default_storage
from .models import Document, Project, Building, AttachedFile, DocumentStatus
from .forms import UploadFileForm
from approvement.models import Procedure
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse





@login_required
def project_list(request):
    projects = Project.objects.all()
    return render(request,
                  'doc_manager/main_page.html',
                  {'projects': projects})

@login_required
def document_list(request):
    documents = Document.objects.all()
    return render(request,
                  'doc_manager/doc_list.html',
                  {'documents': documents, 'projects': Project.objects.all()})

@login_required
def document_detail(request, id):
    document = get_object_or_404(Document,
                                 id=id,)
    try:
        procedures = Procedure.objects.filter(document=document)
    except:
        procedures = ''
    try:
        files = AttachedFile.objects.filter(document=id)
    except: files = ''
    return render(request,
                  'doc_manager/doc_detail.html',
                  {'projects': Project.objects.all(), 'document': document,
                   'files': files, 'procedures': procedures})

@login_required
def find_documents(request):
    search_query = request.GET.get('search', '')
    if search_query:
        documents = Document.objects.filter(code__icontains=search_query)
    else:
        documents = Document.objects.all()

    print(search_query)
    print(documents)
    return render(request,
                  'doc_manager/doc_list_search.html',
                  {'documents': documents, 'projects': Project.objects.all()})

@login_required
def document_by_project(request, code):
    project = Project.objects.get(code=code)
    documents = Document.objects.raw(f"SELECT * FROM docman.doc_manager_document AS doc \
                                    INNER JOIN docman.doc_manager_building AS build ON (doc.building_id = build.id) \
                                    INNER JOIN docman.doc_manager_project AS proj ON (build.project_id=proj.id) \
                                    WHERE proj.id = {project.id}")
    return render(request,
                  'doc_manager/doc_list.html',
                  {'documents': documents, 'projects': Project.objects.all(), 'project': project})

@login_required
def create_new_document(request, code):
    project = Project.objects.get(code=code)
    return render(request,
                  'doc_manager/doc_create.html',
                  {'projects': Project.objects.all(), 'project': project,
                   'buildings': Building.objects.filter(project=project), 'users': User.objects.exclude(username="admin")})
@login_required
def save_new_document(request):
    code = request.POST['code']
    name = request.POST['name']
    building = request.POST['building']
    developer = request.user.id
    new_document = Document(code=code, name=name, building=Building.objects.get(id=building), developer=User.objects.get(id=developer))
    new_document.save()

    try:
        procedures = Procedure.objects.filter(document=document)
    except:
        procedures = ''
    try:
        files = AttachedFile.objects.filter(document=id)
    except:
        files = ''
    return render(request,
                  'doc_manager/doc_detail.html',
                  {'projects': Project.objects.all(), 'document': new_document, 'files': files, 'procedures': procedures})

@login_required
def add_file_to_document(request, id):
    document = get_object_or_404(Document,
                                 id=id, )
    if request.method == 'POST':
        form = UploadFileForm(request.POST, request.FILES)
        file = request.FILES['file']
        print(request)
        print(type(file))
        print(file)
        print(file.file)

        newfile = AttachedFile.objects.create(document=document, file=file)
        newfile.save()
        if document.status.name == 'Создан':
            document.status = DocumentStatus.objects.get(name='Разработан')
            document.save()

        return document_detail(request, id)
    elif request.method == 'GET':
        return document_detail(request, id)

@login_required
def show_all_files(request):
    all_files = AttachedFile.objects.all()
    return render(request,
                  'doc_manager/all_files.html',
                  {'all_files': all_files, 'projects': Project.objects.all()})

@login_required
def open_file(request, id):
    file = AttachedFile.objects.get(id=id)
    ################################################################################################################
    MEDIA_ROOT = 'E:\PythonProject\docmandata'
    return render(request,
                  'doc_manager/file_view.html',
                  {'file': file, 'projects': Project.objects.all()})




