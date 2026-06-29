Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E61CC43638
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:53:53 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9687.1782773629030326926
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DI+68gWY;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.42, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piwiYol7rJC9NUyU6UZ0mb9JI9TLvP8quH/44iN/SC5lFkDeIuareKMa3f01+KCeAEVjRcRkGa54ifnG1jmYsuWuI1FJNjZngUiPNHp3lRnbHYg83X3p9GEfrFwKL2UDC1VlZz62y9TPNATUsv2Pn4OjtpdaJkU/afBpUuOPSq8ethT3C++cAXGM7EfAwx8epvfTO1bGZHfFavJdCAB1T+0L8AWTKlugECq9Z4lz/wS9S/z03F8pdDDSA/8x8gX0u6naFudF38h1D+L/v9Ti6Ieu4mdc0so+MhzozguC41/ObM49lkIf95Xeox+A9fp01I2tHw0qd3nnN7SXMR5kFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c61AIyU4eMUoOoMKpUS2J0Pt1ThNqim70kBlvzhM+ZQ=;
 b=JVQKcarf9Ljfns50icAVYKBewltaZfwD4AVHyJ7GHtSMtacSvtw83IRuzIs7ba/TUTF73PiMmmm95QgFa+8lBPVJkE+jz4740JVMl9+yIhiplScpF0EbOzvVXQnd60dhJc+iL5jUXHvaxwXkeVNlx5vaakGM6tmnKUMPtFH/VV9jeKgxTZdvIDWWAsNC6Kb791yT7yf7fuQ/pc9PCDxjXzt1fV00PiZ074sxmcRYeL3Hfsfq9Nd/QyemaRT+JD26UqfINkeCKjk81pu+OU5IljBUoBGaP01Z69oajPZ8HU66PsvIeZet5FjIjDcI4d8bDP+whrC4I1yTu+oZ4faxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c61AIyU4eMUoOoMKpUS2J0Pt1ThNqim70kBlvzhM+ZQ=;
 b=DI+68gWYdigUJT0gVBbj8nw6c2DcFMipOXjpEo3mDk/5tyB+XSOsujxi2FpAdwut4Ai2jERYTMwfDXz/PE/sxDkdXRmvLUBWC6RX3hpCdc4gNHG08nfzlYpbW2f6e+Mq1NFXx7ub9geEeb9yCthk78P4UVrTI6CJldBV7BnW2Fg=
Received: from OS0PR01CA0049.jpnprd01.prod.outlook.com (2603:1096:604:98::20)
 by TYRPR01MB12742.jpnprd01.prod.outlook.com (2603:1096:405:1b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:44 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:98:cafe::66) by OS0PR01CA0049.outlook.office365.com
 (2603:1096:604:98::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:44 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id E33AE3000256;
	Tue, 30 Jun 2026 07:53:42 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/11] pinctrl: renesas: rzt2h: Add GPIO IRQ chip to handle interrupts
Date: Mon, 29 Jun 2026 23:53:26 +0100
Message-ID: <20260629225331.10023-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYRPR01MB12742:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 57737b76-ab3a-448c-947a-08ded63145ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|18002099003|13003099007|22082099003|6133799003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 
	OHqMxu6YDYjuswc9QoN91SXlWA3RbDnxDFpfag/cElXiTiFNbLYoJT0YlYqM+LoDQt2PVPUVzGPrPIEw6LfJ+/e2esuiXidTpOjHNlrSQ6gWh97+z4eGKRXFefcTMuG77nxhomA9ZPj332q261yLm/b4ZwZCXT982gJVC0MkMwMi+Esh3p2MdZieYF7MM6V4lh6SkgsZ3QAc+klQ2JtyIGejJXYctFWIm/L8jgbuPtoJ7Q+dSV6CRciJxau6Wi85/Ul7G+QwiBDerUr2vBmajF8IRX9aS17ia3ljdE+AFAeus399m6vzMo//EuvBIucv6/dg6d01bFiZMn/A9T+HXdW0enkeIYMbijQx58vBEGS6NEYwJKbz3q+1mM/kWUd3davWl+lr5WGOXtLHbDojJxAWcLLkKDlMP7hnsOkiOKMbsgmm4EPlWQ8j4MmagEfbMTZSWS6haDctc0aqHxTee0rR3HvOG45MIraciAgnzsjCdTfKI4Lv2yc01k9gt7Bt+rrfSxlWtRSeFzCQUDE0YTowzsO9bm5A/PHYqVHMBnhN5Ep3Dr8JP4H91YxFagM1dQjqKRaYXr3JLHLK3BizU9rQXgFfS7aXEtk7c9ocmyb0hQCBtSEpbB4+6NoSjTuKeoepc6Yx6xQSuLSAaNjP7wynY+MZLOVR+JWwQ3ycEXw=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(18002099003)(13003099007)(22082099003)(6133799003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	A0hFBZuQbzx2QQXzbo2DOfkj9/bAP4S4QNIByJ9yNbfS0RtAwsG2/tjWwF90qYLyj0GHamAS9yPADIq92FV4cSMUl/K80Kfh80Vh6UJBfuNm/5GeSasnCR6iKwldnsZyZML7dVug8eviBZ2TACSulfHi0aNb/AdraQO+vzXnNGe61jslNUNvUwYtblBEvSfCM2qsExLI9MeIoOX8YFa8xrWKVr2ziEp4Cib+5nXWdapmfO0BnPHJuUieD9eqc2aGo6QFkpwhsf1UD7iLlHvQrWsmny8h2PJM8hZq6J//kh1O0lqZcuZ4A8qsulYj+gZMN6yH9LFoVswOooKurMLjhLUpYCG3jeATYEER/f5xYEtuPa9lkmvXbaWZMSYB1gZ8Hv7gECt9v636rOoLurgSINMwJsS3/Lnk8JWCSAdHJmx9BmekVjnqh2+MFNnTpU+G
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:44.3302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57737b76-ab3a-448c-947a-08ded63145ad
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12742
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:53:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23314

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 829dde3369a91ad637ac15629ea8d73f3db2c562 upstream.

