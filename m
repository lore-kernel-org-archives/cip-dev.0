Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBECFC3ABAC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:37 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.20327.1745934510822824216
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:48:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mcylb+9L;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac289147833so1080585466b.2
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934509; x=1746539309; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owwiK4bvnnQ6/m5tIW2HuqlVHb+dE6SmqwwYm68It4k=;
        b=mcylb+9L5/84djED77nc5yj4iXtymGiAe9xF7SdyWTu0dK7+4WcwsBZfWD6OLpZazS
         3Lk+FicA2/o4d8dlSVvPp0P1LKKFvQ6p02AelOkk5UAc572ATBlEGGQXA4rO6Mxtfshr
         lg7V7OWcrNQCk1sZPbmqzmPnwkgNecFo8+u/xkzpRHyO8QX2Jkst/4EYXUPtCik57Ht9
         amkgJhF66eytyVbveAk8cYi7xhtHgV0AEcO9mnk+689MlyB6NiIkaXwcFGMb63H9UCNG
         dFw4MfcBIRME3X/PszC1ZeOO+10xWfhhk63fYlteaOj3NzqZvTQxljxBsGG4i75wwfE3
         Ls6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934509; x=1746539309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owwiK4bvnnQ6/m5tIW2HuqlVHb+dE6SmqwwYm68It4k=;
        b=adB60Ue0uY1Aw6ONKVI/SUOPpTKifhW1Tk0z8S2hFMIiB4L+ohPjTztJ5KLUpDYGgR
         l1hcStu878lxyS79O5nxNDnU2PQ5LKO+2rrKmzn0M8ds1YxwtjFNohCJXS+OonAGppYG
         oU9ejl9jUzc+dsTWQ0n1RRpVmi1KN5udJIanLR4fI7D27eeWIkGJLvGbRvWlyZGFQ0iw
         Ovv49ntg/XNIygZMdRGlcOJ4MRsVd6Ro7gj99ovUj0GfehcEkaCNxzWMlWvS1EHuW5E+
         txNBsWnrzbDf5UJUg4QIcfYab7IvclAbwS5/+UY6MEcAhHxCdxAnDcRjhl24TWvp3krz
         qNPw==
X-Forwarded-Encrypted: i=1; AJvYcCXkRk32TE5a4uB9V8ciuxpJdbCP9ay2rCjo2PO6g9oCnvkg7nn9hMWgV50TUGnxfIcMgS+SWfCy@lists.cip-project.org
X-Gm-Message-State: AOJu0YyKI9jW8BL7PTDimuILPCXX729RZOFJyxxF8vm/H9e1ElYkMIJr
	iY6d90vquSl26Ldukc3UuDmloRnBWP+PYX1Wu8UI5tYHyDvfF8yGlmuTlyFOm5U=
X-Gm-Gg: ASbGncso6xw1aLzA9c6Fr+wU4lI3BEO38PWbaeY7jXzQJXVY+of9pH20SJ+Km8r02r5
	Vb19TP58im0QVPBwGB7sG9ONnOSFXfvmY/UTlou1cz6C0x5jecwWt+s3Fhvd5oNliOOIUKFYlrR
	74ismot5zZYyN+3hRwwbrx9/ml8gp3wnugQecuWYD7FmqatTfeTbtgB2qnU6PtsLxwNXoOZRUtb
	Eiq7rw/zGal1hTxL2DTxmBpKe0UNgZCAB9KNvjBk1F2+c95qhTVQLEOKgEIXk8gCRnODUVGwhLK
	UPa4fr7F6VttTk82e8Y2sKUBfuv3wkptRvAdES/DCiF+BUpiUf1FyN/Uy4aOtcEJLRJ1kHk=
X-Google-Smtp-Source: AGHT+IExB7PSlGeLnKALcvK6orcfRmPuxvRObt8xYcoSdLOqkjkWnZzJwFwybLk3DeFfk1Yb5z1laA==
X-Received: by 2002:a17:907:7241:b0:aca:c8aa:5899 with SMTP id a640c23a62f3a-ace8490299dmr1185416366b.22.1745934509210;
        Tue, 29 Apr 2025 06:48:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c898sm780033466b.7.2025.04.29.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:48:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 1/4] clk: renesas: r9a08g045: Add clock, reset and power domain support for I2C
Date: Tue, 29 Apr 2025 16:48:23 +0300
Message-ID: <20250429134826.2429916-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18736

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c7e58843d1e49a6b54d528a8ea34933cafb713f2 upstream.

Add clock, reset and power domain support for the I2C channels available
on the Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240625121358.590547-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fix conflict by dropping the power domain
 instantiations]
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


