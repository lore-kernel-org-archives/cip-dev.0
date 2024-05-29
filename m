Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1F9C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:10:45 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.8628.1716970245254500270
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:10:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RxhKlvpx;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.170, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so32855931fa.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970243; x=1717575043; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEoQuJHyn2Mh9Mw3YZSnCxftwhyhkacyw3vyfCZ+U3k=;
        b=RxhKlvpx6AVfPsPYDgRm11AYalPmnJeDILsVf1L4x+aPyoozDXUu5NffKOwmSlQmel
         DIo6KRGQjuAarnHpnSp4jqY0uYYdTA/HgCFTFXtS2tBa5ut5yYCxZ7wc06aFHm99EYsc
         7s71Tax/V0S86yeVYsbdl/Evg9jIz61GnQYbBe5+5jmlv9NAdmhycM3pHjqCq6mYHEN+
         FwHLeyspbQs4t48zzYp70Y4/q6PAzUlMUf3jcx9dMNBTBd4jBPUn2y5xC099qLDvLVn9
         ffOUAcOUBbnIeLmSAw1V3fOF1k8iFEBQ3jNKVIKWiuGrctjaYW9Od1fEwxU+qI1HK+h4
         vs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970243; x=1717575043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEoQuJHyn2Mh9Mw3YZSnCxftwhyhkacyw3vyfCZ+U3k=;
        b=W/9rg6sr/0xZMn4s3I60EhaF6Znyk0WvIL2l6RnhL3AgtqxjTEco6KrUv0AEPkiJhi
         EzV/2BQW4/knpfRk3Cz4ZC6W3RS+RofK9zLwqMV2NyKP/vCHi04Lm7PodYaJMdzfWWi8
         McNBYTYHImQ2T8FZxjeR4HM1Gn1FX4wQNK4ia5NOWE5xGyZ28mExaKif+iljCC+4hGYB
         HtjXtJSiUTis4KdcU4CNVz7yxGqcR40blrftBN9DEbZtOgkUVhf+XpIh68aok50rw9So
         C/5Oq387CQV2MbQT38u9GJV1gT3TSrNMiB1RRyQdq5uGlFzqwndfFIi+0ecxnZLX7g4q
         dlUA==
X-Gm-Message-State: AOJu0YyXu6IBDOf/YXNWQ36qNP+GnZDMk0RXIH3ahKMj6r0jKsgyUXK5
	ZajpbNPD7IS/M757LFNv3otwJpXbzV9vQDAO0uXbinQ12YWyB+vKNZ9vIqbwfJw+NLxVByzMU1d
	X9i8=
X-Google-Smtp-Source: AGHT+IEwqEWjjXp5h6+Jg4CzoQ/PsW1+hOJlICGu1VJpz23h0o66V1BLnCX6dUFdsShGFTpS98Adew==
X-Received: by 2002:a2e:3514:0:b0:2ea:7e39:bd38 with SMTP id 38308e7fff4ca-2ea7e39c68dmr4109541fa.34.1716970243154;
        Wed, 29 May 2024 01:10:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 01/47] clk: renesas: r9a08g045: Add clock and reset support for ETH0 and ETH1
Date: Wed, 29 May 2024 11:09:53 +0300
Message-Id: <20240529081039.639010-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:10:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15981

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 515f05da372aedf347a1ac99d17fb832ba371d4d upstream.

RZ/G3S has 2 Gigabit Ethernet interfaces available.  Add clock and reset
support for both of them.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231207070700.4156557-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 4394cb241d99..a6d3bea968c0 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -181,9 +181,11 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 	DEF_G3S_DIV("P3", R9A08G045_CLK_P3, CLK_PLL3_DIV2_4, DIVPL3C, G3S_DIVPL3C_STS,
 		    dtable_1_32, 0, 0, 0, NULL),
 	DEF_FIXED("P3_DIV2", CLK_P3_DIV2, R9A08G045_CLK_P3, 1, 2),
+	DEF_FIXED("ZT", R9A08G045_CLK_ZT, CLK_PLL3_DIV2_8, 1, 1),
 	DEF_FIXED("S0", R9A08G045_CLK_S0, CLK_SEL_PLL4, 1, 2),
 	DEF_FIXED("OSC", R9A08G045_OSCCLK, CLK_EXTAL, 1, 1),
 	DEF_FIXED("OSC2", R9A08G045_OSCCLK2, CLK_EXTAL, 1, 3),
+	DEF_FIXED("HP", R9A08G045_CLK_HP, CLK_PLL6, 1, 2),
 };
 
 static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
@@ -202,6 +204,12 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("sdhi2_imclk2",		R9A08G045_SDHI2_IMCLK2, CLK_SD2_DIV4, 0x554, 9),
 	DEF_MOD("sdhi2_clk_hs",		R9A08G045_SDHI2_CLK_HS, R9A08G045_CLK_SD2, 0x554, 10),
 	DEF_MOD("sdhi2_aclk",		R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11),
+	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0),
+	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0),
+	DEF_MOD("eth0_refclk",		R9A08G045_ETH0_REFCLK, R9A08G045_CLK_HP, 0x57c, 8),
+	DEF_COUPLED("eth1_axi",		R9A08G045_ETH1_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 1),
+	DEF_COUPLED("eth1_chi",		R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1),
+	DEF_MOD("eth1_refclk",		R9A08G045_ETH1_REFCLK, R9A08G045_CLK_HP, 0x57c, 9),
 	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
 };
@@ -212,6 +220,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
 	DEF_RST(R9A08G045_SDHI2_IXRST, 0x854, 2),
+	DEF_RST(R9A08G045_ETH0_RST_HW_N, 0x87c, 0),
+	DEF_RST(R9A08G045_ETH1_RST_HW_N, 0x87c, 1),
 	DEF_RST(R9A08G045_SCIF0_RST_SYSTEM_N, 0x884, 0),
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
-- 
2.39.2


