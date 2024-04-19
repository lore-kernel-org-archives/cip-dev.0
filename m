Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E060C05052
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:17:57 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.15253.1713514673721295800
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:17:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Lh2V234Z;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5269c3f9c7so192612966b.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514672; x=1714119472; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsdCjrlZL0HXe4FRq418Kin+ww19GRS1XMhADQ8Q0x0=;
        b=Lh2V234ZrGx1Meid46ALyB1ji+YGHSihgA0dhbUEjKUhnQMygwStyRAfqL7YyQVy19
         lIelbRINY1EblSW0M+pwV1wIlLv48+bmDZSEH9CinvVPgqeKnN6QWMQExRRTtB+nFbp9
         g+5YqL837pQTBN7wOYLFZAKYYbZVlUHdROZaQO3rgQSn4q6Z2XcD+9CufFKIdNXz2YzA
         tPgdrpCKgqcTT7IErwHTfIxm7PVa01cAqAQGE5fjRabNsjrwc1taVCAlzCNI80SL/vXw
         PPduvT1r2c9Ku3PGRlk3M3rku/G6Am675GMqGyUHAu6qM74gPdvV1CywAbVRcSjY8zkm
         hOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514672; x=1714119472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsdCjrlZL0HXe4FRq418Kin+ww19GRS1XMhADQ8Q0x0=;
        b=n2KajmuSv7zfy76Q7gH5s6DN80A6T38FddFVbGD6zpkLFh502Oy/icveegMfbAJ44r
         +KYuG1u5xzhtcxXGLnnIkJuBFi1HsN3WSpnSuLmoP7vqZXZS7ZlH6QXmetySd6mZU2V4
         IseSOqo983SlfD+cuTFZqk/pkjbkUgbgwCU/C8yIEeUvPVLWPm6s7bXJndq+GaRrGL0V
         r2ctDOVzTxaXfBRTB7OTwVExhbDLQeDlvv2romIS4jwX9wH//VhqPPPegVdRNZA5dEcy
         r5mbGWJLJnnmJQegKXdX+Ney3C7nT9STA69dXtdozEbG/pyxW3urbNmvYkipaXIHME+q
         bgnw==
X-Gm-Message-State: AOJu0YxliqERh6kCiRtdAC5HrBLldHskoVRTYAQcYd803NlzfqhbsY2f
	ibCKc6aoBlFKOi0P0rCZA/KgWAyg9CYui+9QuG6Xllvy/zynQ3W+zFgdXm29QHU=
X-Google-Smtp-Source: AGHT+IFW53gBPwrxIMSCT5Epo/S0oypiwc/Hds1p9JkykHNDWZjswZPmdLTxDfz9QX67OOp6bCxduw==
X-Received: by 2002:a17:907:7215:b0:a55:8609:1c34 with SMTP id dr21-20020a170907721500b00a5586091c34mr938182ejc.28.1713514672196;
        Fri, 19 Apr 2024 01:17:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:17:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 05/53] clk: renesas: rzg2l: Fix computation formula
Date: Fri, 19 Apr 2024 11:16:54 +0300
Message-Id: <20240419081742.3496709-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:17:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15592

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a2b23159499efd36b2d63b3c4534075d12ddc97a upstream.

According to the hardware manual for RZ/G2L
(r01uh0914ej0130-rzg2l-rzg2lc.pdf), the computation formula for PLL rate
is as follows:

    Fout = ((m + k/65536) * Fin) / (p * 2^s)

and k has values in the range [-32768, 32767].  Dividing k by 65536 with
integer arithmetic gives zero all the time, causing slight differences
b/w what has been set vs. what is displayed.  Thus, get rid of this and
decompose the formula before dividing k by 65536.

Fixes: ef3c613ccd68a ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-6-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3035b1535344..2260741433b2 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -43,7 +43,7 @@
 #define GET_SHIFT(val)		((val >> 12) & 0xff)
 #define GET_WIDTH(val)		((val >> 8) & 0xf)
 
-#define KDIV(val)		FIELD_GET(GENMASK(31, 16), val)
+#define KDIV(val)		((s16)FIELD_GET(GENMASK(31, 16), val))
 #define MDIV(val)		FIELD_GET(GENMASK(15, 6), val)
 #define PDIV(val)		FIELD_GET(GENMASK(5, 0), val)
 #define SDIV(val)		FIELD_GET(GENMASK(2, 0), val)
@@ -699,18 +699,18 @@ static unsigned long rzg2l_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 	struct pll_clk *pll_clk = to_pll(hw);
 	struct rzg2l_cpg_priv *priv = pll_clk->priv;
 	unsigned int val1, val2;
-	unsigned int mult = 1;
-	unsigned int div = 1;
+	u64 rate;
 
 	if (pll_clk->type != CLK_TYPE_SAM_PLL)
 		return parent_rate;
 
 	val1 = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
 	val2 = readl(priv->base + GET_REG_SAMPLL_CLK2(pll_clk->conf));
-	mult = MDIV(val1) + KDIV(val1) / 65536;
-	div = PDIV(val1) << SDIV(val2);
 
-	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, div);
+	rate = mul_u64_u32_shr(parent_rate, (MDIV(val1) << 16) + KDIV(val1),
+			       16 + SDIV(val2));
+
+	return DIV_ROUND_CLOSEST_ULL(rate, PDIV(val1));
 }
 
 static const struct clk_ops rzg2l_cpg_pll_ops = {
-- 
2.39.2


