Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41925D33A0F
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:51 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31252.1768466024055850166
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=aoKiGfDj;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso876463a12.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466022; x=1769070822; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aRbN84XI1WPz3RfTPMzI3pUCjwKsN8zHlmK+/lo+xo=;
        b=aoKiGfDjebkGgvJJhaxR+UNk3uKQQhshoGpO3mgKxqwcbbtYie13x/vH74Qw3nk2z1
         MIvfsCmD0lAqdzRV4QRJUsgJZSq548nHpDPHWmZLTf0grboQyaNY6qoIOrpBwUCmuYHC
         ObDC8wNiHdmEYAtDDrlFs80hZZZ5zDLlQ12C8XFdWFnkQqSysGPLac6GDzH92flyRdGn
         KhTCCh4ZefGhKn7+Y+EibKiy9EXwKw82yNfD89n2NFJnJhc7smUxQ36MmKTw9EeCJz7I
         zL0cO09jSsTBVRNrjP7kUbzZkISVqg807G9GNoS+Lnjn/8K1xw1v/AexJQWyaLWAnC4k
         Dk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466022; x=1769070822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1aRbN84XI1WPz3RfTPMzI3pUCjwKsN8zHlmK+/lo+xo=;
        b=Z2pqAGq9Ya5r+JQbpx+4RuzTCtitvCDYJXnZ6+wb/AdiUujdyY73/PljCj2xp0Oz7k
         Hi2WRmeRDWEzbLTz19NYsh9Ih+660vUjINMvTqGQRkwtbwdc85Ak8go5V6xHyNBELa9C
         OxGbkxRjdO6gKjJOtGt8br43DGIwAyY6wmx6eJmJxA/TL9FzoyiJT8sGmsVwSh+8dh3c
         yzsOTJdo0eKUNFby6H7m1hFwaSOzv+2u9duJvtcjgnl2rlqw1Gzu55LXMrwplaUeM38L
         r+wjotY5hCP6u7gOlXC+mEZXH9E8qFJrzVQYIHaulkykdFB48pJrxLBKHZlcqRfAg1by
         2UNg==
X-Gm-Message-State: AOJu0YxP0TGZFrA+AsnKH5gh3lYIAEDKu3rH2SyakDWiQcQQo7vQJnqQ
	K+EzWydCVHCSnUawOpV/4noR+YFnavN0O1Cb8jqgYKnCFBDcvJ30gbjNcKUo9FrnjAo=
X-Gm-Gg: AY/fxX683lpFHZjBpfXmjGcIEHEYa70BsD7rS/Ao9AHrGviKxmtAGnz019gjKDa82/E
	GL11E2OamFDDWX/RxZASP/vbkwj0NeLlgut3u63nNGgOC8FMBt1iqtO6deeWfmAJ5BQx3k/Jk5H
	Gng22UmIiV4Zst4uGD3v5N1rA0cbdu4VkTxrfLHaoSd1VpDfqdkN9Z2vqOjI3Mnw1vaUjoerLlP
	rOzj8JbTfdd5yybwTg3jgvJnWXMjZfTa3b9GiUNZcHJj1YnUe5oWu9WHiQIWkoz287Luds+m+jL
	6DPVXoJe4Cd3KxyxhHcRu3PrZbP7YRL8oyAQ3z51tEGbkEJk6y92jZWgHin8SRgqvnNKVLRnPKW
	gz2ngEPKg+0WNGTgP45BLSfgEb1SLYMqaeff09NHYn5/ygY6AKo5T3rjonhefvcORLcxsg4GQeU
	ZWiorcYP5vR/4oqbSSkBnuSpcVV5dyK66BTpDOLkH350YgGZaC0IwU+oaRtXXmgep3xQ==
X-Received: by 2002:a17:907:3e04:b0:b87:2579:b6cf with SMTP id a640c23a62f3a-b87612a49b6mr368237166b.41.1768466022375;
        Thu, 15 Jan 2026 00:33:42 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 04/18] PM: domains: Detach on device_unbind_cleanup()
Date: Thu, 15 Jan 2026 10:33:18 +0200
Message-ID: <20260115083332.1063820-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21565

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


