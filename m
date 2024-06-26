Return-Path: <clara.kowalsky@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE71C3064D
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:41:51 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.27068.1719409308177881442
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 06:41:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=clara.kowalsky@siemens.com header.s=fm2 header.b=OEvX9dEx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1047747-202406261341443d483b469875a17f4c-0e5w4c@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202406261341443d483b469875a17f4c
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Jun 2024 15:41:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Q/iFIMirW1k6AY8Yfyxwr9Cuazy/ped87SYWJe4QE4A=;
 b=OEvX9dExklPNsn1yvLvdMDd3oHsr4iB9gzkYinklH5uRMVLb8lbDiKA5Hm9rif29P/zzIV
 9ut++/Sc9i1McN6+tls9dNa5J0K+97kJIN8T52ECKmOM3GZxMNW9lADCHOjIP/K7imBHex0U
 grYuqatsIdakgEMvPbygl8B3RjTSs=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v2 1/2] initramfs-overlay-hook: Add INITRAMFS_OVERLAY_MOUNT_OPTION
Date: Wed, 26 Jun 2024 15:41:40 +0200
Message-Id: <20240626134141.74487-1-clara.kowalsky@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 13:41:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16328

This allows to set options for the mount of the overlay storage device.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .../initramfs-overlay-hook/files/overlay.script.tmpl          | 2 ++
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb      | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index 2563dfd..42eb59c 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -30,12 +30,14 @@ esac
 ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
 ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
 ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
+ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
 
 root_mount_storage=${rootmnt}${ovl_storage_path}
 storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
 
 if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
 	if ! mount -t $(get_fstype ${ovl_partition_device}) \
+		 -o ${ovl_mount_option} \
 		 ${ovl_partition_device} \
 		 ${rootmnt}${storage_mount_point}; then
 		panic "Can't mount ${storage_mount_point} partition - overlay will not work!"
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
index 2694766..955748f 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
@@ -29,11 +29,13 @@ INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
 
 # override this to switch to UUID or PARTUUID based mounts
 INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
+INITRAMFS_OVERLAY_MOUNT_OPTION ??= "defaults,nodev,nosuid,noexec"
 
 TEMPLATE_FILES = "overlay.script.tmpl"
 TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
     INITRAMFS_OVERLAY_PATHS \
-    INITRAMFS_OVERLAY_STORAGE_DEVICE"
+    INITRAMFS_OVERLAY_STORAGE_DEVICE \
+    INITRAMFS_OVERLAY_MOUNT_OPTION"
 
 DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
 
-- 
2.45.2


