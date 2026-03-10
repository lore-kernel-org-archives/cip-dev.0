Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3494CFCA19A
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 16:01:01 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43590.1773158454107655906
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2026 09:00:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: h+347hEjRyqqYa7/kdK/gA==
X-CSE-MsgGUID: oeSe0JAFRP+AH4lvk1FPNg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Mar 2026 01:00:56 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8BFC14019133;
	Wed, 11 Mar 2026 01:00:55 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 2/5] clk: renesas: r9a09g056: Add entries for ICU
Date: Tue, 10 Mar 2026 16:00:47 +0000
Message-ID: <20260310160050.40977-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310160050.40977-1-ovidiu.panait.rb@renesas.com>
References: <20260310160050.40977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 16:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22237

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 94cdeca6a17a3e2ba617c8a03e17d989de005a20 upstream.

Add clock and reset entries for the ICU IP block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251125221420.288809-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/r9a09g056-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g056-cpg.c b/drivers/clk/renesas/r9a09g056-cpg.c
index 73c63cef8a99..b7d66148b42c 100644
--- a/drivers/clk/renesas/r9a09g056-cpg.c
+++ b/drivers/clk/renesas/r9a09g056-cpg.c
@@ -214,6 +214,8 @@ static const struct cpg_core_clk r9a09g056_core_clks[] __initconst = {
 };
 
 static const struct rzv2h_mod_clk r9a09g056_mod_clks[] __initconst = {
+	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5,
+						BUS_MSTOP_NONE),
 	DEF_MOD_CRITICAL("gic_0_gicclk",	CLK_PLLDTY_ACPU_DIV4, 1, 3, 0, 19,
 						BUS_MSTOP(3, BIT(5))),
 	DEF_MOD("gtm_0_pclk",			CLK_PLLCM33_DIV16, 4, 3, 2, 3,
@@ -354,6 +356,7 @@ static const struct rzv2h_mod_clk r9a09g056_mod_clks[] __initconst = {
 
 static const struct rzv2h_reset r9a09g056_resets[] __initconst = {
 	DEF_RST(3, 0, 1, 1),		/* SYS_0_PRESETN */
+	DEF_RST(3, 6, 1, 7),		/* ICU_0_PRESETN_I */
 	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
 	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
 	DEF_RST(6, 13, 2, 30),		/* GTM_0_PRESETZ */
-- 
2.51.0


