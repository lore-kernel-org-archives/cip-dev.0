Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66703C3ABAC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:47 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.20341.1745934462920498960
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZHUB7NHy;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac7bd86f637so1345432066b.1
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934461; x=1746539261; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSw5x3rxzqpAtk6Qr525xBrr+/XQVYP6VU1Fa9Six+U=;
        b=ZHUB7NHy0UUlhO8egzc0ZA5wHhuLpP0/1KQOZaH5VM6Ccl6FQLlncd4l9xCmgUssFX
         cPAzyhpA59wo34ik8Zg7WNkeBXTvNspJ/WDUfdIFgOJv+7i5m214j0p4vK27ATHg1HW/
         mxUiB5mITux9sDKPlRGvvlBK+M0x8g+ZbGTuNsqNCJ7E3YPbQhzKMursCVpC6aI+wzxh
         Q8yE/5HDcMQjCGo+kXpA4zI86qjBkeQ9cX4AumsaERCmBxfNkgV+p3EgEPU4RalVGtS/
         3U9g/Sks8Qx73IrsUvPcp1P3UtihktFLUXSlfJrnSRG8bDdvYS6EIWfy9Nox4dag6nyD
         K0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934461; x=1746539261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSw5x3rxzqpAtk6Qr525xBrr+/XQVYP6VU1Fa9Six+U=;
        b=b4qSWAxt8eU9SMbHcqmEPkRaAcPfz9Ja4S1ubnawjMOv6uE7CkROJOCgRdD/r2RgUy
         HtXD+6T2iUQfLNoKpiu2sUOJDevWAJ7Zh976KXsnraVK/gydT2TPyM5ZqoryMsw3LTwn
         M36JGFzdmmkCMSWPzsxbpPKLp96tWUjvdUbpUbap0kSAqjYd+o65u27Rjd0nRthGQFlz
         H/j3e9QQMWV1w2Yw6xc6NJPyahCVCqdylHoXsESCMCW9UoQldYCHc4GNO2dZ/+gChJWF
         szH08yPiYcRgJv5qwoxWMiXOeWcnCsh1q3wDsueFmPuTZeLK+JzE+8xq/9yKytxeHhz8
         3m6w==
X-Forwarded-Encrypted: i=1; AJvYcCW/o5NLmtK+VQxdUNfv9iytR2CMQY2pb47tPAR9vVlyiCV8Q+I5N8wsAIJ6pnPc4+jVzh2zdmHq@lists.cip-project.org
X-Gm-Message-State: AOJu0YxRG2KFhzy0knjrvRjx667C9TunTDjXC3Yl2tHIB9mUIKGxBSDh
	WrwGSj1T1z2pJstSByJxfqpfmwAAtJf+ZQerJXMfCLyGEEDMGfeuGUqE5yLy97Q=
X-Gm-Gg: ASbGncuCY5Ti+IjwVXMZ4BAeg0U8r3Gpc+fwLTkQkgHVz1c5VfsJ3wEEDXq+uPx4idw
	FacGf2huATyiBWTorBPbnSo89RH5EDnpN06K0Ss/GHkwhka/tMk/PHmtOaFRArI8vCcIkW0nFyp
	65j9E/b5cf2HT6GccqsEx7NxglRAX1LN5hsbMZ5RDLfzCKkf2bmafz001Ll1Lh9/A/X2NQde3Aa
	LPmGqgHs0a/cgWN2vDUmcxYwLwvYIuMTqCAWtkqrpF5QlXUJdzYmv3Z58ux3hbITjnne3waUBrC
	6xba+O7qB5n/R6NGGUPwzVG7L7OctVQ2WpViGtB8rkx6r8Vml4Qjjj53NQtenOwibq5Ch/b3yD+
	V5xK4sg==
X-Google-Smtp-Source: AGHT+IGOP89tF9SA72ZO/ECyf7I7ftiRBoVbh8wApEMLG3V4j/W1VIT9VgZ6Ggn7tQ1W9lSJ7NVTfw==
X-Received: by 2002:a17:907:86a5:b0:ac7:2fbb:ba5 with SMTP id a640c23a62f3a-acec69e5ed1mr329233166b.7.1745934460821;
        Tue, 29 Apr 2025 06:47:40 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 07/21] i2c: riic: Use temporary variable for struct device
Date: Tue, 29 Apr 2025 16:47:13 +0300
Message-ID: <20250429134727.2429662-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18720

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b42ed9fd6cd111a312e4ef35d9a417756f581bef upstream.

