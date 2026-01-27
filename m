Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506E5D2F010
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 12:57:39 +0000 (UTC)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10414.1769518649231068218
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 04:57:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GENqmCpx;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.66, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4359249bbacso4183325f8f.0
        for <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769518648; x=1770123448; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubVdd6GVEV/jpIpIxWKmLNjW8bUaQkB1uVL/rlg3kgU=;
        b=GENqmCpxHuDAJ/rDeGP/5Kl6NOWLxatvptsi+PV0xCnO/leoaMkceR2g41QcrsBs8R
         5A3Z/k8CKSrTD5ynomCQWfe60SQ685OF7JVxcT4Geie/oZFg2GHjdSG/SlglrRHEczYA
         +pbVpU6hfsy/w21J83J//FqvQdEUaD2r7tZQaYPHO2rBWF5ZaLeqFP3iKm+rVYmSTfAd
         8hw6A4FbblyWgOEPq86Mdhlvw6759UvQVpuqCTXlqFur0rgz1n+vlPATjXbeKeg0lieL
         cjI52E3EYT+PJGHF5HHqcOJt64o3gCD5alzUmsFm2Y1IqONChcZJ0SGInwc38r4y5Lme
         dM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769518648; x=1770123448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubVdd6GVEV/jpIpIxWKmLNjW8bUaQkB1uVL/rlg3kgU=;
        b=r435FdXWFomQ0dWKypxnk3Pmy7wXtjGLouMIUPWa8m/ma4y5ZYNrU5mLOnn3QKMaEC
         rfeeRIwCT43rW6VvizwmgTWldASvrLjTaXM5nKq34pSCrtErrWJtu8+HMv1foRFONDzt
         bZY3GA7uCMKg0gIFVEotW7zDOX7FNH97yav9qrZZHFgjvQnxoYnF6N2qYUKuZ688eyXo
         t+bXaepvO2N2WnrQHB3c2Q5b57Ns1qORfGNSYKCvfM8FL5Ys7ZNymW36qrMoHsMBIyj3
         mlpfRKxYsoXqiOyoKejSrWZBO0MdAf8OwFPpVQ6qkUmCLzfEkOcoOtL7IrdrjwRoyflI
         Bp8Q==
X-Gm-Message-State: AOJu0YyRDuxxP+o+r2r2leiwSecnqRFP7A/1uuMvqq/nRITKiFtlh/Bo
	oycs9uI0h5S/+5J3Bc1JP9NILxSQq5aa/SXMNs1qEDuY9+vloqBGvXw9nkGYFiX+Bek=
X-Gm-Gg: AZuq6aJcv8giiYDWMsvBHqeFIeryLLmPQV3hSDV/FGhpeLVLrNiOrRgpJXc9g1+o9SC
	ZbBsNz5zyU3Zjj+Krjwd/E9zC+lu5Ng/sBF02gieOgQ8gNdYREL6eBvc8rQPQMJFTXoZMI/4E/0
	aX6iSrK6RE0s4UeYlwtsOZs/zrSgd/mDLzuKjmBfXaVPEscggUIWnn2ypm8FG/8S5cpSK9yTa+f
	zg2XiQqqaV0rOiHEXgV+ugaeYAvcOqYThGgoIu5U57Lxcvn/eKM2c+NK3b9HSGs/LYZpKIEdUg+
	4zRKWwtOM+55M8zTTX163cmL2EGTVp9mdp80GImO/QDdIvt+9Ow97pTEedHqTvCmNoO7ciyoZHl
	+IOeQhgtsShML1y6q49+mc0Y46vhqpail+jbeXp4aXQz63tAIt95C8Gst2HkBjRmThudRd78KQj
	FbTttS5xVWJNFiwg7Mo0hZqwtULhCG/yMEWhpCIWM4iBmvoFvfng==
X-Received: by 2002:a05:6000:1787:b0:435:9a18:5a29 with SMTP id ffacd0b85a97d-435dd1ba13fmr2622293f8f.11.1769518647612;
        Tue, 27 Jan 2026 04:57:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02ba3sm37089738f8f.2.2026.01.27.04.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 04:57:26 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 2/2] mmc: renesas_sdhi: Add suspend/resume hooks
Date: Tue, 27 Jan 2026 14:57:23 +0200
Message-ID: <20260127125723.3705611-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127125723.3705611-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260127125723.3705611-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 12:57:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21728

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit dcbce328d3a2d87770133834210cf328c083d480 upstream.

Add suspend/resume hooks which assert/deassert the reset signals, along
with forcing runtime suspend/resume. This allows using the driver in
scenarios where the resume is done with the help of bootloader and the
bootloader disables the SDHI clocks, resets, IRQs before passing execution
to Linux.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea: adjusted as follows:
- in renesas_sdhi.h: kept the include section as it was in CIP v5.10, kept
  the renesas_sdhi_probe() and renesas_sdhi_remove() prototype as it was on
  v5.10 CIP
- in renesas_sdhi_core.c: kept the renesas_sdhi_suspend() and
  renesas_sdhi_remove() definitions
- in renesas_sdhi_internal_dmac.c: kept the code from CIP v5.10
- guard new PM function with CONFIG_PM_SLEEP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  4 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 39 +++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 53eded81a53e..15e9d62a2b0e 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -80,4 +80,8 @@ struct renesas_sdhi {
 int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops);
 int renesas_sdhi_remove(struct platform_device *pdev);
+#ifdef CONFIG_PM_SLEEP
+int renesas_sdhi_suspend(struct device *dev);
+int renesas_sdhi_resume(struct device *dev);
+#endif
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 7f80190713b5..efdc7b8fcc61 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -32,6 +32,7 @@
 #include <linux/pinctrl/pinctrl-state.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/sh_dma.h>
@@ -1249,4 +1250,42 @@ int renesas_sdhi_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
 
+#ifdef CONFIG_PM_SLEEP
+int renesas_sdhi_suspend(struct device *dev)
+{
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	ret = reset_control_assert(priv->rstc);
+	if (ret)
+		pm_runtime_force_resume(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(renesas_sdhi_suspend);
+
+int renesas_sdhi_resume(struct device *dev)
+{
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	int ret;
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		reset_control_assert(priv->rstc);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(renesas_sdhi_resume);
+#endif
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 17d693ba90b1..3720f6fb01ae 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -422,8 +422,7 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(renesas_sdhi_suspend, renesas_sdhi_resume)
 	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
 			   tmio_mmc_host_runtime_resume,
 			   NULL)
-- 
2.43.0


