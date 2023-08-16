Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F85C04E69
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.161745.1692195636868099658
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787666"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B63794210C25;
	Wed, 16 Aug 2023 23:20:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/31] rtc: add devm_ prefix to rtc_nvmem_register()
Date: Wed, 16 Aug 2023 15:19:53 +0100
Message-Id: <20230816142017.147173-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12689

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit 3a905c2d9544a418953d6c18668f0f853fbd9be9 upstream.

rtc_nvmem_register() is a managed interface. It doesn't require any
release function to be called at driver detach. To avoid confusing
driver authors, let's rename it to devm_rtc_nvmem_register() and add it
to the list of managed interfaces in Documentation/.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201109163409.24301-6-brgl@bgdev.pl
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/driver-api/driver-model/devres.rst | 1 +
 drivers/rtc/nvmem.c                              | 4 ++--
 drivers/rtc/rtc-cmos.c                           | 2 +-
 drivers/rtc/rtc-ds1305.c                         | 2 +-
 drivers/rtc/rtc-ds1307.c                         | 2 +-
 drivers/rtc/rtc-ds1343.c                         | 2 +-
 drivers/rtc/rtc-ds1511.c                         | 2 +-
 drivers/rtc/rtc-ds1553.c                         | 2 +-
 drivers/rtc/rtc-ds1685.c                         | 2 +-
 drivers/rtc/rtc-ds1742.c                         | 2 +-
 drivers/rtc/rtc-ds3232.c                         | 2 +-
 drivers/rtc/rtc-isl12026.c                       | 2 +-
 drivers/rtc/rtc-isl1208.c                        | 2 +-
 drivers/rtc/rtc-m48t59.c                         | 2 +-
 drivers/rtc/rtc-m48t86.c                         | 2 +-
 drivers/rtc/rtc-meson.c                          | 2 +-
 drivers/rtc/rtc-omap.c                           | 2 +-
 drivers/rtc/rtc-pcf2127.c                        | 2 +-
 drivers/rtc/rtc-pcf85063.c                       | 2 +-
 drivers/rtc/rtc-pcf85363.c                       | 2 +-
 drivers/rtc/rtc-rp5c01.c                         | 2 +-
 drivers/rtc/rtc-rv3028.c                         | 4 ++--
 drivers/rtc/rtc-rv3029c2.c                       | 2 +-
 drivers/rtc/rtc-rv3032.c                         | 4 ++--
 drivers/rtc/rtc-rv8803.c                         | 2 +-
 drivers/rtc/rtc-rx8581.c                         | 2 +-
 drivers/rtc/rtc-stk17ta8.c                       | 2 +-
 drivers/rtc/rtc-tx4939.c                         | 2 +-
 include/linux/rtc.h                              | 8 ++++----
 29 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 6ffc0f07404f..5df7ba54a4ba 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -414,6 +414,7 @@ RESET
 RTC
   devm_rtc_device_register()
   devm_rtc_allocate_device()
+  devm_rtc_nvmem_register()
 
 SERDEV
   devm_serdev_device_open()
diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 5e0b178a3b65..7502deb6390e 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -10,7 +10,7 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/rtc.h>
 
