Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE85C4332F
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 20:18:42 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.858.1635884320716237415
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Nov 2021 13:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1A2KIcuI020944
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 2 Nov 2021 21:18:38 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.22.43.93])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1A2KIXYD007052
	for <cip-dev@lists.cip-project.org>; Tue, 2 Nov 2021 21:18:37 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v2 2/3] Add kconfig menu
Date: Tue,  2 Nov 2021 21:18:32 +0100
Message-Id: 
 <c7126a772c8a7d6186a7c2bc5e09a5224f74c5f6.1635884313.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635884313.git.jan.kiszka@siemens.com>
References: <cover.1635884313.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Nov 2021 20:18:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6857

From: Jan Kiszka <jan.kiszka@siemens.com>

Use the new kas menu plugin to present available image options to the
user. This also allows to model their dependencies, specifically as not
all options are supported on all boards.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitignore |   1 +
 Kconfig    | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 README.md  |  37 +++++++++-----
 3 files changed, 171 insertions(+), 14 deletions(-)
 create mode 100644 Kconfig

diff --git a/.gitignore b/.gitignore
index b73840f..949a710 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,3 +3,4 @@ isar/
 kas-docker
 kas-container
 __pycache__
+.config.yaml*
diff --git a/Kconfig b/Kconfig
new file mode 100644
index 0000000..13c3315
--- /dev/null
+++ b/Kconfig
@@ -0,0 +1,147 @@
+mainmenu "Isar core layer of the Civil Infrastructure Platform project"
+
+config KAS_INCLUDE_MAIN
+	string
+	default "kas-cip.yml"
+
+config KAS_BUILD_SYSTEM
+	string
+	default "isar"
+
+choice
+	prompt "Target board"
+	default TARGET_QEMU_AMD64
+
+config TARGET_QEMU_AMD64
+	bool "QEMU AMD64 (x86-64)"
+
+config TARGET_SIMATIC_IPC227E
+	bool "Siemens SIMATIC IPC227E"
+
+config TARGET_QEMU_ARM64
+	bool "QEMU ARM64 (aarch64)"
+
+config TARGET_HIHOPE_RZG2M
+	bool "HopeRun HiHope-RZ/G2M"
+
+config TARGET_QEMU_ARM
+	bool "QEMU ARM (armhf)"
+
+config TARGET_BBB
+	bool "BeagleBone Black"
+
+config TARGET_IWG20D
+	bool "iWave Systems RainboW-G20D-Qseven"
+
+endchoice
+
+config KAS_INCLUDE_BOARD
+	string
+	default "kas/board/qemu-amd64.yml" if TARGET_QEMU_AMD64
+	default "kas/board/simatic-ipc227e.yml" if TARGET_SIMATIC_IPC227E
+	default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
+	default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
+	default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
+	default "kas/board/bbb.yml" if TARGET_BBB
+	default "kas/board/iwg20m.yml" if TARGET_IWG20D
+
+comment "Kernel options"
+
+choice
+	prompt "CIP kernel version"
+	default KERNEL_4_19
+
+config KERNEL_4_4
+	bool "Kernel 4.4.x-cip"
+
+config KERNEL_4_19
+	bool "Kernel 4.19.x-cip"
+
+endchoice
+
+config KAS_INCLUDE_KERNEL
+	string
+	default "kas/opt/4.4.yml"
+	depends on KERNEL_4_4
+
+config KERNEL_RT
+	bool "Real-time CIP kernel"
+
+config KAS_INCLUDE_KERNEL_RT
+	string
+	default "kas/opt/rt.yml"
+	depends on KERNEL_RT
+
+comment "Debian distribution options"
+
+choice
+	prompt "Debian Release"
+	default DEBIAN_BUSTER
+
+config DEBIAN_STRETCH
+	bool "stretch (9)"
+
+config DEBIAN_BUSTER
+	bool "buster (10)"
+
+config DEBIAN_BULLSEYE
+	bool "bullseye (11)"
+
+endchoice
+
+config KAS_INCLUDE_DEBIAN
+	string
+	default "kas/opt/stretch.yml" if DEBIAN_STRETCH
+	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
+
+comment "Image features"
+
+choice
+	prompt "Image formats"
+	default IMAGE_FLASH
+
+config IMAGE_FLASH
+	bool "Flashable image"
+
+config IMAGE_ARTIFACTS
+	bool "Separate artifacts for NFS boot"
+
+endchoice
+
+config KAS_INCLUDE_IMAGE_FORMAT
+	string
+	default "kas/opt/targz.yml" if IMAGE_ARTIFACTS && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
+	default "kas/opt/wic-targz.yml" if IMAGE_ARTIFACTS && !(TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
+
+config IMAGE_SECURITY
+	bool "Security extensions"
+	depends on DEBIAN_BUSTER
+
+config KAS_INCLUDE_SECURITY
+	string
+	default "kas/opt/security.yml" if IMAGE_SECURITY
+
+config IMAGE_TESTING
+	bool "Test extensions"
+
+config KAS_INCLUDE_TESTING
+	string
+	default "kas/opt/test.yml" if IMAGE_TESTING
+
+if IMAGE_FLASH
+
+config IMAGE_SWUPDATE
+	bool "SWUpdate support for root partition"
+	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E
+
+config IMAGE_SECURE_BOOT
+	bool "Secure boot support"
+	depends on TARGET_QEMU_AMD64
+
+config KAS_INCLUDE_SWUPDATE_SECBOOT
+	string
+	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
+	default "kas/opt/ebg-secure-boot-snakeoil.yml" if !IMAGE_SWUPDATE && IMAGE_SECURE_BOOT
+	default "kas/opt/ebg-snakeoil-swu.yml" if IMAGE_SWUPDATE && IMAGE_SECURE_BOOT
+
+endif
diff --git a/README.md b/README.md
index 980a023..b46f1d2 100644
--- a/README.md
+++ b/README.md
@@ -18,16 +18,30 @@ Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 Furthermore, install docker and make sure you have required permissions to
 start containers.
 
-To build, e.g., the QEMU AMD64 target inside Docker, invoke kas-container like
-this:
+Open up the image configuration menu and select the desired target and its
+options:
 
-    ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml
+    ./kas-container menu
 
-This image can be run using `start-qemu.sh x86`.
+You can direct start the build from the menu.
 
-The BeagleBone Black target is selected by `... kas-cip.yml:kas/board/bbb.yml`. In
-order to build the image with the PREEMPT-RT kernel, append `:kas/opt/rt.yml` to
-the above. Append `:kas/opt/4.4.yml` to use the kernel version 4.4 instead of 4.19.
+If you prefer selecting the configuration via the command line, this builds
+the BeagleBone Black target image with real-time kernel, e.g.:
+
+    ./kas-container build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml
+
+
+## Running Target Images
+
+When having built a virtual QEMU target image, this can be started directly.
+Run, e.g.,
+
+    ./start-qemu.sh x86
+
+when having built a QEMU AMD64 image. A security image for QEMU can be started
+like this:
+
+    TARGET_IMAGE=cip-core-image-security ./start-qemu.sh x86
 
 Physical targets will generate ready-to-boot images under
 `build/tmp/deploy/images/`. To flash, e.g., the BeagleBone Black image to an SD
@@ -36,14 +50,9 @@ card, run
     dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic.img \
        of=/dev/<medium-device> bs=1M status=progress
 
-## Building Security target images
-Building images for QEMU x86-64bit machine
-
-    ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
-
-Run the generated securiy images on QEMU (x86-64bit)
+or via bmap-tools
 
-    TARGET_IMAGE=cip-core-image-security ./start-qemu.sh amd64
+    bmaptool copy build/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic.img /dev/<medium-device>
 
 
 ## Community Resources
-- 
2.31.1


