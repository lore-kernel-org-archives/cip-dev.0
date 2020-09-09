Return-Path: <SRS0=h7IU=CS=lists.cip-project.org=bounce+64572+5421+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5496CC2D0E1
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6E621D47
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Azt2ApLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6E621D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5421+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id p1w0YY4521723xh6MaGsBKr3; Tue, 08 Sep 2020 21:44:43 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.6684.1599626681625055740
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:42 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id E63B75FD2B; Wed,  9 Sep 2020 12:44:32 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 04/11] cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
Date: Wed,  9 Sep 2020 12:42:26 +0800
Message-Id: <20200909044233.4115-5-wens@csie.org>
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2RR7C1CtwyQhfJIVwNkqIRYwx4520388AA=
Content-Type: multipart/mixed; boundary="459Ob9VwnmdxKsy4pCem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626683;
 bh=xNckWPY+fWxndrhpXLlR1s0AbDcixRha+ifiOD6eoZY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Azt2ApLB+AeJJETbTwUwTB/sA5eVHRihh+c6QInJf8S7Le2iOBAsL8GLYablCxp/zYE
 Ezu4nniNewY12f8z7Rr3oC/PkUoLRSjXr3fEWDe0Brif9oFBUlu+SJp99c2UD99kYS9HO
 XXVXqlVGnNmEQH7Q/Sb/lNm5AQeVrPUUGN0=

--459Ob9VwnmdxKsy4pCem
Content-Transfer-Encoding: quoted-printable

From: Dave Gerlach <d-gerlach@ti.com>

commit e13cf046cd70894393a1085ca39da7ef751353fb upstream.

Some TI SoCs, like those in the AM335x, AM437x, DRA7x, and AM57x families=
,
have different OPPs available for the MPU depending on which specific
variant of the SoC is in use. This can be determined through use of the
revision and an eFuse register present in the silicon. Introduce a
ti-cpufreq driver that can read the aformentioned values and provide
them as version matching data to the opp framework. Through this the
opp-supported-hw dt binding that is part of the operating-points-v2
table can be used to indicate availability of OPPs for each device.

This driver also creates the "cpufreq-dt" platform_device after passing
the version matching data to the OPP framework so that the cpufreq-dt
handles the actual cpufreq implementation. Even without the necessary
data to pass the version matching data the driver will still create this
device to maintain backwards compatibility with operating-points v1
tables.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/Kconfig.arm  |  11 ++
 drivers/cpufreq/Makefile     |   1 +
 drivers/cpufreq/ti-cpufreq.c | 272 +++++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 drivers/cpufreq/ti-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index eed1e073d96d7..6b834112d857b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -231,6 +231,17 @@ config ARM_TEGRA124_CPUFREQ
 	help
 	  This adds the CPUFreq driver support for Tegra124 SOCs.
=20
+config ARM_TI_CPUFREQ
+	bool "Texas Instruments CPUFreq support"
+	depends on ARCH_OMAP2PLUS
+	help
+	  This driver enables valid OPPs on the running platform based on
+	  values contained within the SoC in use. Enable this in order to
+	  use the cpufreq-dt driver on all Texas Instruments platforms that
+	  provide dt based operating-points-v2 tables with opp-supported-hw
+	  data provided. Required for cpufreq support on AM335x, AM437x,
+	  DRA7x, and AM57x platforms.
+
 config ARM_PXA2xx_CPUFREQ
 	tristate "Intel PXA2xx CPUfreq driver"
 	depends on PXA27x || PXA25x
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index c0af1a1281c89..6e889596d9a12 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+=3D scpi-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+=3D spear-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+=3D tegra20-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+=3D tegra124-cpufreq.o
+obj-$(CONFIG_ARM_TI_CPUFREQ)		+=3D ti-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+=3D vexpress-spc-cpufreq.o
 obj-$(CONFIG_ACPI_CPPC_CPUFREQ) +=3D cppc_cpufreq.o
