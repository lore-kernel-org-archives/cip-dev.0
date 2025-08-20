Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F79CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:03 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.26])
 by mx.groups.io with SMTP id smtpd.web11.917.1755705962917211820
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Cadk6hE+;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQf5mzVSIm0Trwsest0jOnza4EbVraSVmhzR21gQDBWD/gulGvMbCIsAP7zuACwymj6yaRIVyhatp4cfyezzdEKG0uMJ6Iee1zVuRgb6TAU2mNlnNAoKx/Gx1zHs9zB9VemaKHKFcgyWzBPujLEWxkc8o4sjb5LN+K3ztydi71ANDKkJfTR8S57eUJOsKVtTedZ1uxFBLMf8cx5hit6HpxUAe0lWw4ElsWBG1vebvC5XJt799ZgPoYVi2vIpI1wBtpeAzKufSQPDnhq55wQemCSn2fpCQqlnb9BAzOOL8gSBF6gjWvV3gPa17PU014slls8vNjt1inagQiy/gBJeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KheowT+3n5XL1GvxzmOOzZYhs1y8KxCF4cW4AgF80Jw=;
 b=CCck4f1nCEXOxGjWFTUYefcnE/cH866WZsxpGwTSKAFHjTnjBK5eaIjOEzBz1NwLFFyb+fU9l7qfPoe2A5Za/7nah8R6gNAJNCWzn29gOVFwqcAR6ClRFX3W0avAW/RnsieLbJpLbCnIIsCScxYl2XC+PT6PbgeiwSdPBLiAOJ29aIrOx2Bgc3cEygRpDpKYMog46biEayBhPcAy4uieFqa9ZUPA3u95Sn8IKeI93JPMWhdZYc5IZkDLiMz44fe25my8N/5pfnmTaIKLK9zGbQv9HEpOzaISzlHgTvlek4B+WB/wtWeJ8XbnAqdYGF7BGRrdj4hZNM9YoGd+5Iladg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KheowT+3n5XL1GvxzmOOzZYhs1y8KxCF4cW4AgF80Jw=;
 b=Cadk6hE+SQGBIkpBUpMK+IEMU1SVG181Qa8alOEnNqGEnzKydsXeuMy8vrWc+BklMWD9K/4jhrDFMOFYyZ/Ytbi+SODH1/ZDcXs0TmRsLLaTM/PaJjyFG8ya5+X76EL/Ob6P9WMX3vGRLLoPxYOf9+yM10yYOPFAa2B8Dbs/Npc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:06:00 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 32/55] media: rzg2l-cru: rzg2l-core: Use local variable for struct device in rzg2l_cru_probe()
