Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFE8E7718A
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 10:39:30 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.149455.1734691163015808969
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Dec 2024 02:39:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=uZXTHszl;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202412201039196c92642e54d4c92b9c-reepmh@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202412201039196c92642e54d4c92b9c
        for <cip-dev@lists.cip-project.org>;
        Fri, 20 Dec 2024 11:39:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=IBHzrSiPxYG24XYpVPLmWStKJvrHtpMgdxtw+QAZqVY=;
 b=uZXTHszlYUOV9ZDXxZLHln2MfaI4UX5k22105VZ8aOvZTN2GtbrpciFR6SIWycgOcA9lgj
 6Pn/iC32id4gtMaRtYvXu2DIdOpl81W/TsqJViTTZX2g2ZoThAXJnwAcMF9b26i0Fk9QBLgW
 o6A0mrOMeBrxGbY7BMJqDArPf6dfvJRZoVSUwJMUfK9z7zhnTSkK+5MZA5D7HYFpm+qhta7n
 En/2dez5OvwD2WyHBDIUW8+v0IBKbWms5GymDl6SK6wTsTJX9omMBlolxzHwdN6TFzTEsDtv
 Z91XF7V9aDcPPAOB8yCEas3UQVClh0KWEAhXNuPnhOfY+h/wzrZdI4Pw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC] continue boot if not enough disk space for encryption is available.
Date: Fri, 20 Dec 2024 11:38:37 +0100
Message-ID: <20241220103918.1165341-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Dec 2024 10:39:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17484

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Encrypting a existing system with a full partition will lead to a panic
during resizing. To ensure the availability of the system continue booting
if the flag `CRYPT_ENCRYPTION_OPTIONAL` is set to true.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/local-top-complete     | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 834dea2..f86cade 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -79,7 +79,11 @@ reencrypt_existing_partition() {
 EOF
 		e2fsck -p -f "$1"
 		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
-			panic "reencryption of filesystem $1 cannot continue!"
+			if [ "$tpm_encryption_optional" = "true" ]; then
+				return 1
+			else
+				panic "reencryption of filesystem $1 cannot continue!"
+			fi
 		fi
 		;;
 	squashfs|swap|erofs|"")
@@ -94,6 +98,7 @@ EOF
 	else
 		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
 	fi
+	return 0
 }
 
 expand_partition() {
@@ -236,7 +241,9 @@ for partition_set in $partition_sets; do
 	case "${partition_format}" in
 		"reencrypt")
 			log_begin_msg "Encryption of ${part_device}"
-			reencrypt_existing_partition "$part_device" "$tmp_key"
+			if ! reencrypt_existing_partition "$part_device" "$tmp_key"; then
+				continue
+			fi
 			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
 			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 			log_end_msg
-- 
2.46.1


