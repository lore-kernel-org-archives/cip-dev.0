Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B0CC369D8
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 18:14:16 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1769.1745432044927270126
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 11:14:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: JVwC2TJZQFCjMM2NH4cEjQ==
X-CSE-MsgGUID: Uu8tMFKhQ/2zgOGp7BGMdQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2025 03:14:11 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0D9DF40071EF;
	Thu, 24 Apr 2025 03:14:09 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.12.y-cip 04/10] soc: renesas: rz-sysc: Move RZ/G3S SoC detection to the SYSC driver
Date: Wed, 23 Apr 2025 19:13:54 +0100
Message-ID: <20250423181400.13960-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423181400.13960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250423181400.13960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 18:14:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18572

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0704de89eee60e2f968973c7b4ccd8cd219b2d97  upstream.

Now that we have SoC detection in the RZ SYSC driver, move the RZ/G3S
SoC detection to it. The SYSC provides SoC ID in its own registers.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Link: https://lore.kernel.org/20250128031342.52675-3-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig          |  5 +++++
 drivers/soc/renesas/Makefile         |  1 +
 drivers/soc/renesas/r9a08g045-sysc.c | 23 +++++++++++++++++++++++
 drivers/soc/renesas/renesas-soc.c    | 12 ------------
 drivers/soc/renesas/rz-sysc.c        |  3 +++
 drivers/soc/renesas/rz-sysc.h        |  2 ++
 6 files changed, 34 insertions(+), 12 deletions(-)
 create mode 100644 drivers/soc/renesas/r9a08g045-sysc.c

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 6d1acd371071..026d8c675734 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -334,6 +334,7 @@ config ARCH_R9A07G054
 config ARCH_R9A08G045
 	bool "ARM64 Platform support for RZ/G3S"
 	select ARCH_RZG2L
+	select SYSC_R9A08G045
 	help
 	  This enables support for the Renesas RZ/G3S SoC variants.
 
@@ -385,4 +386,8 @@ config RST_RCAR
 config SYSC_RZ
 	bool "System controller for RZ SoCs" if COMPILE_TEST
 
+config SYSC_R9A08G045
+	bool "Renesas RZ/G3S System controller support" if COMPILE_TEST
+	select SYSC_RZ
+
 endif # SOC_RENESAS
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 3d5f847ed889..8cd139b3dd0a 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SOC_RENESAS)	+= renesas-soc.o
 ifdef CONFIG_SMP
 obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
+obj-$(CONFIG_SYSC_R9A08G045)	+= r9a08g045-sysc.o
 
 # Family
 obj-$(CONFIG_PWC_RZV2M)		+= pwc-rzv2m.o
diff --git a/drivers/soc/renesas/r9a08g045-sysc.c b/drivers/soc/renesas/r9a08g045-sysc.c
new file mode 100644
index 000000000000..f4db1431e036
--- /dev/null
+++ b/drivers/soc/renesas/r9a08g045-sysc.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G3S System controller driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <linux/bits.h>
+#include <linux/init.h>
+
+#include "rz-sysc.h"
+
+static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initconst = {
+	.family = "RZ/G3S",
+	.id = 0x85e0447,
+	.devid_offset = 0xa04,
+	.revision_mask = GENMASK(31, 28),
+	.specific_id_mask = GENMASK(27, 0),
+};
+
+const struct rz_sysc_init_data rzg3s_sysc_init_data __initconst = {
+	.soc_id_init_data = &rzg3s_sysc_soc_id_init_data,
+};
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 172d59e6fbcf..425d9037dcd0 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -71,10 +71,6 @@ static const struct renesas_family fam_rzg2ul __initconst __maybe_unused = {
 	.name	= "RZ/G2UL",
 };
 
-static const struct renesas_family fam_rzg3s __initconst __maybe_unused = {
-	.name	= "RZ/G3S",
-};
-
 static const struct renesas_family fam_rzv2h __initconst __maybe_unused = {
 	.name	= "RZ/V2H",
 };
@@ -176,11 +172,6 @@ static const struct renesas_soc soc_rz_g2ul __initconst __maybe_unused = {
 	.id     = 0x8450447,
 };
 
-static const struct renesas_soc soc_rz_g3s __initconst __maybe_unused = {
-	.family = &fam_rzg3s,
-	.id	= 0x85e0447,
-};
-
 static const struct renesas_soc soc_rz_v2h __initconst __maybe_unused = {
 	.family = &fam_rzv2h,
 	.id     = 0x847a447,
@@ -410,9 +401,6 @@ static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
 #ifdef CONFIG_ARCH_R9A07G054
 	{ .compatible = "renesas,r9a07g054",	.data = &soc_rz_v2l },
 #endif
-#ifdef CONFIG_ARCH_R9A08G045
-	{ .compatible = "renesas,r9a08g045",	.data = &soc_rz_g3s },
-#endif
 #ifdef CONFIG_ARCH_R9A09G011
 	{ .compatible = "renesas,r9a09g011",	.data = &soc_rz_v2m },
 #endif
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index eec535578a85..de603cea4fab 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -77,6 +77,9 @@ static int rz_sysc_soc_init(struct rz_sysc *sysc, const struct of_device_id *mat
 }
 
 static const struct of_device_id rz_sysc_match[] = {
+#ifdef CONFIG_SYSC_R9A08G045
+	{ .compatible = "renesas,r9a08g045-sysc", .data = &rzg3s_sysc_init_data },
+#endif
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rz_sysc_match);
diff --git a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h
index c9ef7e83de59..908f09fa4fc9 100644
--- a/drivers/soc/renesas/rz-sysc.h
+++ b/drivers/soc/renesas/rz-sysc.h
@@ -34,4 +34,6 @@ struct rz_sysc_init_data {
 	const struct rz_sysc_soc_id_init_data *soc_id_init_data;
 };
 
+extern const struct rz_sysc_init_data rzg3s_sysc_init_data;
+
 #endif /* __SOC_RENESAS_RZ_SYSC_H__ */
-- 
2.43.0


