Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5292EC3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:25 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web11.10360.1746783317091172231
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=AxDh9u2M;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f6fb95f431so5670834a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783315; x=1747388115; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdtgQa+3q2RUP2VTNyYStb6zYqnO/YzcE+TaGsn3o8I=;
        b=AxDh9u2Mw0F/jMNlODT6f/cIw4/GsT9wOAneaElAqWSLGRFaIU61DfxE16DhvjxRKZ
         lpDbk1mzBHBXfQa8eeVIJXwQ8T/d2+ke+HbKLv7SQ68Q0ZbT+L2ObTpjXlZBVG8/KNLX
         W0BUes57yLjQE9f31CGZLE2bNbLxclsldhaGrtEtzcABRkaZxrvvGbLfn+nI63r+n7Ka
         AEXmqymDshfOfRqdSlW2+FiOY+vb0x1RxXExPJVdqxu3j09QFOyBRfIxC0zT+/tsvGxj
         asxqY5+FaoMXWLu0+TGS7nJGlMRU0xUUpBU1Xg9JtWX3YcBMmld4LJWGPed6aS2I8MSp
         maCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783315; x=1747388115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdtgQa+3q2RUP2VTNyYStb6zYqnO/YzcE+TaGsn3o8I=;
        b=lxZYz+8Mv/P9wHFBtixIWWsiGYgjpkzutbnS3PQr4dTmk1tX3GOY2+ZWJGpNoH7nfh
         rFUyDU4XS2grqokGaGJ4rtIe2Gc6ihSnPJeqk4tRMRgjwHWUnYsBaHyPTyREFF9zYTCX
         F6L8qVAxqVEsvNmJf25IJka3KHaVR9dDPD6dse91BGJ76vIry2j+Krqdda/BOx7T9lDi
         vAn3BZQqqzhniKIo+u6dWl59+V+8HU8mcJrrLhKVsqTILgS143JZuAyR8MQnK0uUdvSI
         rAxePHfzAijRfYfcigxxQ5fP2koMq2L2CNNaQ/n4GEvGP//oADY19NQEpuZfjsLTLK8k
         RC9w==
X-Forwarded-Encrypted: i=1; AJvYcCXcz6srJabBG0nrnJ3+oFu5Be7PNbnIQ+cDr0TEHJMvh/s5ot4IS+/l8Os/PMuR+QO5e08nm8ww@lists.cip-project.org
X-Gm-Message-State: AOJu0YzOj+ACwkx24S+vwPxWZibzqIRodzQLyNQKffK1gTgONqBjeCTL
	jrmPaTPIBEU8eJ6wVytKwCl3GfivqauJjHeAhWybnmic8WWM1t+v7X0dlZR/XZQ=
X-Gm-Gg: ASbGncvY0/kXkoNGP6cQ27r0woa0shiZkQ5n2ob/9WVBdyIgduJvHEtTEFEj0knk0mH
	pYSuw2Xh16a1DIhSp/7Fr24Ll7NEqxhG/Iidu7ogK5360b/0W7Q5hhOj7GbiiVw5p7molE0Cuyf
	fOQVzEkMTKTw5C75whehAcXw5ISiURtbnUS8PPd9oHJCrhbibOBv1M+vWFlIVcIXHJUFF4LKObg
	LoBGsYkumXK4wSkVpLUn4l9f1XOp7TRIcynV917KXZDkS++CxfxFrfF3V6ANXm+D6FgnRH6ti2u
	kBu6C66/LEykpPmqIZBX1m6VLK8AXYJkWFXpcIPdTqyneNyRmc/TSV8fT9PojJRlUar3mA==
X-Google-Smtp-Source: AGHT+IGlkhALNlXWCy/Z2iMc0+GSTE1n1U8cbLLiKtP3UWXUZCCcgrZ1ZHk6s8HorlYka9OT5ZhGyg==
X-Received: by 2002:a17:907:6e94:b0:ace:6f1f:2233 with SMTP id a640c23a62f3a-ad1fcca1145mr609501166b.24.1746783315272;
        Fri, 09 May 2025 02:35:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 22/37] ASoC: renesas: rz-ssi: Use temporary variable for struct device
Date: Fri,  9 May 2025 12:34:27 +0300
Message-ID: <20250509093442.4015145-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18874

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 403366d2a43eb7c911c6cddf1d7882e429d1212d upstream.

Use a temporary variable for the struct device pointers to avoid
dereferencing.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-12-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[claudiu.beznea: fixed conflict by keeping the "irq request error
 (dma_rt)" text from commit 403366d2a43eb7c911c6cddf1d7882e429d1212d]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 64 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 2b9e649d641f..64fa773f2ea2 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1030,36 +1030,37 @@ static const struct snd_soc_component_driver rz_ssi_soc_component = {
 
 static int rz_ssi_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct rz_ssi_priv *ssi;
 	struct clk *audio_clk;
 	struct resource *res;
 	int ret;
 
-	ssi = devm_kzalloc(&pdev->dev, sizeof(*ssi), GFP_KERNEL);
+	ssi = devm_kzalloc(dev, sizeof(*ssi), GFP_KERNEL);
 	if (!ssi)
 		return -ENOMEM;
 
-	ssi->dev = &pdev->dev;
+	ssi->dev = dev;
 	ssi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ssi->base))
 		return PTR_ERR(ssi->base);
 
 	ssi->phys = res->start;
-	ssi->clk = devm_clk_get(&pdev->dev, "ssi");
+	ssi->clk = devm_clk_get(dev, "ssi");
 	if (IS_ERR(ssi->clk))
 		return PTR_ERR(ssi->clk);
 
