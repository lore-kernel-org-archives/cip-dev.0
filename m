Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E7FC071FD
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:28 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.15309.1713514705131899848
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jB+deYXL;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a554afec54eso183791966b.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514703; x=1714119503; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RO13dUQU1gpnfJyiYiBJrQnsg7d9bSzTslGZ6IYpPU=;
        b=jB+deYXLgkYYDja4YHMdUr1e4ik3tkVbhWyG/GFi0FqyCVd2jbr2W206Hck9oP0KmH
         NoJmMr6rYMn84Cj3JaVbCf2gvGyA8wcSuimjKqjAGgIr6WJYSndrKsYdjRSomZmw0G0v
         b5sdyy96SXLA9pgd6W6+gNCILTTxne+wZPNngRTIe1qahSxYZ7EvQPBFNJSmGO7Y1VOr
         7C8CNqaXRRXQxrajgxQGLyYs2ZEQ8TDDCmU6HVV4EmaK6jbuEvSUH8pyKAvodpXegTGS
         +Dkee7h12WjsRQme7XexDdiu810GowZxVyikkvhGmyGb/MGYs/RFuGA1J0AZB5N2Bjx5
         dcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514703; x=1714119503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RO13dUQU1gpnfJyiYiBJrQnsg7d9bSzTslGZ6IYpPU=;
        b=ioAJf9UycErL/Wysq98NZ39u0pNLgpDQoY1Qi3S16tm4lWysi6Die7HYu4gq1lBijH
         3kq5p8YmDJG3jgROZRfuYIE5xEbrpuUnVp5pm9/7um728J6wzKEUW7ivxsVwxqAnYZSo
         a1fgYPF5Yj1BuSqoPZH6OvToKWcldH1yGUvIFQn1CK3jDL+X2luKwf7nGm15SpjdS/Ej
         czPFcMs0DJGZ85iqqpL2RBsjhc4cyTwTG9oGLARzUoGGoOakczjnVHBSAQCIxJqsmuDN
         7eusnHfCB5YGasxr/qfJrw8cLnCSATD3tiBr/uOClWFpDHXpSry0+F5whh1WgtOIVNb9
         cCGw==
X-Gm-Message-State: AOJu0YxvB9GS/Bq0lamS3opsUPsnE9rhh51HogLLqPfToxUKk9CJPB4+
	fBFNu7NWed4ygH79v18uDYcKASf6f6N1HSQDSJvDMy1Chf3SLtjlA9N6AtJoZGc=
X-Google-Smtp-Source: AGHT+IFgQ3ugu/acZnN5RAhG8K39vkDiuE6kYue8h+DcWDx541aVFCQYps+kWcHnZvYO1zh9IQB1pA==
X-Received: by 2002:a17:907:3eaa:b0:a52:eac5:4911 with SMTP id hs42-20020a1709073eaa00b00a52eac54911mr1262731ejc.17.1713514703581;
        Fri, 19 Apr 2024 01:18:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 26/53] clk: renesas: r9a07g04[34]: Use SEL_SDHI1_STS status configuration for SD1 mux
Date: Fri, 19 Apr 2024 11:17:15 +0300
Message-Id: <20240419081742.3496709-27-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15613

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


