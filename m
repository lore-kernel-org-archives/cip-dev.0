Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87084CCFA1B
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:55 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10112.1762416766877701473
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bwa671Jf;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429bf011e6cso633524f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416765; x=1763021565; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pvJbytWTzeQQgTeew+XJ2afs5Lm454b8s0jaDQoDtQ=;
        b=bwa671JfsS6lKC0wd7Eil+rSruK+7U21bzhy+AOocZQg/fc9V0cdLWbceLRVGoVlWM
         3cZoGvsH/9+YPk5Aorn/IFk0PH/jl3sgQcubXRGa50S9oc37iISP80NQS/fmZYv6qY4l
         KlPAFNWfN0d4mzSKGoheTqeS06q6u0Rg4nFzvHgdzB2e3azxTyVWolumtDJzf+XPkxUu
         31McrX2uQl7SfzmRmqsJijLXps1O18R/ABsbSIuTX36HJZ8Q/LyY1ZL2gxmqziLIZ5pu
         oOcBtJ1uUtOkc3xnL9FiZk/eaS+URemF9WqvaQmBIC0bRPZ+lbH/sTc8FY1YGi9xPYUv
         Wmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416765; x=1763021565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pvJbytWTzeQQgTeew+XJ2afs5Lm454b8s0jaDQoDtQ=;
        b=kQ9qwRl9FZ/TxVWjZroBv9dXVSRTJ55ALvtHyelpSrrplHt8gJL98N3hWdcdgc/NCA
         SY7Aq9fE5UA/KwIVEcTYfLY5gh/D3sMYJtlQncq5lmIxKfsvQlu1u94qxs+Q6yLMwuXL
         3L1UsTdUTEADpv8/rycqH4aGthxqQhK+NrZQQoiHm9vmdJGwZgurBTjiYjmKAX/byEQc
         Q/kU/MTmsjLv5uLjGXuylloboS984Ayuyg3riIVdbaEoixAYoGASnPAKt27Z/XUBTy4c
         r5Vt8URgxn70xEpu5YRlakgVITOKwnQaczYQ9FnOFBDMaGuUEnKjv/0uiL9/GTo6L8ka
         xNMA==
X-Forwarded-Encrypted: i=1; AJvYcCWUgObgT+FiFPH4cGu7uHTDfelFEm014G+F+lGBRd9iQCNwclwcn/iWsS4SHcqI5YDzbGwChMgD@lists.cip-project.org
X-Gm-Message-State: AOJu0Yyf9AfrcGR65IHToYfk3s0DRpGAb6b77LqVwfILWAE8SMhK37Hx
	Q7ZbHUeMJ7UaB8jkUSOHi5N6H+QZY5zxLEQ6+q5F4XrxTWUVsxgHy9wUvQi6sQJOml67tRBBzgu
	XhVH7BLk=
X-Gm-Gg: ASbGnct6LOpOQJRApWi10kLxez+lbpRXPfTiZZY49hyYrZu6frq/HNbaj2Dgae3Akr5
	F3VfL96blTKu8wOft20bRBIikRvb9POEpSganKNO9UoNYKje1wvmuNF5drY8gNrIwD6zdiNLpHS
	gH7kmfYsHU0k1VHpPBenurLrqBcctKSTnua0urCRAc7ctc5hG/lggtK8r9F/gFawfK/Rdel2Ujy
	08Pn7C07Sq1fK6t92aGKsL+J0/3Yakmait+YsQik/yrdRSledHuUi6EALRFWGoemQRQ/iMfSNfh
	+jLKy9+Cp/Qi2rTlduRl2fB8q3RTcChcc929H9+Pw20bWQBlUyE2dHVWX93XPaho7B17uO3nCi+
	H8Shqt11EmD1zv6xN/xSyW5aG6Eh2nAK3VBjIQgBSEsDZR6f8hZOqIVAHISJPmcUhok4srtyhq6
	cCgUywQdNLNJLcdWd8E99Y3HeQYqPUX5KyFzKuLsIh
X-Google-Smtp-Source: AGHT+IFf0x37ugFw79ts0zsMyPnvHj902HeHBE5i7GybkHl1c6/JQnzbnPnyL1fyeVBYul20redRaQ==
X-Received: by 2002:a05:6000:1acb:b0:429:d6fa:da20 with SMTP id ffacd0b85a97d-429e32e48famr5237211f8f.25.1762416765227;
        Thu, 06 Nov 2025 00:12:45 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:44 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 18/22] clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
Date: Thu,  6 Nov 2025 10:12:14 +0200
Message-ID: <20251106081218.2574950-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20435

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0ab2d84f94dae48c3e7605cdc99dbb4e7c7b206a upstream.

If MSTOP is not added for both clocks in a coupled pair, and the clocks
are not disabled in the reverse order of their enable sequence, the MSTOP
may remain enabled when disabling the clocks.

This happens because rzg2l_mod_clock_endisable() executes for coupled
clocks only when a single clock from the pair is enabled. If one clock has
no MSTOP defined, it can result in the MSTOP configuration being left
active when the clocks are disabled out of order (i.e., not in the reverse
order of enabling).

Fixes: c49695952746 ("clk: renesas: r9a08g045: Drop power domain instantiation")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250704134328.3614317-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index f5f0ddca4b8b..6d7295c36d5a 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -246,11 +246,13 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_MCPU1, BIT(13))),
 	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0,
 					MSTOP(BUS_PERI_COM, BIT(2))),
-	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0, 0),
+	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0,
+					MSTOP(BUS_PERI_COM, BIT(2))),
 	DEF_MOD("eth0_refclk",		R9A08G045_ETH0_REFCLK, R9A08G045_CLK_HP, 0x57c, 8, 0),
 	DEF_COUPLED("eth1_axi",		R9A08G045_ETH1_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 1,
 					MSTOP(BUS_PERI_COM, BIT(3))),
-	DEF_COUPLED("eth1_chi",		R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1, 0),
+	DEF_COUPLED("eth1_chi",		R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1,
+					MSTOP(BUS_PERI_COM, BIT(3))),
 	DEF_MOD("eth1_refclk",		R9A08G045_ETH1_REFCLK, R9A08G045_CLK_HP, 0x57c, 9, 0),
 	DEF_MOD("i2c0_pclk",		R9A08G045_I2C0_PCLK, R9A08G045_CLK_P0, 0x580, 0,
 					MSTOP(BUS_MCPU2, BIT(10))),
-- 
2.43.0


