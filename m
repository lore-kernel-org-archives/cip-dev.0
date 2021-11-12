Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53A2C433EF
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 11:07:16 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.14299.1636715234864051078
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 03:07:15 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1ACB7CFx014728
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 12:07:13 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.150])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACB7CBB022456;
	Fri, 12 Nov 2021 12:07:12 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] swupdate.inc: Remove unnecessary
 defaults from getVar
Date: Fri, 12 Nov 2021 12:07:12 +0100
Message-Id: <20211112110712.160124-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 11:07:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6878

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Also 'TRUE' is not a valid value.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/swupdate/swupdate.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index 191aa2b..7812ae7 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -26,12 +26,12 @@ def get_bootloader_build_profile(d):
 SWUPDATE_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
 
 def get_bootloader_dependencies(d):
-    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or ""
+    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
     if bootloader == "efibootguard":
         return "efibootguard-dev"
     if bootloader == "u-boot":
-        if d.getVar("U_BOOT_CONFIG_PACKAGE", True) == "1":
-            return "libubootenv u-boot-{}-config".format(d.getVar("MACHINE", TRUE))
+        if d.getVar("U_BOOT_CONFIG_PACKAGE") == "1":
+            return "libubootenv u-boot-{}-config".format(d.getVar("MACHINE"))
         else:
             return "libubootenv"
     return ""
@@ -48,7 +48,7 @@ dpkg_runbuild_prepend() {
 }
 
 python do_check_bootloader () {
-    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or "None"
+    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
     if not bootloader in ["efibootguard", "u-boot"]:
         bb.warn("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
 }
-- 
2.30.2


