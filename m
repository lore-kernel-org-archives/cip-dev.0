Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56560C25B7C
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 15:54:43 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.25858.1716911680093801800
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 08:54:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=ENuNTH4q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2024052815543556d594e9424bfed2d2-mfdwsn@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024052815543556d594e9424bfed2d2
        for <cip-dev@lists.cip-project.org>;
        Tue, 28 May 2024 17:54:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=VsKxt9+J62TDAPsv3WfUh9Z3MHBEnpBe7ieedzabnjg=;
 b=ENuNTH4qK30nEjS1UyA/H5f8T3bKTHk3OUWFYbOT4xsDGNKVYg3Icwxgz0/Rq2398w8zDe
 q3OwSCpthNgfV8JW9+jtKrtIeTCF6hgt0TCpFT3l0NgSGWFLyvWTsf9Qd68AEIEFhhU31R42
 KsEjfQvxoz0lhPchzOg9vEQHoG8bc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC] enable secureboot and tpm2 encryption for generic x86
Date: Tue, 28 May 2024 17:51:44 +0200
Message-ID: <20240528155435.925718-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 15:54:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15972

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to build generic x86 targets with disk encryption
and secure boot.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

 Kconfig                       |  6 +++---
 doc/README.secureboot.md      | 19 +++++++++++++++++++
 doc/README.tpm2.encryption.md | 12 ++++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

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
index e93266d..13e4512 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -290,3 +290,22 @@ sda              8:0    0     6G  0 disk
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


