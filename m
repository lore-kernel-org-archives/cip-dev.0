Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061A8D167F4
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 09:50:57 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6907.1767952245190713147
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 01:50:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=fs2RTNf1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1330684-20260109095041a38649eaea00020781-didzuc@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260109095041a38649eaea00020781
        for <cip-dev@lists.cip-project.org>;
        Fri, 09 Jan 2026 10:50:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=S8jd2Hm6+4wPioSa5PRTyKDlaZ0T1OIRm2h4tV214/8=;
 b=fs2RTNf1Nraa03z1Fs9/H+u8rWh9dFnx5uETkJQlx8sjdTS3nn5R7IeCfRNMm95sud/qJg
 vW64rBpEevTgbfBP9aVIlODicytyTaCzCpwnusLp37RmUFL3G34PZLzByLBnmxS0DsxbKZ9/
 bQU3dnfdyD1BTPmjAEtoACcrxoCh/2a1uQC0IMFHNF4q7WKP/UYz5qrfSGXINEBDD5pxIWyh
 uMNnTSuBduoGw4O8xhd3ljJLJDSK4r8++DVY1cC6KYf8rb+3l9Ez6MoM3hFQfBWalxvvMC7V
 92yMhlmy5et8EaIIxDd6AEqMAgNzYqBX/nsNpQSHY74qDA0nwAY0ar8A==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH] wic: Unify /var partition handling
Date: Fri,  9 Jan 2026 10:50:39 +0100
Message-ID: <20260109095039.29617-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 09:50:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21492

From: Alexander Heinisch <alexander.heinisch@siemens.com>

This allows changing the fstype as well as additional parameters
used to create the partition depending on configuration more easily.

This simplifies the implementation of possible update strategies
for the A/B support for persistent /var

This patch unifies the slightly varying partition specs for /var in
*-efibootguard.wkis.in files

Main difference was:
1.) --size vs --fixed-size
    Probably the most critical change.
    I assume as we ship empty /var --fixed-size is the desired option to put.
2.) --fixed-size 2G vs --fixed-size 512M
    as we ship empty /var there is no need to create a 2GB partition image
3.) removal of --exclude-path boot/
    this seems to be a copy/paste error from 928209ae423fcf7a658e91be2b1e39ee32b5227c

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass         | 3 +++
 wic/bbb-efibootguard.wks.in                     | 2 +-
 wic/de0-nano-soc-efibootguard.wks.in            | 2 +-
 wic/hihope-rzg2m-efibootguard.wks.in            | 2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in   | 2 +-
 wic/qemu-arm64-efibootguard.wks.in              | 2 +-
 wic/qemu-riscv64-efibootguard.wks.in            | 2 +-
 wic/ti-am62px-sk-efibootguard-secureboot.wks.in | 3 +--
 wic/ti-am62px-sk-efibootguard.wks.in            | 3 +--
 wic/x86-uefi-efibootguard-secureboot.wks.in     | 2 +-
 wic/x86-uefi-efibootguard.wks.in                | 2 +-
 11 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-only-rootfs.bbclass
index 81e747c..a67bb5f 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -17,6 +17,9 @@ do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
 WIC_HOME_PARTITION = ""
 WIC_HOME_PARTITION:separate-home-part = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524"
 
+WIC_VAR_PARTITION_FSTYPE ??= "ext4"
+WIC_VAR_PARTITION ??= "part /var --fstype=${WIC_VAR_PARTITION_FSTYPE} --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153"
+
 IMAGE_INSTALL += " move-homedir-var"
 IMAGE_INSTALL:append:separate-home-part = " home-fs"
 IMAGE_INSTALL:remove:separate-home-part = " move-homedir-var"
diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index 474105a..6883579 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -16,6 +16,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var --fstype=ext4 --label var --align 1024  --size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
+${WIC_VAR_PARTITION}
 
 bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
diff --git a/wic/de0-nano-soc-efibootguard.wks.in b/wic/de0-nano-soc-efibootguard.wks.in
index 906aa72..f010853 100644
--- a/wic/de0-nano-soc-efibootguard.wks.in
+++ b/wic/de0-nano-soc-efibootguard.wks.in
@@ -15,6 +15,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var --fstype=ext4 --label var --align 1024  --size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
+${WIC_VAR_PARTITION}
 
 bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
index 9df0de5..fdbad14 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 7e20a7d5-5578-4ced-a7f1-5ee494dbaf72
+${WIC_VAR_PARTITION}
 
 bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index 261a25f..941a552 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -5,6 +5,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
+${WIC_VAR_PARTITION}
 
 bootloader --ptable gpt --append="panic=5"
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index 4b270a6..21c0b24 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
+${WIC_VAR_PARTITION}
 
 bootloader --ptable gpt
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
index ca12b5c..948c67d 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var --fstype=ext4 --label var --align 1024  --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
+${WIC_VAR_PARTITION}
 
 bootloader --ptable gpt
diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
index fb21cd0..c777a6b 100644
--- a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
+++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
@@ -16,8 +16,7 @@ include ebg-signed-sysparts.inc
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
-# var and optional home are extra partitions
-part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
 ${WIC_HOME_PARTITION}
+${WIC_VAR_PARTITION}
 
 bootloader --ptable gpt-hybrid --timeout=0 --append "rootwait rw console=ttyS2,115200n8"
diff --git a/wic/ti-am62px-sk-efibootguard.wks.in b/wic/ti-am62px-sk-efibootguard.wks.in
index b6976ee..5137c66 100644
--- a/wic/ti-am62px-sk-efibootguard.wks.in
+++ b/wic/ti-am62px-sk-efibootguard.wks.in
@@ -16,8 +16,7 @@ include ebg-sysparts.inc
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
-# var and optional home are extra partitions
-part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9 --exclude-path boot/
 ${WIC_HOME_PARTITION}
+${WIC_VAR_PARTITION}
 
 bootloader --ptable gpt-hybrid --timeout=0 --append "rootwait rw console=ttyS2,115200n8"
diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
index 3e141e7..2af3e58 100644
--- a/wic/x86-uefi-efibootguard-secureboot.wks.in
+++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
@@ -5,6 +5,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
+${WIC_VAR_PARTITION}
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
index cc317f0..3640ecf 100644
--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -9,6 +9,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
+${WIC_VAR_PARTITION}
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "
-- 
2.47.3


