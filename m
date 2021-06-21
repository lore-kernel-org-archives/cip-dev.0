Return-Path: <SRS0=/wev=LP=lists.cip-project.org=bounce+64572+6553+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C993C48BC2
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F412D6054E
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F412D6054E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6553+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zdpEYY4521723xTdxagjziks; Mon, 21 Jun 2021 10:09:47 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web08.50425.1624295386102944213
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 10:09:47 -0700
X-IronPort-AV: E=Sophos;i="5.83,289,1616425200"; 
   d="scan'208";a="85077301"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jun 2021 02:09:39 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 17E2F400752D;
	Tue, 22 Jun 2021 02:09:38 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 5.10.y-cip 09/16] clk: renesas: r8a774c0: Add RPC clocks
Date: Mon, 21 Jun 2021 18:09:18 +0100
Message-Id: <20210621170925.11328-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zvqSXJFWLvZvClJSmReBshi2x4520388AA=
Content-Type: multipart/mixed; boundary="krjjx7HhiR7OFsSZE0Cb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624295387;
 bh=MJbhCf4UA/GcVjU1c3nBxzOJnQ4/d9UIRVcZYYaXzoY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=HZW4Ie+r/ju7tmB+Juqa8J9/51G+56YEyjt/8uNjyQM0Ct8OlW1D/26ldY8HqkRTYW3
 QBQtoowfXvLa7VtMyCRFqFJBtMQ0dovZUWG6gXzvtpsDwq774AWfvyWoUDwH2oCfBk47t
 pfc0uARBmynO5RfeqsLeyblO3uAyhwHGPYA=

--krjjx7HhiR7OFsSZE0Cb

commit 40745482eec81bea686cd1b38693191dc7e9ac66 upstream.

Describe the RPCSRC internal clock and the RPC[D2] clocks derived from it,
as well as the RPC-IF module clock, in the RZ/G2E (R8A774C0) CPG/MSSR
driver.

Add new clk type CLK_TYPE_GEN3_E3_RPCSRC to register rpcsrc as a fixed
clock on R-Car Gen3 E3 (and also RZ/G2E which is identical to E3 SoC),
parent and the divider is set based on the register value CPG_RPCCKCR[4:3]
which has been set prior to booting the kernel.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20201116101002.5986-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r8a774c0-cpg-mssr.c |  9 ++++++++
 drivers/clk/renesas/rcar-gen3-cpg.c     | 28 +++++++++++++++++++++++++
 drivers/clk/renesas/rcar-gen3-cpg.h     |  5 +++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index 9fc9fa9e531a..ed3a2cf0e0bb 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -44,6 +44,7 @@ enum clk_ids {
 	CLK_S2,
 	CLK_S3,
 	CLK_SDSRC,
+	CLK_RPCSRC,
 	CLK_RINT,
 	CLK_OCO,
 
@@ -74,6 +75,13 @@ static const struct cpg_core_clk r8a774c0_core_clks[] __initconst = {
 	DEF_FIXED(".s3",       CLK_S3,             CLK_PLL1,       6, 1),
 	DEF_FIXED(".sdsrc",    CLK_SDSRC,          CLK_PLL1,       2, 1),
 
+	DEF_FIXED_RPCSRC_E3(".rpcsrc", CLK_RPCSRC, CLK_PLL0, CLK_PLL1),
+
+	DEF_BASE("rpc",		R8A774C0_CLK_RPC, CLK_TYPE_GEN3_RPC,
+		 CLK_RPCSRC),
+	DEF_BASE("rpcd2",	R8A774C0_CLK_RPCD2, CLK_TYPE_GEN3_RPCD2,
+		 R8A774C0_CLK_RPC),
+
 	DEF_DIV6_RO(".r",      CLK_RINT,           CLK_EXTAL, CPG_RCKCR, 32),
 
 	DEF_RATE(".oco",       CLK_OCO,            8 * 1000 * 1000),
@@ -199,6 +207,7 @@ static const struct mssr_mod_clk r8a774c0_mod_clks[] __initconst = {
 	DEF_MOD("can-fd",		 914,	R8A774C0_CLK_S3D2),
 	DEF_MOD("can-if1",		 915,	R8A774C0_CLK_S3D4),
 	DEF_MOD("can-if0",		 916,	R8A774C0_CLK_S3D4),
+	DEF_MOD("rpc-if",		 917,	R8A774C0_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A774C0_CLK_S3D2),
 	DEF_MOD("i2c5",			 919,	R8A774C0_CLK_S3D2),
 	DEF_MOD("i2c-dvfs",		 926,	R8A774C0_CLK_CP),
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 488f8b3980c5..20de135e28ed 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -696,6 +696,34 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 						  cpg_rpcsrc_div_table,
 						  &cpg_lock);
 
+	case CLK_TYPE_GEN3_E3_RPCSRC:
+		/*
+		 * Register RPCSRC as fixed factor clock based on the
+		 * MD[4:1] pins and CPG_RPCCKCR[4:3] register value for
+		 * which has been set prior to booting the kernel.
+		 */
+		value = (readl(base + CPG_RPCCKCR) & GENMASK(4, 3)) >> 3;
+
+		switch (value) {
+		case 0:
+			div = 5;
+			break;
+		case 1:
+			div = 3;
+			break;
+		case 2:
+			parent = clks[core->parent >> 16];
+			if (IS_ERR(parent))
+				return ERR_CAST(parent);
+			div = core->div;
+			break;
+		case 3:
+		default:
+			div = 2;
+			break;
+		}
+		break;
+
 	case CLK_TYPE_GEN3_RPC:
 		return cpg_rpc_clk_register(core->name, base,
 					    __clk_get_name(parent), notifiers);
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index c4ac80cac6a0..3d949c4a3244 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -24,6 +24,7 @@ enum rcar_gen3_clk_types {
 	CLK_TYPE_GEN3_OSC,	/* OSC EXTAL predivider and fixed divider */
 	CLK_TYPE_GEN3_RCKSEL,	/* Select parent/divider using RCKCR.CKSEL */
 	CLK_TYPE_GEN3_RPCSRC,
+	CLK_TYPE_GEN3_E3_RPCSRC,
 	CLK_TYPE_GEN3_RPC,
 	CLK_TYPE_GEN3_RPCD2,
 
@@ -54,6 +55,10 @@ enum rcar_gen3_clk_types {
 #define DEF_GEN3_Z(_name, _id, _type, _parent, _div, _offset)	\
 	DEF_BASE(_name, _id, _type, _parent, .div = _div, .offset = _offset)
 
+#define DEF_FIXED_RPCSRC_E3(_name, _id, _parent0, _parent1)	\
+	DEF_BASE(_name, _id, CLK_TYPE_GEN3_E3_RPCSRC,	\
+		 (_parent0) << 16 | (_parent1), .div = 8)
+
 struct rcar_gen3_cpg_pll_config {
 	u8 extal_div;
 	u8 pll1_mult;
-- 
2.17.1


--krjjx7HhiR7OFsSZE0Cb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6553): https://lists.cip-project.org/g/cip-dev/message=
/6553
Mute This Topic: https://lists.cip-project.org/mt/83693881/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--krjjx7HhiR7OFsSZE0Cb--
