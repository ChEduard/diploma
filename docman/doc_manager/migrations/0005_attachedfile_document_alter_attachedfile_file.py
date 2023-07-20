# Generated by Django 4.2.3 on 2023-07-16 20:28

from django.db import migrations, models
import django.db.models.deletion
import doc_manager.models


class Migration(migrations.Migration):

    dependencies = [
        ("doc_manager", "0004_attachedfile_alter_building_project_and_more"),
    ]

    operations = [
        migrations.AddField(
            model_name="attachedfile",
            name="document",
            field=models.ForeignKey(
                default=1,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="files",
                to="doc_manager.document",
            ),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name="attachedfile",
            name="file",
            field=models.FileField(
                max_length=250,
                upload_to=doc_manager.models.AttachedFile.get_attached_file_path,
            ),
        ),
    ]