Use a temporary variable for the struct device pointers to avoid
dereferencing.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
[claudiu.beznea: fix conflict in riic_i2c_remove() as the function
 returns int compared to its upstream version]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 49 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 9df80c4c2b5b..ea2c894600d5 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -132,11 +132,12 @@ static inline void riic_clear_set_bit(struct riic_dev *riic, u8 clear, u8 set, u
 static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
 	struct riic_dev *riic = i2c_get_adapdata(adap);
+	struct device *dev = adap->dev.parent;
 	unsigned long time_left;
 	int i;
 	u8 start_bit;
 
-	pm_runtime_get_sync(adap->dev.parent);
+	pm_runtime_get_sync(dev);
 
 	if (riic_readb(riic, RIIC_ICCR2) & ICCR2_BBSY) {
 		riic->err = -EBUSY;
@@ -169,7 +170,7 @@ static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	}
 
  out:
-	pm_runtime_put(adap->dev.parent);
+	pm_runtime_put(dev);
 
 	return riic->err ?: num;
 }
@@ -304,8 +305,9 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 	int ret = 0;
 	unsigned long rate;
 	int total_ticks, cks, brl, brh;
+	struct device *dev = riic->adapter.dev.parent;
 
-	pm_runtime_get_sync(riic->adapter.dev.parent);
+	pm_runtime_get_sync(dev);
 
 	if (t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) {
 		dev_err(&riic->adapter.dev,
@@ -397,7 +399,7 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 	riic_clear_set_bit(riic, ICCR1_IICRST, 0, RIIC_ICCR1);
 
 out:
-	pm_runtime_put(riic->adapter.dev.parent);
+	pm_runtime_put(dev);
 	return ret;
 }
 
@@ -416,13 +418,14 @@ static void riic_reset_control_assert(void *data)
 
 static int riic_i2c_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct riic_dev *riic;
 	struct i2c_adapter *adap;
 	struct i2c_timings i2c_t;
 	struct reset_control *rstc;
 	int i, ret;
 
-	riic = devm_kzalloc(&pdev->dev, sizeof(*riic), GFP_KERNEL);
+	riic = devm_kzalloc(dev, sizeof(*riic), GFP_KERNEL);
 	if (!riic)
 		return -ENOMEM;
 
@@ -430,22 +433,22 @@ static int riic_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(riic->base))
 		return PTR_ERR(riic->base);
 
-	riic->clk = devm_clk_get(&pdev->dev, NULL);
+	riic->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(riic->clk)) {
-		dev_err(&pdev->dev, "missing controller clock");
+		dev_err(dev, "missing controller clock");
 		return PTR_ERR(riic->clk);
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(rstc))
-		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
+		return dev_err_probe(dev, PTR_ERR(rstc),
 				     "Error: missing reset ctrl\n");
 
 	ret = reset_control_deassert(rstc);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&pdev->dev, riic_reset_control_assert, rstc);
+	ret = devm_add_action_or_reset(dev, riic_reset_control_assert, rstc);
 	if (ret)
 		return ret;
 
@@ -454,29 +457,29 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
-		ret = devm_request_irq(&pdev->dev, ret, riic_irqs[i].isr,
+		ret = devm_request_irq(dev, ret, riic_irqs[i].isr,
 				       0, riic_irqs[i].name, riic);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request irq %s\n", riic_irqs[i].name);
+			dev_err(dev, "failed to request irq %s\n", riic_irqs[i].name);
 			return ret;
 		}
 	}
 
-	riic->info = of_device_get_match_data(&pdev->dev);
+	riic->info = of_device_get_match_data(dev);
 
 	adap = &riic->adapter;
 	i2c_set_adapdata(adap, riic);
 	strscpy(adap->name, "Renesas RIIC adapter", sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->algo = &riic_algo;
-	adap->dev.parent = &pdev->dev;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->dev.parent = dev;
+	adap->dev.of_node = dev->of_node;
 
 	init_completion(&riic->msg_done);
 
-	i2c_parse_fw_timings(&pdev->dev, &i2c_t, true);
+	i2c_parse_fw_timings(dev, &i2c_t, true);
 
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	ret = riic_init_hw(riic, &i2c_t);
 	if (ret)
@@ -488,24 +491,24 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, riic);
 
-	dev_info(&pdev->dev, "registered with %dHz bus speed\n",
-		 i2c_t.bus_freq_hz);
+	dev_info(dev, "registered with %dHz bus speed\n", i2c_t.bus_freq_hz);
 	return 0;
 
 out:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 	return ret;
 }
 
 static int riic_i2c_remove(struct platform_device *pdev)
 {
 	struct riic_dev *riic = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
 
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_get_sync(dev);
 	riic_writeb(riic, 0, RIIC_ICIER);
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put(dev);
 	i2c_del_adapter(&riic->adapter);
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 
 	return 0;
 }
-- 
2.43.0


