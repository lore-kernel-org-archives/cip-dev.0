Return-Path: <SRS0=57BF=BD=lists.cip-project.org=bounce+64572+5001+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446FBC433EA
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:52:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166CA206D8
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jVhbZjpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166CA206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5001+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1TBFYY4521723x6pGAZgZHQc; Fri, 24 Jul 2020 07:52:31 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.7795.1595602349621708445
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2020 07:52:30 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 06OEqRTD025229
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2020 16:52:28 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.3.170])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06OEqPik031602;
	Fri, 24 Jul 2020 16:52:27 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v3 5/5] swupdate: create swu file from wic image
Date: Fri, 24 Jul 2020 16:52:25 +0200
Message-Id: <20200724145225.7895-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200724145225.7895-1-Quirin.Gylstorff@siemens.com>
References: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
 <20200724145225.7895-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Yq3vs1pI5WtYVF59IIAcEdMgx4520388AA=
Content-Type: multipart/mixed; boundary="EOFU6DAcwJmy1wytK1Wy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595602351;
 bh=A07IAaBH9tbjnn/i1dtp+yLK4NPwa2olsK/MrQmw2XE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jVhbZjppdaJpP2cbYbEAj/5QX29LfW+z+B8SlDHMzx85RrtL42SIFsWJH5XnaKm7i1g
 rYoVvrIr3ITDSI2h1j1kZTjjn0eTW6HS+aNW17nCMmme/h2fNp00prt97YZZTUcJZ9b1q
 K2Vw7I5KjwBCZ6wlVPjNp2gRXgCWWRoOG/4=

--EOFU6DAcwJmy1wytK1Wy
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Create a swu file for swupdate to update devices in the field.
This is done in the same step as the complete image build
to avoid diverging images.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/extract-partition.bbclass             | 26 +++++++++++++
 classes/wic-swu-img.bbclass                   | 20 ++++++++++
 kas/opt/ebg-swu.yml                           |  4 +-
 recipes-core/images/cip-core-image.bb         | 10 +++++
 recipes-core/images/files/sw-description.tmpl | 37 +++++++++++++++++++
 5 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 classes/extract-partition.bbclass
 create mode 100644 classes/wic-swu-img.bbclass
 create mode 100644 recipes-core/images/files/sw-description.tmpl

diff --git a/classes/extract-partition.bbclass b/classes/extract-partition.bbclass
new file mode 100644
index 0000000..e9de8fc
--- /dev/null
+++ b/classes/extract-partition.bbclass
@@ -0,0 +1,26 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+SOURCE_IMAGE_FILE ?= "${WIC_IMAGE_FILE}"
+EXTRACT_PARTITIONS ?= "img4"
+
+do_extract_partition () {
+    for PARTITION in ${EXTRACT_PARTITIONS}; do
+        rm -f ${DEPLOY_DIR_IMAGE}/${PARTITION}.gz
+        PART_START=$(fdisk -lu ${SOURCE_IMAGE_FILE} | grep ${PARTITION} | awk '{ print $2 }'  )
+        PART_END=$(fdisk -lu ${SOURCE_IMAGE_FILE} | grep ${PARTITION} | awk '{ print $3 }'  )
+        PART_COUNT=$(expr ${PART_END} - ${PART_START} + 1 )
+
+        dd if=${SOURCE_IMAGE_FILE} of=${DEPLOY_DIR_IMAGE}/${PARTITION} bs=512 skip=${PART_START} count=${PART_COUNT}
+
+        gzip ${DEPLOY_DIR_IMAGE}/${PARTITION}
+    done
+}
diff --git a/classes/wic-swu-img.bbclass b/classes/wic-swu-img.bbclass
new file mode 100644
index 0000000..c8532ba
--- /dev/null
+++ b/classes/wic-swu-img.bbclass
@@ -0,0 +1,20 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+
+inherit wic-img
+inherit extract-partition
+inherit swupdate-img
+
+SOURCE_IMAGE_FILE = "${WIC_IMAGE_FILE}"
+
+addtask do_extract_partition after do_wic_image
+addtask do_swupdate_image after do_extract_partition
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 5b39730..304fa4d 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -22,5 +22,5 @@ local_conf_header:
     WICVARS += "WDOG_TIMEOUT"
 
   wic: |
-    IMAGE_TYPE = "wic-img"
-    WKS_FILE = "${MACHINE}-${BOOTLOADER}.wks"
+    IMAGE_TYPE = "wic-swu-img"
+    WKS_FILE ?= "${MACHINE}-${BOOTLOADER}.wks"
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 9ee4b25..b1ed491 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -17,3 +17,13 @@ DESCRIPTION = "CIP Core image"
 IMAGE_INSTALL += "customizations"
 # for cip-testing
 IMAGE_INSTALL += "ltp-full"
+
+# for swupdate
+EXTRACT_PARTITIONS = "img4"
+ROOTFS_PARTITION_NAME="img4.gz"
+
+SRC_URI += "file://sw-description.tmpl"
+TEMPLATE_FILES += "sw-description.tmpl"
+TEMPLATE_VARS += "PN ROOTFS_PARTITION_NAME KERNEL_IMAGE INITRD_IMAGE"
+
+SWU_ADDITIONAL_FILES += "${INITRD_IMAGE} ${KERNEL_IMAGE} ${ROOTFS_PARTITION_NAME}"
diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
new file mode 100644
index 0000000..4d32f6f
--- /dev/null
+++ b/recipes-core/images/files/sw-description.tmpl
@@ -0,0 +1,37 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+software =
+{
+    version = "0.2";
+    name = "cip software update"
+    images: ({
+            filename = "${ROOTFS_PARTITION_NAME}";
+            device = "fedcba98-7654-3210-cafe-5e0710000001,fedcba98-7654-3210-cafe-5e0710000002";
+            type = "roundrobin";
+            compressed = true;
+            filesystem = "ext4";
+    });
+    files: ({
+            filename = "${KERNEL_IMAGE}";
+            path = "vmlinuz";
+            type = "kernelfile";
+            device = "sda2,sda3";
+            filesystem = "vfat";
+    },
+    {
+            filename = "${INITRD_IMAGE}";
+            path = "initrd.img";
+            type = "kernelfile";
+            device = "sda2,sda3";
+            filesystem = "vfat";
+    });
+}
+
-- 
2.20.1


--EOFU6DAcwJmy1wytK1Wy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5001): https://lists.cip-project.org/g/cip-dev/message=
/5001
Mute This Topic: https://lists.cip-project.org/mt/75767668/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--EOFU6DAcwJmy1wytK1Wy--
