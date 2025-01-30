Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3126C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:28 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.12053.1738229961421101362
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=cRzZ3K92;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-2025013009391847837b8196446b1150-nnv9hh@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025013009391847837b8196446b1150
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 10:39:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tdvr9Jn/xa/D7LiN716BCDc2wsaYYSU8KsLn5FPJ6HU=;
 b=cRzZ3K92MRwZvUtJ9Wp/v/A0gtX1YaEETezu29fEDWTNEgKF3LlTyMfQrVRrfMVjYjO1ZG
 cNX+Hx4XLhef5oH322o+Jog3iP6R7B0ecuUan2p4WBCbjV+RQAaS1k54TMg7BiZSn+JE13yD
 ayJ4mvbYBWYotAscFj0p2Gitza4Njc+QlEaSs+sZBf5LLpN9I8qJgLAHl8xPbY/jCSLyh85z
 2EpOI+tQzD2vLvpAG5oyDEI/N8xl23h70312Xka4E0GW5Y3jGtx7H9Sqtcne5QKny3RGRGfF
 x3htUWLcmO1hJdFue9OmdumFplLkeTD2LCBWDnNBnnxQsaKrLHYyK3MQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC][PATCH 04/10] initramfs-overlay-hook: Optimize variable initialization
Date: Thu, 30 Jan 2025 10:39:11 +0100
Message-ID: <8492ee6dbf5634817cfe0bd80a18f0c21fad5bf5.1738229957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1738229957.git.jan.kiszka@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:39:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17708

From: Jan Kiszka <jan.kiszka@siemens.com>

Move some variables that are only relevant if the storage filesystem
was not mounted yet into the respective branch. This specifically avoids
to uselessly retrieve the filesystem type of the storage.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-overlay-hook/files/local-bottom.tmpl     | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
index f829a9bb..1087c3f7 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
@@ -8,17 +8,19 @@
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
 
-ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
 ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
 ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
-ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
-ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
 
 root_mount_storage=${rootmnt}${ovl_storage_path}
 storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
-partition_fstype=$(get_fstype "${ovl_partition_device}")
 
 if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
+	ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
+	ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
+	ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
+
+	partition_fstype=$(get_fstype "${ovl_partition_device}")
+
 	case $partition_fstype in
 	ext*)
 		e2fsck -p -f "$ovl_partition_device"
-- 
2.43.0


