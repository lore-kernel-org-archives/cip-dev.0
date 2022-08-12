Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D36C00140
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 09:51:25 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web09.8963.1660297876162995885
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 02:51:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=Og3KgZim;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-20220812095114c5af4efafb47e71c72-_zpi6r@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220812095114c5af4efafb47e71c72
        for <cip-dev@lists.cip-project.org>;
        Fri, 12 Aug 2022 11:51:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MNZfxhqM2mfTDwNMgLPkYuddWasw0CBTezCl6VqcNPI=;
 b=Og3KgZimjndYBBQTVhoRLRsgDayj3bpR91WRMrUNOMGHWRIl5/JyitNz2nPfjQX2ppvavJ
 dA3hTOvnU1xYl2953tLjAdfrEfk8oGjL+0hmJrU+XIWxHexDqvaE8JGniL+/mEqssONgyxYu
 jkB6r0jxFbldjxJkISSgeqAbFitsE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 3/3] kas: Remove efibootguard.yml
Date: Fri, 12 Aug 2022 11:51:12 +0200
Message-Id: <20220812095112.632930-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220812095112.632930-1-Quirin.Gylstorff@siemens.com>
References: <20220812095112.632930-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 09:51:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9171

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

A build with only the option `kas/efibootguard.yml` will not succeed.
Move the content to a include in the image directory and the adapt the kas
files.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/ebg-secure-boot-snakeoil.yml |  7 +++--
 kas/opt/ebg-swu.yml                  | 18 ++++++++++---
 kas/opt/efibootguard.yml             | 39 ----------------------------
 recipes-core/images/efibootguard.inc | 18 +++++++++++++
 4 files changed, 36 insertions(+), 46 deletions(-)
 delete mode 100644 kas/opt/efibootguard.yml
 create mode 100644 recipes-core/images/efibootguard.inc

diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 3202076..ff65e99 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -12,17 +12,16 @@
 header:
   version: 10
   includes:
-   - kas/opt/efibootguard.yml
+    - kas/opt/ebg-swu.yml
 
 local_conf_header:
-  image-options-swupdate: |
-    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
-
   secure-boot-image: |
     IMAGE_CLASSES += "verity"
     IMAGE_FSTYPES = "wic"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL_append = " initramfs-verity-hook"
+    # abrootfs cannot be installed together with verity
+    INITRAMFS_INSTALL_remove = " initramfs-abrootfs-hook"
 
   secure-boot: |
     IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 5e4e771..e0bbe2e 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -12,12 +12,24 @@
 header:
   version: 10
   includes:
-   - kas/opt/efibootguard.yml
    - kas/opt/swupdate.yml
 
 local_conf_header:
+  ebg_swu_bootloader: |
+    WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
+    SWUPDATE_BOOTLOADER = "efibootguard"
+  ebg_swu_image_options: |
+    CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
   initramfs: |
     INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
+  firmware-binaries: |
+    # Add ovmf binaries for qemu
+    IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
+    # not needed for Debian 11 and later
+    OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
+    DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
+    DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
+    # Add U-Boot for qemu
+    IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
+    IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"
 
-  image-option-uuid: |
-    CIP_IMAGE_OPTIONS_append = " image-uuid.inc"
diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
deleted file mode 100644
index cee9c78..0000000
--- a/kas/opt/efibootguard.yml
+++ /dev/null
@@ -1,39 +0,0 @@
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
-# This kas file adds efibootguard as the bootloader to the image
-
-header:
-  version: 10
-
-local_conf_header:
-  efibootguard: |
-    IMAGE_INSTALL_append = " efibootguard"
-
-  efibootguard-swupdate: |
-    SWUPDATE_BOOTLOADER = "efibootguard"
-
-  efibootguard-wic: |
-    WIC_IMAGER_INSTALL_append = " efibootguard"
-    WDOG_TIMEOUT ?= "60"
-    WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
-    IMAGE_FSTYPES ?= "wic"
-    WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
-
-  firmware-binaries: |
-    # Add ovmf binaries for qemu
-    IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
-    # not needed for Debian 11 and later
-    OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
-    DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
-    DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
-    # Add U-Boot for qemu
-    IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
-    IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"
diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
new file mode 100644
index 0000000..eace4fd
--- /dev/null
+++ b/recipes-core/images/efibootguard.inc
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+IMAGE_INSTALL_append = " efibootguard"
+
+WIC_IMAGER_INSTALL_append = " efibootguard"
+WDOG_TIMEOUT ?= "60"
+WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
+IMAGE_FSTYPES += "wic"
+
-- 
2.35.1


