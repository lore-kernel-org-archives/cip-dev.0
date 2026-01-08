Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCD1D1D475
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 15:17:12 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8645.1767885424463689123
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 07:17:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=FMrao3tr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20260108151702184b8433ec000207f1-v88kpp@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260108151702184b8433ec000207f1
        for <cip-dev@lists.cip-project.org>;
        Thu, 08 Jan 2026 16:17:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Sw0xLB8QsrR2ywXMW9rYuaadCmCpUmtqloBeEp4dWec=;
 b=FMrao3tr8Ile7Rq8cUQllqdxC5P7RE/2g8wrQxvGox1WP4FzuMJk9N+S0TmLRkEka1eBV6
 vRZCPJi8mZpW7PDBGFa4ktFR30krLUoQ1CUC4mug1cTGVhNjj3xwm+XZHHeF2JGH8zdpA2AU
 CGrITY6Wt+2rUulegtxb1bRcHHunUmrOEto8EJe06X5PjgzzZddkIT4wFRALYzmFhUUiYNuL
 ys8VEtm4R6HDXdDnQqNuWNj2OQvuQSJlzDrvLhdfx8B4VCKLOi7BMmeCK/iGG4rU3NpCddPy
 srYb8FWT9j/kzbMGlsgh7svJkKs7oQSYGjPBuTnoEEQ0cfARhYiMkqAw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	benedikt.niedermayr@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 7/7] rename recipes-core/images/swupdate.inc to swupdate-ab-rootfs.inc
Date: Thu,  8 Jan 2026 16:16:14 +0100
Message-ID: <20260108151650.124306-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
References: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 15:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21488

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This clarifies the indented use. Use a include file as some
defaults are isar-cip-core specific.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.layer-integration.md            |  2 +-
 kas/opt/swupdate.yml                       |  2 +-
 recipes-core/images/swupdate-ab-rootfs.inc | 61 +++++++++++++++++++++
 recipes-core/images/swupdate.inc           | 62 +---------------------
 4 files changed, 64 insertions(+), 63 deletions(-)
 create mode 100644 recipes-core/images/swupdate-ab-rootfs.inc
 mode change 100644 => 120000 recipes-core/images/swupdate.inc

diff --git a/doc/README.layer-integration.md b/doc/README.layer-integration.md
index 1e1973c..5ba6259 100644
--- a/doc/README.layer-integration.md
+++ b/doc/README.layer-integration.md
@@ -19,7 +19,7 @@ with /etc as overlay. It also installs and configures efibootguard and SWUpdate.
 An additional image type is generated with contains the update artifacts.
 
 ```bitbake
-require recipes-core/images/swupdate.inc
+require recipes-core/images/swupdate-ab-rootfs.inc
 ```
 
 ## Create a image description
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index c5b7c61..3c3c93c 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -16,7 +16,7 @@ header:
 
 local_conf_header:
   image-option-swupdate: |
-    CIP_IMAGE_OPTIONS:append = " recipes-core/images/swupdate.inc"
+    CIP_IMAGE_OPTIONS:append = " recipes-core/images/swupdate-ab-rootfs.inc"
     OVERRIDES .= ":swupdate"
 
   wic-swu: |
diff --git a/recipes-core/images/swupdate-ab-rootfs.inc b/recipes-core/images/swupdate-ab-rootfs.inc
new file mode 100644
index 0000000..6858a31
--- /dev/null
+++ b/recipes-core/images/swupdate-ab-rootfs.inc
@@ -0,0 +1,61 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023-2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit image_uuid
+inherit read-only-rootfs
+
+SWUPDATE_BOOTLOADER ??= "efibootguard"
+python __anonymous() {
+    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
+    if not bootloader in ["efibootguard"]:
+        bb.error("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
+}
+
+include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
+
+IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
+IMAGE_FSTYPES:append = " swu"
+# input is already compressed
+SWU_COMPRESSION_TYPE = ""
+
+# read-only rootfs with /home and /var
+# as separate partitions is used
+# /boot is excluded as an unified kernel image
+# is used. This images are stored in separate partitions.
+RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
+
+SWU_SIGNED ?= "1"
+SWU_HW_COMPAT ?= "cip-core-1.0"
+IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+
+SWUPDATE_SELFBUILT ?= "0"
+SWUPDATE_SELFBUILT:buster = "1"
+SWUPDATE_SELFBUILT:bullseye = "1"
+SWUPDATE_SELFBUILT:bookworm = "1"
+
+python() {
+    base_distro = d.getVar('BASE_DISTRO_CODENAME')
+    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
+       bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
+        bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
+
+    if not bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) and \
+       not bb.utils.to_boolean(d.getVar('SWU_SIGNED')):
+        bb.fatal('SWUpdate from Debian requires signed SWUs')
+}
+
+IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
+IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
+
+IMAGE_INSTALL += " swupdate-handler-roundrobin"
+IMAGE_INSTALL += " swupdate-config"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
deleted file mode 100644
index 7cd816a..0000000
--- a/recipes-core/images/swupdate.inc
+++ /dev/null
@@ -1,61 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2023-2026
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit image_uuid
-inherit read-only-rootfs
-
-SWUPDATE_BOOTLOADER ??= "efibootguard"
-python __anonymous() {
-    bootloader = d.getVar("SWUPDATE_BOOTLOADER")
-    if not bootloader in ["efibootguard"]:
-        bb.error(f"swupdate: SWUPDATE_BOOTLOADER set to incompatible value: '{bootloader}'")
-}
-
-include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
-
-IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
-IMAGE_FSTYPES:append = " swu"
-# input is already compressed
-SWU_COMPRESSION_TYPE = ""
-
-# read-only rootfs with /home and /var
-# as separate partitions is used
-# /boot is excluded as an unified kernel image
-# is used. This images are stored in separate partitions.
-RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
-
-SWU_SIGNED ?= "1"
-SWU_HW_COMPAT ?= "cip-core-1.0"
-IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
-IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
-IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
-
-SWUPDATE_SELFBUILT ?= "0"
-SWUPDATE_SELFBUILT:buster = "1"
-SWUPDATE_SELFBUILT:bullseye = "1"
-SWUPDATE_SELFBUILT:bookworm = "1"
-
-python() {
-    base_distro = d.getVar('BASE_DISTRO_CODENAME')
-    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
-       bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
-        bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
-
-    if not bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) and \
-       not bb.utils.to_boolean(d.getVar('SWU_SIGNED')):
-        bb.fatal('SWUpdate from Debian requires signed SWUs')
-}
-
-IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
-IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
-
-IMAGE_INSTALL += " swupdate-handler-roundrobin"
-IMAGE_INSTALL += " swupdate-config"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
new file mode 120000
index 0000000..f02080c
--- /dev/null
+++ b/recipes-core/images/swupdate.inc
@@ -0,0 +1 @@
+swupdate-ab-rootfs.inc
\ No newline at end of file
-- 
2.51.2


