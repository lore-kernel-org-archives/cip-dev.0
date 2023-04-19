Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104D4C77B73
	for <webhook@archiver.kernel.org>; Wed, 19 Apr 2023 13:04:50 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.29124.1681872566319495792
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Apr 2023 19:49:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=K0rqk08y;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-72506-2023041902492267b22d853a8d2443e7-a_9gn_@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023041902492267b22d853a8d2443e7
        for <cip-dev@lists.cip-project.org>;
        Wed, 19 Apr 2023 04:49:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=VXyCQlG5Vle/WTDsUOjpLFWofWOWI3AUzNDfI/Ua+LA=;
 b=K0rqk08yBevrmM7EVGsLaLJ/XfM9pZQdkaZTw5HRDkkJWje2s94jAXcpJeQdgrkdTcBcoD
 kabvClC/F+LSD5QFxRXOBQorlwRANtSV+i3cBw4BIT51k8hL+vgh8pPPdhQQdxGrVTHKGf6M
 s/VWWSyp2bFXbLDF5OAe+NgfPZlgQ=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] fix operator precedence in ebg and swupdate
Date: Wed, 19 Apr 2023 10:48:59 +0800
Message-Id: <20230419024859.19550-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Apr 2023 13:04:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11232

Instead of using the += operator, we need to use the :append operator to
append IMAGE_FSTYPES to a target. Otherwise, the additional types are
evaluated first and by that, weak assignments ( ?= ) are ignored.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kas/opt/swupdate.yml                 | 2 +-
 recipes-core/images/efibootguard.inc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 2899d6c..29b7dd6 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -20,7 +20,7 @@ local_conf_header:
 
   wic-swu: |
     IMAGE_TYPEDEP:wic += "squashfs"
-    IMAGE_FSTYPES += "swu"
+    IMAGE_FSTYPES:append = " swu"
     # squashfs is already compressed
     SWU_COMPRESSION_TYPE = ""
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
index bb1aa1d..23fb215 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -18,4 +18,4 @@ IMAGE_INSTALL:append:buster = " efibootguard"
 WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
 WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
-IMAGE_FSTYPES += "wic"
+IMAGE_FSTYPES:append = " wic"
-- 
2.39.2