The Renesas RZ/T2H (R9A09G077) and Renesas RZ/N2H (R9A09G087) SoCs have
IRQ-capable pins handled by the ICU, which forwards them to the GIC.

The ICU supports 16 IRQ lines, the pins map to these lines arbitrarily,
and the mapping is not configurable.

Add a GPIO IRQ chip to the pin controller that can be used to configure
these pins as IRQ lines.

The pin controller places the requested pins into IRQ function,
disabling GPIO mode. A hierarchical IRQ domain is used to forward other
functionality to the parent IRQ domain, the ICU. The ICU does level
translation and then forwards other functionality to the GIC.

Wakeup capability is implemented by placing the entire pin controller on
the wakeup path if any pins are requested to be wakeup-capable.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260109143910.645628-2-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/Kconfig         |   2 +
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 203 ++++++++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kcon=
fig
index 27ddc5dc46194..911d187a2dc26 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -255,9 +255,11 @@ config PINCTRL_RZT2H
 	bool "pin control support for RZ/N2H and RZ/T2H" if COMPILE_TEST
 	depends on 64BIT && OF
 	select GPIOLIB
+	select GPIOLIB_IRQCHIP
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
+	select IRQ_DOMAIN_HIERARCHY
 	help
 	  This selects GPIO and pinctrl driver for Renesas RZ/T2H
 	  platforms.
diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index f056e28f6a17e..b4107f18f5d6e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
@@ -65,6 +66,9 @@
=20
 #define RZT2H_MAX_SAFETY_PORTS		12
