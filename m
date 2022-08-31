Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FCBC65C0D
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 07:31:29 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web08.22387.1661931086467930376
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 00:31:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=DK0FLTWH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-202208310731248fe11be5fc7ea2ff36-0k_vaj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202208310731248fe11be5fc7ea2ff36
        for <cip-dev@lists.cip-project.org>;
        Wed, 31 Aug 2022 09:31:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=GpGO6Yj4dzvnqmnkm5FwliGsDax4RssUYZgTqqk5ICc=;
 b=DK0FLTWH0pYOu2dAITVj7DcBiwPrdwFfrbpLWgC0ghylkhbTcDSTeq70siGv34wjgicnmX
 P3k34Jaj/eOmgsTYIfkvze4hCNmW/3B2brYUqKTGSjV88TC5kfteRQ1MF6t0Qjh39QhsmX+S
 xcsC+ILoEpNnAPjq0V5tBxgTKJkQ0=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 4/6] u-boot-bbb: Switch BeagleBone Black to
 self-built U-Boot
Date: Wed, 31 Aug 2022 09:31:19 +0200
Message-Id: 
 <9c95ca26dbeb8dc1a8bdf377433e5dd94991d049.1661931081.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1661931081.git.jan.kiszka@siemens.com>
References: <cover.1661931081.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 07:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9329

From: Jan Kiszka <jan.kiszka@siemens.com>

This will allow to boot via UEFI and use EFI Boot Guard and our standard
SWUpdate mode.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/bbb.conf                         |  5 +++-
 recipes-bsp/u-boot/u-boot-bbb_2022.07.bb      | 22 ++++++++++++++++
 ...boot-qemu-common.inc => u-boot-common.inc} | 11 --------
 recipes-bsp/u-boot/u-boot-qemu-common.inc     | 26 +------------------
 wic/bbb.wks                                   |  4 +--
 5 files changed, 29 insertions(+), 39 deletions(-)
 create mode 100644 recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
 copy recipes-bsp/u-boot/{u-boot-qemu-common.inc => u-boot-common.inc} (75%)

diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index 01206cc..eaec5a3 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -10,9 +10,12 @@ DISTRO_ARCH = "armhf"
 DTB_FILES = "am335x-boneblack.dtb"
 
 IMAGE_FSTYPES ?= "wic"
-IMAGER_INSTALL += "u-boot-omap"
+IMAGER_INSTALL += "u-boot-bbb"
+IMAGER_BUILD_DEPS += "u-boot-bbb"
 
 IMAGE_INSTALL += "u-boot-script"
 
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_bbb_defconfig"
+
+PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-bbb"
diff --git a/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb b/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
new file mode 100644
index 0000000..3be09dc
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
@@ -0,0 +1,22 @@
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
+require u-boot-common.inc
+
+U_BOOT_CONFIG = "am335x_evm_defconfig"
+U_BOOT_BIN = "all"
+
+EFI_ARCH = "arm"
+
+do_prepare_build_append() {
+    echo "MLO u-boot.img /usr/lib/u-boot/${MACHINE}" > \
+        ${S}/debian/u-boot-${MACHINE}.install
+}
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
similarity index 75%
copy from recipes-bsp/u-boot/u-boot-qemu-common.inc
copy to recipes-bsp/u-boot/u-boot-common.inc
index 2bb9ac0..60f0da3 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -27,8 +27,6 @@ DEBIAN_BUILD_DEPENDS_append_secureboot = ", \
     openssl, pesign, secure-boot-secrets, python3-openssl:native"
 DEPENDS_append_secureboot = " secure-boot-secrets"
 
-U_BOOT_BIN = "u-boot.bin"
-
 TEMPLATE_FILES_append_secureboot = " secure-boot.cfg.tmpl"
 TEMPLATE_VARS_append_secureboot = " EFI_ARCH"
 
@@ -36,12 +34,3 @@ do_prepare_build_append_secureboot() {
     sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
     cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
 }
-
-do_deploy[dirs] = "${DEPLOY_DIR_IMAGE}"
-do_deploy() {
-    dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
-        tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
-        > "${DEPLOY_DIR_IMAGE}/firmware.bin"
-}
-
-addtask deploy after do_dpkg_build before do_deploy_deb
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
index 2bb9ac0..0a9a15a 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -9,34 +9,10 @@
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
-    file://secure-boot.cfg.tmpl"
-
-S = "${WORKDIR}/u-boot-${PV}"
-
-DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}"
-
-DEBIAN_BUILD_DEPENDS_append_secureboot = ", \
-    openssl, pesign, secure-boot-secrets, python3-openssl:native"
-DEPENDS_append_secureboot = " secure-boot-secrets"
+require recipes-bsp/u-boot/u-boot-common.inc
 
 U_BOOT_BIN = "u-boot.bin"
 
-TEMPLATE_FILES_append_secureboot = " secure-boot.cfg.tmpl"
-TEMPLATE_VARS_append_secureboot = " EFI_ARCH"
-
-do_prepare_build_append_secureboot() {
-    sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
-    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
-}
-
 do_deploy[dirs] = "${DEPLOY_DIR_IMAGE}"
 do_deploy() {
     dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
diff --git a/wic/bbb.wks b/wic/bbb.wks
index 2822ce7..6131c78 100644
--- a/wic/bbb.wks
+++ b/wic/bbb.wks
@@ -6,8 +6,8 @@
 # SPDX-License-Identifier: MIT
 #
 
-part --source rawcopy --sourceparams "file=/usr/lib/u-boot/am335x_boneblack/MLO" --no-table --align 128
-part --source rawcopy --sourceparams "file=/usr/lib/u-boot/am335x_boneblack/u-boot.img" --no-table --align 384
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
 
 part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active
 
-- 
2.35.3


