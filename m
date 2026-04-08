Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A71105D9B7
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 09:40:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.102549.1775641195148974723
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 02:39:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: KEyWeoP0Rc+00IBy3Hnlfg==
X-CSE-MsgGUID: /a+2zf+FS027Im/rhKQ6pw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Apr 2026 18:39:58 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8F49F40116CF;
	Wed,  8 Apr 2026 18:39:57 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 3/7] clk: renesas: r9a09g056: Add clock and reset entries for TSU
Date: Wed,  8 Apr 2026 09:39:46 +0000
Message-ID: <20260408093951.66884-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
References: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 09:40:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22639

commit ebb3acf4d7c95b52265084168b59a565bf972883 upstream.

Add module clock and reset entries for the TSU0 and TSU1 blocks on the
Renesas RZ/V2N (R9A09G056) SoC.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251209091115.8541-3-ovidiu.panait.rb@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/r9a09g056-cpg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g056-cpg.c b/drivers/clk/renesas/r9a09g056-cpg.c
index 651f5efc34bc..1c2b7c3a3821 100644
--- a/drivers/clk/renesas/r9a09g056-cpg.c
+++ b/drivers/clk/renesas/r9a09g056-cpg.c
@@ -374,6 +374,10 @@ static const struct rzv2h_mod_clk r9a09g056_mod_clks[] __initconst = {
 						BUS_MSTOP(3, BIT(4))),
 	DEF_MOD("gpu_0_ace_clk",		CLK_PLLDTY_ACPU_DIV2, 15, 2, 7, 18,
 						BUS_MSTOP(3, BIT(4))),
+	DEF_MOD("tsu_0_pclk",			CLK_QEXTAL, 16, 9, 8, 9,
+						BUS_MSTOP(5, BIT(2))),
+	DEF_MOD("tsu_1_pclk",			CLK_QEXTAL, 16, 10, 8, 10,
+						BUS_MSTOP(2, BIT(15))),
 };
 
 static const struct rzv2h_reset r9a09g056_resets[] __initconst = {
@@ -426,6 +430,8 @@ static const struct rzv2h_reset r9a09g056_resets[] __initconst = {
 	DEF_RST(13, 13, 6, 14),		/* GPU_0_RESETN */
 	DEF_RST(13, 14, 6, 15),		/* GPU_0_AXI_RESETN */
 	DEF_RST(13, 15, 6, 16),		/* GPU_0_ACE_RESETN */
+	DEF_RST(15, 7, 7, 8),		/* TSU_0_PRESETN */
+	DEF_RST(15, 8, 7, 9),		/* TSU_1_PRESETN */
 };
 
 const struct rzv2h_cpg_info r9a09g056_cpg_info __initconst = {
-- 
2.51.0


