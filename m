Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA7AC624D6
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:42 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8331.1788341253156954665
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=FclxYgCF;
 spf=pass (domain: renesas.com, ip: 52.101.229.38, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLE4Kt4upCIXavoSVrmybtw77BqYSkk2C7VzYQZGvFuymSJRxmZ1SgMgwiZjruz6qByc5sWstUiT6uQqAg0ASwAz9yfH/aJKJZuGtrIbe2NyFxRXl/wjNIi9w+EIR+1EElnLbB4NTNM8UAY3JVRCrNPrBPpiRKKm8uSTtB/j6ota+nIHzpcD4p820vJPiwnQuZ9wAmI62VYeUitxvI+icIhKNY4zSpz3Sm12LzHVR512rzlZYytUPro2cG3Aunw2++7s3ndaETv8WzwLgu0P/R6we127NY7IFkmA9Tz9r/eVPaXXC7Zebi0x4ptGZoepDQG949tbmAUh9H355CB7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkfb0fhWvwuvZQZ/VPUENfpNYTjTbkk7akKnfIMRZrE=;
 b=q2zGHvvqRZHvhge67iMWKsDgt+D7whMnMeYlY9oQKuzR1aNcbCEMwvCNionnt/N78QbCakcQ0VQg7CsBoDEAvfSEpt3cGHCNcwYsaNaGx+IJfkEFIYwnp5bVPV/fksm4hUlR7jSzc0VQICYATqxOGu8flpEnUR8VmmoYS/1OaXpsprPtqWLd3bhTbOgp3Gs4i62TbLMD0czEN8ZsHSUMvZIwHq+P+OW5UkAA5EDPT/5SYLEjlEJei7gwxmaLs5p6mNsSOAr7ZgSnlmHb5OEe9CrxEmeuZn5gsQ7hAsGoMji4zeAzP3wNLR+zty6pmDl3l2+C8wea+W2vHJ46ejM4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkfb0fhWvwuvZQZ/VPUENfpNYTjTbkk7akKnfIMRZrE=;
 b=FclxYgCFRMPS0xx8uhx0k4z+MYsjebETD1HN3MbjyG756ykRoIgRvW+1idgs45pYJo08eWVOhi+l5gZ6tD+p/dHTGv6F65xXP9Y1DWm/CKrnasuhYfJWScpQ4eyvWHZbsSilYHlqLXNDYcVOabpJ4YqfmTdyY/xBneDwBrzDI4s=
Received: from TY6P286CA0032.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b7::16)
 by TYRPR01MB12512.jpnprd01.prod.outlook.com (2603:1096:405:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:27:25 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7:cafe::6b) by TY6P286CA0032.outlook.office365.com
 (2603:1096:405:3b7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:25 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id A4099300034C;
	Wed,  2 Sep 2026 18:27:24 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 06/11] irqchip/renesas-rzv2h: Replace single irq_chip with per-region irq_chip instances
Date: Wed,  2 Sep 2026 09:26:57 +0000
Message-ID: <20260902092702.24746-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|TYRPR01MB12512:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ae3a0862-d66e-4f38-f05b-08df08d466b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|13003099007|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	yAzzhn+JAptH5ypF5B8bkuh2P1nDJtCLWzrjrp+zrhHmV/EJA70GZdBl8/MnGBMCmcIgIyawRekYSoXvc6BHBz6QUWtc/ZGYhCaqmxtYOEf+oTO7rgzcvUhl7n81kVc8pj7cEghByWNw0i20ibNkrm15cI94gpNy4JsgKgcw5KbHlp/Gme9NwnV4n45ZZ74pEuCNH0quQWah/OsE14EYjGJSrLpwyWESOvYP/YkCGWb2Sv5/JgdEUVIikmWvhCkJmMLmeaRTCnrzF4QIYkgEOLSqi4ZjxHOcl7h0a1lREeUNxaEuipbsAuTcGz8wuzcQVfrUqiTjWrzp1NVEg/KY/PT1Os68+lBNrTZMmXHpagKgr/7FeBJ7Wcf4Q1W6ISipGtKXEvIs2JrfiqBBkwfZmJg6rHIa3e3YiwYh703ulCa9YKwc6nQ8Ee4RGgJQoE8YsBiByJ3iG99hS5x4LEmFWNhkKmGTY1998sxU++ciFQZ4mb65w5GnALUtiPoGOGaB8JiE8ZeOcC68jwieGCULnv0n7VS5HsB//mUT60KBvw1Xxaqid0PIoDol0UKeHKdoI7cyLt6LR2xmT5ud6SUVcqZQ7GyMKtcf/tf3Kj7nSxmSeoE/tLV8Jw3E7z61CuL3SXmGIk9dLCrnirvD5z3qYlZtgryAk08p0f45I7uHqxc=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(13003099007)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	FhMHRKOpuKwbflmnni4PpVaxHSNLBPjOpX5OMK26m4OJTH6W+qvkkven/qh0OFMTD5H4QM6KQN5qtftmHV2KuUa46OK9Qq7aevz4YgSALL5i1fzitIqdsU1ofIgwsmDcvC71jamT5u23VRUeJALcuZixCLImOap7+iIAqzbjkY566ndnm1PtvOGYZEYJXeOZKVNy2Bv1A7qLJIYpeYPqT/CBZPhDb59S8OZbq2SsFmmjA8QOv2lTU9VswG/3AgrlehI6/hwKQv1j4koE+VO4fqi/NOL1gT1kM+exPVnCpw3arPWFByWzajFSwjYdMXWy3iDO1Qc/t8a0ObW8vPAyLAD1vefuiEF3FpejQ66C5wIa7gWMMn3pHsHe72LKU7QLo8QZfSZTA6ndX/Kx1Kg2TO+EcljdbNqHD1iEm+uHu0JuuBKBxZ2uAtlzlNuE822I
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:25.8878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3a0862-d66e-4f38-f05b-08df08d466b8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12512
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24074

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f3ebae6dc025d0e45e9240ed85f9909a5a91e03c upstream.

