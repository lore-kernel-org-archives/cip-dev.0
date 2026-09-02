Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0849C624D9
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:24:31 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8521.1788341066887954570
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:24:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=BLUccg64;
 spf=pass (domain: renesas.com, ip: 52.101.228.0, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZKwqWdEC9uo+RXAgV7ptXCDQ6/Kj2tIJG52Eyzk6wn0+Zj3YbwfYWcYB/Vj8fCv1MsTX263ksVhMuZiXI0qg5RqZl4udGByeBPCrwC2qAYl45YaCndD7PAUinP5DP2shx+TZXnufryP5cEeMv+Bnpd1PmIx27ioiLEyhIlG23Kpd03MXBNMHKjPlcfM2FsFg++PkgrSdX3RuXik6nKIDzHyZQ63MRdTK1WeSDzHUrLEPXmD9r+z+7K3jVr7NrSzgqJpezCY6CbgMA0euGmn9E3JyWiXVEyK4NBqXLDPGd4KNFtRZai47ivX0xCqH8z43RIdWt1rDsXtfPfiC9YoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOXHvpL2cVRVkXqkDvxA3L5TsQGzFOyR406mE+1Qg10=;
 b=gygYD2ijsvtGY/lvRNfEbe2JUJvIwvrjNjLm4p1lJ6RSJq9NkfpFyV/imSABNLwXPewnkPgsMUuUW3jEk2B+Za+aRbO2CWBkGezn4X12vhP6nY+lKYE55ccj1yn4qe09kBDEUf+9GVAXsG2Dr/++uj35BU8ipT1vExrL4I3xkuI/HPHYmoRSOCtXDpUYxtpthiG/nk3Iidx7qJAbgA5k6di+e3vFYjRg0H1sW9iZfc/1pBRFwbVrjpuPrjcudrvYSaLstv2gNE9BFx0Rd70gzAtWek0e9uc1l0sxeCDtuHnaTnae8tIv+XGw1btbr4I5K+URslcl5ksToCtOjzjWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOXHvpL2cVRVkXqkDvxA3L5TsQGzFOyR406mE+1Qg10=;
 b=BLUccg64zFpmXkVAnzJrcTYn8jxVy6GRfXrStUrGh1WrKit/6SQtfMs7t8aa/nbgXQYnu6SL+OUvbqcnxNoSrzZBqWycfRETxLMGu9Ffb3xHdy/UTcZMyTev5SEBHtmFiQlzEv79oZQ2gHfhRY746jpiqz+ZcBb3gcEPordNOVQ=
Received: from TYCP286CA0258.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:455::6)
 by TYCPR01MB12122.jpnprd01.prod.outlook.com (2603:1096:400:43c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:24:18 +0000
Received: from TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455:cafe::63) by TYCP286CA0258.outlook.office365.com
 (2603:1096:400:455::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BADA.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:24:18 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 16487300035F;
	Wed,  2 Sep 2026 18:24:16 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 07/11] irqchip/renesas-rzv2h: Add CA55 software interrupt support
Date: Wed,  2 Sep 2026 09:23:48 +0000
Message-ID: <20260902092353.24648-8-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BADA:EE_|TYCPR01MB12122:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 136c1bfa-d237-4efd-a579-08df08d3f6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|6133799003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	o+c7FHvs8JW96A6G1p2JxhyM/GrFtREdHt4BVEbYbrxQe0h8jHF+0iyb0RycwGYoxnwUi9AubI6zWbDa+5G5KzaO81Bfdj3lxLge7QTcYkHJS2++M/wm/BLRiC0zkfRebhqkt/rvDSo3WlyPzs8b6b+f22Ztn+4h13e8srkoT8K0mqNr2APolwF7muy29VxWNOL8vgGl7YzSQKTFii6676uirPt1fQaxMw4qM8dZ/gE8cZqzBNJ+u+qqfl4DQmOO4fVKiuFoaDp00dGTppwW+6kJASIw2TcXD6Uzg7YLNNLb8yU90+LLpvRGa9E7M6Cq1CmKONPsS3rjrIL3dgrlzuwAjh85GgDt2fibWQIgwguXnpzi0e9zEcxCPrBa1bbRjpVZt7mOjvqnr+qqmxXzQLdle4fbkOckpIR2WWziMrzXMslaHXgysknhvUAE09MCIscwo7cb8Lk2mtKylK8s7hzFrwnDbCwrHkxP/U0etbloZFLJ8uEM8VBO19J+DrY27JolgsAjo/PyBfjPqrL/I51UOBkWaFFgjPqcJ9UiLsTmnfMZVsAgc3Y8I8mzNtR7WAZpmdi/w0RwYlCN7u4ZiQLic3ihImHxGzR3K9zme0h/eIaA3eoApiwXbDV2y16MsCToYRg6x3dnN7ERKtkZ/YAvDdRCg4uVvN5BnnzzkcY=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	HEHdni7Dzpy+kOuDCiZgxVAComFDUkHmUJjWyxT/MA1Wbf8q110ytoha3cz/15C7pcHMBLd0cI/wdj3D3KhruTIAiGLBEZJ9BDuyj9zzZgc69PDHUOlm+O5IRaGWhVUy7ygl8rtcgcA1NU+cKKHDs4soCI1+7FsBs+3Tej0RTiXMUgsuwnRYDzGshvq4Pn1kqEVgXz679jirbsz5PrHOTENhsFB6yVFE4gdgy0nc+NMOL9H+B7aVurb5ZudvrzbdKDBjlRAmn8xZFgmdqEqvn0HiPGXSSRYND0it4D1AmHD+ydZiwmgWVNqKjFyucZlbq7FsxPHhmdIglpdMqSoDagkMKwb0dz0ohKkRjbWfiYFzfHp2fnCvcnXPzCvIf+phiGn5eYxzQhsUPJqU+kqY/ph6kmmF/tljkQ5V2GUCtb/nEBBYjDhzWQsXBnHCFNYC
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:24:18.2952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 136c1bfa-d237-4efd-a579-08df08d3f6e8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12122
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:24:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24064

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
index 45b30503f88e..2b5765fefac5 100644
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
@@ -657,6 +746,10 @@ static int rzv2h_icu_init_common(struct device_node *n=
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


