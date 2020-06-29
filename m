Return-Path: <SRS0=+1Mh=AK=lists.cip-project.org=bounce+64572+4856+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9062C433E2
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 09:56:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB81A23750
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 09:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ZNIhDBPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB81A23750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4856+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TaFaYY4521723xhcKdtWZwdW; Mon, 29 Jun 2020 02:56:17 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.15187.1593424576060778096
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 02:56:16 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 05T9uEPd026924
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 11:56:14 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.4.33])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 05T9uBnx028120;
	Mon, 29 Jun 2020 11:56:13 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v2 5/5] swupdate: create swu file from wic image
Date: Mon, 29 Jun 2020 11:56:11 +0200
Message-Id: <20200629095611.3000-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200629095611.3000-1-Quirin.Gylstorff@siemens.com>
References: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
 <20200629095611.3000-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8e1uNJYw3ieYa2vC4uc4I3ifx4520388AA=
Content-Type: multipart/mixed; boundary="V4AOVIj2maJ5Yh82LvdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593424577;
 bh=vi3XzKo/1TzYD/r8WmjcgMHOXXBJC9mBshQy++CaEtU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZNIhDBPJ3csqVIfq7YYLSCAQYvEgTBZPe3XkInWLpR11JCsJ7sJ6cXj6AXqekeyjnxd
 HuIq+0QVh9MIvnPxqXa0TWh9mSCkYbAKu6tA/4et0GKxKDotdBAj7vvncy5LToQhRUgeZ
 iA2ywMRsoRU5cgfL1/iOQVKbFL5IXAMhNtY=

--V4AOVIj2maJ5Yh82LvdK
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Create a swu file for swupdate to update devices in the field.
This is done in the same step as the complete image build
to avoid diverging images.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/extract-partition.bbclass             | 26 +++++++++++++++++
 classes/wic-swu-img.bbclass                   | 20 +++++++++++++
 kas/opt/qemu-swupdate.yml                     | 19 ++++++++++++
 recipes-core/images/cip-core-image.bb         | 10 +++++++
 recipes-core/images/files/sw-description.tmpl | 29 +++++++++++++++++++
 5 files changed, 104 insertions(+)
 create mode 100644 classes/extract-partition.bbclass
 create mode 100644 classes/wic-swu-img.bbclass
 create mode 100644 kas/opt/qemu-swupdate.yml
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
diff --git a/kas/opt/qemu-swupdate.yml b/kas/opt/qemu-swupdate.yml
new file mode 100644
index 0000000..99b4547
--- /dev/null
+++ b/kas/opt/qemu-swupdate.yml
@@ -0,0 +1,19 @@
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
+header:
+  version: 8
+
+local_conf_header:
+  qemu-wic: |
+    IMAGE_TYPE ?= "wic-swu-img"
+    WKS_FILE = "qemu-amd64-${BOOTLOADER}.wks"
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 9ee4b25..4dfc983 100644
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
+TEMPLATE_VARS += "PN ROOTFS_PARTITION_NAME"
+
+SWU_ADDITIONAL_FILES += "linux.signed.efi ${ROOTFS_PARTITION_NAME}"
diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
new file mode 100644
index 0000000..bef1984
--- /dev/null
+++ b/recipes-core/images/files/sw-description.tmpl
@@ -0,0 +1,29 @@
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
+    name = "ebsy secure boot update"
+    images: ({
+            filename = "${EXTRACTED_PARTITION_NAME}";
+            device = "fedcba98-7654-3210-cafe-5e0710000001,fedcba98-7654-3210-cafe-5e0710000002";
+            type = "roundrobin";
+            compressed = true;
+            filesystem = "ext4";
+    });
+    files: ({
+            filename = "linux.signed.efi";
+            path = "linux.signed.efi";
+            type = "kernelfile";
+            device = "sda2,sda3";
+            filesystem = "vfat";
+    })
+}
-- 
2.20.1


--V4AOVIj2maJ5Yh82LvdK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4856): https://lists.cip-project.org/g/cip-dev/message=
/4856
Mute This Topic: https://lists.cip-project.org/mt/75188188/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--V4AOVIj2maJ5Yh82LvdK--
