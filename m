Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0272BC352AA
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:07 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.3440.1649834201790323295
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=khttu8KY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-202204130716430c0da5d3fa0b062d83-ucxtq0@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 202204130716430c0da5d3fa0b062d83
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QjhILSWUFTGLOnXV8x7gQka8M+oclocTcR+QDf4/8T8=;
 b=khttu8KYfs3j7jWSTpNpPNziYeYpB/BpGyNihjrGpArX+ggSVXJGG372IPP9aDABxztd26
 +LJgS5eIbc/wBvLDeAA7pz4p17fQAyYIFExJ/6WUKhsZ/dGIzZxihoCj+aAHn8mk31O5+LMj
 +B1auqezIuxuJjAaXCltIs7/P91Ng=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 19/19] doc: README.secureboot polishing
Date: Wed, 13 Apr 2022 09:16:36 +0200
Message-Id: 
 <ad6cc6be1bd0d6703e8cc52a61c5a7a929605a48.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8066

From: Jan Kiszka <jan.kiszka@siemens.com>

There has never been a uefikernel parameter for efibootguard-boot, so
drop this.

Furthermore, spell-out "EFI Boot Guard" and adjust some section levels
and titles.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 doc/README.secureboot.md | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 3c2d524..b2d7be9 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -1,11 +1,11 @@
-# Efibootguard Secure boot
+# EFI Boot Guard secure boot
 
 This document describes how to generate a secure boot capable image with
 [efibootguard](https://github.com/siemens/efibootguard).
 
 ## Description
 
-The image build signs the efibootguard bootloader (bootx64.efi) and generates
+The image build signs the EFI Boot Guard bootloader (bootx64.efi) and generates
 a signed [unified kernel image](https://systemd.io/BOOT_LOADER_SPECIFICATION/).
 A unified kernel image packs the kernel, initramfs and the kernel command-line
 in one binary object. As the kernel command-line is immutable after the build
@@ -19,12 +19,12 @@ If a match is found the rootfs is used for the boot.
 
 ## Adaptation for Images
 
-###  WIC
+### WIC
 The following elements must be present in a wks file to create a secure boot capable image.
 
 ```
 part --source efibootguard-efi  --sourceparams "signwith=<script or executable to sign the image>"
-part --source efibootguard-boot --sourceparams "uefikernel=<name of the unified kernel>,signwith=<script or executable to sign the image>"
+part --source efibootguard-boot --sourceparams "signwith=<script or executable to sign the image>"
 ```
 
 #### Script or executable to sign the image
@@ -43,7 +43,6 @@ executable or script with the following interface:
 Supply the script name and path to wic by adding
 `signwith=<path and name of the script to sign>"` to sourceparams of the partition.
 
-
 ### Existing packages to sign an image
 
 #### ebg-secure-boot-snakeoil
@@ -63,7 +62,7 @@ The following variable and steps are necessary to build a secure boot capable im
 
 The files referred by SB_CERTDB and SB_VERIFY_CERT must be store in  `recipes-devtools/ebg-secure-boot-secrets/files/`
 
-## QEMU
+## Running in QEMU
 
 Set up a secure boot test environment with [QEMU](https://www.qemu.org/)
 
@@ -138,7 +137,7 @@ scripts/start-efishell.sh secureboot-tools
 
 ### Build image
 
-Build the image with a signed efibootguard and unified kernel image
+Build the image with a signed EFI Boot Guard and unified kernel image
 with the snakeoil keys by executing:
 
 ```
@@ -202,7 +201,8 @@ OVMF_CODE=./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd \
 OVMF_VARS=<path to the modified OVMF_VARS.fd> \
 ./start-qemu.sh amd64
 ```
-# Example: Update the image
+
+## Example: Update the image
 
 For updating the image, the following steps are necessary:
 - [Build the image with snakeoil keys](### Build image)
-- 
2.34.1


