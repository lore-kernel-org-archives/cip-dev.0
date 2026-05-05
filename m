Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C976CD343E
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 06:57:19 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33454.1777964232297512868
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 23:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=a+CMK7+d;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20260505065713136182712b00020787-ujoj8g@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260505065713136182712b00020787
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 08:57:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cgJQk/6Mx34yzDN6wnM+Pk0smiEsqjbIMXZnumB0tIM=;
 b=a+CMK7+dZB40YV8ZTb+JmSNog3mmY/47ogMRPzKxRXK3qOPB+V+dyL6eYOq0T9aBA4hXF0
 mJ8tsUPGi9cPvy31Oiu4zUq2AEadfJnk+0BvdrGsOWGD56+Wk7wGLejJVCqbUPR2FCAg192W
 VLLvEXizfCZwbHbBsIV6ZBcIe6yzbf6nJmqGSm7NUALALKFkyfTL99dEtdGEstzUkgREQ/Jq
 X+X1isUbK3zVC2Jsb5jSsPIF5lP3e2/7rBhC0Kq+23by2GxBQhkDOEAE39n2rC7NoQMees8o
 6aAf1ddzeS90q+4EIyIfTpIMIrQwdhzqf4bBAe6McDooBL81g2bbReSw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: [RFC][PATCH 6.12.y-cip 12/12] ARM: 9463/1: Allow to enable RT
Date: Tue,  5 May 2026 08:57:06 +0200
Message-ID: <5529036c6c1c6fb62e8de9759181da73a7bef3dd.1777964226.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22876

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit c6e61c06d6061750597e79c598acb5dead44c35b ]

All known issues have been adressed.
Allow to select RT.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4be68e77b9594..4d09fd4bd9d41 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -40,6 +40,7 @@ config ARM
 	select ARCH_SUPPORTS_CFI_CLANG
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
-- 
2.47.3


