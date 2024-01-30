Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5A1C48285
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 20:34:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.7357.1706646856010792564
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 12:34:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,230,1701097200"; 
   d="scan'208";a="196182844"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Jan 2024 05:34:24 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 95C6840A3D3B;
	Wed, 31 Jan 2024 05:34:22 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RFC PATCH 5.10.y-cip 17/39] clocksource/drivers/riscv: Get rid of clocksource_arch_init() callback
Date: Tue, 30 Jan 2024 20:33:24 +0000
Message-Id: <20240130203346.94488-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 20:34:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14529

commit 3aff0403f814df6ce2377a6ecf61dd7750a3925f upstream.

Having a clocksource_arch_init() callback always sets vdso_clock_mode to
VDSO_CLOCKMODE_ARCHTIMER if GENERIC_GETTIMEOFDAY is enabled, this is
required for the riscv-timer.

This works for platforms where just riscv-timer clocksource is present.
On platforms where other clock sources are available we want them to
register with vdso_clock_mode set to VDSO_CLOCKMODE_NONE.

On the Renesas RZ/Five SoC OSTM block can be used as clocksource [0], to
avoid multiple clock sources being registered as VDSO_CLOCKMODE_ARCHTIMER
move setting of vdso_clock_mode in the riscv-timer driver instead of doing
this in clocksource_arch_init() callback as done similarly for ARM/64
architecture.

[0] drivers/clocksource/renesas-ostm.c

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Samuel Holland <samuel@sholland.org>
Link: https://lore.kernel.org/r/20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/Kconfig                | 1 -
 arch/riscv/kernel/time.c          | 9 ---------
 drivers/clocksource/timer-riscv.c | 5 +++++
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6cdfb41a91813..6b28e663fbed6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,7 +12,6 @@ config 32BIT
 
 config RISCV
 	def_bool y
-	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 303ae47dfb4d6..726860a490f36 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -32,12 +32,3 @@ void __init time_init(void)
 
 	tick_setup_hrtimer_broadcast();
 }
-
-void clocksource_arch_init(struct clocksource *cs)
-{
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
-	cs->vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER;
-#else
-	cs->vdso_clock_mode = VDSO_CLOCKMODE_NONE;
-#endif
-}
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index a035bdf6fc580..a8210493cc21f 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -58,6 +58,11 @@ static struct clocksource riscv_clocksource = {
 	.mask		= CLOCKSOURCE_MASK(64),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.read		= riscv_clocksource_rdtime,
+#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+	.vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER,
+#else
+	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
+#endif
 };
 
 static int riscv_timer_starting_cpu(unsigned int cpu)
-- 
2.34.1


