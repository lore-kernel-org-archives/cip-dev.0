Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E3FC35274
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 14:30:35 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.44721.1702909827898195528
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Dec 2023 06:30:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ALoq9mii;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20231218143024eb3f3c17c3b86293e3-eozpui@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20231218143024eb3f3c17c3b86293e3
        for <cip-dev@lists.cip-project.org>;
        Mon, 18 Dec 2023 15:30:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=OtGb6kZXTFUAA/1OObgsSVrzhIaviG+GAGsogJJdo7w=;
 b=ALoq9miiQhXt0ummyIWBO68rg1ip0jYcFXYgaDCefhAMbgjnxFjmdwzRUmcT5nL0CH6RPY
 VzmZE+LzLtD9Akmy3TNPPm++aTHTG37jTZc5gUkDGliWR8FEwMK+RbSUqLCbDtlZ4Y4iJHmG
 ZkbLXUlUFIre2pLlZBeZXGY74/qYw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] recipes-core/swupdate: Cleanup swupdate.inc
Date: Mon, 18 Dec 2023 15:30:02 +0100
Message-ID: <20231218143023.1507226-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Dec 2023 14:30:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14132

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

As software loads the bootloader libraries dynamically it is no longer
necessary to set the build loader with BUILD_PROFILES.

Also add PROVIDES for the additional packages swupdate provides.

The profile 'pkg.swupdate.nosigning' is automatically set if signing is
not set to `1`.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/swupdate/swupdate.inc        | 25 ++++++++++++++---------
 recipes-core/swupdate/swupdate_2023.05.bb |  9 --------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index e5e7282..4442ca5 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2022
+# Copyright (c) Siemens AG, 2021-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,15 +13,11 @@ HOMEPAGE= "https://github.com/sbabic/swupdate"
 LICENSE = "GPL-2.0"
 LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
 
-def get_bootloader_build_profile(d):
-    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
-    if bootloader == "efibootguard":
-        return "pkg.swupdate.efibootguard"
-    if bootloader == "u-boot":
-        return "pkg.swupdate.uboot"
-    return ""
+PROVIDES += "libswupdate-dev"
+PROVIDES += "libswupdate0.1"
+PROVIDES += "lua-swupdate"
 
-DEB_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
+DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not d.getVar('SWU_SIGNED') == '1' else ''}"
 
 def get_bootloader_dependencies(d):
     bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
@@ -33,13 +29,22 @@ def get_bootloader_dependencies(d):
         else:
             return "libubootenv"
     return ""
-
 DEPENDS += "${@get_bootloader_dependencies(d)}"
 DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
 
+# deactivate hardware compability for simple a/b rootfs update
+DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
+
+# suricatta wfx requires suricatta lua and the dependency
+# is not set automatically
+DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
+# add suricatta wfx
+DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
+
 python do_check_bootloader () {
     bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
     if not bootloader in ["efibootguard", "u-boot"]:
         bb.warn("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
 }
 addtask check_bootloader before do_fetch
+
diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
index 77b7431..e52a329 100644
--- a/recipes-core/swupdate/swupdate_2023.05.bb
+++ b/recipes-core/swupdate/swupdate_2023.05.bb
@@ -35,15 +35,6 @@ SRC_URI:append:bullseye = " file://0004-d-swupdate-www.install-Fix-path-for-debi
 # of update binaries
 # DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
 
-# deactivate hardware compability for simple a/b rootfs update
-DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
-
-# suricatta wfx requires suricatta lua and the dependency
-# is not set automatically
-DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
-# add suricatta wfx
-DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
-
 # Disable cross for arm and arm64 on bullseye
 # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
 ISAR_CROSS_COMPILE:bullseye = "0"
-- 
2.43.0


