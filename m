Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC53CCFA1C
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:44 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10029.1762416698059849227
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SdXc6B+0;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so3438155e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416696; x=1763021496; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7n/xWt1NBWFbg8GoGV+tlmOfZuZJMYHC0uUuKIxg3Q=;
        b=SdXc6B+0Bg2Mr1+0qFkEVc51cgG3TBl2pOsEfKKvWXTKHJYcWnuEwH8S6OuHw1/I9b
         9pLsOdFVrLFytXgKayytEzg+BE0Jr7zjib6t7p/tijYzqFwRpi1Ts2zHOYH6lwvYA3lw
         MPcSNGSdpLhxo+zK1kmma4M7m530uTLsTp9gxglPQa4C5YIPM8LsUCPRI9njnteMm7g7
         Ac5AqE0x9XtKZZezcaUzfl5nXuc7ZAg7LqacKHiBXq3JHEuoPwdAaorPiG82hmtMcSTN
         0LD3YGEBWWZwCEWL1kT4SmrwlTuy6aOVjcQI1yXctVJkGlExbeKpfuwTOu2tIzFYiuFR
         2X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416696; x=1763021496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7n/xWt1NBWFbg8GoGV+tlmOfZuZJMYHC0uUuKIxg3Q=;
        b=b5aWaKuE1N0bJyyINDZGpITvrApi6NEbbkV72oexeId8ukfyq1QISKdzF/2NdlgXRq
         JVd9jWkxFWpIixQFpvfQpW44ff6hxjAbsRDFcIeyglQ6jHmUnilbSDnDtiWlPzlXjjYo
         D1yIkVEwjaW670jcGItcZgJkaMGOZgiN4aXiSVWVIFms4xXdKEGBqaEs/GoY9b44Pxg+
         PPz4iws/Hj+DmQNG+M8tGgkB7GjCn6WS6LCXogErXTn2XymMKZivuP8pI9U2pgMEGVWc
         w3BSID+I1gHaKOPcr37lJK5ZobG3V/oxswk6xdtaz8607taheIiVOCKcjMNpgBGbUrsq
         UD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2tpI++LYYX4e8BNxPBvNvjFzAKzAztV+GYSKR3Q15O7AJUhaWibbeFI01uY0s+DJsHManI84r@lists.cip-project.org
X-Gm-Message-State: AOJu0Yyv0wPwFhEDViddAV3qM1OHhDJN2TL1a906JXY6tHB7cYwk5nMT
	ZbArBX0DktaZtuoTmL47kPu759+FDpEt8IeD0l5Y+SZy61+QVyqxJHgnpa+EcwJi+ow=
X-Gm-Gg: ASbGncvoICAoycn2XzuNfy6mht48MZP0eOjTPssMABpOapAacycKC2alI68EJMzTVAw
	8wGKefx0cdg04oRVjnV09GawF28BBL3UWmCRAp80zfjKwyLnwbYPAuJu35J3mtiyZ24G2vzE6Yb
	P/BSz4ORKlWj3O9nCiFPn8CAmJJCTQ5wKANVdR6zCsqXbhhGu814U99Qfz6625ANY1k/ABW3u/L
	C/rVyoWghgV5d7K14WMiGJSew/z4KS/ch5yOlOR8eHLmwNCjGGmdzZ3aNFA/suBnnmeE0cLnJJd
	MT0Ve3Ko/Of20Hzd9F2pwFqVDHQXsw08skhoKdQF4vMJMNsvsnb8gwnwnFSsZ1CQlkE4a+HDb5z
	lQNlhkk9bwMutP294Qp/lLskDRwWFHS6KhsGDdi7u+WTqJNTlG+/HF/6BUjptQvbNneR07VWVuF
	N95QQ+kyWbm2lJqw0zalVADgh5ZuxDFvsFo9Ojq6jH
