Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA082C624D7
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:42 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8330.1788341252596005770
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=jllgVsQx;
 spf=pass (domain: renesas.com, ip: 40.107.74.16, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZamLpWd3MpaC0dw+GBiCj8zq4NLCrDJLY3on+9+JK8RuUKZUF7Mx3zHODsfjv4mXeAuRd+nre2ID9awYks3aeR8qTVERXp90ErAttMh5Yl5ygL/a91caumaiyEUFuCgjbGCZFSebf5UQFLo/7flQ75wK3l7UL+s1vAOtjZLe9ROAXZaYskWETbNip7zGbpzkHmh19nIv52GOehIeANp/BJ6WTvnPyj3WvXUwaaU3Le9EvfBVFMWEEi2V0Sj2J2r8LVNJEGL/aAhWDMFIB62Pi4QPymi/olh6dTaldELj7XZvLcdAijue68ZEw+toFAkhqpK62uqRhAuBiehBjTRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAP/K++h8P5DQQfMtnY7q7cMKX74Dm4x9jSJKtdw9M4=;
 b=uWDeZ9DJ7BCsh9o/o2LDraDVnNbMZxCl6kCUwAqAJs/FFLdlilAKSAoIB/zrR4tDrsY7FYCy41Z+WYXN9q1e0cl4pvLWjryK16kfNDs5MdLNaQEncHtTlQ7TUeh+V33DpKPFgoihTwMc6DP2n8fURlQIqjin2BtZ9lllVBxcqGkb19+ywrImYGiL4ppUc1uTaZwVLegZsmgf5szwxJvi3Vs79sHGwtr5wDDRl4T0QIC99o4lqLYNwAxqMujq6nh+EhozWDRRrj8oeK3pXHr2B+e2NkPC2Uih7ld6r3s4BKGH6nnelhh2EBnOeu1JnR6lJxbgYEqfycPB0az7YA89wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAP/K++h8P5DQQfMtnY7q7cMKX74Dm4x9jSJKtdw9M4=;
 b=jllgVsQxsDor7rpmE+fz+y2qPqmc/xfR6VjTcoM0a/OKQ+LytkQ56DvH/+9yWBnDfzRLa4ejYpegz2kya7kdSSbyS/2/QlGicI62tn19gJU1mga2dPnCVsC9CSD76CAHbJkJ9L1DFMt6cvQsXYmqRORCREQpJpo/BqrTo0yp8lA=
Received: from OS0P286CA0089.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:b0::22)
 by OS9PR01MB12404.jpnprd01.prod.outlook.com (2603:1096:604:2e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:27:27 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:b0:cafe::80) by OS0P286CA0089.outlook.office365.com
 (2603:1096:604:b0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 09:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:27 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 55706300034C;
	Wed,  2 Sep 2026 18:27:26 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 07/11] irqchip/renesas-rzv2h: Add CA55 software interrupt support
