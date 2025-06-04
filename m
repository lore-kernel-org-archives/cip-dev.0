Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504BCC61CE8
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 10:23:51 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.13337.1749032626869462314
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 03:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rHXcs0Bu;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so13167375a12.2
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749032625; x=1749637425; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9/LviI77w1ZPRUZqFe5n0j3BAO0/pNusy0uMpaOam0=;
        b=rHXcs0Bu1Wu1oEnFkkKx23j9iw17REcj8rZgSIsSOtJHOBPm8y2NOCiMbGacsPM4p4
         IAtJzuhsoYJCA2w4/j5Jws65XgxoAT0H69PjUiUfciUp/O+xrdl3wreCvv+88Jcvzc+L
         gTh8wPHQlt0osuN3rKLl7e7raMGHUaGVwYfPh+0AU+XqhY9O3lEHweNVJPlMGE5qVpaV
         PHDfcWxhD8aAByc6A6Iz8pVoZacTkOUBCFdBKXcHjYyc8c+Y2n6BZnV+ldIagqEeyNHH
         F2/V0/eKF3Z5lJm+r+F4M1gg1whq8v8EPGqBquOOJDN8HTKPIAfJG21oxFvvttGPeL8u
         7H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032625; x=1749637425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9/LviI77w1ZPRUZqFe5n0j3BAO0/pNusy0uMpaOam0=;
        b=KHulqpv3z3vZ+7+TSBK1jLb0B/53NqMxUIczCBz+g8VReM0goDAVZ3E/wl7uorKrrK
         /tl1eTbKtP2ElKwLGtqvavptJ7gF0DhcXrAwlRELTYXp1Oy5PgzSPTeP8IQPeDhBAKIE
         VMLf9RIvydVtILrKvF/Ajsnph6F5oB+oNgWxgP5lWDnnMYD8qEQg/0HA5j9MazDhYXJ0
         tUYo33q5DcfahqT70DmM96usDTAJA0/aK8Arx8Cg1Du/2ZQ750HxWErRyBog94fRxirj
         Zg6ALGWy8OmT4QlznQuyc3VoruaBTgiuQqz9+S9mgIHlL2jC/xR43PRqFiH2bJ4d3IAT
         /hgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcxST8n+zij/jTyUbFToBI0V4cvJlCygX0NKfM6tWktpAxTDgDKl6fYEdZzRNikTX3NGmwZh7Y@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw5h/4bMnOS3jwMpWpkpFltIzWSuHwdz/3vX2EO28aD+ImgXUOt
	kTzg0sX74v56yWaqVPyw2VjotLaq6qW7Ue2RAc89/zjJl3xVOMAdxWHCW4UC/pymthU=
X-Gm-Gg: ASbGnctSofxeZtvGL5XXctrnc2eJqT6SzfgwZPJM1jcNopzAqM8cOFEiUBAo9FekYig
	f+SRoDxbyaR74pu+pbrknVv7cOcPLzjgrJEq5GjPdSfUH6O/zaFYC2kRP6QPkMnlbHUD1JYn2b8
	Y+2Olw5kBGPKEba+73Q54OnXPdS9MzShzdeJKvf5+l2vjYzzzHyihgXFhKHtHtDfMlT7CXByZ+t
	MJxzkr2GW1phIyXY2bzyr6UCGM1PE9JOmKidpSNuSK4+pbaAtykVxrsJh8jltZ4+lY+/XTmSI3v
	9DnG/olop/cdmfposoe058sH0upL7i1ruNU50rTsixCem9YAVv1n1XDwsgbar12VPhOxRK4Sqim
	c+kvnjg==
X-Google-Smtp-Source: AGHT+IEWVf4ti+gsBEpw/rsdxQBz4Z0YSGgRb8JFejjLqpkAFFHvSKaRnnhGxWGJ8Pf93lJFuGw8Lg==
X-Received: by 2002:a17:907:94d0:b0:ad9:f54f:70a2 with SMTP id a640c23a62f3a-addf8d5c680mr162995366b.22.1749032624956;
        Wed, 04 Jun 2025 03:23:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e760sm1087375166b.52.2025.06.04.03.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:23:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 1/8] clk: renesas: r9a08g045: Add clock, reset and power domain for the remaining SCIFs
Date: Wed,  4 Jun 2025 13:23:34 +0300
Message-ID: <20250604102341.2524186-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 10:23:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19002

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

Changes in v2:
- none

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


