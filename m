Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE8C44515
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 07:46:59 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8709.1784274414893653346
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 00:46:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=iME+4apE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2026071707465045b8b9ad3d0002070b-fufumy@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026071707465045b8b9ad3d0002070b
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Jul 2026 09:46:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=y9cTky6HgW8JZcCK63ROWlLFKOnKnW0VCP5Q2BBg87I=;
 b=iME+4apEtAESvP2u4EveqeFKkyuopD4Dm7cvuHVSYdKF/IMuaxaXJLoSYdK8OjE1V5Lgk8
 P51Q0R8lgtTzvfMyoPHn+nffKOrY4eaf1gcPKyWoMtONmSWfwIwrQ/RD2hpHn2lf9iFdAMLT
 9t5ZJNfSFLtdOlGGFzkFWBXaj3uioXrApdrPBDkAnAo4m4cI3zuxQsUOTuPEikRsKF+TbCOE
 Z4E9qXAFwr4jDC/SjUpTreFodUKP51EGIOFAkBUUB0z85JnBqYdTiQ/i7j5OBmn2L26QrcDa
 lVtPllCyq3SAK2CMplxli7UJM06+hJKpRPCWniCap/tnawz87gNVo1tg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 2/3] initramfs-crypt-hook: suppress stderr log from cryptsetup
Date: Fri, 17 Jul 2026 09:45:31 +0200
Message-ID: <20260717074650.1281229-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260716130816.1095792-2-Quirin.Gylstorff@siemens.com>
References: <20260716130816.1095792-2-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 07:46:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23627

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

LuksDump prints additional information to stderr on Debian Sid,
this information is not necessary for the grep command. Suppress
the messages to avoid cluttering the boot log.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
    - Added other calls of luksDump. These are only visible if the
      image is started a second time
 .../initramfs-crypt-hook/files/local-bottom-complete      | 2 +-
 .../initramfs-crypt-hook/files/local-top-complete         | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
index 120ac29..0821566 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
@@ -75,7 +75,7 @@ for partition_set in $partition_sets; do
 		continue
 	fi
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
-			| grep -q "luks2"; then
+			2>/dev/null | grep -q "luks2" ; then
 		mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
 	else
 		mount_partition "$part_device" "$rootmnt""$partition_mountpoint"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 397b315..58f82db 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -124,7 +124,7 @@ reencrypt_existing_partition() {
 	luks)
 		# Check if reencrypt was aborted
 		if /usr/sbin/cryptsetup luksDump --batch-mode "$1" \
-				| grep -q "online-reencrypt-v2"; then
+				2>/dev/null | grep -q "online-reencrypt-v2"; then
 			/usr/sbin/cryptsetup repair --batch-mode "$1" < "$2" || \
 				panic "cryptsetup repair was not successful"
 		fi
@@ -274,7 +274,7 @@ for partition_set in $partition_sets; do
 	# If partition is already encrypted, decrypt and continue with next partition:
 	decrypted_part=/dev/mapper/"$crypt_mount_name"
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
-			| grep -q "systemd-tpm2\|clevis"; then
+			2>/dev/null | grep -q "systemd-tpm2\|clevis"; then
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 
 		# check if we are trying to mount root, set ROOT to decrypted partition:
@@ -287,7 +287,7 @@ for partition_set in $partition_sets; do
 
 	# If partition contains an aborted reencrypt luks header, switch to reencrypt mode:
 	if /usr/sbin/cryptsetup luksDump --batch-mode "${part_device}" \
-			| grep -q "online-reencrypt-v2"; then
+		2>/dev/null | grep -q "online-reencrypt-v2"; then
 		partition_format="reencrypt"
 	fi
 
@@ -337,7 +337,7 @@ for partition_set in $partition_sets; do
 			# header, but no TPM2 token
 			if cmp -s -n "$(( 10 * 1024 * 1024 ))" "${part_device}" /dev/zero || \
 				( [ "$(get_fstype "${part_device}")" = "luks" ] && \
-				! ( /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" |
+				! ( /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" 2>/dev/null |
 					grep -q "systemd-tpm2\|clevis" ) )
 			then
 				log_begin_msg "Encryption of ${part_device}"
-- 
2.53.0


