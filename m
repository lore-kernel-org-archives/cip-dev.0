Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AF8D78333
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 14:51:39 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.175575.1733151095512780478
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 06:51:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=AOvQGjHM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-202412021451354ebac7d0531a8e9d7c-dqvlfn@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202412021451354ebac7d0531a8e9d7c
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Dec 2024 15:51:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+18aKPFg1lFSneqgtVxdUusrgNWRnP5o4ooeMBKw06w=;
 b=AOvQGjHMywQwQVHpZde5KRD1WxGMQjDxbKGViFLES5Iw/rxCwCFl86dxzxeVwCdGlsxWQK
 z3+/S4W/eVsQVlqFpUh2btWfxfjI/xHOrt33dexdC6stWPnyKApI4+oMPvI59s/Ni+eKVT7V
 +7bUtV5OKhMJRl0vba/KW0uLKAjXpqqRRFooRGKs1UN40QzTeHZlt+Lmtpa6Aitf/IZnfzIB
 d72hxKJP3su3K8uq4PEKRThAgYLKL4xLL39JDEhc7E+2gHwIKWHlHJHBLjOO0wzJzKcwBB/r
 O8FvQs5XeQW2ShokfCh1KeyJyAEIIAbKliJJ09IS4QzJT4jxluDUN8Yw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 06/10] initramfs-overlay-hook: Convert to hook.inc
Date: Mon,  2 Dec 2024 15:51:09 +0100
Message-ID: <35a226b87671c1a4814ec8b3c2f04f8bb2049b8c.1733151072.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17312

From: Jan Kiszka <jan.kiszka@siemens.com>

Simplifies the code.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{overlay.script.tmpl => local-bottom.tmpl} | 23 ++-----------
 .../initramfs-overlay-hook/files/overlay.hook | 34 -------------------
 ...k_0.1.bb => initramfs-overlay-hook_0.2.bb} | 20 ++++-------
 3 files changed, 10 insertions(+), 67 deletions(-)
 rename recipes-initramfs/initramfs-overlay-hook/files/{overlay.script.tmpl => local-bottom.tmpl} (91%)
 delete mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
 rename recipes-initramfs/initramfs-overlay-hook/{initramfs-overlay-hook_0.1.bb => initramfs-overlay-hook_0.2.bb} (71%)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
similarity index 91%
rename from recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
rename to recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
index 72d13963..f829a9bb 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
@@ -1,32 +1,13 @@
-#!/bin/sh
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2023
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
 
-PREREQ=""
-
-prereqs()
-{
-	echo "$PREREQ"
-}
-
-case $1 in
-# get pre-requisites
-prereqs)
-	prereqs
-	exit 0
-	;;
-esac
-
-. /scripts/functions
-
-
 ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
 ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
 ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
@@ -76,3 +57,5 @@ for ovl_lower_dir in ${ovl_lower_dirs}; do
 		panic "Can't mount overlay for '$ovl_lower_dir' !"
 	fi
 done
+
+exit 0
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
deleted file mode 100644
index 6f634c50..00000000
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
+++ /dev/null
@@ -1,34 +0,0 @@
-#!/bin/sh
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-
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
-
-hook_error() {
-    echo "(ERROR): $1" >&2
-    exit 1
-}
-
-manual_add_modules overlay
-copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
-copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
-copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
-copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
similarity index 71%
rename from recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
rename to recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
index 7097130d..e6ac1e91 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022 - 2023
+# Copyright (c) Siemens AG, 2022 - 2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -10,13 +10,12 @@
 # SPDX-License-Identifier: MIT
 #
 
-inherit dpkg-raw
+require recipes-initramfs/initramfs-hook/hook.inc
 
 INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
 
 SRC_URI += " \
-    file://overlay.hook \
-    file://overlay.script.tmpl \
+    file://local-bottom.tmpl \
     file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
     "
 
@@ -34,7 +33,7 @@ INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
 INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
 INITRAMFS_OVERLAY_MOUNT_OPTION ??= "defaults,nodev,nosuid,noexec"
 
-TEMPLATE_FILES = "overlay.script.tmpl"
+TEMPLATE_FILES += "local-bottom.tmpl"
 TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
     INITRAMFS_OVERLAY_PATHS \
     INITRAMFS_OVERLAY_STORAGE_DEVICE \
@@ -43,15 +42,10 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
 
 DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
 
-do_install[cleandirs] += " \
-    ${D}/usr/share/initramfs-tools/hooks \
-    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
+HOOK_ADD_MODULES = "overlay"
+HOOK_ADD_EXECS = "mountpoint awk e2fsck mke2fs"
 
-do_install() {
-    install -m 0755 "${WORKDIR}/overlay.hook" \
-        "${D}/usr/share/initramfs-tools/hooks/overlay"
-    install -m 0755 "${WORKDIR}/overlay.script" \
-        "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
+do_install:append() {
     install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
         "${D}/usr/share/initramfs-tools/scripts"
 }
-- 
2.43.0


