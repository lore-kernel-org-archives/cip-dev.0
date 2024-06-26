Return-Path: <clara.kowalsky@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432F6C27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:42:01 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.26865.1719409312193331653
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 06:41:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=clara.kowalsky@siemens.com header.s=fm2 header.b=HcrkM1K7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1047747-2024062613414915a468704cc42279cf-ytervd@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024062613414915a468704cc42279cf
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Jun 2024 15:41:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oNRaM3oJRy7t6fD8x7U/hUoCWKO8ZHUgR9dRKnzjpL4=;
 b=HcrkM1K7exgycywbdq5C1SD+Jdvk96tVqtBOCWYeWWVeY3WQv4tFv8Indq74f4m7O6wMiC
 Uv467Q5ANCREEreQ8jHqAAWUbWnCGtMkUMla7tEFzO/+r1shR1i6gBuwi0d0bxHInDaN3bmr
 VFhpMRyMcr0eJW9JMQmxoxV4mj/5g=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v2 2/2] initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
Date: Wed, 26 Jun 2024 15:41:41 +0200
Message-Id: <20240626134141.74487-2-clara.kowalsky@siemens.com>
In-Reply-To: <20240626134141.74487-1-clara.kowalsky@siemens.com>
References: <20240626134141.74487-1-clara.kowalsky@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 13:42:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16329

In case of ext*, this detects and fixes file system errors in the
partition device before doing the partition mount.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .../initramfs-overlay-hook/files/overlay.hook          | 10 ++++++++--
 .../initramfs-overlay-hook/files/overlay.script.tmpl   |  8 +++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
index 8b00ecf..1a54853 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
@@ -22,6 +22,12 @@ esac
 
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


