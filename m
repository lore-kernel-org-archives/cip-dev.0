Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E7DC3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:43 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web10.10329.1746783153431855999
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Y5MI4eVr;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5fbfdf7d353so2481203a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783152; x=1747387952; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaHjyis1u7ToX/nfp5POUmMWA4xpoNySvQQE6asI7xQ=;
        b=Y5MI4eVr3/1Eu0Dft7fGVz3SOwsb1fBRAxdMfA7a3kGXrivIyCVWEbHjuDT30iUn8y
         JCLgsxiFeiVwVDLypl3+c27wR14aby9Q5SPiHCPxqXD5Ip50QNfxJL6mWEYm6k5ZS+Yz
         FdPEDtSLvClzjTr1f4xZzMAkk+HLXnVEKY9xk3i6xG4sHr3FCV2MBMPo1Igc64+uKtQl
         diqAEDw2jD2Yt2BwC9S4Wj/HyAtLCEmeftVsLwsggdbOcYzUG0ApLk/kkZQROi+A3rGu
         6SCydPfdiREOy3G3nz70jocBQLAMeN2IhX9kAXupGMeso4pfE1UpPs1sRGBluuSdL91G
         YUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783152; x=1747387952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaHjyis1u7ToX/nfp5POUmMWA4xpoNySvQQE6asI7xQ=;
        b=TOAZsWQZxtb3FxFWe4AgMKwTu+iiH+Kl8YbKuddN6fJnuHMEALJOiQIfHWJG2lulhj
         7UQJCLlMShQVtZ0Te2+fIvQEjVp0Pv5ZUANwJ2s7DMX/eJXwcmNbn7tBHYpyn5DXSDo/
         EiTJsTbAsc2IwmSz3BXp3XVHdnFmNhNPBtqS9nLJB7Q87twFMHlc7V+V//cbY7RWxSE3
         fB/G3Np0X+Vlx0XQYiKQKlj9i1LGPmLPu4VNdOi6UyUsdfTDZeDYfvj5mkdS52DifXI/
         FJtUxGC2AlY3XwB5lNvBSUPwp06u8jaXbSszfKE0x+gLkkQ9ahMbzI4BDN+P9NnFpzY5
         EHug==
X-Forwarded-Encrypted: i=1; AJvYcCX7cESIcUZfmbQcFY5I4t1/bh+Xw/EGceM8yji09XzL784rlfUfdByEi/5e0Y3jo7TNtQBnJkVE@lists.cip-project.org
X-Gm-Message-State: AOJu0YyUdh0yohRCYy/X3F/iSxb/plrA9EcWDuLy2rKOmFPALELcOPxT
	dyVLU8WSKw/uOdxgem6FD6tI5J/buhO8ZtHW9IBDJQpf9lvLSh9gQoippnzIR0s=
X-Gm-Gg: ASbGncsK2TAW3d3uZslx5oIlN+Bagab/0FFzBGTN/ZuhMJFgS50zAcpjVDE62xuizKw
	99iYMqFzEdp5remHMRb8yahd59gAovcHR0UQ7AYwaUBfW3zdOTMqPl9TL6toDKjKn8PMycR7aDl
	8dyRzaXPwGShDlyilLpSgMmu0IcaEwxDZu2QEBsaOK8AFbaUKeXKcn9WySm6dJHCv86ey29j8DR
	OsgR96K00P+J0+lL3YoK3hyC0MgCpuRHdUhA6+Wk7NYkKaa+yz+VKXiEp7RCh8BbKdcSImei+Ab
	A0egsvDokcK0cFunb65cmHebRwGdGdjDWI9C18w57qeS/6e2zKH8rwsXOwzHISo3iycwRQ==
X-Google-Smtp-Source: AGHT+IHUXZ5tNQ3Heyeiakrgt71uJnuiIeC23KaTwdMF6qJW6xqT6jyRWYAHI6OfU8QJg/OXDyYz7g==
X-Received: by 2002:a05:6402:5cd:b0:5fc:8d89:c609 with SMTP id 4fb4d7f45d1cf-5fca11e38a7mr1854308a12.34.1746783151790;
        Fri, 09 May 2025 02:32:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:31 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 18/29] ASoC: renesas: rz-ssi: Add runtime PM support
Date: Fri,  9 May 2025 12:31:52 +0300
Message-ID: <20250509093203.4014750-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18805

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
index fa32a5bd0d7b..34eb079a6aea 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1143,14 +1143,13 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1158,13 +1157,11 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
 
@@ -1186,10 +1183,29 @@ static const struct of_device_id rz_ssi_of_match[] = {
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


