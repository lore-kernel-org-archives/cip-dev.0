Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C9CC433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:05:19 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web11.10264.1639659913028134020
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 05:05:18 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: vijaikumar_kanagarajan@mentor.com)
IronPort-SDR: 
 CS4PMezpWgJSvOgxbniJ7t4Jv0eosWJtuI7DbKmQ3pJiLrlogIwXR14OYmimE0qnd49GaA0MWx
 dVaqOu5vPrjKXDX/xotClSUopATcos/OE3Q9sr3pmFuZiWWN/0pPFgBr3EdwZIvU4dbAnjcedl
 ANLP8rV3LPkTps/IJaFw904inFV3MKHM9r7iYsehc3jxECquc6u/3Oycr0LpvAfvApBlQ5cOtm
 F/E2wrWwkdYwEvtQUijwp7STCkbgoPv7BkayMQmoRwZrWRwsukMdkVdgAeyAfu2VKPzLHVApAG
 KRFuvb9Pi1fSGAOTsujN4rd8
X-IronPort-AV: E=Sophos;i="5.88,211,1635235200";
   d="scan'208";a="69782862"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 16 Dec 2021 05:05:17 -0800
IronPort-SDR: 
 ezQ4y+Hsa2fDrMVaAIYnviCbRxdM2JZyK8O+9x387Q4C/DKNmdEHYlDR+0ltMsVSzpXbPGaZba
 eJxhf1ATiblPx998EhSAxIn//XI6JCiceGYPT5/UDS40necYmcI0jCs5LgeThIJ3p9RLtIGjDZ
 fepaZypsyT3xmkYgf7f76tOr6VNhTpenaWpJGsEbMjJ3ySUEA36wLSC7NJhPjCekzx7c6VpigU
 Ho/07E1rvu1g5z65MEzNk/00AZ/i6dC7Wmb1bpj5wmgzT0kn9oDrlUUqBLkx6dXlWaoE7EqQag
 9M0=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [isar-cip-core][PATCH 2/2] swupdate: Drop conditional includes for
 buster
Date: Thu, 16 Dec 2021 18:34:50 +0530
Message-ID: <20211216130450.3402865-3-Vijaikumar_Kanagarajan@mentor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216130450.3402865-1-Vijaikumar_Kanagarajan@mentor.com>
References: <20211216130450.3402865-1-Vijaikumar_Kanagarajan@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 13:05:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7150

Stretch in now dropped. The conditional includes for buster is now not
needed. Those includes are applicable to buster as well as bullseye.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 .../swupdate/swupdate_2021.04-1+debian-gbp.bb  | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
index a4d67fe..826982a 100644
--- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
@@ -23,7 +23,8 @@ SRC_URI += "file://0001-debian-Add-option-to-build-with-efibootguard.patch \
             file://0005-debian-rules-Add-option-to-disable-fs-creation.patch \
             file://0006-debian-rules-Add-option-to-disable-webserver.patch \
             file://0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
-            file://0008-debian-rules-Add-Embedded-Lua-handler-option.patch"
+            file://0008-debian-rules-Add-Embedded-Lua-handler-option.patch \
+            file://0009-debian-prepare-build-for-isar-debian-buster.patch"
 
 # Patch for dm-verity based images - can be removed with next SWUpdate release
 SRC_URI += "file://0001-debian-patches-add-patches-for-dm-verity.patch"
@@ -41,15 +42,12 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
 # GBP_DEPENDS += "swupdate-handlers"
 # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
 
-# modify for debian buster build
-SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
-
-# disable documentation due to missing packages in debian buster
-# disable create filesystem due to missing symbols in debian buster
-# disable webserver due to missing symbols in debian buster
-SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
-                                          pkg.swupdate.nocreatefs \
-                                          pkg.swupdate.nowebserver "
+# disable documentation due to missing packages
+# disable create filesystem due to missing symbols
+# disable webserver due to missing symbols
+SWUPDATE_BUILD_PROFILES_append = " nodoc \
+                                   pkg.swupdate.nocreatefs \
+                                   pkg.swupdate.nowebserver "
 # In debian buster the git-compression defaults to gz and does not detect other
 # compression formats.
 GBP_EXTRA_OPTIONS += "--git-compression=xz"
-- 
2.25.1


