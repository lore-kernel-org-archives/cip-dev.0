Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8464C88E53
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 08:11:52 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34549.1789114309783753737
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 01:11:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pDw55I+U;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.36, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPtSxBHu9gbfR0oc2pGX9uTAZ1u0uAk8ziJaSA0he+OJt2t6EFlNn4jJK2PUW4zbNlxClCFCNa7rM5Ap8ZXUoshrfShEx1lAXAJ7OV6ScGwuS2D7AUetgpYUlimnhOsaScGYbQgVax7sTBzMLj6CLXrg2UGO/Qn0/Y7F7RiQkLVAR8caLnOltrYVXwzAvMBH5QCADFylXrRnIpfibuKoqZp25rn4yUuzk5xq3mS8RUaYZ1Rh1HEwBM6qHQ33Q6U7xzrNxsQsvHHtzU7iZBD7FbS6qSbJ8EOIwojiMMu6+IPh5r0LwjJAopdai02cpw908cJaCSlYbrowU0AxoxJhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peLdsh0GiatmXudz/yBIgh39rUJdbDviC3Uix8UyMe8=;
 b=birZNtE2HW88ICjydETidbKvLI9GPbXS26SdAj2YcXDeXGIy81bmWDxIK1FQfZs7tO0Kz+wYmF7LHKnk4N6u8lmfWTsy8y3bZvg1TIM5AQBm7NTzOfN9bR1L2o1aMrjz3h71CfhFMtW3twYcLl8Y/8i2u2Q9cm71ztEWk/F8ldqpIHB3VlVWwedq5gTv4TaRzFY1BvEhSjQIUROPfkmQGCjtQJydRGwQx3dkyjLmHKoaYnTldf4HSEVWW779A2QVxnBTjG3LTyFiWJZcoEiFxIHvM0pCWxJPGKbWf7wx7kHXFqK0hldtAejgY7aFxsylRSUe2G14KIGPTVVj/O3zWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peLdsh0GiatmXudz/yBIgh39rUJdbDviC3Uix8UyMe8=;
 b=pDw55I+U2O4C4lUt1G4WeEEfhTzdgxpo14hBGKLmZfrOWVx4cjqkrVv/GdEp7kYiJzwbDuwjdY5wV3tNmlKGWGtlxp+T0MVByfdnsqYkYdTK66Pa1LdQc0bo7a1B0mTEOTrAtU8iEpyE8IqcT2x71+FnQi0/Q0x/i0GnESA6GNQ=
Received: from OS7PR01CA0006.jpnprd01.prod.outlook.com (2603:1096:604:251::8)
 by OSZPR01MB9298.jpnprd01.prod.outlook.com (2603:1096:604:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:11:43 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:251:cafe::7) by OS7PR01CA0006.outlook.office365.com
 (2603:1096:604:251::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 08:11:43 +0000
Received: from Ubuntu-22.. (gbr-5cg2238qm6.diasemi.com [10.24.0.235])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id D9CF730002A7;
	Fri, 11 Sep 2026 17:11:41 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 5/8] dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
