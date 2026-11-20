from django.db import models


class SitePage(models.Model):
    STATUS_CHOICES = [
        ("published", "公開"),
        ("coming_soon", "準備中"),
        ("maintenance", "メンテナンス中"),
    ]

    PAGE_CHOICES = [
        ("about", "ABOUT"),
        ("projects", "PROJECTS"),
        ("activities", "ACTIVITIES"),
        ("blog", "BLOG"),
    ]

    page = models.CharField(
        "ページ",
        max_length=20,
        choices=PAGE_CHOICES,
        unique=True,
    )

    status = models.CharField(
        "公開状態",
        max_length=20,
        choices=STATUS_CHOICES,
        default="published",
    )

    updated_at = models.DateTimeField("更新日時", auto_now=True)

    def __str__(self):
        return self.get_page_display()

    class Meta:
        verbose_name = "ページ設定"
        verbose_name_plural = "ページ設定"
