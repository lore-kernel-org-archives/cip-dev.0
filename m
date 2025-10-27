Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358BBCCF9F9
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.26394.1761549712339499875
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=DJyYubma;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-2025102707215008188eb77200020721-okona_@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025102707215008188eb77200020721
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Ow/FLXnRiFJvajvnLhA/2+Pr+xA1F0sEgKTZzJbLfMU=;
 b=DJyYubmanl3MJ0OC+TRDkeeuZh8dA3ckxluT9jJr+AMtj7Exg/ik55Cy7+NZjCm1sDc/3k
 N/FI7IyA+QnsYZArqbXvlQ8UyAjtEndZ5g1zY5XMg8DmVDfMT7/JNpGo31mlrbLHSlRElAqm
 1BkWmOqDDD0UuK/C73Kqkxjg4+6du4INA/tPMhCzHQiSgIrRbVCWv1vXj4Mq4VULj/OJAMAr
 cDiHrIKsyoiI+YIboHsPdndnfd3EYzgiSBJL7S+x8iFv1O7sVoQwRk7xZ/Kd+UXZHd/LsM4C
 FzVzj1Pp7OlCUBQnEFxsJPnhTpCRe4k1TDQ8h7baF/eqWKc0i6jek6xQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 07/19] u-boot: Relocate or drop secure boot unrelated config switches
Date: Mon, 27 Oct 2025 08:21:36 +0100
Message-ID: <ec7f76d44cd2ec5dd5cd216932d19a025f88a418.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20225

From: Jan Kiszka <jan.kiszka@siemens.com>

CONFIG_USB_STORAGE and CONFIG_FIT_SIGNATURE are not generically required
to switch U-Boot into UEFI secure boot, drop them.

CONFIG_EFI_SCROLL_ON_CLEAR_SCREEN helps to keep the debug output intact
when booting via UEFI, but also without secure boot. Move this into a
newly introduced config extension for the QEMU boards. That snippet will
gain more options soon.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/files/qemu-extra.cfg   | 2 ++
 recipes-bsp/u-boot/files/secure-boot.cfg  | 3 ---
 recipes-bsp/u-boot/u-boot-qemu-common.inc | 9 ++++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)
 create mode 100644 recipes-bsp/u-boot/files/qemu-extra.cfg

diff --git a/recipes-bsp/u-boot/files/qemu-extra.cfg b/recipes-bsp/u-boot/files/qemu-extra.cfg
new file mode 100644
index 00000000..775e999c
--- /dev/null
+++ b/recipes-bsp/u-boot/files/qemu-extra.cfg
@@ -0,0 +1,2 @@
+### QEMU extra config
+CONFIG_EFI_SCROLL_ON_CLEAR_SCREEN=y
diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
index 58786a45..9d8b047e 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg
@@ -9,12 +9,9 @@ CONFIG_BOOTDELAY=-2
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="bootflow scan -lb; echo 'EFI Boot failed!'; sleep 1000; reset"
 CONFIG_HUSH_PARSER=y
-CONFIG_USB_STORAGE=y
 CONFIG_EFI_PARTITION=y
 CONFIG_FS_FAT=y
 CONFIG_EFI_VARIABLES_PRESEED=y
 CONFIG_EFI_SECURE_BOOT=y
-CONFIG_FIT_SIGNATURE=y
-CONFIG_EFI_SCROLL_ON_CLEAR_SCREEN=y
 # workaround for v2025.07
 CONFIG_CMD_DHCP=y
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
index 0bf7b621..f1a415b1 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2024
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,8 +11,15 @@
 
 inherit deploy-firmware
 
+SRC_URI += "file://qemu-extra.cfg"
+
 U_BOOT_BIN = "u-boot.bin"
 
+do_prepare_build:append() {
+    sed -ni '/### QEMU extra config/q;p' ${S}/configs/${U_BOOT_CONFIG}
+    cat ${WORKDIR}/qemu-extra.cfg >> ${S}/configs/${U_BOOT_CONFIG}
+}
+
 do_deploy_firmware() {
     dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
         tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
-- 
2.51.0


