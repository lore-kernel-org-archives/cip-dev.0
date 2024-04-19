Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33622C0650F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:28 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.15270.1713514703418985405
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=graIZZZR;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51a1c8d931so183778766b.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514702; x=1714119502; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdHZZEJf+yK+WM1zSQC0a3vxEeeXjRWytC+LKpzVYVg=;
        b=graIZZZRnmMebeX4aA/NwelV/OoYH1rHwSTFfg0IJVD0s1SMJVYFu7U2fb4O5GvhuB
         0artSxIbpMxdj2BWLXcNodauYQrZYIPe1XnhbjtalFbbQveueHT1lk2rvw+iM4goQsnM
         Z/lp/P3auiJ2JYqqIRNaaf6M2txHf2pOEQ+jOYj3Goec26KeiVSiNKh8QvgIBfCRlHwd
         d/cvLXQHU/bVi4/qbwPfjcRjAwqtPRMsfEgpCpPn+AgzLFLND+G0lma0cqGhD+XERvpi
         Xv2eKzPMPZMmXyN47dSQf+mDABb+4+JH1CYt7t51n8z0+UcLQKV2moteSKGREqPUUwWY
         hCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514702; x=1714119502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdHZZEJf+yK+WM1zSQC0a3vxEeeXjRWytC+LKpzVYVg=;
        b=ARq9/qm6ZIKI9s8vW4ahmLFlnQud4Gna0VylbM7gJeYI66szFrMF2N2YvxOexwp3X1
         y5owKaQ2BP6+YYvR/fUK/Gl8G94sbRmPQa6zl+jXKxPfLTC4tUVLIFOJvy4BFchCaTd5
         BSK4OtxdU5WQhTRzCBXN+JS9fKMHzGMzJmc4aMcZ0LktmPpKXGZi58jTBsLbc0kWjUCL
         U80dV+GmNnRKKRjT6QGhl8qaSPC4ipjh0ZdqJcVRVejtHYZaTBpuH/Tw6fhEYtjLCK3L
         rg1XvPZj4jQ8LtBf2OrWUpVLca9h6s3pOYGbmTMcZJBwvzxJ2mGB0gPXDshZSW+cE9UK
         hCzw==
X-Gm-Message-State: AOJu0YwfBcn2zdQhYTIYWd/gJJpVNiOyVVzI5imoT+UCKqVFBgEpFNA1
	jUF+Y0F2xHWHdPABO4vvaiRAYVJ1ViSQMkI44WujPGxdMamE1tXXCtZMJj//QPc=
X-Google-Smtp-Source: AGHT+IEwxMkbLVfp9DbiR3n6IRVak8u0PZ6VlWpUJPeRw8my3wCxWKhKS4HZ4ub6kMQbR2bA7Ykc4g==
X-Received: by 2002:a17:906:3196:b0:a55:73c3:f817 with SMTP id 22-20020a170906319600b00a5573c3f817mr875630ejy.12.1713514701833;
        Fri, 19 Apr 2024 01:18:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 25/53] clk: renesas: r9a08g045: Add clock and reset support for SDHI1 and SDHI2
Date: Fri, 19 Apr 2024 11:17:14 +0300
Message-Id: <20240419081742.3496709-26-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15612

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 4bce4bedbe6daa54cf701184601f913a0c00bb1c upstream.

Add clock and reset support for the SDHI1 and SDHI2 blocks on the
RZ/G3S (R9A08G045) SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231010132701.1658737-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 389d32b32168..4394cb241d99 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -25,6 +25,8 @@
 /* RZ/G3S Specific division configuration.  */
 #define G3S_DIVPL2B		DDIV_PACK(G3S_CPG_PL2_DDIV, 4, 3)
 #define G3S_DIV_SDHI0		DDIV_PACK(G3S_CPG_SDHI_DDIV, 0, 1)
+#define G3S_DIV_SDHI1		DDIV_PACK(G3S_CPG_SDHI_DDIV, 4, 1)
+#define G3S_DIV_SDHI2		DDIV_PACK(G3S_CPG_SDHI_DDIV, 8, 1)
 
 /* RZ/G3S Clock status configuration. */
 #define G3S_DIVPL1A_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 0, 1)
@@ -33,13 +35,19 @@
 #define G3S_DIVPL3B_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 9, 1)
 #define G3S_DIVPL3C_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 10, 1)
 #define G3S_DIV_SDHI0_STS	DDIV_PACK(G3S_CLKDIVSTATUS, 24, 1)
+#define G3S_DIV_SDHI1_STS	DDIV_PACK(G3S_CLKDIVSTATUS, 25, 1)
+#define G3S_DIV_SDHI2_STS	DDIV_PACK(G3S_CLKDIVSTATUS, 26, 1)
 
 #define G3S_SEL_PLL4_STS	SEL_PLL_PACK(G3S_CLKSELSTATUS, 6, 1)
 #define G3S_SEL_SDHI0_STS	SEL_PLL_PACK(G3S_CLKSELSTATUS, 16, 1)
+#define G3S_SEL_SDHI1_STS	SEL_PLL_PACK(G3S_CLKSELSTATUS, 17, 1)
+#define G3S_SEL_SDHI2_STS	SEL_PLL_PACK(G3S_CLKSELSTATUS, 18, 1)
 
 /* RZ/G3S Specific clocks select. */
 #define G3S_SEL_PLL4		SEL_PLL_PACK(G3S_CPG_PLL_DSEL, 6, 1)
 #define G3S_SEL_SDHI0		SEL_PLL_PACK(G3S_CPG_SDHI_DSEL, 0, 2)
