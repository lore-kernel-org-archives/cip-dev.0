Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46CBCD98F2
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 14:36:27 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40079.1782124446007683979
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 03:34:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=TBAwfk7z;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=kQrPozAc;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2X45r5/nbcYeSAfJf1pJIuSAN5ErvuGd3WnV2DwkAEQ=;
	b=TBAwfk7zKVLoiJZfRYUNuBvP343JaZmJcGhqAMLO9PGrMEO73PieFyPkIsdfwVGTx2ZbSY
	mNd8MQ+8CyNLZGEhMV4tPnXVXtDmdlFiJX8exX7HbpS6wgoSADnaKJ4jXKYfq7QjE5fDml
	8ZCQ/CqGCft2Mw8SWfkuryh1/o6kvnh810caggzi+yuEeOJS1AmgSsWOhta1znbH72apTY
	iayrqOHAW9EX0YTU/DcnLU22FpiDANeTXYGB1yVkdMeFceoawMZuiCpnKu/QmszPBo5iMM
	lgaGFDuAv15OBah6cnIAr2eyYKdySpR8bDL+4e0VQghurq3bDQxGsKdHYhEp1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2X45r5/nbcYeSAfJf1pJIuSAN5ErvuGd3WnV2DwkAEQ=;
	b=kQrPozAc74N6peBtJjT0+SnOBx9t/gJXO8Djcx3QXKT16Mc20UIR57JFsyu72KSzZ15WRP
	1mD6Qi2O7v4qh4AA==
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
Date: Mon, 22 Jun 2026 12:26:32 +0200
Message-ID: <20260622102634.780100-3-bigeasy@linutronix.de>
In-Reply-To: <20260622102634.780100-1-bigeasy@linutronix.de>
References: <20260622102634.780100-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 14:36:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23254

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit 40b466db1dffb41f0529035c59c5739636d0e5b8 upstream

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
index 879730a47c4a2..4c0ee81befb1e 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -176,6 +176,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long a=
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


