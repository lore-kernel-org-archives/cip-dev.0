Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DD8CD3443
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 06:57:19 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33676.1777964233202521262
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 23:57:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=jLIsPUcU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20260505065711488a975dda00020744-lu2mne@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260505065711488a975dda00020744
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 08:57:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=D3PYKHRvJXbLgaekem4J5/EEPWyoMTUT29yN2s10sv4=;
 b=jLIsPUcUi09+Ym8Rw/BZYqJmVqDKiKY8pEZRz3M9gYGulj1EOk5ozIPeAKAktSVy07kBSA
 qTCHM2UcJfATZ4rDcfBbP8kZglHKyV5Nua+wNOgTUD2nD6o3sxcBrgE5T4SBQ5eFR7ggaeIX
 jngITLZA8QwZ+sT5L1l9azsGaeXZXEgLk83uBHJO1z2ydPAc5C8lCEuOuv9ZulRAT4qb965q
 a+OTKX4OhU+bf3tcRtb0e+102GT9dAzMZB0SK7bx2mCQsKMrcXD26IbFx1ukTB0Wk4tCwCWv
 5pbng/qpB0s84+dudTB/Uzdknf8Yw97eiAnuZx4x1BOEnihKuKmyEolw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: [RFC][PATCH 6.12.y-cip 05/12] ARM: 9459/1: Disable jump-label on PREEMPT_RT
Date: Tue,  5 May 2026 08:56:59 +0200
Message-ID: <0cb6d5ae203f4bf1ac6442bf48adf4fd2b300e95.1777964226.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22872

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 256d97d3587b441630c345ab3d773a9e7dcd964b ]

jump-labels are used to efficiently switch between two possible code
paths. To achieve this, stop_machine() is used to keep the CPU in a
known state while the opcode is modified. The usage of stop_machine()
here leads to large latency spikes which can be observed on PREEMPT_RT.

Jump labels may change the target during runtime and are not restricted
to debug or "configuration/ setup" part of a PREEMPT_RT system where
high latencies could be defined as acceptable.

On 64-bit Arm, it is possible to use jump labels without the
stop_machine() call, which architecturally provides a way to atomically
change one 32-bit instruction word while keeping maintaining consistency,
but this is not generally the case on 32-bit, in particular in thumb2
mode.

Disable jump-label support on a PREEMPT_RT system when SMP is enabled.

[bigeasy: Patch description.]
[arnd: add !SMP case, extend changelog]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cc8beccc4e86d..4be68e77b9594 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -79,7 +79,7 @@ config ARM
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
-	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
+	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU && (!PREEMPT_RT || !SMP)
 	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
-- 
2.47.3


