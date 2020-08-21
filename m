Return-Path: <SRS0=NJSJ=B7=lists.cip-project.org=bounce+64572+5207+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A8EC433F1
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA122078D
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="e988GjRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA122078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5207+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nUncYY4521723x5Jcsi1kvYV; Fri, 21 Aug 2020 03:58:46 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.131167.1598003052343639956
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:44:12 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954631"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:44:11 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4DCA44232061;
	Fri, 21 Aug 2020 18:44:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 30/36] pinctrl: sh-pfc: Split R-Car H3 support in two independent drivers
Date: Fri, 21 Aug 2020 10:43:06 +0100
Message-Id: <20200821094312.3249-31-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fx3w67W8tNwseFOLNf5VQFvkx4520388AA=
Content-Type: multipart/mixed; boundary="PLDpTxzKfxBP9a8LEowq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007526;
 bh=9JNE9AlJBYbMeW1oY0JHkIyF5atcX4diyhMueAEgR6c=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=e988GjRgYZCIN9EzTck31dnTae6R/ORXSJDLG6KP5kEaehYm7bDHr3AkkhTJo8CF+/c
 7LZ9fH/hUHi+fZuKuA3RLnKl6FBKJis9o0Y2I+WA6DR4P5zODF6Wyqvuk0bBkXyUywqml
 yn+AdQ1RN4/Jlrsv81S5/t7ISBsmC+aSqhU=

--PLDpTxzKfxBP9a8LEowq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit f2bc07562748c23609743ded0630ec965f9e4fec upstream.

Despite using the same compatible values ("r8a7795"-based) because of
historical reasons, R-Car H3 ES1.x (R8A77950) and R-Car H3 ES2.0+
(R8A77951) are really different SoCs, with different part numbers, and
with different Pin Function Controller blocks.

Reflect this in the pinctrl configuration, by replacing the existing
CONFIG_PINCTRL_PFC_R8A7795 symbol by two new config symbols:
CONFIG_PINCTRL_PFC_R8A77950 and CONFIG_PINCTRL_PFC_R8A77951.  The latter
are selected automatically, depending on the soon-to-be-introduced
corresponding SoC-specific config options, and on the current common
config option, to relax dependencies.

Rename the individual pin control driver source files from
pfc-r8a7795-es1.c to pfc-r8a77950.c, and from pfc-r8a7795.c to
pfc-r8a77951.c, and make them truly independent.
As both SoCs share the same compatible value, special care must be taken
to match them to the correct pin control driver, if support for it is
included in the running kernel.

This will allow making support for early R-Car H3 revisions optional,
the largest share of which is taken by the pin control driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20191230083156.19191-1-geert+renesas@glider.be
[biju: updated config file for 4.19.y-cip]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/Kconfig                |  9 ++-
 drivers/pinctrl/sh-pfc/Makefile               |  4 +-
 drivers/pinctrl/sh-pfc/core.c                 | 57 ++++++++++++++-----
 .../{pfc-r8a7795-es1.c => pfc-r8a77950.c}     | 26 ++++-----
 .../sh-pfc/{pfc-r8a7795.c => pfc-r8a77951.c}  | 39 +++++--------
 drivers/pinctrl/sh-pfc/sh_pfc.h               |  4 +-
 6 files changed, 81 insertions(+), 58 deletions(-)
 rename drivers/pinctrl/sh-pfc/{pfc-r8a7795-es1.c => pfc-r8a77950.c} (99%)
 rename drivers/pinctrl/sh-pfc/{pfc-r8a7795.c => pfc-r8a77951.c} (99%)

diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index 2b82f520ccf1..77f606928220 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -99,9 +99,14 @@ config PINCTRL_PFC_R8A7794
 	depends on ARCH_R8A7794
 	select PINCTRL_SH_PFC
 
-config PINCTRL_PFC_R8A7795
+config PINCTRL_PFC_R8A77950
 	def_bool y