Date: Fri, 11 Sep 2026 09:11:29 +0100
Message-ID: <20260911081132.11879-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|OSZPR01MB9298:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a02dc942-fda2-4eaf-094b-08df0fdc50d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	PVk+4L1aOvBjUa+yHTHYgfRBSmRPCOfUD8wr3PRhlzcffgGhiC2wFBlIE8fbJP5GRmjwmlmM7FW9hxYzGuShPC2lRa+jXOPPZ0dIJbR+2awWqG3bPjax56NdZ9Dn3xx8GA8X6Tp0BsDrBywpGBwPoVy7mKl8+IK3Fkrmq2S8l1V5SBvBCUmiikw/qpFnkCWuJBjU8kjreFkHdWHfR2IYEJy/iaUmlwsE62cI9EYrw8Pvchwts2p/aXBzBkl0eW1hWlKmv74B5umXAsjTGL5cKv4VqASSHz54nMSBnIyA6EqD5eYnUk7kAfOzfiYjcen3TalHxI0TX810lZe9MZ3bqGCU80OvAvj7SkboL/VpTQlf1JOweIsmnoqsEYwtgE//ZulQCPW2Wdvh6GMSz8JcvXhPcsBSzOYgkv2iNU13+sSMCMtisw0eQx9kr0+56/nmbKasez7EPtc9wmFREBq4sSbbmvQHSdObOrjT6GAMKs9vAemjG1onshNNA0vesWlFtFy4v2CLC0fI2CkDxHRxKK+MeGpwiz45s8Z9/NF0bJF8ibwMUHqUrGCsIYUKYJ9NMPaQjaJoRt+atBP7Way1vFQTQLQ2r1ZED0coYA3P06jdVQCBYWOkQcQUABpcL5WcfbrDHNrkLR47nJDf6bumvw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	qyqjNxCscdM0iS5XhB6Rsehveb+1Rse4kOJILUomlF1cRBkOHcJbCUQEXgcOky6fU6xAGcT3v8yA7GxgRfdQy/cyrj/J/BLZX+CXT3iM0uCES3F0mcLzN2YamcoW04ngORIf6EeP1CFIu+AaF5rBKgU1RUnMCQHfy8b25TPvOexnFGnh/Hd/v3QL2nf5ZiN2Yl78Uf5OVeaUav9CU8Gn1TZW2WtqbabKwAn+CVImqp7o9kbelRd/dNQMVhFUV4/JhhhFlDZL2tsBuZlnPurd0GMhFGWYVrnm0cehygu8Nk486UiYdmEHhw2X9Si/oV6oj3iBxywGL/iODewAQbvLcaujONpN9pTRcT7qh8al+LTv6sait6zzgp+k13GuJOMZVzWL8vkDBDJupWmUMP8/YYKhsrVUKU1ByxTTE76cYmCMRDdenQzkyQgWsiWRi+bU
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:11:43.2416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a02dc942-fda2-4eaf-094b-08df0fdc50d2
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9298
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 08:11:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24123

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit bbb8b402d798f9f211376cee3d649d64dfc17880 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs use a
completely different ICU unit compared to RZ/V2H, which requires a
separate implementation.

To prepare for adding support for these SoCs, add a chip-specific
structure and put a pointer to the rzv2h_icu_register_dma_req() function
in the .register_dma_req field of the chip-specific structure to allow
for other implementations. Do the same for the default request value,
RZV2H_ICU_DMAC_REQ_NO_DEFAULT, and place it into .dma_req_no_default.

While at it, factor out the logic that calls .register_dma_req() or
rz_dmac_set_dmars_register() into a separate function to remove some
code duplication.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260105114445.878262-3-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 65 ++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 2097c3033a567..6ff4e01245bd7 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -96,9 +96,16 @@ struct rz_dmac_icu {
 	u8 dmac_index;
 };
=20
+struct rz_dmac_info {
+	void (*icu_register_dma_req)(struct platform_device *icu_dev,
+				     u8 dmac_index, u8 dmac_channel, u16 req_no);
+	u16 default_dma_req_no;
+};
+
 struct rz_dmac {
 	struct dma_device engine;
 	struct rz_dmac_icu icu;
+	const struct rz_dmac_info *info;
 	struct device *dev;
 	struct reset_control *rstc;
 	void __iomem *base;
@@ -107,8 +114,6 @@ struct rz_dmac {
 	unsigned int n_channels;
 	struct rz_dmac_chan *channels;
=20
-	bool has_icu;
-
 	DECLARE_BITMAP(modules, 1024);
 };
=20
@@ -317,6 +322,16 @@ static void rz_dmac_set_dmars_register(struct rz_dmac =
*dmac, int nr, u32 dmars)
 	rz_dmac_ext_writel(dmac, dmars32, dmars_offset);
 }
