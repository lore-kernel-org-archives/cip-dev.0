Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9C0CEBF97
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 06:09:17 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6496.1763446148714168594
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 22:09:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Bu9GVtw3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-202511180609057d90c8a568000207ee-jsdi_i@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202511180609057d90c8a568000207ee
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Nov 2025 07:09:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=7potjZFpKmhUw7o7kSSDTRGStOoQdHUy27YNbavuS80=;
 b=Bu9GVtw37CZg9/ybu0gaaQh1iWeVTyqq9fgDLVHSCBMLDP/GbOibgkRn/EPadNHDJ58/Pu
 m4tZ4TL4DPKoYsVlaiX/Z7Tr/db3auF93gJXoTp0O6D0jdG7ojzl6KMEuhKmgfV+ZJVAIUz1
 XG0q3uhM2eocExBTVQGDII/LzK+QO0dng0Qo8dsHrrZrlG8YcWQGTvcB3vNZn0J1ytVzbAR0
 l3QS7B/lNBEhjr6paegbFZDqAHp8H/s5VlZAFcXEGwaYeDvBrcTPppX+scpNPCqQ/wT15FCt
 Mjaucg1DoSOTupvOJQ/oh7OO/2zSCLbImNVgoCiVDN8CFuByKPThscmA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/4] Add DE0-Nano-SoC machine
Date: Tue, 18 Nov 2025 07:09:02 +0100
Message-ID: <bb702afdd9a1f8e70e8476c34fd21a050187fa46.1763446144.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763446144.git.jan.kiszka@siemens.com>
References: <cover.1763446144.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 06:09:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20605

From: Jan Kiszka <jan.kiszka@siemens.com>

We boot the board from SD card in EFI mode, with or without SWUpdate
support.

For that, we need a hybrid partition table. The entry containing the
firmware is marked with the type 0xa2 in the legacy msdos partition
table. Unfortunately, this cannot be expressed with wic natively because
it will try to apply --system-id to the GPT, failing to do so with msdos
value. Therefore add a custom bootloader plugin that does that
hard-coded at the end of the image generation.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/de0-nano-soc.conf                | 19 ++++++++++++
 .../plugins/source/de0-nano-soc-firmware.py   | 31 +++++++++++++++++++
 wic/de0-nano-soc-efibootguard.wks.in          | 20 ++++++++++++
 wic/de0-nano-soc.wks                          | 14 +++++++++
 4 files changed, 84 insertions(+)
 create mode 100644 conf/machine/de0-nano-soc.conf
 create mode 100644 scripts/lib/wic/plugins/source/de0-nano-soc-firmware.py
 create mode 100644 wic/de0-nano-soc-efibootguard.wks.in
 create mode 100644 wic/de0-nano-soc.wks

diff --git a/conf/machine/de0-nano-soc.conf b/conf/machine/de0-nano-soc.conf
new file mode 100644
index 00000000..e4669b5a
--- /dev/null
+++ b/conf/machine/de0-nano-soc.conf
@@ -0,0 +1,19 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH = "armhf"
+DTB_FILES = "socfpga_cyclone5_de0_nano_soc.dtb"
+
+IMAGE_FSTYPES ?= "wic"
+IMAGER_INSTALL:wic += "u-boot-de0-nano-soc ${SYSTEMD_BOOTLOADER_INSTALL}"
+IMAGER_BUILD_DEPS += "u-boot-de0-nano-soc"
+
+USE_CIP_KERNEL_CONFIG = "1"
+
+# for SWUpdate setups: watchdog is configured in U-Boot
+WDOG_TIMEOUT = "0"
diff --git a/scripts/lib/wic/plugins/source/de0-nano-soc-firmware.py b/scripts/lib/wic/plugins/source/de0-nano-soc-firmware.py
new file mode 100644
index 00000000..df5c6a7f
--- /dev/null
+++ b/scripts/lib/wic/plugins/source/de0-nano-soc-firmware.py
@@ -0,0 +1,31 @@
+#
+# Copyright (c) Siemens AG, 2025
+#
+# SPDX-License-Identifier: MIT
+
+import logging
+
+from wic import WicError
+from wic.pluginbase import SourcePlugin
+from wic.misc import exec_native_cmd
+
+logger = logging.getLogger('wic')
+
+class DE0NanoSoCFirmware(SourcePlugin):
+    """
+    Mark mbr-tagged partition with type 0xa2 to enable firmware loading.
+    """
+
+    name = 'de0-nano-soc-firmware'
+
+    @classmethod
+    def do_install_disk(cls, disk, disk_name, creator, workdir, oe_builddir,
+                        bootimg_dir, kernel_dir, native_sysroot):
+        for part in creator.parts:
+            if part.mbr:
+                break
+        else:
+            raise WicError("No active partition found")
+
+        logger.info("Marking MBR partition %d as firmware partition" % part.realnum)
+        exec_native_cmd("sfdisk --label-nested dos --part-type %s %d 0xa2" % (disk.path, part.realnum), native_sysroot)
diff --git a/wic/de0-nano-soc-efibootguard.wks.in b/wic/de0-nano-soc-efibootguard.wks.in
new file mode 100644
index 00000000..906aa72d
--- /dev/null
+++ b/wic/de0-nano-soc-efibootguard.wks.in
@@ -0,0 +1,20 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019-2025
+#
+# SPDX-License-Identifier: MIT
+#
+
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/de0-nano-soc/u-boot-with-spl.sfp" --align 2 --mbr
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
+bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
diff --git a/wic/de0-nano-soc.wks b/wic/de0-nano-soc.wks
new file mode 100644
index 00000000..df4bcec1
--- /dev/null
+++ b/wic/de0-nano-soc.wks
@@ -0,0 +1,14 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019-2025
+#
+# SPDX-License-Identifier: MIT
+#
+
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/de0-nano-soc/u-boot-with-spl.sfp" --align 2 --mbr
+
+part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot,dtb=socfpga_cyclone5_de0_nano_soc.dtb" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid 16d61432-ec24-42fa-a4b8-b2bc20a26f5e --use-uuid
+part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d --use-uuid
+
+bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --timeout=0 --append "rootwait console=ttyO0,115200"
-- 
2.51.0


