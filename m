Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD1DE95A91
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 11:56:59 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.59159.1696852457119436318
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Oct 2023 04:54:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=CgBsUf0M;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-72506-2023100911541445a2eb54e1bc49fb3e-lo1r_z@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023100911541445a2eb54e1bc49fb3e
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Oct 2023 13:54:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yB7NPoaXIWZEm0HFcfc/4syJmWPZsZPWc2atb83gnY8=;
 b=CgBsUf0MOe5AyBdVqDTsUNrxBH8n2dmMp/n1ESJhbV87g+FhNuhdJo5cJBu7xCHEp3shdC
 sXbP0qWLWcL5nhiobwWGQGQCsaReha1OWOnk4FF6q4mKGnQ9dG7UdDaXKuzeKTMmGP5VCXa3
 +D7zKNDR7dCGJzJJExGuaolZ9QYN8=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 1/2] make method to find /var mount configurable
Date: Mon,  9 Oct 2023 19:53:43 +0800
Message-Id: <20231009115344.746642-2-felix.moessbauer@siemens.com>
In-Reply-To: <20231009115344.746642-1-felix.moessbauer@siemens.com>
References: <20231009115344.746642-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 11:56:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13319

Previously, the /var mount is only located by the partition label. This
is problematic, as collisions on this label might happen when working
with multiple disks. This patch makes the method to find the /var
partition configurable. By that, downstream implementations can use UUID
or PARTUUID based mounting.

For backwards compatibility we keep the current label-based mounting as
default.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 .../initramfs-overlay-hook/files/overlay.script.tmpl | 12 ++++++------
 .../initramfs-overlay-hook_0.1.bb                    |  5 +++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index 71d2599..d7da6fb 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -27,17 +27,17 @@ esac
 . /scripts/functions
 
 
-ovl_partition_label="${INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL}"
+ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
 ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
 ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
 
 root_mount_storage=${rootmnt}${ovl_storage_path}
 
-if ! mountpoint -q "${rootmnt}/${ovl_partition_label}"; then
-	if ! mount -t $(get_fstype /dev/disk/by-label/${ovl_partition_label}) \
-		 /dev/disk/by-label/${ovl_partition_label} \
-		 ${rootmnt}/${ovl_partition_label}; then
-		panic "Can't mount /${ovl_partition_label} partition - overlay will not work!"
+if ! mountpoint -q "${rootmnt}/var"; then
+	if ! mount -t $(get_fstype ${ovl_partition_device}) \
+		 ${ovl_partition_device} \
+		 ${rootmnt}/var; then
+		panic "Can't mount /var partition - overlay will not work!"
 	fi
 fi
 
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
index 566bd15..9e78dc8 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
@@ -19,12 +19,13 @@ SRC_URI += " \
 
 INITRAMFS_OVERLAY_PATHS ??= "/etc"
 INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
-INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
+# override this to switch to UUID or PARTUUID based mounts
+INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
 
 TEMPLATE_FILES = "overlay.script.tmpl"
 TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
     INITRAMFS_OVERLAY_PATHS \
-    INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL"
+    INITRAMFS_OVERLAY_STORAGE_DEVICE"
 
 DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
 
-- 
2.39.2


