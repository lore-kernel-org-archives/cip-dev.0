Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C90CD4851
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 05:48:32 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50617.1778508195750616921
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 May 2026 07:03:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=0ORC6IDJ;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=gDxn9kix;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778507646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYx6Mv08jw+CttVnUu1dcxJYEji9HDgJer+ugEWlfKw=;
	b=0ORC6IDJV4heAa9IZ6Z9Ado/DrXdcoJBkCeaWSYvX0WLJ13GwNSxBrtIe55Bqz32Obgnof
	squWIIgb2Rd4zEkc/+WmZO0nBix39tvqs3yWh4FddWGvZrGiiUKnTottNKhCI+vRxvUiDS
	b/OUatPIKVGabocpytb7eaI8I2Wa58fS2cx3CT1cNS/uX8d61MYGxv+5/kWZq5BNbTHAiE
	NxRuwC1IAgtNUW1nHU4BuWEam39yuInC2SQKftW0z/yWQTA4Rr0FILnPacw44Z3ImzAz4O
	HZci7lCH8+PLkziab5sygvO5U//WXj7spQS65PXjZ4Gb9QAqG6m+iueTOPwzyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778507646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYx6Mv08jw+CttVnUu1dcxJYEji9HDgJer+ugEWlfKw=;
	b=gDxn9kixMNmE1DS9O63BXgriLMTYZkIeV1UL1Rkkk/M0QRIPCHpAsbZEoL66XW66FWT0+I
	oqGDl6oO0oDIrZDw==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/4] ARM: allow __do_kernel_fault() to report execution of memory faults
Date: Mon, 11 May 2026 15:53:55 +0200
Message-ID: <20260511135357.2786242-3-bigeasy@linutronix.de>
In-Reply-To: <20260511135357.2786242-1-bigeasy@linutronix.de>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 May 2026 05:48:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22921

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit 40b466db1dffb41f0529035c59c5739636d0e5b8 upstream.

Allow __do_kernel_fault() to detect the execution of memory, so we can
provide the same fault message as do_page_fault() would do. This is
required when we split the kernel address fault handling from the
main do_page_fault() code path.

Reviewed-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Tested-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index f87f353e5a8b0..192c8ab196dba 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -175,6 +175,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long a=
ddr, unsigned int fsr,
 	 */
 	if (addr < PAGE_SIZE) {
 		msg =3D "NULL pointer dereference";
+	} else if (is_permission_fault(fsr) && fsr & FSR_LNX_PF) {
+		msg =3D "execution of memory";
 	} else {
 		if (is_translation_fault(fsr) &&
 		    kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
--=20
2.53.0


