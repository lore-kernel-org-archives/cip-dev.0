Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E9CC5DF8E
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:12 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7139.1787318231496562572
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=iXgY0L27;
 spf=pass (domain: renesas.com, ip: 40.107.74.35, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvPRekfKjkplF2RmnCgNywTUPSYrBe5kpRQsk09m9Newn8O3f5COJ++ulc0N7IKg+hA5tEr0ikAmoTHMubpWzNyv5nEUdgDwFP3BncWIz2ZICTSX5oH3ldi/IwWJBQRejxpcrhY7v1PsRCghsvr/wpTFJEn5/yMM04YCAS3BkaJJ2nWuugTVfRlc1/HnigCoagCmU6U+bPL+1xqF9jZFwkhkSMjA5MM+ZAduodAoLFWnVV7p4/Ejvju24HJfO5PpoqPS2PsvQ8bk3+KlGcOnUxCncSIK1EKnn/ekfXrN/idfoYWcfsaakEMRWfyWbmIlMY/PBgexfozjzVobcfzy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4bgI1Jc600UiKjthnVbmBWywBaEsF13nJsyJzbnWXk=;
 b=XX6rjxmCgbHHl69l7G290rPEnpdN2OKTlSePl7yQOQpmYqmn413unqqV+KfL4kohJeDb9+xhgFlW46aaSxE4RUO5MlJF0N7MNNY9+IdkbseYDwyYYe9pkc6r90V5lF2x+xr1uUhU/s9whbf3TugjUvSklLqRJZu/6ICBWas54REeM51nZAv7JdHB8tLTebYEwulf93y4Ko+TXDU8XyHaqjdne+mxTHBQPpzpqmJTSvmPKl8WxKURDPaXGqvQ/JFpFHLLuRY9rppK4WDfOr83bPh37FUTEAPOetwCufGJRYdwzThmS77KbtHaunBSis4UujpF6R7LgBGwsPQfszbfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4bgI1Jc600UiKjthnVbmBWywBaEsF13nJsyJzbnWXk=;
 b=iXgY0L27pWlT9zrU2/Cpm6QnVOgX9LTDJ1Fhx+R+SS2mB6MK6nJF3M7N1bmnFI3aqBSEoIWVwkvGKJx/350aCUQK7s13ii9dgGmftNhEqaP5E4PrUlAxFLVakXjQpiM0I1urhnwRGdxDESOma/7PBS3xnHC8sbqKODKsbmAahqM=
Received: from OS7PR01CA0247.jpnprd01.prod.outlook.com (2603:1096:604:24b::11)
 by OS9PR01MB16061.jpnprd01.prod.outlook.com (2603:1096:604:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:17:06 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24b:cafe::64) by OS7PR01CA0247.outlook.office365.com
 (2603:1096:604:24b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 13:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:17:06 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D0EAC3000374;
	Fri, 21 Aug 2026 22:17:04 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 11/18] irqchip/renesas-rzt2h: Add software-triggered interrupts support
Date: Fri, 21 Aug 2026 16:15:47 +0300
Message-ID: <20260821131554.638741-12-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|OS9PR01MB16061:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e7a9fefd-1844-4c8c-867c-08deff867f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	Gx63tJB4zonCIZt3hJH0N59lQuUh88DdeIkRvRosnkZHaCeiNp5gev8gmtsYWvu9Y8SIjpb16PL43tt1VbtOuIJA/77PVOOS8gwfyP79cDZt0JHgQbGsUtWvMCvilWd1guxl0FXoreyRR7ziZSae7xb55vF6f9jaQVxf9uhz1UNZ1F2tKLzrP6ddxnoV1XFVxLrfWEe8+luxyyi6k9mQ+ZO9HU1PSajFmHkYXOYq/7xn3ZrGrU+9KBg2LoM1x9NAZaAS8anC2CEmxkbcsysHbADgsHd496x/7l8J45V1BofLkAhYbFvt3q/E2ruJVYyqjDVMhZBdzgU5oJTd4kNgFa1P+UPcRx3NONd4HF6x7CebjjMoY/KVkL9SiM2yGb1gKy4lrApS06I3aJa2ZiRC50OqeZD1oHzA7Vsa2j80PsgrR6VMBhKhGyUqXA62qSCEZv5s7lgIacRDweKoztxr/CC6E4IcJYzRMqziQKCHtGfS5v+PQ3t0/Vgk/q8hNyn4h7yGx/DYY1ajoL9weYy5dcy9KjXPhmaUNWaoH7cO9zMWueiyISVaCX4BqILDguUb51sjzFAA8nSLFncf74/nJPi0uTH5uu8/0BMx19yc+TF7gXdn6FoUc2C66xxujYdJvKdArtZTffPurCG3K3BvX0X8dJp8W9wZBdbwPw+VJpU=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	WXWs2iIjH8ANq7RC9+p+BB4mw+Wq5ruyN5fP0Mtc5YcUeeJNTl4tD+n7G8a/VaZ/Du1dd8SQbNmPniUmv0wPUVrwjc7T03H2loox91J70suYSmqcSck+gn4bLOx1kActk9zA36A+1Vt/nLHrcIxLHOzPBERuJfCmRy+GFbXPelh3hRH4GAjkQPh47zMEN5r1SixfETZGXqjRFJf8Rlwr1MFjkI1AsS+jHWWmKs+qrGj4hVLr5Dtak9kUWmE5gU8HosBwKM7mPqRXcg7YciNspQfsCo+tO4FlWyK8I2+q2epQ/7C3thcDAjLAv3wU4nDRWceouLprRBa94Nm9Ynhdy1fYYouOVD0NR1pygOBdcOYWCooNrs1n0K+rhpn9JNTcUkJ56A6DzbuCQo1KqGI3uz8MC1hDwRwOC7hjL8Ay8Hhv9QHGUa5dZak1mij3OYkS
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:17:06.1646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a9fefd-1844-4c8c-867c-08deff867f75
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16061
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23968

commit a964dabc28a18fe62ff79e734cf54167ed322134 upstream.

The Renesas RZ/T2H ICU supports software-triggerable interrupts.

Add a dedicated rzt2h_icu_intcpu_chip irq_chip which implements
rzt2h_icu_intcpu_set_irqchip_state() to allow injecting these
interrupts.

Request the INTCPU IRQs when IRQ injection is enabled to report them
when they occur.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260520203117.1516442-3-cosmin-gabriel.tani=
slav.xa@renesas.com
[ctani: fix conflict caused by changed rzt2h_icu_init() prototype ]
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/irqchip/irq-renesas-rzt2h.c | 124 +++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzt2h.c b/drivers/irqchip/irq-rene=
sas-rzt2h.c
index e03eb9f86ef4..54d9e82e5de5 100644
--- a/drivers/irqchip/irq-renesas-rzt2h.c
+++ b/drivers/irqchip/irq-renesas-rzt2h.c
@@ -3,6 +3,7 @@
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/irq-renesas-rzt2h.h>
@@ -41,6 +42,9 @@
 	((n) >=3D RZT2H_ICU_##type##_START &&					\
 	 (n) <  RZT2H_ICU_##type##_START + RZT2H_ICU_##type##_COUNT)
=20
+#define RZT2H_ICU_SWINT				0x0
+#define RZT2H_ICU_SWINT_IC_MASK(i)		BIT(i)
+
 #define RZT2H_ICU_PORTNF_MD			0xc
 #define RZT2H_ICU_PORTNF_MDi_MASK(i)		(GENMASK(1, 0) << ((i) * 2))
 #define RZT2H_ICU_PORTNF_MDi_PREP(i, val)	(FIELD_PREP(GENMASK(1, 0), val) =
<< ((i) * 2))
@@ -100,6 +104,12 @@ static inline int rzt2h_icu_irq_to_offset(struct irq_d=
ata *d, void __iomem **bas
 	} else if (RZT2H_ICU_IRQ_IN_RANGE(hwirq, IRQ_S) || RZT2H_ICU_IRQ_IN_RANGE=
(hwirq, SEI)) {
 		*offset =3D hwirq - RZT2H_ICU_IRQ_S_START;
 		*base =3D priv->base_s;
+	} else if (RZT2H_ICU_IRQ_IN_RANGE(hwirq, INTCPU_NS)) {
+		*offset =3D hwirq - RZT2H_ICU_INTCPU_NS_START;
+		*base =3D priv->base_ns;
+	} else if (RZT2H_ICU_IRQ_IN_RANGE(hwirq, INTCPU_S)) {
+		*offset =3D hwirq - RZT2H_ICU_INTCPU_S_START;
+		*base =3D priv->base_s;
 	} else {
 		return -EINVAL;
 	}
@@ -165,6 +175,28 @@ static int rzt2h_icu_set_type(struct irq_data *d, unsi=
gned int type)
 	return irq_chip_set_type_parent(d, IRQ_TYPE_EDGE_RISING);
 }
