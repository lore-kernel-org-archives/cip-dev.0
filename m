Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3C9C624D8
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:42 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8568.1788341257504391890
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=jfFBAKHA;
 spf=pass (domain: renesas.com, ip: 52.101.229.16, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGDJp7/2KY4hYo0VJXUqY8pLRlgSgG3G7dmUFHot2fdgIwTFkgDT+akJfwltGQMcimEsP4OUUMG62o3RRWtrAuGmbqsBOGUQP4hswphBx6l63yJ6aKwNSqA/433YRKBC7bu60ZlqNlUcEQ4nNWljed0ZkW+U3AXi5a7h1ZNzFe/MBZC+jsCdrL/LK+03FKKlfgsH8NqWmbElVbpWcYuuJh2lxpn4UkNFWz99qiV0DSPKOl6/KPabXXKDwtFgZAdnfKQOpr+UwsC1dxETwIbAk1ucsEfEnrXoRfqsD0W5p9G6dj+SXK7rkf9CoNeER+6Il7dvVkkWPqoepjHsKw/RKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJSQA+OSU/Y3zVcObT0p0iVIJGUNT6oF6ZtfvMzOAQU=;
 b=DyvFFtx+x0BSuhCV86aWgoddpMJYYVVj+iNiXDgvfmvLyc3Qt6u7+0mTgF4f2EM95oAXm//Lt1Ck6v8RENG004RUD6FJmGrbkgD2ud8SpJ7Jze5FboW1MDniqU8pHalEByZ8074IxVtS4EVTEKHMdjBLbaHDFMjG7FcweSJaAcriVzOEytIoqw18ygTx146/llS7oNmQuwTnVzHEo1dvqgXfqx3hW+qez6Zc8tqFrQSp6+T/HNckHTJHcVaqaISj+h0SzRsmH9YkMJAiTMJ/hChXN+V6e1DebnOFDVLJ/rXbMpUwbi5u4hkKkxaHz+9bgP4x7LLtcCR/umsmGYU/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJSQA+OSU/Y3zVcObT0p0iVIJGUNT6oF6ZtfvMzOAQU=;
 b=jfFBAKHACkmFC1K8aswhe9G9q6K5NDIfZFT62bcMmj3NBwyOK5U9x2qRWq0bfmkCY8E/icd8SU1ltq8QqJk4PxfRIWfLzHaEOQIN8C6yVKes4Q8RmEQ7PfOeRF0TN72GHey3GvgIvkLEoE1aVOg/2zD/MD4nI6CynggY4da8hUs=
Received: from TY4P286CA0100.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:380::18)
 by OS3PR01MB8604.jpnprd01.prod.outlook.com (2603:1096:604:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:27:29 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380:cafe::6c) by TY4P286CA0100.outlook.office365.com
 (2603:1096:405:380::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:29 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 0DA2E300034C;
	Wed,  2 Sep 2026 18:27:27 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 08/11] irqchip/renesas-rzv2h: Handle ICU error IRQ and add SWPE trigger
Date: Wed,  2 Sep 2026 09:26:59 +0000
Message-ID: <20260902092702.24746-9-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|OS3PR01MB8604:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 45aab2ba-28b2-4b7e-4049-08df08d468c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|22082099003|18002099003|13003099007|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	5OHQHAy6rkVtVeyrrMid5VOzNrDnikCvp38DA84o4cvjVAlXl8iG4s1igzTpIQe7G20E6tSyOiv6WXREfa6bHsv0Iks6YRyl7OD5vQZoxuOQWZLNWEkadpBViH1QrobUMbfNRaAnuXJZiKcsHjlE4okoMd3jhIOG/xW8vTRKcnobLu9kt4MG7yPgtQrKYdKIm4xFvPTvUGJL2dnVIo17O6BQKehBMJRrXU4UGPq+C1pkJIduwlifq0nD+n0fASqa7pLHfrZpMEAJAu8ZpnXqT1w+AfW6DxnOPyNqTx7bCpWZBLqhCHZ0hxF2j//U65PWSGPNGwNu/bPsvSiK1jaJIGB56W7xAHzpRiSiEfh932JpfLBOJR/FA2d/IIp/Fr1qFYpfUikIJiD3NkyEfBwi5pATF4sclUNFPVPhfg/L3bI9ajA7whPSoqVd/vUkTdYatXlp/mQZbztPCnqjbKb3DGqKwf6wWpel/+8lU6+iA/oHWFyDf6jKH1VQxE8gkuRaFSJlSaJZWgtHX5hEojfh0qai76bNauqoP3hC7Zm8YWt6r44a0csyrvA9LwcoBYEVPjc2j0Xv8D7lZROGuzDA8WYIqNnk46Oe4teyCqjJrynxpIdgGEREdPknvhJ6+xV5YpJyD0VbTT4E/N8gHqr+n26/dCZdMF4Kt/fmIdZm3Q4=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(13003099007)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	BjOu1+sHvXq/abitXP/BSgscM9kDaxB2oI2QR3hKCZkwIpk6BLPkE5NKU04vYTmr9zJtBaVOW1neBtMgRILz3I9onVei/vE8bs7QGvisfDit0DKJQxdN6pOlL9/LXfQa46ECSkOxR1MZnHcxmaHGVGphvFnGhY07/dB9Lad1doPQ+MLoZPNAZNf77C41cXs75GcvRWSKEN1MFWTP76UPhBMgfpHqX+R6LLrrLCwEL4gY3s5VsjhXEymYAv9TmX4u2TBtb0gL6IAqu8irJO3rPYFpGkPwlczqC+GAnH+TmcBdCp/0I24PHindez1nTenGZisetd8J5509IQqhj0X+vB9oKHL24YTOdxhsuHtKW4agSHn6XULExdjyc6SQFihT1ZQUhuoWa6fp7i8qUQw9UnIE4MFIybU+BGyRay8gqsPRIfd1dUJYSRDw3ct2rJtM
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:29.3180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aab2ba-28b2-4b7e-4049-08df08d468c4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8604
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24077

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7585a27644f338b3e764ceeda4be10e7047331a7 upstream.

