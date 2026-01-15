Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94592D33A24
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:11 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31291.1768466102728267297
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BhFFKowp;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so1042962a12.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466101; x=1769070901; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW2/xr5QBH49HVQp2Kp4nvtzi1NKKr/rsqg2nM/fj+w=;
        b=BhFFKowp1hLjGhH1Ca9Qcw6GoLL9PKQIPQc5u0uXukSbJGdoiKoFbBvbn+n0w8FBwf
         usCHmuIJKxFTCJFkQcmL0bTTmDXU3s3+hvP+cNLyx2K/P28DxzeqooUl4RbrkNlJ3E4X
         QUyOC+VPzgZaCUYFuBpfJ3FjjF2oOhuMQ/oooO3IPKQ3xUWCbYpgTKNtHHKMM72DzZ6z
         K598deyNYvuxn/cLv8AqRy6z7EQjqsTujheYFja5cmtH4qU+m5L8ARpf02Nv1LszCbrr
         xkFd58tK0NVJYfx2OHEOJoHSqIgxMmgm+CypbFrW3F9v0G9quR/NrZ5NAEXv/XupUqVQ
         GxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466101; x=1769070901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CW2/xr5QBH49HVQp2Kp4nvtzi1NKKr/rsqg2nM/fj+w=;
        b=PDOth7eq/dYVYb6rYMlnJtT7GUmvEcAKSnCYcnky38N5M+CN99B6ximrbuW5BUfUWl
         ffP5CmnL92sFiWv+NmtCqPyWVgfe6pdTPCvTfE5yeqAYmWVGGRwjkpv7ma5QQA65nd8y
         Sl3nGCvMaWFN8YcnwYhMxuZK4BXBeSQkH1LGp/6WcuCwV2hOsxcsSToeJSp21LGaiKkF
         qNorrJBkby9JEM0Pbm23zMKiBYBCRNx1Edd8iSdglkzAU/kORn8UydJXdXBYrqz5WiJK
         VsK1DTs5aoHxeqTuzzWGe5SpzN978l8wJP8PZZmN7wmjLCz6lV3oJ+d5WgVi+GcCD9RR
         HWVQ==
X-Gm-Message-State: AOJu0YwMWUsYbk+jQ2ExwaTknt31q4pGiRi8QiU9f9x3CGejrcaeUflR
	Fvk53VZm9GJZuPZcxyt4rX4BMZ5UV6tv2eNdMEfIchc1V4f4wq4Sctwq+hnSW8Lc57wxlyb28BY
	WjCx4
X-Gm-Gg: AY/fxX7uV6X9TkZkkuFUkuK/l/FcvQfP/uFFXiJvrGQeIpWS9rCJp9ePwbwPwlswur4
	Gr/YNn7+j/nbaBC9tfnryHvWzIkbuwQW3WCkc1JTiTSwnHNd7jeXpnNZILB/6O1u3cUhFXZ20AU
	3N6m5jSh57xQJ7qdWI1bqp+M5NTNGAR33VWpMIXeyFgqo3+kyL9Ba1gUNl7BQiHAKOQGTEpdlpc
	ToBsXTAdH57+PufKdBnXvb7pyzOnUjEaD9EEkWQBjHgpUKYW9PLjVl12BREwXFwZmcDZMMoHYJs
	tcaKemKWZugxR7zcRTBdtgORZuTzjHrgwFcXprTFgb9yYbdiwYIrvUIF+w11wHJPe/41PkmF7n8
	HU7zILavGeSvw5GSKfNw+iIy9rwT3hY+lETP2lupDQNalwpMjzqN1KSMPmMFy6V+yYEYdLBmTsf
	xiwPd7YsgdKuWecfk4FWYHDcBNhIYNuS7MInre5UEGKyRKEycJTehyw8f55n26GVJAeQ==
X-Received: by 2002:a05:6402:610:b0:650:883a:8896 with SMTP id 4fb4d7f45d1cf-653ec459ac0mr3234049a12.29.1768466101096;
        Thu, 15 Jan 2026 00:35:01 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:00 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 04/19] PM: domains: Detach on device_unbind_cleanup()
Date: Thu, 15 Jan 2026 10:34:36 +0200
Message-ID: <20260115083451.1064048-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21584

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


