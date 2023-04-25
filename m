Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB18C6FD18
	for <webhook@archiver.kernel.org>; Tue, 25 Apr 2023 12:54:38 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.71233.1682393583624078921
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Apr 2023 20:33:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=PZTcfaON;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-72506-202304250333017fa449af92f87d5af4-aygacy@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202304250333017fa449af92f87d5af4
        for <cip-dev@lists.cip-project.org>;
        Tue, 25 Apr 2023 05:33:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Pp8siAjuXDCok1PATGzMskxqSCiIkKxB5B9jqwVaXFM=;
 b=PZTcfaONsfrREqaBL1Ub60kJV6gdlAf4YxVJtOC9smHtZTDHad+RR1FKWDQhtJYSHu/uO7
 LKdUdF6Zp7xpOgKIvX/8csKgUd+NT4o0VBP/KJEhyyv1oZrVsQcTsVRjCrahtm0MGNwoMoTk
 T3nJP4amCcCVXKQnsiz+hSu2u1dsE=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] generalize deployment of self compiled firmware
Date: Tue, 25 Apr 2023 11:32:46 +0800
Message-Id: <20230425033246.1199444-2-felix.moessbauer@siemens.com>
In-Reply-To: <20230425033246.1199444-1-felix.moessbauer@siemens.com>
References: <20230425033246.1199444-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Apr 2023 12:54:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11349

For some targets, dedicated firmware is compiled and copied into the
DEPLOY_DIR_IMAGE. Instead of implementing this logic for each firmware
individually, we move the common logic into a class and inherit.

This reduces the amount of code duplication and simplifies the maintenance.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/deploy-firmware.bbclass           | 32 +++++++++++++++++++++++
 recipes-bsp/opensbi/opensbi.inc           | 16 ++----------
 recipes-bsp/u-boot/u-boot-qemu-common.inc | 18 +++----------
 3 files changed, 37 insertions(+), 29 deletions(-)
 create mode 100644 classes/deploy-firmware.bbclass

diff --git a/classes/deploy-firmware.bbclass b/classes/deploy-firmware.bbclass
new file mode 100644
index 0000000..a4b754a
--- /dev/null
+++ b/classes/deploy-firmware.bbclass
@@ -0,0 +1,32 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Felix Moessbauer <felix.moessbauer@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# This class adds a mechanism to deploy files to the DEPLOY_DIR_IMAGE
+# directory. Simply overwrite the deploy_firmware task and copy the
+# to-be-deployed files into DEPLOYDIR_FIRMWARE.
+
+inherit dpkg-base
+
+DEPLOYDIR_FIRMWARE = "${WORKDIR}/deploy-fw"
+SSTATETASKS += "do_deploy_firmware"
+
+do_deploy_firmware[cleandirs] += "${DEPLOYDIR_FIRMWARE}"
+do_deploy_firmware[sstate-inputdirs] = "${DEPLOYDIR_FIRMWARE}"
+do_deploy_firmware[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
+do_deploy_firmware() {
+    die "This should never be called, overwrite it in your derived class"
+}
+
+python do_deploy_firmware_setscene () {
+    sstate_setscene(d)
+}
+addtask do_deploy_firmware_setscene
+
+addtask deploy_firmware after do_dpkg_build before do_deploy_deb
diff --git a/recipes-bsp/opensbi/opensbi.inc b/recipes-bsp/opensbi/opensbi.inc
index 0108231..6d84026 100644
--- a/recipes-bsp/opensbi/opensbi.inc
+++ b/recipes-bsp/opensbi/opensbi.inc
@@ -4,13 +4,11 @@
 # SPDX-License-Identifier: MIT
 
 inherit dpkg
+inherit deploy-firmware
 
 U_BOOT_PACKAGE ?= "u-boot-${MACHINE}"
 PLATFORM ?= "generic"
 
-DEPLOYDIR_FIRMWARE = "${WORKDIR}/deploy-fw"
-SSTATETASKS += "do_deploy"
-
 SRC_URI = " \
     https://github.com/riscv/opensbi/archive/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz;name=opensbi"
 
@@ -27,18 +25,8 @@ do_prepare_build() {
     echo "build/platform/${PLATFORM}/firmware/fw_payload.bin /usr/lib/opensbi/${MACHINE}/" > ${S}/debian/install
 }
 
-do_deploy[cleandirs] += "${DEPLOYDIR_FIRMWARE}"
-do_deploy[sstate-inputdirs] = "${DEPLOYDIR_FIRMWARE}"
-do_deploy[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
-do_deploy() {
+do_deploy_firmware() {
     dpkg --fsys-tarfile "${WORKDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
         tar xOf - "./usr/lib/opensbi/${MACHINE}/fw_payload.bin" \
         > "${DEPLOYDIR_FIRMWARE}/fw_payload.bin"
 }
-
-python do_deploy_setscene () {
-    sstate_setscene(d)
-}
-addtask do_deploy_setscene
-
-addtask deploy after do_dpkg_build before do_deploy_deb
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
index 4d8b240..b222155 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -9,25 +9,13 @@
 # SPDX-License-Identifier: MIT
 #
 
+inherit deploy-firmware
 require recipes-bsp/u-boot/u-boot-common.inc
 
 U_BOOT_BIN = "u-boot.bin"
 
-DEPLOYDIR_U_BOOT = "${WORKDIR}/deploy-u-boot"
-SSTATETASKS += "do_deploy"
-
-do_deploy[cleandirs] += "${DEPLOYDIR_U_BOOT}"
-do_deploy[sstate-inputdirs] = "${DEPLOYDIR_U_BOOT}"
-do_deploy[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
-do_deploy() {
+do_deploy_firmware() {
     dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
         tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
-        > "${DEPLOYDIR_U_BOOT}/firmware.bin"
-}
-
-python do_deploy_setscene () {
-    sstate_setscene(d)
+        > "${DEPLOYDIR_FIRMWARE}/firmware.bin"
 }
-addtask do_deploy_setscene
-
-addtask deploy after do_dpkg_build before do_deploy_deb
-- 
2.39.2