+#define G3S_SEL_SDHI1		SEL_PLL_PACK(G3S_CPG_SDHI_DSEL, 4, 2)
+#define G3S_SEL_SDHI2		SEL_PLL_PACK(G3S_CPG_SDHI_DSEL, 8, 2)
 
 /* PLL 1/4/6 configuration registers macro. */
 #define G3S_PLL146_CONF(clk1, clk2)	((clk1) << 22 | (clk2) << 12)
@@ -74,10 +82,14 @@ enum clk_ids {
 	CLK_PLL6,
 	CLK_PLL6_DIV2,
 	CLK_SEL_SDHI0,
+	CLK_SEL_SDHI1,
+	CLK_SEL_SDHI2,
 	CLK_SEL_PLL4,
 	CLK_P1_DIV2,
 	CLK_P3_DIV2,
 	CLK_SD0_DIV4,
+	CLK_SD1_DIV4,
+	CLK_SD2_DIV4,
 
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -136,6 +148,10 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 	DEF_FIXED(".pll6_div2", CLK_PLL6_DIV2, CLK_PLL6, 1, 2),
 	DEF_SD_MUX(".sel_sd0", CLK_SEL_SDHI0, G3S_SEL_SDHI0, G3S_SEL_SDHI0_STS, sel_sdhi,
 		   mtable_sd, 0, NULL),
+	DEF_SD_MUX(".sel_sd1", CLK_SEL_SDHI1, G3S_SEL_SDHI1, G3S_SEL_SDHI1_STS, sel_sdhi,
+		   mtable_sd, 0, NULL),
+	DEF_SD_MUX(".sel_sd2", CLK_SEL_SDHI2, G3S_SEL_SDHI2, G3S_SEL_SDHI2_STS, sel_sdhi,
+		   mtable_sd, 0, NULL),
 	DEF_SD_MUX(".sel_pll4", CLK_SEL_PLL4, G3S_SEL_PLL4, G3S_SEL_PLL4_STS, sel_pll4,
 		   mtable_pll4, CLK_SET_PARENT_GATE, NULL),
 
@@ -147,7 +163,15 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 	DEF_G3S_DIV("SD0", R9A08G045_CLK_SD0, CLK_SEL_SDHI0, G3S_DIV_SDHI0, G3S_DIV_SDHI0_STS,
 		    dtable_1_2, 800000000UL, 500000000UL, CLK_SET_RATE_PARENT,
 		    rzg3s_cpg_div_clk_notifier),
+	DEF_G3S_DIV("SD1", R9A08G045_CLK_SD1, CLK_SEL_SDHI1, G3S_DIV_SDHI1, G3S_DIV_SDHI1_STS,
+		    dtable_1_2, 800000000UL, 500000000UL, CLK_SET_RATE_PARENT,
+		    rzg3s_cpg_div_clk_notifier),
+	DEF_G3S_DIV("SD2", R9A08G045_CLK_SD2, CLK_SEL_SDHI2, G3S_DIV_SDHI2, G3S_DIV_SDHI2_STS,
+		    dtable_1_2, 800000000UL, 500000000UL, CLK_SET_RATE_PARENT,
+		    rzg3s_cpg_div_clk_notifier),
 	DEF_FIXED(".sd0_div4", CLK_SD0_DIV4, R9A08G045_CLK_SD0, 1, 4),
+	DEF_FIXED(".sd1_div4", CLK_SD1_DIV4, R9A08G045_CLK_SD1, 1, 4),
+	DEF_FIXED(".sd2_div4", CLK_SD2_DIV4, R9A08G045_CLK_SD2, 1, 4),
 	DEF_FIXED("M0", R9A08G045_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
 	DEF_G3S_DIV("P1", R9A08G045_CLK_P1, CLK_PLL3_DIV2_4, DIVPL3A, G3S_DIVPL3A_STS,
 		    dtable_1_32, 0, 0, 0, NULL),
@@ -170,6 +194,14 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("sdhi0_imclk2",		R9A08G045_SDHI0_IMCLK2, CLK_SD0_DIV4, 0x554, 1),
 	DEF_MOD("sdhi0_clk_hs",		R9A08G045_SDHI0_CLK_HS, R9A08G045_CLK_SD0, 0x554, 2),
 	DEF_MOD("sdhi0_aclk",		R9A08G045_SDHI0_ACLK, R9A08G045_CLK_P1, 0x554, 3),
+	DEF_MOD("sdhi1_imclk",		R9A08G045_SDHI1_IMCLK, CLK_SD1_DIV4, 0x554, 4),
+	DEF_MOD("sdhi1_imclk2",		R9A08G045_SDHI1_IMCLK2, CLK_SD1_DIV4, 0x554, 5),
+	DEF_MOD("sdhi1_clk_hs",		R9A08G045_SDHI1_CLK_HS, R9A08G045_CLK_SD1, 0x554, 6),
+	DEF_MOD("sdhi1_aclk",		R9A08G045_SDHI1_ACLK, R9A08G045_CLK_P1, 0x554, 7),
+	DEF_MOD("sdhi2_imclk",		R9A08G045_SDHI2_IMCLK, CLK_SD2_DIV4, 0x554, 8),
+	DEF_MOD("sdhi2_imclk2",		R9A08G045_SDHI2_IMCLK2, CLK_SD2_DIV4, 0x554, 9),
+	DEF_MOD("sdhi2_clk_hs",		R9A08G045_SDHI2_CLK_HS, R9A08G045_CLK_SD2, 0x554, 10),
+	DEF_MOD("sdhi2_aclk",		R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11),
 	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
 };
@@ -178,6 +210,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A08G045_GIC600_DBG_GICRESET_N, 0x814, 1),
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
+	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
+	DEF_RST(R9A08G045_SDHI2_IXRST, 0x854, 2),
 	DEF_RST(R9A08G045_SCIF0_RST_SYSTEM_N, 0x884, 0),
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
-- 
2.39.2


