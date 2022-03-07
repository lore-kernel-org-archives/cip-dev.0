Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23875C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 11:51:00 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.25259.1646653858096258486
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Mar 2022 03:50:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=QHKUGPeg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-51332-2022030711505497cc59336fad25414f-_8p0zd@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 2022030711505497cc59336fad25414f
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Mar 2022 12:50:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=zIQ/vW+Nfndv74e0qHZ3uFoZP2V6WCzIHyUys08agfs=;
 b=QHKUGPegvOzzjTSSexhDspT0XbYNU52MiX5kOvrcpvQabPTv4rYpbMsnMwHxB+gmXUQxwg
 Tyj2ohDXNQRZ2J2GonD2z+thgXfjEneJqhA5F8bqs7DzuRLiE5BX+qBJAjhozzWLak064h/+
 wZvXgS4KOcz8VqqikUAcuPI3kB6mM=;
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] classes: Use extracted partitions
 provided by wic
Date: Mon,  7 Mar 2022 12:50:53 +0100
Message-Id: <20220307115053.1972214-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Mar 2022 11:51:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7664

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Newer versions of the wic provide separated disk partitions
therefore, the extraction code is no longer necessary.

Rename the class from extract-partition to
compress-swupdate-rootfs to clarify the use case.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/compress_swupdate_rootfs.bbclass | 21 +++++++++++++++++++
 classes/extract-partition.bbclass        | 26 ------------------------
 classes/secure-swupdate-img.bbclass      |  6 +++---
 classes/wic-swu-img.bbclass              |  6 +++---
 recipes-core/images/secureboot.inc       |  4 ++--
 recipes-core/images/swupdate.inc         |  4 ++--
 6 files changed, 31 insertions(+), 36 deletions(-)
 create mode 100644 classes/compress_swupdate_rootfs.bbclass
 delete mode 100644 classes/extract-partition.bbclass

diff --git a/classes/compress_swupdate_rootfs.bbclass b/classes/compress_swupdate_rootfs.bbclass
new file mode 100644
index 0000000..2a01e59
--- /dev/null
+++ b/classes/compress_swupdate_rootfs.bbclass
@@ -0,0 +1,21 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+EXTRACT_PARTITIONS ?= "${IMAGE_FULLNAME}.wic.img.p4"
+
+do_compress_swupdate_rootfs () {
+    for PARTITION in ${EXTRACT_PARTITIONS}; do
+        if [ -e ${DEPLOY_DIR_IMAGE}/${PARTITION} ]; then
+            rm -f ${DEPLOY_DIR_IMAGE}/${PARTITION}.gz
+            gzip ${DEPLOY_DIR_IMAGE}/${PARTITION}
+        fi
+    done
+}
diff --git a/classes/extract-partition.bbclass b/classes/extract-partition.bbclass
deleted file mode 100644
index e9de8fc..0000000
--- a/classes/extract-partition.bbclass
+++ /dev/null
@@ -1,26 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-SOURCE_IMAGE_FILE ?= "${WIC_IMAGE_FILE}"
-EXTRACT_PARTITIONS ?= "img4"
-
-do_extract_partition () {
-    for PARTITION in ${EXTRACT_PARTITIONS}; do
-        rm -f ${DEPLOY_DIR_IMAGE}/${PARTITION}.gz
-        PART_START=$(fdisk -lu ${SOURCE_IMAGE_FILE} | grep ${PARTITION} | awk '{ print $2 }'  )
-        PART_END=$(fdisk -lu ${SOURCE_IMAGE_FILE} | grep ${PARTITION} | awk '{ print $3 }'  )
-        PART_COUNT=$(expr ${PART_END} - ${PART_START} + 1 )
-
-        dd if=${SOURCE_IMAGE_FILE} of=${DEPLOY_DIR_IMAGE}/${PARTITION} bs=512 skip=${PART_START} count=${PART_COUNT}
-
-        gzip ${DEPLOY_DIR_IMAGE}/${PARTITION}
-    done
-}
diff --git a/classes/secure-swupdate-img.bbclass b/classes/secure-swupdate-img.bbclass
index 431939b..1715c8a 100644
--- a/classes/secure-swupdate-img.bbclass
+++ b/classes/secure-swupdate-img.bbclass
@@ -21,12 +21,12 @@ INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
 
 inherit verity-img
 inherit wic-img
-inherit extract-partition
+inherit compress_swupdate_rootfs
 inherit swupdate-img
 
 SOURCE_IMAGE_FILE = "${WIC_IMAGE_FILE}"
 
 addtask do_verity_image after do_${SECURE_IMAGE_FSTYPE}_image
 addtask do_wic_image after do_verity_image
-addtask do_extract_partition after do_wic_image
-addtask do_swupdate_image after do_extract_partition
+addtask do_compress_swupdate_rootfs after do_wic_image
+addtask do_swupdate_image after do_compress_swupdate_rootfs
diff --git a/classes/wic-swu-img.bbclass b/classes/wic-swu-img.bbclass
index c8532ba..3a09721 100644
--- a/classes/wic-swu-img.bbclass
+++ b/classes/wic-swu-img.bbclass
@@ -11,10 +11,10 @@
 
 
 inherit wic-img
-inherit extract-partition
+inherit compress_swupdate_rootfs
 inherit swupdate-img
 
 SOURCE_IMAGE_FILE = "${WIC_IMAGE_FILE}"
 
-addtask do_extract_partition after do_wic_image
-addtask do_swupdate_image after do_extract_partition
+addtask do_compress_swupdate_rootfs after do_wic_image
+addtask do_swupdate_image after do_compress_swupdate_rootfs
diff --git a/recipes-core/images/secureboot.inc b/recipes-core/images/secureboot.inc
index f048497..b619b50 100644
--- a/recipes-core/images/secureboot.inc
+++ b/recipes-core/images/secureboot.inc
@@ -11,8 +11,8 @@
 
 FILESEXTRAPATHS_prepend := "${THISDIR}/files/secure-boot:"
 
-EXTRACT_PARTITIONS = "img4"
-ROOTFS_PARTITION_NAME="img4.gz"
+EXTRACT_PARTITIONS = "${IMAGE_FULLNAME}.wic.img.p4"
+ROOTFS_PARTITION_NAME="${IMAGE_FULLNAME}.wic.img.p4.gz"
 
 SRC_URI += "file://sw-description.tmpl"
 TEMPLATE_FILES += "sw-description.tmpl"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 06ad5af..2e9094a 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -11,8 +11,8 @@
 
 FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
 
-EXTRACT_PARTITIONS = "img4"
-ROOTFS_PARTITION_NAME="img4.gz"
+EXTRACT_PARTITIONS = "${IMAGE_FULLNAME}.wic.img.p4"
+ROOTFS_PARTITION_NAME="${IMAGE_FULLNAME}.wic.img.p4.gz"
 
 SRC_URI += "file://sw-description.tmpl"
 TEMPLATE_FILES += "sw-description.tmpl"
-- 
2.34.1


