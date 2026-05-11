Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91382CD4851
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 05:48:52 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50615.1778508195702615846
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 May 2026 07:03:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=0njHzECi;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=9KB3Reu2;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778507646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxi/omoNKx/f8xZACdBlQuKWpQOa02gjt0ViDI9JDrM=;
	b=0njHzECiaeqtDPqrVgsdUWbvdsRhgEj6cX1Ile3UxW6vZSneRLWp9c/mXnXbOT+RJlE5qt
	iHA9f7fTtZOQCG+ysoAL3Usekm3gYifLrGDLNHyjlTXjW+eFVxBshPORPnA/WGocRVAeiM
	2vEkSBdeeQFNANpW7biSlwKxAH4g12kRqhdpZXYU+u7SeUxsQHs7h+ahXBmCuv1WPpKLyY
	5zdRTT2pAfoUAHuyWZcKJghF1iqaP64tbraIQ3EmUJyFpXOPbS1Ubjl9p9OIowtyiWz52P
	7hnO3/gfSYEMA/1qD/RnJIDXj2kfkeTudB0kYq7Pw9WrDc8m9J6hzCBmgMqCXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778507646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxi/omoNKx/f8xZACdBlQuKWpQOa02gjt0ViDI9JDrM=;
	b=9KB3Reu2x1/J7p9weSqHja3sh8ZnXY71D26q+t9yO9aN2+YnFb2V7jE8CWhsAGWp9abkk7
	MXN74zXleQ2Bz0Dg==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/4] ARM: group is_permission_fault() with is_translation_fault()
Date: Mon, 11 May 2026 15:53:54 +0200
Message-ID: <20260511135357.2786242-2-bigeasy@linutronix.de>
In-Reply-To: <20260511135357.2786242-1-bigeasy@linutronix.de>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 May 2026 05:48:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22924

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit dea20281ac88226615761c570c8ff7adc18e6ac2 upstream.

Group is_permission_fault() with is_translation_fault(), which is
needed to use is_permission_fault() in __do_kernel_fault(). As
this is static inline, there is no need for this to be under
CONFIG_MMU.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2bc828a1940c0..f87f353e5a8b0 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -128,6 +128,19 @@ static inline bool is_translation_fault(unsigned int f=
sr)
 	return false;
 }
=20
+static inline bool is_permission_fault(unsigned int fsr)
+{
+	int fs =3D fsr_fs(fsr);
+#ifdef CONFIG_ARM_LPAE
+	if ((fs & FS_MMU_NOLL_MASK) =3D=3D FS_PERM_NOLL)
+		return true;
+#else
+	if (fs =3D=3D FS_L1_PERM || fs =3D=3D FS_L2_PERM)
+		return true;
+#endif
+	return false;
+}
+
 static void die_kernel_fault(const char *msg, struct mm_struct *mm,
 			     unsigned long addr, unsigned int fsr,
 			     struct pt_regs *regs)
@@ -225,19 +238,6 @@ void do_bad_area(unsigned long addr, unsigned int fsr,=
 struct pt_regs *regs)
 }
=20
 #ifdef CONFIG_MMU
-static inline bool is_permission_fault(unsigned int fsr)
-{
-	int fs =3D fsr_fs(fsr);
-#ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_MMU_NOLL_MASK) =3D=3D FS_PERM_NOLL)
-		return true;
-#else
-	if (fs =3D=3D FS_L1_PERM || fs =3D=3D FS_L2_PERM)
-		return true;
-#endif
-	return false;
-}
-
 #ifdef CONFIG_CPU_TTBR0_PAN
 static inline bool ttbr0_usermode_access_allowed(struct pt_regs *regs)
 {
--=20
2.53.0


