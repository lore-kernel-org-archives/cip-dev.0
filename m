Return-Path: <clara.kowalsky@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A7EC3DA59
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 13:53:08 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.38645.1721051584815794410
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jul 2024 06:53:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=clara.kowalsky@siemens.com header.s=fm2 header.b=rOCsyu8L;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1047747-20240715135301b185d3ef164ecc7f9a-n1kdk4@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240715135301b185d3ef164ecc7f9a
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Jul 2024 15:53:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Jrqd2jgaIvnKextb4J7TISsN79hfdMBrghKkNCYOxew=;
 b=rOCsyu8Laokj3lGdZBqFv+QD8TpeP/XMHwrc97SHsjpcHgCHTnMs9UsO2wrIef+KJoo8q8
 pQCTYraOBjf/DNC9mY6k0xTRlrnm90rUQgtcF2283ut6CvMF9SR+O+LEGtTEN/joKuPrS6WT
 K5+djImnImlP9qeBgQQ4Kr8H3sYnI=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH v4] initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
Date: Mon, 15 Jul 2024 15:52:58 +0200
Message-Id: <20240715135258.902008-1-clara.kowalsky@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 13:53:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16498

In case of ext*, this detects and fixes file system errors in the
partition device before doing the partition mount.
If the partition turns out to be broken, the factory state is recovered.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .../initramfs-overlay-hook/files/overlay.hook      | 11 +++++++++--
 .../files/overlay.script.tmpl                      | 11 ++++++++++-
 .../files/overlay_recovery_action.script           | 14 ++++++++++++++
 .../initramfs-overlay-hook_0.1.bb                  |  8 +++++++-
 4 files changed, 40 insertions(+), 4 deletions(-)
 create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
index 8b00ecf..6f634c5 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
@@ -22,6 +22,13 @@ esac
 
 . /usr/share/initramfs-tools/hook-functions
 
+hook_error() {
+    echo "(ERROR): $1" >&2
+    exit 1
+}
+
 manual_add_modules overlay
-copy_exec /usr/bin/mountpoint
-copy_exec /usr/bin/awk
+copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
+copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
+copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
+copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index 42eb59c..deda034 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -31,12 +31,21 @@ ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
 ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
 ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
 ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
+ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
 
 root_mount_storage=${rootmnt}${ovl_storage_path}
 storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
+partition_fstype=$(get_fstype "${ovl_partition_device}")
 
 if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
-	if ! mount -t $(get_fstype ${ovl_partition_device}) \
+	if [ "$partition_fstype" = "ext*" ]; then
+		if ! e2fsck -p -f "$ovl_partition_device"; then
+			if [ -f "$ovl_recovery_script" ] && [ -x "$ovl_recovery_script" ]; then
+				"$ovl_recovery_script" "$ovl_partition_device" "$partition_fstype"
+			fi
+		fi
+	fi
+	if ! mount -t ${partition_fstype} \
 		 -o ${ovl_mount_option} \
 		 ${ovl_partition_device} \
 		 ${rootmnt}${storage_mount_point}; then
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
new file mode 100644
index 0000000..4ef0148
--- /dev/null
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+
+ovl_partition_device="$1"
+partition_fstype="$2"
+
+mke2fs -t "$partition_fstype" "$ovl_partition_device"
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
index 955748f..7097130 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
@@ -12,9 +12,12 @@
 
 inherit dpkg-raw
 
+INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
+
 SRC_URI += " \
     file://overlay.hook \
     file://overlay.script.tmpl \
+    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
     "
 
 # The variable INITRAMFS_OVERLAY_PATHS contains the directories which are
@@ -35,7 +38,8 @@ TEMPLATE_FILES = "overlay.script.tmpl"
 TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
     INITRAMFS_OVERLAY_PATHS \
     INITRAMFS_OVERLAY_STORAGE_DEVICE \
-    INITRAMFS_OVERLAY_MOUNT_OPTION"
+    INITRAMFS_OVERLAY_MOUNT_OPTION \
+    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
 
 DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
 
@@ -48,4 +52,6 @@ do_install() {
         "${D}/usr/share/initramfs-tools/hooks/overlay"
     install -m 0755 "${WORKDIR}/overlay.script" \
         "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
+    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
+        "${D}/usr/share/initramfs-tools/scripts"
 }
-- 
2.45.2


