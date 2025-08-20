Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D23CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:44 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.59])
 by mx.groups.io with SMTP id smtpd.web10.1059.1755706118686873970
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dT/hMset;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=au3dikG7adgcTG3kaqc/nGE/pt6eJqRoO0fueW0npbQPfsnCnTxDc3vQF/Qcvcvi3IvjpG/ThKj928qV7fan7MX+hJuccHBOz4CN7Aj3oecVACzaQGCSXrHUS7UCUii7HJYhrfgNRbdCBv7poYisG3wYekWtKx+y5tBSu0g6hTQuwisQvUjQZ9TCUz0FgrDBRWhc/qFHbbtl0mOB7sol1YzwdUuZPvKWJvLkMoHCwhJ47TzqX1psJOKX2q1KTm7oei015kzFNKcrznJQJe2I0lOj+HtS/qYNspDo9aOTu1Ark+ZWAuHRnT/HiWyuOddAI15DOBjGUl01SvPh0cj1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52zVM4hzesLY16mGw3XoyTbZmhtkXhUF4pG9fFvEba0=;
 b=wdwraNHw9KlsACnq/jHEcSwWmE0xgJQjD0HKqGF6PRyzOqAblT0x4HMtWUJLGmrxo7tRaP3zP4r729mxhKcN4V0ULo/ezqWaLELQCIm2llCw2zJIqDtDE7+JuiAkHcVIjiikGpQXfm/O9J/nhGrQ9YEyVka0OKtTctrUTZdvyF+NDMJqIfeDvT6dRMZ6Ls3JiI09nfLPjhwJBXGEl2hXzvtw8Hzl/looSiv5zciOu+ERLcHCCIQuf0UX0OVXlfOjfumLn8uHtvFvcLEcfBm/kqUt0m8HufcpGC00UCjR4EbkQ9cP1deMEEIunLV2+LiY6LOR6awYSiDVG8XQczXM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52zVM4hzesLY16mGw3XoyTbZmhtkXhUF4pG9fFvEba0=;
 b=dT/hMsetRsZZuY3igbMg9bMMrXFC9qZMn2Y2AGtHKicPIbFdCFvvO6LJ8gmNhb2Tj+j94po8GQE6hPmaOTjGslmWh0nfpj1TNqFy4zRlHp/IiVtb1uwcJqAZo/ho7gNyXbATB9kGCy/Zlh3wviNsg97CZUXoSi9PoqzUMHPvU4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:36 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 05/55] media: platform: rzg2l-cru: rzg2l-video: Set AXI burst max length
