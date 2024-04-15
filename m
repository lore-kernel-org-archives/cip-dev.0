Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9F5C4345F
	for <webhook@archiver.kernel.org>; Mon, 15 Apr 2024 09:57:56 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.17247.1713175074115107365
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Apr 2024 02:57:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Yfj13xZ6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240415095750e1db6f3e5d4ec61e67-ll9fdf@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240415095750e1db6f3e5d4ec61e67
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Apr 2024 11:57:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=vv+bJFADBtGeQqQwNLAAdo+/Tdq20Bt5f0FKGRBCs9o=;
 b=Yfj13xZ6fA9XZ+dDH/Y+7x/jptj6lWAK/X3PcFe6l9aQWsXYOsdS428ygsxdMEP9+vFx1Z
 3SCCnf2bxnVrTx7ShleR1dgqLqAhfXnMr4jkPn1ve7k+PN2YzrymUnqaLzROmFYXHZGJpv/n
 qryyupmhMyHH90/1MPE+wipeulceA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	hannah.kiekens@essensium.com,
	cip-dev@lists.cip-project.org,
	tobias.schaffner@siemens.com
Subject: [cip-core][isar-cip-core][PATCH] fix: swupdate_2021.11 with efibootguard
Date: Mon, 15 Apr 2024 11:54:19 +0200
Message-ID: <20240415095749.572576-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Apr 2024 09:57:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15557

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes a regression introduced with
5e2c207abae61e073bc732d0b93ba390891cd0c7 by readding the bootloader
selection with DEB_BUILD_PROFILES for SWUpdate 2021.11.

SWUpdate 2021.11 selects the bootloader at  compile time instead
of runtime. This fixes the following error message during installing
a binary update:

 [INFO ] : SWUPDATE running :  Installation in progress
 [TRACE] : SWUPDATE running :  [install_single_image] : Found installer
 for stream cip-core-image-cip-core-bookworm-qemu-amd64.squashfs roundrobin
 [TRACE] : SWUPDATE running :  [notify_helper] : Round Robin Handler: No
 compiled-in config found, trying /etc/swupdate.handler.ini
 [ERROR] : SWUPDATE failed [0] ERROR : Round Robin Handler: Error getting
 key 'kernelfile' from bootloader environment.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index 0039116..bb98ede 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -33,6 +33,15 @@ SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
 # DEPENDS += "swupdate-handlers"
 # GBP_DEPENDS += "swupdate-handlers"
 # DEB_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
+def get_bootloader_build_profile(d):
+    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
+    if bootloader == "efibootguard":
+        return "pkg.swupdate.efibootguard"
+    if bootloader == "u-boot":
+        return "pkg.swupdate.uboot"
+    return ""
+
+DEB_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
 
 # modify for debian buster build
 SRC_URI:append = " file://0006-debian-prepare-build-for-isar-debian-buster.patch"
-- 
2.43.0


