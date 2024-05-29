Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BF0C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:47 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.8664.1716970479489809482
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EWWpdKu7;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso14166215e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970478; x=1717575278; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEoQuJHyn2Mh9Mw3YZSnCxftwhyhkacyw3vyfCZ+U3k=;
        b=EWWpdKu7TSJRbTG4PP6wQDhrzaSArx9Zrizex36gQ5GbSflfZhoEToMjW39OW2cvWs
         B5/VtWRZbgsEIfYuA4FNWSuRoQmiVopBjIibMNqDpsjYRcmLBQjbr2+z3KdyO9XMZIe6
         B24UV5ET8BPsvucG8y2I7DvXkH43/08G++wOsW1Zsrl7Gcd8tsvEsp3pLGR7YbkmOYV4
         Wjtxe5LhwuU9Fn+e5IJpUewvon1TqQrr3C8d7n0t9Jkn3uonOjRmjh5ZQOlFieDljcaU
         mYPB1H3NOCpJKFEY7yPo/3imzxBzVCFxoNxw+TMXoEe7y+IyJVID84A7KYOZU64tCrsx
         7qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970478; x=1717575278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEoQuJHyn2Mh9Mw3YZSnCxftwhyhkacyw3vyfCZ+U3k=;
        b=swPivkrnT1OXbQILCQIzAQgja15zLnAbyy8HiZ+MR/v3T43OEClwcKY77GdAAdsV4M
         YEem2wS9jjhsRgZgMfBQrL7uua6g31nS885T+8QX9tC6bDzXCzCq2Ru9vdkDlJPDt3Sq
         IpD9mJHfGNuK0VCsS634nWi5xLOo5GQCkvkCaG83Bry7LzlgRikr465ZhNGSfPc21vhi
         SNuUMcY96/nDO/ZZI9aQwiX9fYIqWYpriMO0GuGM95hEkVz6CuB4TEJMhzCw6n54D5DC
         kwZlEx2MxHgAxbFQ93N7pv6K0/fpAcHrcA0nqspf4+DV5sPt5jTbQk7YBtM1DXT6lM5K
         qgcA==
X-Gm-Message-State: AOJu0Yz7HT3UgG9lBar/TOS+Ja+XJD0lhx4an4z5sz6NDrDn8LXgGhSs
	NF5IsqLFBHhtIi9bU6gmnaKLoc7ZVyt27xhc6X8jdmqEOp5jdfSYtKlTAOBsvm8=
X-Google-Smtp-Source: AGHT+IHno5bRO7rlErG5hzFQnUc1ommSsm2kfeFzydySct7EDYsuHl+SxGnNI5tXlY7l2rSUnxD+sQ==
X-Received: by 2002:a05:600c:68cb:b0:418:dbad:c57d with SMTP id 5b1f17b1804b1-42108a1f7d3mr97527085e9.28.1716970477936;
        Wed, 29 May 2024 01:14:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 01/33] clk: renesas: r9a08g045: Add clock and reset support for ETH0 and ETH1
Date: Wed, 29 May 2024 11:14:02 +0300
Message-Id: <20240529081434.639519-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16029

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


