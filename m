Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.281.1795708108930398590
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ut7q4ZB+;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.12, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF6c8F2eWICytSROP77eZJtDPf7rR4x1wCqI/SYFxpTGXSeQW3CmCXc3vmBtK2+BZwuYDsBTd5uNThHxn3EEYnr7tgZ4ldNf3CzTjAYeRCtGgrlWL7ipsK+wWuqaiSnEmaTKWqfZBkQOffBnx1/qrJ+dPQhiZX6B3+P5+6lTwtLDKvgk6Epp/RcJbrj2zlrWx6mABwfZ3Cm1Hr1bw/fAqX4vf4sR63dAetk3q5kxFsdhSnqKg3g7XLu2VYWf7AmI6PFG+4Mvrx4Ub1p7GCxXfid4dUKx1km2j2bBBf/L0ArjMvDqrcoZPdKbqWqvnExC0eRRkTYIzmkm6CgvMCvkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ojr5aKbTlZwymeh7FQBh933RoAxd4cB6bytlIh9KlIY=;
 b=GlUDlu/Uc/oEvTFqJA0G874lhr93L5CZ45GhuuLIqKfWUqPPmDCk646FBbSzGSZZjd70Zr+bZZger4Fu6dLvxQ7EUA03fjGZZnaXhSkXHZCCjANI7Sm/qmHj898S5fgi8An5E6ZjoPGRp9Vo0fIg2yYhgugcs4YFPP5ey//Oj12cDhfQrQd/tHLgYlmk3QdCO1wWsKHZoUKrt1kf8oOWHuC2odzLmMCivcZW/YPFxGSxS7L+QIgg3ACd8hj0ayRKP6+2F15FKq3+xU/+pWbnmK9aNOuhFgImYiEBMLm8OdhurcmhpwJnLungikqzhqh/MG09gfjJeg9I5SPDy9ZSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ojr5aKbTlZwymeh7FQBh933RoAxd4cB6bytlIh9KlIY=;
 b=Ut7q4ZB+hEftCo0AydJ5a/DOmm6nlTp+W6JUcGnbp+XU//ytczN9h1TC3i9Ij4SRBbVrud+9ENY+mcbUYIoqy7gcR8jPNu/ocTzsyDpFtqFXTGkDrCTJ2GPHU822AmQ8Gm8r40KQeGMyT8f+ouwN1LQYKwB6UB/iEPkVrep/l9s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:26 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:26 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/27] dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
