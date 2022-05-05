Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48C3C433FE
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 16:43:38 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.13764.1651769015105523487
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 09:43:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Cx0EIKS1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-20220505164333be744d1423d00418cd-ugu5qu@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220505164333be744d1423d00418cd
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 May 2022 18:43:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mXv2P4MwnBJxlCvTGoPqN3icakHbb0rep6WZaUFFgV4=;
 b=Cx0EIKS1R7JsLwNvsikGG/dAgIDHWHcGiZKmamPneg/+ni0Y2kI9hGIfQ9VfVxXRE0JtSE
 OxRf8BWVTVa4Pfm3j7XWkRBStvzY7LF8TkZamCsBZDjZbUkSjc1TVztbSOhuptubR4orPcpA
 2PVLGDc3tJ73dQn0ctPUXei1H9QnA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 06/13] linux-cip: Update to 4.19.239-cip72
 and 5.10.112-cip6
Date: Thu,  5 May 2022 18:43:22 +0200
Message-Id: 
 <cb388d29742dbff98818c7eb08ce24a39f865b23.1651769009.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651769009.git.jan.kiszka@siemens.com>
References: <cover.1651769009.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 16:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8257

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{linux-cip_4.19.235-cip70.bb => linux-cip_4.19.239-cip72.bb} | 2 +-
 .../{linux-cip_5.10.106-cip4.bb => linux-cip_5.10.112-cip6.bb}  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.235-cip70.bb => linux-cip_4.19.239-cip72.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.106-cip4.bb => linux-cip_5.10.112-cip6.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.235-cip70.bb b/recipes-kernel/linux/linux-cip_4.19.239-cip72.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.235-cip70.bb
rename to recipes-kernel/linux/linux-cip_4.19.239-cip72.bb
index eaad5e8..718bbfb 100644
--- a/recipes-kernel/linux/linux-cip_4.19.235-cip70.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.239-cip72.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "b3bcb1ffd82c2ccdcb96aba55bdc46c72db12b6b5442591f804c8e298ad405c4"
+SRC_URI[sha256sum] = "5f22ea902c89b1cd178706411e48a40613c1db069fa7dc5993b979fd4652c2cd"
diff --git a/recipes-kernel/linux/linux-cip_5.10.106-cip4.bb b/recipes-kernel/linux/linux-cip_5.10.112-cip6.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.106-cip4.bb
rename to recipes-kernel/linux/linux-cip_5.10.112-cip6.bb
index 2f52cdb..b54dcb5 100644
--- a/recipes-kernel/linux/linux-cip_5.10.106-cip4.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.112-cip6.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "512787b7f75b25e2c7f64978957bb2e6613e7c9edccc6d677ddd256109244d25"
+SRC_URI[sha256sum] = "aedeaefcb3da02fe6ab36859eb15c2e36844b2a0ea828a902b85037ad145e1ee"
-- 
2.34.1


