Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EE7C4450C
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:08 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19081.1782820137839133728
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qka+oBaP;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-473dc4cf238so1273482f8f.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820136; x=1783424936; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNgTuZ21wccW4nqbsdfTEzBmS/jq0kCP8nmD9v2r23U=;
        b=qka+oBaPeeKQZDr3FSzsA/AvBh61pcpVT7THBxqWqmnb100eEH0lIi2wueY+cSz1xw
         QW1/mVEYgBzoP/n0TRThgheiLE388Z0lYWnYZ/HsiM9Ijaiiy+AYXbd/ur7+jdNQp/uI
         Cw8mIPLtkJDBD340neyZujg2eRYPIccDo27rDSCLYa+nmsrhc+SBhr6+FgZGyq3Mc6FH
         0uWbxl4BtFOE3k07o8FIe/7WzBnVqLusn51RCMlfZI4hdDfgxTkl7BOuzbmkyoS1V/7G
         +/P/1LSsZB+kW0S/he+6rKhC/Iu4NVawKB5zfNLOE3/GGzqShTgb3iCv+1CWIOlxLQBt
         zslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820136; x=1783424936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XNgTuZ21wccW4nqbsdfTEzBmS/jq0kCP8nmD9v2r23U=;
        b=dhnboLHBapbAv6un2NIiFwgVSre7gSiG4S+RuKKT8U+53P5lEQkC5e0Wdj6CqcXx9n
         YEsFEUzsno1kocsydHf5PrY3FiBr+66SNV4V0JYguAMOIjTsWj3Ali5uJgrDMJUsR4Cf
         cQxbB1OD0xP8qfMQQZlVUBECDvGYWiIjInRTQOOkzriAr2jve3KnoTG+Ix9bcuDyiHpi
         YpDSdy/4sL0HC4sTbKx+ssWoHFeoe4cj2TN2UCk8HlLrUw26/p7IdbiEkvOLWersYEKt
         JpFEJToXHQW2ecBh5FnFCoSE/N3O+TIRd8ZRsHZRiOV+rkydFlBB58Lu/gTwbOI1oTol
         dKhQ==
X-Gm-Message-State: AOJu0YyEbVIEEStfu6L9tg/ivNDNxgZZOnh2IRGAZMWujVuRjsEcY5Sa
	7b1ZJth4OMymJMnRvIfPnx813rs2XOuYTb+lAPBxUa5GLRsu1fIpMFJjtqfziMIs
X-Gm-Gg: AfdE7ckcb9DZkCpMYp8mao49yqZgNA3pPVvedsfTHsJ2D1VIKi9GrSXokWGWeRZa1Wi
	TBIakIJQYStbz/0/6loHSlpkzwqFwDSkNgspxcago99AjmkAebFGtbH7cysadCuedvUZOyR4G4u
	jdfCG5Kr+FpgmY4MMorZFeP7xrKXjXX+XRFRU5XYcKgXb7P7g0zvE7MPC0+5vhUjMlCF8eu0suv
	cWilgRMds900XovhdqFubhS2p3IYe7VUPd657aVh0z3jXlrjgS4HkXys6HC2rKLC2bIdNV6X7I6
	EcGMnVgCslPj/Jft+amflfVPWHJrAvdHC5yHRANoZxhiBypxRvk5py858SEyn2uSBBsQSS7PaUU
	sl/vdJR30iHEil3aB7XVZlZsLF1/MEZQJXyMD+5FhnedGgsXycEh2yozvDrKq/VBY8xt1Qw68FX
	tp/Lnz1iNxxlvnufqby1Zhy24xj/1RloW+JMwnHA==
X-Received: by 2002:a05:6000:2908:b0:475:f3c5:f8a5 with SMTP id ffacd0b85a97d-475f3c5f982mr2029046f8f.15.1782820135970;
        Tue, 30 Jun 2026 04:48:55 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:55 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 26/39] clk: renesas: r9a08g046: Add CA55 core clocks
Date: Tue, 30 Jun 2026 12:47:45 +0100
Message-ID: <20260630114813.92739-27-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23350

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 4ea266768a258e94a0e2376f5345d4303ab8074f ]

Add CA55 core clock entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260330132349.149391-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g046-cpg.c | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g046-cpg.c b/drivers/clk/renesas/r9a08g046-cpg.c
index dc4108325d9d..d47aeaea2d6e 100644
--- a/drivers/clk/renesas/r9a08g046-cpg.c
+++ b/drivers/clk/renesas/r9a08g046-cpg.c
@@ -17,6 +17,7 @@
 /* RZ/G3L Specific registers. */
 #define G3L_CPG_PL2_DDIV		(0x204)
 #define G3L_CPG_PL3_DDIV		(0x208)
+#define G3L_CPG_CA55CORE_DDIV		(0x234)
 #define G3L_CLKDIVSTATUS		(0x280)
 #define G3L_CPG_ETH_SSEL		(0x410)
 #define G3L_CPG_ETH_SDIV		(0x434)