X-Google-Smtp-Source: AGHT+IHHKD9A33+fT4iRnBsgskR+8Sa9G9jI+74q63zSFHhN/EfP68q1Yt/n8BTJx6xm13qDXQRo+g==
X-Received: by 2002:a05:600c:6304:b0:46e:396b:f5ae with SMTP id 5b1f17b1804b1-4775cdca4ffmr43747425e9.16.1762416696306;
        Thu, 06 Nov 2025 00:11:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:35 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 01/23] PM: domains: Add flags to specify power on attach/detach
Date: Thu,  6 Nov 2025 10:11:10 +0200
Message-ID: <20251106081132.2574638-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20394

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
 - fixed conflict in pm_domain.h by keeping only PD_FLAG_ATTACH_POWER_ON
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
 include/linux/pm_domain.h                | 15 +++++++++++++--
 13 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 0aa2d3111ae6..810840327a50 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -137,7 +137,7 @@ static int amba_read_periphid(struct amba_device *dev)
 	void __iomem *tmp;
 	int i, ret;
 
-	ret = dev_pm_domain_attach(&dev->dev, true);
+	ret = dev_pm_domain_attach(&dev->dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret) {
 		dev_dbg(&dev->dev, "can't get PM domain: %d\n", ret);
 		goto err_out;
@@ -290,7 +290,7 @@ static int amba_probe(struct device *dev)
 		if (ret < 0)
 			break;
 
-		ret = dev_pm_domain_attach(dev, true);
+		ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 		if (ret)
 			break;
 
diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 8c5e65930617..31f5a81b5393 100644
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
index 3a06c214ca1c..14fde28de3f8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1392,7 +1392,7 @@ static int platform_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, true);
+	ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		goto out;
 
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 72115917e0bd..1a68e0075c14 100644
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
index e599f862ec44..9a19aa7a72fc 100644
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
index f5741b45ca07..df87183bf23b 100644
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
index f7e3fc0b3a1d..723dfaa994a0 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -569,7 +569,7 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 
 	do_power_on = !i2c_acpi_waive_d0_probe(dev);
-	status = dev_pm_domain_attach(&client->dev, do_power_on);
+	status = dev_pm_domain_attach(&client->dev, do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0);
 	if (status)
 		goto err_clear_wakeup_irq;
 
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index f191a2a76f3b..8e7322fd62e0 100644
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
index d6dde00efdae..65f723b8ac52 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -521,7 +521,7 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
-	err = dev_pm_domain_attach(dev, true);
+	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (err)
 		goto out;
 
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 963498db0fd2..c68f859db063 100644
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
index df774fb148d8..feadf94b8893 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -435,7 +435,7 @@ static int spi_probe(struct device *dev)
 			spi->irq = 0;
 	}
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		return ret;
 
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 0180e1e4e75d..ea2d80990505 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -410,7 +410,7 @@ static int serdev_drv_probe(struct device *dev)
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ebc351698090..d05b8cd15055 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -18,6 +18,17 @@
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
 
+/*
+ * Flags to control the behaviour when attaching a device to its PM domains.
+ *
+ * PD_FLAG_ATTACH_POWER_ON:	Power on the domain during attach.
+ *
+ * PD_FLAG_DETACH_POWER_OFF:	Power off the domain during detach.
+ *
+ */
+#define PD_FLAG_ATTACH_POWER_ON		BIT(3)
+#define PD_FLAG_DETACH_POWER_OFF	BIT(4)
+
 /*
  * Flags to control the behaviour of a genpd.
  *
@@ -410,7 +421,7 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 #ifdef CONFIG_PM
-int dev_pm_domain_attach(struct device *dev, bool power_on);
+int dev_pm_domain_attach(struct device *dev, u32 flags);
 struct device *dev_pm_domain_attach_by_id(struct device *dev,
 					  unsigned int index);
 struct device *dev_pm_domain_attach_by_name(struct device *dev,
@@ -419,7 +430,7 @@ void dev_pm_domain_detach(struct device *dev, bool power_off);
 int dev_pm_domain_start(struct device *dev);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 #else
-static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
+static inline int dev_pm_domain_attach(struct device *dev, u32 flags)
 {
 	return 0;
 }
-- 
2.43.0


