Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E1BC19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:30:50 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.11655.1740666647935740049
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:30:48 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=aTmD1TfB;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29DBA10382F22;
	Thu, 27 Feb 2025 15:30:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740666646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4q9vcKPc7/ZsUnkqDVld1fof18ktl9ABw86HP15PLuM=;
	b=aTmD1TfBjZclmSabFoQCpGKOT/TE5avx9FrWWUN650yOpwCnHOEM0yz2Mlglhydr6iKHj5
	N3lwRTOeAPd2IOXEpqFlCvLk7x9/bQAJ1jakWLcAqUcnYVebFhwVDS/j/6XB1RA2agF8X3
	G4RHzJU9I8KElOfkr/hYAWKSOMisEArPpPoijvjjM2rX3y7Q6wmG5+faejvQNK0me2aXFL
	/vFLOHYn83zQF+5HhTBocn58s2IVsgOALVdUf4RNrnvqNEv2g7Uj3Ejic4fG54kYheeXCx
	GvJ+rN+xk35BpqPCBchmFwuW0ea+QLyY+utxNmaKiGNJXTis7GNaCGhPUuwvuA==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH v2 4/4] initramfs-crypt-hook: add re-encryption recovery
Date: Thu, 27 Feb 2025 15:30:22 +0100
Message-ID: <20250227143022.323950-5-ch@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227143022.323950-1-ch@denx.de>
References: <20250227143022.323950-1-ch@denx.de>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:30:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17945

Integrate detection and recovery of power failures while a partition is
being encrypted.

There are possible scenarios:
1. Power-fail happens while the partition is reencrypted:
  - The LUKS header contains `online-reencrypt-v2` and needs to be
    repaired with `cryptsetup repair` before it can continue.
  - Also no resizing of the file system is necessary
2. Power-fail happens before the systemd-tpm2 token can be installed
  - The LUKS header does not contain 'systemd-tpm2', thus it needs to be
    registered and the temporary encryption key needs to be removed

In both scenarios the system after the reboot needs to have access to
the temporary encryption key that was initially used. So using a random
one, generated via `openssl rand` is not possible. Since it is only a
temporary key and gets removed after the systemd-tpm2 token was
installed, a known password can be used.

The list of these scenarios is not complete, there might be other
instances where a sudden power-fail could be fatal to the system, but
these where the most obvious and risky ones.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 .../files/local-top-complete                  | 33 +++++++++++++++----
 .../initramfs-crypt-hook_0.6.bb               |  5 ++-
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-compl=
ete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 4b6451a..6034175 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -72,6 +72,9 @@ reencrypt_existing_partition() {
 	reduced_size=3D"$(expr "$part_size_blocks" - 65536 )"
 	reduced_size_in_byte=3D"$(expr "$reduced_size" \* 512)"
 	reduced_size_in_kb=3D"$(expr "$reduced_size_in_byte" / 1024)K"
+
+	CRYPTSETUP_PARAMS=3D"--reduce-device-size ${reduce_device_size}k"
+
 	case $partition_fstype in
 	ext*)
 		# reduce the filesystem and partition by 32M to fit the LUKS header
@@ -90,14 +93,25 @@ reencrypt_existing_partition() {
 	squashfs|swap|erofs|"")
 		[ "$debug" =3D "y" ] && echo "skip disk resize as it is not supported =
or unnecessary for fstype: '$partition_fstype'"
 		;;
+	luks)
+		# Check if reencrypt was aborted
+		if /usr/sbin/cryptsetup luksDump --batch-mode "$1" \
+				| grep -q "online-reencrypt-v2"; then
+			/usr/sbin/cryptsetup repair --batch-mode "$1" < "$2" || \
+				panic "cryptsetup repair was not successful"
+		fi
+
+		# already luks partition, don't resize
+		CRYPTSETUP_PARAMS=3D""
+		;;
 	*)
 		panic "cannot resize partition, unsupported fstype: '$partition_fstype=
'"
 		;;
 	esac
 	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
-		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_dev=
ice_size"k "$1" < "$2"
+		/usr/sbin/cryptsetup-reencrypt --new ${CRYPTSETUP_PARAMS} "$1" < "$2"
 	else
-		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce=
_device_size"k "$1" < "$2"
+		/usr/sbin/cryptsetup reencrypt --encrypt ${CRYPTSETUP_PARAMS} "$1" < "=
$2"
 	fi
 }
=20
@@ -219,7 +233,7 @@ for partition_set in $partition_sets; do
 	# If partition is already encrypted, decrypt and continue with next par=
tition:
 	decrypted_part=3D/dev/mapper/"$crypt_mount_name"
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
-			| grep -q "luks2"; then
+			| grep -q "systemd-tpm2"; then
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
=20
 		# check if we are trying to mount root, set ROOT to decrypted partitio=
n:
@@ -230,6 +244,12 @@ for partition_set in $partition_sets; do
 		continue
 	fi
=20
+	# If partition contains an aborted reencrypt luks header, switch to ree=
ncrypt mode:
+	if /usr/sbin/cryptsetup luksDump --batch-mode "${part_device}" \
+			| grep -q "online-reencrypt-v2"; then
+		partition_format=3D"reencrypt"
+	fi
+
 	# If partition should not be encrypted, continue with next partition:
 	if [ "$partition_format" =3D "noencrypt" ]
 	then
@@ -247,10 +267,11 @@ for partition_set in $partition_sets; do
 		watchdog_pid=3D$!
 	fi
=20
-	# create random password for initial encryption
-	# this will be dropped after reboot
+	# use partuuid of the partition for initial encryption password, this k=
ey
+	# will be removed after the reencryption has finished and the TPM2 toke=
n is
+	# registered:
 	tmp_key=3D/tmp/"$(basename "$part_device")-lukskey"
-	openssl rand -base64 32 > "$tmp_key"
+	lsblk -no partuuid "$part_device" > "$tmp_key"
=20
 	case "${partition_format}" in
 		"reencrypt")
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_=
0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.=
bb
index c9a7f89..5e82521 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
@@ -14,7 +14,6 @@ require recipes-initramfs/initramfs-hook/hook.inc
 DEBIAN_DEPENDS .=3D ", \
     cryptsetup, \
     awk, \
-    openssl, \
     e2fsprogs, \
     tpm2-tools, \
     coreutils, \
@@ -40,8 +39,8 @@ HOOK_ADD_MODULES =3D " \
     ecb aes_generic xts"
=20
 HOOK_COPY_EXECS =3D " \
-    openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint=
 \
-    e2fsck resize2fs cryptsetup cmp \
+    mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
+    e2fsck resize2fs cryptsetup cmp lsblk \
     tpm2_pcrread tpm2_testparms tpm2_flushcontext \
     /usr/lib/*/libgcc_s.so.1"
=20
--=20
2.47.2


