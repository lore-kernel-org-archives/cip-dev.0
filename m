Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461C1CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:10:04 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.31])
 by mx.groups.io with SMTP id smtpd.web10.1121.1755706200496559144
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:10:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cHbJpBcO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVWYzmAt/pbeuRxM1iaUDgTMcsBMasbfXIywTWEYLfsSn4kjwxWYtAFhvjruJ2c9RRwRVxThkHqX451fdyUXk/Cp56bfepj9BMl5wFmd2mU9uE0Iyii95g3WLaBaHUrKfs59S8JzP7jv3N01Bl0+0gsSxD3OzFIyoyocWQRxQFanvxHoflLo5/EvYDrAQq+noB+NNuHV/JCBy4sfDABohYB5sJdnBUguJ5ChtY3wkSfC9yFRNgtqUMrFCsSVMbtj3sLTL18/cxF/6iaoRUmvLR0H2fXzHkj/BVd0pC6MO4X/nG7vUmU70EjH3vdzyFk4uj+CxBy6JuHNIlTsY96unQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lupJmpvaBlD4VQiwTOEUKS/IXH4V5m5aJvvtWmvpXM=;
 b=OuaTwvDUjcH0Eay7nKaGFI4QYSOiI6evKeetS0RZk8B6pqdrLeBeoC7UUNRMBcmu0oANivqOWIx8UW/suKaGDG3yBHwh6prqpQ1aE+jR03dbSYRyw8VVdWyoeG+ZR1++z3rSFXxQZx5gRBVwnLTYRzsYM9LnauTjRkKC2dbSbawoaTFVUEhIK4rg1sJq//jKEJAhEeMI8rlrGMqgk96vwAELLWhh9QmigKRd8ttCSEQjg2VQjfKz8Fi+ZxgwaJhmCN256wBP5gCuVkd1A7b5l99FecgiJC6ql+8oZge3xbPsu6aN/8sv6iDCPs3NQgSpCg9AScbBS+Pu+EITcNuJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lupJmpvaBlD4VQiwTOEUKS/IXH4V5m5aJvvtWmvpXM=;
 b=cHbJpBcOKzrcjcmBXgUEP+CcxQIWka5n5Tss+e2MXhsWgym2Gwc/fAfV3GJM3JviRMGeIuBpYyDVmvfW6+xV3pFvuAWEe2V08RgmhDT3KVD3mp5aJ5+GLDrH/Ahr6WJAXR+NnsZnCH2Vdim1MzkvL88DBAJ+QxGjcD/y8kB2Ysw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:58 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 38/55] media: rzg2l-cru: Pass resolution limits via OF data
