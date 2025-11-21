Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA9DCFC271
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 12:50:26 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10720.1763729423429160846
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 04:50:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KYygpaB4;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so18000325e9.2
        for <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 04:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763729422; x=1764334222; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYGej6hL3GMKaoGQJBgoiE3IsUgMNKKAA4X+9jDTi/E=;
        b=KYygpaB4dTErqPyk27/W55HJ0eHIqxxRtuOHqiDUdKltC9imxIYW0UjASPTfBpJ7Z+
         viTYU8Wm9l9BxRIK7YMdnKxjC1TZ0ZdfUwBhvjToTh79uHBL0YqctJ2V6/fmGxX1kUE1
         ClNFf9Um/4fOWOSVyqhLqgYxV5z1soMkbsZL53qk2UQNzwyefCPQY20tjIrt/Oep34r7
         jFqUx1mvnmzw5bOT6TEnF6f4tHAnUpEEXVq3hskgG+J4ob0G9GoK/OUADOWEUI6zIsLm
         M1pzjLYVe9UUMYmvoki2DcSY6EpdV7iqczkJNsHJo9IYICECpW+Mw0a492hHSkN+yNG1
         9b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729422; x=1764334222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYGej6hL3GMKaoGQJBgoiE3IsUgMNKKAA4X+9jDTi/E=;
        b=JXsKntuLQm4M8HZ/cZxzr8IINmdT/L6VEvB9L9wi9DpXWcARcN852CDvATnAwsVKE7
         H9jQ7Dv5xj6+IKhKn0BjX67HF9Ks/vX3d0tGFg6/DKLPNE4Cym/xZV9D0qXe7F4Ge4lg
         o7nokSEgYAQZvAjh64jkfNxMYpBHNbLn7wdSahw+Pn99R7ve9HatWa6zUiVG2Eac9sKY
         tbWCTc3m8PQuLScfrzHlLNogOt3Pb36Oza5b2g0PzJZLxEp1S/cfbkSyUYezz+ziZlgh
         9oophDP4wfSyBZNrBWATMOWCE8jDFb1U/o2dF60zkpLj67PD7E1wabhcR4IsQB4Dau2G
         +0WA==
X-Gm-Message-State: AOJu0Yz+AV5wAiJwXWCWA15TpR5AXQsR4zEyz0yxOLX2emz6d4qphKmM
	chcufdl9Pmc7y2U2uHvHbF77orEVh/Gs10l/KwyD81vSrhsgxyoXKs9WnJKM8UT7v0QQFcesY48
	+L5nCpoM=
X-Gm-Gg: ASbGnct1bWbn0OJaPJmLOsX4ErGip2WEgpjrfeOyrlqzOA4+WrJBAtVVnTdYUnbSXDT
	lhemOI5QGwKRqUf8+M1yHZzV8hxQYP4wpCTCKrft61mnWlLgjn2DVb45oNgh32z+xYU51d9SZEG
	LMr2AX/7rAJK58FccwbOY64EHpazB5zbqewGr7vCT5u7hzpVmOS1ITcGLNuckxVO+sgsIf49eqr
	nSfLuP0w+C8G6pefRIlATgdFHASkS/Uy3+hElyXLQAlZhGye6yu+raXo1omp48uvDS0oNDI0pJR
	aLxwyLa+LJMg/u6dt5uUE5YgXpekxck3Bq67aF7PnJv8oxE28gty/4oBCO8brRr31ODddO7109D
	86xodlYfssNxj6c4kstDjhyRYm+ODBsoTOw8v+x1ttOYn+0v/26sPIwj43z14kNfO6POlcbaAIk
	j4ZKZCfMSprG+Atnv9CsoN/5fcNwG1pnhocNqtKgmi
X-Google-Smtp-Source: AGHT+IG6y6iXUSdksj721BYbFLkGhxQ+Syhd2/q2A5FWx+e02FB8qZVhKF3Tq7F5QTQzY0ldi0En1Q==
X-Received: by 2002:a05:600c:46c3:b0:471:989:9d7b with SMTP id 5b1f17b1804b1-477c01bddd6mr22180905e9.21.1763729421591;
        Fri, 21 Nov 2025 04:50:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf198a67sm43771855e9.0.2025.11.21.04.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:50:21 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH] drm: renesas: Open/close devres_group on probe/remove
