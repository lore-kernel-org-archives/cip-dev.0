Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F825C19777
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 09:59:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2487.1740563973107301887
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2025 01:59:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=Ue0ChJkd;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A22B10382D2E;
	Wed, 26 Feb 2025 10:59:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740563971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nz/5EGwKwI0PGEuTPIc5979bd4BCxVtjjzyWakKRvdg=;
	b=Ue0ChJkdiQyhVHg8kpopnR9qA19JUc4Qlx7xISe0lrksYneEiYMhKTyAQen9xLkaoq+yW3
	DXRl+FW5BcnTFA02chltjdl0agHVle4wUz8a5tIA/ukNrPrH92ORzmAVXnRxPr2fHk2Prt
	9VHknSsKRJmev2zzvlPO3QCWzOztVSpphMHXUut2kp9TTsWisiMNRQ4XDVOUrZKBj2E/qh
	hbCaTX/eSsXVN7tus3dLthhSLoEkGqwrc78vkI6huF8Og92hFvX4qbLXH4PuPhJ7N1svi9
	jyFZCqU7ZRAf3VAqTkonOR+L6i5HNEsE0AH8QmX4H4OQK0TRU8hnuZI5XmXd9A==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH 5/5] initramfs-crypt-hook: add 'format-if-empty' feature
Date: Wed, 26 Feb 2025 10:59:21 +0100
Message-ID: <20250226095921.168962-6-ch@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226095921.168962-1-ch@denx.de>
References: <20250226095921.168962-1-ch@denx.de>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 09:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17923

When encryption is enabled from one update to the next there is a
difference between flashing a fresh factory image to a empty storage
device, which contains an empty fallback partition set and updating it,
where the fallback partition contains the actual fallback partitions.

In the update case, the update case, the fallback system should be left
alone and unencrypted.

When doing a factory flash, the fallback partitions can be encrypted.

The best marker on in which case the system is booted is, if the
partition is empty or not. The 'format-if-empty' option will format the
partition with a luks format in case the first 10MiB are empty.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 doc/README.tpm2.encryption.md                    |  3 ++-
 .../files/local-top-complete                     | 16 ++++++++++++++++
 .../initramfs-crypt-hook_0.6.bb                  |  2 +-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.m=
d
index 515348a..5fe195d 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -42,12 +42,13 @@ The initramfs-crypt-hook recipe has the following var=
iables which can be overwri
 ### CRYPT_PARTITIONS
=20
 The variable `CRYPT_PARTITIONS` contains the information which partition=
 shall be encrypted where to mount it.
-Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencry=
pt | format | noencrypt>`.
+Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencry=
pt | format | noencrypt | format-if-empty>`.
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
 - `noencrypt` will not try to encrypt the partition, it it isn't encrypt=
ed already, but will open it if it is. This makes it possible for an imag=
e to support encrypted systems, while not encrypting anything on their ow=
n. Useful when updating from a system that is unencrypted to one that is,=
 while supporting a fallback system.
+- `format-if-empty` will create a empty LUKS partition and formats it, l=
ike the `format` option, but only if the first 10MiB are empty (contain o=
nly 0x00). This makes it possible to differenciate if a partition is empt=
y and can be encrypted, because it was freshly flashed via a factory imag=
e, or if it might contain an unencrypted fallback system and should be le=
ft alone.
=20
 #### Encrypted root file system
=20
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-compl=
ete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 1214a63..41598c4 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -279,6 +279,22 @@ for partition_set in $partition_sets; do
 			eval "${create_file_system_cmd} ${decrypted_part}"
 			log_end_msg
 		;;
+		"format-if-empty")
+			# Check if first 10MiB contain only zeros
+			if cmp -s -n "$(( 10 * 1024 * 1024 ))" "${part_device}" /dev/zero
+			then
+				log_begin_msg "Encryption of ${part_device}"
+				/usr/sbin/cryptsetup luksFormat --batch-mode \
+					 --type luks2 "$part_device" < "$tmp_key"
+				enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_=
algorithm" "$pcr_bank_hash_type"
+				open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
+				eval "${create_file_system_cmd} ${decrypted_part}"
+				log_end_msg
+			else
+				# If not empty, leave it alone.
+				continue
+			fi
+		;;
 		*)
 			panic "Unknown value ${partition_format}. Cannot create a encrypted p=
artition !"
 		;;
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_=
0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.=
bb
index df335c9..c9a7f89 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
@@ -41,7 +41,7 @@ HOOK_ADD_MODULES =3D " \
=20
 HOOK_COPY_EXECS =3D " \
     openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint=
 \
-    e2fsck resize2fs cryptsetup \
+    e2fsck resize2fs cryptsetup cmp \
     tpm2_pcrread tpm2_testparms tpm2_flushcontext \
     /usr/lib/*/libgcc_s.so.1"
=20
--=20
2.39.5