Date: Wed, 20 Aug 2025 18:07:39 +0200
Message-ID: <20250820160758.801813-39-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ac9ee8-4e24-4041-8954-08dde0040293
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cFTV6vNUYg47SXHNAKuJfcQK2PHDUTC9jocManHlzmh5tIu+n8Y4WF6/om/t?=
 =?us-ascii?Q?+BofqSWCdQu9f7xKTNqo9yFGNFETRGIjtOe+rjp3OYD0eeZQHNbsdlpG62WK?=
 =?us-ascii?Q?vjPmyerMznNa1ttxDCnup9nWxPBZMvpMX9KzophP/3rbxDW3W7wa9SydhajT?=
 =?us-ascii?Q?qK+6Pj9x2ab34kJiZyT22sy4bN+Qv5rI5/5VETbD3nUjNYBgSKSTfBxBepuw?=
 =?us-ascii?Q?cq7ZE7iWXB+7aRD63sp4eCh8HkH2aE1mLnaI1F1nnkx1lN1+5neYEZvE0JTl?=
 =?us-ascii?Q?c92WGV6sJjUJ8c/vsVjhSiTQao6vx73BrTAaWuvXbuCyBOL3b1k8j6Q9ZPdD?=
 =?us-ascii?Q?LFoTthFbo5DQDKxTDZhx1SlgOk3GUJcIXE/CyRIPZNTczEKuE1OqodwWMdR5?=
 =?us-ascii?Q?BAUMBU+XZy9SAl+TmIYpwt7pD/nuTmZDTureLpE8cUImGeCtlZ7fMLua+CGl?=
 =?us-ascii?Q?eE48kjcksahLdIUryu7MwTjE8Vlq2MV0ecli+OYbHvu+CbrcM5VI/VpI95jf?=
 =?us-ascii?Q?rymq5j7UhnS4gZrEdr7wHDjjQHK2ZNsh/Glo61+MkLpFoQ1fPVnGsVsFdVZs?=
 =?us-ascii?Q?DmYkh3KDsAzcp+LtHmPuNUklMUYrh9kO4XUI+OwcdiEyGFtM1Zv01/M9692v?=
 =?us-ascii?Q?R+w5sipoQGfttr8CEcuFecgrIzN8ffu7eyq5lSSW1iBDbIVXgIkw+NXjyJOW?=
 =?us-ascii?Q?pMpH76t3SZQsTz2nXVJJK1+98nn4vPt2CgnS+dFngFhf2s4srHqDMS/cGRKc?=
 =?us-ascii?Q?pzuvrWas+GQ3nylY3tYLQriCdfxC98YW6DWBe3uh4wWYXkpd/02UPrJbVwyF?=
 =?us-ascii?Q?ITlhj1cjT47s7iCkI8z2g/sUWqS64b3qX3VSDaDcyb9gp3H2YuOP/VjtHc9c?=
 =?us-ascii?Q?MWBHxWU5wenja/DbOczjEMYKlOJ7dS6dl001Rra/0/yMwWceLrkxWgzLJePP?=
 =?us-ascii?Q?S8HLECRQZSCb+Q22VAAxCYrL7j9/gTDgDrqlUn2Of+gMLDn7aTaM6fdP8K5k?=
 =?us-ascii?Q?vTqvieyACbj5RKaTIpMF7MxaREIC5a6NwaroiaD6/xCISCN0bRDSFa2ejbwk?=
 =?us-ascii?Q?o894LLLNc3QDxZvZTlQXBaB79MzWVRiaeubyOBHwqkrBrtiVDnEwfdMSevcY?=
 =?us-ascii?Q?YbmmDQOgwK+YeJIlter1JS3NOk+JmdPwdfaBjNak+4E4TLA9y65AnJPv1RK5?=
 =?us-ascii?Q?JvLo/OgW1e8n1keQlWq2ZszOyy7dKK9fUWvU7iDPV5RaxpoeXwv+iHTu8ys4?=
 =?us-ascii?Q?ksLwONmOwSh6TwTyVK3l7nR2c8b3xvo9BRg0DShzrXG9FjCBfxBnzTVm5mfT?=
 =?us-ascii?Q?7Lc8/HYWGjAhbSIEi2SdfMRXNnPxAkBNakJfDlH6Q7hxnFeF9ToW9Wcfi4g/?=
 =?us-ascii?Q?DLOQJlDujB7rs9Flr0pqUM0hiXS6l9Sg4DRuuPHR/+th8STaPKbgUMLI0XvG?=
 =?us-ascii?Q?gPVKxVqnNT8BXxGCnv9Rf5En8I4wGTEVawBjlMwtjYbAKRGYtW3FHx5nq4fs?=
 =?us-ascii?Q?ClDtR0q9IVx+Cic=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+1712w5YVXjAKEy30VvYB+LQKt+vSThXE1lSQVtjDXbCnGDkczOD8h0pD29S?=
 =?us-ascii?Q?0rIUZ7jB4+dmJ5Ap7dLc676ElM6AzbgXIlZd0gb5TRfUsJ9OKwnscUfHpqSd?=
 =?us-ascii?Q?NIzOt5olosjuZ/V8PWeZMjPtY+VxbVmxdh+Ybm3M41GLDZXnKabqToMk2yYy?=
 =?us-ascii?Q?n93PDVVmC7AKQ/o0gKxyblK632xvzdswf1ET0v0ir+WuktxvOC7a99BlVdgW?=
 =?us-ascii?Q?X+4HSa5FlAWhs5CTyvaxzPse7yZwoT10mAk7+wFnSkp8KvirrmHrz9lxnvdd?=
 =?us-ascii?Q?hnekY9FIWLc7rx3PS+OSbV8qL+1sLCUhw5udYeFbJN/lDBu/EufRbPQHyvZ0?=
 =?us-ascii?Q?10cH6+PHWNyuOLa2zH9U/O4tThZg1kVHZJLBn7klmLxc6RuRNq1pk3iIRaOp?=
 =?us-ascii?Q?/qQ87upu4pxgwtPwsYTvOBVrf2/1I9UyZVvPJ2rTrFtmfFtlySuiCBmHEcXR?=
 =?us-ascii?Q?Ei3gBOFKfi+bArP1M/+fywRjRJdDwOv/dH619f9w9LlHinuD4NQIMwYNSdEE?=
 =?us-ascii?Q?E9n64NOQxLdXEuddM8krcImYtoKUntCIYECYG+4iOX/MVHZQmrn5ebXtLtkm?=
 =?us-ascii?Q?1IT9OnFKfr12ZcKfG6Fdg3LJVFgwPHfrgHshEfzW3j/yddPmEnlKAgRb7dqB?=
 =?us-ascii?Q?P9vj6cSOdY0WwOz+JVgjG82zEXRaxfnfY0B5CB83K6LvMiZMSrh4jLaO9sfY?=
 =?us-ascii?Q?25ikQ/lxm9IAi63eLkH9oivZ6WqT63n5axDlAogS2xGwSSjMJtSNLLTbojRf?=
 =?us-ascii?Q?1cLpu9xnEp413JaFYiASJBqkMQH+o1Bls3Yb1gRciXM/9FplHJ+823hf7DA0?=
 =?us-ascii?Q?OZ1p4l0oHpfQzN2/ECpOpL546hywagD9a2BRmgbUdR4iXs5QpVVSkLaqwF/0?=
 =?us-ascii?Q?lcEcCvwvLWbD/fi0OR2eV6owDWfkvtNQ3Mq1cNXS8n6Idl0ZeVJvDar4x//o?=
 =?us-ascii?Q?JcAGPQcgrvqfTS75LJuazrBRRSjNsVCjWjtBVuFleQk3D62NcYFsraBgX3nG?=
 =?us-ascii?Q?MNlY7ySKaxfuqxNg8v64TN+JyBLLms4E8uoZp8RYsY0cNs5JMoghEdlKbVj/?=
 =?us-ascii?Q?PpM+4GUJJ+eDEgzCvekYsAPple0z3yfcAFcZNWt1Nws49p58AhV/JWmt47eg?=
 =?us-ascii?Q?m9yJOudCk9UkAc3hnPVJyOOZHEOIw9CxGhqF7Y6Pbn+Y+DFc71zCdOMQGMYh?=
 =?us-ascii?Q?9XvbLMFS+crYqS3zpozaDksALCzLG2seFXP0FusGcxxO/6uM6wm1JYzKjbTF?=
 =?us-ascii?Q?qUTmEAkrNjEz6XsDv4cUGP0lJi4+6Trc2x4A4/HbFxt2JlPnpFn1IMYhShtH?=
 =?us-ascii?Q?Afkcms+nPnZAi/mBCkkZ5QOz44e3APakWDcyhMQBdZaSDAF7wT4VtpteniUe?=
 =?us-ascii?Q?U0dupbsDy9oX6pbpWoWmNBcWq7XnQFKvr8bIGR/+IB+iFrYIoMuOLf8R20ol?=
 =?us-ascii?Q?beYH4plVHytC/Wb1iYn1jGB3mLLEViulZGBWgpW8+J7Y08gjWo+mkNJZf+RP?=
 =?us-ascii?Q?FWsIaLijj+uxBkNLT+xT0NXBCRVpgaaZR4jD5+REhmGSpaMVBrHxaB3Rwq89?=
 =?us-ascii?Q?JUwciHSRA1IN/BO4PVZvxrin8qNPvgbKjNmFhakeHJqRlNtrd4IQn526HZ8v?=
 =?us-ascii?Q?Raz769BWqAyhmS9bO8KsXjo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ac9ee8-4e24-4041-8954-08dde0040293
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:58.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Td3EJPe2gD49pN45ffUtZAC0E5YQI6rsenAoTNKxSBsTQY4xoGT75SaL/TlmN+i0QRQoTk6AZ0bdh0VWt/hUdCzH9UINSTanUOPUq0LSSr1oOK5ExzTz50W5CSWJhzo/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:10:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19919

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5f5ed645b31b3e0bbd1a1597cdb41c467f3c7776 upstream.

