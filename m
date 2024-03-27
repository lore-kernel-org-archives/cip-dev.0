Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8243CD1290
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.32662.1711528512819974271
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Gs5C5MJk;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-341cf28e013so1894749f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528511; x=1712133311; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeWqBAajzbxuchwGy9Aip/n4kqo7n9uevcsbMtMHMQ4=;
        b=Gs5C5MJkpzfun19sep51QzBwTQ754Vi2TVMm2HPwiaeBWT59JXlCKnnsZ7gxc6h1s2
         VizfKxk+68lwLf0QTjk+fluV8ofnLb99v37LAr9h9zISnU/s95inHBdSqYX26GuakbxR
         a1VBrQXTlzvDKhTsrQmsN69awtUPdVtSjUyRHUjVR277PqgCqzw5QjVSe1npVig812re
         59q8pTcvzS1pQ4fO9mogCE3I5/PRkdHZ9JXXUJDOcqkliefFwt8P1Z3X7sikZ9q2BEND
         bDaqVZrNXif7dCLkaUM4vsZ0YvFOf3BKf2KAdNPtv2wJUP8/SSoVpllQbV22BgUPrqQI
         u3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528511; x=1712133311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeWqBAajzbxuchwGy9Aip/n4kqo7n9uevcsbMtMHMQ4=;
        b=g/BnkGZFhj/AopJP07guVERM/TuBjz5neQyYFdJYBK0be4tCCXDWJY6p/GTv3FeM8T
         DfhUyPXXuGfhnYlU+WKlWHUeroM77s36dAkX8kjGkARRTCXUwu3/AouEpqsM++tbEQKY
         M7Fkx4j4XLXDzA6eUZ3Q13oGWBFBp4I06SOpOAy4pxNBg8vpzFdf3iuR8daVR7EmMgoS
         Cidw3rjJkf+YgcMRWRMYyzYF73jFwjfUNeU9xciIKgjqAF+DOq/jYDdc7ztzW+3cM1zr
         mRlrpa4/wve9MvsyzHns/c6mo/kRNfOEJUgKd9Mj8371/R52DQHejCYu7As4M6cB6OxL
         ICag==
X-Gm-Message-State: AOJu0YyjHhf5KZLAVFJAodZshnvSzQtF73c2Y11eQIzsNB4ugXFNTbIX
	fa2oUqX+3Y+VrM6SvHLpNzjGy0ugoPGDOn057aZPC9wHS/QMnHltfDv0XErxdms=
X-Google-Smtp-Source: AGHT+IELmwvW/s0F6UnPU4+zzYDDC9UZKgNqB13RQB+Ab9DIPVnMFGajYCpmHLTrpnTgWR8J/CCU1A==
X-Received: by 2002:a5d:6585:0:b0:33d:26b1:c460 with SMTP id q5-20020a5d6585000000b0033d26b1c460mr485460wru.39.1711528511165;
        Wed, 27 Mar 2024 01:35:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 01/13] pinctrl: renesas: rzg2l: Use devm_clk_get_enabled() helper
Date: Wed, 27 Mar 2024 10:34:56 +0200
Message-Id: <20240327083508.2229567-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15455

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 95eb19869401850f069723b296170b8b3bd5be9e upstream.

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the need of a dedicated function used
with devm_add_action_or_reset().

While at it, use dev_err_probe() which filters -EPROBE_DEFER.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/a4a586337d692f0ca396b80d275ba634eb419593.1690058500.git.christophe.jaillet@wanadoo.fr
[geert: Make clk local to rzg2l_pinctrl_probe()]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 32 ++++---------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 22abac051ab6..b0ef821e7016 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -145,7 +145,6 @@ struct rzg2l_pinctrl {
 	const struct rzg2l_pinctrl_data	*data;
 	void __iomem			*base;
 	struct device			*dev;
-	struct clk			*clk;
 
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	gpio_range;
@@ -1480,14 +1479,10 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 	return 0;
 }
 
-static void rzg2l_pinctrl_clk_disable(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 {
 	struct rzg2l_pinctrl *pctrl;
+	struct clk *clk;
 	int ret;
 
 	BUILD_BUG_ON(ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT >
@@ -1510,12 +1505,10 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(pctrl->base))
 		return PTR_ERR(pctrl->base);
 
-	pctrl->clk = devm_clk_get(pctrl->dev, NULL);
-	if (IS_ERR(pctrl->clk)) {
-		ret = PTR_ERR(pctrl->clk);
-		dev_err(pctrl->dev, "failed to get GPIO clk : %i\n", ret);
-		return ret;
-	}
+	clk = devm_clk_get_enabled(pctrl->dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(pctrl->dev, PTR_ERR(clk),
+				     "failed to enable GPIO clk\n");
 
 	spin_lock_init(&pctrl->lock);
 	spin_lock_init(&pctrl->bitmap_lock);
@@ -1523,21 +1516,6 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pctrl);
 
-	ret = clk_prepare_enable(pctrl->clk);
-	if (ret) {
-		dev_err(pctrl->dev, "failed to enable GPIO clk: %i\n", ret);
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_pinctrl_clk_disable,
-				       pctrl->clk);
-	if (ret) {
-		dev_err(pctrl->dev,
-			"failed to register GPIO clk disable action, %i\n",
-			ret);
-		return ret;
-	}
-
 	ret = rzg2l_pinctrl_register(pctrl);
 	if (ret)
 		return ret;
-- 
2.39.2


