Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4578C3ABCF
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:04 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web11.10310.1746783236583287317
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CiBkOF1z;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f4d0da2d2cso3337690a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783235; x=1747388035; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gLaqSvYvz+KVxul0WTQkHptzePqo/2yXN+mEZLwURU=;
        b=CiBkOF1zagOTt6u6Y3m/kp1Rg1FNll3jSRRIfwmieFLw12AN/VdhKCxBCRl3OZilTg
         mZ5nGEe/kQKFtJDKdshPEf2ARhoCV6BnXHyxCuW5Qm6H/2h3EryIh6ZeYcF6Ig2thaBG
         ptD/p0+M3OunOJ6ulP2tuiKtCJm8YKquSiJm9I7lTE/5JSdJbuwgTB1wwbWwLPfp1o18
         CnMzhVJ/BSJUsy6Tzhui7QkKTOp+0R2m602Asp098jDNEjbN8hAMCKabN91BVaO7gRf6
         W+FCKFcfRB5MJ9bQ3dR9y4LiMOaqFiBCyq84TzRw6s1kLGbBNMSEgfA/oXGxyCSE2npq
         ZYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783235; x=1747388035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gLaqSvYvz+KVxul0WTQkHptzePqo/2yXN+mEZLwURU=;
        b=G3wlewaGf1t/X2BzmOP5GaGGlL/stgHZIU1CjoMgjjvdoQgm+/+pmLUo4TlYGqYlqM
         VDYbyu9glGPfy5K5PQmxCL1/Ica979ZA4Ig1hHV79WgMH4fD4WlqOBMdE2POF7Z1dlf6
         LIqIJ6/NrAlObBK/Osxhv5/h/v9NSsjtbGukoga0DVPTmLB2Y9zHgqXySvfYkiLvEM++
         8UYWjQfY+GxMfS+peW3zJZbhygwMk7bNa7ge3xjqAqFesBMXctufVsBeEZqSDoicQZrT
         MQGmVuHutWpabhhzJnKslW17hQBq2TluWMbxzLFOAZyl9SlwgX/U/scC9qIp+B6vvVKY
         lhqA==
X-Forwarded-Encrypted: i=1; AJvYcCUAXU/7uO2QoWffB79hgYrEeylsP6RWP02O0/m3jVM/vjxIAfAiykq3f/n3MHqvz5aC+SUlh8ex@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy+2snbdFEXSGXeGhAaLWvCpm6QmJsdOGci2yTz7F/sklOz5aEx
	scs4W6PqZg4lev47X+1H2vgcGM3/IDFnzLVO4H2Ue3YWGBxbwAuupC+W2bz27VSZW2q7keadswj
	s
X-Gm-Gg: ASbGnctTM372srX0IJqr7rMK8Yu/4XZ90OsyjunPQDimSOmkk9dqUizZnNKI1ArL+WO
	3zFA2OZRFFS9cnKRWVgAxzZjzKVREgM78GOoxUTqjrQXJOb+8zkdeGpSKlBFtogHnioYoTyQeL0
	BhBDXOzrx2GkJrPno3vUdlFjJcpA16c/VxxCRb2TwA86vkvlhMMp9X1A/3b8z1UBaQb8yYFT3/R
	KBSQH8V64B+wcqf6wPVsdFvHkoagt3UR0TMGITOVUrh6X+0q74i6n5XLfG+Yech3B/UmS9f6jGt
	cRRcXkU5/dWQjub5AK/CmNKQf6w994RmsL9ggUSZSTK9FX9+fr/Ugsa86LJSUZHXNSpIu1h8pJI
	EeysG
X-Google-Smtp-Source: AGHT+IFbO/1Nwz/5yA4JjmLLEPVNSpmxyrQKIxI327NJX26rqsZQr9k8tOJVdPK/5n/DlmJdvzkaoA==
X-Received: by 2002:a05:6402:3484:b0:5fb:455f:ac40 with SMTP id 4fb4d7f45d1cf-5fca073078cmr2095633a12.4.1746783234966;
        Fri, 09 May 2025 02:33:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:54 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 23/34] ASoC: renesas: rz-ssi: Add runtime PM support
Date: Fri,  9 May 2025 12:33:07 +0300
Message-ID: <20250509093318.4014916-24-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18840

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 7692de807e3e..57c3fb48a7af 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1151,14 +1151,13 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1166,13 +1165,11 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
 
@@ -1196,10 +1193,29 @@ static const struct of_device_id rz_ssi_of_match[] = {
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
+	RUNTIME_PM_OPS(rz_ssi_runtime_suspend, rz_ssi_runtime_resume, NULL)
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