Pass `max_width` and `max_height` as part of the OF data to facilitate the
addition of support for RZ/G3E and RZ/V2H(P) SoCs. These SoCs have a
maximum resolution of 4096x4096 as compared to 2800x4095 on RZ/G2L SoC.
This change prepares the driver for easier integration of these SoCs by
defining the resolution limits in the `rzg2l_cru_info` structure.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-13-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-core.c   |  2 ++
 .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h    |  4 ++--
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c | 13 +++++++++----
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c  |  5 +++--
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index e84def4f6e3b..6c3e6c20ac6a 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -352,6 +352,8 @@ static const u16 rzg2l_cru_regs[] =3D {
 };
=20
 static const struct rzg2l_cru_info rzgl2_cru_info =3D {
+	.max_width =3D 2800,
+	.max_height =3D 4095,
 	.regs =3D rzg2l_cru_regs,
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 00c3f7458e20..6a621073948a 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -27,9 +27,7 @@
 #define RZG2L_CRU_CSI2_VCHANNEL		4
=20
 #define RZG2L_CRU_MIN_INPUT_WIDTH	320
-#define RZG2L_CRU_MAX_INPUT_WIDTH	2800
 #define RZG2L_CRU_MIN_INPUT_HEIGHT	240
-#define RZG2L_CRU_MAX_INPUT_HEIGHT	4095
=20
 enum rzg2l_csi2_pads {
 	RZG2L_CRU_IP_SINK =3D 0,
@@ -81,6 +79,8 @@ struct rzg2l_cru_ip_format {
 };
=20
 struct rzg2l_cru_info {
+	unsigned int max_width;
+	unsigned int max_height;
 	const u16 *regs;
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 76a2b451f1da..7836c7cd53dc 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -148,6 +148,8 @@ static int rzg2l_cru_ip_set_format(struct v4l2_subdev *=
sd,
 				   struct v4l2_subdev_state *state,
 				   struct v4l2_subdev_format *fmt)
 {
+	struct rzg2l_cru_dev *cru =3D v4l2_get_subdevdata(sd);
+	const struct rzg2l_cru_info *info =3D cru->info;
 	struct v4l2_mbus_framefmt *src_format;
 	struct v4l2_mbus_framefmt *sink_format;
=20
@@ -170,9 +172,9 @@ static int rzg2l_cru_ip_set_format(struct v4l2_subdev *=
sd,
 	sink_format->ycbcr_enc =3D fmt->format.ycbcr_enc;
 	sink_format->quantization =3D fmt->format.quantization;
 	sink_format->width =3D clamp_t(u32, fmt->format.width,
-				     RZG2L_CRU_MIN_INPUT_WIDTH, RZG2L_CRU_MAX_INPUT_WIDTH);
+				     RZG2L_CRU_MIN_INPUT_WIDTH, info->max_width);
 	sink_format->height =3D clamp_t(u32, fmt->format.height,
-				      RZG2L_CRU_MIN_INPUT_HEIGHT, RZG2L_CRU_MAX_INPUT_HEIGHT);
+				      RZG2L_CRU_MIN_INPUT_HEIGHT, info->max_height);
=20
 	fmt->format =3D *sink_format;
=20
@@ -197,6 +199,9 @@ static int rzg2l_cru_ip_enum_frame_size(struct v4l2_sub=
dev *sd,
 					struct v4l2_subdev_state *state,
 					struct v4l2_subdev_frame_size_enum *fse)
 {
+	struct rzg2l_cru_dev *cru =3D v4l2_get_subdevdata(sd);
+	const struct rzg2l_cru_info *info =3D cru->info;
+
 	if (fse->index !=3D 0)
 		return -EINVAL;
=20
@@ -205,8 +210,8 @@ static int rzg2l_cru_ip_enum_frame_size(struct v4l2_sub=
dev *sd,
=20
 	fse->min_width =3D RZG2L_CRU_MIN_INPUT_WIDTH;
 	fse->min_height =3D RZG2L_CRU_MIN_INPUT_HEIGHT;
-	fse->max_width =3D RZG2L_CRU_MAX_INPUT_WIDTH;
-	fse->max_height =3D RZG2L_CRU_MAX_INPUT_HEIGHT;
+	fse->max_width =3D info->max_width;
+	fse->max_height =3D info->max_height;
=20
 	return 0;
 }
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 826ca25ef6e6..83e8af1d7ef2 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -738,6 +738,7 @@ int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru)
 static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
 				   struct v4l2_pix_format *pix)
 {
+	const struct rzg2l_cru_info *info =3D cru->info;
 	const struct rzg2l_cru_ip_format *fmt;
=20
 	fmt =3D rzg2l_cru_ip_format_to_fmt(pix->pixelformat);
@@ -760,8 +761,8 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_dev=
 *cru,
 	}
=20
 	/* Limit to CRU capabilities */
-	v4l_bound_align_image(&pix->width, 320, RZG2L_CRU_MAX_INPUT_WIDTH, 1,
-			      &pix->height, 240, RZG2L_CRU_MAX_INPUT_HEIGHT, 2, 0);
+	v4l_bound_align_image(&pix->width, 320, info->max_width, 1,
+			      &pix->height, 240, info->max_height, 2, 0);
=20
 	pix->bytesperline =3D pix->width * fmt->bpp;
 	pix->sizeimage =3D pix->bytesperline * pix->height;
--=20
2.43.0


