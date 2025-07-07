Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752EEC83F12
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:16:28 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.56252.1751879784137304091
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=OZ9QH9tc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-294854-202507070916225fed9c27a0b0e5e9d2-icqsia@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202507070916225fed9c27a0b0e5e9d2
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Jul 2025 11:16:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=o83kWde3MOOkTpcjTCWV19+VlaHy0K9BaiKqzD5yIxI=;
 b=OZ9QH9tcVNJoovZPEghDIykJolZ/CLf3TwIPWRHjG/y/oZW3Rf6iVmmZQ7asH3mcaVMM8X
 RD9yNEhoHaVl2gc9ajc89BJ55tumPz7WjxNcyBwqivRGuH2pQCNZeidPbsmXV2FD+7qwPSSj
 ADcO2Af92AgptCnN1IxvfnUNA7lz7k6K7gwLA6ZDSyhx6QINttN3+/5M5mHX4GPNY4O6u+Cj
 quj4OWNQ+VWfsin7DAKIj9QruaMwscGRH9vgZFRdb6reFhWQHFtD615s6EmxjB16IVrIeMa2
 veY3xdp01ERi3G/PcQ+fC75xEZGz10VFRpXmTN39RPhR+v/YOLyxCn4A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Heinisch Alexander <alexander.heinisch@siemens.com>,
	Cetin Gokhan <gokhan.cetin@siemens.com>
Subject: [isar-cip-core][PATCH v9 7/8] initramfs-crypt-hook: implement 'noencrypt' option
Date: Mon,  7 Jul 2025 11:16:19 +0200
Message-ID: <e17ee220820d041f32dc4102e03ab5ea37efedc5.1751879780.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1751879779.git.jan.kiszka@siemens.com>
References: <cover.1751879779.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 09:16:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19374

From: Claudius Heine <ch@denx.de>

In case encryption needs to be enabled via an update, while still
allowing the update fall back to work. One update step where encryption
is supported, but no reencryption is taking place if the device is not
encrypted.

For this the `noencrypt` hook is implemented, which requires some
restructure/reordering of the `local-top-complete` script.

Signed-off-by: Claudius Heine <ch@denx.de>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 doc/README.tpm2.encryption.md                 | 22 ++++++++++++++++-
 .../files/local-top-complete                  | 24 +++++++++++++++----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 3f7e89f3..2256f95a 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following variables which can be overwri
 ### CRYPT_PARTITIONS
 
 The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
-Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt or format>`.
+Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
 - The `partition-idenitifer` is used to identify the partition on the disk, it can contain a partition label, partition UUID or absolute path to the partition device, e.g. `/dev/sda`.
 - The `mountpoint` is used mount the decrypted partition in the root file system
 - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
 - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
+- `noencrypt` will not try to encrypt the partition if it isn't encrypted already, but will open it if it is. See the section [Encrypting the shared partition via an update](#### Encrypting the shared partition via an update) for more information
 
 #### Encrypted root file system
 
@@ -58,6 +59,25 @@ The mountpoint is empty as the root partition is mounted  by a seperate initramf
 Both partitions are encrypted during first boot. The initramfs hook opens `${ABROOTFS_PART_UUID_A}` and `${ABROOTFS_PART_UUID_B}`
 during boot.
 
+#### Encrypting the shared partition via an update
+
+With the following requirements, special handling is necessary:
+
+- A/B update scheme is used.
+- Both slots have a shared volume that needs to be encrypted as well.
+- The system in the field is currently unencrypted, and encryption should be added via an update.
+- When the update fails, the fallback system needs to deal with an encrypted data partition.
+
+In this case, the fallback system needs to support an encrypted shared data partition but would not encrypt it on its own. For this, the `noencrypt` flag can be used.
+
+The data partition in the fallback system will have the `noencrypt` flag set, while the update system will set the flag to `reencrypt`. This will handle the following case:
+
+- Unencrypted system on slot A is running; the shared data partition has set the `noencrypt` flag and is not encrypted.
+- Update for enabling encryption is applied to slot B, where the shared data partition has the `reencrypt` flag.
+- System reboots to slot B, encrypting the shared data partition.
+- Update fails at a later point and is not blessed; system reboots into the fallback system on slot A.
+- Fallback system now needs to be able to use the shared data partition.
+
 ### CRYPT_CREATE_FILE_SYSTEM_CMD
 
 The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create a new file system on a newly
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index f93f2a92..b76b1db3 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -243,15 +243,18 @@ for partition_set in $partition_sets; do
 	if [ ! -e  "$part_device" ]; then
 		panic "Could not find device  mapped to '$partition' cannot be encrypted!"
 	fi
-	decrypted_part=/dev/mapper/"$crypt_mount_name"
-	# check if we are trying to mount root
-	if [ "$partition_mountpoint" = "/" ]; then
-		echo "ROOT=$decrypted_part" >/conf/param.conf
-	fi
 
+	# If partition is already encrypted, decrypt and continue with next partition:
+	decrypted_part=/dev/mapper/"$crypt_mount_name"
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
 			| grep -q "systemd-tpm2\|clevis"; then
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
+
+		# check if we are trying to mount root, set ROOT to decrypted partition:
+		if [ "$partition_mountpoint" = "/" ]; then
+			echo "ROOT=$decrypted_part" >/conf/param.conf
+		fi
+
 		continue
 	fi
 
@@ -261,6 +264,17 @@ for partition_set in $partition_sets; do
 		partition_format="reencrypt"
 	fi
 
+	# If partition should not be encrypted, continue with next partition:
+	if [ "$partition_format" = "noencrypt" ]
+	then
+		continue
+	fi
+
+	# check if we are trying to mount root, set ROOT to decrypted partition:
+	if [ "$partition_mountpoint" = "/" ]; then
+		echo "ROOT=$decrypted_part" >/conf/param.conf
+	fi
+
 	# service watchdog in the background during lengthy re-encryption
 	if [ -z "$watchdog_pid" ]; then
 		service_watchdog &
-- 
2.43.0


