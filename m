Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7261C41535
	for <webhook@archiver.kernel.org>; Tue, 19 Dec 2023 10:09:08 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.9093.1702980542829299463
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Dec 2023 02:09:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=c/wIhM6S;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2023121910085981b5c330972284e38e-oqa6xl@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023121910085981b5c330972284e38e
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Dec 2023 11:09:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=A+i0jscrSUdwpFDigtldeieLUCinpLVgiBLxuMrrx+w=;
 b=c/wIhM6SVlNZP9UQaUCYK62HWtBIX5a7aSj8VF1mLlyyGbWsHjUIOyHdGzxgP392BSDi1W
 d+eIRnH/oY6HCJKYXn4N9HN6D2Nvt8IEgZh+9ibWIMkCm51JCAiIbK4ZoFqzhseWOhcAdNKy
 JuzT+7g991ws43Ul2BeMbtXsxTM4k=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] recipes-core/swupdate: Cleanup swupdate.inc
Date: Tue, 19 Dec 2023 11:08:39 +0100
Message-ID: <20231219100858.1853427-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Dec 2023 10:09:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14135

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

As software loads the bootloader libraries dynamically it is no longer
necessary to set the build loader with BUILD_PROFILES.

Also add PROVIDES for the additional packages swupdate provides.

The profile 'pkg.swupdate.nosigning' is automatically set if signing is
not set to `1`.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - cleanup 2021.12 for debian buster
 - move cross and nocheck to swupdate.inc
 - move DEB_BUILD_PROFILES pkg.swupdate.suricatta* back to swupdate_2023.05
   as the apply only to this version

 recipes-core/swupdate/swupdate.inc            | 21 +++++++++++--------
 .../swupdate/swupdate_2021.11-1+debian-gbp.bb | 11 ----------
 recipes-core/swupdate/swupdate_2023.05.bb     | 10 ---------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index e5e7282..cb1716b 100644
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
@@ -13,15 +13,10 @@ HOMEPAGE= "https://github.com/sbabic/swupdate"
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
 
 def get_bootloader_dependencies(d):
     bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
@@ -37,6 +32,14 @@ def get_bootloader_dependencies(d):
 DEPENDS += "${@get_bootloader_dependencies(d)}"
 DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
 
+DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not d.getVar('SWU_SIGNED') == '1' else ''}"
+
+# deactivate hardware compability for simple a/b rootfs update
+DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
+
+# add cross build and deactivate testing for arm based builds
+DEB_BUILD_PROFILES += "cross nocheck"
+
 python do_check_bootloader () {
     bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
     if not bootloader in ["efibootguard", "u-boot"]:
diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index 8f7a97d..0f91d5e 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -27,17 +27,6 @@ SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
             file://0004-debian-rules-Add-option-to-disable-webserver.patch \
             file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
 
-# end patching for dm-verity based images
-
-# The option: "pkg.swupdate.nosigning" disables the required signing
-# of update binaries
-# DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
-
-# deactivate hardware compability for simple a/b rootfs update
-DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
-
-# add cross build and deactivate testing for arm based builds
-DEB_BUILD_PROFILES += "cross nocheck"
 # If the luahandler shall be embedded into the swupdate binary
 # include the following lines.
 # DEPENDS += "swupdate-handlers"
diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
index 77b7431..d1fe1fa 100644
--- a/recipes-core/swupdate/swupdate_2023.05.bb
+++ b/recipes-core/swupdate/swupdate_2023.05.bb
@@ -31,13 +31,6 @@ SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.pat
             file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch"
 SRC_URI:append:bullseye = " file://0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
 
-# The option: "pkg.swupdate.nosigning" disables the required signing
-# of update binaries
-# DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
-
-# deactivate hardware compability for simple a/b rootfs update
-DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
-
 # suricatta wfx requires suricatta lua and the dependency
 # is not set automatically
 DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
@@ -48,9 +41,6 @@ DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
 # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
 ISAR_CROSS_COMPILE:bullseye = "0"
 
-# add cross build and deactivate testing for arm based builds
-DEB_BUILD_PROFILES += "cross nocheck"
-
 # use backport build profile for bullseye
 DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
 
-- 
2.43.0