Date: Fri, 21 Nov 2025 14:50:19 +0200
Message-ID: <20251121125019.488846-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e4137de7-ef22-41ce-b2b5-a1d2762eeb4b@tuxon.dev>
References: <e4137de7-ef22-41ce-b2b5-a1d2762eeb4b@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 12:50:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20680

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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

Open a devres group in the driver probe and release it in the driver
remove. This ensures the runtime PM is disabled (though the devres group)
after the driver remove finishes its execution avoiding the described
scenario.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 37 +++++++++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  1 +
 drivers/media/platform/renesas/rcar-fcp.c     | 38 ++++++++++++++++++-
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 37 +++++++++++++++++-
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    | 10 +++++
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 37 +++++++++++++++++-
 drivers/media/platform/renesas/vsp1/vsp1.h    |  1 +
 .../media/platform/renesas/vsp1/vsp1_drv.c    | 37 +++++++++++++++++-
 8 files changed, 193 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 58d8f9947f82..0c214689c793 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -7,6 +7,7 @@
  * Based on rcar_du_drv.c
  */
 
+#include <linux/device/devres.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -101,6 +102,8 @@ static void rzg2l_du_remove(struct platform_device *pdev)
 	drm_atomic_helper_shutdown(ddev);
 
 	drm_kms_helper_poll_fini(ddev);
+
+	devres_release_group(&pdev->dev, rcdu->devres_group_id);
 }
 
 static void rzg2l_du_shutdown(struct platform_device *pdev)
@@ -110,7 +113,7 @@ static void rzg2l_du_shutdown(struct platform_device *pdev)
 	drm_atomic_helper_shutdown(&rcdu->ddev);
 }
 
