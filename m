From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed,  5 Jun 2019 15:30:14 +0900
Subject: [cip-dev] [ISAR] bmap: generate bmap for wic images
In-Reply-To: <20190605063014.18193-1-daniel.sangorrin@toshiba.co.jp>
References: <20190605063014.18193-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190605063014.18193-2-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

bmap shortens the time required to flash an image because
it skips areas with zeros.

Example usage:
sudo bmaptool copy --bmap \
build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img.bmap \
build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img \
/dev/sdf

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 meta/classes/wic-img.bbclass                            | 2 ++
 meta/recipes-devtools/buildchroot/buildchroot-target.bb | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/meta/classes/wic-img.bbclass b/meta/classes/wic-img.bbclass
index 09d9f2e..8fd2ff8 100644
--- a/meta/classes/wic-img.bbclass
+++ b/meta/classes/wic-img.bbclass
@@ -151,9 +151,11 @@ EOSUDO
         ${ISARROOT}/scripts/wic create ${WKS_FULL_PATH} \
             --vars "${STAGING_DIR}/${MACHINE}/imgdata/" \
             -o /tmp/${IMAGE_FULLNAME}.wic/ \
+            --bmap \
             -e ${IMAGE_BASENAME} ${WIC_CREATE_EXTRA_ARGS}
     sudo chown -R $(stat -c "%U" ${ISARROOT}) ${ISARROOT}/meta ${ISARROOT}/meta-isar ${ISARROOT}/scripts || true
     cp -f $(ls -t -1 ${BUILDCHROOT_DIR}/tmp/${IMAGE_FULLNAME}.wic/*.direct | head -1) ${WIC_IMAGE_FILE}
+    cp -f $(ls -t -1 ${BUILDCHROOT_DIR}/tmp/${IMAGE_FULLNAME}.wic/*.direct.bmap | head -1) ${WIC_IMAGE_FILE}.bmap
 }
 
 do_wic_image[file-checksums] += "${WKS_FILE_CHECKSUM}"
diff --git a/meta/recipes-devtools/buildchroot/buildchroot-target.bb b/meta/recipes-devtools/buildchroot/buildchroot-target.bb
index ce6bd93..15b4be0 100644
--- a/meta/recipes-devtools/buildchroot/buildchroot-target.bb
+++ b/meta/recipes-devtools/buildchroot/buildchroot-target.bb
@@ -19,6 +19,7 @@ BUILDCHROOT_PREINSTALL ?= "gcc \
                            automake \
                            devscripts \
                            equivs \
-                           adduser"
+                           adduser \
+                           bmap-tools"
 
 do_build[depends] = "isar-apt:do_cache_config isar-bootstrap-target:do_bootstrap"
-- 
2.17.1
