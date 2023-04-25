Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D943C77B61
	for <webhook@archiver.kernel.org>; Tue, 25 Apr 2023 12:54:38 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.71231.1682393582026839571
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Apr 2023 20:33:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=Pm7CZ3DE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-202304250332589267ea8444d16225e1-v19yv2@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202304250332589267ea8444d16225e1
        for <cip-dev@lists.cip-project.org>;
        Tue, 25 Apr 2023 05:32:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=k2/K1T3p/F86b3yH2/V5KukHZFx7qonUU/ao5p7jod8=;
 b=Pm7CZ3DEtiOiUxRNH/nN1K+7zIn778/duYvSAIi7AlKqrJnzH/tqjDtT/S6vpRrmNnJE6a
 XiO5rB4nCGrW40rNr/VAFg9YpXvtLugzc9xGKBgiUuAYIWmTGAFh3RPTPW914Vian6Lw1D4R
 wbIHNx8kw7D+lXWNWf8uP8x1qqMIE=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] refactor deploy of OVMF binaries
Date: Tue, 25 Apr 2023 11:32:45 +0800
Message-Id: <20230425033246.1199444-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Apr 2023 12:54:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11348

Instead of deploying the OVMF binaries via a dummy package, we directly
deploy them as part of the imaging. This avoids the insertion of the
dummy package into the apt repo, speeds up the build and simplifies the
logic.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kas/opt/ebg-swu.yml                           |  2 +-
 recipes-core/images/deploy-ovmf.inc           | 21 +++++++++++
 recipes-devtools/ovmf-binaries/files/rules    | 17 ---------
 .../ovmf-binaries/ovmf-binaries_0.1.bb        | 35 -------------------
 4 files changed, 22 insertions(+), 53 deletions(-)
 create mode 100644 recipes-core/images/deploy-ovmf.inc
 delete mode 100644 recipes-devtools/ovmf-binaries/files/rules
 delete mode 100644 recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 203a6b9..1c12ad5 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -25,7 +25,7 @@ local_conf_header:
     INITRAMFS_INSTALL:append = " initramfs-abrootfs-hook"
   firmware-binaries: |
     # Add ovmf binaries for qemu
-    IMAGER_BUILD_DEPS:append:qemu-amd64 = " ovmf-binaries"
+    CIP_IMAGE_OPTIONS:append:qemu-amd64 = " deploy-ovmf.inc"
     # not needed for Debian 11 and later
     DISTRO_APT_SOURCES:append:qemu-amd64:buster = " conf/distro/debian-buster-backports.list"
     DISTRO_APT_PREFERENCES:append:qemu-amd64:buster = " conf/distro/preferences.ovmf-snakeoil.conf"
diff --git a/recipes-core/images/deploy-ovmf.inc b/recipes-core/images/deploy-ovmf.inc
new file mode 100644
index 0000000..0ec8762
--- /dev/null
+++ b/recipes-core/images/deploy-ovmf.inc
@@ -0,0 +1,21 @@
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
+# This recipe deploys the OVMF binaries to run the image in QEMU
+# Note: x86 only
+
+IMAGER_INSTALL += "ovmf"
+
+do_deploy_ovmf_binaries[cleandirs] += "${DEPLOY_DIR_IMAGE}/OVMF"
+do_deploy_ovmf_binaries() {
+    cp -v ${BUILDCHROOT_DIR}/usr/share/OVMF/*.fd ${DEPLOY_DIR_IMAGE}/OVMF
+}
+
+addtask deploy_ovmf_binaries after do_install_imager_deps before do_image
diff --git a/recipes-devtools/ovmf-binaries/files/rules b/recipes-devtools/ovmf-binaries/files/rules
deleted file mode 100644
index dcbef80..0000000
--- a/recipes-devtools/ovmf-binaries/files/rules
+++ /dev/null
@@ -1,17 +0,0 @@
-#!/usr/bin/make -f
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# This file is subject to the terms and conditions of the MIT License.
-# See COPYING.MIT file in the top-level directory.
-#
-
-override_dh_auto_configure:
-	mkdir -p /home/builder/ovmf-binaries/image/var/share/
-	cp -r /usr/share/OVMF /home/builder/ovmf-binaries/image/var/share/
-
-%:
-	dh $@
diff --git a/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb b/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
deleted file mode 100644
index 0f4592a..0000000
--- a/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
+++ /dev/null
@@ -1,35 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit dpkg-raw
-
-DESCRIPTION = "Copy the OVMF biniaries from the build changeroot to the deploy dir"
-
-# this is a empty debian package
-SRC_URI = "file://rules"
-
-DEBIAN_BUILD_DEPENDS = "ovmf"
-
-SSTATETASKS = ""
-
-do_install() {
-     install -v -d ${D}/var/share
-     touch ${D}/var/share/test
-}
-
-do_deploy() {
-    install -m 0755 -d ${DEPLOY_DIR_IMAGE}
-    dpkg --extract ${WORKDIR}/${PN}_${PV}*.deb ${WORKDIR}
-    cp -r ${WORKDIR}/var/share/OVMF ${DEPLOY_DIR_IMAGE}
-}
-addtask do_deploy after do_dpkg_build before do_deploy_deb
-
-
-- 
2.39.2