-	depends on ARCH_R8A7795
+	depends on (ARCH_R8A77950 || ARCH_R8A7795)
+	select PINCTRL_SH_PFC
+
+config PINCTRL_PFC_R8A77951
+	def_bool y
+	depends on (ARCH_R8A77951 || ARCH_R8A7795)
 	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_R8A7796
diff --git a/drivers/pinctrl/sh-pfc/Makefile b/drivers/pinctrl/sh-pfc/Makefile
index 95142f6b8ae4..930be8cf259f 100644
--- a/drivers/pinctrl/sh-pfc/Makefile
+++ b/drivers/pinctrl/sh-pfc/Makefile
@@ -17,8 +17,8 @@ obj-$(CONFIG_PINCTRL_PFC_R8A7791)	+= pfc-r8a7791.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7792)	+= pfc-r8a7792.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7793)	+= pfc-r8a7791.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7794)	+= pfc-r8a7794.o
-obj-$(CONFIG_PINCTRL_PFC_R8A7795)	+= pfc-r8a7795.o
-obj-$(CONFIG_PINCTRL_PFC_R8A7795)	+= pfc-r8a7795-es1.o
+obj-$(CONFIG_PINCTRL_PFC_R8A77950)	+= pfc-r8a77950.o
+obj-$(CONFIG_PINCTRL_PFC_R8A77951)	+= pfc-r8a77951.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7796)	+= pfc-r8a7796.o
 obj-$(CONFIG_PINCTRL_PFC_R8A77965)	+= pfc-r8a77965.o
 obj-$(CONFIG_PINCTRL_PFC_R8A77970)	+= pfc-r8a77970.o
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 788ec0e29376..53cb82a7aa5d 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/psci.h>
 #include <linux/slab.h>
+#include <linux/sys_soc.h>
 
 #include "core.h"
 
@@ -569,18 +570,18 @@ static const struct of_device_id sh_pfc_of_table[] = {
 		.data = &r8a7794_pinmux_info,
 	},
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A7795
+/* Both r8a7795 entries must be present to make sanity checks work */
+#ifdef CONFIG_PINCTRL_PFC_R8A77950
 	{
 		.compatible = "renesas,pfc-r8a7795",
-		.data = &r8a7795_pinmux_info,
+		.data = &r8a77950_pinmux_info,
 	},
-#ifdef DEBUG
+#endif
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 	{
-		/* For sanity checks only (nothing matches against this) */
-		.compatible = "renesas,pfc-r8a77950",	/* R-Car H3 ES1.0 */
-		.data = &r8a7795es1_pinmux_info,
+		.compatible = "renesas,pfc-r8a7795",
+		.data = &r8a77951_pinmux_info,
 	},
