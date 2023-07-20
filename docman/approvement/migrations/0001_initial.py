# Generated by Django 4.2.3 on 2023-07-19 20:12

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ("doc_manager", "0005_attachedfile_document_alter_attachedfile_file"),
    ]

    operations = [
        migrations.CreateModel(
            name="Procedure",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("date_creation", models.DateTimeField(auto_now_add=True)),
                ("date_update", models.DateTimeField(auto_now=True, null=True)),
                (
                    "document",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="procedure",
                        to="doc_manager.document",
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="ProcedureStatus",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=250)),
            ],
        ),
        migrations.CreateModel(
            name="Role",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=250)),
                ("priority", models.PositiveSmallIntegerField()),
            ],
        ),
        migrations.CreateModel(
            name="ProcedureStep",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("is_approved", models.BooleanField()),
                ("date_creation", models.DateTimeField(auto_now_add=True)),
                ("date_update", models.DateTimeField(auto_now=True, null=True)),
                (
                    "procedure",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="step",
                        to="approvement.procedure",
                    ),
                ),
                (
                    "role",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="approvement.role",
                    ),
                ),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
            ],
        ),
        migrations.AddField(
            model_name="procedure",
            name="status",
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.DO_NOTHING,
                to="approvement.procedurestatus",
            ),
        ),
        migrations.CreateModel(
            name="Comment",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("comment_text", models.CharField(max_length=1000)),
                ("response_text", models.CharField(max_length=1000)),
                ("is_corrected", models.BooleanField()),
                ("date_creation", models.DateTimeField(auto_now_add=True)),
                ("date_update", models.DateTimeField(auto_now=True, null=True)),
                (
                    "comment_author",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        related_name="given_comment",
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
                (
                    "procedure_step",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="comment",
                        to="approvement.procedurestep",
                    ),
                ),
                (
                    "response_author",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        related_name="given_response",
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
            ],
        ),
    ]
