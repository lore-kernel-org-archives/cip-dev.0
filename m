Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72601067057
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:32 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24578.1773329732002738870
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UQN7pEvM;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so15165725e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329730; x=1773934530; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bJB3oSNDRwG9otWK7Vq7nRYKJ3lDRH+4GOQXNnpnh4=;
        b=UQN7pEvMissv7KTkzJc4KfPsf+j724KXTnIilAzTagueGCablginl8Juda+RkoCm4n
         PlOvHlhlrDXYEkJSxNTxsuaocZHrXWC1YOWxrvHHrx/z+s24NiDKRack32g5NXLa7blm
         2xOWfMwiQ1kGyl2Kn7tTYouGZCBAC218Iwi29S4lp6oo61+ltcbNBEHKHgHU0ZAwH60q
         gJeS7he/APsrFAA/ag3szLcE2Z3xpvYL9hdNuFIgxvpr14uU+b3JnevZHduObRoRrrR1
         B73Mq7c/04fnhRz2JDTSSBB+/Jd7L0DCz8+/v4pj4GHtnME1gQ/JWaSWWsmeW3OVaNDv
         W8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329730; x=1773934530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1bJB3oSNDRwG9otWK7Vq7nRYKJ3lDRH+4GOQXNnpnh4=;
        b=MWZm/FHlVJaSRpt81gDxES0AB4n4JmCQ03TQT+R4UcZX739tpByavfgwOjKrrlf9Bp
         y6a/7gBphXutXXF0se8Kd/pe8d1dYKVT6873C5yxMZaXHnjQN9WjtPf8vzasE4zgjGkA
         znp+kahK4vcEFVlUtkT1+zZTduKEgNNyPVbeMh9NDI/9nbftytiIOw+bxDa+/L9iKaAi
         89otGxIOR8pid+TKffGzbZHk3IyB3XBs1+Ue+Z/NpmezI2y8cVN27BWnEWwg1lzA4oKd
         FfSxYHgjqv/ruaCOZyRoGDwkqPBCaqnEopz3FLCk8gI7xWpyKWuQP0QjVjPeSskFH/Js
         72xg==
X-Gm-Message-State: AOJu0Yw7xC/1Yz2xktCPHEkWAFFqopv3jlCOhCAMMqSN4hNtYecLIH7X
	nsU1/PwmXoPyPitIaAsLBOMlja4AVMTvIMDWSqUuagSVeOXz9Y6+ELvHBek0/Q==
X-Gm-Gg: ATEYQzy7+x2AH5N094py2iO5U/q/jk66FdIWU4WP6Nxufs/fGaMw1n0OpwFBgeGyHVF
	OyMNieSdnCNaVSAuQcTCSB1uHuC0/3ATKzywyaF/ZVcS6Sl/Bf1f3AVDUYn2n41mAZk5A8DWqFS
	MxvXu7kn3nmuig/fWXj0BF7V7cKi0BFwc/4gPLigvSHh19ctKfOPfINAOHahPBy+BMWNfWiERlr
	2Ihk/8vxusZ2MDH0uVj+RGN2dtQLmApSyQqWNT51M5TJLqPhiQNXFMVIFra1skz4vWkyA5C8STh
	ll6H5CTjAwM88l97UpteSJTW/DtqUA4xRtJf7ShOIoe4F59/4toaQ5NluO7LZ7BffzLvC1ENVJg
	JNefc1ep1hwJSUdW9nCcwQiEN6YWagZk8CvZnJjQZg1gq/NqRgWcuUdEFaWUXlok3egP5ZXhUCS
	oRFfoEssM9Y0HfhjDQzxYbTOW1TWGfwixxMRN5rk7O9HxtnLs=
X-Received: by 2002:a05:600c:a44:b0:485:4100:1eee with SMTP id 5b1f17b1804b1-4854b10c539mr114227315e9.24.1773329729929;
        Thu, 12 Mar 2026 08:35:29 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:29 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/11] phy: renesas: Add Renesas RZ/G3E USB3.0 PHY driver
Date: Thu, 12 Mar 2026 15:35:13 +0000
Message-ID: <20260312153522.1131675-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22364

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit ee5f1a3f90a4720f89fd1e250fa6754470da1510 ]