-#endif /* DEBUG */
 #endif
 #ifdef CONFIG_PINCTRL_PFC_R8A7796
 	{
@@ -881,19 +882,49 @@ static void __init sh_pfc_check_driver(const struct platform_driver *pdrv)
 static inline void sh_pfc_check_driver(struct platform_driver *pdrv) {}
 #endif /* !DEBUG */
 
+#ifdef CONFIG_OF
+static const void *sh_pfc_quirk_match(void)
+{
+#if defined(CONFIG_PINCTRL_PFC_R8A77950) || \
+    defined(CONFIG_PINCTRL_PFC_R8A77951)
+	const struct soc_device_attribute *match;
+	static const struct soc_device_attribute quirks[] = {
+		{
+			.soc_id = "r8a7795", .revision = "ES1.*",
+			.data = &r8a77950_pinmux_info,
+		},
+		{
+			.soc_id = "r8a7795",
+			.data = &r8a77951_pinmux_info,
+		},
+
+		{ /* sentinel */ }
+	};
+
+	match = soc_device_match(quirks);
+	if (match)
+		return match->data ?: ERR_PTR(-ENODEV);
+#endif /* CONFIG_PINCTRL_PFC_R8A77950 || CONFIG_PINCTRL_PFC_R8A77951 */
+
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 static int sh_pfc_probe(struct platform_device *pdev)
 {
-#ifdef CONFIG_OF
-	struct device_node *np = pdev->dev.of_node;
-#endif
 	const struct sh_pfc_soc_info *info;
 	struct sh_pfc *pfc;
 	int ret;
 
 #ifdef CONFIG_OF
-	if (np)
-		info = of_device_get_match_data(&pdev->dev);
-	else
+	if (pdev->dev.of_node) {
+		info = sh_pfc_quirk_match();
+		if (IS_ERR(info))
+			return PTR_ERR(info);
+
+		if (!info)
+			info = of_device_get_match_data(&pdev->dev);
+	} else
 #endif
 		info = (const void *)platform_get_device_id(pdev)->driver_data;
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a77950.c
similarity index 99%
rename from drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
rename to drivers/pinctrl/sh-pfc/pfc-r8a77950.c
index 17f7b1596a62..467396ccb091 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77950.c
@@ -1,5 +1,5 @@
 /*
- * R8A7795 ES1.x processor support - PFC hardware block.
+ * R8A77950 processor support - PFC hardware block.
  *
  * Copyright (C) 2015-2017  Renesas Electronics Corporation
  *
@@ -5565,8 +5565,8 @@ static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	{ /* sentinel */ },
 };
 
-static int r8a7795es1_pin_to_pocctrl(struct sh_pfc *pfc, unsigned int pin,
-				     u32 *pocctrl)
+static int r8a77950_pin_to_pocctrl(struct sh_pfc *pfc, unsigned int pin,
+				   u32 *pocctrl)
 {
 	int bit = -EINVAL;
 
@@ -5823,8 +5823,8 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 	{ /* sentinel */ },
 };
 
-static unsigned int r8a7795es1_pinmux_get_bias(struct sh_pfc *pfc,
-					       unsigned int pin)
+static unsigned int r8a77950_pinmux_get_bias(struct sh_pfc *pfc,
+					     unsigned int pin)
 {
 	const struct pinmux_bias_reg *reg;
 	unsigned int bit;
@@ -5841,8 +5841,8 @@ static unsigned int r8a7795es1_pinmux_get_bias(struct sh_pfc *pfc,
 		return PIN_CONFIG_BIAS_PULL_DOWN;
 }
 
-static void r8a7795es1_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
-				       unsigned int bias)
+static void r8a77950_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
+				     unsigned int bias)
 {
 	const struct pinmux_bias_reg *reg;
 	u32 enable, updown;
@@ -5864,15 +5864,15 @@ static void r8a7795es1_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
 	sh_pfc_write(pfc, reg->puen, enable);
 }
 
