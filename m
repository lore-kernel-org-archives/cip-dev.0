Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A27DCD1286
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 10:06:20 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.9308.1711101969836433271
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Mar 2024 03:06:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Z/3xQ0Wf;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240322100607a43a2efebc1feade8a-wbsfsn@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240322100607a43a2efebc1feade8a
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Mar 2024 11:06:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1pG3HVF1ldqHb3ddz9MFXg3NhQQK3GwHO+U2X0XIUXM=;
 b=Z/3xQ0Wf8Pzn5ybk1FNZKadN7by61tnD+M4trghByzGDOCWzAoCUvT2U5IwOc0VKOZ+Tx2
 QAs/cRnjztSqL8br39BE79oXglTeySImbsdSSiGK4DWJNxghY7QUnHMIcb8ThFQiqwHrhNJs
 b1/tFypGCLzo6PrOiy7giYZUzKz4Y=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v2 08/13] initramfs-crypt-hook: Add check if root is part of the mountpoints
Date: Fri, 22 Mar 2024 11:05:18 +0100
Message-ID: <20240322100605.4129226-9-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
References: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Mar 2024 10:06:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15404

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If root will be encrypted the ROOT mountpoint will be set to
'/dev/mapper/encrypted_<partition_label>'.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.clevis.script                   | 6 ++++++
 .../files/encrypt_partition.systemd.script                  | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index 6aec7b8..fdbd9b5 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -127,12 +127,17 @@ fi
 
 for partition_set in $partition_sets; do
 	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
+	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
 	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
 	partition=/dev/disk/by-partlabel/"$partition_label"
 	crypt_mount_name="encrypted_$partition_label"
 	decrypted_part=/dev/mapper/"$crypt_mount_name"
 	# clevis does not work with links in /dev/disk*
 	part_device=$(readlink -f "$partition")
+	# check if we are trying to mount root
+	if [ "$partition_mountpoint" = "/" ]; then
+		echo "ROOT=$decrypted_part" >/conf/param.conf
+	fi
 
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
 			| grep -q "clevis"; then
@@ -169,6 +174,7 @@ for partition_set in $partition_sets; do
 		 ;;
 	esac
 
+
 	# delete initial key
 	# afterwards no new keys can be enrolled
 	cryptsetup -v luksKillSlot -q  "$part_device" 0
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index 7f2a6e3..e0c84ce 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -125,12 +125,17 @@ fi
 
 for partition_set in $partition_sets; do
 	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
+	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
 	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
 	partition=/dev/disk/by-partlabel/"$partition_label"
 	crypt_mount_name="encrypted_$partition_label"
 	decrypted_part=/dev/mapper/"$crypt_mount_name"
 	part_device=$(readlink -f "$partition")
 
+	# check if we are trying to mount root
+	if [ "$partition_mountpoint" = "/" ]; then
+		echo "ROOT=$decrypted_part" >/conf/param.conf
+	fi
 	# check if partition is already encrypted with systemd-tpm2
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
 			| grep -q "systemd-tpm2"; then
-- 
2.43.0


