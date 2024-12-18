Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3178EE77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:25 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.104378.1734524601440620291
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:23:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=aAXXKaom;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e06af753so3313612f8f.2
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524600; x=1735129400; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11AoqFUKSWD3zMs2LLxkh6xVkPrdT/9gMNfkIPFCQXU=;
        b=aAXXKaomWsIFuDN8f6jhHlXA+J9NZzQC8JKC708p8WZ1fiJMUWFOZFil/Id5V/pggB
         fDAvGU4KCmbWNgUyt0T1/dnaWNoXTd7abW3HtRgLItS8E3TIXlwBJQywZJJ1yKv8z/BP
         8kXM1t4dvMt5SnsicODRnUxzzKRhRCt4RalcN/K1kpv+lQ1iMZloduGnMxqdNJEKhCKJ
         OzDf0Pyvh0ekuBJJASvei7FIoxNx9DptjhFb6hD5PRcnUwmqltEb3ldMr9OXKctF/o4U
         ttCOLhpCQLxBYJwgg1pKDHZ3HArQR7oNQESFIp0HXEVuIDU2Zx6TLh5HuWus6ilnxr5A
         2E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524600; x=1735129400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11AoqFUKSWD3zMs2LLxkh6xVkPrdT/9gMNfkIPFCQXU=;
        b=dJmqlhvuTOzVeIvZ3fAUBPCaQZdu6etmM0N2uHSbjfqFldMGyS+JkQgB8rbuqcB7+u
         nEZJi5uSDRu9hwiU1uOE4PNGyWyQndCjASuygGR2B0U5nUs0fGMXoeQkuFRtBmbMKkNc
         EiSunvAg8+Y5dOUipTiuH/75JdvXbyIsYnky5C02UfjnqWPfGM/Ei4S+PLKf76MW4jSm
         m/9Z7ykzIfPc1WsrixhCqYc9ux1K9WW8tOtFxITM0mZhLybLaHDBZBy/6Mmcze6kJA/8
         6O5vaRG6JkYr76qiboZrcIJGBOxK9eQIDV37bQlvgrySoUWmXxZ3w+blDVBHqVIOk9qg
         qkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0VY3Ptbn361nY9/zkNanFUX2FuiJT4iaTwj2s4uMzdV2w9ib7fL5fXPC/t7FWigejiwxS/UCJ@lists.cip-project.org
X-Gm-Message-State: AOJu0YxT/M3o6Rbho/6kwpnLvyqcEpMLVrfgd2LIOCAlUHsmNjA3u+Vj
	xhgOPOCtByNYGuG9hYejF1fKh71DnAPtvtdrhdcRJsf5DNjiKLqGtmBIfdIkTaw=
X-Gm-Gg: ASbGncv0vY4m5XMKXx40VFM1JA6WRKdAHCNnM5flFeZZEOWuX4Yn5Iw+762E00Tpe8a
	/haEnckFTLmko6IvKkAvT33d9o6EqOTUlzrxhY+4lm9y7ErIh4XkEvG/oamix1cw9bQVZBohebI
	TIVuL2xQkg6G72ALOKiY50KuOK3KdiK0nYq/GvE1LOp8ZZC8zOBdsfHIJd1oO12qQr0T6Ac/cUT
	RkT48XrcnUTwfHd+sMaz+vAUY5LKwPWZbWRsMW8JHsMdkbP1xMQWGn+dCn3t55tNoW8mlYfMbb9
	w8fzY0jsQVE=
X-Google-Smtp-Source: AGHT+IEQhevb3fmuUVggxtwVNodkEu5PISGi0ASh5nFJJpc4VUEaB0K90re2RPtaJ4loZN+5tQvGDA==
X-Received: by 2002:a5d:64a1:0:b0:385:faad:bfb9 with SMTP id ffacd0b85a97d-388e4d6be0emr2432846f8f.8.1734524599917;
        Wed, 18 Dec 2024 04:23:19 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm18746445e9.11.2024.12.18.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:23:19 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 01/10] clk: renesas: r9a08g045: Add clock and reset support for watchdog
Date: Wed, 18 Dec 2024 14:23:08 +0200
Message-ID: <20241218122317.2365272-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17454

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 292d3079abf333540fef06c1533d7c21c6d21390 upstream.

RZ/G3S has a watchdog module accessible by the Cortex-A core. Add clock
and reset support for it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240122111115.2861835-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 2582ba95256e..c3e6da2de197 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -193,6 +193,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("ia55_pclk",		R9A08G045_IA55_PCLK, R9A08G045_CLK_P2, 0x518, 0),
 	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
 	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
+	DEF_MOD("wdt0_pclk",		R9A08G045_WDT0_PCLK, R9A08G045_CLK_P0, 0x548, 0),
+	DEF_MOD("wdt0_clk",		R9A08G045_WDT0_CLK, R9A08G045_OSCCLK, 0x548, 1),
 	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
 	DEF_MOD("sdhi0_imclk2",		R9A08G045_SDHI0_IMCLK2, CLK_SD0_DIV4, 0x554, 1),
 	DEF_MOD("sdhi0_clk_hs",		R9A08G045_SDHI0_CLK_HS, R9A08G045_CLK_SD0, 0x554, 2),
@@ -219,6 +221,7 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A08G045_GIC600_DBG_GICRESET_N, 0x814, 1),
 	DEF_RST(R9A08G045_IA55_RESETN, 0x818, 0),
+	DEF_RST(R9A08G045_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
 	DEF_RST(R9A08G045_SDHI2_IXRST, 0x854, 2),
-- 
2.43.0


