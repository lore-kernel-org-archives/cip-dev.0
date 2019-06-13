From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 13 Jun 2019 14:51:38 +0900
Subject: [cip-dev] [isar-cip-core][next] bmap: apply bmap patch to isar
	until we upgrade
Message-ID: <20190613055138.6769-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

A similar bmap patch has been sent to ISAR upstream,
but while it gets accepted and until we update the ISAR
version, we can use this backport.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 0001-bmap-generate-bmap-for-wic-images.patch | 57 ++++++++++++++++++++
 kas.yml                                      |  4 ++
 2 files changed, 61 insertions(+)
 create mode 100644 0001-bmap-generate-bmap-for-wic-images.patch

diff --git a/0001-bmap-generate-bmap-for-wic-images.patch b/0001-bmap-generate-bmap-for-wic-images.patch
new file mode 100644
index 0000000..63ebe54
--- /dev/null
+++ b/0001-bmap-generate-bmap-for-wic-images.patch
@@ -0,0 +1,57 @@
+From 4bf7d60b4fb64ed0a7a131431cc6a2573e7178a4 Mon Sep 17 00:00:00 2001
+From: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
+Date: Thu, 13 Jun 2019 13:51:28 +0900
+Subject: [PATCH] bmap: generate bmap for wic images
+
+bmap shortens the time required to flash an image.
+This can be useful when you need a fixed-size image, for
+example to update partitions with swupdate.
+
+Example usage:
+sudo bmaptool copy --bmap \
+build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img.bmap \
+build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img \
+/dev/sdf
+
+Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
+---
+ meta/classes/wic-img.bbclass        | 5 ++++-
+ meta/conf/distro/debian-common.conf | 4 ++--
+ 2 files changed, 6 insertions(+), 3 deletions(-)
+
+diff --git a/meta/classes/wic-img.bbclass b/meta/classes/wic-img.bbclass
+index 09d9f2e..f227655 100644
+--- a/meta/classes/wic-img.bbclass
++++ b/meta/classes/wic-img.bbclass
+@@ -151,9 +151,12 @@ EOSUDO
+         ${ISARROOT}/scripts/wic create ${WKS_FULL_PATH} \
+             --vars "${STAGING_DIR}/${MACHINE}/imgdata/" \
+             -o /tmp/${IMAGE_FULLNAME}.wic/ \
++            --bmap \
+             -e ${IMAGE_BASENAME} ${WIC_CREATE_EXTRA_ARGS}
+     sudo chown -R $(stat -c "%U" ${ISARROOT}) ${ISARROOT}/meta ${ISARROOT}/meta-isar ${ISARROOT}/scripts || true
+-    cp -f $(ls -t -1 ${BUILDCHROOT_DIR}/tmp/${IMAGE_FULLNAME}.wic/*.direct | head -1) ${WIC_IMAGE_FILE}
++    WIC_DIRECT=$(ls -t -1 ${BUILDCHROOT_DIR}/tmp/${IMAGE_FULLNAME}.wic/*.direct | head -1)
++    cp -f ${WIC_DIRECT} ${WIC_IMAGE_FILE}
++    cp -f ${WIC_DIRECT}.bmap ${WIC_IMAGE_FILE}.bmap
+ }
+ 
+ do_wic_image[file-checksums] += "${WKS_FILE_CHECKSUM}"
+diff --git a/meta/conf/distro/debian-common.conf b/meta/conf/distro/debian-common.conf
+index 5a47483..c1e5d6b 100644
+--- a/meta/conf/distro/debian-common.conf
++++ b/meta/conf/distro/debian-common.conf
+@@ -10,8 +10,8 @@ WIC_IMAGER_INSTALL = "parted \
+                       util-linux \
+                       dosfstools \
+                       mtools \
+-                      e2fsprogs \
+-                      python3"
++                      python3 \
++                      bmap-tools"
+ 
+ GRUB_BOOTLOADER_INSTALL_amd64 = "grub-efi-amd64-bin"
+ GRUB_BOOTLOADER_INSTALL_i386 = "grub-efi-ia32-bin"
+-- 
+2.17.1
+
diff --git a/kas.yml b/kas.yml
index 21a776e..c726079 100644
--- a/kas.yml
+++ b/kas.yml
@@ -20,6 +20,10 @@ repos:
   isar:
     url: https://github.com/ilbers/isar
     refspec: 596732aa99c361b756655434bc90e0108e1caa33
+    patches:
+      bmap:
+        repo: cip-core
+        path: 0001-bmap-generate-bmap-for-wic-images.patch
     layers:
       meta:
 
-- 
2.17.1
