Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB548C61D97
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 14:28:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20658.1700663304421656546
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 06:28:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,219,1695654000"; 
   d="scan'208";a="187743103"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Nov 2023 23:28:41 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 55CEC4010DF3;
	Wed, 22 Nov 2023 23:28:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 08/11] clk: vc3: Fix 64 by 64 division
Date: Wed, 22 Nov 2023 14:28:16 +0000
Message-Id: <20231122142819.203737-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 14:28:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13620

commit 576418e3417267e93ffee09c46f56434108c4548 upstream.

Fix the below cocci warnings by replacing do_div()->div64_ul() and
bound the result with a max value of U16_MAX.

cocci warnings:
	drivers/clk/clk-versaclock3.c:404:2-8: WARNING: do_div() does a
	64-by-32 division, please consider using div64_ul instead.

Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202307270841.yr5HxYIl-lkp@intel.com/
Fixes: 6e9aff555db7 ("clk: Add support for versa3 clock driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230824104812.147775-3-biju.das.jz@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index ca0921510a70..4013b114bfdf 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -400,11 +400,10 @@ static long vc3_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 		/* Determine best fractional part, which is 16 bit wide */
 		div_frc = rate % *parent_rate;
 		div_frc *= BIT(16) - 1;
-		do_div(div_frc, *parent_rate);
 
-		vc3->div_frc = (u32)div_frc;
+		vc3->div_frc = min_t(u64, div64_ul(div_frc, *parent_rate), U16_MAX);
 		rate = (*parent_rate *
-			(vc3->div_int * VC3_2_POW_16 + div_frc) / VC3_2_POW_16);
+			(vc3->div_int * VC3_2_POW_16 + vc3->div_frc) / VC3_2_POW_16);
 	} else {
 		rate = *parent_rate * vc3->div_int;
 	}
-- 
2.25.1