-static const struct sh_pfc_soc_operations r8a7795es1_pinmux_ops = {
-	.pin_to_pocctrl = r8a7795es1_pin_to_pocctrl,
-	.get_bias = r8a7795es1_pinmux_get_bias,
-	.set_bias = r8a7795es1_pinmux_set_bias,
+static const struct sh_pfc_soc_operations r8a77950_pinmux_ops = {
+	.pin_to_pocctrl = r8a77950_pin_to_pocctrl,
+	.get_bias = r8a77950_pinmux_get_bias,
+	.set_bias = r8a77950_pinmux_set_bias,
 };
 
-const struct sh_pfc_soc_info r8a7795es1_pinmux_info = {
+const struct sh_pfc_soc_info r8a77950_pinmux_info = {
 	.name = "r8a77950_pfc",
-	.ops = &r8a7795es1_pinmux_ops,
+	.ops = &r8a77950_pinmux_ops,
 	.unlock_reg = 0xe6060000, /* PMMR */
 
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a77951.c
similarity index 99%
rename from drivers/pinctrl/sh-pfc/pfc-r8a7795.c
rename to drivers/pinctrl/sh-pfc/pfc-r8a77951.c
index 0a2ea9544802..f922aa46dba4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77951.c
@@ -1,5 +1,5 @@
 /*
- * R8A7795 ES2.0+ processor support - PFC hardware block.
+ * R8A77951 processor support - PFC hardware block.
  *
  * Copyright (C) 2015-2019 Renesas Electronics Corporation
  *
@@ -5918,7 +5918,8 @@ static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	{ /* sentinel */ },
 };
 
-static int r8a7795_pin_to_pocctrl(struct sh_pfc *pfc, unsigned int pin, u32 *pocctrl)
+static int r8a77951_pin_to_pocctrl(struct sh_pfc *pfc,
+				   unsigned int pin, u32 *pocctrl)
 {
 	int bit = -EINVAL;
 
@@ -6175,8 +6176,8 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 	{ /* sentinel */ },
 };
 
-static unsigned int r8a7795_pinmux_get_bias(struct sh_pfc *pfc,
-					    unsigned int pin)
+static unsigned int r8a77951_pinmux_get_bias(struct sh_pfc *pfc,
+					     unsigned int pin)
 {
 	const struct pinmux_bias_reg *reg;
 	unsigned int bit;
@@ -6193,8 +6194,8 @@ static unsigned int r8a7795_pinmux_get_bias(struct sh_pfc *pfc,
 		return PIN_CONFIG_BIAS_PULL_DOWN;
 }
 
-static void r8a7795_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
-				   unsigned int bias)
+static void r8a77951_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
+				     unsigned int bias)
 {
 	const struct pinmux_bias_reg *reg;
 	u32 enable, updown;
@@ -6216,29 +6217,15 @@ static void r8a7795_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
 	sh_pfc_write(pfc, reg->puen, enable);
 }
 
-static const struct soc_device_attribute r8a7795es1[] = {
-	{ .soc_id = "r8a7795", .revision = "ES1.*" },
-	{ /* sentinel */ }
+static const struct sh_pfc_soc_operations r8a77951_pinmux_ops = {
+	.pin_to_pocctrl = r8a77951_pin_to_pocctrl,
+	.get_bias = r8a77951_pinmux_get_bias,
+	.set_bias = r8a77951_pinmux_set_bias,
 };
 
-static int r8a7795_pinmux_init(struct sh_pfc *pfc)
-{
-	if (soc_device_match(r8a7795es1))
-		pfc->info = &r8a7795es1_pinmux_info;
-
-	return 0;
-}
-
-static const struct sh_pfc_soc_operations r8a7795_pinmux_ops = {
-	.init = r8a7795_pinmux_init,
-	.pin_to_pocctrl = r8a7795_pin_to_pocctrl,
-	.get_bias = r8a7795_pinmux_get_bias,
-	.set_bias = r8a7795_pinmux_set_bias,
-};
-
-const struct sh_pfc_soc_info r8a7795_pinmux_info = {
+const struct sh_pfc_soc_info r8a77951_pinmux_info = {
 	.name = "r8a77951_pfc",
-	.ops = &r8a7795_pinmux_ops,
+	.ops = &r8a77951_pinmux_ops,
 	.unlock_reg = 0xe6060000, /* PMMR */
 
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index e66595940584..e8e1e1a8a7cf 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -320,8 +320,8 @@ extern const struct sh_pfc_soc_info r8a7791_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7792_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7793_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7794_pinmux_info;
-extern const struct sh_pfc_soc_info r8a7795_pinmux_info;
-extern const struct sh_pfc_soc_info r8a7795es1_pinmux_info;
+extern const struct sh_pfc_soc_info r8a77950_pinmux_info __weak;
+extern const struct sh_pfc_soc_info r8a77951_pinmux_info __weak;
 extern const struct sh_pfc_soc_info r8a7796_pinmux_info;
 extern const struct sh_pfc_soc_info r8a77965_pinmux_info;
 extern const struct sh_pfc_soc_info r8a77970_pinmux_info;
-- 
2.17.1


--PLDpTxzKfxBP9a8LEowq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5207): https://lists.cip-project.org/g/cip-dev/message=
/5207
Mute This Topic: https://lists.cip-project.org/mt/76326747/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--PLDpTxzKfxBP9a8LEowq--