Replace the single rzv2h_icu_chip and its dispatcher callbacks with
dedicated irq_chip instances for each interrupt region: NMI, IRQ, and
TINT.

Move the irqd_is_level_type() check ahead of the scoped_guard in
rzv2h_icu_tint_eoi() and rzv2h_icu_irq_eoi() to avoid acquiring the
spinlock unnecessarily for level-type interrupts.

Drop the ICU_TINT_START guard from rzv2h_tint_irq_endisable() since it
is now only reachable via the TINT chip path.

[ tglx: Convert to hwirq_within() ]

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260304113317.129339-6-prabhakar.mahadev-la=
d.rj@bp.renesas.com
[OP: fixed minor context difference]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 174 +++++++++++++++++-----------
 1 file changed, 104 insertions(+), 70 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 8a95f19a40a9..8ba131baf25f 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -171,32 +171,47 @@ static inline struct rzv2h_icu_priv *irq_data_to_priv=
(struct irq_data *data)
 	return data->domain->host_data;
 }
=20
-static void rzv2h_icu_eoi(struct irq_data *d)
+static void rzv2h_icu_tint_eoi(struct irq_data *d)
 {
 	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
 	unsigned int hw_irq =3D irqd_to_hwirq(d);
 	unsigned int tintirq_nr;
 	u32 bit;
=20
-	scoped_guard(raw_spinlock, &priv->lock) {
-		if (hw_irq >=3D ICU_TINT_START) {
-			tintirq_nr =3D hw_irq - ICU_TINT_START;
-			bit =3D BIT(tintirq_nr);
-			if (!irqd_is_level_type(d))
-				writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
-		} else if (hw_irq >=3D ICU_IRQ_START) {
-			tintirq_nr =3D hw_irq - ICU_IRQ_START;
-			bit =3D BIT(tintirq_nr);
-			if (!irqd_is_level_type(d))
-				writel_relaxed(bit, priv->base + ICU_ISCLR);
-		} else {
-			writel_relaxed(ICU_NSCLR_NCLR, priv->base + ICU_NSCLR);
-		}
+	if (!irqd_is_level_type(d)) {
+		tintirq_nr =3D hw_irq - ICU_TINT_START;
+		bit =3D BIT(tintirq_nr);
+		writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
+	}
+
+	irq_chip_eoi_parent(d);
+}
+
+static void rzv2h_icu_irq_eoi(struct irq_data *d)
+{
+	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+	unsigned int tintirq_nr;
+	u32 bit;
+
+	if (!irqd_is_level_type(d)) {
+		tintirq_nr =3D hw_irq - ICU_IRQ_START;
+		bit =3D BIT(tintirq_nr);
+		writel_relaxed(bit, priv->base + ICU_ISCLR);
 	}
=20
 	irq_chip_eoi_parent(d);
 }
=20
+static void rzv2h_icu_nmi_eoi(struct irq_data *d)
+{
+	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
+
+	writel_relaxed(ICU_NSCLR_NCLR, priv->base + ICU_NSCLR);
+
+	irq_chip_eoi_parent(d);
+}
+
 static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
 {
 	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
@@ -204,9 +219,6 @@ static void rzv2h_tint_irq_endisable(struct irq_data *d=
, bool enable)
 	u32 tint_nr, tssel_n, k, tssr;
 	u8 nr_tint;
=20
-	if (hw_irq < ICU_TINT_START)
-		return;
-
 	tint_nr =3D hw_irq - ICU_TINT_START;
 	nr_tint =3D 32 / priv->info->field_width;
 	k =3D tint_nr / nr_tint;
@@ -229,13 +241,13 @@ static void rzv2h_tint_irq_endisable(struct irq_data =
*d, bool enable)
 	writel_relaxed(BIT(tint_nr), priv->base + priv->info->t_offs + ICU_TSCLR)=
;
 }
=20
-static void rzv2h_icu_irq_disable(struct irq_data *d)
+static void rzv2h_icu_tint_disable(struct irq_data *d)
 {
 	irq_chip_disable_parent(d);
 	rzv2h_tint_irq_endisable(d, false);
 }
=20
-static void rzv2h_icu_irq_enable(struct irq_data *d)
+static void rzv2h_icu_tint_enable(struct irq_data *d)
 {
 	rzv2h_tint_irq_endisable(d, true);
 	irq_chip_enable_parent(d);
@@ -261,7 +273,7 @@ static int rzv2h_nmi_set_type(struct irq_data *d, unsig=
ned int type)
=20
 	writel_relaxed(sense, priv->base + ICU_NITSR);
=20
-	return 0;
+	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
 }
=20
 static void rzv2h_clear_irq_int(struct rzv2h_icu_priv *priv, unsigned int =
hwirq)
@@ -311,14 +323,15 @@ static int rzv2h_irq_set_type(struct irq_data *d, uns=
igned int type)
 		return -EINVAL;
 	}