Date: Wed, 20 Aug 2025 18:07:06 +0200
Message-ID: <20250820160758.801813-6-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fdac2a-ee61-4b07-5c58-08dde003d1ae
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UPhW6zEw3kdAs0odpvi/afdmoVEP6apwK7tzaY3XukhvqmQT25qpAwOBkWjF?=
 =?us-ascii?Q?0Bo7MkL2CzGleFaVgr8U+5Zi9FOnqcid81eoQtTwQg/jO1WO/rGsra0MYoU+?=
 =?us-ascii?Q?6ILZiEAwwAcJhGXE7Ed/1oL0RgvNhS1tbC0xn+OBwnMYVRR2eVjCvT2aNV2T?=
 =?us-ascii?Q?Ndi9oYufmc6XiaeSaYsOXhOZA9o7/a8mcmltIUOO0jN1MvagdDsSbdu/IkUO?=
 =?us-ascii?Q?anFk9xJl4ERZLo6K1Nb5BEi5gIRafNigQhX0sPnnrzs95fGJfsyMm9TDbXEx?=
 =?us-ascii?Q?HWl42lLTNRW0/4H3XhaouygLSnkKoCczhVchgS7mHP3E2EH2kDSOLXYrn/O7?=
 =?us-ascii?Q?Epx3C5H6GZNqaN8nUXY3j/xx+Cqa+oDZ4/2VuBddPvsO7aVVP4U7wGElsaY9?=
 =?us-ascii?Q?IE+EZgOMYL7L0AaeRO3xB18aKGnN+39lc5hDOtELG5proReMzj3oa1m8qCH6?=
 =?us-ascii?Q?WQFbE0Aw0/vYNkZCa/RHhCVnP7V5QsWk7BFavNccXmqSRweH3FQL9mhkrlB/?=
 =?us-ascii?Q?zNn/12ks+R8dj7WApOJEO8Hr3DE/jYSMG5KbO1/TDG+mbDrQnJlYvyTAJH6G?=
 =?us-ascii?Q?bwgKdplAM0JE+Suhz6j+QwkfuOM1+bc6FrRqx2VwrvBFKaIzJ84vqg8hY0jc?=
 =?us-ascii?Q?8lJSzWof2ku54XQfC/S1j2xgmRBhx+83XLwMrbewB3Vc449IXJrEefOxcDmn?=
 =?us-ascii?Q?QuG25Tp/4ycdV8K0oYvUgDT77oSIB1EaMa9yCy8NhSoTQ1DkNQEA6W4KGkOz?=
 =?us-ascii?Q?W7nP0LS1SzbH44WYEXoiIC+SFbpowuNzjtTqOkRCoFZHrHVewlFx6258qKj8?=
 =?us-ascii?Q?F+VBCUlfbr7mxL2UUUAQnPsGIm4fJPgUkIj4b7oXCx8uAowHyOZvBm1xZWUB?=
 =?us-ascii?Q?h3lzSGEDJS1v7Q/sXazIfSX4s+7xNHswiU92P964QnorcExPwftrWjYppC0o?=
 =?us-ascii?Q?0H4v8MbEvZvEfz3MNjO3Wdix3bIau+T8rTb4o4G/A+gPpBA5JdUJRvFX7ARC?=
 =?us-ascii?Q?lD+g1dEUfqrecs4zIRxsgo2tAA4qUf83ue/PuwhG9aJOTO1lEOKUdVUEhLWd?=
 =?us-ascii?Q?rz3TmfYU/zW5rL2Xgk8eRqtH0qT/hjT+ffPmpSRSfNdRGzNLxaqbKVhvr6YY?=
 =?us-ascii?Q?HJR21LIHaMwuXAyKbqR/0I5Vjj+LmCpCJyMT8oyL0fpe0Jnkw85VEQO1UAfI?=
 =?us-ascii?Q?IXbbr7/6UYyqf3IDeXD1efBfP+kJ5lp+MHUpBOCKEoyxXPKUFwU4rVQQqgT8?=
 =?us-ascii?Q?1ahF8jr0S95B9HIsK8oYUIR+89w22dN2eqaVPqDzle6q01Od/nYC0ucIRdOk?=
 =?us-ascii?Q?IXIT6PVDMHMFg4nwLsc3RSmAQC4yhO1lAzl/Ypmn9jnn4dArNcrjm3cuTFJL?=
 =?us-ascii?Q?BVA7ennc+Ak7C3zNZRVE/AeDlg/py8uVFuu1qE3lMAsoby1WvwJ9291/m0Ir?=
 =?us-ascii?Q?87rS3+BQ2Z7k7CPkt3z2QGg2Jkes1zT0J2qX7ftYWQspLa20e/VU9LNlHBBC?=
 =?us-ascii?Q?A/lOnil7Z2wJrzI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UYYPes3dMy45GE3qctEoS8ptDzeQdRy/DhbQtn72NedYcj2RofD711Fsxl9Y?=
 =?us-ascii?Q?0liT0k1JDfzYBIwOlEayugx1+VvgsjOBMv3m93EQxl6ZJu4lQe9v3J7aDnpd?=
 =?us-ascii?Q?bYIvaHEGi2xHJLXxu82uH4XY1vEYCt0dm8kiTCSAyFJidCdMALC2e4t8x6FL?=
 =?us-ascii?Q?a112fkiaJEegGcqkMze4kziLV1JAF9XSkV/GWkaXCeKO3usdN/Rl+nYN26rt?=
 =?us-ascii?Q?v37wBrA/QauQ9b3VSSRjMxZ0FYjyBOFjn9nsY6V/G9L5BSEUEx/GIhtLhMKA?=
 =?us-ascii?Q?DyB2vKbzJfqDwf+JmhajS2nouwb1IM8kJiCi7XK+WYqx1vYMsQgwxK9oKwSM?=
 =?us-ascii?Q?CJPd1fhvEfzDNKH/CyBRHfwUC8zdss/IYs5//WhP6gcML/altGh8Sxv0x9gT?=
 =?us-ascii?Q?Mt7EFSSzJ/N1/MeiivqIYYHYbz3a9+vZ3Fsn29Z6Jd3eveJFtH2byrGFYzp1?=
 =?us-ascii?Q?HfJ0a07InIyHsDsKyzNHQ6xANNccpl2YtLpoWkfd4+UWgOnL6WNdBCerRpvL?=
 =?us-ascii?Q?GHViHtyRNVxTmL3BnpDfzSlXq5fkisufEgHHV9SaXhaW9/4xWpRaqLRKXC39?=
 =?us-ascii?Q?alz+seTgnRmtrfyOuLIPz26Eyq+0W8tpUUq+pPyfwZ6lWar1HEV8907Hv7rM?=
 =?us-ascii?Q?ovr2OrFLUAv3xntEe/l7Fwvy5S9oyKtD8/0ZO0tC4AxAb/u/wfQ+DkQYWuFG?=
 =?us-ascii?Q?h9HwSHxvcdctvLv7vVHvE31R6fb/+52f+tzfgAt7FyOdLSw+A9xFnC4edH5y?=
 =?us-ascii?Q?0Zs+tTZpbVrkiulEW89oRfvQ+FbX3bdZYMfRfHO/DHuqE+riH93ilqpG/ZDC?=
 =?us-ascii?Q?+eNt+1xqbr6BO8OCxmYhvnbLo2ebFZ3I+2/jCxmuT1IimgZKNQ7F//c5Ljxz?=
 =?us-ascii?Q?aa8hIp8ETQHVn69uu9cOjaZp+zHC+3Zr+H7XakA4KPKcethjJt8ItTz/YC4N?=
 =?us-ascii?Q?/7Z33sqFUYOQpikT0R9XFjN7Iy7hx9q1fvkJyLxYv+60RF1hZ0UxdxLgFFIg?=
 =?us-ascii?Q?NKv4/IDbha9wrNMLcA2+WqiGkVoNgsnbGX3QbNwbko4pey4Wquv1/kg6lRNp?=
 =?us-ascii?Q?LwGMUPOwavitwJFYtsRqKy6Dm3LggpJqoCFgjZddp1jRCX1NlpU1X0QzBvsQ?=
 =?us-ascii?Q?alGdIvklHWbU8AwSwUdPGhebRRTfsEQGJLOvhx5zF/9QC3QOLnmdlZJ87Hxw?=
 =?us-ascii?Q?FoTp8GBcgUv4JvpBnvQwZaB9HVVGZZp6qXxP8kIGSjQJKrCMlslc7fxFc+++?=
 =?us-ascii?Q?6T0KIB25A2XarD0dIsBq4KYo5ttFOX/2cAmaEZmnwBgCqIFH9taWDadCjxJl?=
 =?us-ascii?Q?LGTD8Sl2OGVSLR8gA8qYG8sfGE8EgyyO9zC9ES+kYGxuHu+8/5N05Pbk98ke?=
 =?us-ascii?Q?454LILdQjC1m6YTbvqW+6H9BI51RBageORPtcSa5HDJdfBYRjmSftR3/vbUW?=
 =?us-ascii?Q?1LkbsWQ06JvT0tp7j9pFZ4BAmT55RTZ5ztuE5bq17rEvJxkK94Ig/JfrIqpv?=
 =?us-ascii?Q?nNMQtgXcyuRkyRyrMv8q0UHkIrjRB92TR19LVvMkXv+Xww/4KubnD3UduZku?=
 =?us-ascii?Q?nJjXg3/YTlQtGoNdUXn882wgWstinlQpNPNiTcBf2xcWDZb1U93uO1ElBuH8?=
 =?us-ascii?Q?RgJa2gyHkTbLPEpjeXj/JOI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fdac2a-ee61-4b07-5c58-08dde003d1ae
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:36.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER+i+PzI2x5h2tUoo4r2+51q33LXHu/9q/EcJTHfr0ticFPY9diJL+P3PLf4Hc+y97aVLCAHBQYfC3FcMojG9SkGVoDTCg7pNF2LE5278m8Q4LrhsLYeehEzl9JPB/+8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19886

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 12564e809c8cb30e3eb0dba5368cf7d356ffc883 upstream.