Add Renesas RZ/G3E USB3.0 PHY driver. This module is connected
between USB3 Host and PHY module. The main functions of this
module are:
 1) Reset control
 2) Control of PHY input pins
 3) Monitoring of PHY output pins

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251029084037.108610-3-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/phy/renesas/Kconfig          |   7 +
 drivers/phy/renesas/Makefile         |   1 +
 drivers/phy/renesas/phy-rzg3e-usb3.c | 259 +++++++++++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 drivers/phy/renesas/phy-rzg3e-usb3.c

diff --git a/drivers/phy/renesas/Kconfig b/drivers/phy/renesas/Kconfig
index e342eef0640b..16211072098e 100644
--- a/drivers/phy/renesas/Kconfig
+++ b/drivers/phy/renesas/Kconfig
@@ -40,3 +40,10 @@ config PHY_RCAR_GEN3_USB3
 	select GENERIC_PHY
 	help
 	  Support for USB 3.0 PHY found on Renesas R-Car generation 3 SoCs.
+
+config PHY_RZ_G3E_USB3
+	tristate "Renesas RZ/G3E USB 3.0 PHY driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select GENERIC_PHY
+	help
+	  Support for USB 3.0 PHY found on Renesas RZ/G3E SoCs.
diff --git a/drivers/phy/renesas/Makefile b/drivers/phy/renesas/Makefile
index 8896d1919faa..0e98083f2f0c 100644
--- a/drivers/phy/renesas/Makefile
+++ b/drivers/phy/renesas/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PHY_RCAR_GEN2)		+= phy-rcar-gen2.o
 obj-$(CONFIG_PHY_RCAR_GEN3_PCIE)	+= phy-rcar-gen3-pcie.o
 obj-$(CONFIG_PHY_RCAR_GEN3_USB2)	+= phy-rcar-gen3-usb2.o
 obj-$(CONFIG_PHY_RCAR_GEN3_USB3)	+= phy-rcar-gen3-usb3.o