=20
+static void rz_dmac_set_dma_req_no(struct rz_dmac *dmac, unsigned int inde=
x,
+				   int req_no)
+{
+	if (dmac->info->icu_register_dma_req)
+		dmac->info->icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
+						 index, req_no);
+	else
+		rz_dmac_set_dmars_register(dmac, index, req_no);
+}
+
 static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
@@ -334,13 +349,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_=
dmac_chan *channel)
 	lmdesc->chext =3D 0;
 	lmdesc->header =3D HEADER_LV;
=20
-	if (dmac->has_icu) {
-		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
-					   channel->index,
-					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
-	} else {
-		rz_dmac_set_dmars_register(dmac, channel->index, 0);
-	}
+	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_=
no);
=20
 	channel->chcfg =3D chcfg;
 	channel->chctrl =3D CHCTRL_STG | CHCTRL_SETEN;
@@ -391,12 +400,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct =
rz_dmac_chan *channel)
=20
 	channel->lmdesc.tail =3D lmdesc;
=20
-	if (dmac->has_icu) {
-		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
-					   channel->index, channel->mid_rid);
-	} else {
-		rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
-	}
+	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
=20
 	channel->chctrl =3D CHCTRL_SETEN;
 }
@@ -680,13 +684,7 @@ static void rz_dmac_device_synchronize(struct dma_chan=
 *chan)
 	if (ret < 0)
 		dev_warn(dmac->dev, "DMA Timeout");
=20
-	if (dmac->has_icu) {
-		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
-					   channel->index,
-					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
-	} else {
-		rz_dmac_set_dmars_register(dmac, channel->index, 0);
-	}
+	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_=
no);
 }
=20
 /*
@@ -877,14 +875,13 @@ static int rz_dmac_parse_of_icu(struct device *dev, s=
truct rz_dmac *dmac)
 	uint32_t dmac_index;
 	int ret;
=20
-	ret =3D of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0, &args);
-	if (ret =3D=3D -ENOENT)
+	if (!dmac->info->icu_register_dma_req)
 		return 0;
+
+	ret =3D of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0, &args);
 	if (ret)
 		return ret;
=20
-	dmac->has_icu =3D true;
-
 	dmac->icu.pdev =3D of_find_device_by_node(args.np);
 	of_node_put(args.np);
 	if (!dmac->icu.pdev) {
@@ -938,6 +935,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (!dmac)
 		return -ENOMEM;
=20
+	dmac->info =3D device_get_match_data(&pdev->dev);
 	dmac->dev =3D &pdev->dev;
 	platform_set_drvdata(pdev, dmac);
=20
@@ -955,7 +953,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->base))
 		return PTR_ERR(dmac->base);
=20
-	if (!dmac->has_icu) {
+	if (!dmac->info->icu_register_dma_req) {
 		dmac->ext_base =3D devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(dmac->ext_base))
 			return PTR_ERR(dmac->ext_base);
@@ -1056,9 +1054,18 @@ static void rz_dmac_remove(struct platform_device *p=
dev)
 	pm_runtime_disable(&pdev->dev);
 }
=20
+static const struct rz_dmac_info rz_dmac_v2h_info =3D {
+	.icu_register_dma_req =3D rzv2h_icu_register_dma_req,
+	.default_dma_req_no =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
+};
+
+static const struct rz_dmac_info rz_dmac_generic_info =3D {
+	.default_dma_req_no =3D 0,
+};
+
 static const struct of_device_id of_rz_dmac_match[] =3D {
-	{ .compatible =3D "renesas,r9a09g057-dmac", },
-	{ .compatible =3D "renesas,rz-dmac", },
+	{ .compatible =3D "renesas,r9a09g057-dmac", .data =3D &rz_dmac_v2h_info }=
,
+	{ .compatible =3D "renesas,rz-dmac", .data =3D &rz_dmac_generic_info },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_rz_dmac_match);
--=20
2.43.0


