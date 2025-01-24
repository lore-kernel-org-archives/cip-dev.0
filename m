Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8040BC0218D
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:01 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.7451.1737709256218906779
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=He/ULYp8;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436341f575fso19245845e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709254; x=1738314054; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIIr0bO0+UWuUzDS7v7znuMUqL8P+aoL2of9cURa/us=;
        b=He/ULYp8cQH2oshs+JTVdRciSanLfwYfFWm2fua7RW6UGDxhJ9YDnOaRq9AXWKB+JW
         VPddvXarroYYMD4+etKN0IKNpO9FFVxCLkNUifOn+A4zoMs5M1o86lDoUaJFoam+BdeF
         FxKXunax57egQDRRKRWtIk/XL/SANrNb78+ieIqF1KaCs9p68NMAIAP9VCQjskTUgmLT
         h9zCfVyL5moJCdL4P0T2/vLeBKmEZlMT9jRHshbOJGVqjG5A72LGCwWb12lufl06OP8r
         2LGz4gC4egWtp46kXXGKGGhZT9Ynx0h+J+k3F1IA7lVSXt2t2yaQDF0aNJBDoz8I22ck
         PO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709254; x=1738314054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIIr0bO0+UWuUzDS7v7znuMUqL8P+aoL2of9cURa/us=;
        b=oTTIGLh5QwIGI7V4WWrA46K7gXwc+6vl/OpDA76Y9s/Kav36CjJF/NbbOsMBRYipO9
         cNq0ppQLvo+CIz6MIw2dY8KbAAHCYaLVCaDUtzskZ/WXbydatF374n1Q1M6jyRH92io2
         +r+Sa5affzeeESMrZHWHi892g0NfAdX9LkwmBu7xgbzwojbZe8TtkU0stXnBCwp5RgX7
         jsraatZVnleLAtii/9lRZkA3IRKsesaClI9NZaMJlrgz+Q78t43hCZ7m0ybQcvp4mGP5
         SruZlEQ0iXrgytpXJFw6th6jkjKqBGpWxm9iC38NnTtDwQYvvctNJDzXxvHQveiNlXhu
         O0+w==
X-Forwarded-Encrypted: i=1; AJvYcCUXRepU4knZG43SFTBFhUrBeNq3XD8K/M60uKkOtX/IFSvUlAhVs3FpVulSY7Noiztb6WDpl1ca@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw9EeOkztDf1TePpTp2KjoDrx7GOeMKPtZS3Mx7nsaZBIJxAc33
	3pyvF3CL9RcvbyhjXhzjaOwgkGGBE+LcpZxWOd5/tZmdlU49tRlGSWW6866xTyU=
X-Gm-Gg: ASbGncsJnwDCbB0ABIPwOTLx0cYNFtPrk4drZNmVhB9H0kn0DH/H62zoIeVwG9vn2Gm
	dKu9Ybj5mx7hHp1/KRM7VZjKoA0hSxJmOwv9Cbh8j3zBENgKJepj1JFg1fcYbZQ5JKozN9y5pIP
	EyfO1eIpd0/hQmPeXF/BhvkwCSi4cpEdRh109GMtSqpmNgSPIMNLwdg7FpmtxqBkCmAGEwGiKMq
	wfvhuxUpgyJagc7q9QYbm11+TT1qB1N3fn62oCzgXIWsXj/MHVMNzMHSZwK4fdJ8x6yC2p+ZgjQ
	T/XIJcVbwToo+CeXzl5XhXq8jQlzbdahLA==
X-Google-Smtp-Source: AGHT+IHR+2Ljn5hyBWOrNMc5adD8LyfMVc14OM7STVxHruGm7sdkNZs17ckgswqsrhYtwkr9DyRKhw==
X-Received: by 2002:a05:600c:1c1e:b0:436:6460:e67a with SMTP id 5b1f17b1804b1-43891452899mr235219945e9.25.1737709254621;
        Fri, 24 Jan 2025 01:00:54 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:53 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 08/16] clk: renesas: r9a08g045: Add clock, reset and power domain support for the VBATTB IP
Date: Fri, 24 Jan 2025 11:00:33 +0200
Message-ID: <20250124090041.1401132-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17645

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c8bd9bd6446fa034a1877b553bf118606b37c025 upstream.

The Renesas RZ/G3S SoC has an IP named Battery Backup Function (VBATTB)
that generates the RTC clock. Add clock, reset and power domain support
for it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240614071932.1014067-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Pavel Machek <pavel@denx.de>
[claudiu.beznea: dropped PM domain part as it is not ready yet]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index c3e6da2de197..55e7d42dc472 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -215,6 +215,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("eth1_refclk",		R9A08G045_ETH1_REFCLK, R9A08G045_CLK_HP, 0x57c, 9),
 	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
+	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
 static const struct rzg2l_reset r9a08g045_resets[] = {
@@ -231,6 +232,7 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
+	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
 static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
@@ -238,6 +240,7 @@ static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G045_IA55_PCLK,
 	MOD_CLK_BASE + R9A08G045_IA55_CLK,
 	MOD_CLK_BASE + R9A08G045_DMAC_ACLK,
+	MOD_CLK_BASE + R9A08G045_VBAT_BCLK,
 };
 
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
-- 
2.43.0


