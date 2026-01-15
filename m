Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FF3D33A36
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:11 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31322.1768466171301339314
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lBT9IQu4;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so955909a12.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466170; x=1769070970; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm47YLcuIuKB5l9kiwyFBoNu+ixRzcltT9+GSGacK18=;
        b=lBT9IQu4K9MlIoBLaXcCo+S5gwvnx81TP5cCDa/mTA4EJARyx5vL4gv51iZgF9YdXa
         9SLNicWzV6E/i7a7QGpSyeu+hSyLgFgev5ndmNZ1KFIrd3PTbzWUPtBRETC7b5Oq/m1+
         OZ5GwOMcVukcY+ZME8Qn0tSyVPgtbIiMgT0aF+WA1E2GbRAWxMlw0g4+xmJLcduVS1zw
         gICcUAmYaE4B0dJOBNMT3gitKx7hbbvnrod5yOlhLYikC4pnLNWjcmIhRIul3CTB4Yui
         j6ZdNOnB69ppwuCghi3knJDMLmYye6sujTn7YuqoPMzLK7Ud+H9LASa+KclZbtFGGxeP
         4t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466170; x=1769070970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gm47YLcuIuKB5l9kiwyFBoNu+ixRzcltT9+GSGacK18=;
        b=TjzkkDRz9MplkoxOa/wov0bte/IHbfdTlDm8czw3AAnanwfvrVcBCDAH4FTcSZ/hxt
         gWun4CYNrxyWJrFap5W4yOgk7fvbQUs+CrIxXHdw9sdBbkVZkc23vyXcSX23ASqUNMlg
         gMTcK37WY2F8kT4zkMntEC1mxTc+/1IubGVLC5UTpJGKBxHvZgLd3LhXLy8lZxuUz2yF
         sNx/CCPJwsLnuoMkRttOYOPeTxpX2eO/4aZgo/Fmr7x12wdkq2jMDkjeIejbusRO96+U
         2CNgMj+lONXDUlzCcK1ZGsjCqhQnS/dnUoKBVJRSmRLA0mgNs+0Yqn5+hOxPipelExhj
         yb/Q==
X-Gm-Message-State: AOJu0YwwGY/uATv0xy1W9MNhDOVcmOTqt83oiFCfwu5g+76jHCVbTLx/
	S4BiQGIduxhK5I9NPg/E/nL0BfR4xmMRZBp6qYcrjcf0NgJBA2H6TC1bhD4tQ1Ow1xc=
X-Gm-Gg: AY/fxX5OJN/OST1ert2vTXeMJLUaHp+lzv24CTUr3mSjDSmwm1Am3h44mgDrgHFGW3A
	B6Cf06IeuIaBBYERHCfLpEyvirMDw3XILweQcsBlQuGoxAMdtsBEvEbVm1w5HGHeP75/Hnt6jvT
	rPlsqnNR1tyzaiqfjkJKwPUer9TMq60kotB7r7CJqsW5KraW/VBEC6XUT0quZ+1yp6akdxMgRgG
	fL+tuhCgUjqUKNenzNq/qKeHwjWoYoEirNSqVl7Rh2Ij0aR7HIAIvuVbcntkXtnL43TXWXWD3yc
	Ddvq7G7l7r6BZ4bLn2wAIJgFNvluDd6zBExeIi7a8L8EVs51S5evtAyzmFNOQJT2VVvDlnDk6IN
	EvjnP0UX7kuHihc9MgI/b5nBusNsAXh8uxpvn35fByKiwoYRp3OMtCQ7froDmcG6s1Bvko2Tof1
	pmkOGxxHBxx7ueyKjS9SpcjzWriK8I5swRu9jT54kCFB8iRANflM7rgcSic/RnEp7Uew==
X-Received: by 2002:a05:6402:2816:b0:64b:73d5:e2b4 with SMTP id 4fb4d7f45d1cf-653ec10b2d0mr4450849a12.5.1768466169610;
        Thu, 15 Jan 2026 00:36:09 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:09 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 01/19] PM: domains: Add flags to specify power on attach/detach
Date: Thu, 15 Jan 2026 10:35:45 +0200
Message-ID: <20260115083604.1064260-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21601

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d42c7c6fd66a6e2a78ae1da666c5df6c2fde8389 upstream.

