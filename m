Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDB9C25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:10:06 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.8547.1716970197684303915
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:09:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=NUr2xSE6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-2024052908095459d3caa2353ad03066-hic8em@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024052908095459d3caa2353ad03066
        for <cip-dev@lists.cip-project.org>;
        Wed, 29 May 2024 10:09:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=bEzudaeBtLBhD8m4bzbZp6CyX+1Po00VrKlJL283ABc=;
 b=NUr2xSE6KtnXAhkRhUD1a2W5K8ec5b3wBvnq4l7HxET+xbe9hLxS+bo/q6WcBv2sywtnqG
 SIgFLtwmM3YoPN5kdCXEbYnZeFfkOsW/Y4uw6B5oOAG0PtcryKzt8JfEyn+7U+DYyUPcKi4N
 7GR3ngXa7O3kFNNRK9R2yB5l0QdTM=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	cip-security@lists.cip-project.org,
	schilling.benjamin@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2] Enable secureboot and tpm2 encryption for generic x86
Date: Wed, 29 May 2024 10:08:26 +0200
Message-ID: <20240529080954.1080468-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:10:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15979

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to build generic x86 targets with disk encryption
and secure boot.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - add section about ebg-secure-boot-signer

 Kconfig                       |  6 +++---
 doc/README.secureboot.md      | 30 ++++++++++++++++++++++++++++++
 doc/README.tpm2.encryption.md | 12 ++++++++++++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Kconfig b/Kconfig
index 334b5c6..364a84e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -190,7 +190,7 @@ endchoice
 
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
 
 config KAS_INCLUDE_SWUPDATE_SECBOOT
 	string
@@ -203,13 +203,13 @@ config KAS_INCLUDE_DELTA_UPDATE
 
 config IMAGE_DATA_ENCRYPTION
 	bool "Encrypt data partitions on first boot"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
 	help
 	  This enables LUKS encryption for the partitions /var and /home.
 
 config IMAGE_FULL_ENCRYPTION
 	bool "Encrypt rootfs and data partitions"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
 	select IMAGE_DATA_ENCRYPTION
 	help
 	  This enables LUKS encryption for all non-boot partitions on first boot.
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index e93266d..f0c46ca 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -290,3 +290,33 @@ sda              8:0    0     6G  0 disk
 ├─sda6           8:6    0   1.3G  0 part  /home
 └─sda7           8:7    0   2.6G  0 part  /var
 ```
+
+## Secure boot on Generic UEFI x86
+
+Secureboot for a generic UEFI x86 target works similar to the QEMU target,
+except the enrollment of the secure boot keys.
+
+### Secure boot key enrollment
+
+> :exclamation:**IMPORTANT** This document is not for generating a Machine Owner Key(MOK).
+
+> :exclamation:**IMPORTANT** Enrollment of secure boot keys must occur
+> in a secure environment.
+
+The following keys need to be enrolled onto the device:
+ - The Platform Key (PK)
+ - The Key Exchange Key (KEK)
+ - Allowed Signatures Database
+
+The enrollment must occur according to the manual of the UEFI Firmware.
+
+Use the recipes [secure-boot-key](###secure-boot-key) to provided the keys
+to the signing script contained in
+[ebg-secure-boot-signer](###ebg-secure-boot-signer).
+
+### [ebg-secure-boot-signer](./recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb)
+
+During building a efibootguard based wic image the scripts contained in
+the recipe ebg-secure-boot-signer can be used to sign the bootloader and
+unified kernel image(UKI). If the keys are stored in a HSM the script can
+be exchanged to sign the artifacts in a more secure way.
diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 7dc97c0..3f7e89f 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -82,3 +82,15 @@ if [ -n "$keyslot" ]; then
   systemd-cryptenroll --tpm2-device="$tpm_device" --tpm2-pcrs=7 "$device"
 fi
 ```
+# TPM2 based encryption on generic x86
+
+For a generic x86 platform with TPM2  module the build can be started with:
+
+```bash
+kas-container menu
+```
+
+The TPM2 module should support:
+ - a sha256 pcr bar with the ecc algorithm.
+
+If only a sha1 pcr bar is avaiable the variable `CRYPT_HASH_TYPE` needs to be set to `sha1`.
-- 
2.43.0


