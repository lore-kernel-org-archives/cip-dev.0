Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4EAC3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:54 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.10376.1746783232522758291
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YpOadeex;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fca7c14715so812783a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783231; x=1747388031; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lOp3PDWRodGvbrwENKOXtZolJ3EMf+F4OsMVx31eeE=;
        b=YpOadeexCJNbtjDCjWbxmm/S8YvkRUbgSHiGgQcuL1sQURJcSQGXQmxmQ3usAxKAuj
         JR1t2RSU1K1y54NkJpapAUbtUh8/Duen4wUAfznHu5nGS0fpgOFqekRyQQ9s2TEP1L+V
         7ZNm0Yj7QcN8+TPHM6mSlWH7DZ6yadrfBWFWyl+BBLPmSIitkeIW5ca8qusrBnDJPLfD
         mL0jdJmTp2VPJKHz6MTd0M15asDGgl425qpw0jlMc07NJupK5ehPjNjOS2qVAkQfhuXd
         ChJAV/7IKcAqo0qaiEAurxPCGmrI3jcaO7v+V5rFZbzm9vJ4leTgh36+q4EnlKs3SLVr
         G69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783231; x=1747388031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lOp3PDWRodGvbrwENKOXtZolJ3EMf+F4OsMVx31eeE=;
        b=fMtM0Ntl5gSb9GKx7qRaRAUYx8VsitpuOjy/EgB1DBc4UadjaWsWJTnRVcY9yzRw8s
         VZ7QJ5LnD88GXkYfLvzsyGfk73QvKgWWp3dp+lklLUQkD+kf32FZdIk2xw08/uynxWc+
         tjH3y8SANtZcR7RaZ8NLTQEdSf7iJ4TH7Hh2i3WDYm63XMWHTr8hA+qE/x1cOfJK+FYy
         3hcRVmPjJ40rYflxzWFKMt2SwHbXY1NdJpsSFSpttZJ2zmzn2tGEuazy5rMbOw//PCbL
         fWLgxA6ta8cfnEk77DvsidmhUAXbslOO+axp3cx0G+ySUx131/MZvT2Yd/LuRYr3YIxT
         lNEA==
X-Forwarded-Encrypted: i=1; AJvYcCXn7lI4CPtw3ItChdel4wbfw3YHfiMDF19okz1Ftw8s47Kf/JPznf52p62R5bu3UnVvfrU+diIK@lists.cip-project.org
X-Gm-Message-State: AOJu0YySF1Ce+XLWvamhj0ncXemnXB81xRTXE/1HJhsb2nr/7GTkrWl0
	4G1gsg0Kj7eBwN3oR1TlvOYgZljvMBOZxgBV1LWP+JKCKKR0GfE2LTNxTM9YpQNQ1W0QbONDQuC
	2
X-Gm-Gg: ASbGnctpv0JpnAIaztZy+rDIpAaGbHrNgxR76EaIBBDHZKORy+5p26/rc2OjDI2R2jI
	QAs+UEbFlix1vFGazSscaJfvuWFwTqwSkmNPZUrXdkd7KeD8DGubOtqWKsDPz/6RDGE7XyhMlrq
	HU9lR6eiYq0DtATOslF1SaHIRIUsqkLDx/Fh4aqQGgkQfkFDZJ/7APNjMcKdYBtWbzIyaYqA+Ss
	zsTS1p+pfzDcAKHjP1aTjZQ8l70lJM2CIOJGBBQYZr/hwZecTpJXblGaUaWti2iOsUktepr3jQb
	aT5Pq+kngurQJrP46RtBGZYqwWolzEDPeJdRv0kIzsYEKQQTtzlXDx5RdFWsTiizimN+jA==
X-Google-Smtp-Source: AGHT+IHl73eQhlaSLBoSggD8zSpgohUrBhzuwJWMEhSXcqUblKndyE7lsQKNvink8XBGdJCogA/pOA==
X-Received: by 2002:a05:6402:510c:b0:5fa:f7ee:191f with SMTP id 4fb4d7f45d1cf-5fca11df2c5mr2231752a12.32.1746783230962;
        Fri, 09 May 2025 02:33:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 20/34] ASoC: renesas: rz-ssi: Use goto label names that specify their actions
Date: Fri,  9 May 2025 12:33:04 +0300
Message-ID: <20250509093318.4014916-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18837

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
index 0fc7ede4d392..611b8eb6d8c9 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1096,15 +1096,15 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1148,7 +1148,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	ssi->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(ssi->rstc)) {
 		ret = PTR_ERR(ssi->rstc);
-		goto err_reset;
+		goto err_release_dma_chs;
 	}
 
 	reset_control_deassert(ssi->rstc);
@@ -1164,17 +1164,17 @@ static int rz_ssi_probe(struct platform_device *pdev)
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