Calling dev_pm_domain_attach()/dev_pm_domain_detach() in bus driver
probe/remove functions can affect system behavior when the drivers
attached to the bus use devres-managed resources. Since devres actions
may need to access device registers, calling dev_pm_domain_detach() too
early, i.e., before these actions complete, can cause failures on some
systems. One such example is Renesas RZ/G3S SoC-based platforms.

If the device clocks are managed via PM domains, invoking
dev_pm_domain_detach() in the bus driver's remove function removes the
device's clocks from the PM domain, preventing any subsequent
pm_runtime_resume*() calls from enabling those clocks.

The second argument of dev_pm_domain_attach() specifies whether the PM
domain should be powered on during attachment. Likewise, the second
argument of dev_pm_domain_detach() indicates whether the domain should be
powered off during detachment.

Upcoming changes address the issue described above (initially for the
platform bus only) by deferring the call to dev_pm_domain_detach() until
after devres_release_all() in device_unbind_cleanup(). The detach_power_off
field in struct dev_pm_info stores the detach power off info from the
second argument of dev_pm_domain_attach().

Because there are cases where the device's PM domain power-on/off behavior
must be conditional (e.g., in i2c_device_probe()), the patch introduces
PD_FLAG_ATTACH_POWER_ON and PD_FLAG_DETACH_POWER_OFF flags to be passed
to dev_pm_domain_attach().

Finally, dev_pm_domain_attach() and its users are updated to use the newly
introduced PD_FLAG_ATTACH_POWER_ON and PD_FLAG_DETACH_POWER_OFF macros.

