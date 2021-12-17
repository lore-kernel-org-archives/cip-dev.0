Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07621C433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 15:05:16 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.7236.1639753514343238373
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 07:05:15 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1BHF5BJl014763
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 16:05:11 +0100
Received: from md2dvrtc.fritz.box ([139.22.39.215])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1BHF5AXv017057;
	Fri, 17 Dec 2021 16:05:11 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] Make read-only rootfs a inc file
Date: Fri, 17 Dec 2021 16:05:10 +0100
Message-Id: <20211217150510.1351713-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 15:05:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7185

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows downstream recipes to include the kas option
and use the include as base without recreating some parts
of the recipes.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/ebg-secure-boot-snakeoil.yml                  |  4 ++--
 recipes-core/images/cip-core-image.bb                 |  3 ++-
 .../{cip-core-image-read-only.bb => read-only.inc}    | 11 ++++++++++-
 .../initramfs-verity-hook_0.1.bb                      |  2 +-
 start-qemu.sh                                         |  3 ---
 5 files changed, 15 insertions(+), 8 deletions(-)
 rename recipes-core/images/{cip-core-image-read-only.bb => read-only.inc} (78%)

diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 1cfbacc..9f3eae9 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -14,16 +14,16 @@ header:
   includes:
    - kas/opt/ebg-secure-boot-base.yml
 
-target: cip-core-image-read-only
 
 local_conf_header:
+  image-options: |
+    CIP_IMAGE_OPTIONS_append = " read-only.inc"
   swupdate: |
     IMAGE_INSTALL_append = " swupdate"
     IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
 
   verity-img: |
     SECURE_IMAGE_FSTYPE = "squashfs"
-    VERITY_IMAGE_RECIPE = "cip-core-image-read-only"
     IMAGE_TYPE = "secure-swupdate-img"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
 
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 2cecde3..9bf21ff 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -18,4 +18,5 @@ IMAGE_INSTALL += "customizations"
 
 # for swupdate
 SWU_DESCRIPTION ??= "swupdate"
-include ${SWU_DESCRIPTION}.inc
+CIP_IMAGE_OPTIONS ?= "${SWU_DESCRIPTION}.inc"
+include ${CIP_IMAGE_OPTIONS}
diff --git a/recipes-core/images/cip-core-image-read-only.bb b/recipes-core/images/read-only.inc
similarity index 78%
rename from recipes-core/images/cip-core-image-read-only.bb
rename to recipes-core/images/read-only.inc
index 79cd6bf..604caa0 100644
--- a/recipes-core/images/cip-core-image-read-only.bb
+++ b/recipes-core/images/read-only.inc
@@ -1,4 +1,13 @@
-require cip-core-image.bb
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <Quriin.Gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
 
 SQUASHFS_EXCLUDE_DIRS += "home var"
 
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
index a7fbf5a..f0d2d68 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
@@ -24,7 +24,7 @@ TEMPLATE_VARS += "VERITY_BEHAVIOR_ON_CORRUPTION"
 
 DEBIAN_DEPENDS = "initramfs-tools, cryptsetup"
 
-VERITY_IMAGE_RECIPE ?= "cip-core-image-read-only"
+VERITY_IMAGE_RECIPE ?= "cip-core-image"
 
 VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.verity.env"
 
diff --git a/start-qemu.sh b/start-qemu.sh
index 4ab3861..24df490 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -45,9 +45,6 @@ if [ -z "${TARGET_IMAGE}" ];then
 	if grep -s -q "IMAGE_SECURITY: true" .config.yaml; then
 		TARGET_IMAGE="cip-core-image-security"
 	fi
-	if [ -n "${SECURE_BOOT}" ]; then
-		TARGET_IMAGE="cip-core-image-read-only"
-	fi
 fi
 
 case "$1" in
-- 
2.34.1


