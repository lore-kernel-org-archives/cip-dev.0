Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4754C624D8
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:24:31 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8281.1788341063484490896
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:24:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=Q5Ao29ZR;
 spf=pass (domain: renesas.com, ip: 52.101.229.46, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jv8AljyvgEtlpL8cgnZulW7d6THho26R4eDjttnNvj4AcQOJufGirGgbIhpTlvzhMw9AvpPDicFBef6omggBpZBzTMlZRWu9iX+4FYPT4WPWP1dwkLCNmtnHEwX+7b3slqif5BsYPC9wSbvPsAgHSvnKM5u7Vwxo1LqL9mAEaQ+EaAe4uWLIxe2FC/FCrPRSDXZiH9RgCIqNu1PKTVKKffo2lILTkgFXMO+FBv0PZDvN81rnTH+q50jUW9g/EilKiTnVM3LgCSG7KQl8XbrEivvuuQIQk1pqpitZan9kdHp2NIAgBXSvsgM1vgtbqsj4cTYlaLDpHLUoKAPkal8oPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTk8Q5AUsoJ+eVyTgKryG/osMD6nVPPS73rfRnmL4OM=;
 b=fqtrAXMWi4vkMyIHU4eMahJHCqS/QVu9ybyaBrXIXAAlY11LQtmCVD6Be/0h5KGKrgz6py/IKW33b6XGEej0AxCoZEjFBTJvP2hU1jM0jhjGIJqUOoyIkquWJcaYWX1YhVVijCwgHvQGZxxxe9R1sraLurWRyipS1ToaDyjux0n2yB0Y+UwcEq1pPpsh0Fx8Iv+iTLAHedVdiyz7ynqvN0k8gLaUsSON20yVW8dTaP8SG7720o/3jj02/El2SeqoThYbiqbkrzuPQmI3HIXzLFzWCUQsBHedKIxceQmwAQLHev2T5Wv6HHWKUsERoDlSDZvikjiWWCnPNMr/lsXxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTk8Q5AUsoJ+eVyTgKryG/osMD6nVPPS73rfRnmL4OM=;
 b=Q5Ao29ZRkpuiEI5BtjSdcbxh5gceILuVIGPJwvrGhokj06lrqbp2BtkRrkxXxhrkwUQ+BEI91YF3aMA2LGwoFxVcJ53SwxSzFKmWT6nIBnxM9Vv7BhBJyH2P/2HYJvepX1kTQGHIoWRD/7iKBSL7J5oZPF06Sh+SBeqb/F2Zmko=
Received: from TYCP286CA0259.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:455::7)
 by OS7PR01MB13862.jpnprd01.prod.outlook.com (2603:1096:604:36b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:24:16 +0000
Received: from TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455:cafe::21) by TYCP286CA0259.outlook.office365.com
 (2603:1096:400:455::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BADA.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:24:16 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 6BF3D300035F;
	Wed,  2 Sep 2026 18:24:15 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 06/11] irqchip/renesas-rzv2h: Replace single irq_chip with per-region irq_chip instances
Date: Wed,  2 Sep 2026 09:23:47 +0000
Message-ID: <20260902092353.24648-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BADA:EE_|OS7PR01MB13862:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a0aa5434-d1fa-4d45-e052-08df08d3f5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	MIB3Udvc81ECMPucAGWobGIIXUXkWUBcjG3Y8yoVLeQN6UIwTQuOnzjIsJyhLqQl894LXO7jI3C++5MpKshCnrxFuRuOxD7dXqcvHLOV5UUPSqqSobKHoQsJk/MSH8cWw3NVkdnnTEp7VhGL3A03p9AviLMJ/cDNK+EiPfa/KBLnRHT4EHoijC5cF2cVQfwbSCatGiqWTn/++NnGwiAodteT8y4Q2Ex4gp2gPmZiMaboYzTrkBHu417j1g16qMj580/tj7JegZ4dan7IGiiudL1l+jmN1hJKeYJqrbDUzqNwsfngkDmTHUTLMXeuWlylANnZojUWcPKWalyLxqZCCh7KtL9+Q+b4NUtERu4EY6FdHp5/koB7xD2iJphKrcvPCUJItGnPnzZPl+JIImrJ0InhFb381xCzatHaJVwjSMTf5UTNOebQV793XphKsEP+Z78Ap5FEN0O8QkYa0FrvXNLl76QYo45j/tfcoqH0GTi38Uz3bJoeO1Uwd2VYdSVRhu1ymbcjgawo6P7IH+XJ2WXYp0SjwKDP72j470aEdwvww9j7qnb/xfKZRzuHzmomHr1WNWIw/rHtULRdDGCEENYFIVX+C4d3ri2YyAloa8lwcZ64sHjEvQ9ov5UIItExra7K3hmvV7Zczd4jY3fRUJuqL/RrknQcTr2qZQPY+S8=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	WcKmbLpTcPlDw9Y6WorBFk8YFTWVnXk/V7TPj4nzEU02haaJQrje9pG7wwRZPZIWJ9Pw310tNryIJvNENOOE7jnEHHnfA41pipjtD8zIExIYUm0fcfFq6qzM+mMaXlDSBqYdZErUUie4gpbG6vIyVayiQahpHssHQ/Ub37ZpCol2WMFGo9GjHk7HmK/SBtAkps+4H0ODFqPmunx34l9+FFdobInHM+nUnA17GVtwLtX42U+SfI1z5e/Q4DazeMCCEF/J3v24rR73UwgBNVsLFEbAE/hX19VhWLxImV8cZQJpr3haxLbtKQW9Fu9n7+SDIOXMJrfsKXLomNFSb+r6sFlQNWsMdjpOWxPb+hGW1rqlTn3QmZeJK9bkg3jTICA0rbsbW82pEgMQPq8g2x+Zm9kbYaryW1s0X+REQ6QcMUX9hhFNdxOpIc7EgBty6pmk
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:24:16.6460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0aa5434-d1fa-4d45-e052-08df08d3f5ec
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13862
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:24:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24061

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
index b6ca865d9e9b..45b30503f88e 100644
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


