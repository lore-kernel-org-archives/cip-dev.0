Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35DAC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 11:54:01 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.30350.1641815634920037812
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 03:54:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106552705"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 20:54:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CAE65429BEB0;
	Mon, 10 Jan 2022 20:53:59 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 08/15] clk: renesas: r9a07g044: Add clock and
 reset entries for ADC
Date: Mon, 10 Jan 2022 11:53:41 +0000
Message-Id: <20220110115348.14297-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 11:54:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7357

commit 1b87d5bba32c1f25a12ba0625546e5375e3f998d upstream.

Add clock and reset entries for ADC block in CPG driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20210719085840.21842-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index f1e0be50283f..4c94b94c4125 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -145,6 +145,10 @@ static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
 				0x594, 0),
 	DEF_MOD("gpio",		R9A07G044_GPIO_HCLK, R9A07G044_OSCCLK,
 				0x598, 0),
+	DEF_MOD("adc_adclk",	R9A07G044_ADC_ADCLK, R9A07G044_CLK_TSU,
+				0x5a8, 0),
+	DEF_MOD("adc_pclk",	R9A07G044_ADC_PCLK, R9A07G044_CLK_P0,
+				0x5a8, 1),
 };
 
 static struct rzg2l_reset r9a07g044_resets[] = {
@@ -176,6 +180,8 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A07G044_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A07G044_GPIO_SPARE_RESETN, 0x898, 2),
+	DEF_RST(R9A07G044_ADC_PRESETN, 0x8a8, 0),
+	DEF_RST(R9A07G044_ADC_ADRST_N, 0x8a8, 1),
 };
 
 static const unsigned int r9a07g044_crit_mod_clks[] __initconst = {
-- 
2.17.1


