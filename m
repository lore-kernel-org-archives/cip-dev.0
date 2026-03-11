Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45231061202
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:41 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18347.1773227198176359468
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=UjL6LoeR;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439baf33150so755907f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227196; x=1773831996; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywgOLeXq4pXcgD1dUKm//7e0E50L2eCCYYXcPgtXzhw=;
        b=UjL6LoeR3vOxKbAHYegMe7vaKC3KBqasCoMEhHQ2Me6Uy32xK46T+EZGEnK1NTxyo1
         48zyKrYLgqqQAWdqmyrnL465HtZLGFcyHD/dWtIhdlE9Yi8O8vDJ2VFZilAUKAZFaWwG
         AOW7TxHomszK5aghrws6Xvak5wX+vL5elKdUtU8epSzyjB9ZZZ9Wh7nejW/eUzYBo91i
         WWy82B0icCfT9WxkpAzQxj32MKnuxGcnCBTCbNzgRAv4Qjv4izjtDmIWoVkPFtWUbDGL
         xT09gcdxMVAryI9BP30lrmkefXYWYiOmZB6IC+Xll03iYnKP5rhHkmEaeP4aVqd+wNvW
         5SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227196; x=1773831996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ywgOLeXq4pXcgD1dUKm//7e0E50L2eCCYYXcPgtXzhw=;
        b=RCFA0crF40u7KJnQWEsZFSGy7yosINB6gH5IHOAYNsFa7i2HQeLuW+ByKa3fPhuR3i
         OIsihJcgXi4rsPtq5Pwxuiah2xMTTCNkHb4XMNumiEuYU53csOI+SXtcBrwNMD4pFEtY
         ig1UWJZH6aOA74HO3q+6T8AK/tUf0DUkNQgzeOXRXufIDPo1gGxqk/KLiU8zgHGADxcU
         KanoGjSlC2oN6ZzF6c+yi49C6Ac8ZFSJBS6d15I3UAt9WwE8fdfql1yAHM43avxL7zfR
         W9nOoc4lXCUA4iMTI0GqZF+mBEA48MFMVL6TJ/cM2CV9EmbH29SXaWYkMzn85DMGJONE
         kL3w==
X-Gm-Message-State: AOJu0Yw9FuZg2fuMO27dkWfN2D2vs3hwZTvX07Lsz68RStgS3x3R74au
	noA4qK2+p7ZRuZBclsoAN7B7ZlNDkYr5v/DnejwyFDfnKRqTsS4LdtQ0brUovx3gc4EkQlhQX8Q
	KQNa9
X-Gm-Gg: ATEYQzwC099sV+A4EeGdBT4JyxcEhkA/TXSjZNrvfzVX34sVg+aWNFrH+uG4kpY2AXb
	dIlj9F/otiq4Yjigvq4oT/96qMFK4g9zb9NNB/O4R5WMznajQrIpTFEMPsT9bP+HjQWA57ReNRm
	sjZOpQavCI1CAjffSoLkJ96bQYNzqITpt/01WBDFyrIGVZ92ONsC7n6StY9T3deypaH8QTiPkN1
	KTYj2Clon+wHuSpLawI39wRFd9jmA6OUSLDfnA+jIne4pZzdMwU541cFV9ZLhk+IOpwCu8LsHqh
	Wg4TaxME98nb2AjKzopsvA4+wvlAqnSRJLX/ZLffD1zBnx2v8yHSps3sHEzoNgjuRp+3xD0csnm
	xKamLifP8WGlej6fQoWZaZkoHXZZIq8/QckifFNPWJ7vz2+/0RxN+1RkvaQhpsJaeoCpZXbmkVI
	N1ZqVkbTFCJO7C6gHRISVKOWIfTDf4/MrVrnPSulr9cqnruMpdnoCx
X-Received: by 2002:a05:6000:40de:b0:439:d755:a5ab with SMTP id ffacd0b85a97d-439f8bb1862mr3850491f8f.6.1773227196510;
        Wed, 11 Mar 2026 04:06:36 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:36 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 01/13] clk: renesas: r9a08g045: Add PCIe clocks and resets
Date: Wed, 11 Mar 2026 13:06:21 +0200
Message-ID: <20260311110633.1938579-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22327

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
 these are not yet present in v6.12 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 9e6bda7f6c57..937a044cd5d3 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -291,6 +291,10 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
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
@@ -331,6 +335,13 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
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
 
@@ -342,6 +353,10 @@ static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G045_VBAT_BCLK,
 };
 
+static const unsigned int r9a08g045_no_pm_mod_clks[] = {
+	MOD_CLK_BASE + R9A08G045_PCI_CLKL1PM,
+};
+
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	/* Core Clocks */
 	.core_clks = r9a08g045_core_clks,
@@ -358,6 +373,10 @@ const struct rzg2l_cpg_info r9a08g045_cpg_info = {
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


