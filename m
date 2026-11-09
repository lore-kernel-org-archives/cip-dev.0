Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3950.1794223246721061510
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 03:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=aXmtxcx7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20261109112044d8c075578b000207f7-d6lv3i@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261109112044d8c075578b000207f7
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Nov 2026 12:20:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YwZC2syDSECDG3oBEWkn3WT4o9huG/s/mAO6m1jYTbs=;
 b=aXmtxcx73dgLtKY74FZp3uEWZwxbOUfLunUqDimdxuUnxTVWYo+TCmswpr+FG+47SGye7i
 2kZDqIN/ikY6kAPZTa272fPp42ej2OqIdt6UEvH23EkH898oyKWNr8BsJQSIN5Na9v82oGqI
 7X3IJ1H9ppHgkVnFPslEHOV6NLovcrNCOSVEBuH1/QxVIxWllp7OJNsTGbLYrQ/1HukEDG5C
 ziaWGxjnbQF1T/ZYuMlVM76yAG5sV4L66ijRE9ymvVfCaYRBlGWC8FZlJ0qlVjnpHWv9eVk7
 bgVX6GTM1LV6blIvPLIgqcQHb7xOXxyruQqchOkEQLl5Jz+Sbkv9Z3GA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: Daniel Wagner <wagi@monom.org>,
	Bryan Brattlof <bb@ti.com>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Pasquale Nieddu <pasquale.nieddu@siemens.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6.12.y-cip v2 6/6] ARM: 9463/1: Allow to enable RT
Date: Mon,  9 Nov 2026 12:20:41 +0100
Message-ID: <4be992a200b3fcb7bd214c11d5e683a5b2fde9f6.1794223241.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1794223241.git.jan.kiszka@siemens.com>
References: <cover.1794223241.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 11:20:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24697
Content-Type: text/plain; charset="utf-8"

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit c6e61c06d6061750597e79c598acb5dead44c35b ]

All known issues have been adressed.
Allow to select RT.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5f0e12a84eaa1..bbf84b0ac0b50 100644
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

