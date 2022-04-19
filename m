Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D554BC41535
	for <webhook@archiver.kernel.org>; Tue, 19 Apr 2022 17:48:47 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web08.1386.1650384423096306932
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Apr 2022 09:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=YTp5mAxz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-202204191607000454c1885a44a1b843-_nae1q@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202204191607000454c1885a44a1b843
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Apr 2022 18:07:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=y9bXgGbX7OOtVx4/jJlQhNL49cgsnyBtrqxmMwkr1/g=;
 b=YTp5mAxzdzYaEeuN8/XZS9sQYxF4XmRW/j4u6eeQ6pVOIiTVfPKpdRyCC18nqDNY0kgG/T
 nRruN5mFe/R3CQcWTIhRUJ2fvU0EEJ+6GpHDWmU7T45bpj4aNfDuEyuwpPw9RrIRVks7oOVk
 fAkxvY/yS4RJOoQGZLVyxVeG9PXJs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 5/5] wic: Drop redundant / misleading --ondisk
 sda parameters
Date: Tue, 19 Apr 2022 18:06:58 +0200
Message-Id: 
 <550de78f33624ba99dfc9eaf32e3f419faae39e0.1650384418.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650384418.git.jan.kiszka@siemens.com>
References: <cover.1650384418.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Apr 2022 17:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8108

From: Jan Kiszka <jan.kiszka@siemens.com>

First, sda is the default anyway. But, more importantly, we do not need
this parameter in these cases as we either mount by label/uuid or do not
mount at all (EBG partitions).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 wic/ebg-signed-bootloader.inc                 |  2 +-
 wic/ebg-sysparts.inc                          |  6 +++---
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 12 ++++++------
 wic/simatic-ipc227e.wks                       |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/wic/ebg-signed-bootloader.inc b/wic/ebg-signed-bootloader.inc
index 667e014..62ebca9 100644
--- a/wic/ebg-signed-bootloader.inc
+++ b/wic/ebg-signed-bootloader.inc
@@ -1,2 +1,2 @@
 # EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
index 18c879a..9b2c879 100644
--- a/wic/ebg-sysparts.inc
+++ b/wic/ebg-sysparts.inc
@@ -1,8 +1,8 @@
 # default partition layout EFI Boot Guard usage
 
 # EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active
+part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2"
-part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1"
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2"
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1"
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index c47257b..54f7143 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -2,14 +2,14 @@
 include ebg-signed-bootloader.inc
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh"
-part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh"
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --ondisk sda --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --ondisk sda --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --ondisk sda --fstype=ext4 --label home --align 1024  --size 1G
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --ondisk sda --fstype=ext4 --label var --align 1024  --size 2G
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
+part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait rw earlyprintk"
diff --git a/wic/simatic-ipc227e.wks b/wic/simatic-ipc227e.wks
index d0081f7..9044e0f 100644
--- a/wic/simatic-ipc227e.wks
+++ b/wic/simatic-ipc227e.wks
@@ -6,8 +6,8 @@
 # SPDX-License-Identifier: MIT
 #
 
-part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --ondisk sda --label efi --part-type EF00 --align 1024
+part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024
 
-part / --source rootfs --ondisk sda --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid
+part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid
 
 bootloader --ptable gpt --timeout 2 --append "console=ttyS0,115200"
-- 
2.34.1


