Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1FFCCA47F
	for <webhook@archiver.kernel.org>; Mon, 11 Jul 2022 19:41:04 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web09.160.1657568463588509440
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jul 2022 12:41:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=fJQPBHb4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-294854-20220711194101a14ceb0411e207ce9b-t9jug7@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20220711194101a14ceb0411e207ce9b
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Jul 2022 21:41:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=elbvcE88yGAzM5Hn8kyzuysrcw5KBYloMANcfyq70MQ=;
 b=fJQPBHb4q6XdZT5dcNsVpXunrQ0JIWpfpjJVb7KZvZRIaYrkzAMbNL1KVjsiqdyEOGvKbZ
 aTsKS+z3yXFXTl0zz8JaeaKMVKiDseNK2Gvgh5JNPBLkju+4tgu2udkVdZguLyu2trmcCfug
 iovT86rDjmDBt+xdu/AgW/YnGhEwE=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 5/7] u-boot-qemu-arm64: Generalize the recipe
Date: Mon, 11 Jul 2022 21:40:56 +0200
Message-Id: 
 <ed13b6ac3366afe604dc801fdca9ab8395075fe4.1657568458.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1657568458.git.jan.kiszka@siemens.com>
References: <cover.1657568458.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Jul 2022 19:41:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8746

From: Jan Kiszka <jan.kiszka@siemens.com>

This will allow to reuse it for 32-bit ARM.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/qemu-arm64.conf                  |  2 ++
 recipes-bsp/u-boot/files/secure-boot.cfg      |  6 ----
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |  6 ++++
 .../u-boot/u-boot-qemu-arm64_2022.07.bb       | 33 ++-----------------
 ...rm64_2022.07.bb => u-boot-qemu-common.inc} |  8 +++--
 5 files changed, 15 insertions(+), 40 deletions(-)
 delete mode 100644 recipes-bsp/u-boot/files/secure-boot.cfg
 create mode 100644 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
 copy recipes-bsp/u-boot/{u-boot-qemu-arm64_2022.07.bb => u-boot-qemu-common.inc} (84%)

diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index b5c1e1c..7f42369 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -14,3 +14,5 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_ar
 
 # for SWUpdate setups: watchdog is configured in U-Boot
 WDOG_TIMEOUT = "0"
+
+PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm64"
diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
deleted file mode 100644
index a1b9931..0000000
--- a/recipes-bsp/u-boot/files/secure-boot.cfg
+++ /dev/null
@@ -1,6 +0,0 @@
-### Secure boot config
-CONFIG_BOOTDELAY=-2
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv scan_dev_for_boot 'if test -e ${devtype} ${devnum}:${distro_bootpart} efi/boot/bootaa64.efi; then load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/bootaa64.efi; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo 'EFI Boot failed!'; sleep 1000; reset"
-CONFIG_EFI_VARIABLES_PRESEED=y
-CONFIG_EFI_SECURE_BOOT=y
diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
new file mode 100644
index 0000000..956dcbf
--- /dev/null
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
@@ -0,0 +1,6 @@
+### Secure boot config
+CONFIG_BOOTDELAY=-2
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="setenv scan_dev_for_boot 'if test -e ${devtype} ${devnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo 'EFI Boot failed!'; sleep 1000; reset"
+CONFIG_EFI_VARIABLES_PRESEED=y
+CONFIG_EFI_SECURE_BOOT=y
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
index 465be40..29ca0a5 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
@@ -9,37 +9,8 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-bsp/u-boot/u-boot-custom.inc
-
-SRC_URI += " \
-    https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
-    file://rules.tmpl;subdir=debian"
-SRC_URI[sha256sum] = "92b08eb49c24da14c1adbf70a71ae8f37cc53eeb4230e859ad8b6733d13dcf5e"
-
-SRC_URI_append_secureboot = " \
-    file://secure-boot.cfg"
-
-S = "${WORKDIR}/u-boot-${PV}"
-
-DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:arm64"
-
-DEBIAN_BUILD_DEPENDS_append_secureboot = ", \
-    openssl, pesign, secure-boot-secrets, python3-openssl:native"
-DEPENDS_append_secureboot = " secure-boot-secrets"
+require u-boot-qemu-common.inc
 
 U_BOOT_CONFIG = "qemu_arm64_defconfig"
-U_BOOT_BIN = "u-boot.bin"
-
-do_prepare_build_append_secureboot() {
-    sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
-    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
-}
-
-do_deploy[dirs] = "${DEPLOY_DIR_IMAGE}"
-do_deploy() {
-    dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
-        tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
-        > "${DEPLOY_DIR_IMAGE}/firmware.bin"
-}
 
-addtask deploy after do_dpkg_build before do_deploy_deb
+EFI_ARCH = "aa64"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-common.inc
similarity index 84%
copy from recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
copy to recipes-bsp/u-boot/u-boot-qemu-common.inc
index 465be40..2bb9ac0 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -17,19 +17,21 @@ SRC_URI += " \
 SRC_URI[sha256sum] = "92b08eb49c24da14c1adbf70a71ae8f37cc53eeb4230e859ad8b6733d13dcf5e"
 
 SRC_URI_append_secureboot = " \
-    file://secure-boot.cfg"
+    file://secure-boot.cfg.tmpl"
 
 S = "${WORKDIR}/u-boot-${PV}"
 
-DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:arm64"
+DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}"
 
 DEBIAN_BUILD_DEPENDS_append_secureboot = ", \
     openssl, pesign, secure-boot-secrets, python3-openssl:native"
 DEPENDS_append_secureboot = " secure-boot-secrets"
 
-U_BOOT_CONFIG = "qemu_arm64_defconfig"
 U_BOOT_BIN = "u-boot.bin"
 
+TEMPLATE_FILES_append_secureboot = " secure-boot.cfg.tmpl"
+TEMPLATE_VARS_append_secureboot = " EFI_ARCH"
+
 do_prepare_build_append_secureboot() {
     sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
     cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
-- 
2.35.3


