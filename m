Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCEBFD8FD2
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 16:08:51 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73663.1772122123090681465
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 08:08:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=BVXkszQU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1330684-20260226160840edb0dd06f3000207bc-ixn1pe@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260226160840edb0dd06f3000207bc
        for <cip-dev@lists.cip-project.org>;
        Thu, 26 Feb 2026 17:08:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IZ/VVCUcv4WfezphOphX/c9BqjaQj1RawUHh4hti+VA=;
 b=BVXkszQUIZJ29lo+NCe/w9cyQyNk+Go3y2kSqmLwQqSb+0uoI0Ekzc0M8mKlVv2huBrx39
 JkjRojmzHM+wDTa745TXacEErAi3QDmAQ2fsm/hF0FNHr6Rf+xzQq2k5MrBO+iHU2UhuJF+a
 OGpsgxbN5WQphVmwylAcExEB3C9trTNQWXnyTYx03jx1SJLWs+A2+6R4cIakIkjDsZhm5yCt
 al0WU/1HZKg5nC1fcx3+2i8/dF5D0OpuzQhRItTOL4P05iYYb/SJ68mQWnqefuGl9Z6asBGM
 5e20uOW6NtKJ5z4J4c0qTtkBWNYyY1K4kAr56HPWZwgCvgtZwhyqOlYg==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] wic: Added support to set sourceparams for empty root-B partition.
Date: Thu, 26 Feb 2026 17:08:36 +0100
Message-ID: <20260226160837.1107096-2-alexander.heinisch@siemens.com>
In-Reply-To: <20260226160837.1107096-1-alexander.heinisch@siemens.com>
References: <20260226160837.1107096-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 16:08:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21994

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 wic/bbb-efibootguard.wks.in                     | 2 +-
 wic/beaglev-fire-efibootguard.wks.in            | 2 +-
 wic/de0-nano-soc-efibootguard.wks.in            | 2 +-
 wic/hihope-rzg2m-efibootguard.wks.in            | 2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in   | 2 +-
 wic/qemu-arm64-efibootguard.wks.in              | 2 +-
 wic/qemu-riscv64-efibootguard.wks.in            | 2 +-
 wic/ti-am62px-sk-efibootguard-secureboot.wks.in | 2 +-
 wic/ti-am62px-sk-efibootguard.wks.in            | 2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in     | 2 +-
 wic/x86-uefi-efibootguard.wks.in                | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index 6883579..b6d19ba 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -12,7 +12,7 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-
 include ebg-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
diff --git a/wic/beaglev-fire-efibootguard.wks.in b/wic/beaglev-fire-efibootguard.wks.in
index f24b53c..0274745 100644
--- a/wic/beaglev-fire-efibootguard.wks.in
+++ b/wic/beaglev-fire-efibootguard.wks.in
@@ -11,7 +11,7 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/beaglev-fire/payload.
 include ebg-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
diff --git a/wic/de0-nano-soc-efibootguard.wks.in b/wic/de0-nano-soc-efibootguard.wks.in
index f010853..a1c1108 100644
--- a/wic/de0-nano-soc-efibootguard.wks.in
+++ b/wic/de0-nano-soc-efibootguard.wks.in
@@ -11,7 +11,7 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/de0-nano-soc/u-boot-w
 include ebg-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
index fdbad14..2865e8b 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -4,7 +4,7 @@
 include ebg-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index 941a552..2092d07 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -1,7 +1,7 @@
 include ebg-signed-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index 21c0b24..2ca607a 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -4,7 +4,7 @@
 include ebg-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
index 948c67d..6336398 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -4,7 +4,7 @@
 include ebg-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
index c777a6b..1e2f578 100644
--- a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
+++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
@@ -14,7 +14,7 @@ include ebg-signed-sysparts.inc
 
 # ABROOTFS partitions
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
diff --git a/wic/ti-am62px-sk-efibootguard.wks.in b/wic/ti-am62px-sk-efibootguard.wks.in
index 5137c66..d0c7ef4 100644
--- a/wic/ti-am62px-sk-efibootguard.wks.in
+++ b/wic/ti-am62px-sk-efibootguard.wks.in
@@ -14,7 +14,7 @@ include ebg-sysparts.inc
 
 # ABROOTFS partitions
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
index 2af3e58..c508656 100644
--- a/wic/x86-uefi-efibootguard-secureboot.wks.in
+++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
@@ -1,7 +1,7 @@
 include ebg-signed-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
index 3640ecf..df7d9ea 100644
--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -4,7 +4,7 @@
 include ebg-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 
 # var and optional home are extra partitions
-- 
2.47.3


