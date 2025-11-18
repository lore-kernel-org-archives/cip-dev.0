Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F448CED247
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 06:09:17 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6478.1763446148728117963
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 22:09:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=UXZh2c0x;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20251118060905cf5a894a7300020763-meehxg@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251118060905cf5a894a7300020763
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Nov 2025 07:09:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pKpkG+uAoaY9Zk58i8RBTy8pWxT6yLbwAr6UHP9WHRA=;
 b=UXZh2c0x+M66isnVHFEhCkaLMF0iw3rVL24lucukeuDX0Xh6aOlV9i2nAssqBujGhJdmNX
 T8XJ7MQIWNPgxT+FAj+szVjRL7FTwX87D4fwAM5ORTzWP9MQs4xzwCXC/heqRDO1ucjXyxFp
 5jzmzskW4CdYB4yv3C1m3uV4Cx6Y2kZxO8SWy/5ZQhQjOgMutXKHtmdkfmCWnxSmvuzIZ1Hm
 DH6MaSKPJ8ilITFVgpdzKMPfOLIJKWSyCokA68TB2JCPIk58NT0H0FH6xa/Z6OVzFz4uyFVO
 4dHBcH/QaEgJrp11/3aobXQpUqufTpge6O86HcoSE94KyA+GL5dHxu8g==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 4/4] ci: Add DE0-Nano-SoC board
Date: Tue, 18 Nov 2025 07:09:04 +0100
Message-ID: <4d7fa83ea454a3301151cfdf22bbf64cfc3569a8.1763446144.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763446144.git.jan.kiszka@siemens.com>
References: <cover.1763446144.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 06:09:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20607

From: Jan Kiszka <jan.kiszka@siemens.com>

Just a basic build test.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 440d0267..28b235d1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -103,6 +103,13 @@ build:bbb-base:
     target: bbb
     dtb: am335x-boneblack.dtb
 
+build:de0-nano-soc-base:
+  extends:
+    - .build_base
+  variables:
+    target: de0-nano-soc
+    dtb: socfpga_cyclone5_de0_nano_soc.dtb
+
 build:iwg20m-base:
   extends:
     - .build_base
-- 
2.51.0