=20
+#define RZT2H_INTERRUPTS_START		16
+#define RZT2H_INTERRUPTS_NUM		17
+
 struct rzt2h_pinctrl_data {
 	unsigned int n_port_pins;
 	const u8 *port_pin_configs;
@@ -80,9 +84,11 @@ struct rzt2h_pinctrl {
 	struct device			*dev;
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	gpio_range;
+	DECLARE_BITMAP(used_irqs, RZT2H_INTERRUPTS_NUM);
 	spinlock_t			lock; /* lock read/write registers */
 	struct mutex			mutex; /* serialize adding groups and functions */
 	bool				safety_port_enabled;
+	atomic_t			wakeup_path;
 };
=20
 #define RZT2H_GET_BASE(pctrl, port) \
@@ -642,14 +648,185 @@ static const char * const rzt2h_gpio_names[] =3D {
 	"P35_0", "P35_1", "P35_2", "P35_3", "P35_4", "P35_5", "P35_6", "P35_7",
 };
=20
+/*
+ * Interrupts 0-15 are for INTCPUn, which are not exposed externally.
+ * Interrupts 16-31 are for IRQn. SEI is 32.
+ * This table matches the information found in User Manual's Section
+ * 17.5, Multiplexed Pin Configurations, Tables 17.5 to 17.40, on the
+ * Interrupt rows.
+ * RZ/N2H has the same GPIO to IRQ mapping, except for the pins which
+ * are not present.
+ */
+static const u8 rzt2h_gpio_irq_map[] =3D {
+	32, 16, 17, 18, 19,  0, 20, 21,
+	22,  0,  0,  0,  0,  0,  0,  0,
+	23, 24, 25, 26, 27,  0,  0,  0,
+	 0,  0, 28, 29, 30, 31,  0,  0,
+	 0,  0,  0,  0,  0, 32, 16, 17,
+	18, 19, 20, 21, 22,  0,  0,  0,
+	 0,  0, 24, 25, 26, 27,  0, 28,
+	29, 30, 31,  0,  0,  0,  0,  0,
+	 0,  0,  0,  0,  0, 24, 32, 16,
+	 0,  0,  0,  0,  0,  0,  0,  0,
+	20, 23, 17, 18, 19,  0, 16, 25,
+	29, 20, 21, 22, 23,  0,  0,  0,
+	 0,  0,  0,  0, 17,  0,  0, 18,
+	 0,  0, 19,  0,  0, 20,  0, 30,
+	21,  0,  0, 22,  0,  0, 24, 25,
+	 0,  0,  0,  0,  0, 16, 17,  0,
+	18,  0,  0, 26, 27,  0,  0,  0,
+	28, 29, 30, 31,  0,  0,  0,  0,
+	23, 31, 32, 16, 17, 18, 19, 20,
+	 0,  0,  0,  0,  0,  0,  0,  0,
+	 0,  0,  0,  0,  0,  0,  0,  0,
+	 0,  0,  0,  0,  0,  0,  0,  0,
+	27,  0,  0, 21, 22, 23, 24, 25,
+	26,  0,  0,  0,  0,  0,  0,  0,
+	27, 28, 29, 30, 31,  0,  0,  0,
+	 0,  0,  0,  0,  0,  0,  0,  0,
+	 0,  0,  0,  0,  0, 28, 32, 16,
+	17, 18, 19,  0,  0,  0,  0, 20,
+	21, 22, 23,  0,  0,  0,  0,  0,
+	 0,  0,  0,  0, 24, 25,  0,  0,
+	 0,  0, 26, 27,  0,  0,  0, 30,
+	 0, 29,  0,  0,  0,  0,  0,  0,
+	 0,  0,  0,  0,  0,  0,  0,  0,
+	 0,  0,  0, 28, 29, 30, 31,  0,
+	 0,  0,  0,  0,  0,  0,  0, 30,
+	 0,  0,  0,  0,  0,  0,  0,  0,
+};
+
+static void rzt2h_gpio_irq_disable(struct irq_data *d)
+{
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+
+	irq_chip_disable_parent(d);
+	gpiochip_disable_irq(gc, hwirq);
+}
+
+static void rzt2h_gpio_irq_enable(struct irq_data *d)
+{
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+
+	gpiochip_enable_irq(gc, hwirq);
+	irq_chip_enable_parent(d);
+}
+
+static int rzt2h_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
+	struct rzt2h_pinctrl *pctrl =3D container_of(gc, struct rzt2h_pinctrl, gp=
io_chip);
+	int ret;
+
+	ret =3D irq_chip_set_wake_parent(d, on);
+	if (ret)
+		return ret;
+
+	/*
+	 * If any of the IRQs are in use, put the entire pin controller on the
+	 * device wakeup path.
+	 */
+	if (on)
+		atomic_inc(&pctrl->wakeup_path);
+	else
+		atomic_dec(&pctrl->wakeup_path);
+
+	return 0;
+}
+
+static const struct irq_chip rzt2h_gpio_irqchip =3D {
+	.name =3D "rzt2h-gpio",
+	.irq_disable =3D rzt2h_gpio_irq_disable,
+	.irq_enable =3D rzt2h_gpio_irq_enable,
+	.irq_mask =3D irq_chip_mask_parent,
+	.irq_unmask =3D irq_chip_unmask_parent,
+	.irq_set_type =3D irq_chip_set_type_parent,
+	.irq_set_wake =3D rzt2h_gpio_irq_set_wake,
+	.irq_eoi =3D irq_chip_eoi_parent,
+	.irq_set_affinity =3D irq_chip_set_affinity_parent,
+	.flags =3D IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static int rzt2h_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
+					    unsigned int child,
+					    unsigned int child_type,
+					    unsigned int *parent,
+					    unsigned int *parent_type)
+{
+	struct rzt2h_pinctrl *pctrl =3D gpiochip_get_data(gc);
+	u8 port =3D RZT2H_PIN_ID_TO_PORT(child);
+	u8 pin =3D RZT2H_PIN_ID_TO_PIN(child);
+	u8 parent_irq;
+
+	parent_irq =3D rzt2h_gpio_irq_map[child];
+	if (parent_irq < RZT2H_INTERRUPTS_START)
+		return -EINVAL;
+
+	if (test_and_set_bit(parent_irq - RZT2H_INTERRUPTS_START,
+			     pctrl->used_irqs))
+		return -EBUSY;
+
+	rzt2h_pinctrl_set_pfc_mode(pctrl, port, pin, PFC_FUNC_INTERRUPT);
+
+	*parent =3D parent_irq;
+	*parent_type =3D child_type;
+
+	return 0;
+}
+
+static void rzt2h_gpio_irq_domain_free(struct irq_domain *domain, unsigned=
 int virq,
+				       unsigned int nr_irqs)
+{
+	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
+	struct rzt2h_pinctrl *pctrl =3D container_of(gc, struct rzt2h_pinctrl, gp=
io_chip);
+	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
+	u8 port =3D RZT2H_PIN_ID_TO_PORT(hwirq);
+	u8 pin =3D RZT2H_PIN_ID_TO_PIN(hwirq);
+
+	if (test_and_clear_bit(hwirq - RZT2H_INTERRUPTS_START, pctrl->used_irqs))
+		rzt2h_pinctrl_set_gpio_en(pctrl, port, pin, false);
+
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+}
+
+static void rzt2h_gpio_init_irq_valid_mask(struct gpio_chip *gc,
+					   unsigned long *valid_mask,
+					   unsigned int ngpios)
+{
+	struct rzt2h_pinctrl *pctrl =3D gpiochip_get_data(gc);
+	unsigned int offset;
+
+	for (offset =3D 0; offset < ngpios; offset++) {
+		if (!rzt2h_gpio_irq_map[offset] || rzt2h_validate_pin(pctrl, offset))
+			clear_bit(offset, valid_mask);
+	}
+}
+
 static int rzt2h_gpio_register(struct rzt2h_pinctrl *pctrl)
 {
 	struct pinctrl_gpio_range *range =3D &pctrl->gpio_range;
 	struct gpio_chip *chip =3D &pctrl->gpio_chip;
+	struct device_node *np =3D pctrl->dev->of_node;
+	struct irq_domain *parent_domain;
 	struct device *dev =3D pctrl->dev;
 	struct of_phandle_args of_args;
+	struct device_node *parent_np;
+	struct gpio_irq_chip *girq;
 	int ret;
=20
+	parent_np =3D of_irq_find_parent(np);
+	if (!parent_np)
+		return -ENXIO;
+
+	parent_domain =3D irq_find_host(parent_np);
+	of_node_put(parent_np);
+	if (!parent_domain)
+		return -EPROBE_DEFER;
+
 	ret =3D of_parse_phandle_with_fixed_args(dev->of_node, "gpio-ranges", 3, =
0, &of_args);
 	if (ret)
 		return dev_err_probe(dev, ret, "Unable to parse gpio-ranges\n");
@@ -673,6 +850,17 @@ static int rzt2h_gpio_register(struct rzt2h_pinctrl *p=
ctrl)
 	chip->set =3D rzt2h_gpio_set;
 	chip->label =3D dev_name(dev);
=20
+	if (of_property_present(np, "interrupt-controller")) {
+		girq =3D &chip->irq;
+		gpio_irq_chip_set_chip(girq, &rzt2h_gpio_irqchip);
+		girq->fwnode =3D dev_fwnode(pctrl->dev);
+		girq->parent_domain =3D parent_domain;
+		girq->child_to_parent_hwirq =3D rzt2h_gpio_child_to_parent_hwirq;
+		girq->populate_parent_alloc_arg =3D gpiochip_populate_parent_fwspec_twoc=
ell;
+		girq->child_irq_domain_ops.free =3D rzt2h_gpio_irq_domain_free;
+		girq->init_valid_mask =3D rzt2h_gpio_init_irq_valid_mask;
+	}
+
 	range->id =3D 0;
 	range->pin_base =3D 0;
 	range->base =3D 0;
@@ -817,10 +1005,25 @@ static const struct of_device_id rzt2h_pinctrl_of_ta=
ble[] =3D {
 	{ /* sentinel */ }
 };
=20
+static int rzt2h_pinctrl_suspend_noirq(struct device *dev)
+{
+	struct rzt2h_pinctrl *pctrl =3D dev_get_drvdata(dev);
+
+	if (atomic_read(&pctrl->wakeup_path))
+		device_set_wakeup_path(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops rzt2h_pinctrl_pm_ops =3D {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(rzt2h_pinctrl_suspend_noirq, NULL)
+};
+
 static struct platform_driver rzt2h_pinctrl_driver =3D {
 	.driver =3D {
 		.name =3D DRV_NAME,
 		.of_match_table =3D of_match_ptr(rzt2h_pinctrl_of_table),
+		.pm =3D pm_sleep_ptr(&rzt2h_pinctrl_pm_ops),
 		.suppress_bind_attrs =3D true,
 	},
 	.probe =3D rzt2h_pinctrl_probe,
--=20
2.43.0


