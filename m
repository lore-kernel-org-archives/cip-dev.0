Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827F2C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:04 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.10377.1746783234493031544
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=VeX2IezT;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fc8c68dc9fso3344823a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783233; x=1747388033; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Cz6MSpx7OSia/d2O9Ex5jLUXPi69XFJOqdwos6zoZU=;
        b=VeX2IezTrdg6kCtm53jCZWFwG/45jqjYAMKLPLVpTAhrMh/VH+1yByfirqxJl5bczi
         urk88joFgtDtD6+6cWs4EgxF7mtxv7oiRzsQAOyrGc1eIpcZq3A5JVk2xH6dvyGJxpqC
         sA1JoxVD3lq6/kqQE7qMNzXVdIdx1cLpgSPhNTQrdGBJPk2J6W664SdMmNFm79Sfe5KQ
         xeG9dIbCLlpkrQj5gK+ZWaHjNlABOQgyIjRVMplwXOPX8O8CCuFKia5ZXH83XW2pVtfK
         BlN9Q4oXRZmiCrMi5rBFZW33uNNb/qK4nz2SjtVckWsrL1AvLajHWTxk/4AsTVcMiBkA
         3nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783233; x=1747388033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Cz6MSpx7OSia/d2O9Ex5jLUXPi69XFJOqdwos6zoZU=;
        b=dkiqhx0HBM7kLprvYgvhOt+ydnJCT/FK81nlPelE7mOsWwRcxxxrZmUKs0kVZr3r5c
         J59GrKQfEG1JeUaBkihKMG9OjNhekZPJ9KHimvEWqYWZ6KZH99ViGA+MR3q4YttBdi4r
         U5p/LW1KMImyd8Nw4R1hwL/w1Ra8VqiYFIS71Q2hgj5v9SfX4N5G9SFhijFhYZ+6f/pn
         GJoGx0o9NrsigoBHoQ5WD0ydwydJbS1DFudXG4bJ7NE68Rf7tuAC80GCDhJcnWwCS0Ho
         LTLVA530imu3/u8kmzQ+KrZu9RLjpMBetpFaKHhyIzeEq3QjID5MfYcGg8H6m3RnRfJu
         wVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBKsSR/H24eD3wbUGCZN5VPNj9ozPJi4y7TNHOPLlQ50jzOFStyJJanddrmWN7uZp1bflSd/aQ@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz+Mp5fW2vtPbCvGXAezsKBEW9O/wzfv0jH8xvzW3zOrBj7pDVu
	NbyF+GSvN9+sbvc7wK4rn1dScZRFLUt8sDFgPZbioYwh1QC6oWMWx6eq4EOlhlvCrD9ant7iyF8
	D
X-Gm-Gg: ASbGncv47SPOtuzZb5vMr0Mq2h3l3mZ54IfWIEUvpfOMzMg9W9UK5pqCrTZEAj7/P14
	AHiXI/lRKMIPLNx217hbTpPNCgSiJqy9SMBjA/YVRKOsVjdaa5SPKm4wBkv4/MII+bXHUn3671c
	5Y9zjw2nUa9sIfjIltH0v9LWNs5GitBwYMNTrXlaglXNKWE6BOgkwCzeIXRqrgMQimnmGp2hY25
	nDRD/9t1xp3/9eqxHbKNSrMNBrmKE0Gw9fMGO/o0IOcvOoto7Hkc2cSHjhsT7Ve/qT6S9hRMzuv
	skzsnJFwDlZkEccS61PcIdLnoWignE9MfLeAOui/GaT+Wm0elA7wC4FVHK9GQOeFoJrJszTl7J4
	wDVPS
X-Google-Smtp-Source: AGHT+IHIcB1EMz1b2qVuqkyPC/7Py3P4E+8fIn9EB8h2dN/vZHXSVNjPTvMHZnniv1yJUYSSnwFMVw==
X-Received: by 2002:a05:6402:27d3:b0:5f6:25d6:71e1 with SMTP id 4fb4d7f45d1cf-5fca035db93mr2274226a12.0.1746783232692;
        Fri, 09 May 2025 02:33:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 21/34] ASoC: renesas: rz-ssi: Rely on the ASoC subsystem to runtime resume/suspend the SSI
Date: Fri,  9 May 2025 12:33:05 +0300
Message-ID: <20250509093318.4014916-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18838

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e8fcf25f562891d5c0734d4f49c44bb6aa72bc15 upstream.

The ASoC subsystem takes care of runtime resume/suspend the audio
devices when needed. Just enable the runtime PM on the SSI driver and
let the subsystem runtime resume/suspend it. While at it use directly
the devm_pm_runtime_enable().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-14-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 611b8eb6d8c9..52449f406448 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1152,11 +1152,10 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	}
 
 	reset_control_deassert(ssi->rstc);
-	pm_runtime_enable(dev);
-	ret = pm_runtime_resume_and_get(dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret < 0) {
-		dev_err(dev, "pm_runtime_resume_and_get failed\n");
-		goto err_pm;
+		dev_err(dev, "Failed to enable runtime PM!\n");
+		goto err_reset;
 	}
 
 	ret = devm_snd_soc_register_component(dev, &rz_ssi_soc_component,
@@ -1164,15 +1163,12 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					      ARRAY_SIZE(rz_ssi_soc_dai));
 	if (ret < 0) {
 		dev_err(dev, "failed to register snd component\n");
-		goto err_pm_put;
+		goto err_reset;
 	}
 
 	return 0;
 
-err_pm_put:
-	pm_runtime_put(dev);
-err_pm:
-	pm_runtime_disable(dev);
+err_reset:
 	reset_control_assert(ssi->rstc);
 err_release_dma_chs:
 	rz_ssi_release_dma_channels(ssi);
@@ -1186,8 +1182,6 @@ static int rz_ssi_remove(struct platform_device *pdev)
 
 	rz_ssi_release_dma_channels(ssi);
 
-	pm_runtime_put(ssi->dev);
-	pm_runtime_disable(ssi->dev);
 	reset_control_assert(ssi->rstc);
 
 	return 0;
-- 
2.43.0