Date: Wed,  2 Sep 2026 09:26:58 +0000
Message-ID: <20260902092702.24746-8-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|OS9PR01MB12404:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 39bfa7d4-59ca-4fa8-e477-08df08d467d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	n4pyLmiWUiLXjV9BjhDCUNgGqLkKoFjziCorOpVUhlTJgxuYc4WDeBDniLVic6N+E8OC+WY8cba+YW1dcjVyxHN2jtTVTU+4NxbuRuEkUxqICDW7iMwtcJqH4Z1959wj7dqhiFfOqRbFnC0sR4emZtTtjCQly/3nu5Y0RqmcuoY5mdsaxhz4fuQAiwaOTJ7zMSsX4PsZdFq4o96e8ggsiiN5AAvWF3utpucBJJ5+XEpzaYhg8/GaMSAElrHmjMTWAdyXZxXPquv/NRKvz6ZAR7ON9cVXAdBVmKFrFE9PRTfTI1XOskBOjFJ9rAx6+kk0cBoQ+3hU47pVUeaCq4LB/Qehbbc2++bY/DZoqRq0aFEwzd0ANfPa0KbVEtgj0qSOGO+oJnRPxxNG69d69gq+U6ozc0Q6dJhriFnyAKKkkdRkaRqrbLEbraEAU5FP1RqPAJtqA6JFcGc6Kv/DeZ8/Q1AGZuDQ/4UhUpL0D4dAhZIpP59wJAHLSB4Oe17OeRWiTShZgZ6S4V4aEXRpqu8pQZCFTInPNqSwKnhjiYjEbP+zSGkMRRGAsXg4Pjjeyt2XBzfiRkqR84R4WcqIj4Jm3/ff9AnwLAwkul8V7P6pNxpm2mV2UvzaUKigMGaUNXkw6AAbsJOBHXGqUkqC+NouWssiq74PrOYjKjSJ8O+f8FQ=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	R45LZQU3swRhZNk+C+TsHTvFjgEd8/rZNtnkaFH2zq2PwP7+RTHxcry4eSIvvCqbtoqmua9oJ5XDFnDCVrWw3oW7wZf3YYRciZP7cr6hA92aR8GfhHmNB0CBuD2mCx17Ac9vkUW280L97ychHXJlU93BZt6djwsd+ZgAvPkUw8AnQt0VOtTJmOAAloYbUErD69btDVwHpN0CQS487gWREmMXBVCSOzS1E0bgS+BQjfqOUkDbjU0qOzid9m5Uqa6DJgYp6XFYlmwxGc3dZk50KzU2xGbXOawFP1CCOYUgilVlzoXQGfy/3+1sfLc43hwMa4GK6MBJCq5bKjCPDgjO5Md08hMqtEAQceuIt5eYnW/7sItatkKuR/irgwmqf3FJPXTactJ8ruRG4XQHPXwwrYBtvrGFi9mNWV+Emsepm3+f91WvAZrlDgX02N9DtTGF
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:27.7680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bfa7d4-59ca-4fa8-e477-08df08d467d9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12404
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24073

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 61adc4813d67990f6f9c20ab8c4a57fb3d969322 upstream.

The RZ/V2H ICU exposes four software-triggerable interrupts targeting
the CA55 cores (int-ca55-0 to int-ca55-3). Add support for these
interrupts to enable IRQ injection via the generic IRQ injection
framework.

Add a dedicated rzv2h_icu_swint_chip irq_chip for the CA55 region and
implement rzv2h_icu_irq_set_irqchip_state() to handle software interrupt
injection.

[ tglx: Convert to hwirq_within() ]

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260304113317.129339-7-prabhakar.mahadev-la=
d.rj@bp.renesas.com
[OP: fixed minor context difference]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 95 ++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 8ba131baf25f..d92c0475f06b 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -12,6 +12,7 @@
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/irq-renesas-rzv2h.h>
@@ -29,7 +30,10 @@
 #define ICU_TINT_START				(ICU_IRQ_LAST + 1)
 #define ICU_TINT_COUNT				32
 #define ICU_TINT_LAST				(ICU_TINT_START + ICU_TINT_COUNT - 1)
-#define ICU_NUM_IRQ				(ICU_TINT_LAST + 1)
+#define ICU_CA55_INT_START			(ICU_TINT_LAST + 1)
+#define ICU_CA55_INT_COUNT			4
+#define ICU_CA55_INT_LAST			(ICU_CA55_INT_START + ICU_CA55_INT_COUNT - 1)
+#define ICU_NUM_IRQ				(ICU_CA55_INT_LAST + 1)
=20
 /* Registers */
 #define ICU_NSCNT				0x00
@@ -42,6 +46,7 @@
 #define ICU_TSCLR				0x24
 #define ICU_TITSR(k)				(0x28 + (k) * 4)
 #define ICU_TSSR(k)				(0x30 + (k) * 4)
+#define ICU_SWINT				0x130
 #define ICU_DMkSELy(k, y)			(0x420 + (k) * 0x20 + (y) * 4)
 #define ICU_DMACKSELk(k)			(0x500 + (k) * 4)
=20
@@ -433,6 +438,27 @@ static int rzv2h_tint_set_type(struct irq_data *d, uns=
igned int type)
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
 }