=20
-	guard(raw_spinlock)(&priv->lock);
-	iitsr =3D readl_relaxed(priv->base + ICU_IITSR);
-	iitsr &=3D ~ICU_IITSR_IITSEL_MASK(irq_nr);
-	iitsr |=3D ICU_IITSR_IITSEL_PREP(sense, irq_nr);
-	rzv2h_clear_irq_int(priv, hwirq);
-	writel_relaxed(iitsr, priv->base + ICU_IITSR);
+	scoped_guard(raw_spinlock, &priv->lock) {
+		iitsr =3D readl_relaxed(priv->base + ICU_IITSR);
+		iitsr &=3D ~ICU_IITSR_IITSEL_MASK(irq_nr);
+		iitsr |=3D ICU_IITSR_IITSEL_PREP(sense, irq_nr);
+		rzv2h_clear_irq_int(priv, hwirq);
+		writel_relaxed(iitsr, priv->base + ICU_IITSR);
+	}
=20
-	return 0;
+	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
 }
=20
 static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int=
 hwirq)
@@ -393,48 +406,30 @@ static int rzv2h_tint_set_type(struct irq_data *d, un=
signed int type)
 	titsr_k =3D ICU_TITSR_K(tint_nr);
 	titsel_n =3D ICU_TITSR_TITSEL_N(tint_nr);
