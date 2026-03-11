Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE8B10611EF
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:30 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18690.1773227125846307603
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=F6DLbXCH;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b78b638eso11356061f8f.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227124; x=1773831924; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpFIyR5hD45AhwsvJHTbL/45o+ojOv1J7+L3zA6sYuM=;
        b=F6DLbXCHK4Yjt5XV0edMtYMwIXI28aNwpd/3z5Q2Ce7YB69BmU91oEs3aNWZzB9s4K
         nLMrpHUKfONF3TmEhPRCFLciD0//sWKByeAxJCfV5OH+NmUhqPnYm4YxEIZAgtPPBZfi
         Eau8sGoLMDWPmkg1jwZ7nR7uBNrAltLC5zot60ktJB3wszZkezuePXu1PDQPN/u8UWiq
         rNeocssxeg9Q5VHskHbvgj+WkscRdoGzdw1fXUmu+hSFQNGPMyfq5hDkaWOVAezS4C/A
         9IlT1v1xhZCHZd2rQSlIo+BS+cqJtqaChmf001ytbDjsB4Zkht0IkoB6TANDGWa6dIr2
         S0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227124; x=1773831924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BpFIyR5hD45AhwsvJHTbL/45o+ojOv1J7+L3zA6sYuM=;
        b=jV6w84xVe+bKNwuaSsqW8jW2uj/pr57MeOcRZgroMEEtKITSGrk1/mTV8HdXIcLkMF
         vvTh1jvdpDQtxzqpFvpVPHtjHYoJ1p1nCqHg7cAhzHHyTcuHwGjW+WX9TjxJ13LIStD1
         oS/0TbpW3aEkXnM36goU3qU2qQXIQXXxAW0Ejyerw3KmdOWwqpRI8o0Khh3x9RKzbEFj
         SUx7oWCBnl76MsnNKyWbsrOWrphov2QKarbkvY/R4Ho7mwbO5O8dOeonzqoNc+Q30KmQ
         VSC3EQFCIWPizjZi89YSivujg8VXyeAgW50H9TqazkZghPaPpOsqdUud6vvOUQ5imtGe
         l+bw==
X-Gm-Message-State: AOJu0YzGU2i+WSw73zRpygnwOJimQP3Hz3uH8npJ1vq/ezmoWBn3L+lr
	FlabKSJUy6UwJvIAM6rEFKq3mXYdp9+xO9rUL1tTJyemuodJHumWwqiSrLscwytb3XCkdJUVJGw
	9+FiQ
X-Gm-Gg: ATEYQzwc+u5Y1DgkIMKegf0gnosUv5FiV4RbZDGDM6UA33ND+UXC+PLSv4TChCdRvds
	mqaBQzLQUp+xyuHtMYSTLEivoFQdLzFcqIUkWY3j2vNaJ52Uz6y1g+8oKdHwSQ/EqOie5GTfGEC
	+BIH2cRZqyZY/e9WI6illil2ffkeiDQtKjygUfm0uWk3d9w3jQ1WNALRpVMpsO4jMiKS2l4dqv9
	51oZn2t/H4lOjL53GN0ZtbN2b8JkFJd8XqcrN9VzWs9+1cQLoifuvL1jZQi4SvtGd59kq1JQfxS
	AsreryrkvgwhwUtkASUacLumGejMg7PASYN6jAlG7RCHzq/inD3U/9i0v6LENnhyPGkp7ch36x0
	80u+DET551EWh/4qCpuqGTwfhPUtinCvKIKgBvq3ya45lcKUKHykNUTL3ZyreEw4XrBcHpfAA52
	Iq6jUzTdI7TsBkNd+l2FFJxmMWWd4ahFQHqXWxMF5/EeaoKCU2wgHo
X-Received: by 2002:a05:600c:4fcb:b0:485:35a4:939c with SMTP id 5b1f17b1804b1-4854b132402mr35015405e9.29.1773227123721;
        Wed, 11 Mar 2026 04:05:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:23 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 01/17] clk: renesas: r9a08g045: Add PCIe clocks and resets
Date: Wed, 11 Mar 2026 13:05:04 +0200
Message-ID: <20260311110520.1938414-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22309

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 6b234eda88d781d244094836afc37c90b57832f3 upstream.

Add clocks and resets for the PCIe IP available on the Renesas RZ/G3S
SoC.  The clkl1pm clock is required for PCIe link power management (PM)
control and should be enabled based on the state of the CLKREQ# pin.
Therefore, mark it as a no_pm clock to allow the PCIe driver to manage
it during link PM transitions.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250704161410.3931884-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by dropping I3C clocks and resets as
 these are not yet present in v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index c3b64f94e188..3e8eae79af09 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -283,6 +283,10 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_MCPU2, BIT(14))),
 	DEF_MOD("tsu_pclk",		R9A08G045_TSU_PCLK, R9A08G045_CLK_TSU, 0x5ac, 0,
 					MSTOP(BUS_MCPU2, BIT(15))),
+	DEF_MOD("pci_aclk",		R9A08G045_PCI_ACLK, R9A08G045_CLK_M0, 0x608, 0,
+					MSTOP(BUS_PERI_COM, BIT(10))),
+	DEF_MOD("pci_clkl1pm",		R9A08G045_PCI_CLKL1PM, R9A08G045_CLK_ZT, 0x608, 1,
+					MSTOP(BUS_PERI_COM, BIT(10))),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0,
 					MSTOP(BUS_MCPU3, GENMASK(8, 7))),
 };
@@ -319,6 +323,13 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
 	DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A08G045_TSU_PRESETN, 0x8ac, 0),
+	DEF_RST(R9A08G045_PCI_ARESETN, 0x908, 0),
+	DEF_RST(R9A08G045_PCI_RST_B, 0x908, 1),
+	DEF_RST(R9A08G045_PCI_RST_GP_B, 0x908, 2),
+	DEF_RST(R9A08G045_PCI_RST_PS_B, 0x908, 3),
+	DEF_RST(R9A08G045_PCI_RST_RSM_B, 0x908, 4),
+	DEF_RST(R9A08G045_PCI_RST_CFG_B, 0x908, 5),
+	DEF_RST(R9A08G045_PCI_RST_LOAD_B, 0x908, 6),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
@@ -330,6 +341,10 @@ static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G045_VBAT_BCLK,
 };
 
+static const unsigned int r9a08g045_no_pm_mod_clks[] = {
+	MOD_CLK_BASE + R9A08G045_PCI_CLKL1PM,
+};
+
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	/* Core Clocks */
 	.core_clks = r9a08g045_core_clks,
@@ -346,6 +361,10 @@ const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	.num_mod_clks = ARRAY_SIZE(r9a08g045_mod_clks),
 	.num_hw_mod_clks = R9A08G045_VBAT_BCLK + 1,
 
+	/* No PM modules Clocks */
+	.no_pm_mod_clks = r9a08g045_no_pm_mod_clks,
+	.num_no_pm_mod_clks = ARRAY_SIZE(r9a08g045_no_pm_mod_clks),
+
 	/* Resets */
 	.resets = r9a08g045_resets,
 	.num_resets = R9A08G045_VBAT_BRESETN + 1, /* Last reset ID + 1 */
-- 
2.43.0


