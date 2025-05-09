Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C56C3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:33 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.10261.1746783151335906059
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=cil34gv/;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fbee929e56so3562896a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783150; x=1747387950; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+MDPIA5x+sdTX3RRWF3umLbgzfCyKz7iOetsDdpmIg=;
        b=cil34gv/O+EKs4FvkSB+p4+jQ9uip9Ut0NhqexDFxwM8eNc+TMYmWRwPars1IOoV1X
         dwf82ME6pirzff6HZXMxBSRGe+s45dDu28vGVlFaGdAnAiNeo9JM7BOcUHfguCyRlQlL
         bUTpxhZv1XTS0guLYN94FPGpR4YCHbM1r1S4uzIqhgSIfEJfMIgOW5n4GJtz1/4i9Ar+
         Y5zHnS7dwBkXsORrdRR2Crd3n1Neu+Hgnf+WRrZYo4zLsJhF0pADa+uX9T/atyAz4wKp
         +rsdWIHbfBHtg18H1SpBkjwxqiy1y3oXZbQ/SWGLEIgh4VT5oMElG98P5UPQLYY7bGf0
         th9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783150; x=1747387950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+MDPIA5x+sdTX3RRWF3umLbgzfCyKz7iOetsDdpmIg=;
        b=Xs2ZHtwhiJiI1LFmkRSACoK77T6m3IVn+XKhebszfCC55f77q55nPZZM/YFgQl9twd
         g4uoRNamgUNWj+o7GKW6wrOPU8yQHkWgvuccvS+3aq++6ijuAYYi2ESU3q6cOAcG/2d+
         o0DAz5z2fDEm1s06d2JKW5+UpLqHHGSaVkPq1jNqX4czBy+curYOvBLcbeZsZlhRjulZ
         Kmm17rWZIs64bC6kMRwEdf7HscMIJG3l9rhWV34BPFwrX7/P4fOQRKNJkKu8ngQVfD6A
         q774oDVHNIBhCa1thPI9kI5FTbTFexVMiNwhxevbAfCN51gsX8zEgjIZrEoBTIdGu4wh
         T1cA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Y18NUh6tzZxWgYlwSxc1alMckAMyDEqA3oiYoulOiggs9zAkwIUUn5rJA5kqxJS+NjzBGjfl@lists.cip-project.org
X-Gm-Message-State: AOJu0YwNs/tMV0td39vPleD25dxzo+hDUr1x+YLh5X7MMvrh2EKrHkLi
	6gUl8vYX+4Na5sG8y8PKRCn12uP2Yx+JwyqQgax2kSvQWCUl2c8yP3Z7zkWo6pE=
X-Gm-Gg: ASbGncst3FqW0yC6VTilFV9tOUyJgNz3WEPqal+zre52zmGscH5iMJwTHEm482stkRX
	Ik6AOVuulNvJFmo2/oLoIipsO71YZTcUxPRHuTBkKLheUOpz6KWTrWrWyk/F5r+7now2i9MHZeK
	RWvhVeUqHst3Zms0Y9b1M6VTWJyOwkqsbM2r4SzDGBloGov9i1g8kjEGBfunnLl9D1NGoZfn/P3
	vi/7QBKB1ft9Ni8jkkjPAhitX7hBtcyui2pUjWXU8G1U2f9GhEW/M2mKKOe+2YZXa/VWhhrLjCp
	6Zv1LJF3qnn5lkk8kOmIEDH8JeopZG1ypj8VzoG55l90zR2QmSF7FPmINoSaV0ujaB+/wF1AWqq
	FP6/a
X-Google-Smtp-Source: AGHT+IEMNx3RP5B5bxIHISYdSDEVw2M6fnpLvAGpNffPh41j+CYeWe5m0Dk6iFfW00rchFkfdxICfw==
X-Received: by 2002:a17:907:a38e:b0:ad2:11a9:43d8 with SMTP id a640c23a62f3a-ad218f09fd5mr259190766b.23.1746783147483;
        Fri, 09 May 2025 02:32:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 16/29] ASoC: renesas: rz-ssi: Rely on the ASoC subsystem to runtime resume/suspend the SSI
Date: Fri,  9 May 2025 12:31:50 +0300
Message-ID: <20250509093203.4014750-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18803

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
index 037a5b476a58..868b734eba65 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1144,11 +1144,10 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1156,15 +1155,12 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1178,8 +1174,6 @@ static void rz_ssi_remove(struct platform_device *pdev)
 
 	rz_ssi_release_dma_channels(ssi);
 
-	pm_runtime_put(ssi->dev);
-	pm_runtime_disable(ssi->dev);
 	reset_control_assert(ssi->rstc);
 }
 
-- 
2.43.0


