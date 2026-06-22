Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5204CDB46F
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 14:36:07 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39928.1782124448096872267
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 03:34:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=mfCJNwNQ;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=bZY5kRZ6;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOzEjx5PQnC9UfVnNe9RtDdPxKOBZ1MuHuIdqCNNaus=;
	b=mfCJNwNQ/g+J/avmfKLwQeiFGdzxxkpedm0m/PTMD4+V/YOidHVwXaVNzbyqJNjNBvRtQb
	pFcGhcgm3qhGhNyIWjcEEdF+brCLVfL6SK5sVoJDvVXnbKzcCvFh3dXviqidVsTBlbaSCf
	eVjd8yAFYIjzynOT8xtpbkZH0CVI6E345C6OhqUZN+0O8u1VBEj1NGmISCOKgAfvtv1kni
	8ccLgZBMpFVj/QynrOkasb/Fl4muO7Z4t/jWPY0Z2iGadrPru64jaBv+S8zBgnsWEzSyNV
	/lYJ7qCwBq4WJmjHGGXh2VoEkSGbrwMOLJ+pQwH4g4kclNFbSigrVGoHFKLG8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOzEjx5PQnC9UfVnNe9RtDdPxKOBZ1MuHuIdqCNNaus=;
	b=bZY5kRZ6cBpqeSAX3smnYBoQjCEcoZxXCLulWb/SNwQdtpotxEpZUla1UIRpq1/4HSV63O
	4V1MPGPFSKF2D0CA==
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
Date: Mon, 22 Jun 2026 12:26:31 +0200
Message-ID: <20260622102634.780100-2-bigeasy@linutronix.de>
In-Reply-To: <20260622102634.780100-1-bigeasy@linutronix.de>
References: <20260622102634.780100-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 14:36:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23252

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
index ed1a25f457e48..879730a47c4a2 100644
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
@@ -229,19 +242,6 @@ void do_bad_area(unsigned long addr, unsigned int fsr,=
 struct pt_regs *regs)
 #define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
 #define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
=20
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
 static int __kprobes
 do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
--=20
2.53.0


