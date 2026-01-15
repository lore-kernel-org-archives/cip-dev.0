Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D52ED29FFA
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:22 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31309.1768466174714884372
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hv4taAe9;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so1044375a12.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466173; x=1769070973; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3qHi8NH1X041G4M6x0jR2QhEvLGy3ihpAm0uUJAa0Q=;
        b=hv4taAe9KJMzhI6JSgOpkpeXHd3ht+f4lomwvoZKhyy9NUi1l7Ih21bt7Li1aZMv8R
         ibqVovIBQmG/fnBKwLrimUtTVO74EOuFrB9Mulb25wO9tHB9Bm7YCk3K/9vPENRfo+tu
         iHuBJ2FklVybibojfA9XYRKVtAVTeT/Zk7mKSog2a+vcivWJ0PVLWnTuDm1nmztKBXJO
         A+FRZJ9AhAkESwlnfUQzBD+cL4lrozsAG2CGsm1r/9ixjRJJrM0tASQN1apN3KVw+hZH
         wjP1NvnGrUUgSbU/8zNxdpRWWYnciUA1xvhIXfR7GbP8ugEsCsBAGFxV8PpMl/20v3VH
         vtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466173; x=1769070973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v3qHi8NH1X041G4M6x0jR2QhEvLGy3ihpAm0uUJAa0Q=;
        b=r3SFjQnMNIRtIXNl3imbclhLLJgmUoGVHm58HLMPosqoUgausR5ZwklTNyD2JMtHXP
         iilcA37JesLx2EdvQFuDS0yFiCOfuVR5hqigqeqW4m8t6I7DKsnxUt2dl5vHIcLJr4Ek
         AwgcqWGK+yguW4cY8iQhNxPAUQC/iRIH7lFBbXFAA6EChGaSlv0Mf5y0uKSUEBuaJ7kO
         Px6siKc/0n5CooiO75LTmOolYdeh5dyUsw8UDeRDDvAPJ7tjLnC57Fqdi7GByoheuVC7
         XNXfGxavWT6ah43PQ3HzI5L3yFhRErmssK8cz/XrzXXDpsNpkS2UswALEtg4KC8sIdG5
         AAwQ==
X-Gm-Message-State: AOJu0YyqjUuk/N+sfqN8nKLKD7Dw0Uso6Jikbz1LPD6VcvqKfvW5LX6o
	lPOnh20R/ZTtLPdITUDdqsHHuTBE4Dz046jSgRhSyVpnX90t1SBQtsrYvfW9OedAlT8=
X-Gm-Gg: AY/fxX6xq2GOIESTcf0ROY2WuCZwsYe7S+XNAyf5Fa3/0p6AxQnFQopIArYB6C1Ga3V
	414wtvn2euKX5hbHc5nlOHERR4cUPKcmCc/Fiy7O6j3WaVori0k4clPJHll85xm2BjyCxTcVC76
	v01uTDQgHfxOmfJCKGzM6BnVqa7/sOiOHxGj1m2vV1dQGTAps8feJ5albIt6OcYlTXxHYy6mcz7
	lIR7qpk604GhwEd8nABfXiADRa8RJTSOQ0/q6lnNKfsCEQNDPlnqNww5e70dkFoiisI+pYmvUqM
	5HiI8lIAdMIdb2QeadNsuf8QT4teEbA6oSRm+/bLpmYLtjjHj3TF+rG7K5cp2R0IvmQQFCkcGTU
	iQlvnElCzXKqTc4AeXbK34wMmv3zj72ySpomruxMI9QKQgLBd82hzX8DK4qCTrX23547POO3e1u
	dvJpO3qTNUiIONoqKQYZOwvlIDQfFLihjmK4AclO6UwD8Wwif1Hg4XIZZjPiwT2+D1gw==
X-Received: by 2002:a05:6402:40c3:b0:64b:a1e6:7fed with SMTP id 4fb4d7f45d1cf-653ec114587mr4276809a12.8.1768466173114;
        Thu, 15 Jan 2026 00:36:13 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:12 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 03/19] PM: domains: Detach on device_unbind_cleanup()
Date: Thu, 15 Jan 2026 10:35:47 +0200
Message-ID: <20260115083604.1064260-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21603

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