+obj-$(CONFIG_PHY_RZ_G3E_USB3)		+= phy-rzg3e-usb3.o
diff --git a/drivers/phy/renesas/phy-rzg3e-usb3.c b/drivers/phy/renesas/phy-rzg3e-usb3.c
new file mode 100644
index 000000000000..6b3453ea0004
--- /dev/null
+++ b/drivers/phy/renesas/phy-rzg3e-usb3.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G3E USB3.0 PHY driver
+ *
+ * Copyright (C) 2025 Renesas Electronics Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#define USB3_TEST_RESET				0x0000
+#define USB3_TEST_UTMICTRL2			0x0b04
+#define USB3_TEST_PRMCTRL5_R			0x0c10
+#define USB3_TEST_PRMCTRL6_R			0x0c14
+
+#define USB3_TEST_RSTCTRL			0x1000
+#define USB3_TEST_CLKCTRL			0x1004
+#define USB3_TEST_RAMCTRL			0x100c
+#define USB3_TEST_CREGCTRL			0x1010
+#define USB3_TEST_LANECONFIG0			0x1030
+
+#define USB3_TEST_RESET_PORTRESET0_CTRL		BIT(9)
+#define USB3_TEST_RESET_SIDDQ			BIT(3)
+#define USB3_TEST_RESET_PHY_RESET		BIT(2)
+#define USB3_TEST_RESET_PORTRESET0		BIT(1)
+#define USB3_TEST_RESET_RELEASE_OVERRIDE	(0)
+
+#define USB3_TEST_UTMICTRL2_CTRL_MASK		GENMASK(9, 8)
+#define USB3_TEST_UTMICTRL2_MODE_MASK		GENMASK(1, 0)
+
+#define USB3_TEST_PRMCTRL5_R_TXPREEMPAMPTUNE0_MASK	GENMASK(2, 1)
+
+#define USB3_TEST_PRMCTRL6_R_OTGTUNE0_MASK	GENMASK(2, 0)
+
+#define USB3_TEST_RSTCTRL_HARDRESET_ODEN	BIT(9)
+#define USB3_TEST_RSTCTRL_PIPERESET_ODEN	BIT(8)
+#define USB3_TEST_RSTCTRL_HARDRESET		BIT(1)
+#define USB3_TEST_RSTCTRL_PIPERESET		BIT(0)
+#define USB3_TEST_RSTCTRL_ASSERT	\
+	(USB3_TEST_RSTCTRL_HARDRESET_ODEN | USB3_TEST_RSTCTRL_PIPERESET_ODEN | \
+	 USB3_TEST_RSTCTRL_HARDRESET | USB3_TEST_RSTCTRL_PIPERESET)
+#define USB3_TEST_RSTCTRL_RELEASE_HARDRESET	\
+	(USB3_TEST_RSTCTRL_HARDRESET_ODEN | USB3_TEST_RSTCTRL_PIPERESET_ODEN | \
+	 USB3_TEST_RSTCTRL_PIPERESET)
+#define USB3_TEST_RSTCTRL_DEASSERT	\
+	(USB3_TEST_RSTCTRL_HARDRESET_ODEN | USB3_TEST_RSTCTRL_PIPERESET_ODEN)
+#define USB3_TEST_RSTCTRL_RELEASE_OVERRIDE	(0)
+
+#define USB3_TEST_CLKCTRL_MPLLA_SSC_EN		BIT(2)
+
+#define USB3_TEST_RAMCTRL_SRAM_INIT_DONE	BIT(2)
+#define USB3_TEST_RAMCTRL_SRAM_EXT_LD_DONE	BIT(0)
+
+#define USB3_TEST_CREGCTRL_PARA_SEL		BIT(8)
+
+#define USB3_TEST_LANECONFIG0_DEFAULT		(0xd)
+
+struct rz_usb3 {
+	void __iomem *base;
+	struct reset_control *rstc;
+	bool skip_reinit;
+};
+
+static void rzg3e_phy_usb2test_phy_init(void __iomem *base)
+{
+	u32 val;
+
+	val = readl(base + USB3_TEST_UTMICTRL2);
+	val |= USB3_TEST_UTMICTRL2_CTRL_MASK | USB3_TEST_UTMICTRL2_MODE_MASK;
+	writel(val, base + USB3_TEST_UTMICTRL2);
+
+	val = readl(base + USB3_TEST_PRMCTRL5_R);
+	val &= ~USB3_TEST_PRMCTRL5_R_TXPREEMPAMPTUNE0_MASK;
+	val |= FIELD_PREP(USB3_TEST_PRMCTRL5_R_TXPREEMPAMPTUNE0_MASK, 2);
+	writel(val, base + USB3_TEST_PRMCTRL5_R);
+
+	val = readl(base + USB3_TEST_PRMCTRL6_R);
+	val &= ~USB3_TEST_PRMCTRL6_R_OTGTUNE0_MASK;
+	val |= FIELD_PREP(USB3_TEST_PRMCTRL6_R_OTGTUNE0_MASK, 7);
+	writel(val, base + USB3_TEST_PRMCTRL6_R);
+
+	val = readl(base + USB3_TEST_RESET);
+	val &= ~USB3_TEST_RESET_SIDDQ;
+	val |= USB3_TEST_RESET_PORTRESET0_CTRL | USB3_TEST_RESET_PHY_RESET |
+	       USB3_TEST_RESET_PORTRESET0;
+	writel(val, base + USB3_TEST_RESET);
+	fsleep(10);
+
+	val &= ~(USB3_TEST_RESET_PHY_RESET | USB3_TEST_RESET_PORTRESET0);
+	writel(val, base + USB3_TEST_RESET);
+	fsleep(10);
+
+	val = readl(base + USB3_TEST_UTMICTRL2);
+	val &= ~USB3_TEST_UTMICTRL2_CTRL_MASK;
+	writel(val, base + USB3_TEST_UTMICTRL2);
+
+	writel(USB3_TEST_RESET_RELEASE_OVERRIDE, base + USB3_TEST_RESET);
+}
+
+static int rzg3e_phy_usb3test_phy_init(void __iomem *base)
+{
+	int ret;
+	u32 val;
+
+	writel(USB3_TEST_CREGCTRL_PARA_SEL, base + USB3_TEST_CREGCTRL);
+	writel(USB3_TEST_RSTCTRL_ASSERT, base + USB3_TEST_RSTCTRL);
+	fsleep(20);
+
+	writel(USB3_TEST_CLKCTRL_MPLLA_SSC_EN, base + USB3_TEST_CLKCTRL);
+	writel(USB3_TEST_LANECONFIG0_DEFAULT, base + USB3_TEST_LANECONFIG0);
+	writel(USB3_TEST_RSTCTRL_RELEASE_HARDRESET, base + USB3_TEST_RSTCTRL);
+
+	ret = readl_poll_timeout_atomic(base + USB3_TEST_RAMCTRL, val,
+					val & USB3_TEST_RAMCTRL_SRAM_INIT_DONE, 1, 10000);
+	if (ret)
+		return ret;
+
+	writel(USB3_TEST_RSTCTRL_DEASSERT, base + USB3_TEST_RSTCTRL);
+	writel(USB3_TEST_RAMCTRL_SRAM_EXT_LD_DONE, base + USB3_TEST_RAMCTRL);
+	writel(USB3_TEST_RSTCTRL_RELEASE_OVERRIDE, base + USB3_TEST_RSTCTRL);
+
+	return 0;
+}
+
+static int rzg3e_phy_usb3_init_helper(void __iomem *base)
+{
+	rzg3e_phy_usb2test_phy_init(base);
+
+	return rzg3e_phy_usb3test_phy_init(base);
+}
+
+static int rzg3e_phy_usb3_init(struct phy *p)
+{
+	struct rz_usb3 *r = phy_get_drvdata(p);
+	int ret = 0;
+
+	if (!r->skip_reinit)
+		ret = rzg3e_phy_usb3_init_helper(r->base);
+
+	return ret;
+}
+
+static const struct phy_ops rzg3e_phy_usb3_ops = {
+	.init = rzg3e_phy_usb3_init,
+	.owner = THIS_MODULE,
+};
+
+static int rzg3e_phy_usb3_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
+	struct rz_usb3 *r;
+	struct phy *phy;
+	int ret;
+
+	r = devm_kzalloc(dev, sizeof(*r), GFP_KERNEL);
+	if (!r)
+		return -ENOMEM;
+
+	r->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(r->base))
+		return PTR_ERR(r->base);
+
+	r->rstc = devm_reset_control_get_shared_deasserted(dev, NULL);
+	if (IS_ERR(r->rstc))
+		return dev_err_probe(dev, PTR_ERR(r->rstc), "failed to get deasserted reset\n");
+
+	/*
+	 * devm_phy_create() will call pm_runtime_enable(&phy->dev);
+	 * And then, phy-core will manage runtime pm for this device.
+	 */
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0)
+		return ret;
+
+	phy = devm_phy_create(dev, NULL, &rzg3e_phy_usb3_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy), "failed to create USB3 PHY\n");
+
+	platform_set_drvdata(pdev, r);
+	phy_set_drvdata(phy, r);
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(provider))
+		return dev_err_probe(dev, PTR_ERR(provider), "failed to register PHY provider\n");
+
+	return 0;
+}
+
+static int rzg3e_phy_usb3_suspend(struct device *dev)
+{
+	struct rz_usb3 *r = dev_get_drvdata(dev);
+
+	pm_runtime_put(dev);
+	reset_control_assert(r->rstc);
+	r->skip_reinit = false;
+
+	return 0;
+}
+
+static int rzg3e_phy_usb3_resume(struct device *dev)
+{
+	struct rz_usb3 *r = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(r->rstc);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		goto reset_assert;
+
+	ret = rzg3e_phy_usb3_init_helper(r->base);
+	if (ret)
+		goto pm_put;
+
+	r->skip_reinit = true;
+
+	return 0;
+
+pm_put:
+	pm_runtime_put(dev);
+reset_assert:
+	reset_control_assert(r->rstc);
+	return ret;
+}
+
+static const struct dev_pm_ops rzg3e_phy_usb3_pm = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(rzg3e_phy_usb3_suspend, rzg3e_phy_usb3_resume)
+};
+
+static const struct of_device_id rzg3e_phy_usb3_match_table[] = {
+	{ .compatible = "renesas,r9a09g047-usb3-phy" },
+	{ /* Sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, rzg3e_phy_usb3_match_table);
+static struct platform_driver rzg3e_phy_usb3_driver = {
+	.driver = {
+		.name = "phy_rzg3e_usb3",
+		.of_match_table = rzg3e_phy_usb3_match_table,
+		.pm = pm_sleep_ptr(&rzg3e_phy_usb3_pm),
+	},
+	.probe	= rzg3e_phy_usb3_probe,
+};
+module_platform_driver(rzg3e_phy_usb3_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Renesas RZ/G3E USB3.0 PHY Driver");
+MODULE_AUTHOR("biju.das.jz@bp.renesas.com>");
-- 
2.43.0


