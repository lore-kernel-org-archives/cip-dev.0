Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0606E73165
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 12:57:57 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51899.1770037072080847635
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 04:57:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=A65xAmDG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20260202125749dabbbf7e2a00020791-bowaj5@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260202125749dabbbf7e2a00020791
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Feb 2026 13:57:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=OFLuvRCsBAS4HPb4aOUOXqBEkN+EXPXBSHfP3Xg3erE=;
 b=A65xAmDG1u+XQ//sKvtqX34dC3KyOEMy2igDaxeH94xusMzPRR+fl9UCWUY7UhlhxX97eO
 3jyyJmUX/vunR/h/0sPy3YIsd6oHJmNv1EH6YSHiOZpql2YwvdpRba9SDoIKb2HkaAUcDQiF
 OR5Md2G/08LbQ69M1FEbG4Viwwi1GWqm2LDtLqZFnAFK4AD0vXRvY4zoefkqUXkxNydrCF00
 qsFvx/B5n+JGjMBqYs92zNYOqP+3VlYJ8/ukwaOwK+02U7WR7lrE4Y/8ys3BVYdayoyji7dq
 YpTTCY6B4wn+1TWndHMqe1BIyf7q9WbYxgm8KjeAjBpaowUxQQgecPTA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 7/9] Add BeagleV-Fire board
Date: Mon,  2 Feb 2026 13:57:46 +0100
Message-ID: <72b3fe58175869ad3fcc702722b0d65371a9e1b3.1770037068.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1770037068.git.jan.kiszka@siemens.com>
References: <cover.1770037068.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 12:57:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21802

From: Jan Kiszka <jan.kiszka@siemens.com>

This is the new RISC-V reference target. Add its machine config and the
wks files for regular and SWUpdate-based UEFI booting.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/beaglev-fire.conf                | 22 +++++++++++++++++++
 .../u-boot/u-boot-beaglev-fire_2026.01.bb     |  5 +++++
 wic/beaglev-fire-efibootguard.wks.in          | 20 +++++++++++++++++
 wic/beaglev-fire.wks                          | 14 ++++++++++++
 4 files changed, 61 insertions(+)
 create mode 100644 conf/machine/beaglev-fire.conf
 create mode 100644 wic/beaglev-fire-efibootguard.wks.in
 create mode 100644 wic/beaglev-fire.wks

diff --git a/conf/machine/beaglev-fire.conf b/conf/machine/beaglev-fire.conf
new file mode 100644
index 00000000..585c7803
--- /dev/null
+++ b/conf/machine/beaglev-fire.conf
@@ -0,0 +1,22 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH = "riscv64"
+
+IMAGE_FSTYPES ?= "wic"
+
+IMAGER_INSTALL:wic += "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-beaglev-fire"
+IMAGER_BUILD_DEPS += "u-boot-beaglev-fire"
+
+USE_CIP_KERNEL_CONFIG = "1"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/${KERNEL_ARCH}/beaglev-fire_defconfig"
+
+WDOG_TIMEOUT = "0"
diff --git a/recipes-bsp/u-boot/u-boot-beaglev-fire_2026.01.bb b/recipes-bsp/u-boot/u-boot-beaglev-fire_2026.01.bb
index 6249fa1a..bde8c1ef 100644
--- a/recipes-bsp/u-boot/u-boot-beaglev-fire_2026.01.bb
+++ b/recipes-bsp/u-boot/u-boot-beaglev-fire_2026.01.bb
@@ -21,3 +21,8 @@ DEBIAN_BUILD_DEPENDS += ", hss-payload-generator:native"
 U_BOOT_CONFIG = "beaglev_fire_defconfig"
 U_BOOT_BIN = "u-boot.bin"
 U_BOOT_EXTRA_BUILDCMD = "hss-payload-generator -c debian/beaglev-fire-config.yaml payload.bin"
+
+do_prepare_build:append() {
+    echo "payload.bin /usr/lib/u-boot/${MACHINE}" > \
+        ${S}/debian/u-boot-${MACHINE}.install
+}
diff --git a/wic/beaglev-fire-efibootguard.wks.in b/wic/beaglev-fire-efibootguard.wks.in
new file mode 100644
index 00000000..f24b53c4
--- /dev/null
+++ b/wic/beaglev-fire-efibootguard.wks.in
@@ -0,0 +1,20 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019-2025
+#
+# SPDX-License-Identifier: MIT
+#
+
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/beaglev-fire/payload.bin" --part-type 21686148-6449-6E6F-744E-656564454649
+
+include ebg-sysparts.inc
+
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+
+# var and optional home are extra partitions
+${WIC_HOME_PARTITION}
+part /var --fstype=ext4 --label var --align 1024  --size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
+
+bootloader --ptable gpt --append="rootwait watchdog.handle_boot_enabled=0"
diff --git a/wic/beaglev-fire.wks b/wic/beaglev-fire.wks
new file mode 100644
index 00000000..89e19f23
--- /dev/null
+++ b/wic/beaglev-fire.wks
@@ -0,0 +1,14 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens, 2025
+#
+# SPDX-License-Identifier: MIT
+#
+
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/beaglev-fire/payload.bin" --part-type 21686148-6449-6E6F-744E-656564454649
+
+part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot" --label efi --part-type EF00 --align 1024 --use-uuid
+part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid --exclude-path boot/
+
+bootloader --ptable gpt --timeout=0 --append "rootwait rw"
-- 
2.51.0


