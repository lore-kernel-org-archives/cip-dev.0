Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67D2C7EE2E
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 07:52:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.3504.1686037963300736519
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 00:52:43 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,219,1681138800"; 
   d="scan'208";a="165915324"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Jun 2023 16:52:41 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DF84E4187F1A;
	Tue,  6 Jun 2023 16:52:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 1/8] clk: renesas: r9a07g044: Add MTU3a clock and reset entry
Date: Tue,  6 Jun 2023 08:52:28 +0100
Message-Id: <20230606075235.183132-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 07:52:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11842

commit 576d6b40dcceade7d77e88f63e621349c6937bc3 upstream.

Add MTU3a clock and reset entry to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20221005111855.553436-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 02a4fc41bb6e..12b1a83625cb 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -182,7 +182,7 @@ static const struct {
 };
 
 static const struct {
-	struct rzg2l_mod_clk common[76];
+	struct rzg2l_mod_clk common[77];
 #ifdef CONFIG_CLK_R9A07G054
 	struct rzg2l_mod_clk drp[0];
 #endif
@@ -204,6 +204,8 @@ static const struct {
 					0x534, 1),
 		DEF_MOD("ostm2_pclk",	R9A07G044_OSTM2_PCLK, R9A07G044_CLK_P0,
 					0x534, 2),
+		DEF_MOD("mtu_x_mck",	R9A07G044_MTU_X_MCK_MTU3, R9A07G044_CLK_P0,
+					0x538, 0),
 		DEF_MOD("gpt_pclk",	R9A07G044_GPT_PCLK, R9A07G044_CLK_P0,
 					0x540, 0),
 		DEF_MOD("poeg_a_clkp",	R9A07G044_POEG_A_CLKP, R9A07G044_CLK_P0,
@@ -356,6 +358,7 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_OSTM0_PRESETZ, 0x834, 0),
 	DEF_RST(R9A07G044_OSTM1_PRESETZ, 0x834, 1),
 	DEF_RST(R9A07G044_OSTM2_PRESETZ, 0x834, 2),
+	DEF_RST(R9A07G044_MTU_X_PRESET_MTU3, 0x838, 0),
 	DEF_RST(R9A07G044_GPT_RST_C, 0x840, 0),
 	DEF_RST(R9A07G044_POEG_A_RST, 0x844, 0),
 	DEF_RST(R9A07G044_POEG_B_RST, 0x844, 1),
-- 
2.25.1


