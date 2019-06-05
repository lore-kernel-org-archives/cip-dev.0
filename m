From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed,  5 Jun 2019 17:14:28 +0900
Subject: [cip-dev] [PATCH v3] bmap: generate bmap for wic images
Message-ID: <20190605081428.7596-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

bmap shortens the time required to flash an image.
This can be useful when you need a fixed-size image, for
example to update partitions with swupdate.

Example usage:
sudo bmaptool copy --bmap \
build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img.bmap \
build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img \
/dev/sdf

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 meta/classes/wic-img.bbclass        | 5 ++++-
 meta/conf/distro/debian-common.conf | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/meta/classes/wic-img.bbclass b/meta/classes/wic-img.bbclass
index 86a918d..94f0b02 100644
--- a/meta/classes/wic-img.bbclass
+++ b/meta/classes/wic-img.bbclass
@@ -147,9 +147,12 @@ EOSUDO
         ${ISARROOT}/scripts/wic create ${WKS_FULL_PATH} \
             --vars "${STAGING_DIR}/${MACHINE}/imgdata/" \
             -o /tmp/${IMAGE_FULLNAME}.wic/ \
+            --bmap \
             -e ${IMAGE_BASENAME} ${WIC_CREATE_EXTRA_ARGS}
     sudo chown -R $(stat -c "%U" ${ISARROOT}) ${ISARROOT}/meta ${ISARROOT}/meta-isar ${ISARROOT}/scripts || true
-    cp -f $(ls -t -1 ${BUILDCHROOT_DIR}/tmp/${IMAGE_FULLNAME}.wic/*.direct | head -1) ${WIC_IMAGE_FILE}
+    WIC_DIRECT=$(ls -t -1 ${BUILDCHROOT_DIR}/tmp/${IMAGE_FULLNAME}.wic/*.direct | head -1)
+    cp -f ${WIC_DIRECT} ${WIC_IMAGE_FILE}
+    cp -f ${WIC_DIRECT}.bmap ${WIC_IMAGE_FILE}.bmap
 }
 
 do_wic_image[file-checksums] += "${WKS_FILE_CHECKSUM}"
diff --git a/meta/conf/distro/debian-common.conf b/meta/conf/distro/debian-common.conf
index 5a47483..b845c73 100644
--- a/meta/conf/distro/debian-common.conf
+++ b/meta/conf/distro/debian-common.conf
@@ -11,7 +11,8 @@ WIC_IMAGER_INSTALL = "parted \
                       dosfstools \
                       mtools \
                       e2fsprogs \
-                      python3"
+                      python3 \
+                      bmap-tools"
 
 GRUB_BOOTLOADER_INSTALL_amd64 = "grub-efi-amd64-bin"
 GRUB_BOOTLOADER_INSTALL_i386 = "grub-efi-ia32-bin"
-- 
2.17.1
