From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 13 Jan 2020 13:46:03 +0100
Subject: [cip-dev] [isar-cip-core PATCH] ci: Adjust deploy-cip-core.sh to
 new kernel build
Message-ID: <d3acfab0-611e-c41d-e4fa-8897a973d7bb@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The path structure has changed, multiple times by now in fact.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/deploy-cip-core.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index e5c09ef..b8a1cd3 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -39,5 +39,5 @@ aws s3 cp --no-progress $KERNEL_IMAGE s3://download.cip-project.org/cip-core/$TA
 aws s3 cp --no-progress $BASE_PATH-initrd.img s3://download.cip-project.org/cip-core/$TARGET/
 
 if [ -n "$DTB" ]; then
-	aws s3 cp --no-progress build/tmp/work/cip-core-*/linux-cip-*/repack/linux-image/usr/lib/linux-image-*/$DTB s3://download.cip-project.org/cip-core/$TARGET/
+	aws s3 cp --no-progress build/tmp/work/cip-core-*/linux-cip/*/linux-cip-*/debian/linux-image-cip/usr/lib/linux-image-*/$DTB s3://download.cip-project.org/cip-core/$TARGET/
 fi
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
