Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00EED78332
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 14:51:39 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.175576.1733151096412742655
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 06:51:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=TqtALidS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20241202145137455e0d4afa66591a79-35zzs_@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241202145137455e0d4afa66591a79
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Dec 2024 15:51:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Z2cCa9wsRbJvoopfPV/uQsEWl+MaSRN0zjUEbkPVZvE=;
 b=TqtALidSn8b0dC3v8Yhd3KcJ1opQjDnggPJTV2AOAmrFwHfcKTeWOhYEJPU4YMAqK0vhhl
 +K2Pf/M+0Kg066QDtqH8QI+B7NhM1qya2nWGJUA+AAnwbyrPg+CcrPSoZcInbq5XZr5qxkzy
 DGx5Aw+vAdTPVcA/gcDGELOF77M2MZ5MiuUQLLpk8yZ7JmrUpoWEcjb9aQhUFXgWKyY761f9
 3E1dO18Gdjq/8s9RACosN7qvfl3Pbrj2R4LKKWocOxm2DBTiFVhBkQUFCTKBgZP5APtlUuRv
 uOiLmhtXBt2/k6LmazIlQDUprlvVAob9HcjTvGyWLoGEFE9xiOsyGopw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 08/10] initramfs-verity-hook: Convert to hook.inc
Date: Mon,  2 Dec 2024 15:51:11 +0100
Message-ID: <ccb97e2bdaa3af44f9e248cf304dc10148469b37.1733151072.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1733151072.git.jan.kiszka@siemens.com>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 14:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17317

From: Jan Kiszka <jan.kiszka@siemens.com>

Simplifies the code.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-verity-hook/files/hook          |  5 ++++
 ...ty.script.tmpl => local-top-complete.tmpl} |  0
 .../initramfs-verity-hook/files/verity.hook   | 23 -------------------
 .../initramfs-verity-hook_0.2.bb              | 22 ++++++++----------
 4 files changed, 14 insertions(+), 36 deletions(-)
 create mode 100644 recipes-initramfs/initramfs-verity-hook/files/hook
 rename recipes-initramfs/initramfs-verity-hook/files/{verity.script.tmpl => local-top-complete.tmpl} (100%)
 delete mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.hook

diff --git a/recipes-initramfs/initramfs-verity-hook/files/hook b/recipes-initramfs/initramfs-verity-hook/files/hook
new file mode 100644
index 00000000..1550dafe
--- /dev/null
+++ b/recipes-initramfs/initramfs-verity-hook/files/hook
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: MIT
+# Copyright (c) Siemens AG, 2021-2024
+
+copy_file library /lib/cryptsetup/functions /lib/cryptsetup/functions
+copy_file library /usr/share/verity-env/verity.env /usr/share/verity-env/verity.env
diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl b/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
similarity index 100%
rename from recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
rename to recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.hook b/recipes-initramfs/initramfs-verity-hook/files/verity.hook
deleted file mode 100644
index 5eada8a0..00000000
--- a/recipes-initramfs/initramfs-verity-hook/files/verity.hook
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-PREREQ=""
-prereqs()
-{
-    echo "$PREREQ"
-}
-case $1 in
-prereqs)
-    prereqs
-    exit 0
-    ;;
-esac
-
-. /usr/share/initramfs-tools/hook-functions
-# Begin real processing below this line
-
-manual_add_modules dm_mod
-manual_add_modules dm_verity
-
-copy_exec /sbin/veritysetup
-copy_exec /sbin/dmsetup
-copy_file library /lib/cryptsetup/functions /lib/cryptsetup/functions
-copy_file library /usr/share/verity-env/verity.env /usr/share/verity-env/verity.env
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
index 6db4efcc..d8f62bb4 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
@@ -9,21 +9,24 @@
 # SPDX-License-Identifier: MIT
 #
 
-inherit dpkg-raw
+require recipes-initramfs/initramfs-hook/hook.inc
 
 SRC_URI += " \
-    file://verity.hook \
-    file://verity.script.tmpl \
+    file://hook \
+    file://local-top-complete.tmpl \
     "
 
 VERITY_BEHAVIOR_ON_CORRUPTION ?= "--restart-on-corruption"
 
-TEMPLATE_FILES = "verity.script.tmpl"
+TEMPLATE_FILES += "local-top-complete.tmpl"
 TEMPLATE_VARS += "VERITY_BEHAVIOR_ON_CORRUPTION"
 
 DEBIAN_DEPENDS = "initramfs-tools, cryptsetup"
 DEBIAN_CONFLICTS = "initramfs-abrootfs-hook"
 
+HOOK_ADD_MODULES = "dm_mod dm_verity"
+HOOK_COPY_EXECS = "veritysetup dmsetup"
+
 VERITY_IMAGE_RECIPE ?= "cip-core-image"
 
 # This is defined in image.bbclass which cannot be used in a package recipe.
@@ -33,22 +36,15 @@ IMAGE_FULLNAME ??= "${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}"
 VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.verity.env"
 
 do_install[depends] += "${VERITY_IMAGE_RECIPE}:do_image_verity"
-do_install[cleandirs] += " \
-    ${D}/usr/share/initramfs-tools/hooks \
-    ${D}/usr/share/verity-env \
-    ${D}/usr/share/initramfs-tools/scripts/local-top"
+do_install[cleandirs] += "${D}/usr/share/verity-env"
 
-do_install() {
+do_install:append() {
     # Insert the veritysetup commandline into the script
     if [ -f "${VERITY_ENV_FILE}" ]; then
         install -m 0600 "${VERITY_ENV_FILE}" "${D}/usr/share/verity-env/verity.env"
     else
         bberror "Did not find ${VERITY_ENV_FILE}. initramfs will not be build correctly!"
     fi
-    install -m 0755 "${WORKDIR}/verity.script" \
-        "${D}/usr/share/initramfs-tools/scripts/local-top/verity"
-    install -m 0755 "${WORKDIR}/verity.hook" \
-        "${D}/usr/share/initramfs-tools/hooks/verity"
 }
 
 addtask install after do_transform_template
-- 
2.43.0


