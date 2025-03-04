Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3282AC282D6
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 13:07:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.21187.1741093673591260581
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 05:07:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=GDIkWjm/;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8A9310382C18;
	Tue,  4 Mar 2025 14:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741093672; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TZ+E1sUZ1rppZwB9IDQaU0XD3uT5Hss85l9Y3vGtw6I=;
	b=GDIkWjm/gzonp2/8CHNHnZsVd2hJ3pPQ186cQZO7rrEJNIYErdePZ87cNJKkiWF5R7lDjf
	09It70m92DZXVI3gClK+gzdKGyT5sTf+o2qr+qYcIHKjYnec8zSYjR39R9PNXoDB54knHQ
	DFv2xJvoisHSn23upqv0h9bWQH4wVwD98rYCilY6nk+IWIV/oUKNjb8Ukk12wCrcxFeDka
	yT0a1gXcEBGAQqSXZHWASjFSx7tHhc4OVU6L2bNbD0olppTc4TjPwGdl5+9mGqDKNGiNXI
	3Ev9DJJEZ2fyLYyiJcR4Nm5v0Mah8+pT4otRqSsonYtqstBYKvFYWEj9GR/SAA==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH v3 2/4] initramfs-crypt-hook: implement 'noencrypt' option
Date: Tue,  4 Mar 2025 14:07:41 +0100
Message-ID: <20250304130743.2812183-3-ch@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304130743.2812183-1-ch@denx.de>
References: <20250304130743.2812183-1-ch@denx.de>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 13:07:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18017

In case encryption needs to be enabled via an update, while still
allowing the update fall back to work. One update step where encryption
is supported, but no reencryption is taking place if the device is not
encrypted.

For this the `noencrypt` hook is implemented, which requires some
restructure/reordering of the `local-top-complete` script.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 doc/README.tpm2.encryption.md                 | 22 ++++++++++++++++-
 .../files/local-top-complete                  | 24 +++++++++++++++----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.m=
d
index 3f7e89f..a97425c 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following var=
iables which can be overwri
 ### CRYPT_PARTITIONS
=20
 The variable `CRYPT_PARTITIONS` contains the information which partition=
 shall be encrypted where to mount it.
-Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencry=
pt or format>`.
+Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencry=
pt | format | noencrypt>`.
 - The `partition-idenitifer` is used to identify the partition on the di=
sk, it can contain a partition label, partition UUID or absolute path to =
the partition device, e.g. `/dev/sda`.
 - The `mountpoint` is used mount the decrypted partition in the root fil=
e system
 - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content=
 of the partition. This reduces the partition by 32MB and the file system=
 by a similar amount
 - `format` creates a empty LUKS partition and creates a file system defi=
ned with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
+- `noencrypt` will not try to encrypt the partition, if it isn't encrypt=
ed already, but will open it if it is. See the section [Encrypting the sh=
ared partition via an update](#### Encrypting the shared partition via an=
 update) for more information
=20
 #### Encrypted root file system
=20
@@ -58,6 +59,25 @@ The mountpoint is empty as the root partition is mount=
ed  by a seperate initramf
 Both partitions are encrypted during first boot. The initramfs hook open=
s `${ABROOTFS_PART_UUID_A}` and `${ABROOTFS_PART_UUID_B}`
 during boot.
=20
+#### Encrypting the shared partition via an update
+
+With the following requirements, special handling is necessary:
+
+- A/B update scheme is used
+- Both slots have a shared volume, that needs to be encrypted as well
+- The system in field is currently unencrypted and encryption should be =
added via an update
+- When the update failed, the fallback system needs to deal with an encr=
ypted data partition
+
+If this case the fallback system needs to support an encrypted shared da=
ta partition, but would not encrypt it themselves. For this the `noencryp=
t` flag can be used.
+
+The data partition in the fallback system will have the `noencrypt` flag=
 set, while the update system will set the flag to `reencrypt`, this will=
 handle the following case, for example
+
+- Un-encrypted system on slot A is running, shared data partition has se=
t `noencrypt` flag and is not encrypted
+- Update for enabling encryption is applied to slot B, where the shared =
data partition has the `reencrypt` flag
+- System reboots to slot B, encrypting the shared data partition
+- Update fails at a later point and is not blessed, system reboots into =
the fallback system on slot A
+- Fallback system now needs to be able to use the shared data partition
+
 ### CRYPT_CREATE_FILE_SYSTEM_CMD
=20
 The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to crea=
te a new file system on a newly
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-compl=
ete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index cf49e63..1ef784d 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -240,18 +240,32 @@ for partition_set in $partition_sets; do
 	if [ ! -e  "$part_device" ]; then
 		panic "Could not find device  mapped to '$partition' cannot be encrypt=
ed!"
 	fi
-	decrypted_part=3D/dev/mapper/"$crypt_mount_name"
-	# check if we are trying to mount root
-	if [ "$partition_mountpoint" =3D "/" ]; then
-		echo "ROOT=3D$decrypted_part" >/conf/param.conf
-	fi
=20
+	# If partition is already encrypted, decrypt and continue with next par=
tition:
+	decrypted_part=3D/dev/mapper/"$crypt_mount_name"
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
 			| grep -q "luks2"; then
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
+
+		# check if we are trying to mount root, set ROOT to decrypted partitio=
n:
+		if [ "$partition_mountpoint" =3D "/" ]; then
+			echo "ROOT=3D$decrypted_part" >/conf/param.conf
+		fi
+
 		continue
 	fi
=20
+	# If partition should not be encrypted, continue with next partition:
+	if [ "$partition_format" =3D "noencrypt" ]
+	then
+		continue
+	fi
+
+	# check if we are trying to mount root, set ROOT to decrypted partition=
:
+	if [ "$partition_mountpoint" =3D "/" ]; then
+		echo "ROOT=3D$decrypted_part" >/conf/param.conf
+	fi
+
 	# service watchdog in the background during lengthy re-encryption
 	if [ -z "$watchdog_pid" ]; then
 		service_watchdog &
--=20
2.47.2


