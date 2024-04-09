Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D039CD12A2
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 13:06:51 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.136241.1712668002836662354
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 06:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ULoOU1G0;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240409130640932e873c4c624c97ce-urlkoq@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240409130640932e873c4c624c97ce
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Apr 2024 15:06:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1pG3HVF1ldqHb3ddz9MFXg3NhQQK3GwHO+U2X0XIUXM=;
 b=ULoOU1G04JbqoaAN97i9oGde2660tL35smtkUAli7MGqZhuNoL55igN2iu6eWNaJ5Lk/Ia
 DD6MKb+iG6YZ0TV5srjg7OTEgkV6StlCynWb+RKSd0XP73Fc8EYCcUxzFD/NRB+Ff6GaWgEc
 GIEhtxHxBfDoVIJC8DW7MK3VIScsg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v3 08/15] initramfs-crypt-hook: Add check if root is part of the mountpoints
Date: Tue,  9 Apr 2024 15:05:25 +0200
Message-ID: <20240409130638.559398-9-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
References: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Apr 2024 13:06:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15513

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


