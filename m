Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD18E77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:05 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.104362.1734524576725840309
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:22:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=gWyLLnVQ;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434e3953b65so45144345e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524575; x=1735129375; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWZU9u9KGM9/toaLraaZHb4O50yaoNfe/2yq1mKlP9g=;
        b=gWyLLnVQ2f6x6CpPw2e3y4LIrHQ21ZdLbFXUaOZuAw/UUC0ABQq4mjxoCufFmH7NuU
         1yLiLt9RS5IusaWMIW45IsQEa7S2H4gU/OkERc/weI3XgG0o9Z463A9QczE76RQ43vkh
         kAenb3BNVQs8WbXJzxGAgRfW1Vnrz1NKvSjAhpsFvAUA8PtIacgWj2raSUEA+NOW0T4e
         Nqo2GT+sXZqxIG28XJJ8D1zCj+0+ukfZZpYsJ59Q6KXIsOtdr9PJpniVOg8zqZQ5lYDX
         NHnoboJR0c3MGK02lJLDE82l/ZDGvsi0Aekl/IQxQvPNyEEi7ePb3kWl9MwxcT1XS5zj
         sMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524575; x=1735129375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWZU9u9KGM9/toaLraaZHb4O50yaoNfe/2yq1mKlP9g=;
        b=TJqWR6Iwic/g/lkg43uLSpJQxWewL7FslPZB8f60qStvAg6uGJNG9Ysib/Shta5JMw
         fpQe5qShZqoMZ/yLzwk71ugdA8hMDg28LsnEvrAjMpMTiHnnv9YbOSNFd8dGaEnH2oCR
         ntwXMWtEbgVCKjCuslAlOxlhlnLw4QI7uEugnqF7FUfo3Alm8x9KT1IEr8aq1oFYCmBz
         eZvOgPuKUE8Nj3IV5Gj8klBzePiOWreWQzFDmnrO9M2H9JWX2AQ+/pAooSlkGoH3nfB3
         jaDTIg6fzfy5ceevs7WLrCojDb6xD+TiUnymtWjPeioPhV903ZU9USu7ivtfBySNFAjU
         7VnA==
X-Forwarded-Encrypted: i=1; AJvYcCXqn0hnKdZCNUR4pcm7yxDmmHT2oU9a7ra09120F1I77SjpiIFk6owZUSchFUwdq0U0jgIUIj+C@lists.cip-project.org
X-Gm-Message-State: AOJu0YxJnuKspbl7N2kv5caqHLE+xByedc2Y0cMEdkiDL27MhahdZmpN
	bZnLF3PvHiIZVC3FABvoCchmdoxoJYn3Xdl1q37WyoMeGu5jZ/5PxHU3XBpqSIY=
X-Gm-Gg: ASbGncsBrlhPU2o2nTb/qo2ZqSulQYg4hvvp276mYB/sy9mefcaOE4th5sn9iURvuU6
	SCWodmjEm7myQpgbXPxmV8tFK04SAID1wx7MrCCxXfTpUg9oV2PnKIT/PdaTK/kPHrpridG5KHz
	tQ5SFa/1v5veojHrCdPIxjglxARmXavjTabUmkCL6TwHGAR4DZWCeoMDnb1PtHy5Dq/DaIyOGi9
	VhUic7+Ee/sxbBWN6i0MmwhiZaEbUBtuULl/bafqCCtwOyu1u5QhTIst0l6Fm8PL0gCC2Vngu8o
	mLCzjzlRgn0=
X-Google-Smtp-Source: AGHT+IEl0D5XrqRRwhZminx8vCyLa8iUe0dLlKTAOW6O86UKTDJzbpx0dr4qlMOuIDzaC8N5UPOjog==
X-Received: by 2002:a05:600c:3ba3:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-43655426a25mr19333715e9.25.1734524575039;
        Wed, 18 Dec 2024 04:22:55 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b2dsm18790365e9.12.2024.12.18.04.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:22:54 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 6/8] watchdog: rzg2l_wdt: Power on the watchdog domain in the restart handler
Date: Wed, 18 Dec 2024 14:22:44 +0200
Message-ID: <20241218122246.2365189-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17450

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
index 1cf7360d7d48..71b81c8c570d 100644
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


