Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA0DC3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:33 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web11.10259.1746783146852507089
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fn8kfeAz;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5fbf0324faaso3717250a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783145; x=1747387945; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qaq1sGviOwBuiCirS/hnDchv8J33nR6Up3+ap+Jv+jU=;
        b=fn8kfeAzFSoIj8q3QQ/twDnTBiN9qZTg/l5vrmyUcz+KvPNqPz1WzvuwLEv8oJiCC5
         OpHu69X+65QONbjc8s6Q9exejO9l0eaOEco5lLq2bt4s0KlNTwc5u8EjLCa8EJAkak23
         A80PZ4lzhrHyzhb/OEwsHyxVbhUrLRpt6hvTP3357tIwu2Jm7rg9kVQt3si2xpzG/NHR
         nKJe/+kD0Gjj0Cq3tt319I5cHkdeaZtlTJzh5gHpFAV4FJsCf7yQGa0g9Q6iJQngW9sa
         QzkcYVc2JuFXb/MpEqVrfPy8rm2KAmBseYI5fjfLw/cL87fHs8HnNXEv8nrts+XdT9LZ
         naxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783145; x=1747387945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qaq1sGviOwBuiCirS/hnDchv8J33nR6Up3+ap+Jv+jU=;
        b=OHwEGrUveNJaGu3QEARVpleOYot/6TvRUiFmsu/0/cuJ1seLgpAANQjgHIlW+cXD0b
         91PoDdFRnhUScryiQ+IvKVLC8Le139az0DwT629X/i7h8UvkVjw7pwTkB0CJ54dU9YFS
         T73Jq6pHlPCFqIkareQSz0BoJAiTG8842yL6YQs5l14K0NVZqFtz0ocsc5+dcep7rlwo
         h7ARKj3+uUXmCgulhXUEhyjYrtiGdbsjX/1gC3SDyF7d+sjuRNWp+OFHg93t3x3N+O5X
         LHFWqY9L85zoeyu6PmTIXv6rCYdXq9EkVCDBJN0fEdLFo1QyXcCkf+DauyrO0vufkwJ0
         IF/A==
X-Forwarded-Encrypted: i=1; AJvYcCU/t4guCuHST1z+2rdah8GEqQ0BDz/6K3iU/xiRC1tnP8Mxw1uzlOZCLbHhBOSmN4yUTJSE//fx@lists.cip-project.org
X-Gm-Message-State: AOJu0YzXFn9xBKqcHa2ljJfwWz8BChns+Gmbs9v95v8xur+Gj2NOxnjV
	pRoob+jW1T2Pzc1HqNh3vtIDcv3+eoXFK++g7t5/wp4rHSy3e+UumlTOoLBsifM=
X-Gm-Gg: ASbGncv2EL9sqx962ytQ9Y9bChL3V83n2ihvojMLYlhzCHvGfHvHbTP+IVfWj/SsmL8
	8TwUXEJuzrX991069XiP+8302tSiG6bzTRzzIO/y9HI53YGFECS6kY7srh0bBKxrbxhimv/f/gE
	7Q+378o6cqbG55ZsFR/8V1ax927XWIpZUKdwi+LBu15hE9rOKIAqRDE4v+sxC5TR7eDj0ExxfO4
	bB4BzYvWsWG2RlGs9RXgLd8X63JB/1fSsC45HRoYUMf64CLbnAgFwQojbxeLFxw32wprm1rLcc9
	s6dV5i+Y0prmt3waTBpqbohD9ILrYlHSwWoeXTP7hHH6D2UXyoLX0sNZX2OB1tPrC6eZNA==
X-Google-Smtp-Source: AGHT+IE/lHYBNRX5joZmU8QXx7jqFUoJpAnFYLiPpXSqVpwbxSXRDsTkMKJ6LoOIwjZXtYxkS6osJg==
X-Received: by 2002:a05:6402:27d3:b0:5f4:5a6d:20c9 with SMTP id 4fb4d7f45d1cf-5fca035dbf6mr2189284a12.0.1746783145187;
        Fri, 09 May 2025 02:32:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 15/29] ASoC: renesas: rz-ssi: Use goto label names that specify their actions
Date: Fri,  9 May 2025 12:31:49 +0300
Message-ID: <20250509093203.4014750-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18802

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
index 15c78222647d..037a5b476a58 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1088,15 +1088,15 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1140,7 +1140,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	ssi->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(ssi->rstc)) {
 		ret = PTR_ERR(ssi->rstc);
-		goto err_reset;
+		goto err_release_dma_chs;
 	}
 
 	reset_control_deassert(ssi->rstc);
@@ -1156,17 +1156,17 @@ static int rz_ssi_probe(struct platform_device *pdev)
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