=20
+static int rzt2h_icu_intcpu_set_irqchip_state(struct irq_data *d, enum irq=
chip_irq_state which,
+					      bool state)
+{
+	unsigned int offset;
+	void __iomem *base;
+	int ret;
+
+	if (which !=3D IRQCHIP_STATE_PENDING)
+		return irq_chip_set_parent_state(d, which, state);
+
+	if (!state)
+		return 0;
+
+	ret =3D rzt2h_icu_irq_to_offset(d, &base, &offset);
+	if (ret)
+		return ret;
+
+	writel_relaxed(RZT2H_ICU_SWINT_IC_MASK(offset), base + RZT2H_ICU_SWINT);
+
+	return 0;
+}
+
 static const struct irq_chip rzt2h_icu_chip =3D {
 	.name			=3D "rzt2h-icu",
 	.irq_mask		=3D irq_chip_mask_parent,
@@ -181,10 +213,27 @@ static const struct irq_chip rzt2h_icu_chip =3D {
 				  IRQCHIP_SKIP_SET_WAKE,
 };
=20
+static const struct irq_chip rzt2h_icu_intcpu_chip =3D {
+	.name			=3D "rzt2h-icu",
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+	.irq_eoi		=3D irq_chip_eoi_parent,
+	.irq_set_type		=3D irq_chip_set_type_parent,
+	.irq_set_wake		=3D irq_chip_set_wake_parent,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D rzt2h_icu_intcpu_set_irqchip_state,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
 static int rzt2h_icu_alloc(struct irq_domain *domain, unsigned int virq, u=
nsigned int nr_irqs,
 			   void *arg)
 {
 	struct rzt2h_icu_priv *priv =3D domain->host_data;
+	const struct irq_chip *chip;
 	irq_hw_number_t hwirq;
 	unsigned int type;
 	int ret;
@@ -193,7 +242,12 @@ static int rzt2h_icu_alloc(struct irq_domain *domain, =
unsigned int virq, unsigne
 	if (ret)
 		return ret;
=20
-	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &rzt2h_icu_chi=
p, NULL);
+	if (RZT2H_ICU_IRQ_IN_RANGE(hwirq, INTCPU_NS) || RZT2H_ICU_IRQ_IN_RANGE(hw=
irq, INTCPU_S))
+		chip =3D &rzt2h_icu_intcpu_chip;
+	else
+		chip =3D &rzt2h_icu_chip;
+
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, chip, NULL);
 	if (ret)
 		return ret;
=20
@@ -223,6 +277,60 @@ static int rzt2h_icu_parse_interrupts(struct rzt2h_icu=
_priv *priv, struct device
 	return 0;
 }
=20
+static irqreturn_t rzt2h_icu_intcpu_irq(int irq, void *data)
+{
+	unsigned int intcpu =3D (uintptr_t)data;
+
+	pr_info("INTCPU%u software interrupt\n", intcpu);
+	return IRQ_HANDLED;
+}
+
+static int rzt2h_icu_request_irqs(struct platform_device *pdev, struct irq=
_domain *irq_domain,
+				  unsigned int start, unsigned int count, irq_handler_t handler,
+				  void *data)
+{
+	struct device *dev =3D &pdev->dev;
+	unsigned int offset, virq;
+	struct irq_fwspec fwspec;
+	int ret;
+
+	for (offset =3D start; offset < start + count; offset++) {
+		fwspec.fwnode =3D irq_domain->fwnode;
+		fwspec.param_count =3D 2;
+		fwspec.param[0] =3D offset;
+		fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
+
+		virq =3D irq_create_fwspec_mapping(&fwspec);
+		if (!virq)
+			return dev_err_probe(dev, -EINVAL, "Failed to create IRQ %u mapping\n",=
 offset);
+
+		ret =3D devm_request_irq(dev, virq, handler, 0, dev_name(dev),
+				       data ?: (void *)(uintptr_t)offset);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request IRQ %u\n", offset);
+	}
+
+	return 0;
+}
+
+static int rzt2h_icu_setup_irqs(struct platform_device *pdev, struct irq_d=
omain *irq_domain)
+{
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_INJECTION)) {
+		int ret =3D rzt2h_icu_request_irqs(pdev, irq_domain, RZT2H_ICU_INTCPU_NS=
_START,
+						 RZT2H_ICU_INTCPU_NS_COUNT, rzt2h_icu_intcpu_irq,
+						 NULL);
+		if (ret)
+			return ret;
+
+		ret =3D rzt2h_icu_request_irqs(pdev, irq_domain, RZT2H_ICU_INTCPU_S_STAR=
T,
+					     RZT2H_ICU_INTCPU_S_COUNT, rzt2h_icu_intcpu_irq, NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int rzt2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
 {
 	struct platform_device *pdev =3D of_find_device_by_node(node);
@@ -269,10 +377,14 @@ static int rzt2h_icu_init(struct device_node *node, s=
truct device_node *parent)
 	irq_domain =3D irq_domain_create_hierarchy(parent_domain, 0, RZT2H_ICU_NU=
M_IRQ,
 						 dev_fwnode(dev), &rzt2h_icu_domain_ops, priv);
 	if (!irq_domain) {
-		pm_runtime_put_sync(dev);
-		return -ENOMEM;
+		ret =3D -ENOMEM;
+		goto err_pm_put;
 	}
=20
+	ret =3D rzt2h_icu_setup_irqs(pdev, irq_domain);
+	if (ret)
+		goto err_irq_domain_free;
+
 	/*
 	 * Prevent the cleanup function from invoking put_device by assigning
 	 * NULL to dev.
@@ -285,6 +397,12 @@ static int rzt2h_icu_init(struct device_node *node, st=
ruct device_node *parent)
 	dev =3D NULL;
=20
 	return 0;
+
+err_irq_domain_free:
+	irq_domain_remove(irq_domain);
+err_pm_put:
+	pm_runtime_put_sync(dev);
+	return ret;
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzt2h_icu)
--=20
2.55.0


