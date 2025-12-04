Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AD2D29F9E
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:08 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50547.1764872167536523465
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=cuwiHxE7;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so15609615e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872166; x=1765476966; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3qHi8NH1X041G4M6x0jR2QhEvLGy3ihpAm0uUJAa0Q=;
        b=cuwiHxE7gUzD5/1/7YyAFBe962sPCshvkH0K56RIpobicfcaPTLXblMNe8FOWukzU+
         Fkh5uMiixtEJ4pvlHrOla/EBxuGbovucd3TqE8ftuousOiPB8pHuxziuCRt8N7t0/HbK
         +9+VJ7cFDrFIz9hiidSRB2vGfjDBnei7pRcX5PWvC4uNOBXbG8ek4RZuQ42rpjIUsfLI
         0vicmqyaoOhyDlJlEAijroMg72crFMIObywSmlIoena97UywuGS9DgNb3xvVuEj1lU23
         R+xFBYCR0Ma2T6P9WinC9vXZh6MoVRYGhpKckllY6bR1nPiR8XZof43jbP5MUz6Ecrdq
         D5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872166; x=1765476966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v3qHi8NH1X041G4M6x0jR2QhEvLGy3ihpAm0uUJAa0Q=;
        b=lD5KfBuEWrEv8aNz3qpiNH/bX9HR0n2BNsSHMQiUAN8zwoTSNmu5guMrSeanw7nJo8
         Ik7eRUKJKnYLRx4fZ+/Ab9cUzumqvyeEZb2YdTJLkL8pYI85NGCC2SdqTiQlSgjpTt9J
         T/vz5ayuLEeHa8Tkl05An36byGBOa8+eOHBSj661v6YrGdAbAfdg2qDpKKKAdy5h8Ank
         Gl2NDm96Fx4wZUaruLe3jriYZF/iGT0AOZ8xJA4bFyPsnjq6Aeb7nB2fiLNZvfRbewga
         A683damTswV7r2ktm0gzm/ts/a4QXcHk/kfzF49Y2hTlBadqb9IdnkcOosxhaIvgT1Jl
         vMwg==
X-Forwarded-Encrypted: i=1; AJvYcCV6JEOHzqNtl5mqInqDVWNQtYkUqYlCBKSlPMTCitM2EUwdkKwHmsWOVhA8vqRWoOtv9M1N6zuT@lists.cip-project.org
X-Gm-Message-State: AOJu0YxgcHGz7UMoV0XfDvrTsUmIrXNXB1/0T6StLi4lGSAQIC57AKUe
	M7GY9QE62ytcejCBj6hw88A+byiwhYlxAPazbfMA/t9OJYxNPRMkqdQLyD4/k6yyqcs=
X-Gm-Gg: ASbGncs1nzoTf1E/Q1eMS67xYrLKq9W269RHG4oAM5nIm20ukoUBZA7hi1HhhrgFxub
	W50zTZfEPRu0S0v2QKTK3kwIXagCwBEEWEfzlcqkyHYMQgl9hyPg7XeTbtfprz4V9DWHGB807Ye
	lgK456NmJpKfoEPN/Q+PccxHn4T9moStmngj5b1UwLz5oJv2o23wotBGiF+oZI8qgPPa4j7HA6+
	IUadcrJCsMzl+VU80+QckTXATOGdVi06NN1A824O7rZGHq3Yf99GeouogiOf5rSa50H7+hWqSxE
	xxZzTw2Xm4b/Dh7IaE/QTsq0T+qVvvBaDMH+5TFQuor0A1Xw9FE51MPGEisVIs+W2wdXUp//kWy
	qwy/cmY3oUKkGlYcFO0fokegXGbiU63Y65BSgl3TT6+eYcUPy8AzdfplOF5FWw9EgNxsDExIWoN
	h/yigLjHpXPJLaZEzUFFtzJxk6GHWU4BjrloBf7VVH
