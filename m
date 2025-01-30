Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180C7C0219A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:29 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.12052.1738229961373325279
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=RZmgv1yr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20250130093919afc18517eda4f21690-3ytw5z@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250130093919afc18517eda4f21690
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 10:39:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=WgU8HNT4wbOLgbvzNe4r7IOVD5zLpkzdKo17O8TBwQ4=;
 b=RZmgv1yrwd6FTWvIXm75+7fbobw3RMLHiacAvMVha0Ni/WdQe/pocM/U521PoEu9EWhy39
 hSJw2mpSRqCFLHqJtgsUDOS9GAA23pSNsfC0s4hf80Ye5Vat6Vh39hPUlHzd0gbUpGkmpQ8g
 Wz20o/GAFY5+EIYGp4V/A3gntT6Qjrdxwg58eNPeSFmvM/1Q8+UDUozj0aP3p9g0E1s/87Mi
 AbINIQtzp6T8DOnFwcJG1+u0w5spxU4M6CC7qKEroZKEDeG0za3kZEaY0glcdwqLiCesn+VA
 ILFoEzYBJFt5Br8UgrCuVMuZVm2FsO+sJi2NiR/IGO8/crlbLcIbLqSQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC][PATCH 08/10] swupdate: Make var filesystem type configurable for update images
Date: Thu, 30 Jan 2025 10:39:15 +0100
Message-ID: <15504c79cbd009779ff184606cb8778cf53578dd.1738229957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1738229957.git.jan.kiszka@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:39:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17701

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to switch to var filesystem type to something else than ext4
which will be needed when enabling A/V snapshots for it. Default remains
ext4.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/swupdate.bbclass                      | 1 +
 kas/opt/swupdate.yml                          | 1 +
 wic/bbb-efibootguard.wks.in                   | 2 +-
 wic/hihope-rzg2m-efibootguard.wks.in          | 2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in | 2 +-
 wic/qemu-arm64-efibootguard.wks.in            | 2 +-
 wic/qemu-riscv64-efibootguard.wks.in          | 2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in   | 2 +-
 wic/x86-uefi-efibootguard.wks.in              | 2 +-
 9 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 05291ee9..213a8ffb 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -61,6 +61,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
     TARGET_IMAGE_UUID \
     ABROOTFS_PART_UUID_A \
     ABROOTFS_PART_UUID_B \
+    VAR_FS_TYPE \
     SWU_HW_COMPAT_NODE \
     SWU_COMPRESSION_NODE \
     SWU_VERSION \
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 38dc3907..c5c5a56a 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -29,6 +29,7 @@ local_conf_header:
     INITRAMFS_INSTALL:append = " initramfs-${RO_ROOTFS_TYPE}-hook"
     ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
+    VAR_FS_TYPE ??= "ext4"
     PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
     PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
     PREFERRED_PROVIDER_swupdate-signer ??= "swupdate-signer-cms"
diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index e6c3e158..6effa523 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -16,6 +16,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var --fstype=${VAR_FS_TYPE} --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
index fb3f090a..2305262f 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -9,6 +9,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 # home and var are extra partitions
 
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var --fstype=${VAR_FS_TYPE} --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index 00d627d0..98398e67 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -5,6 +5,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var  --fstype=${VAR_FS_TYPE} --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="panic=5"
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index 17434d15..bf0bb82b 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var --fstype=${VAR_FS_TYPE} --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
index 1a2291e3..2acb2f9a 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --fstype=ext4 --label var --align 1024  --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var --fstype=${VAR_FS_TYPE} --label var --align 1024  --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt
diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
index 0f4d6374..fe0f7cc5 100644
--- a/wic/x86-uefi-efibootguard-secureboot.wks.in
+++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
@@ -5,6 +5,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var  --fstype=${VAR_FS_TYPE} --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
index 9d344f8a..5eab54cf 100644
--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -9,6 +9,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 # home and var are extra partitions
 
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var --fstype=${VAR_FS_TYPE} --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "
-- 
2.43.0