-	ssi->sfr_clk = devm_clk_get(&pdev->dev, "ssi_sfr");
+	ssi->sfr_clk = devm_clk_get(dev, "ssi_sfr");
 	if (IS_ERR(ssi->sfr_clk))
 		return PTR_ERR(ssi->sfr_clk);
 
-	audio_clk = devm_clk_get(&pdev->dev, "audio_clk1");
+	audio_clk = devm_clk_get(dev, "audio_clk1");
 	if (IS_ERR(audio_clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(audio_clk),
 				     "no audio clk1");
 
 	ssi->audio_clk_1 = clk_get_rate(audio_clk);
-	audio_clk = devm_clk_get(&pdev->dev, "audio_clk2");
+	audio_clk = devm_clk_get(dev, "audio_clk2");
 	if (IS_ERR(audio_clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(audio_clk),
 				     "no audio clk2");
@@ -1072,13 +1073,13 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	ssi->audio_mck = ssi->audio_clk_1 ? ssi->audio_clk_1 : ssi->audio_clk_2;
 
 	/* Detect DMA support */
-	ret = rz_ssi_dma_request(ssi, &pdev->dev);
+	ret = rz_ssi_dma_request(ssi, dev);
 	if (ret < 0) {
-		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
+		dev_warn(dev, "DMA not available, using PIO\n");
 		ssi->playback.transfer = rz_ssi_pio_send;
 		ssi->capture.transfer = rz_ssi_pio_recv;
 	} else {
-		dev_info(&pdev->dev, "DMA enabled");
+		dev_info(dev, "DMA enabled");
 		ssi->playback.transfer = rz_ssi_dma_transfer;
 		ssi->capture.transfer = rz_ssi_dma_transfer;
 	}
@@ -1087,7 +1088,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	ssi->capture.priv = ssi;
 
 	spin_lock_init(&ssi->lock);
-	dev_set_drvdata(&pdev->dev, ssi);
+	dev_set_drvdata(dev, ssi);
 
 	/* Error Interrupt */
 	ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
@@ -1096,12 +1097,11 @@ static int rz_ssi_probe(struct platform_device *pdev)
 		return ssi->irq_int;
 	}
 
-	ret = devm_request_irq(&pdev->dev, ssi->irq_int, &rz_ssi_interrupt,
-			       0, dev_name(&pdev->dev), ssi);
+	ret = devm_request_irq(dev, ssi->irq_int, &rz_ssi_interrupt,
+			       0, dev_name(dev), ssi);
 	if (ret < 0) {
 		rz_ssi_release_dma_channels(ssi);
-		return dev_err_probe(&pdev->dev, ret,
-				     "irq request error (int_req)\n");
+		return dev_err_probe(dev, ret, "irq request error (int_req)\n");
 	}
 
 	if (!rz_ssi_is_dma_enabled(ssi)) {
@@ -1113,12 +1113,12 @@ static int rz_ssi_probe(struct platform_device *pdev)
 			if (ssi->irq_rt < 0)
 				return ssi->irq_rt;
 
-			ret = devm_request_irq(&pdev->dev, ssi->irq_rt,
+			ret = devm_request_irq(dev, ssi->irq_rt,
 					       &rz_ssi_interrupt, 0,
-					       dev_name(&pdev->dev), ssi);
+					       dev_name(dev), ssi);
 			if (ret < 0)
-				return dev_err_probe(&pdev->dev, ret,
-						"irq request error (dma_tx)\n");
+				return dev_err_probe(dev, ret,
+						     "irq request error (dma_rt)\n");
 		} else {
 			if (ssi->irq_tx < 0)
 				return ssi->irq_tx;
@@ -1126,50 +1126,50 @@ static int rz_ssi_probe(struct platform_device *pdev)
 			if (ssi->irq_rx < 0)
 				return ssi->irq_rx;
 
-			ret = devm_request_irq(&pdev->dev, ssi->irq_tx,
+			ret = devm_request_irq(dev, ssi->irq_tx,
 					       &rz_ssi_interrupt, 0,
-					       dev_name(&pdev->dev), ssi);
+					       dev_name(dev), ssi);
 			if (ret < 0)
-				return dev_err_probe(&pdev->dev, ret,
+				return dev_err_probe(dev, ret,
 						"irq request error (dma_tx)\n");
 
-			ret = devm_request_irq(&pdev->dev, ssi->irq_rx,
+			ret = devm_request_irq(dev, ssi->irq_rx,
 					       &rz_ssi_interrupt, 0,
-					       dev_name(&pdev->dev), ssi);
+					       dev_name(dev), ssi);
 			if (ret < 0)
-				return dev_err_probe(&pdev->dev, ret,
+				return dev_err_probe(dev, ret,
 						"irq request error (dma_rx)\n");
 		}
 	}
 
-	ssi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	ssi->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(ssi->rstc)) {
 		ret = PTR_ERR(ssi->rstc);
 		goto err_reset;
 	}
 
 	reset_control_deassert(ssi->rstc);
-	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	pm_runtime_enable(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed\n");
+		dev_err(dev, "pm_runtime_resume_and_get failed\n");
 		goto err_pm;
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &rz_ssi_soc_component,
+	ret = devm_snd_soc_register_component(dev, &rz_ssi_soc_component,
 					      rz_ssi_soc_dai,
 					      ARRAY_SIZE(rz_ssi_soc_dai));
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register snd component\n");
+		dev_err(dev, "failed to register snd component\n");
 		goto err_snd_soc;
 	}
 
 	return 0;
 
 err_snd_soc:
-	pm_runtime_put(ssi->dev);
+	pm_runtime_put(dev);
 err_pm:
-	pm_runtime_disable(ssi->dev);
+	pm_runtime_disable(dev);
 	reset_control_assert(ssi->rstc);
 err_reset:
 	rz_ssi_release_dma_channels(ssi);
-- 
2.43.0


