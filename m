Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFE3CF65C9
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:44:25 +0000 (UTC)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16763.1769420655475145953
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 01:44:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZRHNr2Oy;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.66, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4359249bbacso3378457f8f.0
        for <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 01:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769420654; x=1770025454; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F0wnLdF6XB3eNZtkM2rN2tlDGGeiGZ2wUC6Ue25Uvc=;
        b=ZRHNr2OyywqWS6G6BtbcPfvjdqvl0QMOAYJOBpiyXi+7y528QgKG5ur1e+xeiXdqO4
         t+irp1iX7GA5n9OxaOAXIsRITWhA33VkxOtIJmaJrkB+fGV9DmfVcWJByzcmG0FhHDm6
         HM2zfFCVQrCAQQTx6+HhEaE9VYVg2jbZGOlwVZ88ujQlRHyt41yo4tdtC4CB1lj0LL+D
         yDAwAvqaVntgNkr6sOY0FFZpSOSFnzy4AhXcrlW4aBshi028iyezPJUbfkkSx799fE5H
         mwnzrk9n08e6IK1w6KODbglik2IhyU9Jzk24b0VsrBqNymJh9atxFYN0hCsCqKlGzvZv
         GhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420654; x=1770025454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9F0wnLdF6XB3eNZtkM2rN2tlDGGeiGZ2wUC6Ue25Uvc=;
        b=kNWgu9zQSPpAE3e52RRr116CZbL1OylDmC4piLktl3VtJtrYV5vOcCLgkCEQdw32qR
         hhjF+mup4cRH/dPYLGqPqRHo9OdUObzB+vcRZOlqoz+sZDeP9JzUJ/D919WWo0AnhGO9
         mCre7kGWf7UwROpHLIcftc0veL6l7rG+cfdnLMwlP8BIgjP4cgmsnR2QSMugKld2AHdz
         eQ5YOIjZKmj38fov6JSM9Dtyi4+AbYYcFB1dWvv4ICCGtWT7kBq64UkfESlzNRYHTzKH
         T06rg6+N7KsJkIHoUl/DZVp75XHs6vDxSpKAiWQfjjueef+x53iOPV4UkgngnVO67W91
         KMDQ==
X-Gm-Message-State: AOJu0YzU5YsVHxisgpKD3l+oh3ifaOaSzCrGo4Qi/gMWqcZrI+eOSzZz
	PSlRNZnlYyE2qI9KxFiS6o1TbPvgncfABnK61KurHvAhy3dzUfsUxDi+xMuoY3dpUfpOL8Cw2tT
	vfcN7G3M=
X-Gm-Gg: AZuq6aIXM4WMOdV5tGfpc8Mnwsj3DWI7AaPupB1rSjScE3SO51gTZV6pyWhojvc6rph
	w/a7jM6JsQ7zwT6Lfi88bR/FHf7eHstr/l4mirkPPDj6xj7o3RgHm7z9SMwZvlUynKrozLEH3aA
	8IkfFDi7J+lVKJCfaRmwEjPuzKLq3AsakEsz/dz9iqMPyUS8keEtGk1lKx+O388wzJ1mRn4xCxC
	m7AMy+LcP1rqGl49zVEVxGNWhOZflsUsP4WaAp52dzXgqdZWGXf+g2idLz50+p/hr+jVB7Hv+RF
	UIeqUBSRhQWrfamYctUDDVowJV+Kfw+ZW1jD2kgO4KRwPvXyn3sc8pqdRJvQ8RVkYLEqPLyPmDv
	c9SMKdlNhgHRkD0dMVIBk75SKAo21KAvMcdJkGtYGoQpcyU7stptxBZqAMCAF3/crB9xnJGZgTh
	I2IgYFzR5vtrjin6RXCYoSlKkKEeZkIYkLXb791S0=
X-Received: by 2002:a5d:5d13:0:b0:435:97ff:7d35 with SMTP id ffacd0b85a97d-435c9a8eae7mr6794022f8f.4.1769420653811;
        Mon, 26 Jan 2026 01:44:13 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745c5sm29675520f8f.32.2026.01.26.01.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:44:13 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 3/3] mmc: renesas_sdhi: Add suspend/resume hooks
Date: Mon, 26 Jan 2026 11:44:09 +0200
Message-ID: <20260126094409.2529052-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126094409.2529052-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126094409.2529052-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 09:44:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21719

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  3 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 37 +++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 291ddb4ad9be..ac5b0cf673d5 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -9,6 +9,7 @@
 #ifndef RENESAS_SDHI_H
 #define RENESAS_SDHI_H
 
+#include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
@@ -106,4 +107,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct renesas_sdhi_of_data *of_data,
 		       const struct renesas_sdhi_quirks *quirks);
 void renesas_sdhi_remove(struct platform_device *pdev);
+int renesas_sdhi_suspend(struct device *dev);
+int renesas_sdhi_resume(struct device *dev);
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index bc1d6a877c0e..ce0ccc3261b8 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -31,6 +31,7 @@
 #include <linux/platform_data/tmio.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
@@ -1292,5 +1293,41 @@ void renesas_sdhi_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
 
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
+
 MODULE_DESCRIPTION("Renesas SDHI core driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index ec475d427421..6ebe71248620 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -18,7 +18,6 @@
 #include <linux/pagemap.h>
 #include <linux/platform_data/tmio.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/sys_soc.h>
 
@@ -599,7 +598,7 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SYSTEM_SLEEP_PM_OPS(renesas_sdhi_suspend, renesas_sdhi_resume)
 	RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
 		       tmio_mmc_host_runtime_resume,
 		       NULL)
-- 
2.43.0


