Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBFCC5478A
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 12:27:27 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.9033.1708506028853837985
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 01:00:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=PM+Bl3tb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1321639-20240221090025c38b66af5f410d9db1-bwdb_v@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240221090025c38b66af5f410d9db1
        for <cip-dev@lists.cip-project.org>;
        Wed, 21 Feb 2024 10:00:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=mGstNH/tMYZdX3o5nHuHHw/FpMivxryZ0k6A6ZLGcyc=;
 b=PM+Bl3tb7YD5uzuhZf/QIsGM/5qls3MU+FsairCYKjtzvU4cjtPl7Pc+c5IeMc03OTmtD7
 hxnNPOSiH591kD6S4hbskAnqnJwhw7pPJ8ZFi40fYaa4UtxB8BdMq5GklkBjxaA5CiebnZRa
 ME3BVL6cWIvIB6GgvzacGsBAdfQso=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Cheng shu Mou <chengshu.mou@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] swupdate: use to_boolean to compare boolean variables
Date: Wed, 21 Feb 2024 10:00:05 +0100
Message-Id: <20240221090005.54520-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 12:27:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15055

When checking if boolean wariables are enabled / disabled, a comparison
against "0" or "1" is error prone, as a user might use other values like
"True" to enable it. For that, bitbake offers the to_boolean.

Reported-by: Cheng shu Mou <chengshu.mou@siemens.com>
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-core/swupdate/swupdate.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index cb1716b..7a4214f 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -23,7 +23,7 @@ def get_bootloader_dependencies(d):
     if bootloader == "efibootguard":
         return "libebgenv-dev"
     if bootloader == "u-boot":
-        if d.getVar("U_BOOT_CONFIG_PACKAGE") == "1":
+        if bb.utils.to_boolean(d.getVar("U_BOOT_CONFIG_PACKAGE")):
             return "libubootenv u-boot-{}-config".format(d.getVar("MACHINE"))
         else:
             return "libubootenv"
@@ -32,7 +32,7 @@ def get_bootloader_dependencies(d):
 DEPENDS += "${@get_bootloader_dependencies(d)}"
 DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
 
-DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not d.getVar('SWU_SIGNED') == '1' else ''}"
+DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 # deactivate hardware compability for simple a/b rootfs update
 DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
-- 
2.39.2


