Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21260CD3439
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 06:57:19 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33678.1777964234113819111
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 23:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=eAeU4HWn;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-2026050506571294e23f802b000207c5-1dxtch@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026050506571294e23f802b000207c5
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 08:57:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+n04mmC2y79FnBAhpYRn72pdIKc26uln5axhQ3gbaYM=;
 b=eAeU4HWnTQJ2/1Z6m6azzlI6zyCtCVn5PCtXzH241apUCMmcb3fTyfKe+OkOiHCXLgI9PZ
 YNnlazACs1iHo0PpsOEO9jFNCuNF8Wgnbhkg5yYt33N/jNTG4/XMllj0RMtZMvTzAIjtm6aU
 ZSJEPT1r7LzOA1lCBnNPf6hkbZCDapCIVNzhmkk3JK27o6C+fpCM0zG7OtnCZtXvu5MeFB6O
 r8fQY487iZ8F5iXAs2WhFvJtggiIrJVkSXDEIcYN5x6Q3WhnuSYN+H1f/fzK7iZo6Sbalpcu
 NMixsW2otHvCqMc93rN5KMpnTSFpu6Kgo8y5Hspx30A857kNOdzDurWg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: [RFC][PATCH 6.12.y-cip 09/12] ARM: use BIT() and GENMASK() for fault status register fields
Date: Tue,  5 May 2026 08:57:03 +0200
Message-ID: <511f4fef1dff4bf58f946730af416eccff5ab1e7.1777964226.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1777964226.git.jan.kiszka@siemens.com>
References: <cover.1777964226.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 06:57:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22877

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit 5548e8a4663d9decc8215c53e4a41c704f183cbb ]

Modernise the fault status field definitions by using BIT() and
GENMASK().

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index e95f44757dc96..d2bdedaefe149 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -5,12 +5,12 @@
 /*
  * Fault status register encodings.  We steal bit 31 for our own purposes.
  */
-#define FSR_LNX_PF		(1 << 31)
-#define FSR_CM			(1 << 13)
-#define FSR_WRITE		(1 << 11)
-#define FSR_FS4			(1 << 10)
-#define FSR_FS3_0		(15)
-#define FSR_FS5_0		(0x3f)
+#define FSR_LNX_PF		BIT(31)
+#define FSR_CM			BIT(13)
+#define FSR_WRITE		BIT(11)
+#define FSR_FS4			BIT(10)
+#define FSR_FS3_0		GENMASK(3, 0)
+#define FSR_FS5_0		GENMASK(5, 0)
 
 #ifdef CONFIG_ARM_LPAE
 #define FSR_FS_AEA		17
-- 
2.47.3


