Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F50D29F99
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:08 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50546.1764872165356891175
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NQuCy1kO;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so11780505e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872164; x=1765476964; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm47YLcuIuKB5l9kiwyFBoNu+ixRzcltT9+GSGacK18=;
        b=NQuCy1kOnqtr14F6dR+uQ26pQgaAQWtrvgPHAysKrYjeiInW2Y6oJ2IoefImIEig0P
         M6WLJfhXRUrogpJ/TYtwWGYZ8Pkmm9lmCNrrVtesmLXN3eVEuLCezHIIDXQ8BloTU5TD
         gW7LggbTiokq2xCSgbXeAap8pN0Oo2QDdTPLsSK24Qv16ixC//qLRcat1I/mvNv+56Pw
         Lp6jYu4SUfv8Ni3sojCMoLVEd2TWoAUAGay0RGXdrrJ1ZOuR/dNiZJvtqraAcmDlbPFI
         YnpNJpHwid6iinzP2pY/acDlVwMqzICXrpspgnmy/DI12WDo11Vf9fOT7I1ix+kZoGu6
         VJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872164; x=1765476964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gm47YLcuIuKB5l9kiwyFBoNu+ixRzcltT9+GSGacK18=;
        b=BhDOSznvp+7dMHafBcTwwPjbOglGQRF7DBucbfxXIT90E8HlVqqPAPEZr05BG1+N9H
         5aDxGySbyQQ2JWvHdH0pjszhynHFGkidA2jbOE63NwsZaMTRGejEVPrUa+rzZX7XYAnT
         8qvOl16++IAbg0U+KRY9Q2WBQUUmrjTdjDEAFqs6BgzF1dcrdZ0VyckHit2CKsnP1I1Q
         cn04zRI0UglbU5xygrPnew8QrNOJeVGABKH9xH4zxemwld6G1ac2JnTdScMjfDdQG1LS
         gRJQSASPWqQFQqsso8BeXdcYLD1qkML+Er/UldMXDmtqPsd1aiUbUyC+KN8iIciX+u+u
         LmzA==
X-Forwarded-Encrypted: i=1; AJvYcCXgraa1DamtQKoKr7jNQCrQq6/b1k9PJ42RfBCkwM9J5nJkvQ3TQZmUa6RxZ9hNifUZWyepPDBB@lists.cip-project.org
X-Gm-Message-State: AOJu0YynIva+bCAGxaQx5slvfPYDWg2vom/C6j/wecRCIeSlnAjPDqgq
	jcEhZzbClnRKg/BFHEnPd1KCWEFuqfbZEL+F5sc8saHbTeU2HM7s0iO3xXYUha5q1/4=
X-Gm-Gg: ASbGnctO2WfEwTrbMgu0yf0dgBa5ayX/IEwL6RPpEkCSIgETNhHAc01WYCALz+sqcnK
	gpiuM1SLw5x4nqclmRDkR6BTPbE3GKZgIXIpjm0DhKQku0W0/ZRQL3i+Z1+foyAOwgYdhDv1wCM
	Dp1WvG2pLEI+NRN2jSrQdu2jkaw+UOgwResxhMXBzrw262+Dwh7XyYBW4EnXJBlpeNh/g3DU8xL
	ghWLzVz9x6rCfTB28ZIBjnON5+ktV8VJR/Lgwwb7U7eE5CpXrTvXRpxyGrW20wCIshH7KLj/Uwq
	MBaGo8WRWUW+94BpETnVRvwCdvu/gX0udgWtP5xwi9teo2lHRXrYK6C8skpwF9X1fYK/g54Wtz+
	6eUevZg9Sc7VfEt529hV82laeLCad/GNLK/rPwHCy7bl9fn+CNYDqwADC/Z07uZGDx8k3jRBE4Z
	XAWybI894xO8Y5xPHn1pLRRz82b84ibPPz70uqRSkr4phwAW6pIsA=
X-Google-Smtp-Source: AGHT+IHabNyPx7ocmvGi8YTcFrPzL0To/ccxTBEj8XyrAbtPigMzAiDfuACh0pvESIO034+Jb6ms6w==
X-Received: by 2002:a05:600c:8b88:b0:479:3046:6bb3 with SMTP id 5b1f17b1804b1-47930466bc3mr39909465e9.23.1764872163619;
        Thu, 04 Dec 2025 10:16:03 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 01/19] PM: domains: Add flags to specify power on attach/detach
Date: Thu,  4 Dec 2025 20:15:42 +0200
Message-ID: <20251204181600.689203-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20887

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