-static int rzg2l_du_probe(struct platform_device *pdev)
+static int rzg2l_du_probe_helper(struct platform_device *pdev, void *devres_group_id)
 {
 	struct rzg2l_du_device *rcdu;
 	int ret;
@@ -124,6 +127,8 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 	if (IS_ERR(rcdu))
 		return PTR_ERR(rcdu);
 
+	rcdu->devres_group_id = devres_group_id;
+
 	rcdu->dev = &pdev->dev;
 	rcdu->info = of_device_get_match_data(rcdu->dev);
 
@@ -170,6 +175,36 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int rzg2l_du_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void *devres_group_id;
+	int ret;
+
+	/*
+	 * Open a devres group to allow unconfiguring everything at
+	 * the end of the driver remove function (or, in the probe
+	 * failure path, just after leaving the driver probe function).
+	 * Otherwise, the dev_pm_domain_detach() call in the bus driver's
+	 * remove function disables the device clocks/power, leaving
+	 * subsequent devm actions or reset functions to execute with
+	 * clocks/power already disabled. This may lead to register
+	 * accesses while clocks/power are off (for example, in some cases
+	 * the devm_pm_runtime_enable() cleanup handler may perform a
+	 * runtime resume, and the device driver's runtime PM APIs may
+	 * then access registers with clocks/power disabled).
+	 */
+	devres_group_id = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!devres_group_id)
+		return -ENOMEM;
+
+	ret = rzg2l_du_probe_helper(pdev, devres_group_id);
+	if (ret)
+		devres_release_group(dev, devres_group_id);
+
+	return ret;
+}
+
 static struct platform_driver rzg2l_du_platform_driver = {
 	.probe		= rzg2l_du_probe,
 	.remove_new	= rzg2l_du_remove,
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index 58806c2a8f2b..0eea0f0246e9 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -57,6 +57,7 @@ struct rzg2l_du_device_info {
 struct rzg2l_du_device {
 	struct device *dev;
 	const struct rzg2l_du_device_info *info;
+	void *devres_group_id;
 
 	void __iomem *mmio;
 
diff --git a/drivers/media/platform/renesas/rcar-fcp.c b/drivers/media/platform/renesas/rcar-fcp.c
index bcef7b87da7c..de8f7e6a4c20 100644
--- a/drivers/media/platform/renesas/rcar-fcp.c
+++ b/drivers/media/platform/renesas/rcar-fcp.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/device/devres.h>
 #include <linux/dma-mapping.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -22,6 +23,7 @@
 struct rcar_fcp_device {
 	struct list_head list;
 	struct device *dev;
+	void *devres_group_id;
 };
 
 static LIST_HEAD(fcp_devices);
@@ -121,7 +123,7 @@ EXPORT_SYMBOL_GPL(rcar_fcp_disable);
  * Platform Driver
  */
 
-static int rcar_fcp_probe(struct platform_device *pdev)
+static int rcar_fcp_probe_helper(struct platform_device *pdev, void *devres_group_id)
 {
 	struct rcar_fcp_device *fcp;
 
@@ -129,6 +131,8 @@ static int rcar_fcp_probe(struct platform_device *pdev)
 	if (fcp == NULL)
 		return -ENOMEM;
 
+	fcp->devres_group_id = devres_group_id;
+
 	fcp->dev = &pdev->dev;
 
 	dma_set_max_seg_size(fcp->dev, UINT_MAX);
@@ -144,6 +148,36 @@ static int rcar_fcp_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int rcar_fcp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void *devres_group_id;
+	int ret;
+
+	/*
+	 * Open a devres group to allow unconfiguring everything at
+	 * the end of the driver remove function (or, in the probe
+	 * failure path, just after leaving the driver probe function).
+	 * Otherwise, the dev_pm_domain_detach() call in the bus driver's
+	 * remove function disables the device clocks/power, leaving
+	 * subsequent devm actions or reset functions to execute with
+	 * clocks/power already disabled. This may lead to register
+	 * accesses while clocks/power are off (for example, in some cases
+	 * the devm_pm_runtime_enable() cleanup handler may perform a
+	 * runtime resume, and the device driver's runtime PM APIs may
+	 * then access registers with clocks/power disabled).
+	 */
+	devres_group_id = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!devres_group_id)
+		return -ENOMEM;
+
+	ret = rcar_fcp_probe_helper(pdev, devres_group_id);
+	if (ret)
+		devres_release_group(dev, devres_group_id);
+
+	return ret;
+}
+
 static void rcar_fcp_remove(struct platform_device *pdev)
 {
 	struct rcar_fcp_device *fcp = platform_get_drvdata(pdev);
@@ -153,6 +187,8 @@ static void rcar_fcp_remove(struct platform_device *pdev)
 	mutex_unlock(&fcp_lock);
 
 	pm_runtime_disable(&pdev->dev);
+
+	devres_release_group(&pdev->dev, fcp->devres_group_id);
 }
 
 static const struct of_device_id rcar_fcp_of_match[] = {
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index ab8f76ccd9ba..7b3c323318ba 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/device/devres.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
@@ -239,7 +240,7 @@ static int rzg2l_cru_media_init(struct rzg2l_cru_dev *cru)
 	return 0;
 }
 
-static int rzg2l_cru_probe(struct platform_device *pdev)
+static int rzg2l_cru_probe_helper(struct platform_device *pdev, void *devres_group_id)
 {
 	struct device *dev = &pdev->dev;
 	struct rzg2l_cru_dev *cru;
@@ -249,6 +250,8 @@ static int rzg2l_cru_probe(struct platform_device *pdev)
 	if (!cru)
 		return -ENOMEM;
 
+	cru->devres_group_id = devres_group_id;
+
 	cru->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cru->base))
 		return PTR_ERR(cru->base);
@@ -304,6 +307,36 @@ static int rzg2l_cru_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int rzg2l_cru_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void *devres_group_id;
+	int ret;
+
+	/*
+	 * Open a devres group to allow unconfiguring everything at
+	 * the end of the driver remove function (or, in the probe
+	 * failure path, just after leaving the driver probe function).
+	 * Otherwise, the dev_pm_domain_detach() call in the bus driver's
+	 * remove function disables the device clocks/power, leaving
+	 * subsequent devm actions or reset functions to execute with
+	 * clocks/power already disabled. This may lead to register
+	 * accesses while clocks/power are off (for example, in some cases
+	 * the devm_pm_runtime_enable() cleanup handler may perform a
+	 * runtime resume, and the device driver's runtime PM APIs may
+	 * then access registers with clocks/power disabled).
+	 */
+	devres_group_id = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!devres_group_id)
+		return -ENOMEM;
+
+	ret = rzg2l_cru_probe_helper(pdev, devres_group_id);
+	if (ret)
+		devres_release_group(dev, devres_group_id);
+
+	return ret;
+}
+
 static void rzg2l_cru_remove(struct platform_device *pdev)
 {
 	struct rzg2l_cru_dev *cru = platform_get_drvdata(pdev);
@@ -316,6 +349,8 @@ static void rzg2l_cru_remove(struct platform_device *pdev)
 	mutex_destroy(&cru->mdev_lock);
 
 	rzg2l_cru_dma_unregister(cru);
+
+	devres_release_group(&pdev->dev, cru->devres_group_id);
 }
 
 static const u16 rzg3e_cru_regs[] = {
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 56feda6e6207..4c9d84561db5 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -99,6 +99,15 @@ struct rzg2l_cru_info {
  * struct rzg2l_cru_dev - Renesas CRU device structure
  * @dev:		(OF) device
  * @base:		device I/O register space remapped to virtual memory
+ * @devres_group_id	devres group that allows unconfiguring everything at
+ *			the end of the driver remove function (or, on the probe
+ *			failure path, just after leaving the driver probe
+ *			function). Otherwise, the dev_pm_domain_detach() call in
+ *			the platform driver's remove function disables the device
+ *			clocks, leaving subsequent actions or reset functions to
+ *			be executed (later) with clocks disabled. This can cause
+ *			the system to hang and eventually be restarted by the
+ *			watchdog.
  * @info:		info about CRU instance
  *
  * @presetn:		CRU_PRESETN reset line
@@ -137,6 +146,7 @@ struct rzg2l_cru_dev {
 	struct device *dev;
 	void __iomem *base;
 	const struct rzg2l_cru_info *info;
+	void *devres_group_id;
 
 	struct reset_control *presetn;
 	struct reset_control *aresetn;
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index b2654aaba2a5..e3e6079d0dcc 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -7,6 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/device/devres.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -114,6 +115,7 @@ enum rzg2l_csi2_pads {
 struct rzg2l_csi2 {
 	struct device *dev;
 	void __iomem *base;
+	void *devres_group_id;
 	struct reset_control *presetn;
 	struct reset_control *cmn_rstb;
 	const struct rzg2l_csi2_info *info;
@@ -866,7 +868,7 @@ static const struct media_entity_operations rzg2l_csi2_entity_ops = {
 	.link_validate = v4l2_subdev_link_validate,
 };
 
-static int rzg2l_csi2_probe(struct platform_device *pdev)
+static int rzg2l_csi2_probe_helper(struct platform_device *pdev, void *devres_group_id)
 {
 	struct device *dev = &pdev->dev;
 	struct rzg2l_csi2 *csi2;
@@ -876,6 +878,8 @@ static int rzg2l_csi2_probe(struct platform_device *pdev)
 	if (!csi2)
 		return -ENOMEM;
 
+	csi2->devres_group_id = devres_group_id;
+
 	csi2->info = of_device_get_match_data(dev);
 	if (!csi2->info)
 		return dev_err_probe(dev, -EINVAL, "Failed to get OF match data\n");
@@ -968,6 +972,36 @@ static int rzg2l_csi2_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int rzg2l_csi2_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void *devres_group_id;
+	int ret;
+
+	/*
+	 * Open a devres group to allow unconfiguring everything at
+	 * the end of the driver remove function (or, in the probe
+	 * failure path, just after leaving the driver probe function).
+	 * Otherwise, the dev_pm_domain_detach() call in the bus driver's
+	 * remove function disables the device clocks/power, leaving
+	 * subsequent devm actions or reset functions to execute with
+	 * clocks/power already disabled. This may lead to register
+	 * accesses while clocks/power are off (for example, in some cases
+	 * the devm_pm_runtime_enable() cleanup handler may perform a
+	 * runtime resume, and the device driver's runtime PM APIs may
+	 * then access registers with clocks/power disabled).
+	 */
+	devres_group_id = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!devres_group_id)
+		return -ENOMEM;
+
+	ret = rzg2l_csi2_probe_helper(pdev, devres_group_id);
+	if (ret)
+		devres_release_group(dev, devres_group_id);
+
+	return ret;
+}
+
 static void rzg2l_csi2_remove(struct platform_device *pdev)
 {
 	struct rzg2l_csi2 *csi2 = platform_get_drvdata(pdev);
@@ -977,6 +1011,7 @@ static void rzg2l_csi2_remove(struct platform_device *pdev)
 	v4l2_async_unregister_subdev(&csi2->subdev);
 	v4l2_subdev_cleanup(&csi2->subdev);
 	media_entity_cleanup(&csi2->subdev.entity);
+	devres_release_group(&pdev->dev, csi2->devres_group_id);
 }
 
 static int rzg2l_csi2_pm_runtime_suspend(struct device *dev)
diff --git a/drivers/media/platform/renesas/vsp1/vsp1.h b/drivers/media/platform/renesas/vsp1/vsp1.h
index 2f6f0c6ae555..3d9c917c5a2f 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1.h
+++ b/drivers/media/platform/renesas/vsp1/vsp1.h
@@ -77,6 +77,7 @@ struct vsp1_device_info {
 struct vsp1_device {
 	struct device *dev;
 	const struct vsp1_device_info *info;
+	void *devres_group_id;
 	u32 version;
 
 	void __iomem *mmio;
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
index 1aac44d68731..3b278c93c1c2 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/device/devres.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -883,7 +884,7 @@ static const struct vsp1_device_info *vsp1_lookup_info(struct vsp1_device *vsp1)
 	return NULL;
 }
 
-static int vsp1_probe(struct platform_device *pdev)
+static int vsp1_probe_helper(struct platform_device *pdev, void *devres_group_id)
 {
 	struct vsp1_device *vsp1;
 	struct device_node *fcp_node;
@@ -894,6 +895,8 @@ static int vsp1_probe(struct platform_device *pdev)
 	if (vsp1 == NULL)
 		return -ENOMEM;
 
+	vsp1->devres_group_id = devres_group_id;
+
 	vsp1->dev = &pdev->dev;
 	INIT_LIST_HEAD(&vsp1->entities);
 	INIT_LIST_HEAD(&vsp1->videos);
@@ -985,6 +988,36 @@ static int vsp1_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int vsp1_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void *devres_group_id;
+	int ret;
+
+	/*
+	 * Open a devres group to allow unconfiguring everything at
+	 * the end of the driver remove function (or, in the probe
+	 * failure path, just after leaving the driver probe function).
+	 * Otherwise, the dev_pm_domain_detach() call in the bus driver's
+	 * remove function disables the device clocks/power, leaving
+	 * subsequent devm actions or reset functions to execute with
+	 * clocks/power already disabled. This may lead to register
+	 * accesses while clocks/power are off (for example, in some cases
+	 * the devm_pm_runtime_enable() cleanup handler may perform a
+	 * runtime resume, and the device driver's runtime PM APIs may
+	 * then access registers with clocks/power disabled).
+	 */
+	devres_group_id = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!devres_group_id)
+		return -ENOMEM;
+
+	ret = vsp1_probe_helper(pdev, devres_group_id);
+	if (ret)
+		devres_release_group(dev, devres_group_id);
+
+	return ret;
+}
+
 static void vsp1_remove(struct platform_device *pdev)
 {
 	struct vsp1_device *vsp1 = platform_get_drvdata(pdev);
@@ -993,6 +1026,8 @@ static void vsp1_remove(struct platform_device *pdev)
 	rcar_fcp_put(vsp1->fcp);
 
 	pm_runtime_disable(&pdev->dev);
+
+	devres_release_group(&pdev->dev, vsp1->devres_group_id);
 }
 
 static const struct of_device_id vsp1_of_match[] = {
-- 
2.43.0


