Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92402D29F88
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:48 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50852.1764872139619325592
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JUqBynmK;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so8970955e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872138; x=1765476938; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW2/xr5QBH49HVQp2Kp4nvtzi1NKKr/rsqg2nM/fj+w=;
        b=JUqBynmKfVmvSGVPaQpJhLM1Dx2QV5Lq8Fs3WGWJhgADL8WU3XA8Ryc3kr15PpKRf1
         fDm/vQWfm+QQqcSQagZR0/Wox+zxdTZXQ0OBctvmyGV7p0bAu6DwEsb+GieN53bvM4FW
         SAbnu7GC0YUv+mcCImd0oF7jSIZKV35VdCveyxGdagpq6+OUkHLQK4xitSlDNep4UAD9
         gUwHox2NQtA+GfaJTwf7F3/j+v+XdBXoaLslOOcfnRAjinujsi8Yg1ojMUsaFt9DWnzk
         Sp44l+EFkvQ93lsytz5rU4PWCm7l2IYaWULgHA4zo2cbpgl+/05CkoQGIGKu160CBvCX
         w9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872138; x=1765476938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CW2/xr5QBH49HVQp2Kp4nvtzi1NKKr/rsqg2nM/fj+w=;
        b=A4RzGer0Pma41j4mf/t/yRVL0/TiQnUi94yJxIwfxSd6YUGwFvEYOgEt3Ysmad4x0d
         8wtajpkJVH6eIs+Ls6mQ94ZU8AgWBStwKqBG/VVXu76BkUXlu2CMb5eck6MAY8IKGj6v
         0T2O0nokMspzZ/6NaUn+E3Q/bnPYjCR6BJwS/recl5odgVjH6MwKO7PUhFtUArMS3fLP
         VT+i6S8poQ8a506dgHBf2yBTrzbeXd45zqljzWW5b8kY6qoylMhYsYrFlqGIuIcbVAHf
         3r0THqOn8ER3YRSAm9qJ7dqxeZ0E1VVuFDkz1blkdyDHnjyxl2inZJvGQRUjk59o5Zzt
         KVOA==
X-Forwarded-Encrypted: i=1; AJvYcCV50jSEkzLATqDLr9BIO+GgyF3PPq6U46E3KsvqIoMXKO1ylfqULkKdyNaK/J3wkBhTrLILgdbt@lists.cip-project.org
X-Gm-Message-State: AOJu0YyRLJZ2ladlGCtLt0/YsXylVAUam/NnrmVKxNggd3vjHgwJXAmO
	tzCT2nmBNkk3LUiNgplvbWBUm+vLeMa98DYiUp115cWZCSJz1pNS/ejyotw3hvTLDv4=
X-Gm-Gg: ASbGncsSpIeMDJ9lOFBeP8Jr89CZYOD2Byy5P1gOTH96H3Cm4iXmqemmImC8SlLjoGO
	Noch4pLjwwVH7eoXQrmVbz3fFwy4r+3YLXIiewdWxRxt4fDTuIcXmeT/i8dSzlxkWpRfppRF1KN
	g88GHVySbR7VB17KcyJB2bmeEvf9FpIG8IflvCZ9lJlpPcVQ/7SrKlT4G4vHGmLHEeprc04nwJf
	IemDxLpwjScojMiJxF7Av2D1/fhXEvcIxXZ3gJBp8GyvMZN6lxoMin02qG0yMTgsyYgM+H77Wsy
	GBmYI7SHrHlGEXQomvUm4HpnvDHX4iOkgPEjJxcluHwJLGp7Rg826qy7uMFjgzZp3ZfAlARkaO4
	EOIYKNPeHx41HJPjEgYjHtKPWRuw24hFcFzN1x6i4b3c4oNAa3dbN9HW5H5tHYeKBHvrafOadCT
	0++ZT2ZFGdCpQL4y8dtK0kWBc56J01dqAwjke0HRoj4LNUvSzGkEE=
X-Google-Smtp-Source: AGHT+IFBorXe8AaZe03igkBESIM/Ornrg5lGpJB/O0Cq3G+nVY9VdYsHkNFHo0ch7SnJ0Np3aLNiiw==
X-Received: by 2002:a05:600c:5607:b0:479:2f95:5179 with SMTP id 5b1f17b1804b1-4792f95556bmr32238315e9.15.1764872137951;
        Thu, 04 Dec 2025 10:15:37 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 04/19] PM: domains: Detach on device_unbind_cleanup()
Date: Thu,  4 Dec 2025 20:15:15 +0200
Message-ID: <20251204181530.689132-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20870

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
index dbbe2cebb891..8a1aadd0dc3f 100644
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
@@ -533,6 +534,8 @@ static void device_unbind_cleanup(struct device *dev)
 	dev->dma_range_map = NULL;
 	dev->driver = NULL;
 	dev_set_drvdata(dev, NULL);
+	if (dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, dev->power.detach_power_off);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index da8b9af9d798..f1fd50d0efb9 100644
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
index 93cd34f00822..30420441da19 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -692,6 +692,7 @@ struct dev_pm_info {
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
 	struct dev_pm_qos	*qos;
+	bool			detach_power_off:1;	/* Owned by the driver core */
 };
 
 extern int dev_pm_get_subsys_data(struct device *dev);
-- 
2.43.0


