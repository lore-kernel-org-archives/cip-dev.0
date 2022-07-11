Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805AECCA47B
	for <webhook@archiver.kernel.org>; Mon, 11 Jul 2022 19:41:14 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web12.185.1657568463681145185
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jul 2022 12:41:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=TY2FudSW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-294854-20220711194101f52c61cab064878828-vgmbuy@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20220711194101f52c61cab064878828
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Jul 2022 21:41:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=z7PxAyTK342FeBJU1yXMy+m0/VEiZXzReKKK8jAGlcI=;
 b=TY2FudSW7sbB048gOhYhWQvgitN+aeE1SRHszPQbh3WDZUqnYn/cxw/UDlBwnbEpOxfdRB
 3G+/CrWwu11fMB6uIAvYdpXb6A5A8oIqdqOqfRCd3dsnLlGhV73Bvln6gNUBMfsOlCgUHQwv
 ZCdC16DJHvy6XqMhqowaX/5GPYejo=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 6/7] Add support for ARM-based swupdate/secure
 boot image
Date: Mon, 11 Jul 2022 21:40:57 +0200
Message-Id: 
 <4fe9685bb385cd4eea3c0c1a699d0575aebd8411.1657568458.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1657568458.git.jan.kiszka@siemens.com>
References: <cover.1657568458.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Jul 2022 19:41:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8747

From: Jan Kiszka <jan.kiszka@siemens.com>

Everything is now lined up so that enabling this almost trivial,
reusing what is there for qemu-arm64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                          |  4 ++--
 conf/machine/qemu-arm.conf                       |  5 +++++
 kas/opt/efibootguard.yml                         |  1 +
 recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb    | 16 ++++++++++++++++
 .../lib/wic/plugins/source/efibootguard-boot.py  |  1 +
 .../lib/wic/plugins/source/efibootguard-efi.py   |  1 +
 start-qemu.sh                                    |  4 ++--
 wic/qemu-arm-efibootguard-secureboot.wks.in      |  1 +
 wic/qemu-arm-efibootguard.wks.in                 |  1 +
 9 files changed, 30 insertions(+), 4 deletions(-)
 create mode 100644 recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb
 create mode 120000 wic/qemu-arm-efibootguard-secureboot.wks.in
 create mode 120000 wic/qemu-arm-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index 9c89008..c63000b 100644
--- a/Kconfig
+++ b/Kconfig
@@ -132,11 +132,11 @@ if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
-	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64
+	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
 
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
 	select IMAGE_SWUPDATE
 
 config KAS_INCLUDE_SWUPDATE_SECBOOT
diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index 1937c4c..aa3a6b4 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -12,3 +12,8 @@ DISTRO_ARCH = "armhf"
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
+
+# for SWUpdate setups: watchdog is configured in U-Boot
+WDOG_TIMEOUT = "0"
+
+PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm"
diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index 4282932..cee9c78 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -36,3 +36,4 @@ local_conf_header:
     DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
     # Add U-Boot for qemu
     IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
+    IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb
new file mode 100644
index 0000000..cdad19a
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require u-boot-qemu-common.inc
+
+U_BOOT_CONFIG = "qemu_arm_defconfig"
+
+EFI_ARCH = "arm"
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 4b7fa8d..f9b232b 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -184,6 +184,7 @@ class EfibootguardBootPlugin(SourcePlugin):
         distro_to_efi_arch = {
             "amd64": "x64",
             "arm64": "aa64",
+            "armhf": "arm",
             "i386": "ia32"
         }
         rootfs_path = rootfs_dir.get('ROOTFS_DIR')
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 140b734..a754ee1 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -55,6 +55,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
         distro_to_efi_arch = {
             "amd64": "x64",
             "arm64": "aa64",
+            "armhf": "arm",
             "i386": "ia32"
         }
 
diff --git a/start-qemu.sh b/start-qemu.sh
index f7ca87f..bcc7a51 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -145,8 +145,8 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 					${QEMU_COMMON_OPTIONS} "$@"
 			fi
 			;;
-		arm64|aarch64)
-			u_boot_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-arm64/firmware.bin}
+		arm64|aarch64|arm|armhf)
+			u_boot_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH}/firmware.bin}
 
 			${QEMU_PATH}${QEMU} \
 				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
diff --git a/wic/qemu-arm-efibootguard-secureboot.wks.in b/wic/qemu-arm-efibootguard-secureboot.wks.in
new file mode 120000
index 0000000..c6ac32f
--- /dev/null
+++ b/wic/qemu-arm-efibootguard-secureboot.wks.in
@@ -0,0 +1 @@
+qemu-arm64-efibootguard-secureboot.wks.in
\ No newline at end of file
diff --git a/wic/qemu-arm-efibootguard.wks.in b/wic/qemu-arm-efibootguard.wks.in
new file mode 120000
index 0000000..9cb5f0e
--- /dev/null
+++ b/wic/qemu-arm-efibootguard.wks.in
@@ -0,0 +1 @@
+qemu-arm64-efibootguard.wks.in
\ No newline at end of file
-- 
2.35.3