=20
-	guard(raw_spinlock)(&priv->lock);
-
-	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k)=
);
-	titsr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr=
_k));
-
-	tssr_cur =3D field_get(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_wid=
th), tssr);
-	titsr_cur =3D field_get(ICU_TITSR_TITSEL_MASK(titsel_n), titsr);
-	if (tssr_cur =3D=3D tint && titsr_cur =3D=3D sense)
-		return 0;
-
-	tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien)=
;
-	tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
-
-	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
-
-	titsr &=3D ~ICU_TITSR_TITSEL_MASK(titsel_n);
-	titsr |=3D ICU_TITSR_TITSEL_PREP(sense, titsel_n);
+	scoped_guard(raw_spinlock, &priv->lock) {
+		tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k=
));
+		titsr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(tits=
r_k));
=20
-	writel_relaxed(titsr, priv->base + priv->info->t_offs + ICU_TITSR(titsr_k=
));
+		tssr_cur =3D field_get(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_wi=
dth), tssr);
+		titsr_cur =3D field_get(ICU_TITSR_TITSEL_MASK(titsel_n), titsr);
+		if (tssr_cur =3D=3D tint && titsr_cur =3D=3D sense)
+			goto set_parent_type;
=20
-	rzv2h_clear_tint_int(priv, hwirq);
+		tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien=
);
+		tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
=20
-	writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR(ts=
sr_k));
+		writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k))=
;
=20
-	return 0;
-}
+		titsr &=3D ~ICU_TITSR_TITSEL_MASK(titsel_n);
+		titsr |=3D ICU_TITSR_TITSEL_PREP(sense, titsel_n);
=20
-static int rzv2h_icu_set_type(struct irq_data *d, unsigned int type)
-{
-	unsigned int hw_irq =3D irqd_to_hwirq(d);
-	int ret;
-
-	if (hw_irq >=3D ICU_TINT_START)
-		ret =3D rzv2h_tint_set_type(d, type);
-	else if (hw_irq >=3D ICU_IRQ_START)
-		ret =3D rzv2h_irq_set_type(d, type);
-	else
-		ret =3D rzv2h_nmi_set_type(d, type);
+		writel_relaxed(titsr, priv->base + priv->info->t_offs + ICU_TITSR(titsr_=
k));
=20
-	if (ret)
-		return ret;
+		rzv2h_clear_tint_int(priv, hwirq);
=20
+		writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR(t=
ssr_k));
+	}
+set_parent_type:
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
 }
=20
@@ -472,17 +467,51 @@ static struct syscore_ops rzv2h_irqc_syscore_ops =3D =
{
 	.resume		=3D rzv2h_irqc_irq_resume,
 };
=20
-static const struct irq_chip rzv2h_icu_chip =3D {
+static const struct irq_chip rzv2h_icu_tint_chip =3D {
+	.name			=3D "rzv2h-icu",
+	.irq_eoi		=3D rzv2h_icu_tint_eoi,
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+	.irq_disable		=3D rzv2h_icu_tint_disable,
+	.irq_enable		=3D rzv2h_icu_tint_enable,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_set_type		=3D rzv2h_tint_set_type,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
+static const struct irq_chip rzv2h_icu_irq_chip =3D {
+	.name			=3D "rzv2h-icu",
+	.irq_eoi		=3D rzv2h_icu_irq_eoi,
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+	.irq_disable		=3D irq_chip_disable_parent,
+	.irq_enable		=3D irq_chip_enable_parent,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_set_type		=3D rzv2h_irq_set_type,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
+static const struct irq_chip rzv2h_icu_nmi_chip =3D {
 	.name			=3D "rzv2h-icu",
-	.irq_eoi		=3D rzv2h_icu_eoi,
+	.irq_eoi		=3D rzv2h_icu_nmi_eoi,
 	.irq_mask		=3D irq_chip_mask_parent,
 	.irq_unmask		=3D irq_chip_unmask_parent,
-	.irq_disable		=3D rzv2h_icu_irq_disable,
-	.irq_enable		=3D rzv2h_icu_irq_enable,
+	.irq_disable		=3D irq_chip_disable_parent,
+	.irq_enable		=3D irq_chip_enable_parent,
 	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
 	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
 	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
-	.irq_set_type		=3D rzv2h_icu_set_type,
+	.irq_set_type		=3D rzv2h_nmi_set_type,
 	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
 	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
 				  IRQCHIP_SET_TYPE_MASKED |
@@ -495,6 +524,7 @@ static int rzv2h_icu_alloc(struct irq_domain *domain, u=
nsigned int virq, unsigne
 			   void *arg)
 {
 	struct rzv2h_icu_priv *priv =3D domain->host_data;
+	const struct irq_chip *chip;
 	unsigned long tint =3D 0;
 	irq_hw_number_t hwirq;
 	unsigned int type;
@@ -516,13 +546,17 @@ static int rzv2h_icu_alloc(struct irq_domain *domain,=
 unsigned int virq, unsigne
=20
 		if (!hwirq_within(hwirq, ICU_TINT))
 			return -EINVAL;
+		chip =3D &rzv2h_icu_tint_chip;
+	} else if (hwirq_within(hwirq, ICU_IRQ)) {
+		chip =3D &rzv2h_icu_irq_chip;
+	} else {
+		chip =3D &rzv2h_icu_nmi_chip;
 	}
=20
 	if (hwirq > (ICU_NUM_IRQ - 1))
 		return -EINVAL;
=20
-	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &rzv2h_icu_chi=
p,
-					    (void *)(uintptr_t)tint);
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, chip, (void *)=
(uintptr_t)tint);
 	if (ret)
 		return ret;
=20
--=20
2.34.1


