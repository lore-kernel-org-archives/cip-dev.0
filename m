Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E0FC369D7
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:15:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5123.1745583302342089664
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 05:15:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: ZAtPa/aiT2umc0f4+vH/qg==
X-CSE-MsgGUID: d28iSanRSGqgRSGqRf9fJg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Apr 2025 21:15:05 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 506EA42D7EC8;
	Fri, 25 Apr 2025 21:15:04 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 08/21] soc: renesas: rz-sysc: Add support for RZ/G3E family
Date: Fri, 25 Apr 2025 13:14:32 +0100
Message-ID: <20250425121445.62818-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 12:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18630

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit d07470cff53b3cfc68a3653c36fbf8ffd1ddaf3c upstream.

Add SoC detection support for the RZ/G3E SoC.  Also add support for
detecting the number of cores and the ETHOS-U55 NPU, and also detect PLL
mismatch for SW settings other than 1.7GHz.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250128031342.52675-4-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig         |  5 +++
 drivers/soc/renesas/Makefile        |  1 +
 drivers/soc/renesas/r9a09g047-sys.c | 67 +++++++++++++++++++++++++++++
 drivers/soc/renesas/rz-sysc.c       | 12 +++++-
 drivers/soc/renesas/rz-sysc.h       |  6 +++
 5 files changed, 89 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/renesas/r9a09g047-sys.c

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 9530bfe7a3bf5..d27248f4828fa 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -341,6 +341,7 @@ config ARCH_R9A09G011
 
 config ARCH_R9A09G047
 	bool "ARM64 Platform support for RZ/G3E"
+	select SYS_R9A09G047
 	help
 	  This enables support for the Renesas RZ/G3E SoC variants.
 
@@ -483,4 +484,8 @@ config SYSC_R9A08G045
 	bool "Renesas RZ/G3S System controller support" if COMPILE_TEST
 	select SYSC_RZ
 
+config SYS_R9A09G047
+	bool "Renesas RZ/G3E System controller support" if COMPILE_TEST
+	select SYSC_RZ
+
 endif # SOC_RENESAS
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 9e60c84496955..8ef5a389f9167 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -31,6 +31,7 @@ ifdef CONFIG_SMP
 obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
 obj-$(CONFIG_SYSC_R9A08G045)	+= r9a08g045-sysc.o
+obj-$(CONFIG_SYS_R9A09G047)	+= r9a09g047-sys.o
 
 # Family
 obj-$(CONFIG_PWC_RZV2M)		+= pwc-rzv2m.o
diff --git a/drivers/soc/renesas/r9a09g047-sys.c b/drivers/soc/renesas/r9a09g047-sys.c
new file mode 100644
index 0000000000000..cd2eb7782cfe6
--- /dev/null
+++ b/drivers/soc/renesas/r9a09g047-sys.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G3E System controller (SYS) driver
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include "rz-sysc.h"
+
+/* Register Offsets */
+#define SYS_LSI_MODE		0x300
+/*
+ * BOOTPLLCA[1:0]
+ *	    [0,0] => 1.1GHZ
+ *	    [0,1] => 1.5GHZ
+ *	    [1,0] => 1.6GHZ
+ *	    [1,1] => 1.7GHZ
+ */
+#define SYS_LSI_MODE_STAT_BOOTPLLCA55	GENMASK(12, 11)
+#define SYS_LSI_MODE_CA55_1_7GHZ	0x3
+
+#define SYS_LSI_PRR			0x308
+#define SYS_LSI_PRR_CA55_DIS		BIT(8)
+#define SYS_LSI_PRR_NPU_DIS		BIT(1)
+
+static void rzg3e_sys_print_id(struct device *dev,
+				void __iomem *sysc_base,
+				struct soc_device_attribute *soc_dev_attr)
+{
+	bool is_quad_core, npu_enabled;
+	u32 prr_val, mode_val;
+
+	prr_val = readl(sysc_base + SYS_LSI_PRR);
+	mode_val = readl(sysc_base + SYS_LSI_MODE);
+
+	/* Check CPU and NPU configuration */
+	is_quad_core = !(prr_val & SYS_LSI_PRR_CA55_DIS);
+	npu_enabled = !(prr_val & SYS_LSI_PRR_NPU_DIS);
+
+	dev_info(dev, "Detected Renesas %s Core %s %s Rev %s%s\n",
+		 is_quad_core ? "Quad" : "Dual", soc_dev_attr->family,
+		 soc_dev_attr->soc_id, soc_dev_attr->revision,
+		 npu_enabled ? " with Ethos-U55" : "");
+
+	/* Check CA55 PLL configuration */
+	if (FIELD_GET(SYS_LSI_MODE_STAT_BOOTPLLCA55, mode_val) != SYS_LSI_MODE_CA55_1_7GHZ)
+		dev_warn(dev, "CA55 PLL is not set to 1.7GHz\n");
+}
+
+static const struct rz_sysc_soc_id_init_data rzg3e_sys_soc_id_init_data __initconst = {
+	.family = "RZ/G3E",
+	.id = 0x8679447,
+	.devid_offset = 0x304,
+	.revision_mask = GENMASK(31, 28),
+	.specific_id_mask = GENMASK(27, 0),
+	.print_id = rzg3e_sys_print_id,
+};
+
+const struct rz_sysc_init_data rzg3e_sys_init_data = {
+	.soc_id_init_data = &rzg3e_sys_soc_id_init_data,
+};
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index de603cea4fabf..70a0f19316333 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -66,8 +66,13 @@ static int rz_sysc_soc_init(struct rz_sysc *sysc, const struct of_device_id *mat
 		return -ENODEV;
 	}
 
