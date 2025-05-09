Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B81FC3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:25 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.10421.1746783318319392856
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Er83/GnM;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fbf52aad74so4678930a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783317; x=1747388117; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7KSRF1KJl20yDlziN5We5gCT7IGF0Fg8Q5UtvXYbio=;
        b=Er83/GnMgJAVTGiDViHGy5k8g9sB6SenplT93pgPkt2AbtRb4nJ3edMkBka2+RxNmq
         T3LpFUYAvn7Slb2ippzEasBQTbtGSrtcVaMC80xodpgDQVZbnW1iHv7wzf2cVlNImBg8
         9ZGTHDLtXkeD38gEjxxgv7Z9HtoYXKnL38fVyiLeI1lfMFXVE0s8L9My0B5iT3JvTGWA
         qA47Donx7QQcE8Ddxp1YxMewd0nrGpMscC3FMnbtXdcvEAIwWnfzeY3jCVVCbnnrQDzk
         uBBmWiTUQ8g7tRC2friwfHGUjZnEhlFt0N55q2yVrTDqlPWPlKsHA7l0X5LgIq/jvMmU
         xEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783317; x=1747388117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7KSRF1KJl20yDlziN5We5gCT7IGF0Fg8Q5UtvXYbio=;
        b=eR3lBaghOF5UFgUc/OBXW8bFxd45ZqmnnLVqp9FylTFz+8lc7blxDRQLeKi/3CPCz0
         R6bNqq8KNpCt6zVoco4EBwIqVXIXiRwR/ibcu60BRZEZ8GS54Jzzf4oftEYUun8zPa9r
         2OjaSymKKoIKZIyYXyoZGXP39sxlAqUWJ8IN694k5FgMHlNageLVS3Pp2Flm1dIULwHS
         V6nRuB9eHT7Qdy0CDKLfOjpX4RrXBAM/4FxrXe3b/MB2/7bhYB6OwWLvq3HpOwDUxL6B
         w+EmD3lUmm+a4/cZEV8ENQRbaEc+0gxqg/kQYrdHrj1x/xTgHGpQ/2JDrrvy4b0CmAQh
         3EKw==
X-Forwarded-Encrypted: i=1; AJvYcCVmmWskBkIDtG0ezoJReYOxcWWSpXwMLTO3vutIOrpbc/Npq3lTOEs7MMnx5EmlWUqG2mVaBpb4@lists.cip-project.org
X-Gm-Message-State: AOJu0YwNbjzU8uxqeSeHjVwPkiNDTlr0YrBCXdv6k1ILM3n3Wexcn6XI
	2fmP4T2eNhijuJegE1ZPVn9gPfkevtwyyp64BzsZvohGYp2TTRey+uCgHnWQxeM=
X-Gm-Gg: ASbGncv/ftC+XfFb3qWcrHE6/fyI8kOp9uyhncBWSpBlPlzOf+jPpUkKFF7a49lHmOI
	hs5DsteyyA6/KEte5dd4Cay9nuMAqnfE4zuEeEvYsp+tvi+/KfVFeUuTRWDNrO05Tae71VKAmkX
	G4OTtRJTlATXus8GKkrtwOvrLgBIlLNQn7K1N+SnZb5/E+DFkfYy86z1Za7/dxV9t6TXbyO///R
	p6GfvHxPg1X1JuW4H5dLEDpqNh8zMCHlGtJclRYzEOPCnZMAp3CwH4XRQBx4nyFfaDi0TiUtzIN
	mmcxVhiDgX9RO6HikRfjxgpVaPhyJb4zxxbG3ktiRsMrtEeRjCeroPrVwGo7DONGX3SwYGmUnlr
	Dur8L
X-Google-Smtp-Source: AGHT+IFupaSbJXBMNXs5alqGlZkVsfkTpc81EYm8+mpyPLnbyD3fLPydWqM1uWKL7sHh8f9gSAnsPQ==
X-Received: by 2002:a17:907:3908:b0:ace:d077:3bb with SMTP id a640c23a62f3a-ad21b14a9cbmr195637566b.1.1746783316708;
        Fri, 09 May 2025 02:35:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 23/37] ASoC: renesas: rz-ssi: Use goto label names that specify their actions
Date: Fri,  9 May 2025 12:34:28 +0300
Message-ID: <20250509093442.4015145-24-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18875

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f0c155c9da7536ab33687b5207eb21e704122a56 upstream.

Use goto label names that specify their action. In this way we can have
a better understanding of what is the action associated with the label
by just reading the label name.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-13-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 64fa773f2ea2..042ecd20006c 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1093,15 +1093,15 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	/* Error Interrupt */
 	ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
 	if (ssi->irq_int < 0) {
-		rz_ssi_release_dma_channels(ssi);
-		return ssi->irq_int;
+		ret = ssi->irq_int;
+		goto err_release_dma_chs;
 	}
 
 	ret = devm_request_irq(dev, ssi->irq_int, &rz_ssi_interrupt,
 			       0, dev_name(dev), ssi);
 	if (ret < 0) {
-		rz_ssi_release_dma_channels(ssi);
-		return dev_err_probe(dev, ret, "irq request error (int_req)\n");
+		dev_err_probe(dev, ret, "irq request error (int_req)\n");
+		goto err_release_dma_chs;
 	}
 
 	if (!rz_ssi_is_dma_enabled(ssi)) {
@@ -1145,7 +1145,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	ssi->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(ssi->rstc)) {
 		ret = PTR_ERR(ssi->rstc);
-		goto err_reset;
+		goto err_release_dma_chs;
 	}
 
 	reset_control_deassert(ssi->rstc);
@@ -1161,17 +1161,17 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					      ARRAY_SIZE(rz_ssi_soc_dai));
 	if (ret < 0) {
 		dev_err(dev, "failed to register snd component\n");
-		goto err_snd_soc;
+		goto err_pm_put;
 	}
 
 	return 0;
 
-err_snd_soc:
+err_pm_put:
 	pm_runtime_put(dev);
 err_pm:
 	pm_runtime_disable(dev);
 	reset_control_assert(ssi->rstc);
-err_reset:
+err_release_dma_chs:
 	rz_ssi_release_dma_channels(ssi);
 
 	return ret;
-- 
2.43.0


