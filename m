Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67590D33A09
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:41 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31249.1768466019499962416
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dQ7LR7H1;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8765b7f4c0so111531766b.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466018; x=1769070818; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x00vsw806Rn13QoltLSsjUyuOs0Go6kcJ+yiBzlXZtA=;
        b=dQ7LR7H1Pw2H1XGeYRnSCvXAvAskHzzsJJ2AW+y4aIiWZErJZKNlRONwd8B5ECPOh2
         IMQvQybrr4iIk8fHHTIhcroNq9Ml7xPbwtweAIiyb8nAEndl4F6LK8f6tuOJxDATkYlp
         dSyjoo3tARj/Z7M/Ekw1seLXpUhgBI+0iBku+ZYWKVKz3cQLYLUDBOZ+b+K3UiQE6V+i
         7ZguA0hufkM5f4CdII8PTmuLFnNPNuGKRWdi5By+a5lPg8tfI8FaGgvxq1I9Xog/1E96
         6xPUzbRXcoMHaIEepmhQ1VnGGcH+tMWi9hXdjFQojLskdYATpJW5wXEQaunt1E5WFydj
         ulRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466018; x=1769070818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x00vsw806Rn13QoltLSsjUyuOs0Go6kcJ+yiBzlXZtA=;
        b=wtN/XCg55/YKif1TVaU23l6m2m8oOrL4VaidAaddggb+9HjqW3psA6JFHo6vjaHMua
         gce5OqQk50UZ87/HzqW1nOKl9AZlnMP52TY1I2OaVMuRE0n8qJiV+rAqbNwz1BLCtHxz
         mhMvorEH7GKgJb0paOrmreLdL6RMMD4OLTBz12SNgSiaeqxdG28n9+z3WbEMgyD7WVr3
         SOkPhieprhU9dM8FbCT6S+xiKdymj2f2QIAl+oKf6xAVZ9tvkj/YCjmef8M6uNCnFtVq
         COuMNutvI39S6MFgaOnbJMTqF2uZmEaH5Stb1LjgoKGXqusmyp2WFzeC/1QFx9HoZlrE
         /EJw==
X-Gm-Message-State: AOJu0Yxy3nGtnAAUIyjnET77AvILfJEEYa1U1OiSm/z3g5ykzYcSonaI
	ig2B5KWxHLvFfPKxzQRfwZRpepq/lxmtqTyyKSHQC6t3NfsZWDUDrYzcxh5GyGBLfpI=
X-Gm-Gg: AY/fxX4SjN7dDetxLfnxC46g5dc7ZXJL8w2zbk5F5YoppLe2YRhXV7gaRvJhEsshMxL
	8nWOipNLmaV/avvfJjoTQfq34DvE0HDQzCebNILt6pRaqGBSrwve197g3rvvYk8+/2OkRhoXt2D
	BQdOd4qSwEPPUXTt7eOhrIOFlxkmIGtPWbFu4Xg2cY3VH/c77BSw83FJCm8+R73sX7Ns30sy3Cv
	Hr3nGqI+OdVB5OWo8XwzFtpar9kn1cqjk6avGc5NKdJUm4Jz07rttabl6gmRTRoty5LHH9/pa3u
	aTjinns1ZBVBlD/2/eqYMYnELyERvH20Qvch+P+Zy5bETcyFeEye34VEIfGSfFHn/9EW20z7Xuo
	84itQUH7ORm3MaJmnvXC632ugHN65WWAZakvvDkCTtt4EMcE3HwXbp7T4ZTfd2qChB1ueehMN6y
	799PhYHsiOLm8WNXnRcqq+kXy/IfKSgfHvm5gvUvmRB/tjCojvYD3NcqgtrSzlyjUNrQ==
X-Received: by 2002:a17:907:d86:b0:b76:bcf5:a388 with SMTP id a640c23a62f3a-b87612a1d31mr492874766b.50.1768466017735;
        Thu, 15 Jan 2026 00:33:37 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 01/18] PM: domains: Add flags to specify power on attach/detach
