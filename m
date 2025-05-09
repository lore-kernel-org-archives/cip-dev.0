Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B136C3ABCF
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:25 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.10423.1746783323425947089
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RpXjvBHB;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-acb5ec407b1so323906066b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783322; x=1747388122; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+DMbtBS2bVHW3vUEcTxET3gCudEWEQF5ZHrCkwisYw=;
        b=RpXjvBHBjozkeBasETWSE7/g5ECzrBwFpAAZdpNDZH5ZgCo8ED6Ufe112KLcrTfvF+
         tHKGv+19shcP7qPg4nkKGD7p/uLptPnHXudL2gNxctOu/TLyrq5lm+wxVdaCpLZ2XCfG
         qf5cigwVq8a6NzW1mJqYGJsLJ9FswvqGFyXv392CQvwSf9WyO7NBXmMrWIqQNw1gE92l
         hNkktHdQ0Uz1Sy/Q/wi2Fvt+FTQ+9t8IR807lHKKTXlANv1bysJmNhSN5I6D2Kby3sqU
         f9zTw5e9xQLulmKWTLjvZ0DjwyVQ+gewuKc0gUqey7LoCezgC/GKX0rcySfAAxu6pFMJ
         DI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783322; x=1747388122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+DMbtBS2bVHW3vUEcTxET3gCudEWEQF5ZHrCkwisYw=;
        b=Cn5mT1MW6I1QAKmWH7lyM4AyCOZxMXFZ556Q8/aHSBj9pPMnDF3/kiQCDLLIAmoWMr
         bLRUL/AejpHK1RqU32pgzaXOsrfABCy3dQxhH9J1YWlnUOHVkX3bdLZf8z5xnlI4GcuX
         QniYiFGo0g56KVIbrhZg6OLx6bcqj2I2UfV1vrl+AK5T6oeP4xIujpRAJxQ5RgQWhkzS
         6lw13kWjpazOgLGzIWUDjQB0p+gNm7xf99maBjpRNb5KF3/oxvYesilOEizVbOkHfAR2
         qAfkz0Ryt2+HPBveHjo5bND9PQG4UKq9BZkjHZJF7G8Yt5PLcuUaMiBIjKu7IiklRyBj
         Eplw==
X-Forwarded-Encrypted: i=1; AJvYcCXEKGTxs+4RL6u0zpllNQ/BnXcri1I5ilBR5QCUuFTxMwQB95AVeAr8fSZPacKdbRjaTPqxEhTF@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz8ryRhLlVez8r1jS59HnH/SZaSly3KRP7o6amCUmGbuRokCYP4
	uWA3Vpz8blAEEjGljO3uMjklpbIixns5QOWouninLu5cgtkPyBPG8Wdil4WGPlhDgdMbUNmNCCG
	j
X-Gm-Gg: ASbGnctEOy8hc8THjipGQPCofWgyN/1lZq8vhEQLlfChD6y5oOcV/Uu1cbVkvZNShka
	50c4rsaXKdBvANcMt1DaqCyBjTArXC7Y5X2cKUuteAC57rq8hbXGx0MjVQoUR8T11g/gtIyEsWP
	vIy2jzvjFfIiRqSz7DCENqLk8kUgc6zmBikKUx+CDIaXamkoaVgErvFWzLyN1ia7gaKz767sjGM
	IhM1bid8cTCW78sxv7N7RcpWwhhfHtNIZRWWAy6nwpMucHD5fxr6XcJrL/3+ZCr79UpilXq19rU
	nwEzq9y4GeDD51kXsnFE9azerNOG+9lEFowbyTgrlLIA9+RhhRThtNmnhfbcblD+sRmCDg==
X-Google-Smtp-Source: AGHT+IFbVQhJwSkPdeUcM7vR5ySJJL0jZw9Iwd27lwxb42PTwJPBiUHo3WoLRWY6uBCoTRNc+OIrBg==
X-Received: by 2002:a17:907:3cd4:b0:ac4:169:3664 with SMTP id a640c23a62f3a-ad218fa9075mr249743566b.33.1746783321767;
        Fri, 09 May 2025 02:35:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:20 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 26/37] ASoC: renesas: rz-ssi: Add runtime PM support
Date: Fri,  9 May 2025 12:34:31 +0300
Message-ID: <20250509093442.4015145-27-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18878

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 3888672495fcaee98b90196c0a899b1c2eb57d5b upstream.

Add runtime PM support to the ssi driver. This assert/de-assert the
reset lines on runtime suspend/resume. Along with it the de-assertion of
the reset line from probe function was removed as it is not necessary
anymore.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-16-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[claudiu.beznea: use SET_RUNTIME_PM_OPS() as RUNTIME_PM_OPS() is not
 available in v5.10]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 507ba55b9b9c..2e688889653a 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1148,14 +1148,13 @@ static int rz_ssi_probe(struct platform_device *pdev)
 		goto err_release_dma_chs;
 	}
 
-	reset_control_deassert(ssi->rstc);
 	/* Default 0 for power saving. Can be overridden via sysfs. */
 	pm_runtime_set_autosuspend_delay(dev, 0);
 	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable runtime PM!\n");
-		goto err_reset;
+		goto err_release_dma_chs;
 	}
 
 	ret = devm_snd_soc_register_component(dev, &rz_ssi_soc_component,
@@ -1163,13 +1162,11 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					      ARRAY_SIZE(rz_ssi_soc_dai));
 	if (ret < 0) {
 		dev_err(dev, "failed to register snd component\n");
-		goto err_reset;
+		goto err_release_dma_chs;
 	}
 
 	return 0;
 
-err_reset:
-	reset_control_assert(ssi->rstc);
 err_release_dma_chs:
 	rz_ssi_release_dma_channels(ssi);
 
@@ -1193,10 +1190,29 @@ static const struct of_device_id rz_ssi_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rz_ssi_of_match);
 
+static int rz_ssi_runtime_suspend(struct device *dev)
+{
+	struct rz_ssi_priv *ssi = dev_get_drvdata(dev);
+
+	return reset_control_assert(ssi->rstc);
+}
+
+static int rz_ssi_runtime_resume(struct device *dev)
+{
+	struct rz_ssi_priv *ssi = dev_get_drvdata(dev);
+
+	return reset_control_deassert(ssi->rstc);
+}
+
+static const struct dev_pm_ops rz_ssi_pm_ops = {
+	SET_RUNTIME_PM_OPS(rz_ssi_runtime_suspend, rz_ssi_runtime_resume, NULL)
+};
+
 static struct platform_driver rz_ssi_driver = {
 	.driver	= {
 		.name	= "rz-ssi-pcm-audio",
 		.of_match_table = rz_ssi_of_match,
+		.pm = pm_ptr(&rz_ssi_pm_ops),
 	},
 	.probe		= rz_ssi_probe,
 	.remove		= rz_ssi_remove,
-- 
2.43.0


