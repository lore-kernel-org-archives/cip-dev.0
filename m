Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17613C433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 12:57:05 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web08.4038.1665147416847953581
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 05:56:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.95,166,1661846400";
   d="scan'208";a="84165877"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 07 Oct 2022 04:56:51 -0800
IronPort-SDR: 
 0PdzdOuxJ4y7ncKhf6QuvqiPVGIFoAri31gjxvB5sLVzyjeR5bF+z7Wm1ycpottD6KtEzFsKvL
 z2I2NBwqwi5gmxtC1j55aYg6JYmVz0syICki8RQ578y8Yr0SsPHrx7RVAIceOjCISEDYZ9RbvQ
 KzBQwlXbDeWDcMIxW0Cv1oPiPBjcRRrDwl9mn3rlgCPF5faXs1Cc5PsQiLCPNKqqrWk5lmebsN
 lu/C4F4sO+f0P50Pl/XBhHb4JzKMoOiXONC8A4XO5BnTCcP3eHE1ygk4nzvtKd7ugtHzMxSLLe
 qv8=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-core][PATCH] Remove BASE_DISTRO_CODENAME from OVERRIDES
 variable list
Date: Fri, 7 Oct 2022 18:26:30 +0530
Message-ID: <20221007125630.3665599-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 12:57:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9692

From: Srinuvasan A <srinuvasan_a@mentor.com>

In this commit "71039175" onwords ISAR supports additional overrides ie:
BASE_DISTRO_CODENAME, hence remove the local one.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 kas/opt/ebg-swu.yml                            | 4 +---
 recipes-core/images/cip-core-image-security.bb | 2 --
 recipes-core/swupdate/swupdate.inc             | 4 +---
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index b534c50..62889fb 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -27,10 +27,8 @@ local_conf_header:
     # Add ovmf binaries for qemu
     IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
     # not needed for Debian 11 and later
-    OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
     DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
     DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
     # Add U-Boot for qemu
     IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
     IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"
-
diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 8ea032c..58a0f98 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -40,8 +40,6 @@ IMAGE_PREINSTALL += " \
 	util-linux \
 "
 
-OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
-
 # Package names based on the distro version
 IMAGE_PREINSTALL_append_buster = " libtss2-esys0"
 IMAGE_PREINSTALL_append_bullseye = " libtss2-esys-3.0.2-0"
diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index f2d478d..72c116a 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,8 +13,6 @@ HOMEPAGE= "https://github.com/sbabic/swupdate"
 LICENSE = "GPL-2.0"
 LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
 
-OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
-
 def get_bootloader_build_profile(d):
     bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
     if bootloader == "efibootguard":
-- 
2.25.1


