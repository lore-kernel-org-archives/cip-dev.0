Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DF0C369D7
	for <webhook@archiver.kernel.org>; Mon, 21 Apr 2025 16:59:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.19917.1745254768476413106
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Apr 2025 09:59:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: EnI6Tt6DQUKoZns2s4xQbw==
X-CSE-MsgGUID: o8yUn8b1TsKBN14gMPN2cw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Apr 2025 01:59:29 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.26])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4F74F40134EF;
	Tue, 22 Apr 2025 01:59:28 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 3/4] clk: renesas: r9a07g043: Add clock and reset entry for PLIC
Date: Mon, 21 Apr 2025 17:59:20 +0100
Message-ID: <20250421165921.631205-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421165921.631205-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250421165921.631205-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Apr 2025 16:59:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18531

commit 44019387fce230beda35b83da3a2c9fc5787704e upstream.

Add the missing clock and reset entry for PLIC. Also add
R9A07G043_NCEPLIC_ACLK to the critical clocks list.

Fixes: 95d48d270305ad2c ("clk: renesas: r9a07g043: Add support for RZ/Five SoC")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240403200952.633084-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 6e2d502fe7eb..c3c2b0c43983 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -291,6 +291,10 @@ static const struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x5a8, 1),
 	DEF_MOD("tsu_pclk",	R9A07G043_TSU_PCLK, R9A07G043_CLK_TSU,
 				0x5ac, 0),
+#ifdef CONFIG_RISCV
+	DEF_MOD("nceplic_aclk",	R9A07G043_NCEPLIC_ACLK, R9A07G043_CLK_P1,
+				0x608, 0),
+#endif
 };
 
 static const struct rzg2l_reset r9a07g043_resets[] = {
@@ -350,6 +354,10 @@ static const struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_ADC_PRESETN, 0x8a8, 0),
 	DEF_RST(R9A07G043_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A07G043_TSU_PRESETN, 0x8ac, 0),
+#ifdef CONFIG_RISCV
+	DEF_RST(R9A07G043_NCEPLIC_ARESETN, 0x908, 0),
+#endif
+
 };
 
 static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
@@ -359,6 +367,7 @@ static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
 #endif
 #ifdef CONFIG_RISCV
 	MOD_CLK_BASE + R9A07G043_IAX45_CLK,
+	MOD_CLK_BASE + R9A07G043_NCEPLIC_ACLK,
 #endif
 	MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
 };
-- 
2.43.0