-	dev_info(sysc->dev, "Detected Renesas %s %s Rev %s\n", soc_dev_attr->family,
-		 soc_dev_attr->soc_id, soc_dev_attr->revision);
+	/* Try to call SoC-specific device identification */
+	if (soc_data->print_id) {
+		soc_data->print_id(sysc->dev, sysc->base, soc_dev_attr);
+	} else {
+		dev_info(sysc->dev, "Detected Renesas %s %s Rev %s\n",
+			 soc_dev_attr->family, soc_dev_attr->soc_id, soc_dev_attr->revision);
+	}
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev))
@@ -79,6 +84,9 @@ static int rz_sysc_soc_init(struct rz_sysc *sysc, const struct of_device_id *mat
 static const struct of_device_id rz_sysc_match[] = {
 #ifdef CONFIG_SYSC_R9A08G045
 	{ .compatible = "renesas,r9a08g045-sysc", .data = &rzg3s_sysc_init_data },
+#endif
+#ifdef CONFIG_SYS_R9A09G047
+	{ .compatible = "renesas,r9a09g047-sys", .data = &rzg3e_sys_init_data },
 #endif
 	{ }
 };
diff --git a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h
index 908f09fa4fc98..4e70b77433a3e 100644
--- a/drivers/soc/renesas/rz-sysc.h
+++ b/drivers/soc/renesas/rz-sysc.h
@@ -8,6 +8,8 @@
 #ifndef __SOC_RENESAS_RZ_SYSC_H__
 #define __SOC_RENESAS_RZ_SYSC_H__
 
+#include <linux/device.h>
+#include <linux/sys_soc.h>
 #include <linux/types.h>
 
 /**
@@ -17,6 +19,7 @@
  * @devid_offset: SYSC SoC ID register offset
  * @revision_mask: SYSC SoC ID revision mask
  * @specific_id_mask: SYSC SoC ID specific ID mask
+ * @print_id: print SoC-specific extended device identification
  */
 struct rz_sysc_soc_id_init_data {
 	const char * const family;
@@ -24,6 +27,8 @@ struct rz_sysc_soc_id_init_data {
 	u32 devid_offset;
 	u32 revision_mask;
 	u32 specific_id_mask;
+	void (*print_id)(struct device *dev, void __iomem *sysc_base,
+			 struct soc_device_attribute *soc_dev_attr);
 };
 
 /**
@@ -34,6 +39,7 @@ struct rz_sysc_init_data {
 	const struct rz_sysc_soc_id_init_data *soc_id_init_data;
 };
 
+extern const struct rz_sysc_init_data rzg3e_sys_init_data;
 extern const struct rz_sysc_init_data rzg3s_sysc_init_data;
 
 #endif /* __SOC_RENESAS_RZ_SYSC_H__ */
-- 
2.43.0


