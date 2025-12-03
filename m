Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08F3D15D91
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:38:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18205.1764776281542836390
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 07:38:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: D13fsPK8RtuTF95IvbBwSw==
X-CSE-MsgGUID: RN2mFc7tQw2SqzVuazAvvQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Dec 2025 00:38:08 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5EDE540138F5;
	Thu,  4 Dec 2025 00:38:07 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 05/12] soc: renesas: rz-sysc: Add SoC identification for RZ/V2N SoC
Date: Wed,  3 Dec 2025 15:37:50 +0000
Message-ID: <20251203153757.32977-6-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 15:38:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20818

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3903b4701bc03d7d805c3df378a7fc2ff72cbef5 upstream.

Add SoC identification for the RZ/V2N SoC using the System Controller
(SYS) block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250415085438.83856-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/soc/renesas/Kconfig         |  5 ++
 drivers/soc/renesas/Makefile        |  1 +
 drivers/soc/renesas/r9a09g056-sys.c | 75 +++++++++++++++++++++++++++++
 drivers/soc/renesas/rz-sysc.c       |  3 ++
 drivers/soc/renesas/rz-sysc.h       |  1 +
 5 files changed, 85 insertions(+)
 create mode 100644 drivers/soc/renesas/r9a09g056-sys.c

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index e7cbdf39fb5f..121f0c928542 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -348,6 +348,7 @@ config ARCH_R9A09G047
 config ARCH_R9A09G056
 	bool "ARM64 Platform support for RZ/V2N"
 	default y if ARCH_RENESAS
+	select SYS_R9A09G056
 	help
 	  This enables support for the Renesas RZ/V2N SoC variants.
 
@@ -496,6 +497,10 @@ config SYS_R9A09G047
 	bool "Renesas RZ/G3E System controller support" if COMPILE_TEST
 	select SYSC_RZ
 
+config SYS_R9A09G056
+	bool "Renesas RZ/V2N System controller support" if COMPILE_TEST
+	select SYSC_RZ
+
 config SYS_R9A09G057
 	bool "Renesas RZ/V2H System controller support" if COMPILE_TEST
 	select SYSC_RZ
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index c49ab974090a..fa8ff3936cb7 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
 obj-$(CONFIG_SYSC_R9A08G045)	+= r9a08g045-sysc.o
 obj-$(CONFIG_SYS_R9A09G047)	+= r9a09g047-sys.o
+obj-$(CONFIG_SYS_R9A09G056)	+= r9a09g056-sys.o
 obj-$(CONFIG_SYS_R9A09G057)	+= r9a09g057-sys.o
 
 # Family
diff --git a/drivers/soc/renesas/r9a09g056-sys.c b/drivers/soc/renesas/r9a09g056-sys.c
new file mode 100644
index 000000000000..3ad1422eba36
--- /dev/null
+++ b/drivers/soc/renesas/r9a09g056-sys.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/V2N System controller (SYS) driver
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
+#define SYS_LSI_MODE_SEC_EN	BIT(16)
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
+#define SYS_LSI_PRR_GPU_DIS		BIT(0)
+#define SYS_LSI_PRR_ISP_DIS		BIT(4)
+
+#define SYS_RZV2N_FEATURE_G31		BIT(0)
+#define SYS_RZV2N_FEATURE_C55		BIT(1)
+#define SYS_RZV2N_FEATURE_SEC		BIT(2)
+
+static void rzv2n_sys_print_id(struct device *dev,
+			       void __iomem *sysc_base,
+			       struct soc_device_attribute *soc_dev_attr)
+{
+	u32 prr_val, mode_val;
+	u8 feature_flags;
+
+	prr_val = readl(sysc_base + SYS_LSI_PRR);
+	mode_val = readl(sysc_base + SYS_LSI_MODE);
+
+	/* Check GPU, ISP and Cryptographic configuration */
+	feature_flags = !(prr_val & SYS_LSI_PRR_GPU_DIS) ? SYS_RZV2N_FEATURE_G31 : 0;
+	feature_flags |= !(prr_val & SYS_LSI_PRR_ISP_DIS) ? SYS_RZV2N_FEATURE_C55 : 0;
+	feature_flags |= (mode_val & SYS_LSI_MODE_SEC_EN) ? SYS_RZV2N_FEATURE_SEC : 0;
+
+	dev_info(dev, "Detected Renesas %s %sn%d Rev %s%s%s%s%s\n", soc_dev_attr->family,
+		 soc_dev_attr->soc_id, 41 + feature_flags, soc_dev_attr->revision,
+		 feature_flags ?  " with" : "",
+		 feature_flags & SYS_RZV2N_FEATURE_G31 ? " GE3D (Mali-G31)" : "",
+		 feature_flags & SYS_RZV2N_FEATURE_SEC ? " Cryptographic engine" : "",
+		 feature_flags & SYS_RZV2N_FEATURE_C55 ? " ISP (Mali-C55)" : "");
+
+	/* Check CA55 PLL configuration */
+	if (FIELD_GET(SYS_LSI_MODE_STAT_BOOTPLLCA55, mode_val) != SYS_LSI_MODE_CA55_1_7GHZ)
+		dev_warn(dev, "CA55 PLL is not set to 1.7GHz\n");
+}
+
+static const struct rz_sysc_soc_id_init_data rzv2n_sys_soc_id_init_data __initconst = {
+	.family = "RZ/V2N",
+	.id = 0x867d447,
+	.devid_offset = 0x304,
+	.revision_mask = GENMASK(31, 28),
+	.specific_id_mask = GENMASK(27, 0),
+	.print_id = rzv2n_sys_print_id,
+};
+
+const struct rz_sysc_init_data rzv2n_sys_init_data = {
+	.soc_id_init_data = &rzv2n_sys_soc_id_init_data,
+};
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index 14db508f669f..ffa65fb4dade 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -88,6 +88,9 @@ static const struct of_device_id rz_sysc_match[] = {
 #ifdef CONFIG_SYS_R9A09G047
 	{ .compatible = "renesas,r9a09g047-sys", .data = &rzg3e_sys_init_data },
 #endif
+#ifdef CONFIG_SYS_R9A09G056
+	{ .compatible = "renesas,r9a09g056-sys", .data = &rzv2n_sys_init_data },
+#endif
 #ifdef CONFIG_SYS_R9A09G057
 	{ .compatible = "renesas,r9a09g057-sys", .data = &rzv2h_sys_init_data },
 #endif
diff --git a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h
index aa83948c5117..56bc047a1bff 100644
--- a/drivers/soc/renesas/rz-sysc.h
+++ b/drivers/soc/renesas/rz-sysc.h
@@ -42,5 +42,6 @@ struct rz_sysc_init_data {
 extern const struct rz_sysc_init_data rzg3e_sys_init_data;
 extern const struct rz_sysc_init_data rzg3s_sysc_init_data;
 extern const struct rz_sysc_init_data rzv2h_sys_init_data;
+extern const struct rz_sysc_init_data rzv2n_sys_init_data;
 
 #endif /* __SOC_RENESAS_RZ_SYSC_H__ */
-- 
2.51.0


