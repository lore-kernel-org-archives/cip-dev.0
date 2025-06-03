Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E076C61CE5
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:47 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.6977.1748942385112645703
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZhPuGAV8;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d51dso9250881a12.2
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942383; x=1749547183; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae5vt5GN06EU1NkfFFuyCos0NK7itnNXnj5i5OfwWrY=;
        b=ZhPuGAV8JhktB5Uc6G/tE/5J/22qRiihLtsYvKU5W03DzhvEZXZmuKaEFfkM7QLeEg
         2noI3HUfwx0WJQaWXTI2HuuV/Nue6cHRtYdrXza0dXGHVzoxLaiDpHhMoUl0Z29bY77q
         zHw8tx7XzBR7XkuOth6ErDqYu5E1+fHU2N4JV2i1Sri2lWRRUahS0iwgd1g3+b557ibw
         tG0JgXgz1FpMLXEDwZ067PHYv+eGvI8+QxwvRFSxhCRg3M9H5dTsUeXua+CAdVJ3Mtcm
         v9l5lcBxg09LFQ01V9bSKKjha2O8QZCqkqiAAVoorzFgSpco9dvPrFrLzBllQgedUuou
         aWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942383; x=1749547183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae5vt5GN06EU1NkfFFuyCos0NK7itnNXnj5i5OfwWrY=;
        b=M5wd1imhKVnJPBwDRsjg4YYb1GelyL8T9w6vlhNgp5ESrxDk4v8WJWRmOSkj09o1Js
         SlbK6PG4ky85UtuB2SpE3iQmdWthR0jUkPmG5EDI24CH0C9xgtF8RaYPJlHqzbhws0mv
         14xWgZUC7IAnPiGnCkWH7Yxm3Y0hEeIaRek/kF3kpbWeKzuTN5Wsjqh+BGWcYVOozGfA
         TpOzy4/6LXk2nwaD5RLLpCtMLEGmDhyZHnQse15f0ucFpzBEHcSOpzIn+2pThRYrfdLm
         nV7wcxswUnk3dGxFS0SHxj93EtIeeEBxdxogAxNDQDXKqX9mYl2rdTysOLuJVl3cH2KA
         6+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCX+g72+WlChBf6oTUpbTwocGUDWIVXO5jgUmR0eFcxfTH3V/QuHv64MQYMeGNBqWC1o1lHoHwYT@lists.cip-project.org
X-Gm-Message-State: AOJu0YyzZ06HVfh9y4ddqoYuMJ9pQ4gX0uPuQnjnP7jiZKqhEImU0BMk
	pA/6R9gNAJvMfAexLJseFCdaQF/BReyUyqYNOkJLctelMFUuR20YxohT8TjwgJAtMGg=
X-Gm-Gg: ASbGnctKfB9K2FhFNWJCq++UGkl5Xk2/G60g9uaX6IjPNkmKDX9/4jU3s2OywaUejy0
	07RgHrMMJhosY6enY3mAIWNgu4IflSrpQVjCbq7ePKYiMKNBEf/pJEDiLvyE0OhO9YCLqQC48qg
	znFd9RWLi4rcjuhKbG/WU6NGA31cd/P9p+ewUtbUDmYQHj1JJXbqJO5ZiOaUkL4wAROniF44wIt
	12sU6Rff9LHv0CInWz4q3X0KKfBi85WcTvqp2LXGYQSnJQw2p3QTtNpuZrmK+w69Tc3y2G5Ht4u
	NOvmFL1IhzMqil2G4xy6DuY3NfJhV8zL+SD+wnGSNgcxEXUrPnYrsKJBXsZJSqQ1Uhr1ThMH+MD
	/iCNEIzFfo3ptbVES
X-Google-Smtp-Source: AGHT+IGspzwCdRzfrgEnR5cOTlPpAs0TCRv5vhgXeZ7mtqdjy8FcclWUy2n/fQaboV2aVW8WAR9MTQ==
X-Received: by 2002:a05:6402:2346:b0:602:4405:777b with SMTP id 4fb4d7f45d1cf-6056ed04375mr14563186a12.24.1748942383523;
        Tue, 03 Jun 2025 02:19:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5c5casm7301944a12.25.2025.06.03.02.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 1/8] clk: renesas: r9a08g045: Add clock, reset and power domain for the remaining SCIFs
Date: Tue,  3 Jun 2025 12:19:33 +0300
Message-ID: <20250603091940.3917581-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18975

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


