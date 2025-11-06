Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C1CCCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:35 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10100.1762416747406528123
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P/pYJCaC;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429bcddad32so464906f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416746; x=1763021546; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aRbN84XI1WPz3RfTPMzI3pUCjwKsN8zHlmK+/lo+xo=;
        b=P/pYJCaCDTY+gZhC53x/VbqXIfpL85KpjdTrnaHYoND5sgEeRLA3QWbbg+n8NwAIOR
         6Koub+T/eSPn9RPEm8LMWncAYX53VlEvFyt430pHuKiE4Yy8m3VqbgLX/543kTm5lnyl
         BWPSDMZFgH+Fy3ugHLAaDtwx2eka+ZslVOGBQjWi7U+9dHJXAUtH4V01xtvkkDU0doFh
         IyQaZHOBRZtlByj5CdWmPxfNjic14tLeokP0z9lhDJBB0A4z6GuEeN+VhgDe1z+SaPIm
         IQsTPrPumYPUrB9YCfhiv/LbdZC0beyCWIQcylK2LmcEDcq+BqMQ8n2ww0ZodsPrNEvA
         Itlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416746; x=1763021546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aRbN84XI1WPz3RfTPMzI3pUCjwKsN8zHlmK+/lo+xo=;
        b=Nh8lfR6bDwJDWH072Ff/860TuDcXlEDHEIK9bZrn1MgI8EtEegb8067MGQfq7+bnhb
         EAsVkPuwMuccTgfsdYtu/OoIc9v4NXxxci/CNDysa9Vd29YipuQeZA5toianoS8dLjyY
         XVQVHGpAQBmmyRAOPcnR6W+4cEaFfOWFK4cN8EWWHgearpZ1M0t5kiF4K7TMBjPEq01c
         jIZBBBmsLB1esYnoZ59g7rbScEeEw5S3z3gxEcz3ZO11PPkwwwnbvKTwWGVrtccu+kNL
         m9pPgCQJacZrX6rgcdJdV8f6OfVFcMO+MJn+LotswK25GsUChcimqHjR9APiTmSnbLnS
         6F6A==
X-Forwarded-Encrypted: i=1; AJvYcCW+Js8g9+MU9Og4rGgDRftWLTbzZ926p6Zry+Wi1xEgofpysOlGJHBv+UIfWLo7W2dBs1Efcufn@lists.cip-project.org
X-Gm-Message-State: AOJu0YxA5goKKB3LVArC9o4bvDat3JEsSx7Bho9GkaWC9g8CvyI2XLk2
	R6uqAyfNYDZLBVxdgcKRhn9ORplH672QqsdlUaPDBhw+K4wX7XLe/Au3kP5B5KYR3Gk=
X-Gm-Gg: ASbGncvSaxIePbZtMyPiao7v/Y7CI7gsPnmGpmSpy2X/7sKj4/zHZpyhTQRTtF7oxp1
	9YJ8L42lfLRfPap813OJRAls/aOCkff2Z4v2apxqOu3gM8TkuLe4MmZeX5qqbKT1OIvZmuONAt1
	hJM7A2UkAtjFhtCnvOIL0lNCvZHLq9IG5cHiSU/GkVd0I5NqrTdlv2V3e0jGa/f7ugjLBfUyTBx
	fMc5/XglX1MHhDx/iJV7MBSENWO6MEV0ufTO0MUAIYLgnD9tsiuS6YNPq8hUOrFzTaLZD8zo6YW
	R4DHGndCzijlcX5GfBsoCWfPQPP4dkJongTQHdoDrVg2d/Gv3c3Ng8njTt1bt6MtiLrLokinV7q
	l0SozcTai9OeB5Bjsi0MhPpywmRmIEhBlV1159qlBGrjAYAt7uKA/4DTgn6QnUEt222b+UKe1zB
	5jGmGit287xGOzCVSKOr8zNwgch/EtZw==
X-Google-Smtp-Source: AGHT+IGRJ2CJSdXwIJ4WpMAjFwuBxVH/0PUTuttQ/u51KXZ8tdX7hE0RtpmXoBShPC0xklGuDar4Hw==
X-Received: by 2002:a05:6000:402b:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-429e32e3662mr4935413f8f.14.1762416745703;
        Thu, 06 Nov 2025 00:12:25 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:25 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 04/22] PM: domains: Detach on device_unbind_cleanup()
Date: Thu,  6 Nov 2025 10:12:00 +0200
Message-ID: <20251106081218.2574950-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20421

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


