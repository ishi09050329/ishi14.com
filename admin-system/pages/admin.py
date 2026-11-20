from django.contrib import admin
from .models import SitePage


@admin.register(SitePage)
class SitePageAdmin(admin.ModelAdmin):
    list_display = ("page", "status", "updated_at")
    list_editable = ("status",)
    list_display_links = ("page",)
    ordering = ("page",)