This change is preparatory.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # I2C
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://patch.msgid.link/20250703112708.1621607-2-claudiu.beznea.uj@bp.renesas.com
[ rjw: Changelog adjustments ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[claudiu.beznea:
 - fixed conflict in apcs-sdx55.c by keeping the v6.12 version
   (that don't check for failures) and adding flag
   PD_FLAG_ATTACH_POWER_ON
 - fixed conflict in pm_domain.h by keeping PD_FLAG_ATTACH_POWER_ON
   and PD_FLAG_ATTACH_POWER_OFF]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/amba/bus.c                       |  4 ++--
 drivers/base/auxiliary.c                 |  2 +-
 drivers/base/platform.c                  |  2 +-
 drivers/base/power/common.c              |  6 +++---
 drivers/clk/qcom/apcs-sdx55.c            |  2 +-
 drivers/gpu/drm/display/drm_dp_aux_bus.c |  2 +-
 drivers/i2c/i2c-core-base.c              |  2 +-
 drivers/mmc/core/sdio_bus.c              |  2 +-
 drivers/rpmsg/rpmsg_core.c               |  2 +-
 drivers/soundwire/bus_type.c             |  2 +-
 drivers/spi/spi.c                        |  2 +-
 drivers/tty/serdev/core.c                |  2 +-
 include/linux/pm_domain.h                | 10 ++++++++--
 13 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 0230c43377c1..35b104075ff5 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -138,7 +138,7 @@ static int amba_read_periphid(struct amba_device *dev)
 	void __iomem *tmp;
 	int i, ret;
 
-	ret = dev_pm_domain_attach(&dev->dev, true);
+	ret = dev_pm_domain_attach(&dev->dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret) {
 		dev_dbg(&dev->dev, "can't get PM domain: %d\n", ret);
 		goto err_out;
@@ -291,7 +291,7 @@ static int amba_probe(struct device *dev)
 		if (ret < 0)
 			break;
 
-		ret = dev_pm_domain_attach(dev, true);
+		ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 		if (ret)
 			break;
 
diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 7823888af4f6..5d5b2a9fee0c 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -207,7 +207,7 @@ static int auxiliary_bus_probe(struct device *dev)
 	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret) {
 		dev_warn(dev, "Failed to attach to PM Domain : %d\n", ret);
 		return ret;
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6f2a33722c52..e10a0ee27ca5 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1396,7 +1396,7 @@ static int platform_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, true);
+	ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		goto out;
 
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index cca2fd0a1aed..0581fa25460b 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -82,7 +82,7 @@ EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
 /**
  * dev_pm_domain_attach - Attach a device to its PM domain.
  * @dev: Device to attach.
- * @power_on: Used to indicate whether we should power on the device.
+ * @flags: indicate whether we should power on/off the device on attach/detach
  *
  * The @dev may only be attached to a single PM domain. By iterating through
  * the available alternatives we try to find a valid PM domain for the device.
@@ -99,14 +99,14 @@ EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
  * Returns 0 on successfully attached PM domain, or when it is found that the
  * device doesn't need a PM domain, else a negative error code.
  */
-int dev_pm_domain_attach(struct device *dev, bool power_on)
+int dev_pm_domain_attach(struct device *dev, u32 flags)
 {
 	int ret;
 
 	if (dev->pm_domain)
 		return 0;
 
-	ret = acpi_dev_pm_attach(dev, power_on);
+	ret = acpi_dev_pm_attach(dev, !!(flags & PD_FLAG_ATTACH_POWER_ON));
 	if (!ret)
 		ret = genpd_dev_pm_attach(dev);
 
diff --git a/drivers/clk/qcom/apcs-sdx55.c b/drivers/clk/qcom/apcs-sdx55.c
index 76ece6c4a969..560bc84b1fee 100644
--- a/drivers/clk/qcom/apcs-sdx55.c
+++ b/drivers/clk/qcom/apcs-sdx55.c
@@ -111,7 +111,7 @@ static int qcom_apcs_sdx55_clk_probe(struct platform_device *pdev)
 	 * driver, there seems to be no better place to do this. So do it here!
 	 */
 	cpu_dev = get_cpu_device(0);
-	dev_pm_domain_attach(cpu_dev, true);
+	dev_pm_domain_attach(cpu_dev, PD_FLAG_ATTACH_POWER_ON);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/display/drm_dp_aux_bus.c
index d810529ebfb6..fd3591f45f6c 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
@@ -57,7 +57,7 @@ static int dp_aux_ep_probe(struct device *dev)
 		container_of(aux_ep, struct dp_aux_ep_device_with_data, aux_ep);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to attach to PM Domain\n");
 
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 75d30861ffe2..d70364e6ea6f 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -572,7 +572,7 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 
 	do_power_on = !i2c_acpi_waive_d0_probe(dev);
-	status = dev_pm_domain_attach(&client->dev, do_power_on);
+	status = dev_pm_domain_attach(&client->dev, do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0);
 	if (status)
 		goto err_clear_wakeup_irq;
 
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index b66b637e2d57..656601754966 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -161,7 +161,7 @@ static int sdio_bus_probe(struct device *dev)
 	if (!id)
 		return -ENODEV;
 
-	ret = dev_pm_domain_attach(dev, false);
+	ret = dev_pm_domain_attach(dev, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 712c06c02696..55c5f8833820 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -542,7 +542,7 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
-	err = dev_pm_domain_attach(dev, true);
+	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (err)
 		goto out;
 
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 77dc094075e1..9900cf0e6f8d 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -101,7 +101,7 @@ static int sdw_drv_probe(struct device *dev)
 	/*
 	 * attach to power domain but don't turn on (last arg)
 	 */
-	ret = dev_pm_domain_attach(dev, false);
+	ret = dev_pm_domain_attach(dev, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 63b25d929a8b..e5f3372d86be 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -434,7 +434,7 @@ static int spi_probe(struct device *dev)
 			spi->irq = 0;
 	}
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		return ret;
 
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index ebf0bbc2cff2..bdf58b4bce73 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -411,7 +411,7 @@ static int serdev_drv_probe(struct device *dev)
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index c6716f474ba4..be1e09f297dc 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -30,9 +30,15 @@
  *				supplier and its PM domain when creating the
  *				device-links.
  *
+ * PD_FLAG_ATTACH_POWER_ON:	Power on the domain during attach.
+ *
+ * PD_FLAG_DETACH_POWER_OFF:	Power off the domain during detach.
+ *
  */
 #define PD_FLAG_NO_DEV_LINK		BIT(0)
 #define PD_FLAG_DEV_LINK_ON		BIT(1)
+#define PD_FLAG_ATTACH_POWER_ON		BIT(3)
+#define PD_FLAG_DETACH_POWER_OFF	BIT(4)
 
 struct dev_pm_domain_attach_data {
 	const char * const *pd_names;
@@ -481,7 +487,7 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 #ifdef CONFIG_PM
-int dev_pm_domain_attach(struct device *dev, bool power_on);
+int dev_pm_domain_attach(struct device *dev, u32 flags);
 struct device *dev_pm_domain_attach_by_id(struct device *dev,
 					  unsigned int index);
 struct device *dev_pm_domain_attach_by_name(struct device *dev,
@@ -498,7 +504,7 @@ int dev_pm_domain_start(struct device *dev);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state);
 #else
-static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
+static inline int dev_pm_domain_attach(struct device *dev, u32 flags)
 {
 	return 0;
 }
-- 
2.43.0