Date: Wed, 20 Aug 2025 18:03:48 +0200
Message-ID: <20250820160413.801341-33-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: 5288b710-4b05-4018-715c-08dde00374d5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QuAGAcjdxrePrc9ImDMWTjGypTTMvNZs4bK36zVUIaizjFgZmr7ArqrtS/ly?=
 =?us-ascii?Q?+8Kkz/WO3fghd6cZ/b/7jhsQ92ew+/jYL7xOO2IO3nMiTtTuHEk4Aw00yk2M?=
 =?us-ascii?Q?hrRE7LC0JV1WkiRVRShBjHOUuDOytSsqsgxIcokLBg8D1an+XgCVwa7hnr63?=
 =?us-ascii?Q?xWH63dbAdnw9fEBExAvXODx5bAi+SUOdU38nUHSbrXYy5WvtcPLy/CvGVkh8?=
 =?us-ascii?Q?Ka71H7nYuvpejwFMWHbTXP6lo5NTVRMl+q2wjTB/Xdy61Q+J8LICxxL88BrQ?=
 =?us-ascii?Q?SHxUqZPcuKRlspbt2rxezG3kO8LDTLkJ75pWqxSHfC25Cb0BYi5m2GoV9cTp?=
 =?us-ascii?Q?3x4D2AtTfrJjLNC+yz/lAv16JCRiUnLPOjHyMCIiR0PV4Yz0ONadIT8Ut4MI?=
 =?us-ascii?Q?up7x7W4whO6z1vqFOflhJ4YVcYczB8D4w7izWwtzQVyuwAH4SC/0Z1zHWxPJ?=
 =?us-ascii?Q?1TDgeUncszWUINqV4jbJyP422E6Q/hLiORJ4f47Tdz4oWklfYUKUzvGpmz6J?=
 =?us-ascii?Q?R1RnHzgsaRT8VeNNjZbhpd+j0Fn4pk5L03fKNMv4DBK8M0LFLi7fh8t02pPp?=
 =?us-ascii?Q?YFR82N++OjTyBnCwL/rq/6D6QEIhlYi8S/j2hNL3cepUVp32vQbTMglMYgb0?=
 =?us-ascii?Q?MOe/NpKkRk9qtKtUgeMJi3qFCtSpQUY/wwxZQRL4gTos9m4RfPAN7VD/9NyT?=
 =?us-ascii?Q?Ln6qiij5e7SwiA23WA1sAeF2l2fC1zIn+Q722SS1LI7SHY8EvRaIGBG4sm4Q?=
 =?us-ascii?Q?VNW4pr3tSZQY2oMtTQPRYy+atXMtrSkEEX04xP5k2aejTNygnl0m2ONbbLvD?=
 =?us-ascii?Q?ceL8nS4YdB2J4JtbYTfsb1oUk86PRH5Ybc3yjQJPi8Bj5MleGVS4aeG1tjXw?=
 =?us-ascii?Q?4C6TMcY7Mx3iFSuEF0UP4mouFrEg+8OZ9te2JeFIp1KsesnQU+aw54Alg9Vf?=
 =?us-ascii?Q?MAoJeJJFTg3040jVZtp0qt0yPCHrjWIWm29R5Tt7XFPquYnd5zuWzC4KYeym?=
 =?us-ascii?Q?PDL/yQ4W5tj52gXo+lQqVnqZN5fhWg3XDh7q4cvGlfl7qL293Z92knb/Raz9?=
 =?us-ascii?Q?oVvHbvJJaAedcnYVeTgGYZYGtfV143TbiO7O/Hf1SORrMsd2NVhtIAF+ZmLf?=
 =?us-ascii?Q?6WxAQFucL27mAlMpqzSscmeVFUv5UfHCf4fUMI22edYKrtQLZjf31et9ezYO?=
 =?us-ascii?Q?QNh4VDJVkGkZlC0b21lGTmFf1r1joJxlnX2XnT66hDEyl0SlFKPhYFOn3gdl?=
 =?us-ascii?Q?erCWg1tDaLmvh9ezwZi9hqToCWTUdcvHRBwJCjppGWkQ8pbqLts2gHiMKg+o?=
 =?us-ascii?Q?Y3cVf5pZxr2SpUTpw0406BibFix5rHzTdtG5fnK8NqykhJBKBV52hvIFnr15?=
 =?us-ascii?Q?/VUdi2NY9+R+zvYx9Fto48YYFkDx5Hp+zHKq01aeUW/z0H1VxEhYtaFGVN6l?=
 =?us-ascii?Q?S/vF80d9aD12pT1jqyeKXSKJOF5/a1rCRaR6uodtjdSVDsi40O2eMyS8MqT4?=
 =?us-ascii?Q?IwNbjbbABybs7Gs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lTmK0lNtgH6rGXKXFkErUAFf6HVi/lcEjZy/5Ck316mRrk1RXziN73xqnYhF?=
 =?us-ascii?Q?CLsNV7/2675UmXlH7vE933VT3E457kE3ldaUljeY5WpbBEBPpMnErTlJnC52?=
 =?us-ascii?Q?FR7GuRm/dBIlfaGh1UNgpTkaCMcXK9y4+tTTpMe6M6Cg3ZmdbJyHHeHZhmYZ?=
 =?us-ascii?Q?0V9pgY40GfMYva+y9I9zKvyAjJrTafsbsZuXi9TJH2L73y503k1z+ldZbWT0?=
 =?us-ascii?Q?zgxw0TgdNz+uO+6jVDnEZKzk3yXS5pL4MCATDqXxL+wTByWSJiopwg11NZBq?=
 =?us-ascii?Q?CJ6hOqYt+Vxz6ltuEo9DwZkgIpruQOt3DBnqZ4oWDEEwfX4uMr5vP0Ti5+Mw?=
 =?us-ascii?Q?+XtHlKz8KCMUwa419lo2khyLhCJT/eNWfQqqWYR5R4G+vybVyaQNVgnK49RS?=
 =?us-ascii?Q?+26zckXsybn+rK/G9TG27zVxRiXPPcCsgoVHWWTGJ0cnKBoL78g0oUDVu9by?=
 =?us-ascii?Q?nPCTbxRe8D3WJc0MVCltEZ/PvWo/ySO6LORMFssuw/Xa3Yn+Ay3zORqEmvOQ?=
 =?us-ascii?Q?TEgM+xh8iB+2zCwIcMI2tENyRtjB9pZYSDUxJ24AyZZQwums4mDMV1bmvb5W?=
 =?us-ascii?Q?Cr8n/o7mU1OFlNmVwjVN04UVDLXluTwA2v7tgAVu6sGI7QsoCkYtZ2tIxwpV?=
 =?us-ascii?Q?8p+EZh7h8LeeIz9AfZR6Vcw2CPDkexooXCQrCje1HeyE7ju1GzHR+1lSAziB?=
 =?us-ascii?Q?CHXUVyJtB//zp6J1vZuJpEKzbXm4TZ3GGHS54NqNPMfmxCihUgz74U802MF7?=
 =?us-ascii?Q?ZrNmE/AAwBAh/lDxu+GzlQpes+9o215gipukuW6ItPzjJi4ooYTk+eab6lVb?=
 =?us-ascii?Q?9UmaU8jC0Meicv3KokHIgWd2+dwxpUeXst5ZpvzbYGqCclf+EZZGZMQ8eyCw?=
 =?us-ascii?Q?ykScGwGt3dRAhlitb3DreQBSzxtmUUK/DZboQ8lTh6lJ2ulJJFplgd36sYeY?=
 =?us-ascii?Q?hExTcpw7/M/Lzp+iGEHVOCq+m1PcL3TLP8QMYoBgNN3uw1cDXTcdmup0JEiT?=
 =?us-ascii?Q?/tywSbajpGGzFw3YPWfgIbYHR8jEAtBedsVaKoltFAYLXTLKWJoTOJrVGxxb?=
 =?us-ascii?Q?rq6mLAv/vOK5NxtChvuPlqye+nOXbWVXPWnGHN3D6KDMo+KWXqc4trazrPWi?=
 =?us-ascii?Q?6sCXkLN1a+pVBlo7JxKrmqcLYqjgUzmeP2KBBhzlhI5WAJpA3Jo/3gOxh9CZ?=
 =?us-ascii?Q?76FsDNduRVQi4Fap+u9tSfPvxqj2BPNN0JZw+KxOag877rTz4t+SlJ1F2uN+?=
 =?us-ascii?Q?KEXShk6c/GyC5Uf4DQ7Cep/Uo/Ggv1Im4c6luqlOZjx9KAKqgjJa1Zr8430+?=
 =?us-ascii?Q?QGoEg1tYGUq9QT7/pBUfyXXTCTurgRfnN2F/NLZ18C+Di6WpxoUhEkhICUKE?=
 =?us-ascii?Q?zYFtpieJ+xVf0aREozXR0JQfphpf0SLVRXJ85t5Jw1kfxwOjKb8Zh1mOSe1G?=
 =?us-ascii?Q?5TQEwL84BHzs8avE2DBPVE0DQ6hl35QlhBoIvRSwC8Hz03SybZkrxmV3tZdF?=
 =?us-ascii?Q?ovJ5ykJDPUWhv5gM5UH6hOxmysULwgeBfruBuZpt6T9I1mokffof6E2K129S?=
 =?us-ascii?Q?Ly9ajAb+Jgl7emBlInj4KpWWKjVgZaH6Rkf5ik66h6GK3rZ6i2v0OL9PVfV1?=
 =?us-ascii?Q?dZJuJyct8386uxbdBauZakE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5288b710-4b05-4018-715c-08dde00374d5
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:00.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37pbcJ/UMo0rfT3Dvxo5Wk+4mVi0CaMi4iInb/1xZ8XgFoc4seP0Bej2wt/pBw0z90oaeKe7fSaQDPfBZsUZx+IUYSnx4MrFwnxspxjVjdEEyuwdJ54ZwMmQPEldW7wq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19857

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit aed5bbaec5346147b8580878a32809fdb1bf46c8 upstream.

