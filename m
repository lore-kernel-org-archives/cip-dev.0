Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BB0C4321E
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 16:43:38 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.13539.1651769014539215601
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 09:43:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=RsXmk6pN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-20220505164335b0fa7f9fb4df3b398a-7gs7fe@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220505164335b0fa7f9fb4df3b398a
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 May 2022 18:43:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AzHYcEu0j+5gns1JGUX20ciyeMXO2L5ijI5X5XyEWzY=;
 b=RsXmk6pNB3udahRnT+hQAHHBVG99jKIIqgNdwqNKsBbwJQfNKkt+Nn2nsRf3BkEsZzaLYM
 wXBlADCygk5NnJBEyq6nNBYJe4ypi/4Hzu+6lmIWJh1/rIXEbdH69ZelseagGA/uk4f2WQMo
 /iZF9uysy12k+LRqJih09rh6WAWvI=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 12/13] Enable SWUpdate with and w/o secure
 boot for QEMU arm64
Date: Thu,  5 May 2022 18:43:28 +0200
Message-Id: 
 <5d8314f71095cfb1ff736f864f7a04f5467178af.1651769009.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651769009.git.jan.kiszka@siemens.com>
References: <cover.1651769009.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 16:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8263

From: Jan Kiszka <jan.kiszka@siemens.com>

Hook up the new U-Boot recipe, provide new wks files and disable the
watchdog for EFI Boot Guard - that's all what's need to allow offering
SWUpdate and secure boot for the QEMU arm64 target.

QEMU currently does not provide a watchdog for the virt machine which we
plan to use. A patch to change this has been sent, but for now we will
have to live without one.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                       |  4 ++--
 conf/machine/qemu-arm64.conf                  |  3 +++
 kas/opt/ebg-secure-boot-snakeoil.yml          |  3 +++
 kas/opt/efibootguard.yml                      |  4 +++-
 wic/qemu-arm64-efibootguard-secureboot.wks.in | 15 +++++++++++++++
 wic/qemu-arm64-efibootguard.wks.in            | 13 +++++++++++++
 6 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 wic/qemu-arm64-efibootguard-secureboot.wks.in
 create mode 100644 wic/qemu-arm64-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index 135794d..651a726 100644
--- a/Kconfig
+++ b/Kconfig
@@ -131,11 +131,11 @@ if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
-	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E
+	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64
 
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
-	depends on TARGET_QEMU_AMD64
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64
 	select IMAGE_SWUPDATE
 
 config KAS_INCLUDE_SWUPDATE_SECBOOT
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 0d21262..4e12cdb 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -11,3 +11,6 @@ DISTRO_ARCH = "arm64"
 IMAGE_FSTYPES ?= "ext4-img"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
+
+# for SWUpdate setups: watchdog is configured in U-Boot
+WDOG_TIMEOUT = "0"
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 7442eb7..3f2a794 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -32,3 +32,6 @@ local_conf_header:
     IMAGER_INSTALL += "ebg-secure-boot-signer"
     # Use snakeoil keys
     PREFERRED_PROVIDER_secure-boot-secrets = "secure-boot-snakeoil"
+
+  secureboot_override: |
+    OVERRIDES .= ":secureboot"
diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index c71cdb3..d85aed7 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -27,10 +27,12 @@ local_conf_header:
     IMAGE_FSTYPES ?= "wic-img"
     WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
 
-  ovmf-binaries: |
+  firmware-binaries: |
     # Add ovmf binaries for qemu
     IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
     # not needed for Debian 11 and later
     OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
     DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
     DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
+    # Add U-Boot for qemu
+    IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
new file mode 100644
index 0000000..df6a9a1
--- /dev/null
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -0,0 +1,15 @@
+# EFI partition containing efibootguard bootloader binary
+include ebg-signed-bootloader.inc
+
+# EFI Boot Guard environment/config partitions plus Kernel files
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh"
+
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+
+# home and var are extra partitions
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
+part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G
+
+bootloader --ptable gpt --append="panic=5"
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
new file mode 100644
index 0000000..a153205
--- /dev/null
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -0,0 +1,13 @@
+# short-description: arm64 with EFI Boot Guard and SWUpdate
+# long-description: Disk image for arm64 machines with EFI Boot Guard and SWUpdate
+
+include ebg-sysparts.inc
+
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+
+# home and var are extra partitions
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
+
+bootloader --ptable gpt
-- 
2.34.1