Date: Thu, 26 Nov 2026 16:47:25 +0100
Message-ID: <20261126154747.3832917-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB12784:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eaa69f7-4f22-4492-c7f7-08df4bd4b58d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026130827099003|261026140227099003|261026135527099003|261028144727099003|261022113327099003|261021130227099003|261021121427099003|261021133027099003|261021123027099003|261021135927099003|261022105027099003|261022075727099003|261022115727099003|261009221227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BKuuLpxBLe62HxnwZfoRB64BpPx1VXUyOkrWmqW53z2WcYO4OHMa6pPVaH0EGvKOtamDHRgKWdCsmBg8xKWpL+DyuEuPTf6IO+V9mAFfh9DdyHu8mJsfgmXG6mz2/eDP8btLom9vnqUxba8p+/y0SlxEkRL3nFRulg5burnTHQKF3y/JHgT/eTcM33FdqPofcS0RyML2QgpAJnQgkniqXUbjrBg8cdmDLb64L55hjbKi6OFmSf/M8xs8sUVsP9lTyQT4uQIBpz94z6nlwjGZFVC0DoIf/PvPCshY0Lez6NwXgX58Bzvi+8mj6+HYwkh+Q16IZHiYYoEn/b6MkzAwd8Gzn2N69ji7Mv0gMWm0zH2IGehSNwdnOunz/InE5BjlCWhJ10PDOyS2AzNDm7Lmc+ODxFj/nGO88eqFqqvJ0pOBtOhItUSUO8FSCrSgt9ON1W39B/FuxCtgAtO6T2OCh3QbjspEZ17MvTUxTTZIG+DG01Q4gpE3nA0rNM74Bql4WI4W4aIXQx+xXA/O682ddc3NZpRPbQus3/aB40eB5zGMagVJojjGjVk7Mf5rJpHw/uHm0GKkDD7MVFPuYli02xq6lrsQCTtlMhBTQSiKqNFZLioT/GzGj1JFQKjZ1etYrTMCCF8S8GtHdzMg97qXUU2oq/YWIAwoq6VOlsq/fsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026130827099003)(261026140227099003)(261026135527099003)(261028144727099003)(261022113327099003)(261021130227099003)(261021121427099003)(261021133027099003)(261021123027099003)(261021135927099003)(261022105027099003)(261022075727099003)(261022115727099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tr2X0eZhf23yGdVSvzb1Xn1T6HdZjvMArI9ltnFbBLk3pFHjZLVg4dKB0Rhd?=
 =?us-ascii?Q?1K9619P5gUlxplM/QjypiufwivaoX2Qgu0NOzCzmFaTM1GFIqPdaxo9b9yUT?=
 =?us-ascii?Q?M+Ly8npfJDF+WCojjgNjt8MdojE2o6UVRCTxWOrvxAGEMRNsHI2lVekpxBXE?=
 =?us-ascii?Q?4lOZiZR6L0L9oRfYzZrGs7+n3TtYY7qrx2Mzcnifcv8gGWfWQxeUYTyiEz8y?=
 =?us-ascii?Q?djci+Zecvgl74cn3wGaWvcoDMZ0mQ1/yvqDHuzSAx9j6fosRoAKfRbArNttq?=
 =?us-ascii?Q?0U469XhJYHvg10C4RnoEl8OOrA/3z0ef1otZ/vXDcA4G7nt/5GbIUFcRXjoG?=
 =?us-ascii?Q?oNrnQoeZy698y7klGclqO+F0G0txYa+odwCy19ISCvBGlgjQEgmAnB/h0HnM?=
 =?us-ascii?Q?KcU8VAkUWQ0uWid2JKTmVN32UAI+ZLgXDqT7si/RSBdlCMssyG2jm/2jtx0F?=
 =?us-ascii?Q?icND7pGdxYA8QB8FgVGb/Yxq2cFm2do9hSPBZzFUZCL9fnxeAvMfh5Ezo7WO?=
 =?us-ascii?Q?VqumLmvB7uIrU8xAw49feeXHxonFhMdHxCEViMelHGMihnRgoXs0pGqQXrfz?=
 =?us-ascii?Q?/iawSphWnWZiBoFDlpMmyAbmtt8WFFPQBlfykn4pLJUuzW2GDpfrQZE27BMb?=
 =?us-ascii?Q?pWKNzsTc2/qk7kY+23gqT9semy2M2Mht4513JqxTVlh2Mwn5sgEmXtqUR1b6?=
 =?us-ascii?Q?jtnn5EaAEjN5xYgmKeS+zE/fxbNCjl+0cxTUd4iWrhPiNZPe7fjmQ1C04bmf?=
 =?us-ascii?Q?n6VNlZtSl7b2OCBCt2TMEA70GtiZI1jQOaWc3B5eP8SlDAaPhS8KoOElyLNr?=
 =?us-ascii?Q?kHh+obD5siPn1tSd580N+YYvZRgKnNZiynsfr9yUorqNqZwvP26k6q+u1IhZ?=
 =?us-ascii?Q?PThqPvUq4AmKsCc6rvTmET29aMkITEUYbuFIWR8HqUGX+Iqm730YL6wxW41K?=
 =?us-ascii?Q?WiTNC89YikPgaiihBTq5KO7OceEwdeIyMMH9A0DF1BJsZpHLP0vbLUW1iTxV?=
 =?us-ascii?Q?wFrm6ev1y0KE5nE0kWcFheSg2IF4MCSC7VTKBQS4z9Knn2VBEON9DDvfUf+A?=
 =?us-ascii?Q?aXvoxC07B/KHzlHL0iEJdrg9t5nd/DOPny8PwpoLaJasM5ckhC1s0QkiWEWo?=
 =?us-ascii?Q?+r4mYoQdy/oXxpLDtLTT3m1jK7iCpVZ6NYu0+WRsfBtXNNDJVisN12a76fl3?=
 =?us-ascii?Q?bL4pwHOelrPb70ws7+Rm6HD+9qOlj8PD4Ct40PeoYvw2FhukBPOE7I2JsFPC?=
 =?us-ascii?Q?EME3HIAg6IgeX7R9mYYfyMc7bD80c20dOY9kxgz65ALJ3JRgrBRwYShJQPqt?=
 =?us-ascii?Q?kmwYAXJBg2b2FsUUEwFbO8nQUCp+7Cfzw5/o9Nd4IuZ3+3gxIc2DifH5o1mV?=
 =?us-ascii?Q?xfO00N6EqlYn+6K6K1tKTgU3T5aL2SkeQxF+TXO9qtHDzklpfhAxLWjQ7OwU?=
 =?us-ascii?Q?gCTdLvWKjJExWtgsNeQG/5BlvK4UT8foZHvZPAyhnW4pKzrZDne2SPGtbaVE?=
 =?us-ascii?Q?ALmpRHPKQyT7BEN0sJUtHStyqlHPXXsNvikJwkSLtlVGvtGawmKHEXY3/BkJ?=
 =?us-ascii?Q?npkwq4KUCEYKA/1/6B8zcXiAJXTBtbpX23Q8Vfx9a7bzZd1bQt9AAplzHzJ2?=
 =?us-ascii?Q?5lVfFcgaVEbCQZn3p0Iz0gleMU11VTynyY9SLfU34u2fS2OoMXPkY5dnsOFg?=
 =?us-ascii?Q?78/C4/KqvqSmaSGlwT1DGMeLKQVrNtt9KKPVvS/Dk6t8RNwwT+h8PKhpDP12?=
 =?us-ascii?Q?HQN0cJs1rLSCOLDiF5vy6PCWmp7HDoFjs2tTHmqoV8w1L5VCL58J?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaa69f7-4f22-4492-c7f7-08df4bd4b58d
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:26.3566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15brjkS8Bsm6ku+Dn3rDsdBMVbmtWVQxeqKGEci1uRoUzv226lEhYBp+Gx/12GljafdnNVPe790DmfVvkXMfEXhpDnTo5Pq7xS23Xh9L13w0LZ7bzudabDMw3PWmYGsk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25155
Content-Type: text/plain; charset="utf-8"

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
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 65 ++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 6f8f109b8294..dd24908bb2d8 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -95,9 +95,16 @@ struct rz_dmac_icu {
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
@@ -106,8 +113,6 @@ struct rz_dmac {
 	unsigned int n_channels;
 	struct rz_dmac_chan *channels;
=20
-	bool has_icu;
-
 	DECLARE_BITMAP(modules, 1024);
 };
=20
@@ -316,6 +321,16 @@ static void rz_dmac_set_dmars_register(struct rz_dmac =
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
@@ -333,13 +348,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_=
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
@@ -390,12 +399,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct =
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
@@ -679,13 +683,7 @@ static void rz_dmac_device_synchronize(struct dma_chan=
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
@@ -874,14 +872,13 @@ static int rz_dmac_parse_of_icu(struct device *dev, s=
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
@@ -935,6 +932,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (!dmac)
 		return -ENOMEM;
=20
+	dmac->info =3D device_get_match_data(&pdev->dev);
 	dmac->dev =3D &pdev->dev;
 	platform_set_drvdata(pdev, dmac);
=20
@@ -952,7 +950,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->base))
 		return PTR_ERR(dmac->base);
=20
-	if (!dmac->has_icu) {
+	if (!dmac->info->icu_register_dma_req) {
 		dmac->ext_base =3D devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(dmac->ext_base))
 			return PTR_ERR(dmac->ext_base);
@@ -1053,9 +1051,18 @@ static void rz_dmac_remove(struct platform_device *p=
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
2.54.0

