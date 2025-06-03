Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359A9C61DB2
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:17 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.6966.1748942347744869767
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=S6YQs0RC;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-602e203db66so9300041a12.1
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942346; x=1749547146; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae5vt5GN06EU1NkfFFuyCos0NK7itnNXnj5i5OfwWrY=;
        b=S6YQs0RC70GWOxLWo/2AZELwxCOqpzYYgtkPfPYLYqD57S68TqXgXFUJgSjy8yL2Ac
         eDeSoDQxHmTHf1R4CMv95CHnvV3BVXzg9X1i4LtChK2cAeCtP8PouOIoVGj9lLl3b8Om
         SkL0aLRU7E8yboq90NcjzGlnPHicnz3zykDuTmRZk1GkPPSxuJLqadmzpUVs9t5y90ty
         UabpHVtuwVkXECn+yPblXSlJMV7/0ATXtbWxy/qOHmMLHnBFH1e2NKVZllTlYZZkkwfh
         YeOiJZjYe/OzLN+RihPNP7vyHwZNiynmoHr/0GHDOzOeR95PxoyBav/+e33oY5LgCQyu
         yQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942346; x=1749547146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae5vt5GN06EU1NkfFFuyCos0NK7itnNXnj5i5OfwWrY=;
        b=SlvpRj9nIGaHVpAYuIMBsWBm6c4eg0NDu8UluttBv8RZxSb9n8zpcrIsxmYXIHCTKQ
         Owe2I8fm9ltlGuoJUlTBRcdGu/NehrXl9SSOjmlARCMKf4B1LhB4R0a8AKwIwN/FbIir
         svwdryemJcTwqyHI0U+sjbVZUK9vct2X/xXYc00gYMQ2dWUkz2H8/SX2A7ps83N48aIs
         Uc6YzUEBQ0JmB0LEKtbm/67a1D1M/XavCBABpjbOR16y6G9KcbYQLBR3C3OvcT9Aru6Z
         xpsR4sGjADNi2Jf4uUiMCmhG3rFjpjduHqmWVEJZD+ZDG/d8VkXLdjWDnfgntSBTGT83
         ICGg==
X-Forwarded-Encrypted: i=1; AJvYcCW8M+rYjOzFgQZQfvdA0iz/V0agOKHLZ0Fj8QvKFV4zUO0sQ51FRhsbbI05YF2ofBQ/q39htXFW@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx+dVef96/UYjbr0/UuCK8fWZGaA3MNI3i5r23yzmraXGYHGp/j
	kCMZXVrMujLM5o8UGMQZQi/Z7izb+iPe0gog5WBAhLRztsP+kLy9kUABdq5/RF7Z07U=
X-Gm-Gg: ASbGnctYAhBie3tlIx8W+jScGV2OtotyWuk4J7poTDyt//sr0DJ8ec5fxxp5HN1Ycrr
	zsEB5/t8CAmA1jFFcx9DoHgR/tQ2WHvP1GsbhnSGF6gB4Uh5/xb2grvRG3YzdE62GX2Fdav6RGP
	mWmwtZbffERmNcitrrm0ENjqE1Qo9v4eUYyRA9eLg9Ks63nYLw/nr/6X5/bMmDfBPTiNIfjZ6b+
	G5bqcC+u94Wt0nsWS5DGMrfrhT2mzRwKYTqxf/6S1hKkwsyV/5HO4RXQJEufKo+BPfqtokpwBl+
	IwOB/R+uUpN6LVhhcw3bGrwPdFtZz/z+ypMJOFsFQqxQKVE+3lWoq0qHNQRJU8NKi0gS1DxkV65
	mVjZGeOlLiuuHPZDiJFdDqTfBHIw=
X-Google-Smtp-Source: AGHT+IGdLQv1VF4lNrppIiv+4qbmQ1LpWXyxq7QFPidL+XVJB1w+H/r0/cIOvE7HF7vMRmMcMFeuaQ==
X-Received: by 2002:a17:907:728e:b0:ad8:a512:a9fc with SMTP id a640c23a62f3a-adb49548765mr1151210666b.42.1748942346058;
        Tue, 03 Jun 2025 02:19:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fecd2sm918093866b.36.2025.06.03.02.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 1/8] clk: renesas: r9a08g045: Add clock, reset and power domain for the remaining SCIFs
Date: Tue,  3 Jun 2025 12:18:56 +0300
Message-ID: <20250603091903.3917202-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18966

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b73435047ef74c82d6e82c333810eba0038f9cf7 upstream.

The Renesas RZ/G3S SoC has 6 SCIF interfaces.  SCIF0 is used as debug
console and is already enabled.  Add clock, reset and power domain
support for the remaining ones.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241115134401.3893008-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: drop the power domain description array as the core code
 is not available in v6.1]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index d01a784cbb10..7f96b615f087 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -227,6 +227,11 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("i2c2_pclk",		R9A08G045_I2C2_PCLK, R9A08G045_CLK_P0, 0x580, 2),
 	DEF_MOD("i2c3_pclk",		R9A08G045_I2C3_PCLK, R9A08G045_CLK_P0, 0x580, 3),
 	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
+	DEF_MOD("scif1_clk_pck",	R9A08G045_SCIF1_CLK_PCK, R9A08G045_CLK_P0, 0x584, 1),
+	DEF_MOD("scif2_clk_pck",	R9A08G045_SCIF2_CLK_PCK, R9A08G045_CLK_P0, 0x584, 2),
+	DEF_MOD("scif3_clk_pck",	R9A08G045_SCIF3_CLK_PCK, R9A08G045_CLK_P0, 0x584, 3),
+	DEF_MOD("scif4_clk_pck",	R9A08G045_SCIF4_CLK_PCK, R9A08G045_CLK_P0, 0x584, 4),
+	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
@@ -252,6 +257,11 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_I2C2_MRST, 0x880, 2),
 	DEF_RST(R9A08G045_I2C3_MRST, 0x880, 3),
 	DEF_RST(R9A08G045_SCIF0_RST_SYSTEM_N, 0x884, 0),
+	DEF_RST(R9A08G045_SCIF1_RST_SYSTEM_N, 0x884, 1),
+	DEF_RST(R9A08G045_SCIF2_RST_SYSTEM_N, 0x884, 2),
+	DEF_RST(R9A08G045_SCIF3_RST_SYSTEM_N, 0x884, 3),
+	DEF_RST(R9A08G045_SCIF4_RST_SYSTEM_N, 0x884, 4),
+	DEF_RST(R9A08G045_SCIF5_RST_SYSTEM_N, 0x884, 5),
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
-- 
2.43.0


