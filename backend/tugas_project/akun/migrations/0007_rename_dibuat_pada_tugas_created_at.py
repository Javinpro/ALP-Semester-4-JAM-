# Generated by Django 5.2 on 2025-05-15 17:12

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('akun', '0006_tugas_selesai'),
    ]

    operations = [
        migrations.RenameField(
            model_name='tugas',
            old_name='dibuat_pada',
            new_name='created_at',
        ),
    ]
