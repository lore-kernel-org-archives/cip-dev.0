Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59103CD12A9
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.32432.1711527487337625102
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dnrwNeA3;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41488e17e1cso17815725e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527486; x=1712132286; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L54lWPHYc9HFQiRqSsiWrn83FaCx6Rp3gfoBfFoHZac=;
        b=dnrwNeA3h1shLimWGh1qQqwT92MtpMRhrgx09kBokyqLs0M5d9UaRdA3yJyquVemBv
         zVTydlYrP1fuAeC0vG1B+GLd3p5b918CZoOn0Y/4shP15oJipD0ogLSG3PlPtUDYBgv8
         1FfnHhnq4bwWB882ZGydchWFgObtqW6LWu5A1eH/JmnumD/B2VKRZVcgwN+IwvtQ+k1t
         CmrrDeD4JgtTkrCi8xHipe1X4vmr1dLX0f83sJww2mpsN0cFVLw37LUHTuSIFatroOk3
         HQcvZPcu+CdpBnIGsaQaO1wkjHPHlrBUpwRzB9aC1egxrKiTAPa65kDI72w6h5xn0LGI
         b/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527486; x=1712132286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L54lWPHYc9HFQiRqSsiWrn83FaCx6Rp3gfoBfFoHZac=;
        b=BJIaAWPjDA61WN+gLvYjJzVIV4BndVNsXtI9oFN1FSsBIfvzvazdt9+9YyZ25R4rdZ
         7ZZSfUdpSo8p8FBGjqSOIlbQ6bsemxiAVSJ+G2aUbYoSTY09QX4efkuYpJBTN4ljzZHs
         J6f7L3B/is+UYeh2iSBXsNC1gpmfa9BIZeX6axwkfEc9VA3aZ6QiDv/qEiSAzW3SlUhE
         e3Yoh9cEYNU/7ovUh25Dx6vbO+5HDjCUmQbGJ/oyf7jESHfMKGPZSB49fxxf3Z/xhmYA
         0DF0uJFjCy6RFWVs1emIz8vDY4FYWCjdvVYhdXlGJ3xWo/mAtppyHQAvWrX/gD73hlV9
         U+bA==
X-Gm-Message-State: AOJu0YwfP+IiUwSW2Yu1WutdZtBoi4UhIRC9+iGrHPPlhI6radXIu68D
	lXUHVSPav9fwR2ydfo+oG5/Ei2IVi16WQE5F0GJ8UiMmf5B3Rlz9AjmQ0r2P6Fg=
X-Google-Smtp-Source: AGHT+IEZmrTHpN441cpLLtYrk2OdUqOxpR8jhVVK1NTgKXOzEJQDtcHQoaKfY+NNRH31vSNo1iVD6Q==
X-Received: by 2002:a05:600c:46c7:b0:414:7597:c2dc with SMTP id q7-20020a05600c46c700b004147597c2dcmr3486007wmo.17.1711527485741;
        Wed, 27 Mar 2024 01:18:05 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 06/36] pinctrl: renesas: rzg2l: Use devm_clk_get_enabled() helper
Date: Wed, 27 Mar 2024 10:17:26 +0200
Message-Id: <20240327081756.2228036-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15423

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
index 230075645094..a0a704449caf 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -142,7 +142,6 @@ struct rzg2l_pinctrl {
 	const struct rzg2l_pinctrl_data	*data;
 	void __iomem			*base;
 	struct device			*dev;
-	struct clk			*clk;
 
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	gpio_range;
@@ -1476,14 +1475,10 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
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
@@ -1506,12 +1501,10 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
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
@@ -1519,21 +1512,6 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 
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


