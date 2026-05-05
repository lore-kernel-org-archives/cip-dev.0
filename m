Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1427DFF885A
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 06:57:19 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33455.1777964234494935320
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 23:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=bgxB8hrG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20260505065712fbe12ca71e000207fd-gn6smt@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260505065712fbe12ca71e000207fd
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 08:57:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=KtEBKHoBqfYUnBeuSuCXiIuL8qo2pFWzF56ZwS/1JyQ=;
 b=bgxB8hrGJjawoHChqQTcIUK9ScPgvbwr+i1aHlMUEkwSI2cOIpua4bqGHRss1v80MPXzMJ
 vZe3CJ83lvooyXQB8bHfM3dmPu3fHnaNahPA1Xd2wBBEn0zbht/e4xnWj2aPMjpSBIKD6m1N
 10tq7SsgTapPTg03mHhgmwR6OUxXV4jFEwVCyva2vCE/DCTa8YcInESHr9k1UiOcATtjZbbr
 jukkDW9EWHAUYTnX/sE/E7l0XgjapjNnmFgtZdDrzb8ViS/jKNBXoz/dpMjm5fhVjz6Htinc
 wSnfH8J94UNQ5vT8vBbZXJ5rFTvyyWx+u2iAN6zdI7lF83pqfgnPudDQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: [RFC][PATCH 6.12.y-cip 08/12] ARM: move is_permission_fault() and is_translation_fault() to fault.h
Date: Tue,  5 May 2026 08:57:02 +0200
Message-ID: <2aad422bd469d4ac638e7c623dcf483ac13ec951.1777964226.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22878

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit 9c46fcaf2efa78e814e102c5828cf5c825a133ec ]

is_permission_fault() and is_translation_fault() are both conditional
on the FSR encodings, which are dependent on LPAE. We define the
constants in fault.h. Move these inline functions to fault.h to be
near the FSR definitions.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.c | 26 --------------------------
 arch/arm/mm/fault.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index fabaefa26bb1c..04c2b48e02adc 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -115,32 +115,6 @@ static inline bool is_write_fault(unsigned int fsr)
 	return (fsr & FSR_WRITE) && !(fsr & FSR_CM);
 }
 
-static inline bool is_translation_fault(unsigned int fsr)
-{
-	int fs = fsr_fs(fsr);
-#ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_MMU_NOLL_MASK) == FS_TRANS_NOLL)
-		return true;
-#else
-	if (fs == FS_L1_TRANS || fs == FS_L2_TRANS)
-		return true;
-#endif
-	return false;
-}
-
-static inline bool is_permission_fault(unsigned int fsr)
-{
-	int fs = fsr_fs(fsr);
-#ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_MMU_NOLL_MASK) == FS_PERM_NOLL)
-		return true;
-#else
-	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
-		return true;
-#endif
-	return false;
-}
-
 static void die_kernel_fault(const char *msg, struct mm_struct *mm,
 			     unsigned long addr, unsigned int fsr,
 			     struct pt_regs *regs)
diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index e8f8c19025444..e95f44757dc96 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -35,6 +35,32 @@ static inline int fsr_fs(unsigned int fsr)
 }
 #endif
 
+static inline bool is_translation_fault(unsigned int fsr)
+{
+	int fs = fsr_fs(fsr);
+#ifdef CONFIG_ARM_LPAE
+	if ((fs & FS_MMU_NOLL_MASK) == FS_TRANS_NOLL)
+		return true;
+#else
+	if (fs == FS_L1_TRANS || fs == FS_L2_TRANS)
+		return true;
+#endif
+	return false;
+}
+
+static inline bool is_permission_fault(unsigned int fsr)
+{
+	int fs = fsr_fs(fsr);
+#ifdef CONFIG_ARM_LPAE
+	if ((fs & FS_MMU_NOLL_MASK) == FS_PERM_NOLL)
+		return true;
+#else
+	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
+		return true;
+#endif
+	return false;
+}
+
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
 void early_abt_enable(void);
 asmlinkage void do_DataAbort(unsigned long addr, unsigned int fsr,
-- 
2.47.3