Handle the RZ/V2H ICU error interrupt to help diagnose latched bus,
ECC RAM, and CA55/IP error conditions.

Support error injection via ICU_SWPE to allow testing the pseudo error
error interrupts.

Account for SoC differences in ECC RAM error register coverage so the
handler only iterates over valid ECC status/clear banks, and route the
RZ/V2N compatible to a probe path with the correct ECC range while
keeping the existing RZ/V2H and RZ/G3E handling.

[ tglx: Convert to hwirq_within() and upgrade to pr_warn() for those errors=
 ]

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260304113317.129339-8-prabhakar.mahadev-la=
d.rj@bp.renesas.com
[OP: adjusted rzv2n_icu_probe() to rzv2n_icu_init() for the init path, as
upstream commit 1e3e330c0707 ("irqchip: Pass platform device to platform
drivers") is not present in 6.12 CIP]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 163 +++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index d92c0475f06b..238c8383b387 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -33,7 +33,10 @@
 #define ICU_CA55_INT_START			(ICU_TINT_LAST + 1)
 #define ICU_CA55_INT_COUNT			4
 #define ICU_CA55_INT_LAST			(ICU_CA55_INT_START + ICU_CA55_INT_COUNT - 1)
-#define ICU_NUM_IRQ				(ICU_CA55_INT_LAST + 1)
+#define ICU_ERR_INT_START			(ICU_CA55_INT_LAST + 1)
+#define ICU_ERR_INT_COUNT			1
+#define ICU_ERR_INT_LAST			(ICU_ERR_INT_START + ICU_ERR_INT_COUNT - 1)
+#define ICU_NUM_IRQ				(ICU_ERR_INT_LAST + 1)
=20
 /* Registers */
 #define ICU_NSCNT				0x00
@@ -46,7 +49,15 @@
 #define ICU_TSCLR				0x24
 #define ICU_TITSR(k)				(0x28 + (k) * 4)
 #define ICU_TSSR(k)				(0x30 + (k) * 4)
+#define ICU_BEISR(k)				(0x70 + (k) * 4)
+#define ICU_BECLR(k)				(0x80 + (k) * 4)
+#define ICU_EREISR(k)				(0x90 + (k) * 4)
+#define ICU_ERCLR(k)				(0xE0 + (k) * 4)
 #define ICU_SWINT				0x130
+#define ICU_ERINTA55CTL(k)			(0x338 + (k) * 4)
+#define ICU_ERINTA55CRL(k)			(0x348 + (k) * 4)
+#define ICU_ERINTA55MSK(k)			(0x358 + (k) * 4)
+#define ICU_SWPE				0x370
 #define ICU_DMkSELy(k, y)			(0x420 + (k) * 0x20 + (y) * 4)
 #define ICU_DMACKSELk(k)			(0x500 + (k) * 4)
=20
@@ -97,6 +108,10 @@
 #define ICU_RZG3E_TSSEL_MAX_VAL			0x8c
 #define ICU_RZV2H_TSSEL_MAX_VAL			0x55
=20
+#define ICU_SWPE_NUM				16
+#define ICU_NUM_BE				4
+#define ICU_NUM_A55ERR				4
+
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
=20
 /**
@@ -117,12 +132,16 @@ struct rzv2h_irqc_reg_cache {
  * @t_offs:		TINT offset
  * @max_tssel:		TSSEL max value
  * @field_width:	TSSR field width
+ * @ecc_start:		Start index of ECC RAM interrupts
+ * @ecc_end:		End index of ECC RAM interrupts
  */
 struct rzv2h_hw_info {
 	const u8	*tssel_lut;
 	u16		t_offs;
 	u8		max_tssel;
 	u8		field_width;
+	u8		ecc_start;
+	u8		ecc_end;
 };
=20
 /* DMAC */
@@ -456,6 +475,36 @@ static int rzv2h_icu_swint_set_irqchip_state(struct ir=
q_data *d, enum irqchip_ir
=20
 	/* Trigger the software interrupt */
 	writel_relaxed(bit, priv->base + ICU_SWINT);
+
+	return 0;
+}
+
+static int rzv2h_icu_swpe_set_irqchip_state(struct irq_data *d, enum irqch=
ip_irq_state which,
+					    bool state)
+{
+	struct rzv2h_icu_priv *priv;
+	unsigned int bit;
+	static u8 swpe;
+
+	if (which !=3D IRQCHIP_STATE_PENDING)
+		return irq_chip_set_parent_state(d, which, state);
+
+	if (!state)
+		return 0;
+
+	priv =3D irq_data_to_priv(d);
+
+	bit =3D BIT(swpe);
+	/*
+	 * SWPE has 16 bits; the bit position is rotated on each trigger
+	 * and wraps around once all bits have been used.
+	 */
+	if (++swpe >=3D ICU_SWPE_NUM)
+		swpe =3D 0;
+
+	/* Trigger the pseudo error interrupt */
+	writel_relaxed(bit, priv->base + ICU_SWPE);
+
 	return 0;
 }
=20
@@ -561,6 +610,23 @@ static const struct irq_chip rzv2h_icu_swint_chip =3D =
{
 				  IRQCHIP_SKIP_SET_WAKE,
 };
=20
+static const struct irq_chip rzv2h_icu_swpe_err_chip =3D {
+	.name			=3D "rzv2h-icu",
+	.irq_eoi		=3D irq_chip_eoi_parent,
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+	.irq_disable		=3D irq_chip_disable_parent,
+	.irq_enable		=3D irq_chip_enable_parent,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D rzv2h_icu_swpe_set_irqchip_state,
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
@@ -594,6 +660,8 @@ static int rzv2h_icu_alloc(struct irq_domain *domain, u=
nsigned int virq, unsigne
 		chip =3D &rzv2h_icu_irq_chip;
 	} else if (hwirq_within(hwirq, ICU_CA55_INT)) {
 		chip =3D &rzv2h_icu_swint_chip;
+	} else if (hwirq_within(hwirq, ICU_ERR_INT)) {
+		chip =3D &rzv2h_icu_swpe_err_chip;
 	} else {
 		chip =3D &rzv2h_icu_nmi_chip;
 	}
@@ -636,6 +704,48 @@ static void rzv2h_icu_put_device(void *data)
 	put_device(data);
 }
=20
+static irqreturn_t rzv2h_icu_error_irq(int irq, void *data)
+{
+	struct rzv2h_icu_priv *priv =3D data;
+	const struct rzv2h_hw_info *hw_info =3D priv->info;
+	void __iomem *base =3D priv->base;
+	unsigned int k;
+	u32 st;
+
+	/* 1) Bus errors (BEISR0..3) */
+	for (k =3D 0; k < ICU_NUM_BE; k++) {
+		st =3D readl(base + ICU_BEISR(k));
+		if (!st)
+			continue;
+
+		writel_relaxed(st, base + ICU_BECLR(k));
+		pr_warn("rzv2h-icu: BUS error k=3D%u status=3D0x%08x\n", k, st);
+	}
+
+	/* 2) ECC RAM errors (EREISR0..X) */
+	for (k =3D hw_info->ecc_start; k <=3D hw_info->ecc_end; k++) {
+		st =3D readl(base + ICU_EREISR(k));
+		if (!st)
+			continue;
+
+		writel_relaxed(st, base + ICU_ERCLR(k));
+		pr_warn("rzv2h-icu: ECC error k=3D%u status=3D0x%08x\n", k, st);
+	}
+
+	/* 3) IP/CA55 error interrupt status (ERINTA55CTL0..3) */
+	for (k =3D 0; k < ICU_NUM_A55ERR; k++) {
+		st =3D readl(base + ICU_ERINTA55CTL(k));
+		if (!st)
+			continue;
+
+		/* there is no relation with status bits so clear all the interrupts */
+		writel_relaxed(0xffffffff, base + ICU_ERINTA55CRL(k));
+		pr_warn("rzv2h-icu: IP/CA55 error k=3D%u status=3D0x%08x\n", k, st);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t rzv2h_icu_swint_irq(int irq, void *data)
 {
 	u8 cpu =3D *(u8 *)data;
@@ -646,12 +756,15 @@ static irqreturn_t rzv2h_icu_swint_irq(int irq, void =
*data)
=20
 static int rzv2h_icu_setup_irqs(struct platform_device *pdev, struct irq_d=
omain *irq_domain)
 {
+	const struct rzv2h_hw_info *hw_info =3D rzv2h_icu_data->info;
 	bool irq_inject =3D IS_ENABLED(CONFIG_GENERIC_IRQ_INJECTION);
 	static const char * const rzv2h_swint_names[] =3D {
 		"int-ca55-0", "int-ca55-1",
 		"int-ca55-2", "int-ca55-3",
 	};
+	static const char *icu_err =3D "icu-error-ca55";
 	static const u8 swint_idx[] =3D { 0, 1, 2, 3 };
+	void __iomem *base =3D rzv2h_icu_data->base;
 	struct device *dev =3D &pdev->dev;
 	struct irq_fwspec fwspec;
 	unsigned int i, virq;
@@ -677,6 +790,35 @@ static int rzv2h_icu_setup_irqs(struct platform_device=
 *pdev, struct irq_domain
 		}
 	}
=20
+	/* Unmask and clear all IP/CA55 error interrupts */
+	for (i =3D 0; i < ICU_NUM_A55ERR; i++) {
+		writel_relaxed(0xffffff, base + ICU_ERINTA55CRL(i));
+		writel_relaxed(0x0, base + ICU_ERINTA55MSK(i));
+	}
+
+	/* Clear all Bus errors */
+	for (i =3D 0; i < ICU_NUM_BE; i++)
+		writel_relaxed(0xffffffff, base + ICU_BECLR(i));
+
+	/* Clear all ECCRAM errors */
+	for (i =3D hw_info->ecc_start; i <=3D hw_info->ecc_end; i++)
+		writel_relaxed(0xffffffff, base + ICU_ERCLR(i));
+
+	fwspec.fwnode =3D irq_domain->fwnode;
+	fwspec.param_count =3D 2;
+	fwspec.param[0] =3D ICU_ERR_INT_START;
+	fwspec.param[1] =3D IRQ_TYPE_LEVEL_HIGH;
+
+	virq =3D irq_create_fwspec_mapping(&fwspec);
+	if (!virq) {
+		return dev_err_probe(dev, -EINVAL, "failed to create IRQ mapping for %s\=
n",
+				     icu_err);
+	}
+
+	ret =3D devm_request_irq(dev, virq, rzv2h_icu_error_irq, 0, dev_name(dev)=
, rzv2h_icu_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request %s IRQ\n", icu_err);
+
 	return 0;
 }
=20
@@ -790,12 +932,24 @@ static const struct rzv2h_hw_info rzg3e_hw_params =3D=
 {
 	.t_offs		=3D ICU_RZG3E_TINT_OFFSET,
 	.max_tssel	=3D ICU_RZG3E_TSSEL_MAX_VAL,
 	.field_width	=3D 16,
+	.ecc_start	=3D 1,
+	.ecc_end	=3D 4,
+};
+
+static const struct rzv2h_hw_info rzv2n_hw_params =3D {
+	.t_offs		=3D 0,
+	.max_tssel	=3D ICU_RZV2H_TSSEL_MAX_VAL,
+	.field_width	=3D 8,
+	.ecc_start	=3D 0,
+	.ecc_end	=3D 2,
 };
=20
 static const struct rzv2h_hw_info rzv2h_hw_params =3D {
 	.t_offs		=3D 0,
 	.max_tssel	=3D ICU_RZV2H_TSSEL_MAX_VAL,
 	.field_width	=3D 8,
+	.ecc_start	=3D 0,
+	.ecc_end	=3D 11,
 };
=20
 static int rzg3e_icu_init(struct device_node *node, struct device_node *pa=
rent)
@@ -803,6 +957,11 @@ static int rzg3e_icu_init(struct device_node *node, st=
ruct device_node *parent)
 	return rzv2h_icu_init_common(node, parent, &rzg3e_hw_params);
 }
=20
+static int rzv2n_icu_init(struct device_node *node, struct device_node *pa=
rent)
+{
+	return rzv2h_icu_init_common(node, parent, &rzv2n_hw_params);
+}
+
 static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
 {
 	return rzv2h_icu_init_common(node, parent, &rzv2h_hw_params);
@@ -810,7 +969,7 @@ static int rzv2h_icu_init(struct device_node *node, str=
uct device_node *parent)
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
 IRQCHIP_MATCH("renesas,r9a09g047-icu", rzg3e_icu_init)
-IRQCHIP_MATCH("renesas,r9a09g056-icu", rzv2h_icu_init)
+IRQCHIP_MATCH("renesas,r9a09g056-icu", rzv2n_icu_init)
 IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
 MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");
--=20
2.34.1


