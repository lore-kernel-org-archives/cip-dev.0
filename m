Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91616C77B75
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 18:50:52 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.14355.1684819161048828539
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 May 2023 22:19:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=MRKy7Bhm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-72506-2023052305191833aeb03f1c96cf9546-_4yjvi@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023052305191833aeb03f1c96cf9546
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 May 2023 07:19:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2GkpkKncNUXTWU+DLTkdhX3Ret6lXSOL0TUR47Uf6O0=;
 b=MRKy7BhmMQw6PCQlICghVeFqZbckX/KhK2dHLoGTOoYFN2EofGgQh2pmBuhjvcywSdipw1
 es4/SDDm/y4KslAwLJTQSrcbj2VKfEFlx6hYik8DjTkdTqNVKYYaCD333xxGTYtkPhcIZ2os
 asSxpq3MIDn0eujpr2+N3WH/djPUc=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	meng.ding@siemens.com,
	chengshu.mou@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 3/3] docs(secureboot): make markdown better readable
Date: Tue, 23 May 2023 13:18:46 +0800
Message-Id: <20230523051846.1007400-4-felix.moessbauer@siemens.com>
In-Reply-To: <20230523051846.1007400-1-felix.moessbauer@siemens.com>
References: <20230523051846.1007400-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 18:50:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11620

This patch adds the language annotations to all code blocks to enable
code highlighting. In addition, code blocks are surrounded by newlines
to make it better readable in the non-rendered version.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 doc/README.secureboot.md | 54 ++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 797e913..6546095 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -103,18 +103,23 @@ execute the script `scripts/generate_secure_boot_keys.sh`
 ##### Add Keys to OVMF
 1. Create a folder and copy the generated keys and KeyTool.efi
 (in Debian the file can be found at: /lib/efitools/x86_64-linux-gnu/KeyTool.efi) to the folder
-```
+
+```bash
 mkdir secureboot-tools
 cp -r keys secureboot-tools
 cp /lib/efitools/x86_64-linux-gnu/KeyTool.efi secureboot-tools
 ```
+
 2. Copy the file OVMF_VARS_4M.fd (in Debian the file can be found at /usr/share/OVMF/OVMF_VARS_4M.fd)
 to the current directory. OVMF_VARS_4M.fd contains no keys can be instrumented for secureboot.
 3. Start QEMU with the script scripts/start-efishell.sh
-```
+
+```bash
 ./scripts/start-efishell.sh secureboot-tools
 ```
+
 4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the following steps:
+
 ```
           -> "Edit Keys"
              -> "The Allowed Signatures Database (db)"
@@ -130,6 +135,7 @@ to the current directory. OVMF_VARS_4M.fd contains no keys can be instrumented f
                 -> Change/Confirm device
                 -> Select "demoPK.auth" file
 ```
+
 5. quit QEMU
 
 ### Build image
@@ -137,12 +143,13 @@ to the current directory. OVMF_VARS_4M.fd contains no keys can be instrumented f
 Build the image with a signed EFI Boot Guard and unified kernel image
 with the snakeoil keys by executing:
 
-```
+```bash
 kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-secure-boot-snakeoil.yml
 ```
 
 For user-generated keys, create a new option file in the repository. This option file could look like this:
-```
+
+```yaml
 header:
   version: 12
   includes:
@@ -178,7 +185,7 @@ need to stored in the folder `recipes-devtools/ebg-secure-boot-secrets/files`.
 
 Build the image with user-generated keys by executing the command:
 
-```
+```bash
 kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:<path to the new option>.yml
 ```
 
@@ -187,7 +194,8 @@ kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:<path to the new option
 #### Debian snakeoil
 
 Start the image with the following command:
-```
+
+```bash
 SECURE_BOOT=y \
 ./start-qemu.sh amd64
 ```
@@ -195,13 +203,14 @@ SECURE_BOOT=y \
 The image configuration menu will set default values for start-qemu.sh for secureboot
 and the following command is sufficient:
 
-```
+```bash
 ./start-qemu.sh amd64
 ```
 
 #### User-generated keys
 Start the image with the following command:
-```
+
+```bash
 SECURE_BOOT=y \
 OVMF_CODE=./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd \
 OVMF_VARS=<path to the modified OVMF_VARS.fd> \
@@ -209,12 +218,15 @@ OVMF_VARS=<path to the modified OVMF_VARS.fd> \
 ```
 
 After boot check the dmesg for secure boot status like below:
-```
+
+```bash
 root@demo:~# dmesg | grep Secure
 [    0.008368] Secure boot enabled
 ```
+
 In case of arm64 or armhf architectures, the secure boot status can be found in bootloader logs like below:
-```
+
+```bash
 EFI stub: UEFI Secure Boot is enabled.
 ```
 ## Example: Update the image
@@ -223,19 +235,26 @@ For updating the image, the following steps are necessary:
 - [Build the image with snakeoil keys](#build-image)
 - save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` to /tmp
 - modify the image for example, switch to the RT kernel as modification:
-```
+
+```bash
 kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-secure-boot-snakeoil.yml:kas/opt/rt.yml
 ```
+
 - start the new target
-```
+
+```bash
 SECURE_BOOT=y ./start-qemu.sh amd64
 ```
+
 Copy the swu cip-core-image-cip-core-bullseye-qemu-amd64.swu to the running system
-```
+
+```bash
 scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@127.0.0.1:/home/
 ```
+
 - check which partition is booted, e.g. with `lsblk`:
-```
+
+```bash
 root@demo:~# lsblk
 NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
 sda              8:0    0     6G  0 disk
@@ -250,12 +269,15 @@ sda              8:0    0     6G  0 disk
 ```
 
 - install the swupdate and reboot the image
-```
+
+```bash
 root@demo:~# swupdate -i /home/cip-core-image-cip-core-bullseye-qemu-amd64.swu`
 root@demo:~# reboot
 ```
+
 - check which partition is booted, e.g. with `lsblk`. The rootfs should have changed:
-```
+
+```bash
 root@demo:~# lsblk
 NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
 sda              8:0    0     6G  0 disk
-- 
2.39.2


