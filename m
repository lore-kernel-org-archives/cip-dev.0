Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A7BC48299
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:42:36 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.61936.1707136950759841430
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:42:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="192915854"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2024 21:42:30 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B755D40065B6;
	Mon,  5 Feb 2024 21:42:28 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 25/48] clocksource/drivers/riscv: Increase the clock source rating
Date: Mon,  5 Feb 2024 12:41:12 +0000
Message-Id: <20240205124135.14779-26-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:42:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14694

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
index c51c5ed15aa7..a035bdf6fc58 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -54,7 +54,7 @@ static u64 notrace riscv_sched_clock(void)
 
 static struct clocksource riscv_clocksource = {
 	.name		= "riscv_clocksource",
-	.rating		= 300,
+	.rating		= 400,
 	.mask		= CLOCKSOURCE_MASK(64),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.read		= riscv_clocksource_rdtime,
-- 
2.34.1


