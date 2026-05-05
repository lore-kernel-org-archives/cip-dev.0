Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A8CD3430
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 06:57:19 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33679.1777964235200768806
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 23:57:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=AeqpMV6L;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-20260505065712e632eb78cd0002078e-l0eb2_@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260505065712e632eb78cd0002078e
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 08:57:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wedTFJK9q2A2jUbklZUGcXbvg8oGg/UXul4iP/UoiHU=;
 b=AeqpMV6LhudHyw6aPnBfW6gzoywGrIWsJKC3BtfFbkZ8lLzMWM9xuDjB+7Dek6RguQ7N0H
 zW+6FM/qFj8jbzrHVpAM5VyJnjsMsSgofjFJ0IshFjlujbV8okwV84QO3YAouqGL3QOsIVQ5
 hFu6dTLSTzqcuE4rWPOtvjgF1FfeCaPJOQ9VED+yT2uEDkKxUJTBvuMgmZObyIgnPCy8z887
 KdA/+QgIUZaVuGZ9UouDmaBojPq3uQlAyEeTClYduxjqdngzS25wNg/zwCMDnyVxejApueZc
 +xsYKbexykhNr2ZzghqOsvzv8xUNYTejwqpSiNaJDDPd4jhAObCrJ94g==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: [RFC][PATCH 6.12.y-cip 10/12] ARM: move FSR fault status definitions before fsr_fs()
Date: Tue,  5 May 2026 08:57:04 +0200
Message-ID: <2e82cd0c8fba691bfe9f1250fbeefd5f3d40220b.1777964226.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22879

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit a542de4451093f310d20e3d65d62ab4f4d38241f ]

The FSR's fault status bits depend on whether LPAE is enabled. Rather
than always exposing both LPAE and non-LPAE to all code, move them
inside the ifdef blocks dependent on LPAE to restrict their visibility.
No code other than fsr_fs() makes use of these.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index d2bdedaefe149..44c0fad29cce3 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -8,9 +8,6 @@
 #define FSR_LNX_PF		BIT(31)
 #define FSR_CM			BIT(13)
 #define FSR_WRITE		BIT(11)
-#define FSR_FS4			BIT(10)
-#define FSR_FS3_0		GENMASK(3, 0)
-#define FSR_FS5_0		GENMASK(5, 0)
 
 #ifdef CONFIG_ARM_LPAE
 #define FSR_FS_AEA		17
@@ -18,6 +15,8 @@
 #define FS_PERM_NOLL		0xC
 #define FS_MMU_NOLL_MASK	0x3C
 
+#define FSR_FS5_0		GENMASK(5, 0)
+
 static inline int fsr_fs(unsigned int fsr)
 {
 	return fsr & FSR_FS5_0;
@@ -29,6 +28,9 @@ static inline int fsr_fs(unsigned int fsr)
 #define FS_L1_PERM		0xD
 #define FS_L2_PERM		0xF
 
+#define FSR_FS4			BIT(10)
+#define FSR_FS3_0		GENMASK(3, 0)
+
 static inline int fsr_fs(unsigned int fsr)
 {
 	return (fsr & FSR_FS3_0) | (fsr & FSR_FS4) >> 6;
-- 
2.47.3


