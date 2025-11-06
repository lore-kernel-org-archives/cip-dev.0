Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0720CCFA1B
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:44 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10033.1762416702250096435
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=f1BSPNTK;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477563bcbbcso3059725e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416701; x=1763021501; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW2/xr5QBH49HVQp2Kp4nvtzi1NKKr/rsqg2nM/fj+w=;
        b=f1BSPNTKDxKg4H0T6rw9vQ+ea0a8X44MlAl1PDrffuXoLgrYAD1H10r6Mh/+Hd2P6C
         Cu2Uy4+MsBNdXv6B6F9p3oobLAEjZzSjymryAIVKPN4zDcy00Os9pJAtGJt9mE4JkDom
         IFYIFL+dpPpgeVc4/K/H5djo0HyGNvwbAIrPpt8sEUOH9ZtZsOHB4jseVaFzU2qT6fTB
         gZqnxwk9twBVICJsQiwh8ZqgqAQviBv9oT4dtzq/ihQUaY8dDi73K3CriKVaIP+K0Mlp
         lkgwLq0LgqffjlbJVdsNuy38upwXT6JwQ9JBGF0pHrgCOCSWMdB+uGy2PPBn/vYFE3aQ
         6f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416701; x=1763021501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW2/xr5QBH49HVQp2Kp4nvtzi1NKKr/rsqg2nM/fj+w=;
        b=Hu4KRGwsCXuEb+985ODUIVWTGN3qlN5v6NH/r8T9Vi8nuIZiEQ3vbWWXBfCTMOVCUC
         HS6Agx7eP44KgNMfry4X9wekOQnCIYfh8CPJE8yVhF17IbiTiKZF2KWFuAE6rlmGxaJf
         8KnVmT+R0zPPR9xtdrWR1VErY2lPVTrGX7YMQe8PfrD/mi0mRCOqm3CjP7nvFczSkMqw
         wXDu4m99m0fcoUSnhbWw7qTpsjcwJ7FQD0zfoNg649TiTkh7lVXv4dwS9s8bZeZv3kFK
         v/aQCli+/9MBVefwcY39xcsr6LzlGv4U5wQXkGBZkCxbPPqWcc/51ReWJlG+MqtpSXHl
         e1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWGc2pTqW4rdxicpSLdq0bOBOpt5BY4PA71gQ0gt9CVudC4xAh8oznk2ZO3mVBne79uHuFvBLUh@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzy4V+3oHgb5bl27mWLviVLLtH611xqfDB4LVc5qkMskOCwmdeH
	GmiqJJLjmOukZyvQCIh56m9Lqy/csVfh04yQBrKrot9RZq3JYGtTwXDAf4uUpY7s/hA=
X-Gm-Gg: ASbGncviBXg1QDMz5gt7EUeBjHDAqic8UC0xgbZ7awYxM2xizMr1xpqogWdb8ZHnjno
	55GCjI3aDud3Nv97NGx89YYEGaEEc6wV/Sz1XV+VLU3Z83+yFW/ebMFOq/LKTdo3xs9XiCDTkWU
	6pERCJH0JP3C/aXfdrmtqFUAIPFxX4kiEbNlDriORZ3/mUWsdm2sUVUWjriQj3sXufuvqiNs4qp
	8jkr7yiqlYt3x4/B8VI/tfcK4ySarIo5Q3rQh9AxqQ+4GFAqixbntGPlDAOJ1HHYOAFPD+6oi+4
	ICbABKMldg30QQ8cSNsKQMUsasxrA28wlUHxd6WFbgukozuhApxeSEQSQP7hFld4tXOz5kRYce2
	8i6+GJafmBnOBanbNzPMW4CHUlxWXjvyU8boDGDFeJB2+JbPVA6g0JrW0ZyEr85f2uLh4rpoEtp
	5v1XsTJNoH4L+8PZWOdtwyOUb6VHPbJqQO032s8UnCy5v5tZagQtc=
X-Google-Smtp-Source: AGHT+IHkfIx7DQ3hO23iga4RGCJddQzxh5cMDgrWA9qzAY8dMuiq0oTbMRoc8V1crRRrL7d3gL4G+g==
X-Received: by 2002:a05:600c:4f0b:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-47769d50255mr1112815e9.24.1762416700550;
        Thu, 06 Nov 2025 00:11:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:40 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 04/23] PM: domains: Detach on device_unbind_cleanup()
Date: Thu,  6 Nov 2025 10:11:13 +0200
Message-ID: <20251106081132.2574638-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20397

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


