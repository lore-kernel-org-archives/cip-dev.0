Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8406AC3ABCC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:44 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web11.10300.1746783223322467670
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=UIOhdlUU;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fc5bc05f99so3292729a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783222; x=1747388022; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoQNPj1MDPxiwU3oDeV0EoMyUy0kZvsdz2+rSntMRTA=;
        b=UIOhdlUUifdUFZnNULaPtaCIr4ZaMkY44yZwiaerpJoJhFdqvG1ob09vEtZd/7kb6t
         gSZTxNeGLbTag8eG71xJGpx8QsMQ/p0DgsKJrTS7xsvAoXe002BLyDGa+tm0YE+NMl0f
         A3JK2iqO8v8+sz5P/YaJPiFXvYK5SOMJHK97ryUgbCo1BgMysfqezUaMdNOE3ksQnSK4
         d0D9s4xgMK7HoHdy7Imm+Ar7ogJlZFo9szgcjnZuYCgbNG/x9ORrNEsW1HGJVLKIrn9e
         JWXb+3FsHzyxdMsu4Wbt29GfdHhbm57NMesIzTnP3dEI//3zi4j/fOtY4D6xkATVV9ZD
         GxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783222; x=1747388022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoQNPj1MDPxiwU3oDeV0EoMyUy0kZvsdz2+rSntMRTA=;
        b=lddFBmroF9oFEOVHbi3boDiDgGHp9ClI76Lys7sBwcaaRUEdD+yD5SKv4wZzC+DYuD
         XVi+DS15Nbq7+dzu0vFCV0ojpF8KVewX/ncKKn3RU3927FZ8a/7CbJjogqMIJ3xJs7HL
         X4uh2H2KGBOl+4tui8NchjIXS7Tt/XPLE3wOMYqAPa8PyjVfcOxirU5lQS3hRntNtr5Q
         /rvOKyr+CoxH9324Yc9AHa470dQHx2lDFd8d/FrczDfavv8LDpybDGLCN8C+3/2pu2S0
         NsZGW1RPkakAfr2wuucQ1qE/DPRSIGvm4JLSmLZLlNbectuA9SeSA0gv0y/pTlf0vWbA
         DDig==
X-Forwarded-Encrypted: i=1; AJvYcCWkx7hcKAEJNTfW34RG//bUntOC8S6WUW305h3pKeejyH3761xPmR2/FB8guj3qUpnVMXr1zuk2@lists.cip-project.org
X-Gm-Message-State: AOJu0YzY4ppbroUL1vmmimqCRMcyCh2cRa63PGmtyoS0bjZlRv4ZROqz
	HTSV6K3ZoBvQIxbTTlYtV7zufslL5Ukydkrv9TQ3aGiThTH8upG5vcS3nsmsxM4=
X-Gm-Gg: ASbGncv87IBvauNGK13DSXNuwwrSlaHZtIZuapdXkW4Nwa7KJw2tvPj3Dpb+Abhu+ou
	8jR485no27o59kcpTQO34Cagft6Z89jiBKxL/6ZqVi/+zb7n21/oFvYo/f+NqaNHCm8+N2/4t3K
	Qrx2do4r5zKgfKFGelN3gkzbnmaGNDllIw2/Vsz7hv9r+JcjOvQfukoUZndNJAwWRFP/6J6bKks
	WYfi/poX35kLsGj+EFWoZw35RtiDuyyJjfuCBSE+0OGi/JRoFm5831wD0ECzZxML4eawoIHGXip
	aWdlNa+ITSmnQxTm+X9uVJeWc6QwzPkaPIohJ4+MPXu/wQsHHLDDcZxTN/KtCheSez7dHg==
X-Google-Smtp-Source: AGHT+IHF3wFRAnmMdOX/FHMqqDIIbRiuHl7rVffkMypzYlnIhUvQ1pi0p+/7j6XI9kvcEbhtI0lpnA==
X-Received: by 2002:a05:6402:35ca:b0:5fb:87a0:6b5a with SMTP id 4fb4d7f45d1cf-5fca073132fmr2107814a12.1.1746783221716;
        Fri, 09 May 2025 02:33:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 16/34] ASoC: renesas: rz-ssi: Remove pdev member of struct rz_ssi_priv
Date: Fri,  9 May 2025 12:33:00 +0300
Message-ID: <20250509093318.4014916-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18833

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a73710a25808a585a2bf0a8325eb16fd6a2f370c upstream.

Remove the pdev member of struct rz_ssi_priv as it is not used.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-8-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index f9436153109e..88f058921e1d 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -100,7 +100,6 @@ struct rz_ssi_stream {
 
 struct rz_ssi_priv {
 	void __iomem *base;
-	struct platform_device *pdev;
 	struct reset_control *rstc;
 	struct device *dev;
 	struct clk *sfr_clk;
@@ -1048,7 +1047,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	if (!ssi)
 		return -ENOMEM;
 
-	ssi->pdev = pdev;
 	ssi->dev = &pdev->dev;
 	ssi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ssi->base))
-- 
2.43.0