=20
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
new file mode 100644
index 0000000000000..7ff7ae3c3911c
--- /dev/null
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -0,0 +1,272 @@
+/*
+ * TI CPUFreq/OPP hw-supported driver
+ *
+ * Copyright (C) 2016-2017 Texas Instruments, Inc.
+ *	 Dave Gerlach <d-gerlach@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/cpu.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pm_opp.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define REVISION_MASK				0xF
+#define REVISION_SHIFT				28
+
+#define AM33XX_800M_ARM_MPU_MAX_FREQ		0x1E2F
+#define AM43XX_600M_ARM_MPU_MAX_FREQ		0xFFA
+
+#define DRA7_EFUSE_HAS_OD_MPU_OPP		11
+#define DRA7_EFUSE_HAS_HIGH_MPU_OPP		15
+#define DRA7_EFUSE_HAS_ALL_MPU_OPP		23
+
+#define DRA7_EFUSE_NOM_MPU_OPP			BIT(0)
+#define DRA7_EFUSE_OD_MPU_OPP			BIT(1)
+#define DRA7_EFUSE_HIGH_MPU_OPP			BIT(2)
+
+#define VERSION_COUNT				2
+
+struct ti_cpufreq_data;
+
+struct ti_cpufreq_soc_data {
+	unsigned long (*efuse_xlate)(struct ti_cpufreq_data *opp_data,
+				     unsigned long efuse);
+	unsigned long efuse_fallback;
+	unsigned long efuse_offset;
+	unsigned long efuse_mask;
+	unsigned long efuse_shift;
+	unsigned long rev_offset;
+};
+
+struct ti_cpufreq_data {
+	struct device *cpu_dev;
+	struct device_node *opp_node;
+	struct regmap *syscon;
+	const struct ti_cpufreq_soc_data *soc_data;
+};
+
+static unsigned long amx3_efuse_xlate(struct ti_cpufreq_data *opp_data,
+				      unsigned long efuse)
+{
+	if (!efuse)
+		efuse =3D opp_data->soc_data->efuse_fallback;
+	/* AM335x and AM437x use "OPP disable" bits, so invert */
+	return ~efuse;
+}
+
+static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
+				      unsigned long efuse)
+{
+	unsigned long calculated_efuse =3D DRA7_EFUSE_NOM_MPU_OPP;
+
+	/*
+	 * The efuse on dra7 and am57 parts contains a specific
+	 * value indicating the highest available OPP.
+	 */
+
+	switch (efuse) {
+	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
+	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
+		calculated_efuse |=3D DRA7_EFUSE_HIGH_MPU_OPP;
+	case DRA7_EFUSE_HAS_OD_MPU_OPP:
+		calculated_efuse |=3D DRA7_EFUSE_OD_MPU_OPP;
+	}
+
+	return calculated_efuse;
+}
+
+static struct ti_cpufreq_soc_data am3x_soc_data =3D {
+	.efuse_xlate =3D amx3_efuse_xlate,
+	.efuse_fallback =3D AM33XX_800M_ARM_MPU_MAX_FREQ,
+	.efuse_offset =3D 0x07fc,
+	.efuse_mask =3D 0x1fff,
+	.rev_offset =3D 0x600,
+};
+
+static struct ti_cpufreq_soc_data am4x_soc_data =3D {
+	.efuse_xlate =3D amx3_efuse_xlate,
+	.efuse_fallback =3D AM43XX_600M_ARM_MPU_MAX_FREQ,
+	.efuse_offset =3D 0x0610,
+	.efuse_mask =3D 0x3f,
+	.rev_offset =3D 0x600,
+};
+
+static struct ti_cpufreq_soc_data dra7_soc_data =3D {
+	.efuse_xlate =3D dra7_efuse_xlate,
+	.efuse_offset =3D 0x020c,
+	.efuse_mask =3D 0xf80000,
+	.efuse_shift =3D 19,
+	.rev_offset =3D 0x204,
+};
+
+/**
+ * ti_cpufreq_get_efuse() - Parse and return efuse value present on SoC
+ * @opp_data: pointer to ti_cpufreq_data context
+ * @efuse_value: Set to the value parsed from efuse
+ *
+ * Returns error code if efuse not read properly.
+ */
+static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
+				u32 *efuse_value)
+{
+	struct device *dev =3D opp_data->cpu_dev;
+	u32 efuse;
+	int ret;
+
+	ret =3D regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
+			  &efuse);
+	if (ret) {
+		dev_err(dev,
+			"Failed to read the efuse value from syscon: %d\n",
+			ret);
+		return ret;
+	}
+
+	efuse =3D (efuse & opp_data->soc_data->efuse_mask);
+	efuse >>=3D opp_data->soc_data->efuse_shift;
+
+	*efuse_value =3D opp_data->soc_data->efuse_xlate(opp_data, efuse);
+
+	return 0;
+}
+
+/**
+ * ti_cpufreq_get_rev() - Parse and return rev value present on SoC
+ * @opp_data: pointer to ti_cpufreq_data context
+ * @revision_value: Set to the value parsed from revision register
+ *
+ * Returns error code if revision not read properly.
+ */
+static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
+			      u32 *revision_value)
+{
+	struct device *dev =3D opp_data->cpu_dev;
+	u32 revision;
+	int ret;
+
+	ret =3D regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
+			  &revision);
+	if (ret) {
+		dev_err(dev,
+			"Failed to read the revision number from syscon: %d\n",
+			ret);
+		return ret;
+	}
+
+	*revision_value =3D BIT((revision >> REVISION_SHIFT) & REVISION_MASK);
+
+	return 0;
+}
+
+static int ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_=
data)
+{
+	struct device *dev =3D opp_data->cpu_dev;
+	struct device_node *np =3D opp_data->opp_node;
+
+	opp_data->syscon =3D syscon_regmap_lookup_by_phandle(np,
+							"syscon");
+	if (IS_ERR(opp_data->syscon)) {
+		dev_err(dev,
+			"\"syscon\" is missing, cannot use OPPv2 table.\n");
+		return PTR_ERR(opp_data->syscon);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ti_cpufreq_of_match[] =3D {
+	{ .compatible =3D "ti,am33xx", .data =3D &am3x_soc_data, },
+	{ .compatible =3D "ti,am4372", .data =3D &am4x_soc_data, },
+	{ .compatible =3D "ti,dra7", .data =3D &dra7_soc_data },
+	{},
+};
+
+static int ti_cpufreq_init(void)
+{
+	u32 version[VERSION_COUNT];
+	struct device_node *np;
+	const struct of_device_id *match;
+	struct ti_cpufreq_data *opp_data;
+	int ret;
+
+	np =3D of_find_node_by_path("/");
+	match =3D of_match_node(ti_cpufreq_of_match, np);
+	if (!match)
+		return -ENODEV;
+
+	opp_data =3D kzalloc(sizeof(*opp_data), GFP_KERNEL);
+	if (!opp_data)
+		return -ENOMEM;
+
+	opp_data->soc_data =3D match->data;
+
+	opp_data->cpu_dev =3D get_cpu_device(0);
+	if (!opp_data->cpu_dev) {
+		pr_err("%s: Failed to get device for CPU0\n", __func__);
+		return -ENODEV;
+	}
+
+	opp_data->opp_node =3D dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_de=
v);
+	if (!opp_data->opp_node) {
+		dev_info(opp_data->cpu_dev,
+			 "OPP-v2 not supported, cpufreq-dt will attempt to use legacy tables.=
\n");
+		goto register_cpufreq_dt;
+	}
+
+	ret =3D ti_cpufreq_setup_syscon_register(opp_data);
+	if (ret)
+		goto fail_put_node;
+
+	/*
+	 * OPPs determine whether or not they are supported based on
+	 * two metrics:
+	 *	0 - SoC Revision
+	 *	1 - eFuse value
+	 */
+	ret =3D ti_cpufreq_get_rev(opp_data, &version[0]);
+	if (ret)
+		goto fail_put_node;
+
+	ret =3D ti_cpufreq_get_efuse(opp_data, &version[1]);
+	if (ret)
+		goto fail_put_node;
+
+	of_node_put(opp_data->opp_node);
+
+	ret =3D PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
+							  version, VERSION_COUNT));
+	if (ret) {
+		dev_err(opp_data->cpu_dev,
+			"Failed to set supported hardware\n");
+		goto fail_put_node;
+	}
+
+register_cpufreq_dt:
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+
+	return 0;
+
+fail_put_node:
+	of_node_put(opp_data->opp_node);
+
+	return ret;
+}
+module_init(ti_cpufreq_init);
+
+MODULE_DESCRIPTION("TI CPUFreq/OPP hw-supported driver");
+MODULE_AUTHOR("Dave Gerlach <d-gerlach@ti.com>");
+MODULE_LICENSE("GPL v2");
--=20
2.28.0


--459Ob9VwnmdxKsy4pCem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5421): https://lists.cip-project.org/g/cip-dev/message=
/5421
Mute This Topic: https://lists.cip-project.org/mt/76726425/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--459Ob9VwnmdxKsy4pCem--