Use a local variable for the struct device pointers. This increases code
readability with shortened lines.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-7-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 17e651376b2f..a5fa2daf534a 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -241,10 +241,11 @@ static int rzg2l_cru_media_init(struct rzg2l_cru_dev =
*cru)
=20
 static int rzg2l_cru_probe(struct platform_device *pdev)
 {
+	struct device *dev =3D &pdev->dev;
 	struct rzg2l_cru_dev *cru;
 	int irq, ret;
=20
-	cru =3D devm_kzalloc(&pdev->dev, sizeof(*cru), GFP_KERNEL);
+	cru =3D devm_kzalloc(dev, sizeof(*cru), GFP_KERNEL);
 	if (!cru)
 		return -ENOMEM;
=20
@@ -252,32 +253,32 @@ static int rzg2l_cru_probe(struct platform_device *pd=
ev)
 	if (IS_ERR(cru->base))
 		return PTR_ERR(cru->base);
=20
-	cru->presetn =3D devm_reset_control_get_shared(&pdev->dev, "presetn");
+	cru->presetn =3D devm_reset_control_get_shared(dev, "presetn");
 	if (IS_ERR(cru->presetn))
-		return dev_err_probe(&pdev->dev, PTR_ERR(cru->presetn),
+		return dev_err_probe(dev, PTR_ERR(cru->presetn),
 				     "Failed to get cpg presetn\n");
=20
-	cru->aresetn =3D devm_reset_control_get_exclusive(&pdev->dev, "aresetn");
+	cru->aresetn =3D devm_reset_control_get_exclusive(dev, "aresetn");
 	if (IS_ERR(cru->aresetn))
-		return dev_err_probe(&pdev->dev, PTR_ERR(cru->aresetn),
+		return dev_err_probe(dev, PTR_ERR(cru->aresetn),
 				     "Failed to get cpg aresetn\n");
=20
-	cru->vclk =3D devm_clk_get(&pdev->dev, "video");
+	cru->vclk =3D devm_clk_get(dev, "video");
 	if (IS_ERR(cru->vclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(cru->vclk),
+		return dev_err_probe(dev, PTR_ERR(cru->vclk),
 				     "Failed to get video clock\n");
=20
-	cru->dev =3D &pdev->dev;
-	cru->info =3D of_device_get_match_data(&pdev->dev);
+	cru->dev =3D dev;
+	cru->info =3D of_device_get_match_data(dev);
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
=20
-	ret =3D devm_request_irq(&pdev->dev, irq, rzg2l_cru_irq, 0,
+	ret =3D devm_request_irq(dev, irq, rzg2l_cru_irq, 0,
 			       KBUILD_MODNAME, cru);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "failed to request irq\n");
+		return dev_err_probe(dev, ret, "failed to request irq\n");
=20
 	platform_set_drvdata(pdev, cru);
=20
@@ -286,8 +287,8 @@ static int rzg2l_cru_probe(struct platform_device *pdev=
)
 		return ret;
=20
 	cru->num_buf =3D RZG2L_CRU_HW_BUFFER_DEFAULT;
-	pm_suspend_ignore_children(&pdev->dev, true);
-	pm_runtime_enable(&pdev->dev);
+	pm_suspend_ignore_children(dev, true);
+	pm_runtime_enable(dev);
=20
 	ret =3D rzg2l_cru_media_init(cru);
 	if (ret)
@@ -297,7 +298,7 @@ static int rzg2l_cru_probe(struct platform_device *pdev=
)
=20
 error_dma_unregister:
 	rzg2l_cru_dma_unregister(cru);
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
=20
 	return ret;
 }
--=20
2.43.0


