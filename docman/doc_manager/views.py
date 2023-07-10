from django.shortcuts import render, get_object_or_404
from .models import Document, Project


def project_list(request):
    projects = Project.objects.all()
    return render(request,
                  'doc_manager/project_list.html',
                  {'projects': projects})

def document_list(request):
    documents = Document.objects.all()
    return render(request,
                  'doc_manager/doc_list.html',
                  {'documents': documents})

def document_detail(request, id):
    document = get_object_or_404(Document,
                                 id=id,)
    return render(request,
                  'doc_manager/doc_detail.html',
                  {'document': document})

def find_documents(request):
    search_query = request.GET.get('search', '')
    if search_query:
        documents = Document.objects.filter(code__icontains=search_query)
    else:
        documents = Document.objects.all()

    print(search_query)
    print(documents)
    return render(request,
                  'doc_manager/doc_list.html',
                  {'documents': documents})


def document_by_project(request, code):
    print('*'*50)
    print(request)

    project = Project.objects.get(code=code)
    print(project)
    print(project.code)
    documents = Document.objects.filter(code__icontains='02')
    return render(request,
                  'doc_manager/doc_list.html',
                  {'documents': documents})
