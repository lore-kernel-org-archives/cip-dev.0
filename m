Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD4FC369D5
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:15:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.5125.1745583308658722051
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 05:15:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: fJur4V1qRAqry5zLTTG8ew==
X-CSE-MsgGUID: ITrVnrAvR+uKOJ6IBHwxBA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Apr 2025 21:15:08 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7AF8842D7EC8;
	Fri, 25 Apr 2025 21:15:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 09/21] soc: renesas: rz-sysc: Move RZ/V2H SoC detection to the SYS driver
Date: Fri, 25 Apr 2025 13:14:33 +0100
Message-ID: <20250425121445.62818-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 12:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18631

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit 4300f38467e71ce3cde978bf14ea1e696912b918 upstream.

As per the other SoC variant of the same family, the system controller
provides SoC ID in its own registers.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250128031342.52675-5-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig         |  5 +++++
 drivers/soc/renesas/Makefile        |  1 +
 drivers/soc/renesas/r9a09g057-sys.c | 25 +++++++++++++++++++++++++
 drivers/soc/renesas/renesas-soc.c   | 21 +--------------------
 drivers/soc/renesas/rz-sysc.c       |  3 +++
 drivers/soc/renesas/rz-sysc.h       |  1 +
 6 files changed, 36 insertions(+), 20 deletions(-)
 create mode 100644 drivers/soc/renesas/r9a09g057-sys.c

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index d27248f4828fa..a0d17933e410b 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -347,6 +347,7 @@ config ARCH_R9A09G047
 
 config ARCH_R9A09G057
 	bool "ARM64 Platform support for RZ/V2H(P)"
+	select SYS_R9A09G057
 	help
 	  This enables support for the Renesas RZ/V2H(P) SoC variants.
 
@@ -488,4 +489,8 @@ config SYS_R9A09G047
 	bool "Renesas RZ/G3E System controller support" if COMPILE_TEST
 	select SYSC_RZ
 
+config SYS_R9A09G057
+	bool "Renesas RZ/V2H System controller support" if COMPILE_TEST
+	select SYSC_RZ
+
 endif # SOC_RENESAS
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 8ef5a389f9167..c49ab974090ad 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
 obj-$(CONFIG_SYSC_R9A08G045)	+= r9a08g045-sysc.o
 obj-$(CONFIG_SYS_R9A09G047)	+= r9a09g047-sys.o
+obj-$(CONFIG_SYS_R9A09G057)	+= r9a09g057-sys.o
 
 # Family
 obj-$(CONFIG_PWC_RZV2M)		+= pwc-rzv2m.o
diff --git a/drivers/soc/renesas/r9a09g057-sys.c b/drivers/soc/renesas/r9a09g057-sys.c
new file mode 100644
index 0000000000000..49a92de581b4c
--- /dev/null
+++ b/drivers/soc/renesas/r9a09g057-sys.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/V2H System controller (SYS) driver
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include "rz-sysc.h"
+
+static const struct rz_sysc_soc_id_init_data rzv2h_sys_soc_id_init_data __initconst = {
+	.family = "RZ/V2H",
+	.id = 0x847a447,
+	.devid_offset = 0x304,
+	.revision_mask = GENMASK(31, 28),
+	.specific_id_mask = GENMASK(27, 0),
+};
+
+const struct rz_sysc_init_data rzv2h_sys_init_data = {
+	.soc_id_init_data = &rzv2h_sys_soc_id_init_data,
+};
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index c00d20118cfb2..ca22ea0f3289f 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -72,10 +72,6 @@ static const struct renesas_family fam_rzg2ul __initconst __maybe_unused = {
 	.name	= "RZ/G2UL",
 };
 
-static const struct renesas_family fam_rzv2h __initconst __maybe_unused = {
-	.name	= "RZ/V2H",
-};
-
 static const struct renesas_family fam_rzv2l __initconst __maybe_unused = {
 	.name	= "RZ/V2L",
 };
@@ -174,11 +170,6 @@ static const struct renesas_soc soc_rz_g2ul __initconst __maybe_unused = {
 	.id     = 0x8450447,
 };
 
-static const struct renesas_soc soc_rz_v2h __initconst __maybe_unused = {
-	.family = &fam_rzv2h,
-	.id     = 0x847a447,
-};
-
 static const struct renesas_soc soc_rz_v2l __initconst __maybe_unused = {
 	.family = &fam_rzv2l,
 	.id     = 0x8447447,
@@ -277,7 +268,6 @@ static const struct renesas_soc soc_shmobile_ag5 __initconst __maybe_unused = {
 	.id	= 0x37,
 };
 
-
 static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
 #ifdef CONFIG_ARCH_R7S72100
 	{ .compatible = "renesas,r7s72100",	.data = &soc_rz_a1h },
@@ -400,9 +390,6 @@ static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
 #ifdef CONFIG_ARCH_R9A09G011
 	{ .compatible = "renesas,r9a09g011",	.data = &soc_rz_v2m },
 #endif
-#ifdef CONFIG_ARCH_R9A09G057
-	{ .compatible = "renesas,r9a09g057",	.data = &soc_rz_v2h },
-#endif
 #ifdef CONFIG_ARCH_SH73A0
 	{ .compatible = "renesas,sh73a0",	.data = &soc_shmobile_ag5 },
 #endif
@@ -428,11 +415,6 @@ static const struct renesas_id id_rzg2l __initconst = {
 	.mask = 0xfffffff,
 };
 
-static const struct renesas_id id_rzv2h __initconst = {
-	.offset = 0x304,
-	.mask = 0xfffffff,
-};
-
 static const struct renesas_id id_rzv2m __initconst = {
 	.offset = 0x104,
 	.mask = 0xff,
@@ -450,7 +432,6 @@ static const struct of_device_id renesas_ids[] __initconst = {
 	{ .compatible = "renesas,r9a07g054-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a08g045-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a09g011-sys",	.data = &id_rzv2m },
-	{ .compatible = "renesas,r9a09g057-sys",	.data = &id_rzv2h },
 	{ .compatible = "renesas,prr",			.data = &id_prr },
 	{ /* sentinel */ }
 };
@@ -519,7 +500,7 @@ static int __init renesas_soc_init(void)
 			eslo = product & 0xf;
 			soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u",
 							   eshi, eslo);
-		}  else if (id == &id_rzg2l || id == &id_rzv2h) {
+		}  else if (id == &id_rzg2l) {
 			eshi =  ((product >> 28) & 0x0f);
 			soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%u",
 							   eshi);
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index 70a0f19316333..14db508f669ff 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -87,6 +87,9 @@ static const struct of_device_id rz_sysc_match[] = {
 #endif
 #ifdef CONFIG_SYS_R9A09G047
 	{ .compatible = "renesas,r9a09g047-sys", .data = &rzg3e_sys_init_data },
+#endif
+#ifdef CONFIG_SYS_R9A09G057
+	{ .compatible = "renesas,r9a09g057-sys", .data = &rzv2h_sys_init_data },
 #endif
 	{ }
 };
diff --git a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h
index 4e70b77433a3e..aa83948c51172 100644
--- a/drivers/soc/renesas/rz-sysc.h
+++ b/drivers/soc/renesas/rz-sysc.h
@@ -41,5 +41,6 @@ struct rz_sysc_init_data {
 
 extern const struct rz_sysc_init_data rzg3e_sys_init_data;
 extern const struct rz_sysc_init_data rzg3s_sysc_init_data;
+extern const struct rz_sysc_init_data rzv2h_sys_init_data;
 
 #endif /* __SOC_RENESAS_RZ_SYSC_H__ */
-- 
2.43.0


