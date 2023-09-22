Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DF8E7D0D2
	for <webhook@archiver.kernel.org>; Fri, 22 Sep 2023 06:49:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.16025.1695365349926894327
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Sep 2023 23:49:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 38M6n7Pm700411; Fri, 22 Sep 2023 15:49:07 +0900
X-Iguazu-Qid: 2rWgDRdQ1droMQeTWl
X-Iguazu-QSIG: v=2; s=0; t=1695365346; q=2rWgDRdQ1droMQeTWl; m=GApAch7D9wLW4gn7MXGqqLbbQ7VrriGp82jNP8AG3kc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 38M6n5w83935305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 22 Sep 2023 15:49:06 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] wic: Use fixed UUID values for the partitions
Date: Fri, 22 Sep 2023 12:19:04 +0530
X-TSB-HOP2: ON
Message-Id: <20230922064904.11232-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Sep 2023 06:49:03.0844 (UTC) FILETIME=[E0166240:01D9ED20]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Sep 2023 06:49:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13206

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

To generated images reproducibly it should assign with fixed UUID
values.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 wic/ebg-signed-sysparts.inc | 6 +++---
 wic/hihope-rzg2m.wks        | 4 ++--
 wic/iwg20m.wks              | 4 ++--
 wic/simatic-ipc227e.wks     | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
index 2d4d0e3..b2340e2 100644
--- a/wic/ebg-signed-sysparts.inc
+++ b/wic/ebg-signed-sysparts.inc
@@ -1,8 +1,8 @@
 # default partition layout EFI Boot Guard usage, signed version
 
 # EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcba
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh"
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbb
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbc
diff --git a/wic/hihope-rzg2m.wks b/wic/hihope-rzg2m.wks
index c0a9f77..fd3a338 100644
--- a/wic/hihope-rzg2m.wks
+++ b/wic/hihope-rzg2m.wks
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0
+part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba
 
 # Rootfs partition
-part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active
+part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
diff --git a/wic/iwg20m.wks b/wic/iwg20m.wks
index 14bf8b0..85765f0 100644
--- a/wic/iwg20m.wks
+++ b/wic/iwg20m.wks
@@ -12,7 +12,7 @@
 # [Note] u-boot runs from an SPI memory device
 
 # SDCard Boot partition (copies files in IMAGE_BOOT_FILES: zImage and device tree)
-part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0
+part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba
 
 # Rootfs partition
-part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active
+part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
diff --git a/wic/simatic-ipc227e.wks b/wic/simatic-ipc227e.wks
index 9044e0f..1a44e26 100644
--- a/wic/simatic-ipc227e.wks
+++ b/wic/simatic-ipc227e.wks
@@ -6,8 +6,8 @@
 # SPDX-License-Identifier: MIT
 #
 
-part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024
+part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba
 
-part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid
+part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --timeout 2 --append "console=ttyS0,115200"
-- 
2.20.1



