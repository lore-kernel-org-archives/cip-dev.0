Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D340C02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 05:31:37 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.14910.1739511087784890611
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Feb 2025 21:31:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=PNIWOUTA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1324425-20250214053124c0ac515f4d08346458-tbayt1@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250214053124c0ac515f4d08346458
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Feb 2025 06:31:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=1UOxn+wW4qBxSRAh4elxbYsM/bZdfA9kpBQFsFuJZZQ=;
 b=PNIWOUTAhPPnrDJ1faKVe3YvCe6/4YqRb/d5rTj6lX9ewHaW9S6azQqcCFzOZp4fCf+v99
 bTst3Lvmlc7dkHAK6BrvoEJw/LVTYu55CTGHl1WHL4i2iDrShyPh6y9tvBNFm8YnJY76TGZI
 1+AD0YoRUdEafEOK0n5DEyTg3Nv3292wNnNGapu+9s9zdydARh4u1Ggp8UW6Kl8T2s3XkGrs
 c0TS1qZtluSLQciWDRTfnyX4JXd1lW0GW/eISwO193h+xCbyi+sSdMraiOWHtwf8kaspc9Dk
 qtAz5xtWjCc5AErAIV3eMy4w9Yybpsi3A6zD0K1WV6/v1S803os1e7GA==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	srinuvasan <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] update cip-kernel-defconfig to the latest version
Date: Fri, 14 Feb 2025 11:01:27 +0530
Message-Id: <20250214053127.1152501-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 05:31:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17835

From: srinuvasan <srinuvasan.a@siemens.com>

This revision brings the CONFIG_EFIVAR_FS to read
the EFI (Extensible Firmware Interface) variable information via sysfs.

Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 53bee8f..e761957 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2024
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "e486c93a916cb6f78b4917b7345e8818f96069f9"
+SRCREV_cip-kernel-config ?= "6b5db480b7a43e0217b1fa58f487f0bb997743c7"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.39.5


