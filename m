Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB7C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:17:57 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.15252.1713514670162408090
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:17:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XKc0lE7A;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4715991c32so186129666b.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514668; x=1714119468; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im9BhV8e+mg0Pd+K2yFeYFHTd+RD8vwsP2TzyvVWPV4=;
        b=XKc0lE7AW7ns3/kvbKEf9I4s+v8KLx2H3KjmhzBS1JpYE7NH4y8VKScOxDQffIvCMr
         dl0yJPghL93fZc8GD1BR8YRzzKv8ohYrnXKbVZA5n5hCJJcbtiNWcMllRBl8USA8gyRG
         wcTExlq17Ho7N1FU8LlPJ+v5dtq2wyijrL0htZgU7BY/Eg34vNN+fXJxg/xIldrpuZKY
         tbNLLmxVqKy8rERb1DxmbT/rPngbEQsL2raPg0vC99XSbTJShHC9kfI3Dc794eGsFloT
         MyPn1IBUYVaI7PE0/bkEYIggtAcrI2SqpqIF73VTydtKa411+H/y5St4n7F1zDQqtZvs
         h6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514668; x=1714119468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=im9BhV8e+mg0Pd+K2yFeYFHTd+RD8vwsP2TzyvVWPV4=;
        b=FgFA2MHOSVicYUIQI5KmJipaBnUvNqs3CNfeEaDW1Xh28RSjzMIHTl16XFJOp26hx9
         qrYGWO2MTWZO77P9DYy2S4vtfcl1AZ5fPxXUB4t4v6+1Fg1ZmssNHn+2MyHq1lmSJHd3
         jMKAxlW34hhlfdxRkIB21mM1qaddn66rIc6b2aRgKs0o0UW0z+uvGyRNzj5LSCIiYp+D
         P/eveTu/yzfecaUiOsd2fd9i4SIHYjB6A5bS+KlSe+/wAt5CsNwDDD0Bn4+/XGh8kmkI
         PED5Og+nxW7QNfVEIm85GWECM9KwtgSUyBwnmi8qGKDqHp+uFz2XbiVztXkrU+8BqijU
         1c3g==
X-Gm-Message-State: AOJu0YyTHBg1ot4JgPz53PrTZ5+/vq+m/PN55aIrKqAw/ap2w03nr8VW
	PDXnZ2pwuvuxMAimJr4gvj3shfTjDXhlDHyq3kpJGr+Sx735hMlM4XUeFZKafr0=
X-Google-Smtp-Source: AGHT+IGC0lXmdUNw3fnT95mVo1NhOY8lx9BkXrJcseuHT3HmOcJRXHW+TFSn0MnWThVMXdH4jkpFlg==
X-Received: by 2002:a17:906:4555:b0:a52:5460:a1d1 with SMTP id s21-20020a170906455500b00a525460a1d1mr1032816ejq.60.1713514668640;
        Fri, 19 Apr 2024 01:17:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:17:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 02/53] clk: renesas: rzg2l: Lock around writes to mux register
Date: Fri, 19 Apr 2024 11:16:51 +0300
Message-Id: <20240419081742.3496709-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:17:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15589

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d2692ed490e680a41401cef879adebcfafb4298f upstream.

The SD MUX output (SD0) is further divided by 4 in G2{L,UL}.  The
divided clock is SD0_DIV4. SD0_DIV4 is registered with
CLK_SET_RATE_PARENT which means a rate request for it is propagated to
the MUX and could reach rzg2l_cpg_sd_clk_mux_set_parent() concurrently
with the users of SD0.
Add proper locking to avoid concurrent accesses on SD MUX set rate
registers.

Fixes: eaff33646f4cb ("clk: renesas: rzg2l: Add SDHI clk mux support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-4-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 23 +++++++++++++----------
 drivers/clk/renesas/rzg2l-cpg.h |  2 +-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index da81059d4bd8..fcbb0e2d2123 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -193,6 +193,7 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	u32 shift = GET_SHIFT(hwdata->conf);
 	const u32 clk_src_266 = 2;
 	u32 msk, val, bitmask;
+	unsigned long flags;
 	int ret;
 
 	/*
@@ -208,23 +209,25 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	 */
 	bitmask = (GENMASK(GET_WIDTH(hwdata->conf) - 1, 0) << shift) << 16;
 	msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
+	spin_lock_irqsave(&priv->rmw_lock, flags);
 	if (index != clk_src_266) {
 		writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
 
-		ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
-					 !(val & msk), 100,
-					 CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
-		if (ret) {
-			dev_err(priv->dev, "failed to switch clk source\n");
-			return ret;
-		}
+		ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
+						!(val & msk), 10,
+						CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+		if (ret)
+			goto unlock;
 	}
 
 	writel(bitmask | ((index + 1) << shift), priv->base + off);
 
-	ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
-				 !(val & msk), 100,
-				 CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+	ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
+					!(val & msk), 10,
+					CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+unlock:
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
 	if (ret)
 		dev_err(priv->dev, "failed to switch clk source\n");
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index b33a3e79161b..aefa53a90059 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -43,7 +43,7 @@
 #define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
 #define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
 
-#define CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US	20000
+#define CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US	200
 
 /* n = 0/1/2 for PLL1/4/6 */
 #define CPG_SAMPLL_CLK1(n)	(0x04 + (16 * n))
-- 
2.39.2


