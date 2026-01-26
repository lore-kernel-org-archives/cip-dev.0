Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1588CF65C4
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:43:45 +0000 (UTC)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16223.1769420620140280210
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 01:43:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eoXdVY4j;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.65, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so48852265e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 01:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769420618; x=1770025418; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlQpJImAcunZ2Ch7OWsZ4JEjCog7izHoXTx1ez73oQE=;
        b=eoXdVY4jufUdZnTOSwvBjxLdCq38pgUg0ygGWXB/y0vPyYPxwH/IUACbHfF2RNGIMj
         0ehqHPFiYAcxY/qVw4d5CjjGLKn8Ls9uEz399gXYUNqP5rWvH6VMzrs5GuRHTm7QkPdM
         4SgpkK3RWcgBnDk09CDbucDX3cDh0WoRFCp84TYtdxRCbm13g1eOk9pR6MSVFBeGuhQY
         hThz98y65xN3oGSOCO6fbb+DYhlaw01HvFsxutgcJMHB98XMmKx1owfPjduAWTZWzz8M
         Y/EwmAbJwXGC3Bscx9feZ62TH3VcqH78BEXMPmWKk8Uwo+RzHfFfZpXKgtpFsI9cnMQZ
         Dfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420618; x=1770025418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qlQpJImAcunZ2Ch7OWsZ4JEjCog7izHoXTx1ez73oQE=;
        b=Fy6o8MErQvkgKe3y91M0wux370ca80Di/aQ5EPTAR+ZYnOcd5GyONtuzGpM6bETyVl
         EWkRaMyo5MKP+zWiEobNjyIOqe7kNOsJx299R2VCdrKwOFJFRUBNN3aoq/K0HY1mbVoB
         eJ9uFQ86rdfXHiQophRc4Mp8sjgFQvUu/Bfwk91EIla14jfM1cNtvavHtLBg6r3yoZoX
         tUObJ19v3XIE3RsS/AAxzd21NyOj4uIM0qFbxYWoOO5bjxjLtVjJVEVTbwxbdHM/9t5Q
         n86/011MazyIfGJki77x2QtXLmrO2T5DhtZH0wpnbDVSP5d3cGkxSMzPkelePtB4viuX
         2Xig==
X-Gm-Message-State: AOJu0YxoVN4nlajaOe1bburgim/tQ64LEvHLxlE8zuOc0iTz/MX3TvRT
	vIeUKTCUUWt85I7ycP0A4oDRDHvAEjfNOawZsXTSO4BzVcF/A3NyRtCZ6hC+ni88fOaNE9cy6uq
	S5yBp9Pk=
X-Gm-Gg: AZuq6aJAFIcIjHGagd9ACR4mFu+u8INBwT75EjDZuSGMI4x0XXwGUuOnz5v1D+hkNg4
	yMKG0CnmOc+J+/5+lrDCF1mX8va/ZZxDnGluww8atTrGK9kF0Et7dNOvlBSS/+HZg32SLZUVzhT
	Ik5i1qg13O7XAuZxitH3fAM+4nsLZCrTpJ8L9U2pkS3gL+tf723IHeCaJ6AZ6hG+Eqzqq7bJH+B
	6w6KYn32fii1YPTR/0XO63A2hfwXt42NDvQfiCmP3LNdTj5wBot4Sn948Mps3eMsAhY1FvjCLJs
	0IUvaoOe0o6Z59oKd0+f3QJ4beSLlBCwDfhI17YeumdmxJqab1cTD2+L/AlyPR/ZFj+KLZqMPYY
	5QePtyEjPl6NLpcwy3W4OHRxexYlcOZc8I5uHcm7q7xEW4ZN3+Loa2Gj7pu1zIaBTFv4nNsZGRs
	kX+NlxPYyipXPx08grRxywIlysgE3WJcobIWftmnc=
X-Received: by 2002:a05:600c:3b17:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-4805d06616fmr57745645e9.29.1769420618499;
        Mon, 26 Jan 2026 01:43:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804daf23f4sm103692495e9.1.2026.01.26.01.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:43:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 3/3] mmc: renesas_sdhi: Add suspend/resume hooks
Date: Mon, 26 Jan 2026 11:43:33 +0200
Message-ID: <20260126094333.2528974-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126094333.2528974-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126094333.2528974-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 09:43:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21715

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
[claudiu.beznea:
- in renesas_sdhi.h: kept the v6.1 CIP prototype for renesas_sdhi_remove()
- in renesas_sdhi_core.c: kept suspend and resume function and dropped
  MODULE_DESCRIPTION()
- renesas_sdhi_internal_dmac.c: fixed conflict in header include section by
  keeping the code from v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  3 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 37 +++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  2 +-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 517c21ea9751..1c2dc8bd7e94 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -9,6 +9,7 @@
 #ifndef RENESAS_SDHI_H
 #define RENESAS_SDHI_H
 
+#include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include "tmio_mmc.h"
@@ -105,4 +106,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct renesas_sdhi_of_data *of_data,
 		       const struct renesas_sdhi_quirks *quirks);
 int renesas_sdhi_remove(struct platform_device *pdev);
+int renesas_sdhi_suspend(struct device *dev);
+int renesas_sdhi_resume(struct device *dev);
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 501598821748..6e685ecf133d 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -31,6 +31,7 @@
 #include <linux/pinctrl/pinctrl-state.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
@@ -1310,4 +1311,40 @@ int renesas_sdhi_remove(struct platform_device *pdev)
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
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 5fcf137cd877..aab2cac172f2 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -599,7 +599,7 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SYSTEM_SLEEP_PM_OPS(renesas_sdhi_suspend, renesas_sdhi_resume)
 	RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
 		       tmio_mmc_host_runtime_resume,
 		       NULL)
-- 
2.43.0


