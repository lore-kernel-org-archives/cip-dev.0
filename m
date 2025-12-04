Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3C3D2447A
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:28 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50476.1764872064071125591
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=p/iyrmoA;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso16555735e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872062; x=1765476862; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aRbN84XI1WPz3RfTPMzI3pUCjwKsN8zHlmK+/lo+xo=;
        b=p/iyrmoAjd2zmDYtDvkqoOounV4d5kltsvKsNqfngdnNHZQW0/hiNnWQCBIiBovtdH
         +34UDOgpdQ+De+64eNyD4UqFDVL9Is+FG1/9i20Mpn1QNSICttUEoiO5hRm1NHkPeOBe
         o2IrXH2gJcYgDr/Sj5b5V0uL6pwXEtp8l2nfGFtAnXXEML5s5CiN7N1s7D+Bp1DfbmPh
         Fx2TYIrcPHtO3GQ/9QZ8Cd+6fHYwhUeoBVI3h7Yjnd4/G+1t4lItlbErIR5WciF0s+Zi
         NyqE9gfml5TB4gMyGn7R5UxEtLvOFSFhdTG60f9mRFF4tZh/CmeBbrQc8ARtb2c8mqfG
         SRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872062; x=1765476862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1aRbN84XI1WPz3RfTPMzI3pUCjwKsN8zHlmK+/lo+xo=;
        b=bcEg5Hu5hhr5oHmB2xuhn8yIG6esDMIlcRdeNU34Q2FXUE5v7XV6GX2FP2nQxnI+7P
         EY2F56N+kb83vqCjnsLyjYK3/shVLI0VukTc1hyrHbMzdfFpBIoZYKYBq2Gmt3Ymlc+F
         dRuk6dxAHK7aOeqZseUMuYf7HQRPZFcN0/DqkPPTpOoi2xbNn6GRUtwKQ+sTjPv5V1QH
         tunG5Z+5RaVf8QDrD/3YWnGrdwSSqUsoH4+v1kDhEqSBS/l3Ceyh2+kdEdP+16a5RbiJ
         bO6EZC+Vwq6XeNGL1oOPeWJY2xFB4FcD7+K0fL48t+bGa6qotivKwu/cZEvaV31ootJX
         tgCw==
X-Forwarded-Encrypted: i=1; AJvYcCWCzptNjCNPEMEi51yP66Ixz06E+UX4FqjrjXeEhVTmBJjKqmWw2iW/9kmuPSSu2ttOKOz3sAAS@lists.cip-project.org
X-Gm-Message-State: AOJu0YyVY0Fg9bOJccGVVMiIU5K/JF5MLYWpLhlVBfM/GPc9/ZYI7bFA
	jISDhDUl8s/VvZv2uP6H0YUlPOUHdc1Od1c2YiKK7cjCQ8CRdBZTLk+EeJ/VVM5WJbY=
X-Gm-Gg: ASbGncuNv4NW6fUDv5H54OZGIICkn1vf4qXqt4/5xNQa2YcQphv/htGqLtCOZFNIB6x
	xZaqilIcNMcp99irOw1GT7QVn0NQ5WgXc0dHDAZc9UWoN/aikJ4zXyE9n53xMXOu8FliJU1zJfV
	rGFQ21qHN6wqxy4guIB6JHhIPUcz5KjV5zV8hZ89HoT9EQUNm1T5eHBCSKqdNuKlY47Q7PgwBSn
	UWbQsquKgwErRMr2c/altXGdBVK8MQ1yHA9oGaJqyrsyysOOOtHUKYPlpBu2rq20JVzWNR9uAgW
	vn2dTUifnmYMKydeLaH74dZSe7//QdsF9+OthPdywFxRearNXXdniTHvY86jiSGGATVDoP+j0ja
	lfNKdKO4koyD/sYt2OCBAo/9vZYVKdTknBjo9dILFk439ENVECVaBKDsYYjR7XvI4DHRUJlvuhj
	AHklIkyCEI63s/ChkzCEnVGhIGLXrQfpUZKhvzYiZFgiZ0jiIxmeg=
X-Google-Smtp-Source: AGHT+IGUPOpVuxr/YWH/Lj0XaGCBZW0/hrXt7K1GCD4b9JhM/ECOgAp65Di2kITIjPUyBWL1+E9pvg==
X-Received: by 2002:a05:600c:470b:b0:477:9c73:267f with SMTP id 5b1f17b1804b1-4792af43afbmr73077515e9.33.1764872062262;
        Thu, 04 Dec 2025 10:14:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:21 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 04/18] PM: domains: Detach on device_unbind_cleanup()
Date: Thu,  4 Dec 2025 20:14:01 +0200
Message-ID: <20251204181415.689009-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20851

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
[claudiu.beznea: adjust dd.c chance on v5.10 CIP code]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/base/dd.c           | 7 +++++++
 drivers/base/power/common.c | 3 +++
 include/linux/pm.h          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1e8318acf621..f8313e42ad82 100644
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
@@ -596,6 +597,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		driver_sysfs_remove(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
+		if (dev_pm_domain_allow_detach_on_unbind_cleanup())
+			dev_pm_domain_detach(dev, dev->power.detach_power_off);
 		if (dev->pm_domain && dev->pm_domain->dismiss)
 			dev->pm_domain->dismiss(dev);
 		pm_runtime_reinit(dev);
@@ -634,6 +637,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
 	dev_set_drvdata(dev, NULL);
+	if (dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, dev->power.detach_power_off);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
@@ -1193,6 +1198,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		dev->dma_range_map = NULL;
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
+		if (dev_pm_domain_allow_detach_on_unbind_cleanup())
+			dev_pm_domain_detach(dev, dev->power.detach_power_off);
 		if (dev->pm_domain && dev->pm_domain->dismiss)
 			dev->pm_domain->dismiss(dev);
 		pm_runtime_reinit(dev);
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 593fb5bbeb97..e58dcfe1f0c9 100644
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
index 52d9724db9dc..a5354eeec2bf 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -621,6 +621,7 @@ struct dev_pm_info {
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
 	struct dev_pm_qos	*qos;
+	bool			detach_power_off:1;	/* Owned by the driver core */
 };
 
 extern int dev_pm_get_subsys_data(struct device *dev);
-- 
2.43.0


