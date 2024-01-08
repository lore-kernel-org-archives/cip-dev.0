Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D615DC47073
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 18:16:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4650.1704737779601560182
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jan 2024 10:16:23 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,180,1695654000"; 
   d="scan'208";a="189691388"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jan 2024 03:16:22 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.235])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 470FC40469DF;
	Tue,  9 Jan 2024 03:16:21 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/30] clocksource/drivers/riscv: Increase the clock source rating
Date: Mon,  8 Jan 2024 18:15:46 +0000
Message-Id: <20240108181612.5651-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 18:16:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14292

From: Samuel Holland <samuel@sholland.org>

commit 674402b0098b66b8ba91fe93c0d27af703256098 upstream.

RISC-V provides an architectural clock source via the time CSR. This
clock source exposes a 64-bit counter synchronized across all CPUs.
Because it is accessed using a CSR, it is much more efficient to read
than MMIO clock sources. For example, on the Allwinner D1, reading the
sun4i timer in a loop takes 131 cycles/iteration, while reading the
RISC-V time CSR takes only 5 cycles/iteration.

Adjust the RISC-V clock source rating so it is preferred over the
various platform-specific MMIO clock sources.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20221228004444.61568-1-samuel@sholland.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clocksource/timer-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index a01c2bd24134..b745db8eab93 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -73,7 +73,7 @@ static u64 notrace riscv_sched_clock(void)
 
 static struct clocksource riscv_clocksource = {
 	.name		= "riscv_clocksource",
-	.rating		= 300,
+	.rating		= 400,
 	.mask		= CLOCKSOURCE_MASK(64),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.read		= riscv_clocksource_rdtime,
-- 
2.34.1


