Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764CBC04FFF
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:17:57 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.15280.1713514667101796297
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:17:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jBbOwi8W;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so5006940a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514665; x=1714119465; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1amMR8EPWpnlnfA7KuX/3/FmNZgNSEd9tib+5jAE4o=;
        b=jBbOwi8WM9JT0/GObKrmwPehsG3qDdH9QukHYaNJCHD1bs1bN4DHjDX9AZ7NNiyCDK
         X2DbbUI5RyrAc+/G9a/mWKryPuk9YuyGDbRcvzkSYVxvFj3AxdWYfvG1gaczvFOq/1+F
         itVqkUsgS/lpPt7d9XfRBVkfzIGaIUVJHrSVgMpVAGeF0+QpzHqW76oGXL2VIiy3Rdxp
         HYkaP+PNch+Q5+0pnZIf2H7YN6+TaB/yMIAix0vsVk+msJenvzJk6+np9nOz8I7Nw4qA
         jc5VEKDCEqUoIqP8VPTLP0NZnDvdlXyec8BiMzscad+gdKukC3VpO65AgFmBecw1FzYJ
         jQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514665; x=1714119465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1amMR8EPWpnlnfA7KuX/3/FmNZgNSEd9tib+5jAE4o=;
        b=hW74nxkrWFxciPg12BgDD2f0avsFLhvHkVmcT8RAFrE88fG1X7M7hYMW6CzryyQva3
         0KeXnTDs4hGtddIc7t9HL/s3w5XfVdn2YmLv5p93WkcGDtnZMaZ/bEKPT5tzHyvjgfil
         2UKAqRD67rTDraX+s75ruLEUA0gOWJ1trUamrwekVXNRgoScef9I4LYrdv4b4Lm+iU3R
         f4N2DRkpdCLeYsUJgtfOspn0XZOs+aEDBg/vx4HM0zLVM4WioMcj73UrWCo5ZFFp2JSe
         4/6TWmKjRYXiaUp6PHqbxyTk4MU2gvsWI959G8lvTq1fJZKDj7FP7muaTyJzlChKoiuq
         qqFg==
X-Gm-Message-State: AOJu0Yw+BgKxGvILDwX9Uiz//xPqrareBV2n0gphCBhyQRX4wRPxBoQn
	M7TFgFWGjnaepKLCyjMwTJd05VywN8XEQo7CK00qBbkVETjgJ3L8A6Xd8xipRSU=
X-Google-Smtp-Source: AGHT+IH+1vdx2W9NNaq/5dy+9v6otHDBNVsvmReEJIraxEZVyuhGIaDZKVeUkyhWtUC2n2dLAKHN8Q==
X-Received: by 2002:a17:906:3ad1:b0:a52:54f2:6d0 with SMTP id z17-20020a1709063ad100b00a5254f206d0mr1397391ejd.15.1713514665221;
        Fri, 19 Apr 2024 01:17:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:17:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 01/53] clk: renesas: rzg2l: Wait for status bit of SD mux before continuing
Date: Fri, 19 Apr 2024 11:16:50 +0300
Message-Id: <20240419081742.3496709-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:17:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15588

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 549f4ae2601f968e2474c6031fb4799468882f64 upstream.

The hardware user manual for RZ/G2L (r01uh0914ej0130-rzg2l-rzg2lc.pdf,
chapter 7.4.7 Procedure for Switching Clocks by the Dynamic Switching
Frequency Selectors) specifies that we need to check CPG_PL2SDHI_DSEL
for SD clock switching status.

Fixes: eaff33646f4cb ("clk: renesas: rzg2l: Add SDHI clk mux support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-3-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 77513ceaaf2d..da81059d4bd8 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -192,7 +192,8 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	u32 off = GET_REG_OFFSET(hwdata->conf);
 	u32 shift = GET_SHIFT(hwdata->conf);
 	const u32 clk_src_266 = 2;
-	u32 bitmask;
+	u32 msk, val, bitmask;
+	int ret;
 
 	/*
 	 * As per the HW manual, we should not directly switch from 533 MHz to
@@ -206,14 +207,10 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	 * the index to value mapping is done by adding 1 to the index.
 	 */
 	bitmask = (GENMASK(GET_WIDTH(hwdata->conf) - 1, 0) << shift) << 16;
+	msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
 	if (index != clk_src_266) {
-		u32 msk, val;
-		int ret;
-
 		writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
 
-		msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
-
 		ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
 					 !(val & msk), 100,
 					 CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
@@ -225,7 +222,13 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 
 	writel(bitmask | ((index + 1) << shift), priv->base + off);
 
-	return 0;
+	ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
+				 !(val & msk), 100,
+				 CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+	if (ret)
+		dev_err(priv->dev, "failed to switch clk source\n");
+
+	return ret;
 }
 
 static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
-- 
2.39.2


