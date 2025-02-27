Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FFFC282C1
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:30:49 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.11652.1740666645672457614
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:30:46 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=Dy6cRjiA;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB89E10382D2E;
	Thu, 27 Feb 2025 15:30:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740666644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUpU22LCVzXe6uJPJoMcXajbtqTmzVYRmTTG5dlKeCA=;
	b=Dy6cRjiA4KOJPISDWP374v3QhEM/jMY2V7H7HVrX/Oy5ELq8xa+rq3QAvzFaBEvgWB6PcL
	/EQXbMI19/3Zukxezc3sbYZek+Vc6TSv+RkQR6sQa4n2aO/GUg5oA6mSiybx2of1kBcgyu
	ZNAEQcIwWRRGOUQTYlXZn5qNgppd/6can6N+W6awhncoo0eJGKJ7AVXS23Zxf9DYIWoUTw
	W4x8oZ7ynqfvSnUldtwI7GCmqCf1J/QAnyzIt9PBYWSOyPi1BAH2d/AxIFvNnVVa34vrSr
	td9MtSpESoDp/DEI25iwOLt4D0wLqNHB8lwndhfZB8dHpt82YwFD+rcP/dGrYg==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH v2 2/4] initramfs-crypt-hook: implement 'noencrypt' option
Date: Thu, 27 Feb 2025 15:30:20 +0100
Message-ID: <20250227143022.323950-3-ch@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227143022.323950-1-ch@denx.de>
References: <20250227143022.323950-1-ch@denx.de>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:30:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17943

In case encryption needs to be enabled via an update, while still
allowing the update fall back to work. One update step where encryption
is supported, but no reencryption is taking place if the device is not
encrypted.

For this the `noencrypt` hook is implemented, which requires some
restructure/reordering of the `local-top-complete` script.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 doc/README.tpm2.encryption.md                 |  3 ++-
 .../files/local-top-complete                  | 24 +++++++++++++++----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.m=
d
index 3f7e89f..a503095 100644
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
ed already, but will open it if it is. This makes it possible for an syst=
em to support encrypted partitions, while not encrypting anything on thei=
r own. Useful when updating from a system that is unencrypted to one that=
 is, while supporting a fallback system. For example, with a shared data =
partition, the fallback system would have the `noencrypt` option, while t=
he encrypted system would have the `reencrypt` option set for it. Now the=
 fallback system can still open the data partition if the update to the e=
ncrypted system failed.
=20
 #### Encrypted root file system
=20
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-compl=
ete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 502fcc1..67722fc 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -211,22 +211,36 @@ for partition_set in $partition_sets; do
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
 	if [ "$partition_expand" =3D "expand" ]; then
 		expand_partition $part_device
 	fi
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


