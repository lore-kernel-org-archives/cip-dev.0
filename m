Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF7DCA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:23 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.63])
 by mx.groups.io with SMTP id smtpd.web10.984.1755705982192710152
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=sMKwoBLl;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.63, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F77312jP/5crXs9zKhu3DNqH96L4J75nuoYbn0rKQGVO8x2Cj+QJRxTfqmJW1x81bq09QBNE6dfga5am8K57VmnHDWpAbH6sMXgBJ5ZbIob1mEddXWsia2czOzTAbjzhDUNKVq6I/G4GDZoPhgwkdz+mRCx0bC0VPk7H2xZhDJFX3LQ/S0Ty+eFD2rdWoFB2kmuMa3ohwNVA+jR5AEA5lZ77EF6/4NkbiyVM9WWwJ2UUnqxSRVn1c3zGFLo1wJBVscjHxFuAgEB98ZXB1BMeOYXXNZsVKotdyKIliUGBFxgiqLy/m3RcwNgxdZHCyUXm1pNV9ogHoy7cKZGqoKFTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhuNcSq5ZDitRxFUE/8C9vCgYa/wPrsIFOTk90d7trs=;
 b=U5S6ytjOaI4d7yykZaDmsaU5c5uhPIL619ViU6BjygHVhGiCSjMlcPMGb+kEVdVTaJEdba9cpT9Um7E3GwpEkGQok2XYnFVYM4HagoxGJ7GjwV4zIv5J1eGlQixRTrsxcX+NHbs0BCeIY0m692PkpxaAdTwfCYv9pHVXSDoQ1YEngmadIp5SckU6Ye4U1aoKXgtlljompCrWL4EzAGpaBQnJZTA+7iUFlYsVRgDbDF6kb2Tma4FDHYoOV1yb0RdAe/ajPHmEoxmYOtjZSe140NXh4YgIdLsxQbBMm3uJcyqhKjfEeipxdASbLnYyGD7bS1C24ihIcF8XFjitxulWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhuNcSq5ZDitRxFUE/8C9vCgYa/wPrsIFOTk90d7trs=;
 b=sMKwoBLlbxjUsRqvwplGS8zKjOV2cBie8NKAdFU4fVicrofmWSOO4tK+IaBlak7vGHVApAcFpMlT08QW0HnE16JQM7le19i+NYU5t2JzekgUaHF9iv7vJKR0tJR8Xnwnr4ZTQu7VCXn7LOdNt5uT1DzChr7UBru0+RBh1XzLuK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:17 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 39/55] media: rzg2l-cru: Add image_conv offset to OF data
