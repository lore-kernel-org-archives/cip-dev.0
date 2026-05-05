Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44170CD343D
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 06:57:19 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33674.1777964232294387747
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 23:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=dWlT4+cW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-202605050657139aec302a1100020722-kzw_fm@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202605050657139aec302a1100020722
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 08:57:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cmBkksbkIBX429B/sGc/AnAdZdh3selaelR9uBipYHQ=;
 b=dWlT4+cWzU+UinP7AlVRXUViP/5/UlKis2AzuUUGCuaJkRo8XmCXKt9VDw2RVZ5gxCEyrJ
 LEuOI5HlLr0AhtYROt8meFkj+ixiTn7SDcMZ7iEWiUd/IEAyu14QLvClJTyhERLJhZAJKqxK
 ezGfp0F3xvQ+ngi5SO8rpIGJGr9FCc+YrZUmDVstiHm0E7CwGzKnhEFomWU1SHAhQPxuU89c
 4HNG6jVxBFQDdtBiAxOxAh2qyPD4tDT1sXX5n1B9wcfy+Q1LZgv3KKx11tJKLE5AUyXcDvBw
 GAHRj8+bnuy9IchxVT5kvj130loW8XVVxhkLCsZ/uiOE5E5bL2Hivdwg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: [RFC][PATCH 6.12.y-cip 11/12] ARM: provide individual is_translation_fault() and is_permission_fault()
Date: Tue,  5 May 2026 08:57:05 +0200
Message-ID: <54a0a2d0a1fabb8682e3fd0e2c75b9a2ef27192a.1777964226.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22875

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit d1fed2d600905e7f007d8c88c936b768d45c09d6 ]

Provide individual LPAE and non-LPAE definitions for both these
functions, rather than having ifdefs inside the function body. This
places the functions closer to their associated definitions.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.h | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index 44c0fad29cce3..207f1b06941de 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -21,6 +21,20 @@ static inline int fsr_fs(unsigned int fsr)
 {
 	return fsr & FSR_FS5_0;
 }
+
+static inline bool is_translation_fault(unsigned int fsr)
+{
+	int fs = fsr_fs(fsr);
+
+	return (fs & FS_MMU_NOLL_MASK) == FS_TRANS_NOLL;
+}
+
+static inline bool is_permission_fault(unsigned int fsr)
+{
+	int fs = fsr_fs(fsr);
+
+	return (fs & FS_MMU_NOLL_MASK) == FS_PERM_NOLL;
+}
 #else
 #define FSR_FS_AEA		22
 #define FS_L1_TRANS		0x5
@@ -35,33 +49,21 @@ static inline int fsr_fs(unsigned int fsr)
 {
 	return (fsr & FSR_FS3_0) | (fsr & FSR_FS4) >> 6;
 }
-#endif
 
 static inline bool is_translation_fault(unsigned int fsr)
 {
 	int fs = fsr_fs(fsr);
-#ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_MMU_NOLL_MASK) == FS_TRANS_NOLL)
-		return true;
-#else
-	if (fs == FS_L1_TRANS || fs == FS_L2_TRANS)
-		return true;
-#endif
-	return false;
+
+	return fs == FS_L1_TRANS || fs == FS_L2_TRANS;
 }
 
 static inline bool is_permission_fault(unsigned int fsr)
 {
 	int fs = fsr_fs(fsr);
-#ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_MMU_NOLL_MASK) == FS_PERM_NOLL)
-		return true;
-#else
-	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
-		return true;
-#endif
-	return false;
+
+	return fs == FS_L1_PERM || fs == FS_L2_PERM;
 }
+#endif
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
 void early_abt_enable(void);
-- 
2.47.3


