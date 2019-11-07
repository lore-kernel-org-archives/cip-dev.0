From: Quirin.Gylstorff@siemens.com (Q. Gylstorff)
Date: Thu,  7 Nov 2019 17:39:40 +0100
Subject: [cip-dev] [isar-cip-core PATCH v2 2/4] classes: add
	wic-targz-img.bbclass
In-Reply-To: <TYAPR01MB2285BB4C180DBB805DC1C079B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285BB4C180DBB805DC1C079B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20191107163942.23513-3-Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The Linaro Automated Validation Architecture (LAVA) uses tarballs
as root file-systems to modify the file-system during the deployment.
Add a new bbclass to build tarballs and wic images at the same time to
feed the build output of isar-cip-core directly into LAVA tests.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/wic-targz-img.bbclass     | 13 +++++++++++++
 conf/machine/bbb.conf             |  2 +-
 conf/machine/iwg20m.conf          |  2 +-
 conf/machine/qemu-amd64.conf      |  2 +-
 conf/machine/simatic-ipc227e.conf |  2 +-
 opt-targz-img.yml                 | 20 ++++++++++++++++++++
 scripts/deploy-cip-core.sh        |  4 ++++
 7 files changed, 41 insertions(+), 4 deletions(-)
 create mode 100644 classes/wic-targz-img.bbclass
 create mode 100644 opt-targz-img.yml

diff --git a/classes/wic-targz-img.bbclass b/classes/wic-targz-img.bbclass
new file mode 100644
index 0000000..4e9f89d
--- /dev/null
+++ b/classes/wic-targz-img.bbclass
@@ -0,0 +1,13 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit wic-img
+inherit targz-img
diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index c945aac..a9b460e 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -8,7 +8,7 @@
 
 DISTRO_ARCH = "armhf"
 
-IMAGE_TYPE = "wic-img"
+IMAGE_TYPE ?= "wic-img"
 IMAGER_INSTALL += "u-boot-omap"
 
 # On stretch, select U-Boot from buster which comes with distro-boot support
diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index 2f91771..6c1a227 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -8,7 +8,7 @@
 DISTRO_ARCH = "armhf"
 
 # see wic/iwg20m.wks
-IMAGE_TYPE = "wic-img"
+IMAGE_TYPE ?= "wic-img"
 
 # sets serial login getty
 MACHINE_SERIAL = "ttySC0"
diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index 90325d6..7cbd55b 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -8,4 +8,4 @@
 
 DISTRO_ARCH = "amd64"
 
-IMAGE_TYPE = "ext4-img"
+IMAGE_TYPE ?= "ext4-img"
diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
index 73dac33..473e6c5 100644
--- a/conf/machine/simatic-ipc227e.conf
+++ b/conf/machine/simatic-ipc227e.conf
@@ -8,5 +8,5 @@
 
 DISTRO_ARCH = "amd64"
 
-IMAGE_TYPE = "wic-img"
+IMAGE_TYPE ?= "wic-img"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
diff --git a/opt-targz-img.yml b/opt-targz-img.yml
new file mode 100644
index 0000000..1a73024
--- /dev/null
+++ b/opt-targz-img.yml
@@ -0,0 +1,20 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+# lava uses nfs to deploy the image. For this we need a tarball instead of
+# full image
+
+local_conf_header:
+  image-type: |
+    IMAGE_TYPE = "wic-targz-img"
diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 081dc9d..e5c09ef 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -26,6 +26,10 @@ xz -9 -k $BASE_PATH.wic.img
 echo "Uploading artifacts..."
 aws s3 cp --no-progress $BASE_PATH.wic.img.xz s3://download.cip-project.org/cip-core/$TARGET/
 
+if [ -f $BASE_PATH.tar.gz ]; then
+    aws s3 cp --no-progress $BASE_PATH.tar.gz s3://download.cip-project.org/cip-core/$TARGET/
+fi
+
 KERNEL_IMAGE=$BASE_PATH-vmlinuz
 # iwg20m workaround
 if [ -f build/tmp/deploy/images/$TARGET/zImage ]; then
-- 
2.20.1