=20
+static int rzv2h_icu_swint_set_irqchip_state(struct irq_data *d, enum irqc=
hip_irq_state which,
+					     bool state)
+{
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+	struct rzv2h_icu_priv *priv;
+	unsigned int bit;
+
+	if (which !=3D IRQCHIP_STATE_PENDING)
+		return irq_chip_set_parent_state(d, which, state);
+
+	if (!state)
+		return 0;
+
+	priv =3D irq_data_to_priv(d);
+	bit =3D BIT(hwirq - ICU_CA55_INT_START);
+
+	/* Trigger the software interrupt */
+	writel_relaxed(bit, priv->base + ICU_SWINT);
+	return 0;
+}
+
 static int rzv2h_irqc_irq_suspend(void)
 {
 	struct rzv2h_irqc_reg_cache *cache =3D &rzv2h_icu_data->cache;
@@ -518,6 +544,23 @@ static const struct irq_chip rzv2h_icu_nmi_chip =3D {
 				  IRQCHIP_SKIP_SET_WAKE,
 };
=20
+static const struct irq_chip rzv2h_icu_swint_chip =3D {
+	.name			=3D "rzv2h-icu",
+	.irq_eoi		=3D irq_chip_eoi_parent,
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+	.irq_disable		=3D irq_chip_disable_parent,
+	.irq_enable		=3D irq_chip_enable_parent,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D rzv2h_icu_swint_set_irqchip_state,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_set_type		=3D irq_chip_set_type_parent,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
 #define hwirq_within(hwirq, which)	((hwirq) >=3D which##_START && (hwirq) =
<=3D which##_LAST)
=20
 static int rzv2h_icu_alloc(struct irq_domain *domain, unsigned int virq, u=
nsigned int nr_irqs,
@@ -549,6 +592,8 @@ static int rzv2h_icu_alloc(struct irq_domain *domain, u=
nsigned int virq, unsigne
 		chip =3D &rzv2h_icu_tint_chip;
 	} else if (hwirq_within(hwirq, ICU_IRQ)) {
 		chip =3D &rzv2h_icu_irq_chip;
+	} else if (hwirq_within(hwirq, ICU_CA55_INT)) {
+		chip =3D &rzv2h_icu_swint_chip;
 	} else {
 		chip =3D &rzv2h_icu_nmi_chip;
 	}
@@ -591,6 +636,50 @@ static void rzv2h_icu_put_device(void *data)
 	put_device(data);
 }
=20
+static irqreturn_t rzv2h_icu_swint_irq(int irq, void *data)
+{
+	u8 cpu =3D *(u8 *)data;
+
+	pr_info("SWINT interrupt for CA55 core %u\n", cpu);
+	return IRQ_HANDLED;
+}
+
+static int rzv2h_icu_setup_irqs(struct platform_device *pdev, struct irq_d=
omain *irq_domain)
+{
+	bool irq_inject =3D IS_ENABLED(CONFIG_GENERIC_IRQ_INJECTION);
+	static const char * const rzv2h_swint_names[] =3D {
+		"int-ca55-0", "int-ca55-1",
+		"int-ca55-2", "int-ca55-3",
+	};
+	static const u8 swint_idx[] =3D { 0, 1, 2, 3 };
+	struct device *dev =3D &pdev->dev;
+	struct irq_fwspec fwspec;
+	unsigned int i, virq;
+	int ret;
+
+	for (i =3D 0; i < ICU_CA55_INT_COUNT && irq_inject; i++) {
+		fwspec.fwnode =3D irq_domain->fwnode;
+		fwspec.param_count =3D 2;
+		fwspec.param[0] =3D ICU_CA55_INT_START + i;
+		fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
+
+		virq =3D irq_create_fwspec_mapping(&fwspec);
+		if (!virq) {
+			return dev_err_probe(dev, -EINVAL, "failed to create IRQ mapping for %s=
\n",
+					     rzv2h_swint_names[i]);
+		}
+
+		ret =3D devm_request_irq(dev, virq, rzv2h_icu_swint_irq, 0, dev_name(dev=
),
+				       (void *)&swint_idx[i]);
+		if (ret) {
+			return dev_err_probe(dev, ret, "Failed to request %s IRQ\n",
+					     rzv2h_swint_names[i]);
+		}
+	}
+
+	return 0;
+}
+
 static int rzv2h_icu_init_common(struct device_node *node, struct device_n=
ode *parent,
 				 const struct rzv2h_hw_info *hw_info)
 {
@@ -654,6 +743,10 @@ static int rzv2h_icu_init_common(struct device_node *n=
ode, struct device_node *p
=20
 	register_syscore_ops(&rzv2h_irqc_syscore_ops);
=20
+	ret =3D rzv2h_icu_setup_irqs(pdev, irq_domain);
+	if (ret)
+		goto pm_put;
+
 	/*
 	 * coccicheck complains about a missing put_device call before returning,=
 but it's a false
 	 * positive. We still need dev after successfully returning from this fun=
ction.
--=20
2.34.1


