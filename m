Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DB7C282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 05:53:57 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.7825.1741844525559238464
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 22:42:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm1 header.b=YXr9qFPV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1328765-202503130542029b92d4f4ed3b4abf87-ucxttp@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202503130542029b92d4f4ed3b4abf87
        for <cip-dev@lists.cip-project.org>;
        Thu, 13 Mar 2025 06:42:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=nksSBhvGLmZR2p/zgnqZiq/B1AbpL7JsN2w6HaGl/eg=;
 b=YXr9qFPVCullMEz7iisIfnlcU7arUQz13r3vBKLgUhYW/UAqsL9p1GQrhuzuElncvPndzz
 ovyM2uA85moazpfCiugi+cfGW35V6S+DVV1YT7ljbOvtTlYM/MJzdI/eQDG7TrMRY2c0WLLw
 Sh2xyL8iK9nwN5XJribVAPT7T9qTWbi3opXu91A9Woi0oKJVK+JXvBr7uV0FPap+6quUY9ZA
 f4iZVXWHfU3u72rQhwwyLLWJXS9J1Weyr2ND6cPOv2lqmgzDZgDHqdA4Sk05cCZjgX1U4a8g
 O73CbqAL450fz3zDn/GK1bMNB+Wt/4rWj1ijwI0ye5Sni+28tKKl1YZg==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	cedric.hombourger@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [PATCH][isar-cip-core] linux-cip: Update cip-kernel-config to latest revision
Date: Thu, 13 Mar 2025 11:11:55 +0530
Message-Id: <20250313054155.337079-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 05:53:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18179

Enabled CONFIG_EFIVAR_FS and CONFIG_BLK_DEV_NVME in 6.1+ kernel configurations
for simatic_ipc227e_defconfig:

* CONFIG_EFIVAR_FS: Read EFI variable information via sysfs
(e.g. for checking secure-boot status)

* CONFIG_BLK_DEV_NVME: Allows to recognize and use NVMe block devices

Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 53bee8f..3f9078d 100644
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
+SRCREV_cip-kernel-config ?= "fb0a224685c6ffecfc2e45ec3e4d84eb98727c4a"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.39.5


