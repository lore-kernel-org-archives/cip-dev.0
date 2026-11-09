Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3865.1794223245922137721
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 03:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=OaMli4v+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20261109112042f82c91571900020721-3cceiu@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261109112042f82c91571900020721
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Nov 2026 12:20:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hmUcsFBU1Bj17iLiFhI6+ON0EeU7x4Q2l6a3vSq7rYk=;
 b=OaMli4v+ZnscKgU1POhRWzQljMHl+VBJFeujIYZ3hlxEz6WLlyE1oCYMHACd5Xx2rz5Cqu
 o8ys1FJLMGOvV4nRPlBroTyaC61LZlQqgRGdc+juZE6kyRmp3b9aE5fT8iRK4qZiff+lYh5x
 I9lhJSbQHe6/VIFRcJdQCqs4b4Z4ljuv273v8JjNb+ZNSVTiI0krByPt8eB3yh6JGT0sk/KC
 2l5SUV8g3++DSFHtMElcO8xKTl7W1BGCZi0RjCXt6EJ7XMADQxrVOeYiRrLSii8pO0dwsIEJ
 s0QTapHHdapZdaKFvA+uSoJ7cGfmdG9LPdQEbO0+6FA8+zNg+2WUuITQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: Daniel Wagner <wagi@monom.org>,
	Bryan Brattlof <bb@ti.com>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Pasquale Nieddu <pasquale.nieddu@siemens.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6.12.y-cip v2 1/6] ARM: 9459/1: Disable jump-label on PREEMPT_RT
Date: Mon,  9 Nov 2026 12:20:36 +0100
Message-ID: <396476c8d61cf14cebf787d5e8dd2c300dc5b96c.1794223241.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1794223241.git.jan.kiszka@siemens.com>
References: <cover.1794223241.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 11:20:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24701
Content-Type: text/plain; charset="utf-8"

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
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 51c6b2db9eadf..5f0e12a84eaa1 100644
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