X-Google-Smtp-Source: AGHT+IEhoh9tEVGBeEWajM1tyjqCMpMsDL/so71OJme85BFM8ueXTTuO8dxb6/6PuJE3ITIGnq9zgg==
X-Received: by 2002:a05:600c:154c:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-4792f28b98amr39376425e9.17.1764872165847;
        Thu, 04 Dec 2025 10:16:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:05 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 03/19] PM: domains: Detach on device_unbind_cleanup()
Date: Thu,  4 Dec 2025 20:15:44 +0200
Message-ID: <20251204181600.689203-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20889

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f99508074e78fea17f06d753d9ef453b174ec98e upstream.

The dev_pm_domain_attach() function is typically used in bus code
alongside dev_pm_domain_detach(), often following patterns like:

static int bus_probe(struct device *_dev)
{
    struct bus_driver *drv = to_bus_driver(dev->driver);
    struct bus_device *dev = to_bus_device(_dev);
    int ret;

    // ...

    ret = dev_pm_domain_attach(_dev, true);
    if (ret)
        return ret;

    if (drv->probe)
        ret = drv->probe(dev);

    // ...
}

static void bus_remove(struct device *_dev)
{
    struct bus_driver *drv = to_bus_driver(dev->driver);
    struct bus_device *dev = to_bus_device(_dev);

    if (drv->remove)
        drv->remove(dev);
    dev_pm_domain_detach(_dev);
}

When the driver's probe function uses devres-managed resources that
depend on the power domain state, those resources are released later
during device_unbind_cleanup().

Releasing devres-managed resources that depend on the power domain state
after detaching the device from its PM domain can cause failures.

For example, if the driver uses devm_pm_runtime_enable() in its probe
function, and the device's clocks are managed by the PM domain, then
during removal the runtime PM is disabled in device_unbind_cleanup()
after the clocks have been removed from the PM domain. It may happen
that the devm_pm_runtime_enable() action causes the device to be runtime-
resumed. If the driver specific runtime PM APIs access registers directly,
this will lead to accessing device registers without clocks being enabled.
Similar issues may occur with other devres actions that access device
registers.

Add detach_power_off member to struct dev_pm_info, to be used
later in device_unbind_cleanup() as the power_off argument for
dev_pm_domain_detach(). This is a preparatory step toward removing
dev_pm_domain_detach() calls from bus remove functions. Since the current
PM domain detach functions (genpd_dev_pm_detach() and acpi_dev_pm_detach())
already set dev->pm_domain = NULL, there should be no issues with bus
drivers that still call dev_pm_domain_detach() in their remove functions.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://patch.msgid.link/20250703112708.1621607-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[claudiu.beznea: conditionally call dev_pm_domain_detach() on
 device_unbind_cleanup()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/base/dd.c           | 3 +++
 drivers/base/power/common.c | 3 +++
 include/linux/pm.h          | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b526e0e0f52d..82d1d9a9d531 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -25,6 +25,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/async.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/slab.h>
@@ -552,6 +553,8 @@ static void device_unbind_cleanup(struct device *dev)
 	dev->dma_range_map = NULL;
 	device_set_driver(dev, NULL);
 	dev_set_drvdata(dev, NULL);
+	if (dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, dev->power.detach_power_off);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index abbbcf85a5b2..ad929eae0de1 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -110,6 +110,9 @@ int dev_pm_domain_attach(struct device *dev, u32 flags)
 	if (!ret)
 		ret = genpd_dev_pm_attach(dev);
 
+	if (dev->pm_domain)
+		dev->power.detach_power_off = !!(flags & PD_FLAG_DETACH_POWER_OFF);
+
 	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 97b0e23363c8..fd4926168a1b 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -721,6 +721,7 @@ struct dev_pm_info {
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
 	struct dev_pm_qos	*qos;
+	bool			detach_power_off:1;	/* Owned by the driver core */
 };
 
 extern int dev_pm_get_subsys_data(struct device *dev);
-- 
2.43.0


