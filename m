Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C5C7EE32
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 09:09:51 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.4064.1750928982223003927
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jun 2025 02:09:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=dfyYCH+g;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A3A71039BD78;
	Thu, 26 Jun 2025 11:09:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750928980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xzUsfmfvAjfj4wugvJAdsXBeUBVnZKNB3fG8MtDyE7A=;
	b=dfyYCH+gygoQ84erqsW+gQQdEY0rrnlBtGuhqkvPPDcW7WuDe8vUTaW9GN1rQl1001NE2U
	UHlNu9DDiDs3fUBfm2AfYAXT/K4uETCTfKii3jBQLAfz904xybvGSk/R9So2Rpn1hGk85T
	jbdN6fXwTvvWHJKy0VLeV43HeZ5qrS0acRrg4huGbROsOqVyJiWKi52wYkxBfXRyZvVqkZ
	B0gIlFIZKEHXT7SaUs4xjDjFeptqy/E7Qth6Q2soO6+6eOqvM9dAo95SNXY655cZY6+tPg
	YOHDT1RFyTtQ65uwBJ3lbO0C3Uiaisjw0+8afOhq42Ebay1+G7UThlPIhuCd3Q==
From: Claudius Heine <ch@denx.de>
Date: Thu, 26 Jun 2025 11:09:26 +0200
Subject: [PATCH v8 3/4] initramfs-crypt-hook: implement 'noencrypt' option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-initramfs-crypt-hook-patches-2-v8-3-46f000788686@denx.de>
References: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
In-Reply-To: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Quirin Gylstorff <quirin.gylstorff@siemens.com>, 
 Heinisch Alexander <alexander.heinisch@siemens.com>, 
 Cetin Gokhan <gokhan.cetin@siemens.com>, Claudius Heine <ch@denx.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jun 2025 09:09:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19242

In case encryption needs to be enabled via an update, while still
allowing the update fall back to work. One update step where encryption
is supported, but no reencryption is taking place if the device is not
encrypted.

For this the `noencrypt` hook is implemented, which requires some
restructure/reordering of the `local-top-complete` script.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 doc/README.tpm2.encryption.md                      | 22 +++++++++++++++++++-
 .../initramfs-crypt-hook/files/local-top-complete  | 24 +++++++++++++++++-----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 3f7e89f34fa4638a42285989e61370d8970afcde..2256f95a039044313807ab75ce219fa3eb7408b6 100644
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
index e773ec3e165f72de624a17872ed3fa74746f20d8..9038f4b74b94a5c673239da316f0966b77e4b5d3 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -303,15 +303,18 @@ for partition_set in $partition_sets; do
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
 
@@ -321,6 +324,17 @@ for partition_set in $partition_sets; do
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
2.50.0


