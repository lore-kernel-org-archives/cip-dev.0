Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DCEC3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:33 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.10258.1746783145513976090
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=AJ9aXw5W;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f7ec0e4978so3490403a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783144; x=1747387944; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kImx8YrVCCScHLaX0v//oJ5MRXYTveMQ1xoAnP1LPAY=;
        b=AJ9aXw5Wm/dyi9WRMEInGZia0q1rOEnD6x/OqKHqIO8DhwmIUqnx5KsEYqEkb6BXNJ
         49t3chf6Ih3LG4lFm36DjeBGTz4y4xWDx0WrOaQ5ZzAnnITJBOH2fh1752g4B8l9XcgD
         Fr8wZDhtgeTRWyZ0/fc+Z8Z4SmL7OI5Ml/y7OzQ1NZqWGIKj4X6VXTO1lnkuDlsaH/zS
         20VGac4EMhtIi1riyNcMBnEoptN1TmUjhUVGwbd4cC8yzNnBr+Y1w0/V4Z2Ikzzc7fuA
         fCko+7U1zliaofcSfQxCi1wvMmIK1XZnYUvE0ioZaUvWK+EuC+pbPqImFA/7KA9SZ8dh
         2kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783144; x=1747387944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kImx8YrVCCScHLaX0v//oJ5MRXYTveMQ1xoAnP1LPAY=;
        b=hMsbs7+QHN8y8pVYdkMqrFCjb2DpZHj2mymH/uRis2QMGcuxUGoHYxnevLxWjEOfQ5
         PMbxvZIoJJViLffq3ijiLdFFed1NJqCpGr+xjmmAQ6flnsWSy9ohtVpCz3QH6sBPDnLH
         xL0Nj527XRV/rERiu3w4aSxIasz85oZV+PgJ/JU8MXF9A8M0LDB0MA44GARonCd5ssQD
         6tiWolwdJEmn1xJYCHv8E0RyvM4utbfbeccgcEknDNPSP1rafBh8rs6ylCcfYw8px4qJ
         H1hu+OYPAIOwRl4nGzD0QUJDTEbJ/C9eTZQewr8zpJuP7mxsgqlKQR5dGveUER/zvPyX
         yOBg==
X-Forwarded-Encrypted: i=1; AJvYcCWzPOgnmGPoi0TStEC5GvIIAnc81mudDH2wrZZkouS29bnwGp5BOqNsFQ9IhOGbmM1ny3Pigvu9@lists.cip-project.org
X-Gm-Message-State: AOJu0YzXfI3AYRh4QBOZpXExGRuTTkGitzn6EPY4mmDBY9M8T7PMdzFH
	xZKlBZ1LxN0+dZliwAPw8rwfJgt97JuCMKmB3HmMjM3x2M9wwSv+uD8epzSzBYs=
X-Gm-Gg: ASbGncsObZad80ckSxtwAFugkvY1kQir/USqChKpNvuc2d4rZAwD/uExFJPMuJMKSg1
	zuOuTftcw1wWnZGFk41OlTY9VL9Z8zQkHl8plQPq2LJ9HvlvMjLXYIkTPgeFD6HnQVdSHJaWDc5
	6uKoWJxwumbsQ66pQmYvSsFGdsIvwguWikZQrouCkFspMyRofPWuw/sHwIpKkkoIcIM4wCXxsag
	F8qDRqXDNsj+5sSZDk3jbEwsFprZ+v2HPUvQd9jLNGoRy1qvcdlj6hGMNj5QG9cndQ7TISl4x7n
	o1gjC2kUQTlLDbRd15Urn5q9ggf/+pIRb7a66t1VlCs6akwsRd48LjDgbYAi0Xc6exjXdA==
X-Google-Smtp-Source: AGHT+IHrud7YDVou7aOVYQMTrK30jmIpcYxT1C8Aw0kTmOTQiju1u3AaVF8px46KwLnNBwvOiViP0w==
X-Received: by 2002:a05:6402:26c5:b0:5f8:5672:69cb with SMTP id 4fb4d7f45d1cf-5fca0730948mr1956280a12.5.1746783143799;
        Fri, 09 May 2025 02:32:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 14/29] ASoC: renesas: rz-ssi: Use temporary variable for struct device
Date: Fri,  9 May 2025 12:31:48 +0300
Message-ID: <20250509093203.4014750-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18801

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 403366d2a43eb7c911c6cddf1d7882e429d1212d upstream.

Use a temporary variable for the struct device pointers to avoid
dereferencing.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-12-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 62 +++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index f3a07ac51501..15c78222647d 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1025,36 +1025,37 @@ static const struct snd_soc_component_driver rz_ssi_soc_component = {
 
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
@@ -1067,13 +1068,13 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1082,7 +1083,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	ssi->capture.priv = ssi;
 
 	spin_lock_init(&ssi->lock);
-	dev_set_drvdata(&pdev->dev, ssi);
+	dev_set_drvdata(dev, ssi);
 
 	/* Error Interrupt */
 	ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
@@ -1091,12 +1092,11 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1108,11 +1108,11 @@ static int rz_ssi_probe(struct platform_device *pdev)
 			if (ssi->irq_rt < 0)
 				return ssi->irq_rt;
 
-			ret = devm_request_irq(&pdev->dev, ssi->irq_rt,
+			ret = devm_request_irq(dev, ssi->irq_rt,
 					       &rz_ssi_interrupt, 0,
-					       dev_name(&pdev->dev), ssi);
+					       dev_name(dev), ssi);
 			if (ret < 0)
-				return dev_err_probe(&pdev->dev, ret,
+				return dev_err_probe(dev, ret,
 						     "irq request error (dma_rt)\n");
 		} else {
 			if (ssi->irq_tx < 0)
@@ -1121,50 +1121,50 @@ static int rz_ssi_probe(struct platform_device *pdev)
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


