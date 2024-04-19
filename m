Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80CBC07C79
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:20 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.18428.1713526752282522572
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=keMNk5+f;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56fffd131a8so1028191a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526750; x=1714131550; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RO13dUQU1gpnfJyiYiBJrQnsg7d9bSzTslGZ6IYpPU=;
        b=keMNk5+f0KT42eOQDQ85HH/yp2v70zqA/J64Z/9UpO/I6JUIxmKifKnKc/pquSq6nn
         plSdODX9qygKPLxRPRe6heHcMrvGWUFzIVdTc7ZlHd08+NYf/RoI7BRvdhRMcRCFZhm1
         fOTpd5JynbI0a6WdasrjPamVrWVw8UWJungXbzOMRI2MG/wUNXyMqR3SGe4623tXvtHo
         sbEX+VF4f7cRcksl6LkCM7QEKicchpdHy4TDn2m+XanMjDHa/0f1fIGsB//XakXXTE0l
         Mtbk4kX4zbYuN/5rcXzaoRk5Lm4cnN4bYj3WmvAlDG9uyZQRczUXzMcrP/N2HvvQx/mn
         KH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526750; x=1714131550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RO13dUQU1gpnfJyiYiBJrQnsg7d9bSzTslGZ6IYpPU=;
        b=w9sE4+SKpSsS9jvbU1XGjldrdGYYDp1auLTIpT0yvpSNGgGh4+HxGgEL4o+Xj5dMdi
         F6ttfuiMw69p87gZS9/MutjebtVN9wSO8u1kXEBPlaAR/tDaKCTh+VJypkHvz47MrEpx
         aVWb7NKM4g2FlB+VnTceURZLVYG2HmYuUOuQrMO4IzzNy2lF47zSz8znf61efUkZSTk7
         TML7Pv5IaoHBuHChrSHOdZlLDYskpVDh67l6fGS7NpCIqlQ9ynVDj9aDazmyPPpnDogm
         b65sTkwD66PzWZcSl09dvsp5tI1TgcqDlLXfJF81lUIs5om/6s7z95ORphkykHtHhmsK
         R4SA==
X-Gm-Message-State: AOJu0YyjWJqII74PDfDQTuKEtSM1LgRc87/fUC1M8j+I/+k/3lgGmnd4
	2YSRpZ0Pjr+SCR2dUfKJNqO5a5DwuV/k45/nqFGWgvgG1Bb6GS1ykcKDv/xMfEbc03Fsg1Hl9cA
	Z
X-Google-Smtp-Source: AGHT+IGT5lEJefuccqABz7ECmWsGIuDV2EJy3P1g8jwXtCK0XA2r7H1968B3t9AEH4rxEo3QQLG92g==
X-Received: by 2002:a50:8ac6:0:b0:56e:c5a:c7a9 with SMTP id k6-20020a508ac6000000b0056e0c5ac7a9mr1570481edk.41.1713526750668;
        Fri, 19 Apr 2024 04:39:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 18/44] clk: renesas: r9a07g04[34]: Use SEL_SDHI1_STS status configuration for SD1 mux
Date: Fri, 19 Apr 2024 14:38:16 +0300
Message-Id: <20240419113842.3675543-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15669

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 9b2a11c83859c06233049b134bd8ee974b284559 upstream.

The status configuration for SD1 mux clock is SEL_SDHI1_STS. Fix it.

Fixes: 16b86e5c03c5 ("clk: renesas: rzg2l: Refactor SD mux driver")
Reported-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240131102930.1841901-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 2 +-
 drivers/clk/renesas/r9a07g044-cpg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index b70bb378ab46..075ade0925d4 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -138,7 +138,7 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED("SPI1", R9A07G043_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
 	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0, SEL_SDHI0_STS, sel_shdi,
 		   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
-	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1, SEL_SDHI0_STS, sel_shdi,
+	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1, SEL_SDHI1_STS, sel_shdi,
 		   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
 	DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G043_CLK_SD0, 1, 4),
 	DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G043_CLK_SD1, 1, 4),
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 7b18b9be76c7..22c03c8d4636 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -178,7 +178,7 @@ static const struct {
 		DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
 		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0, SEL_SDHI0_STS, sel_shdi,
 			   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
-		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, SEL_SDHI0_STS, sel_shdi,
+		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, SEL_SDHI1_STS, sel_shdi,
 			   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
 		DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
 		DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
-- 
2.39.2


