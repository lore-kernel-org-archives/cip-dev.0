Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C81C3DA4A
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:54 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web11.10308.1746783230788718134
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=pchzmKA9;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad21c5d9db2so117216266b.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783229; x=1747388029; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qylayr0642LUU9X7Mo7pfip7APMmd2q4CWlWuGS2GKs=;
        b=pchzmKA9eXc/3n6LhQi0inwm9u4AAOMZtEckw9nidC2uKoHy+GRr/aJO1RccUpVECk
         UBZVzvqX6ijKPFgMWjbd1kyMQ9Cu6kxBGXiC6STyAJbtCpVKRzmdUsmheaOXFEZt5K9P
         VGElb0ATBQ0nWYYZ3bHJECwrLjerJ82WK1CCJwuz1atgA7iska2MPhjdEBLGy+j65y0w
         XYw3inL9OIMPeRqDORNFkEh7Ktk30Cs9UKoLvAm1fzUuqaCdIPsWMoHxS+iPaYuIWZwa
         Ty/ilJ49RnhYKv/qrpC8Z5EHiLS2qv2bGP/o3uvL07T/riH1+1lfnxhAtoMc6+gnh32G
         CxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783229; x=1747388029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qylayr0642LUU9X7Mo7pfip7APMmd2q4CWlWuGS2GKs=;
        b=nxPjYok4QzJfJ+B0FzHTHJ0eU86nj/t+ubXJwQeRcuDZi6QhDgrULmt1XFiIMmxj32
         EDfJ41zv7tokCVP2LqWDL3D4QINaJ/9fqn2p0hSiF5bU6cbN5ChfLOCzJl7FNJ1TnJgz
         clw2odhNbiBUhGWscJaojnGCghtwvSz9LMZcflYm0LY1+iKkQoO3OcQ3KxOWTDHfnaZm
         GxdGAsG1scGqER7aKN57I4ABsZszGS9sAZt9fJU/ekfif2y1tbFQX4vcKowdImkvtCP0
         cgrwVghGZtqB4d3IMTIcMNal/ptmv5ibqu2p7Vu397iIPPz1gBgkkSHeKHUGssdCOntI
         Q6rA==
X-Forwarded-Encrypted: i=1; AJvYcCUblyBKa7BdxLCVsC4rf+muHPAHbM3kXpSk3UX7YcXde/9X1TSI+3eBq1DBCS/OX8ab2iXd2vWr@lists.cip-project.org
X-Gm-Message-State: AOJu0YzXslEO6uDHHvRxHpkqrI/C9EOnM7lJrXnfE2+MJekwMfsfc9tT
	imdw6XWZkNIiTHClMeEk0jSV2NyO17er5pRkHoCMKBUB7SCngYJj0B/HIUK+TJ8y+NDjffuqkK0
	2
X-Gm-Gg: ASbGncsJH0lcqB4/R0rV3SokohACign671sBqtKxSzoICPC9n0tv7XeP5mfC/dViKcw
	pA9zaroIO5AyNmt4q1vWZaweG+XFSskb6UF1VbSwy65yoKhvVxPAeWYRj5MbSmUckbGOZEuLYuC
	1IKSOSgEx4Nn6FAEtD2y/DMigBXi8oJ+ZTu3+EhBNbZYiDtgWUqYEenhWpUCqpf4ZNvZUavA+CW
	Kd/S7bK6wyHzLzgiiBG8roUspBl9un4kqgRjvBnUgAOmnPAs0YJU8qctNVkwpl9onXaBWq0ig2n
	mgt6LFqugJp86dcK1fgRD117qI8cXcswD5A/c5YwhQz5xTSOUv0L7wLoWpV28Lk1HIXmtg==
X-Google-Smtp-Source: AGHT+IHFefK4uktnLLnDtbm7LliCjAUfyq05uimlpLc4E3aKPQ/NX/isRbBwzzykCz4Tj2Oo9lc0BQ==
X-Received: by 2002:a17:907:c23:b0:ace:c3b9:c710 with SMTP id a640c23a62f3a-ad2191448a1mr220489866b.36.1746783229084;
        Fri, 09 May 2025 02:33:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 19/34] ASoC: renesas: rz-ssi: Use temporary variable for struct device
Date: Fri,  9 May 2025 12:33:03 +0300
Message-ID: <20250509093318.4014916-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18836

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
index 997ac3897862..0fc7ede4d392 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1033,36 +1033,37 @@ static const struct snd_soc_component_driver rz_ssi_soc_component = {
 
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
@@ -1075,13 +1076,13 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1090,7 +1091,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	ssi->capture.priv = ssi;
 
 	spin_lock_init(&ssi->lock);
-	dev_set_drvdata(&pdev->dev, ssi);
+	dev_set_drvdata(dev, ssi);
 
 	/* Error Interrupt */
 	ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
@@ -1099,12 +1100,11 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1116,12 +1116,12 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1129,50 +1129,50 @@ static int rz_ssi_probe(struct platform_device *pdev)
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


