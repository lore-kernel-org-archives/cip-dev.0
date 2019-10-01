From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:27 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 28/32] media: use strscpy() instead of
	strlcpy()
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-29-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

commit c0decac19da3906d9b66291e57b7759489e1170f upstream.

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[fab: cherry-picked changes for vsp1_drv.c only]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/media/platform/vsp1/vsp1_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index b6619c9..8c9d9d6 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -242,7 +242,7 @@ static int vsp1_create_entities(struct vsp1_device *vsp1)
 
 	mdev->dev = vsp1->dev;
 	mdev->hw_revision = vsp1->version;
-	strlcpy(mdev->model, vsp1->info->model, sizeof(mdev->model));
+	strscpy(mdev->model, vsp1->info->model, sizeof(mdev->model));
 	snprintf(mdev->bus_info, sizeof(mdev->bus_info), "platform:%s",
 		 dev_name(mdev->dev));
 	media_device_init(mdev);
-- 
2.7.4