Date: Wed, 20 Aug 2025 18:03:55 +0200
Message-ID: <20250820160413.801341-40-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c3209a-303d-427e-e3dc-08dde0037eeb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X0GB0u4jn7Zr1K/m4MnfnZkiCYaAh14xWbI5PirQIZLrfeGoKND9e3gbvC/x?=
 =?us-ascii?Q?u6po2vdHpdTAAaU2dHS2NBDdxoM6TO1cmCfv3r57FKuK0niYc9JZcEnlSvPT?=
 =?us-ascii?Q?4IDkBgN5pvCke7HAzZqE8ZzL7xx+Epahc3qAD4Nqx0OwEFSmTSC/izT//u0r?=
 =?us-ascii?Q?Q330OJ/43oYlvC8pPLahmRpTmmK9ERBtO1A+acBA0i5AsASt7pey22KxOwV6?=
 =?us-ascii?Q?VfBNzpRgDO1Y4uaf7l16wGDjpEj33VBplRJf9TfplPlR7ZOdvj5zCOH9VWPh?=
 =?us-ascii?Q?CW16muELxIJOGOcsckTtVg9SB+MZJppB0TSTX530axX8AB2Ryz/NQNeZu7hs?=
 =?us-ascii?Q?COY4Pc2m7TxvIkOLWsM9tcqY8En28IAsNyzOC6JbI9eAIwLJd/H6pO1pX2FE?=
 =?us-ascii?Q?nUsF+DFhIkUZ9cgeXF+nM16HaMQbjrsdSo15uh+7paT9tiQ64un5Ey6951hM?=
 =?us-ascii?Q?UBjPjviPveafhNpDHAzC246xI48Bx16qpYiUZx63Lqad0+fyzB+DvY3+k2nU?=
 =?us-ascii?Q?fgZltEW6rURSbBT2IcrPflSzmh9hs66yW/RtKujgmwLo3753oqEAuR089ovs?=
 =?us-ascii?Q?hVdDwYyn2Gkfppp+/B+eGZHjYQtbzu5Q2etRA5ur91ZlzKO3nkwpQzQtxdLa?=
 =?us-ascii?Q?duTyGay4dZUr5HBpbmjuk3/ZQq6xL7bL0atGfs8Rm1KMvJD+gOz/8J0gc99m?=
 =?us-ascii?Q?YoNT1US85EERr1XCInPfjh69RQRLJ+fj9Q0zTchnl7QX60CF/VuhlgTUtTa6?=
 =?us-ascii?Q?OFFs06fCNEN/4mIyGRUQhJpKFPRr8tUPymNv59mH4sQnA64dPikGthu+rl5T?=
 =?us-ascii?Q?+tJKmLvDoxJQd3wCYjd+C6Ulf1XeJ77tpcxTEQBusxx19/K0fqB4Ic9HW0n6?=
 =?us-ascii?Q?LJWvg2LWfi6hf+bc4hsIS/G+Dn0E2AMYjTry8EmyV2zzglUGj0P5TsIDzotr?=
 =?us-ascii?Q?cjfsW3hAYQFPKkE0HW9s7RPIq2T6tfAOPNi2IVVGkb62m319ZYJzrC+8Sf/v?=
 =?us-ascii?Q?lBH6OZrLQvW0jNCPPKBHUV5xqPEAwY18WWEcIDw+IGccUOiO2Fdji5J3tZJ4?=
 =?us-ascii?Q?mbVSWGpLRsBEUidcSItiVICSXwgq2BskWrHy1OjzIT+EgpWTKdu8jtkoN2vQ?=
 =?us-ascii?Q?66xmq05BiUav/BuAgo4xN6rgxfErodGeGLMshgOuImQZ1r2k5mO5UzzIK0ZC?=
 =?us-ascii?Q?YaQUX+9kQpaiX/s6/0VaoXv4gdgqadCvetjmuDT8mHQgdKn0a3hRGocp+aFs?=
 =?us-ascii?Q?uSLva3DrVegolHqpLJGvCWZXmhyBW9hgmqzsAe2ktn7LuS6+p9/fbKKL5MkV?=
 =?us-ascii?Q?OfsOyPkKFHv4RECObfHA7V7rz1Ly/WrcF8SiA/I29CTzUHDrAPSAMTx5HW+d?=
 =?us-ascii?Q?oLt9HVcsSJRXhxjfRnXDEaQdzUVhDrJPbPUnyBTQbH5J2e9kqPuf5yhHJCPb?=
 =?us-ascii?Q?TtQqVStF3An/OBxNsYSQZbOMcKhTO8V/f3vbUmb01hFipyRlVNRL2WinUI0r?=
 =?us-ascii?Q?74bDfOUAInbVFgA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?c/P2aZ/V2uKGH06rUAXbGOmoUihqhECuNgfyurK7/pPQOXYj0DdeQdrhD55Q?=
 =?us-ascii?Q?nBwWElBTpzgi9/hYZ7jN4RBjvEKtF+hQiNimgvXuP8T3hCrP6uRc5ozHAkMK?=
 =?us-ascii?Q?m0L9WmpY6MNz8gCum/tt4CAtoCxakNmwtw9n4vnLlFM7wssvOX1gk/eNdRc5?=
 =?us-ascii?Q?JuOjEumk6FTO3QSL7oH8oVAIeno/MXgwrP15JiHeqGTAbGtoKygMmuLOHGuG?=
 =?us-ascii?Q?7py1WyXSp/9PLDzXcuTYdtj130lkEFYpRG97nMrWJmJevjBR8F+pQCyxnJvj?=
 =?us-ascii?Q?LTH4rLC9cxQpB1sZ8IYQALNMXnfuqVTLKnreosaBC0r6BSmPi5/w4qkVYsf4?=
 =?us-ascii?Q?nzS2roFVnfHZknDwFD9tPgpT/sxFEJRqfBcMXo1Eh9o06ZgwRfEAhnaCeRTK?=
 =?us-ascii?Q?K6mOPTrZryyiacmbe87LdAcGMquAVxHZcW3Cd7ZyMf4whXhCqExzEGRChPWZ?=
 =?us-ascii?Q?nbqhzC95RQy78Txt7bWrzsqyeim05HsQznsgcUhSZ6h7s0EQvCfgaSTkFSQf?=
 =?us-ascii?Q?GQrCOowppWwJ8mAOszVyUgGEx1xmUj4YKKSqxQYkxUHkLDVRliGzA+gOG57F?=
 =?us-ascii?Q?hLKIk2b7lAiXP0hZqQIAwIBNoexE3dtzxtHi3+aXdHZN8uwKo71BRMJDgE/v?=
 =?us-ascii?Q?btWU16pCj0J0eGICdkOZ2IHoZMMr5YsjAIpjBBBzuZNQHsWZLXT+3FZEI8u/?=
 =?us-ascii?Q?3AJEkSW0tvpeEltyXbEqnFaeXZ2TWGSXg/fBjYfFZjoLHceUtGdPlrqhU4jP?=
 =?us-ascii?Q?Irv5qD10VBW0S4hWTJZHTuAkAqCgJnpzg8xL61oO0OCqbDy+iY4eVZ5ef78D?=
 =?us-ascii?Q?4oQkaKDRPCKwMm+3ayB3Xbp9Jn5nwfkCfRDvciuCpk/+XgyM0pzvCSQDODw7?=
 =?us-ascii?Q?s9pYHwov+EF36ZpXYhX8VqBDsOpUAw4gJkzv/bVGAqcPHBpdoWsg+LzOakZd?=
 =?us-ascii?Q?AeOjsOB9uBj7p65gD6veTRRdRRWpqZ+FmDM8MMvaktZWUmeRaz0HBf5Di5Z3?=
 =?us-ascii?Q?drssHrBmINTWhDd81PNFAQOnvylu6/N8Gk0HNvbBOXaAF+1eSanTwJqDNenY?=
 =?us-ascii?Q?nRgvtJQNbQIkKS2GM3Jj3Z26H7F2RxdSbmV8vB/I8lZjDihbauKPZSOO+9WI?=
 =?us-ascii?Q?CB/49inM95qppK7CzsgIl4AzwToIUSLRrhbV+g+aK3gB2f31cIg2SBloJsAI?=
 =?us-ascii?Q?g/BJGMxl+HYkaBwFF3882/ucHzA49Vaq+vorBgqylQqq/XUJvpGzrz4t2b1R?=
 =?us-ascii?Q?QtRpplo/yiSUy+c2dG78KSQRiOXySseeAuhwcA8Z+rZMXf/eGifaSmDqafr8?=
 =?us-ascii?Q?fZOU+5SV06vK7zJUXIlTdNC56u6AhC6b2KnENMt5xGYThDvuIMuu34vd4Lnp?=
 =?us-ascii?Q?DpzFF2lzJd9PYUP6huOiP4b89baQn5jfgf8n05DSjTaCogSizUtjdOPQ7qvZ?=
 =?us-ascii?Q?pyA7g4Va1jozYhRDOw0o73OFpTfXaMSNL/m+CnQ9FNmYUlvOnNtHxuWJqE3a?=
 =?us-ascii?Q?SyfUBmEvcNYUGS5G4SwMa42y7354FZm/92cYVJvxbuCvGryDhd69t1dpy6FB?=
 =?us-ascii?Q?sVCovSikvrQnxQVCWXOoK76DxlanjF99GS28A7m9FJ1DDty6SseaPf8M8t4R?=
 =?us-ascii?Q?hXiUsLbLgk8oCyPcuZF/tgE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c3209a-303d-427e-e3dc-08dde0037eeb
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:17.8262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stZONqIuxEwSIes5Qqc1Rguq5S2sAeOuL7ZdRGmaeS/2njPqDMyA6/kLdJnd/LRzKnx90wMq4OLdUumGfayxLicW4/Cff8c6sAV4K26K/JTp9DBsAgMuEsWRreu+DT7N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19864

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 48ce5920da1d65f22b4808564f6f5c9c4ff9d976 upstream.

