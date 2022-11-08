Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070D4C43217
	for <webhook@archiver.kernel.org>; Tue,  8 Nov 2022 12:56:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7381.1667912195619553618
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Nov 2022 04:56:39 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.96,147,1665414000"; 
   d="scan'208";a="139360138"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Nov 2022 21:56:38 +0900
Received: from localhost.localdomain (unknown [10.226.92.61])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CE7474007204;
	Tue,  8 Nov 2022 21:56:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/3] mmc: renesas_sdhi: Fix rounding errors
Date: Tue,  8 Nov 2022 12:56:29 +0000
Message-Id: <20221108125630.3853219-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108125630.3853219-1-biju.das.jz@bp.renesas.com>
References: <20221108125630.3853219-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Nov 2022 12:56:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9946

commit f0c00454bf78975925eccc9737faaa4d4951edbf upstream.

Due to clk rounding errors on RZ/G2L platforms, it selects a clock source
with a lower clock rate compared to a higher one.
For eg: The rounding error (533333333 Hz / 4 * 4 = 533333332 Hz < 5333333
33 Hz) selects a clk source of 400 MHz instead of 533.333333 MHz.

This patch fixes this issue by adding a margin of (1/1024) higher to
the clock rate.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Fixes: bb6d3fa98a41 ("clk: renesas: rcar-gen3: Switch to new SD clock handling")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20220928110755.849275-1-biju.das.jz@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[biju: fixed the conflicts manually]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 120bb5860645..589e19ff52c6 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -128,6 +128,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
+	unsigned int new_upper_limit;
 	int i;
 
 	/*
@@ -143,14 +144,21 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	 * greater than, new_clock.  As we can divide by 1 << i for
 	 * any i in [0, 9] we want the input clock to be as close as
 	 * possible, but no greater than, new_clock << i.
+	 *
+	 * Add an upper limit of 1/1024 rate higher to the clock rate to fix
+	 * clk rate jumping to lower rate due to rounding error (eg: RZ/G2L has
+	 * 3 clk sources 533.333333 MHz, 400 MHz and 266.666666 MHz. The request
+	 * for 533.333333 MHz will selects a slower 400 MHz due to rounding
+	 * error (533333333 Hz / 4 * 4 = 533333332 Hz < 533333333 Hz)).
 	 */
 	for (i = min(9, ilog2(UINT_MAX / new_clock)); i >= 0; i--) {
 		freq = clk_round_rate(priv->clk, new_clock << i);
-		if (freq > (new_clock << i)) {
+		new_upper_limit = (new_clock << i) + ((new_clock << i) >> 10);
+		if (freq > new_upper_limit) {
 			/* Too fast; look for a slightly slower option */
 			freq = clk_round_rate(priv->clk,
 					      (new_clock << i) / 4 * 3);
-			if (freq > (new_clock << i))
+			if (freq > new_upper_limit)
 				continue;
 		}
 
@@ -169,6 +177,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 				   unsigned int new_clock)
 {
+	unsigned int clk_margin;
 	u32 clk = 0, clock;
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
@@ -182,7 +191,13 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	host->mmc->actual_clock = renesas_sdhi_clk_update(host, new_clock);
 	clock = host->mmc->actual_clock / 512;
 
-	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
+	/*
+	 * Add a margin of 1/1024 rate higher to the clock rate in order
+	 * to avoid clk variable setting a value of 0 due to the margin
+	 * provided for actual_clock in renesas_sdhi_clk_update().
+	 */
+	clk_margin = new_clock >> 10;
+	for (clk = 0x80000080; new_clock + clk_margin >= (clock << 1); clk >>= 1)
 		clock <<= 1;
 
 	/* 1/1 clock is option */
-- 
2.25.1


