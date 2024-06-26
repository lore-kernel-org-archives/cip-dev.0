Return-Path: <clara.kowalsky@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92751C27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 11:47:39 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.24164.1719402456538566240
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 04:47:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=clara.kowalsky@siemens.com header.s=fm2 header.b=pkLXd+OK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1047747-2024062611473369363af49faa613dfb-fymkqk@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024062611473369363af49faa613dfb
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Jun 2024 13:47:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GuLBP/LykwKtpkos8BYFpy2vNuMR5aEEZNy4NJvKEiw=;
 b=pkLXd+OKhks+MlUNZdc1px/e4z9inFRxqNeniM9GCPHVisg3qLgfgzu4Rg8eugI29009Cn
 m+F9OL8isaWSdGN45k6/fJ0JBEobotQVpfQ0bsO+Gngb+AcesKUNo4EnR7EaV1xzt2JLJWO9
 ALfsQz3BLMxoHlABacsczwPW7ZAqw=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 2/2] initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
Date: Wed, 26 Jun 2024 13:47:15 +0200
Message-Id: <20240626114715.70823-2-clara.kowalsky@siemens.com>
In-Reply-To: <20240626114715.70823-1-clara.kowalsky@siemens.com>
References: <20240626114715.70823-1-clara.kowalsky@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 11:47:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16325

In case of ext*, this detects and fixes file system errors in the
partition device before doing the partition mount.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .../initramfs-overlay-hook/files/overlay.hook             | 5 +++--
 .../initramfs-overlay-hook/files/overlay.script.tmpl      | 8 +++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
index 8b00ecf..7a9f737 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
@@ -23,5 +23,6 @@ esac
 . /usr/share/initramfs-tools/hook-functions
 
 manual_add_modules overlay
-copy_exec /usr/bin/mountpoint
-copy_exec /usr/bin/awk
+copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
+copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
+copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index 42eb59c..6b404c6 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -34,9 +34,15 @@ ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
 
 root_mount_storage=${rootmnt}${ovl_storage_path}
 storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
+partition_fstype=$(get_fstype "${ovl_partition_device}")
 
 if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
-	if ! mount -t $(get_fstype ${ovl_partition_device}) \
+	if [ $partition_fstype = "ext*" ]; then
+		if ! e2fsck -p -f "$partition_fstype"; then
+			panic "E2fsck on ${ovl_partition_device} not successful!"
+		fi
+	fi
+	if ! mount -t ${partition_fstype} \
 		 -o ${ovl_mount_option} \
 		 ${ovl_partition_device} \
 		 ${rootmnt}${storage_mount_point}; then
-- 
2.45.2