Add `image_conv` field to the `rzg2l_cru_info` structure to store the
register offset for image conversion control. RZ/G2L uses `ICnMC`, while
RZ/G3E and RZ/V2H(P) use `ICnIPMC_C0`.

Update `rzg2l_cru_initialize_image_conv()` and `rzg2l_cru_csi2_setup()`
to use this `image_conv` offset from the OF data, facilitating future
support for RZ/G3E and RZ/V2H(P) SoCs.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-14-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-core.c  |  1 +
 .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h   |  1 +
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c | 14 ++++++++------
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index f7c9eb040bd8..b9ab8c067b71 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -357,6 +357,7 @@ static const u16 rzg2l_cru_regs[] =3D {
 static const struct rzg2l_cru_info rzgl2_cru_info =3D {
 	.max_width =3D 2800,
 	.max_height =3D 4095,
+	.image_conv =3D ICnMC,
 	.regs =3D rzg2l_cru_regs,
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 764d109b253c..07d1ed76bafd 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -81,6 +81,7 @@ struct rzg2l_cru_ip_format {
 struct rzg2l_cru_info {
 	unsigned int max_width;
 	unsigned int max_height;
+	u16 image_conv;
 	const u16 *regs;
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 5c5b7ca71c19..3ad0e20425cb 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -246,20 +246,22 @@ static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev=
 *cru,
 				 const struct rzg2l_cru_ip_format *ip_fmt,
 				 u8 csi_vc)
 {
+	const struct rzg2l_cru_info *info =3D cru->info;
 	u32 icnmc =3D ICnMC_INF(ip_fmt->datatype);
=20
-	icnmc |=3D (rzg2l_cru_read(cru, ICnMC) & ~ICnMC_INF_MASK);
+	icnmc |=3D rzg2l_cru_read(cru, info->image_conv) & ~ICnMC_INF_MASK;
=20
 	/* Set virtual channel CSI2 */
 	icnmc |=3D ICnMC_VCSEL(csi_vc);
=20
-	rzg2l_cru_write(cru, ICnMC, icnmc);
+	rzg2l_cru_write(cru, info->image_conv, icnmc);
 }
=20
 static int rzg2l_cru_initialize_image_conv(struct rzg2l_cru_dev *cru,
 					   struct v4l2_mbus_framefmt *ip_sd_fmt,
 					   u8 csi_vc)
 {
+	const struct rzg2l_cru_info *info =3D cru->info;
 	const struct rzg2l_cru_ip_format *cru_video_fmt;
 	const struct rzg2l_cru_ip_format *cru_ip_fmt;
=20
@@ -276,11 +278,11 @@ static int rzg2l_cru_initialize_image_conv(struct rzg=
2l_cru_dev *cru,
=20
 	/* If input and output use same colorspace, do bypass mode */
 	if (cru_ip_fmt->yuv =3D=3D cru_video_fmt->yuv)
-		rzg2l_cru_write(cru, ICnMC,
-				rzg2l_cru_read(cru, ICnMC) | ICnMC_CSCTHR);
+		rzg2l_cru_write(cru, info->image_conv,
+				rzg2l_cru_read(cru, info->image_conv) | ICnMC_CSCTHR);
 	else
-		rzg2l_cru_write(cru, ICnMC,
-				rzg2l_cru_read(cru, ICnMC) & (~ICnMC_CSCTHR));
+		rzg2l_cru_write(cru, info->image_conv,
+				rzg2l_cru_read(cru, info->image_conv) & ~ICnMC_CSCTHR);
=20
 	/* Set output data format */
 	rzg2l_cru_write(cru, ICnDMR, cru_video_fmt->icndmr);
--=20
2.43.0


