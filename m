Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D84DCD13DA
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 06:57:19 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33452.1777964231126534913
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 23:57:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=J2C0XDy4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20260505065708cb81029c86000207f8-xpzdfn@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260505065708cb81029c86000207f8
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 08:57:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wPtimJcfxpZNwzcXCpubFbwEfSyKwMp6xqLnskwo4TE=;
 b=J2C0XDy4R04vzqHhG5uJJCvpOsdgF0TNcWLkf9qPa5xihYau8f5M0WRS2ZOfBmMUmMJ7R7
 b7hW8uNq/OE6B72jkBIqoNZMeqxIzrkQm4JPFVwojucWxUDYQAz9ZQiI/0JvzxZ2YBecC+qm
 hihyf5Qh28nHyJ3I4bsWqYHV7zRBjWgZyMZwJckP4p1ewXBrqEIhhIoaDUyL8P4R4+nHVQkL
 2biy292LO8pnFJJhR2NlvRAQATKjYeKETVmg+zPgrCpdGr2FRl1ZfsczkennX5GsNslwbuFm
 uuuFJkzlAWETaHZAROAtRFaRvYmHD+hCpBXs/VDnpUwkdUymgF8snKkg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: [RFC][PATCH 6.12.y-cip 02/12] ARM: allow __do_kernel_fault() to report execution of memory faults
Date: Tue,  5 May 2026 08:56:56 +0200
Message-ID: <136ecfa2110eba6595f67f38734ac6a1921021e6.1777964226.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22867

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit 40b466db1dffb41f0529035c59c5739636d0e5b8 ]

Allow __do_kernel_fault() to detect the execution of memory, so we can
provide the same fault message as do_page_fault() would do. This is
required when we split the kernel address fault handling from the
main do_page_fault() code path.

Reviewed-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Tested-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 4dca7b75ae5e4..1d052d3c767d9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -176,6 +176,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 	 */
 	if (addr < PAGE_SIZE) {
 		msg = "NULL pointer dereference";
+	} else if (is_permission_fault(fsr) && fsr & FSR_LNX_PF) {
+		msg = "execution of memory";
 	} else {
 		if (is_translation_fault(fsr) &&
 		    kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
-- 
2.47.3


