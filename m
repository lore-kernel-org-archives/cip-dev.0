Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAD6EA71AF
	for <webhook@archiver.kernel.org>; Sun, 19 Apr 2026 23:59:21 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42964.1776426435936954557
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Apr 2026 04:47:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gouravsingh@siemens.com header.s=fm2 header.b=mIRY8vkB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1333022-20260417113709c4a4710b6000020761-teilnf@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260417113709c4a4710b6000020761
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Apr 2026 13:37:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=gouravsingh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=fJZWPb96XYCNM2zQTJfwJQtKJR+IB2gU8HPYwpU60iI=;
 b=mIRY8vkB9AJm0pSzX64mrNVV6hDPyWOXYtH3cFAPJdua1H9ESEeni4ETrGG9cR1NrQnj3U
 lleS9CXfD2ibT2GT0R1FJNu2+4tWMusbTAVHYWpIHPl5GTacH5H0NiTk9RrYc1yTlFvao/kL
 PPis+d7/EvE4AxuMNH++VOpBheBlVKCiJyeNzgdkuYwR51LfTD58LzWNvzhZXR3BhDr48JsS
 0/c10x/s8E7dah8yho5b42V+Q742IHAO7SNa561FjFWntTaVAnuPQhv15wcf8F04ETuTj1kx
 2JXoCB04pUWk3ueyGHmp13aqpoxwQEjej/VOdGmjbW3DvRFX1xsxLOwA==;
From: Gourav Singh <gouravsingh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Gourav Singh <gouravsingh@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] initramfs-crypt-hook: add configurable mount options for encrypted partitions
Date: Fri, 17 Apr 2026 17:06:50 +0530
Message-Id: <20260417113651.3923307-1-gouravsingh@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 19 Apr 2026 23:59:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22763

Introduce INITRAMFS_CRYPT_MOUNT_OPTIONS BitBake variable to allow
configuring mount options for encrypted partitions at build time,
following the same pattern as other INITRAMFS_* variables.

The overlay hook already sets nodev, nosuid and noexec mount options
for the overlay storage device. However, the crypt hook was mounting
encrypted partitions without explicit mount options, relying on
kernel/mount defaults, leaving the same security properties unenforced
for encrypted partitions.

Changes:
- Add INITRAMFS_CRYPT_MOUNT_OPTIONS BitBake variable with a safe
  default of "defaults,nodev,nosuid,noexec"
- Expose it via encrypt_partition.env.tmpl as MOUNT_OPTIONS
- Pass MOUNT_OPTIONS to mount_partition() via mount -o in
  local-bottom-complete
- Add INITRAMFS_CRYPT_MOUNT_OPTIONS to TEMPLATE_VARS so it is
  expanded into the env template at build time

Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl     | 1 +
 .../initramfs-crypt-hook/files/local-bottom-complete          | 4 +++-
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb         | 4 +++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
index 452714d..787172f 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
@@ -8,3 +8,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
 HASH_TYPE="${CRYPT_HASH_TYPE}"
 KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
 ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
+MOUNT_OPTIONS="${INITRAMFS_CRYPT_MOUNT_OPTIONS}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
index 064e41c..d8516bc 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
@@ -36,13 +36,15 @@ esac
 # get configuration variables
 . /usr/share/encrypt_partition/encrypt_partition.env

+mount_options="$MOUNT_OPTIONS"
 mount_partition() {
 	partition_dev_path=$1
 	partition_mountpoint=$2
 	[ "$debug" = "y" ] && echo "mount device: '$partition_dev_path' to '$partition_mountpoint'"
 	if ! mountpoint -q "${partition_mountpoint}"; then
 		mkdir -p "${partition_mountpoint}"
-		if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
+		if ! mount -o "${mount_options}" \
+             -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
 			 "${partition_mountpoint}"; then
 			panic "Can't mount partition '${partition_dev_path}'!"
 		fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
index 18a10a8..c0572f2 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
@@ -95,10 +95,12 @@ CRYPT_KEY_ALGORITHM ??= "ecc"
 CRYPT_ENCRYPTION_OPTIONAL ??= "false"
 # add support for btrfs encryption
 CRYPT_BTRFS_SUPPORT ??= "0"
+# mount options for encrypted partitions
+INITRAMFS_CRYPT_MOUNT_OPTIONS ??= "defaults,nodev,nosuid,noexec"

 TEMPLATE_VARS += "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
     CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
-    CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
+    CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL INITRAMFS_CRYPT_MOUNT_OPTIONS"
 TEMPLATE_FILES += "encrypt_partition.env.tmpl"

 OVERRIDES .= "${@':expand-on-crypt' if ':expand' in d.getVar('CRYPT_PARTITIONS') else ''}"
--
2.39.5


