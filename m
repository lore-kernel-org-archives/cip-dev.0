Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AACE77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:35 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.104196.1734524609955047661
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:23:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rCNsqpj2;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385d7f19f20so3254289f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524608; x=1735129408; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlw3XORVxneL5Y+VJ7M6kWxkt5o4r00XhCIFwaPgRow=;
        b=rCNsqpj2iC9MijNlRJ0u/l5me1Gs4pTMvSfDOcAw5UMw9SBGGFGJ9xKQFdMI9ZJPLA
         uE1ygpzcJfBHs3bDA7FIzQeZCCwcGuF5jO6Da7X8S39RVGKAUcAmJgbfKNq0b3oxMW9a
         IORLvXC7cMgQuxDv6vY2tcGQFl9//YhZmmMn8x0kFIXU5KxEeAIQyoPmZNiaMx9nNUMO
         isYGtxYr3R65G35XbMFgduvJA2zkgdkDq4WKY18JSmXimlbpk2JjH7lLfLxt/WfF3SfW
         99mCA+NgoULuCMHdooMLYjqiuQ9fo3QBVl7pxGQtyE4XSXNOc5vWcdgE0dT7fypd8HYB
         bhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524608; x=1735129408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlw3XORVxneL5Y+VJ7M6kWxkt5o4r00XhCIFwaPgRow=;
        b=eN+6yJb58xHcl4SUeHLubX10KNVJkP3ij5fURRy2ssnwjRrXM4M4+vic56TQ6Gkk+B
         WorCHbBy7b7Iqasm6MYz4ylJ9+zHhJAMkxouY60b72Pz0e/2kSW6eTl8Bwo+DFFblx2f
         cej3bB/3qg/nJY97MZt2ofwsYm/EdFT72HYSKNTaE5Z1vK7SNEX5RbCqcxMB3Z8FE5up
         PhwR7ThZt7cHkG2oNkN1T/lCcJfO43K42ORM7h8GmYj2/q6p6wjEMIfM2J3t3RIk9hfv
         A0O+XLY/4moAUoC0PZ8yjyFVaZRsXZ2fKLPJH3pYuN38Fn1Bbl/b+BtLrk3zqvkyuXlx
         MFoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSbn7MfIMCGbphTsGzP0j0/bQFAwHZtTvgo4J78zx9xQjaLCxwfoevXKeBiEZMiCUUUi8t2+7i@lists.cip-project.org
X-Gm-Message-State: AOJu0YwqD0ZycEl3gOX67G0VbrbSd88HuGNv+ZJ6JuIlhfiHnoNTlSxq
	vnX3NruSjZBGfilkyfnBytt9SkXiIvdVSgb0jNgXSzjO95UEsQtyzZl2TO+g7Xk=
X-Gm-Gg: ASbGncvQL/tGOZp2YyuWxCfY6LWq6ZNZruMEubuIbItQyEaliCLrFCeRuz3Pzs0Gazp
	AgDDMDMCF7D1TlOQhj1AWTKnCkrS4WcO9QNSJJZ5AhBjhr24RSSVOOxBGqw/L8GMOGSlVreYqIj
	B4iZQgrpHVq+z0695oMeqeGIvQNvYcn+Ae0Wf78gXeHdIIxiwX+I8H67c6HLZx9hellrnKSfMdv
	Pt/JPLUCHpSmLTK936vwVcNXAJ7Wg01YqZ9moDRhzxpDXovX9yO2CohzBi2JwWrkiYuqUaKsAxM
	2pcJyy21zzI=
X-Google-Smtp-Source: AGHT+IEe/Omg7IqQv60ISQOz52lbNvGcmVjQoI9q7afV871dUvnSWiGxSBcdN6HG7J54uxNdNEhDfg==
X-Received: by 2002:a05:6000:1f8f:b0:385:e013:39ec with SMTP id ffacd0b85a97d-388e4d2df18mr2196901f8f.8.1734524608326;
        Wed, 18 Dec 2024 04:23:28 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm18746445e9.11.2024.12.18.04.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:23:27 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 08/10] watchdog: rzg2l_wdt: Power on the watchdog domain in the restart handler
Date: Wed, 18 Dec 2024 14:23:15 +0200
Message-ID: <20241218122317.2365272-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17461

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit bad201b2ac4e238c6d4b6966a220240e3861640c upstream.

On RZ/G3S the watchdog can be part of a software-controlled PM domain. In
this case, the watchdog device need to be powered on in
struct watchdog_ops::restart API. This can be done though
pm_runtime_resume_and_get() API if the watchdog PM domain and watchdog
device are marked as IRQ safe. We mark the watchdog PM domain as IRQ safe
with GENPD_FLAG_IRQ_SAFE when the watchdog PM domain is registered and the
watchdog device though pm_runtime_irq_safe().

Before commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
context'") pm_runtime_get_sync() was used in watchdog restart handler
(which is similar to pm_runtime_resume_and_get() except the later one
handles the runtime resume errors).

Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
context'") dropped the pm_runtime_get_sync() and replaced it with
clk_prepare_enable() to avoid invalid wait context due to genpd_lock()
in genpd_runtime_resume() being called from atomic context. But
clk_prepare_enable() doesn't fit for this either (as reported by
Ulf Hansson) as clk_prepare() can also sleep (it just not throw invalid
wait context warning as it is not written for this).

Because the watchdog device is marked now as IRQ safe (though this patch)
the irq_safe_dev_in_sleep_domain() call from genpd_runtime_resume() returns
1 for devices not registering an IRQ safe PM domain for watchdog (as the
watchdog device is IRQ safe, PM domain is not and watchdog PM domain is
always-on), this being the case for RZ/G3S with old device trees and
the rest of the SoCs that use this driver, we can now drop also the
clk_prepare_enable() calls in restart handler and rely on
pm_runtime_resume_and_get().

Thus, drop clk_prepare_enable() and use pm_runtime_resume_and_get() in
watchdog restart handler.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20241015164732.4085249-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index afc1e9f1bf04..73d92b6cbcf8 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/units.h>
@@ -166,8 +167,22 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 	int ret;
 
-	clk_prepare_enable(priv->pclk);
-	clk_prepare_enable(priv->osc_clk);
+	/*
+	 * In case of RZ/G3S the watchdog device may be part of an IRQ safe power
+	 * domain that is currently powered off. In this case we need to power
+	 * it on before accessing registers. Along with this the clocks will be
+	 * enabled. We don't undo the pm_runtime_resume_and_get() as the device
+	 * need to be on for the reboot to happen.
+	 *
+	 * For the rest of SoCs not registering a watchdog IRQ safe power
+	 * domain it is safe to call pm_runtime_resume_and_get() as the
+	 * irq_safe_dev_in_sleep_domain() call in genpd_runtime_resume()
+	 * returns non zero value and the genpd_lock() is avoided, thus, there
+	 * will be no invalid wait context reported by lockdep.
+	 */
+	ret = pm_runtime_resume_and_get(wdev->parent);
+	if (ret)
+		return ret;
 
 	if (priv->devtype == WDT_RZG2L) {
 		ret = reset_control_deassert(priv->rstc);
@@ -275,6 +290,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
 	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
 
+	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	priv->wdev.info = &rzg2l_wdt_ident;
-- 
2.43.0


