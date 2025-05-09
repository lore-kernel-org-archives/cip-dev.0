Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36680C3ABCF
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:05 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web11.10348.1746783301979142737
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=f9WxCKea;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fbc736f0c7so2857810a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783300; x=1747388100; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQEhJwmeax+qSYfxRMDTDFuvrasEoxff+z5M+j2q5AA=;
        b=f9WxCKeaBAi8U/iCmpiwEykh7Cm2M2wTbQjwU01ATbtFPWKmfSf53cf6wwQJKFqfuQ
         O7oeqQzooXLKs5RBBN3KuToCJwxselhVnEFkFXyE6Ulj9rTn4nfEXwoYnQO1cwa3BIDw
         T4BeyeU6LVWiyBG5OAdL0Vx5TO23nIiwBHiJjNWOGc83xqZcjxpaTVos6uknb3L9wqv9
         R+KQESpmiKjjnngkNCq6iD4apUkK9PAZs8RMYZPrM6eZBFvnBuxYQ8lAyoew2jn94bRN
         Ygpvvc3n20JqjdQLfHhooBLhfrTWe3+M2Mi+kDnVcUCfeoPHimTN5mmI50G8wlgNzd12
         Tg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783300; x=1747388100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQEhJwmeax+qSYfxRMDTDFuvrasEoxff+z5M+j2q5AA=;
        b=RZpKT7SyCz7qCv+IsuUGkvV/twmFcGf04Q1Qr/yPhf1pFCW7kyaYyZbEtYSg3ry0fw
         5o4fVTwSr+dTZGqJ795EWMLjx7QUakStq7hBA1zrym6VW2RZisJNMny05bIZYG6f3k89
         g+IQVoFK/POpdGdQbOE8niZkS3QdHoIVvPRxDraswq5lPZ5FNqO9ewZqn8vUYRTQEF9d
         JG3AcW0XoNoz9tOa1rJHVh4RSQqs8Q2mt3V5UHU+/n9Axu0OSQeMWd3faP/2kKp+qvf+
         +Jfg/+sv8ZQDdCxbcsxtxg/AYO9X/pJv+0Fkus8Eahd3uGTUdSRU/B5DvFCxdHPiMkzC
         G10A==
X-Forwarded-Encrypted: i=1; AJvYcCWh1jL91UX1mjzw/kaWnr0cr/s86oySozymGm6ozPpjxf0rMV1Qg/Y0TPMH3juD0laZYWbp2zZB@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw3wqXAGzmVLpSRw6ebX3+f0Z4PtyNEv09uQbaO0WbELm42AKsB
	0ew5rtYV1rBabXDFWxhoXuxRLQ1MiNOy5skTLK2FdWTP3i3S2/sUwdBeEbRG+0M=
X-Gm-Gg: ASbGncsxsuJu5gkpg8t9b35ZSW5dG0RLsb55Mr4CVwVRmEUfJG7jl4RbBe7AzeWwZRg
	JugGKLhrbgTNZspFtJ3kgw8DuFeDBzNDPnj18ae2fo8ERifi+AKL/HGB/OwlX4M29DjFqn3gWX5
	UplW4I0X6q06jmYzuJRmpaeowRsiON3TJJC3T9HraEJz3MjW5vdbW220iv8lvE42nPf/rFF8o4f
	7Vw8LyaU7XZukFk30guixh7H97/fnugFV039Ewl1I/2KEwoHlAyYaMRSOolJAmM5eG77xq+vTlx
	pD5vVurN4yQNyN+7OtZBx/akTEkTEN6lYEA2yzXfD4FglYTrrAQC0Azk77fnFgP0H8ZUoA==
X-Google-Smtp-Source: AGHT+IFKewGblDD4RkyV05u1z5F+2mhNzwmS0Ldj5YGrih3Trxx4wcBpkxsARyW+NhHUMvb330/qTw==
X-Received: by 2002:a17:907:d30a:b0:ac7:3817:d8da with SMTP id a640c23a62f3a-ad2192b5b2dmr326148566b.52.1746783300388;
        Fri, 09 May 2025 02:35:00 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 12/37] clk: renesas: r9a08g045: Add clocks, resets and power domains support for SSI
Date: Fri,  9 May 2025 12:34:17 +0300
Message-ID: <20250509093442.4015145-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18864

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 97088b3a8e71ed87fbb25a34b222d869033d73df upstream.

Add SSI clocks, resets and power domains support for the SSI blocks
available on the Renesas RZ/G3S SoC.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241113133540.2005850-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: dropped USB clocks and resets, dropped the power domain
 instantiation as the core code is not available yet]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index c14b34bfdb05..d01a784cbb10 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -208,6 +208,14 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("sdhi2_imclk2",		R9A08G045_SDHI2_IMCLK2, CLK_SD2_DIV4, 0x554, 9),
 	DEF_MOD("sdhi2_clk_hs",		R9A08G045_SDHI2_CLK_HS, R9A08G045_CLK_SD2, 0x554, 10),
 	DEF_MOD("sdhi2_aclk",		R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11),
+	DEF_MOD("ssi0_pclk2",		R9A08G045_SSI0_PCLK2, R9A08G045_CLK_P0, 0x570, 0),
+	DEF_MOD("ssi0_sfr",		R9A08G045_SSI0_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 1),
+	DEF_MOD("ssi1_pclk2",		R9A08G045_SSI1_PCLK2, R9A08G045_CLK_P0, 0x570, 2),
+	DEF_MOD("ssi1_sfr",		R9A08G045_SSI1_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 3),
+	DEF_MOD("ssi2_pclk2",		R9A08G045_SSI2_PCLK2, R9A08G045_CLK_P0, 0x570, 4),
+	DEF_MOD("ssi2_sfr",		R9A08G045_SSI2_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 5),
+	DEF_MOD("ssi3_pclk2",		R9A08G045_SSI3_PCLK2, R9A08G045_CLK_P0, 0x570, 6),
+	DEF_MOD("ssi3_sfr",		R9A08G045_SSI3_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 7),
 	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0),
 	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0),
 	DEF_MOD("eth0_refclk",		R9A08G045_ETH0_REFCLK, R9A08G045_CLK_HP, 0x57c, 8),
@@ -233,6 +241,10 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
 	DEF_RST(R9A08G045_SDHI2_IXRST, 0x854, 2),
+	DEF_RST(R9A08G045_SSI0_RST_M2_REG, 0x870, 0),
+	DEF_RST(R9A08G045_SSI1_RST_M2_REG, 0x870, 1),
+	DEF_RST(R9A08G045_SSI2_RST_M2_REG, 0x870, 2),
+	DEF_RST(R9A08G045_SSI3_RST_M2_REG, 0x870, 3),
 	DEF_RST(R9A08G045_ETH0_RST_HW_N, 0x87c, 0),
 	DEF_RST(R9A08G045_ETH1_RST_HW_N, 0x87c, 1),
 	DEF_RST(R9A08G045_I2C0_MRST, 0x880, 0),
-- 
2.43.0