Date: Thu, 15 Jan 2026 10:33:15 +0200
Message-ID: <20260115083332.1063820-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:33:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21562

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
 - fix confclit in amba bus by keeing v5.10 CIP code
 - drop auxiliary bus code as it is not in v5.10 CIP
 - keep the code from v5.10 and add PD flags for platform bus
 - removed apcs-sdx55.c, drm_dp_aux_bus.c
 - for i2c-core kept the v5.10 CIP variant and add PD_FLAG_ATTACH_POWER_ON
   to it
 - for pm_domain.h fix conflict by keeping only PD_FLAG_ATTACH_POWER_ON,
   PD_FLAG_ATTACH_POWER_OFF flags]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/amba/bus.c           |  4 ++--
 drivers/base/platform.c      |  2 +-
 drivers/base/power/common.c  |  6 +++---
 drivers/i2c/i2c-core-base.c  |  2 +-
 drivers/mmc/core/sdio_bus.c  |  2 +-
 drivers/rpmsg/rpmsg_core.c   |  2 +-
 drivers/soundwire/bus_type.c |  2 +-
 drivers/spi/spi.c            |  2 +-
 drivers/tty/serdev/core.c    |  2 +-
 include/linux/pm_domain.h    | 15 +++++++++++++--
 10 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 52ab582930ca..71297aae325a 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -266,7 +266,7 @@ static int amba_probe(struct device *dev)
 		if (ret < 0)
 			break;
 
-		ret = dev_pm_domain_attach(dev, true);
+		ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 		if (ret)
 			break;
 
@@ -394,7 +394,7 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 		goto err_release;
 	}
 
-	ret = dev_pm_domain_attach(&dev->dev, true);
+	ret = dev_pm_domain_attach(&dev->dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret) {
 		iounmap(tmp);
 		goto err_release;
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 647066229fec..cd10408e04d0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -753,7 +753,7 @@ static int platform_drv_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, true);
+	ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		goto out;
 
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index bbddb267c2e6..de0eee2f0057 100644
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
 
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index ef6d52a38b5c..fea3ea0bc08a 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -535,7 +535,7 @@ static int i2c_device_probe(struct device *dev)
 	if (status < 0)
 		goto err_clear_wakeup_irq;
 
-	status = dev_pm_domain_attach(&client->dev, true);
+	status = dev_pm_domain_attach(&client->dev, PD_FLAG_ATTACH_POWER_ON);
 	if (status)
 		goto err_clear_wakeup_irq;
 
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 89dd49260080..c90dabb5ab06 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -160,7 +160,7 @@ static int sdio_bus_probe(struct device *dev)
 	if (!id)
 		return -ENODEV;
 
-	ret = dev_pm_domain_attach(dev, false);
+	ret = dev_pm_domain_attach(dev, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index fd3d7b3fbbd1..58db61f4d613 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -451,7 +451,7 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
-	err = dev_pm_domain_attach(dev, true);
+	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (err)
 		goto out;
 
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 2e8986cccdd4..3c7b12b130ea 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -102,7 +102,7 @@ static int sdw_drv_probe(struct device *dev)
 	/*
 	 * attach to power domain but don't turn on (last arg)
 	 */
-	ret = dev_pm_domain_attach(dev, false);
+	ret = dev_pm_domain_attach(dev, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index be85faf9ec76..6acdb27a2be1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -407,7 +407,7 @@ static int spi_drv_probe(struct device *dev)
 			spi->irq = 0;
 	}
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
 	if (ret)
 		return ret;
 
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index c5f0d936b003..bf35e03c06cd 100644
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
index 1ad0ec481416..9c9e4f3d7a73 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -17,6 +17,17 @@
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
@@ -392,7 +403,7 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 #ifdef CONFIG_PM
-int dev_pm_domain_attach(struct device *dev, bool power_on);
+int dev_pm_domain_attach(struct device *dev, u32 flags);
 struct device *dev_pm_domain_attach_by_id(struct device *dev,
 					  unsigned int index);
 struct device *dev_pm_domain_attach_by_name(struct device *dev,
@@ -401,7 +412,7 @@ void dev_pm_domain_detach(struct device *dev, bool power_off);
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