@@ -25,6 +26,10 @@
 #define G3L_DIVPL2A		DDIV_PACK(G3L_CPG_PL2_DDIV, 0, 2)
 #define G3L_DIVPL2B		DDIV_PACK(G3L_CPG_PL2_DDIV, 4, 2)
 #define G3L_DIVPL3A		DDIV_PACK(G3L_CPG_PL3_DDIV, 0, 2)
+#define G3L_DIV_CA55_CORE0	DDIV_PACK(G3L_CPG_CA55CORE_DDIV, 0, 3)
+#define G3L_DIV_CA55_CORE1	DDIV_PACK(G3L_CPG_CA55CORE_DDIV, 4, 3)
+#define G3L_DIV_CA55_CORE2	DDIV_PACK(G3L_CPG_CA55CORE_DDIV, 8, 3)
+#define G3L_DIV_CA55_CORE3	DDIV_PACK(G3L_CPG_CA55CORE_DDIV, 12, 3)
 #define G3L_SDIV_ETH_A		DDIV_PACK(G3L_CPG_ETH_SDIV, 0, 2)
 #define G3L_SDIV_ETH_B		DDIV_PACK(G3L_CPG_ETH_SDIV, 4, 1)
 #define G3L_SDIV_ETH_C		DDIV_PACK(G3L_CPG_ETH_SDIV, 8, 2)
@@ -34,6 +39,10 @@
 #define G3L_DIVPL2A_STS		DDIV_PACK(G3L_CLKDIVSTATUS, 4, 1)
 #define G3L_DIVPL2B_STS		DDIV_PACK(G3L_CLKDIVSTATUS, 5, 1)
 #define G3L_DIVPL3A_STS		DDIV_PACK(G3L_CLKDIVSTATUS, 8, 1)
+#define G3L_DIV_CA55_CORE0_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 12, 1)
+#define G3L_DIV_CA55_CORE1_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 13, 1)
+#define G3L_DIV_CA55_CORE2_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 14, 1)
+#define G3L_DIV_CA55_CORE3_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 15, 1)
 
 /* RZ/G3L Specific clocks select. */
 #define G3L_SEL_ETH0_TX		SEL_PLL_PACK(G3L_CPG_ETH_SSEL, 0, 1)
@@ -62,6 +71,7 @@ enum clk_ids {
 	CLK_ETH1_RXC_RX_CLK_IN,
 
 	/* Internal Core Clocks */
+	CLK_PLL1,
 	CLK_PLL2,
 	CLK_PLL2_DIV2,
 	CLK_PLL3,
@@ -84,6 +94,16 @@ enum clk_ids {
 };
 
 /* Divider tables */
+static const struct clk_div_table dtable_1_32[] = {
+	{ 0, 1 },
+	{ 1, 2 },
+	{ 2, 4 },
+	{ 3, 8 },
+	{ 4, 16 },
+	{ 5, 32 },
+	{ 0, 0 },
+};
+
 static const struct clk_div_table dtable_2_20[] = {
 	{ 0, 2 },
 	{ 1, 20 },
@@ -134,6 +154,8 @@ static const struct cpg_core_clk r9a08g046_core_clks[] __initconst = {
 	DEF_INPUT("eth1_rxc_rx_clk", CLK_ETH1_RXC_RX_CLK_IN),
 
 	/* Internal Core Clocks */
+	DEF_G3L_PLL(".pll1", CLK_PLL1, CLK_EXTAL, G3L_PLL1467_CONF(0x4, 0x8, 0x100),
+		    1200000000UL),
 	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
 	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
 	DEF_G3L_PLL(".pll6", CLK_PLL6, CLK_EXTAL, G3L_PLL1467_CONF(0x54, 0x58, 0),
@@ -153,6 +175,14 @@ static const struct cpg_core_clk r9a08g046_core_clks[] __initconst = {
 	DEF_DIV(".div_eth1_rm", CLK_ETH1_RM, CLK_SEL_ETH1_RM, G3L_SDIV_ETH_D, dtable_2_20),
 
 	/* Core output clk */
+	DEF_G3S_DIV("IC0", R9A08G046_CLK_IC0, CLK_PLL1, G3L_DIV_CA55_CORE0, G3L_DIV_CA55_CORE0_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_G3S_DIV("IC1", R9A08G046_CLK_IC1, CLK_PLL1, G3L_DIV_CA55_CORE1, G3L_DIV_CA55_CORE1_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_G3S_DIV("IC2", R9A08G046_CLK_IC2, CLK_PLL1, G3L_DIV_CA55_CORE2, G3L_DIV_CA55_CORE2_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_G3S_DIV("IC3", R9A08G046_CLK_IC3, CLK_PLL1, G3L_DIV_CA55_CORE3, G3L_DIV_CA55_CORE3_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
 	DEF_G3S_DIV("P0", R9A08G046_CLK_P0, CLK_PLL2_DIV2, G3L_DIVPL2B, G3L_DIVPL2B_STS,
 		    dtable_8_256, 0, 0, 0, NULL),
 	DEF_G3S_DIV("P1", R9A08G046_CLK_P1, CLK_PLL3_DIV2, G3L_DIVPL3A, G3L_DIVPL3A_STS,
-- 
2.43.0


