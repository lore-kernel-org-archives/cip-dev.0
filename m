Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B636C47DDF
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 11:18:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.15798.1706613484340530990
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 03:18:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 40UBI1Jd3473757; Tue, 30 Jan 2024 20:18:02 +0900
X-Iguazu-Qid: 2yAbxkHIeMtA31a0IL
X-Iguazu-QSIG: v=2; s=0; t=1706613481; q=2yAbxkHIeMtA31a0IL; m=GYrFTqUkwEwdItHUbDjom37BoLIBDhns33L/hUjtZeA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 40UBI0ol872248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 30 Jan 2024 20:18:01 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v2] wic: Set fixed partition UUID values
Date: Tue, 30 Jan 2024 16:47:22 +0530
X-TSB-HOP2: ON
Message-Id: <20240130111722.1463101-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <8ee6a477e885307b180d216fd83ec4475247ac0a.camel@siemens.com>
References: <8ee6a477e885307b180d216fd83ec4475247ac0a.camel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Jan 2024 11:17:59.0294 (UTC) FILETIME=[FB4429E0:01DA536D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 11:18:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14490

This commit sets fixed partition uuid for partitions. The --uuid
option in wic allows to set fixed uuid for a partition. This is
required for generating reproducible images

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 README.md                                     | 1 +
 wic/bbb-efibootguard.wks.in                   | 4 ++--
 wic/bbb.wks                                   | 2 +-
 wic/ebg-signed-sysparts.inc                   | 6 +++---
 wic/ebg-sysparts.inc                          | 6 +++---
 wic/hihope-rzg2m-efibootguard.wks.in          | 4 ++--
 wic/hihope-rzg2m.wks                          | 4 ++--
 wic/iwg20m.wks                                | 4 ++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
 wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
 wic/qemu-riscv64-efibootguard.wks.in          | 4 ++--
 wic/x86-efibootguard.wks.in                   | 4 ++--
 wic/x86_64-generic.wks                        | 4 ++--
 14 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/README.md b/README.md
index 4ded924..62f72e5 100644
--- a/README.md
+++ b/README.md
@@ -27,6 +27,7 @@ the BeagleBone Black target image with real-time kernel, e.g.:
 
     ./kas-container build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml
 
+**NOTE**: For Production images, it is recommended to use fresh UUID's (Partition UUID) and not default ones.
 
 ## Running Target Images
 
diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index 48789c7..b9c8f3f 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -15,7 +15,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
 
 bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
diff --git a/wic/bbb.wks b/wic/bbb.wks
index a797e95..b46282d 100644
--- a/wic/bbb.wks
+++ b/wic/bbb.wks
@@ -9,6 +9,6 @@
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
 
-part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d
 
 bootloader --append "rootwait console=ttyO0,115200"
diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
index b2340e2..be63cd7 100644
--- a/wic/ebg-signed-sysparts.inc
+++ b/wic/ebg-signed-sysparts.inc
@@ -1,8 +1,8 @@
 # default partition layout EFI Boot Guard usage, signed version
 
 # EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcba
+part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcba --uuid d1360f76-b09a-4bcc-b923-8195088cbe02
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbb
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbc
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75ce61b8b
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4482ee9
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
index 300c36f..121dc73 100644
--- a/wic/ebg-sysparts.inc
+++ b/wic/ebg-sysparts.inc
@@ -1,8 +1,8 @@
 # default partition layout EFI Boot Guard usage
 
 # EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --fsuuid 0x4321dcba
+part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --fsuuid 0x4321dcba --uuid c19e7e9f-bacf-49a6-b43d-2fc18d2a8d03
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2" --fsuuid 0x4321dcbb
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1" --fsuuid 0x4321dcbc
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
index 2ac8850..aa704f5 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 43a29d19-005f-49d9-9108-51ad0861d724
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 7e20a7d5-5578-4ced-a7f1-5ee494dbaf72
 
 bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
diff --git a/wic/hihope-rzg2m.wks b/wic/hihope-rzg2m.wks
index fd3a338..f5b850d 100644
--- a/wic/hihope-rzg2m.wks
+++ b/wic/hihope-rzg2m.wks
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba
+part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba --uuid d122d639-1d92-4b41-bf7b-4b2bdf8dd899
 
 # Rootfs partition
-part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid b8bbba3f-3ba6-4b2b-8d69-4a95fd4f34ed
diff --git a/wic/iwg20m.wks b/wic/iwg20m.wks
index 85765f0..21fc419 100644
--- a/wic/iwg20m.wks
+++ b/wic/iwg20m.wks
@@ -12,7 +12,7 @@
 # [Note] u-boot runs from an SPI memory device
 
 # SDCard Boot partition (copies files in IMAGE_BOOT_FILES: zImage and device tree)
-part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba
+part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba --uuid 28a58348-5270-44d3-bea4-b1c492a81b7f
 
 # Rootfs partition
-part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid d0fa8361-7deb-43df-acee-1725d40d403e
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index 2e5cb39..b16da0b 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 94593121-6f5f-4b04-98db-39aace692682
+part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index 2fc389c..22e23b4 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e869413d-dc84-4822-b50d-00c5aab7d6fc
+part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
 
 bootloader --ptable gpt --append="panic=5"
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index 1f50ba3..7fe68d9 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 7346faa7-d6d4-49fa-a03e-82ee469cb1e5
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
 
 bootloader --ptable gpt
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
index 9158aa4..19ca1e0 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e578254c-bd99-4442-bc51-4935cd0ef522
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
 
 bootloader --ptable gpt
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
index 98e8da5..43bb782 100644
--- a/wic/x86-efibootguard.wks.in
+++ b/wic/x86-efibootguard.wks.in
@@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f12faa7c-a9ef-4b3f-b63d-1c74bd5c2b1c
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "
diff --git a/wic/x86_64-generic.wks b/wic/x86_64-generic.wks
index 1a44e26..a2b9c21 100644
--- a/wic/x86_64-generic.wks
+++ b/wic/x86_64-generic.wks
@@ -6,8 +6,8 @@
 # SPDX-License-Identifier: MIT
 #
 
-part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba
+part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid cf142945-6fa1-4945-b0f2-b8d6226298c0
 
-part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f225331b-2d9c-45a2-bcfe-4a6e86287dfb
 
 bootloader --ptable gpt --timeout 2 --append "console=ttyS0,115200"
-- 
2.39.2