-int rtc_nvmem_register(struct rtc_device *rtc,
+int devm_rtc_nvmem_register(struct rtc_device *rtc,
 		       struct nvmem_config *nvmem_config)
 {
 	struct nvmem_device *nvmem;
@@ -24,4 +24,4 @@ int rtc_nvmem_register(struct rtc_device *rtc,
 
 	return PTR_ERR_OR_ZERO(nvmem);
 }
-EXPORT_SYMBOL_GPL(rtc_nvmem_register);
+EXPORT_SYMBOL_GPL(devm_rtc_nvmem_register);
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 74e21341e373..6b237943ee31 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1099,7 +1099,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 
 	/* export at least the first block of NVRAM */
 	nvmem_cfg.size = address_space - NVRAM_OFFSET;
-	if (rtc_nvmem_register(cmos_rtc.rtc, &nvmem_cfg))
+	if (devm_rtc_nvmem_register(cmos_rtc.rtc, &nvmem_cfg))
 		dev_err(dev, "nvmem registration failed\n");
 
 	/*
diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index a1ed539d41b4..a4e768261b43 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -698,7 +698,7 @@ static int ds1305_probe(struct spi_device *spi)
 	if (status)
 		return status;
 
-	rtc_nvmem_register(ds1305->rtc, &ds1305_nvmem_cfg);
+	devm_rtc_nvmem_register(ds1305->rtc, &ds1305_nvmem_cfg);
 
 	/* Maybe set up alarm IRQ; be ready to handle it triggering right
 	 * away.  NOTE that we don't share this.  The signal is active low,
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 295fcf73b746..eb24aaf110a9 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -2055,7 +2055,7 @@ static int ds1307_probe(struct i2c_client *client,
 			.priv = ds1307,
 		};
 
-		rtc_nvmem_register(ds1307->rtc, &nvmem_cfg);
+		devm_rtc_nvmem_register(ds1307->rtc, &nvmem_cfg);
 	}
 
 	ds1307_hwmon_register(ds1307);
diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index e7604e844cbd..ea663e24a34c 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -413,7 +413,7 @@ static int ds1343_probe(struct spi_device *spi)
 		return res;
 
 	nvmem_cfg.priv = priv;
-	rtc_nvmem_register(priv->rtc, &nvmem_cfg);
+	devm_rtc_nvmem_register(priv->rtc, &nvmem_cfg);
 
 	priv->irq = spi->irq;
 
diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 33c483d759c8..d5f48216e851 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -470,7 +470,7 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	rtc_nvmem_register(pdata->rtc, &ds1511_nvmem_cfg);
+	devm_rtc_nvmem_register(pdata->rtc, &ds1511_nvmem_cfg);
 
 	/*
 	 * if the platform has an interrupt in mind for this device,
diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index c6a5563504e5..2d2eb739d92b 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -309,7 +309,7 @@ static int ds1553_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (rtc_nvmem_register(pdata->rtc, &nvmem_cfg))
+	if (devm_rtc_nvmem_register(pdata->rtc, &nvmem_cfg))
 		dev_err(&pdev->dev, "unable to register nvmem\n");
 
 	return 0;
diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 9043c96e8845..bef588fce266 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1317,7 +1317,7 @@ ds1685_rtc_probe(struct platform_device *pdev)
 		return ret;
 
 	nvmem_cfg.priv = rtc;
-	ret = rtc_nvmem_register(rtc_dev, &nvmem_cfg);
+	ret = devm_rtc_nvmem_register(rtc_dev, &nvmem_cfg);
 	if (ret)
 		return ret;
 
diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 291bbed90ef8..29792a8cce97 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -195,7 +195,7 @@ static int ds1742_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (rtc_nvmem_register(rtc, &nvmem_cfg))
+	if (devm_rtc_nvmem_register(rtc, &nvmem_cfg))
 		dev_err(&pdev->dev, "Unable to register nvmem\n");
 
 	return 0;
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 69c37ab64352..16b89035d135 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -518,7 +518,7 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 	if (IS_ERR(ds3232->rtc))
 		return PTR_ERR(ds3232->rtc);
 
-	ret = rtc_nvmem_register(ds3232->rtc, &nvmem_cfg);
+	ret = devm_rtc_nvmem_register(ds3232->rtc, &nvmem_cfg);
 	if(ret)
 		return ret;
 
diff --git a/drivers/rtc/rtc-isl12026.c b/drivers/rtc/rtc-isl12026.c
index 5b6b17fb6d62..fff8d8253669 100644
--- a/drivers/rtc/rtc-isl12026.c
+++ b/drivers/rtc/rtc-isl12026.c
@@ -465,7 +465,7 @@ static int isl12026_probe_new(struct i2c_client *client)
 
 	priv->rtc->ops = &isl12026_rtc_ops;
 	nvm_cfg.priv = priv;
-	ret = rtc_nvmem_register(priv->rtc, &nvm_cfg);
+	ret = devm_rtc_nvmem_register(priv->rtc, &nvm_cfg);
 	if (ret)
 		return ret;
 
diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index ebb691fa48a6..08d778b10e9e 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -890,7 +890,7 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = rtc_nvmem_register(isl1208->rtc, &isl1208->nvmem_config);
+	rc = devm_rtc_nvmem_register(isl1208->rtc, &isl1208->nvmem_config);
 	if (rc)
 		return rc;
 
diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index ee1d8f0146fd..e966a66ab2d3 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -466,7 +466,7 @@ static int m48t59_rtc_probe(struct platform_device *pdev)
 	m48t59->rtc->ops = ops;
 
 	nvmem_cfg.size = pdata->offset;
-	ret = rtc_nvmem_register(m48t59->rtc, &nvmem_cfg);
+	ret = devm_rtc_nvmem_register(m48t59->rtc, &nvmem_cfg);
 	if (ret)
 		return ret;
 
diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 2b1135590dd5..182cfe59e4e0 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -259,7 +259,7 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	rtc_nvmem_register(info->rtc, &m48t86_nvmem_cfg);
+	devm_rtc_nvmem_register(info->rtc, &m48t86_nvmem_cfg);
 
 	/* read battery status */
 	reg = m48t86_readb(&pdev->dev, M48T86_D);
diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
index 47ebcf834cc2..938267713a4d 100644
--- a/drivers/rtc/rtc-meson.c
+++ b/drivers/rtc/rtc-meson.c
@@ -365,7 +365,7 @@ static int meson_rtc_probe(struct platform_device *pdev)
 	}
 
 	meson_rtc_nvmem_config.priv = rtc;
-	ret = rtc_nvmem_register(rtc->rtc, &meson_rtc_nvmem_config);
+	ret = devm_rtc_nvmem_register(rtc->rtc, &meson_rtc_nvmem_config);
 	if (ret)
 		goto out_disable_vdd;
 
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 18ae2a4f26ea..d165367a152c 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -891,7 +891,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_deregister_pinctrl;
 
-	rtc_nvmem_register(rtc->rtc, &omap_rtc_nvmem_config);
+	devm_rtc_nvmem_register(rtc->rtc, &omap_rtc_nvmem_config);
 
 	if (rtc->is_pmic_controller) {
 		if (!pm_power_off) {
diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 715513311ece..cb6bd7cae927 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -610,7 +610,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 			.size = 512,
 		};
 
-		ret = rtc_nvmem_register(pcf2127->rtc, &nvmem_cfg);
+		ret = devm_rtc_nvmem_register(pcf2127->rtc, &nvmem_cfg);
 	}
 
 	/*
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 449204d84c61..ad07ef654f6b 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -606,7 +606,7 @@ static int pcf85063_probe(struct i2c_client *client)
 	}
 
 	nvmem_cfg.priv = pcf85063->regmap;
-	rtc_nvmem_register(pcf85063->rtc, &nvmem_cfg);
+	devm_rtc_nvmem_register(pcf85063->rtc, &nvmem_cfg);
 
 #ifdef CONFIG_COMMON_CLK
 	/* register clk in common clk framework */
diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 3450d615974d..23cf14ca2c96 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -422,7 +422,7 @@ static int pcf85363_probe(struct i2c_client *client,
 
 	for (i = 0; i < config->num_nvram; i++) {
 		nvmem_cfg[i].priv = pcf85363;
-		rtc_nvmem_register(pcf85363->rtc, &nvmem_cfg[i]);
+		devm_rtc_nvmem_register(pcf85363->rtc, &nvmem_cfg[i]);
 	}
 
 	return ret;
diff --git a/drivers/rtc/rtc-rp5c01.c b/drivers/rtc/rtc-rp5c01.c
index a69e8adcc4a1..8bc476c0905f 100644
--- a/drivers/rtc/rtc-rp5c01.c
+++ b/drivers/rtc/rtc-rp5c01.c
@@ -255,7 +255,7 @@ static int __init rp5c01_rtc_probe(struct platform_device *dev)
 	priv->rtc = rtc;
 
 	nvmem_cfg.priv = priv;
-	error = rtc_nvmem_register(rtc, &nvmem_cfg);
+	error = devm_rtc_nvmem_register(rtc, &nvmem_cfg);
 	if (error)
 		return error;
 
diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index fa226f0fe67d..f788df979750 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -891,9 +891,9 @@ static int rv3028_probe(struct i2c_client *client)
 		return ret;
 
 	nvmem_cfg.priv = rv3028->regmap;
-	rtc_nvmem_register(rv3028->rtc, &nvmem_cfg);
+	devm_rtc_nvmem_register(rv3028->rtc, &nvmem_cfg);
 	eeprom_cfg.priv = rv3028;
-	rtc_nvmem_register(rv3028->rtc, &eeprom_cfg);
+	devm_rtc_nvmem_register(rv3028->rtc, &eeprom_cfg);
 
 	rv3028->rtc->max_user_freq = 1;
 
diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 62718231731b..ad359b3b74b2 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -755,7 +755,7 @@ static int rv3029_probe(struct device *dev, struct regmap *regmap, int irq,
 		return rc;
 
 	nvmem_cfg.priv = rv3029->regmap;
-	rtc_nvmem_register(rv3029->rtc, &nvmem_cfg);
+	devm_rtc_nvmem_register(rv3029->rtc, &nvmem_cfg);
 
 	return 0;
 }
diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
index e7b343a7ef02..6ad7665c6dab 100644
--- a/drivers/rtc/rtc-rv3032.c
+++ b/drivers/rtc/rtc-rv3032.c
@@ -890,9 +890,9 @@ static int rv3032_probe(struct i2c_client *client)
 		return ret;
 
 	nvmem_cfg.priv = rv3032->regmap;
-	rtc_nvmem_register(rv3032->rtc, &nvmem_cfg);
+	devm_rtc_nvmem_register(rv3032->rtc, &nvmem_cfg);
 	eeprom_cfg.priv = rv3032;
-	rtc_nvmem_register(rv3032->rtc, &eeprom_cfg);
+	devm_rtc_nvmem_register(rv3032->rtc, &eeprom_cfg);
 
 	rv3032->rtc->max_user_freq = 1;
 
diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 1d888da48c7c..44e1818a751c 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -591,7 +591,7 @@ static int rv8803_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	rtc_nvmem_register(rv8803->rtc, &nvmem_cfg);
+	devm_rtc_nvmem_register(rv8803->rtc, &nvmem_cfg);
 
 	rv8803->rtc->max_user_freq = 1;
 
diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index 490f70f57636..017f74721cc0 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -302,7 +302,7 @@ static int rx8581_probe(struct i2c_client *client,
 
 	for (i = 0; i < config->num_nvram; i++) {
 		nvmem_cfg[i].priv = rx8581;
-		rtc_nvmem_register(rx8581->rtc, &nvmem_cfg[i]);
+		devm_rtc_nvmem_register(rx8581->rtc, &nvmem_cfg[i]);
 	}
 
 	return ret;
diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index 1ccf0d5d05b4..ad616bce7bca 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -313,7 +313,7 @@ static int stk17ta8_rtc_probe(struct platform_device *pdev)
 	pdata->rtc->ops = &stk17ta8_rtc_ops;
 
 	nvmem_cfg.priv = pdata;
-	ret = rtc_nvmem_register(pdata->rtc, &nvmem_cfg);
+	ret = devm_rtc_nvmem_register(pdata->rtc, &nvmem_cfg);
 	if (ret)
 		return ret;
 
diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index abbb62b14d7a..11f46272bad3 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -271,7 +271,7 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 	pdata->rtc = rtc;
 
 	nvmem_cfg.priv = pdata;
-	ret = rtc_nvmem_register(rtc, &nvmem_cfg);
+	ret = devm_rtc_nvmem_register(rtc, &nvmem_cfg);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 0983ab9faffb..cbca651d8ca4 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -244,11 +244,11 @@ extern int rtc_hctosys_ret;
 #endif
 
 #ifdef CONFIG_RTC_NVMEM
-int rtc_nvmem_register(struct rtc_device *rtc,
-		       struct nvmem_config *nvmem_config);
+int devm_rtc_nvmem_register(struct rtc_device *rtc,
+			    struct nvmem_config *nvmem_config);
 #else
-static inline int rtc_nvmem_register(struct rtc_device *rtc,
-				     struct nvmem_config *nvmem_config)
+static inline int devm_rtc_nvmem_register(struct rtc_device *rtc,
+					  struct nvmem_config *nvmem_config)
 {
 	return 0;
 }
-- 
2.25.1


