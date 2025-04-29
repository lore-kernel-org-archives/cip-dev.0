Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3C0C3ABAC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:07 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.20348.1745934482185280973
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:48:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Z7h+18T4;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f728aeedacso6803594a12.2
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934480; x=1746539280; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yUISU++PVCfLRQqKtg/Zpl9a3QXfHu1NXTR4BqwKAQ=;
        b=Z7h+18T4jfpZDaja13EYbeQtshJVbkCK0mW+Qn9EBBuw7HtCjpCAP9q7cNJWP+DANz
         6gbG6iWNq9EEbc0G5tSuXqBP2bLIu6ZQMdI4OPOMjbJjW1QW4kQ8uWMWzwNETmDFQP6y
         vvxDdj3jNYDRiCBiQKR/p7OW+7e3ZmEnNie6RmBhwdehivPsuOEHghcxzILMgcO03erz
         Rqk47LUf29OZQu9ZISncpQAXTUmToS47MHg/tUEWCzghYMf3TIiJ/t6uWT5PLW5iBHv7
         IJkYDk7Hqi8E4oMTT43Te7kU35gW15+GMQoq44NfCJK8eQXN9Bmdb5JYwNuE5uxqqifG
         GfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934480; x=1746539280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yUISU++PVCfLRQqKtg/Zpl9a3QXfHu1NXTR4BqwKAQ=;
        b=Mwy+rvKkFFJjoA5l9v/x8cv0JEJI6ae7euu9B6Td/fpuwB2MQH9d3RB68y+SRxy0yb
         rP8IcoHfNUh/+dlwLlmMXfOdl3120DlMOU5rWMwqTxw85cPYpEScBVtu5n4iPoP1CieK
         YCRywn2GX1gauWThCtiiaMQxM+ick6YTaK4IzKMCzNp2Q9J8OO7zR92/e+78BtuStkd+
         uhqBkXJrwGd6MHFQXdBggHo+shDP110mFliD15IF5NdvK6CcjlVaS17RASTbKrfR3Yt/
         MnnTyvxREve5RpScWiIKZDkaSp3kvweRFBXL7k7HDeF8YcDnXXwGmafGm5aBwSxtnxUX
         CgFA==
X-Forwarded-Encrypted: i=1; AJvYcCVWw0offxXie1TWwwMYK8fbAQUMHOB6lhd8TVDTd+qyrlZyKlWFIXY0kO9bCG/bgUYMrzL0fAsv@lists.cip-project.org
X-Gm-Message-State: AOJu0YwUoDXKUOx+9yTHxa4/2ExWyRwASqhgKTRWHFi7AsvlNdj17GFU
	kOV9vpTzHVMg5c00K+Q376WtjeT6DQHq6FXIF3G/F0PRpd4KGl4/JdVyIac0/H0=
X-Gm-Gg: ASbGncuJraLRDilGaZ0OYmSPtutd91x06X2YBRym9BwhB46BGnCwgAaviC+261sMgaR
	xo/ZY77OJ9A9l4iKDbNH1ZbGHfPF2T8YQEbyteUVBlP9EaLha7odDLrwPVce63PjEAE6Tx4CXIm
	QBeWv7L6karvnbslf2qX2Ht6Jpj1tJ6etbR6JHpZv5i4eSOVs2vhqb4/6GGufwIlEHlzL7+VDuq
	6x2EIZQLfh2rzb4XjyBcYmvV2x4B5/IH3HapzR8WrhFLuC6kNvIDjuHWScRmVr9qXwrJdwKxj6m
	NB5bmD2Mr2a1ROgMbX0ucmueaZ2XYuYsaOxkSTNmYZQU1iOfznJEwVQ+wMHKtbtrYLtuRrCmAZI
	7MOSX5g==
X-Google-Smtp-Source: AGHT+IFkuJ4oE4OoBEvNlF2h9AZW+rjveTxNWtQ5KkggDsV0fSBlgWWizrokQj+zxcm+6WlYPAhrdA==
X-Received: by 2002:a17:906:6a29:b0:ac7:e6bb:a0a1 with SMTP id a640c23a62f3a-acec4eae4bfmr418210866b.38.1745934480325;
        Tue, 29 Apr 2025 06:48:00 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 18/21] clk: renesas: r9a08g045: Add clock, reset and power domain support for I2C
Date: Tue, 29 Apr 2025 16:47:24 +0300
Message-ID: <20250429134727.2429662-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18731

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c7e58843d1e49a6b54d528a8ea34933cafb713f2 upstream.

Add clock, reset and power domain support for the I2C channels available
on the Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240625121358.590547-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: drop power domain instantiation as its core code is not
 available in v5.10]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index b22bc5e972a4..c14b34bfdb05 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -214,6 +214,10 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_COUPLED("eth1_axi",		R9A08G045_ETH1_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 1),
 	DEF_COUPLED("eth1_chi",		R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1),
 	DEF_MOD("eth1_refclk",		R9A08G045_ETH1_REFCLK, R9A08G045_CLK_HP, 0x57c, 9),
+	DEF_MOD("i2c0_pclk",		R9A08G045_I2C0_PCLK, R9A08G045_CLK_P0, 0x580, 0),
+	DEF_MOD("i2c1_pclk",		R9A08G045_I2C1_PCLK, R9A08G045_CLK_P0, 0x580, 1),
+	DEF_MOD("i2c2_pclk",		R9A08G045_I2C2_PCLK, R9A08G045_CLK_P0, 0x580, 2),
+	DEF_MOD("i2c3_pclk",		R9A08G045_I2C3_PCLK, R9A08G045_CLK_P0, 0x580, 3),
 	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
@@ -231,6 +235,10 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_SDHI2_IXRST, 0x854, 2),
 	DEF_RST(R9A08G045_ETH0_RST_HW_N, 0x87c, 0),
 	DEF_RST(R9A08G045_ETH1_RST_HW_N, 0x87c, 1),
+	DEF_RST(R9A08G045_I2C0_MRST, 0x880, 0),
+	DEF_RST(R9A08G045_I2C1_MRST, 0x880, 1),
+	DEF_RST(R9A08G045_I2C2_MRST, 0x880, 2),
+	DEF_RST(R9A08G045_I2C3_MRST, 0x880, 3),
 	DEF_RST(R9A08G045_SCIF0_RST_SYSTEM_N, 0x884, 0),
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
-- 
2.43.0