As per the hardware manual section 35.2.3.26 'AXI Master Transfer
Setting Register for CRU Image Data', it is mentioned that to improve
the transfer performance of CRU, it is recommended to use AXILEN value
'0xf' for AXI burst max length setting for image data.

Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20240905111828.159670-1-biju.das.jz@bp.rene=
sas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index e80bfb9fc1af..bbf4674f888d 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -52,6 +52,11 @@
 #define AMnMBS				0x14c
 #define AMnMBS_MBSTS			0x7
=20
+/* AXI Master Transfer Setting Register for CRU Image Data */
+#define AMnAXIATTR			0x158
+#define AMnAXIATTR_AXILEN_MASK		GENMASK(3, 0)
+#define AMnAXIATTR_AXILEN		(0xf)
+
 /* AXI Master FIFO Pointer Register for CRU Image Data */
 #define AMnFIFOPNTR			0x168
 #define AMnFIFOPNTR_FIFOWPNTR		GENMASK(7, 0)
@@ -278,6 +283,7 @@ static void rzg2l_cru_fill_hw_slot(struct rzg2l_cru_dev=
 *cru, int slot)
 static void rzg2l_cru_initialize_axi(struct rzg2l_cru_dev *cru)
 {
 	unsigned int slot;
+	u32 amnaxiattr;
=20
 	/*
 	 * Set image data memory banks.
@@ -287,6 +293,11 @@ static void rzg2l_cru_initialize_axi(struct rzg2l_cru_=
dev *cru)
=20
 	for (slot =3D 0; slot < cru->num_buf; slot++)
 		rzg2l_cru_fill_hw_slot(cru, slot);
+
+	/* Set AXI burst max length to recommended setting */
+	amnaxiattr =3D rzg2l_cru_read(cru, AMnAXIATTR) & ~AMnAXIATTR_AXILEN_MASK;
+	amnaxiattr |=3D AMnAXIATTR_AXILEN;
+	rzg2l_cru_write(cru, AMnAXIATTR, amnaxiattr);
 }
=20
 static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru, bool *input_is=
_yuv,
--=20
2.43.0


