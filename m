Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4099C021A1
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 08:51:38 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.7771.1739263889339041016
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Feb 2025 00:51:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=RuAZYOpl;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202502110851271b0200be61c0eb4e0e-jyjlne@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202502110851271b0200be61c0eb4e0e
        for <cip-dev@lists.cip-project.org>;
        Tue, 11 Feb 2025 09:51:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=l0wpBrT4+8mTFHg21fCgJ1/xfdiCQxMA953gsnz7B84=;
 b=RuAZYOpllhPWc61Yndp3VdaEPK38Fksy8k3waQwEn7ZCGyBCOMcpO3n5nm0tZ5IwcdtaNt
 q+HhFXFY/93RDwDknrnQfqtBOjEOoxpsHKECI8JIaeT3JQJ78WwbTe0ZWTyD4Rb3HcuRff9F
 l60QR3rB5sDwf41QV7etvzSnfAUFr45nGNOs+9HpRgErCUkQouIg/qJ6lEtptoilZQ9Pxu3O
 +MWsW57eJt8lISBMlnNlQ+fsZXRxF8nrdPXXgcl3/YhaGglsto1l0BueUs/zk/OUxDFQmAI/
 gpcsr3NVYDssqEPi12cVFPeFI7Y3Bha95LN0hMmWEx3sN4Pi9Gw4uU7w==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	ludwig.nussel@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 4/4] Move content of home to IMMUTABLE_DATA_DIR
Date: Tue, 11 Feb 2025 09:49:11 +0100
Message-ID: <20250211085125.22154-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
References: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 08:51:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17807

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This reduces the amount of necessary partitions. It also
allows to use a A/B-update scheme for the var partition.

This fixes issue #123.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/123
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/read-only-rootfs.bbclass | 11 +++++++++++
 kas/opt/home-to-var.yml          | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 kas/opt/home-to-var.yml

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 99a2909..c809187 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -17,6 +17,10 @@ do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
 IMAGE_INSTALL += "home-fs"
 HOME_PARTITION_CMD = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002"
 
+HOME_PARTITION_CMD:home-to-var = ""
+IMAGE_INSTALL:remove:home-to-var = " home-fs"
+IMAGE_INSTALL:append:home-to-var = " move-homedir-var"
+
 IMAGE_INSTALL:append:buster   = " tmp-fs"
 IMAGE_INSTALL:append:bullseye = " tmp-fs"
 IMAGE_INSTALL:append:bookworm = " tmp-fs"
@@ -37,6 +41,13 @@ copy_dpkg_state() {
     sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
 }
 
+ROOTFS_POSTPROCESS_COMMAND:append:home-to-var =" copy_home_to_immutable_data"
+copy_home_to_immutable_data() {
+    IMMUTABLE_HOME_DIR="${ROOTFSDIR}/${IMMUTABLE_DATA_DIR}/"
+    sudo mkdir -p "$IMMUTABLE_HOME_DIR"
+    sudo cp -a ${ROOTFSDIR}/var/home "$IMMUTABLE_HOME_DIR/"
+}
+
 RO_ROOTFS_EXCLUDE_DIRS ??= ""
 EROFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
 SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
diff --git a/kas/opt/home-to-var.yml b/kas/opt/home-to-var.yml
new file mode 100644
index 0000000..c40b4cd
--- /dev/null
+++ b/kas/opt/home-to-var.yml
@@ -0,0 +1,21 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
+# from the first wic partition
+
+header:
+  version: 14
+
+local_conf_header:
+  move-home-to-var: |
+    OVERRIDES .= ":home-to-var"
+  remove-home-from-crypt: |
+    CRYPT_PARTITIONS:remove:home-to-var = "home:/home:reencrypt"
-- 
2.47.0


