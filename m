Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90B9CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:03 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.1])
 by mx.groups.io with SMTP id smtpd.web10.921.1755705899501990784
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:04:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=O8poqNLB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.1, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fphKLe3PBQJrAUWQzTZMHP0Fa1ktCKfdmC3AKDW5ZTlXfuL171iTsdAjaXxBIg8LNfnE2lIxdN1MKV+vEAZ/VB4GxO0CgbBB5SEBv6uwvbxDT3nsq7zGPhG8KEFBYoNY3TgxziK9wEgFhTuBp9qiWeqJs8hVCNXgw60JCWZcHi/8TqyCvY48kKGxMSJOhhFoI+52E81i2YrR2EMJmUuvQuKm1m8KBU9Nk6+vXkb6W0BsIl7DOFroeI2oeiIBPkQo0MD7zouOfBEz6ggGPg70vLwszGiZyL9qYXFjKjD+H8xmOpM4DkHWml5TyrxjTQ/xg2nd8lM4PWkRNIkKeb9vEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GBEq923F9FeLurmExqHFRA8ruwBmGpP8SswsBdxRU0=;
 b=nRCuOF97Nsoa0e1AuB/B7Mkiw9pw1BuWOMIOZ0IuWW8RN+wNrLzs4aL98O/3EoaB9+DjiJtFAJuRtIq5Naoi8LhSIMdbF0SRfKBdJlFJK2Gu9y5jAnyTJEkmlG/deu4Nec61Nt0JUrZg4pkUm92+hylh8Nh8eo8tJt1c0bjKWL0wOkXH7tZOE+kKtFB5vggwrNfqZq0/kkyATVUpKuJtBLs+xuobLGEeZWKzz8X+A3wcBbxsqLqeUosepspd/Ur/aHoFtIo2oq0nIuBEz0i8tr+5eokYmyfDB1LreMp9iKKAmWpw5cmo6WM6GxutwCDN+g/mhtHepjHQuAXr3t460A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GBEq923F9FeLurmExqHFRA8ruwBmGpP8SswsBdxRU0=;
 b=O8poqNLBYhkqo42isr5b8S2xL4d69t3Cxr5k7BYiMPTxQ8URmOWeEM0/a2HLqKVQECq0ejh+yIFtTKNp5/5zIHr8jQatwalnRmc1uzaP/Ff/7AW6FUbU+/RxNf32PKTeiVxT32kcRRqww04NTyN19rdhDusatdy+YkBIxJKXOhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:04:56 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:04:56 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/55] media: rzg2l-cru: Use RZG2L_CRU_IP_SINK/SOURCE enum entries
Date: Wed, 20 Aug 2025 18:03:22 +0200
Message-ID: <20250820160413.801341-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f61a6c-bf48-4fec-23ac-08dde0034e67
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0p8VlS+SG018OPvY1rk4soe+BYZFkibBgJUl3kgdY2rV8ZqVZmh06MDqBqzG?=
 =?us-ascii?Q?NHz1YTzbdLBUaVYw11jF3hAkDaVAMl18uzKaFk6nCF6XMcBGR7xKerD2GhE5?=
 =?us-ascii?Q?rKhBe4Kmk4QOqa8nAbnPrq2WFMEcOkct8HDwmaY1dgbFRq6Cf7ozqGQsexj1?=
 =?us-ascii?Q?AK1hXLGVbZja/1Gus4O0353wymRledGvHAW1oWcZ6KoVulCWK2LFgEGIjCuy?=
 =?us-ascii?Q?4TIdNDPWq6sBAn3RRhb0JsPyZeEQSwO/5LlwiI8z29qufte+DQ/nhhIDmEJ1?=
 =?us-ascii?Q?IyBYXgWxU95sbja6HUe+mwlemRWjta3bs3QhHarP0+BOwLZsEG8naybYOVj+?=
 =?us-ascii?Q?I+B5rVgDim15XIpOXbbJZmX7fRc4g6BAboXTSmk4VpejK9fW/7j76UiC6Inr?=
 =?us-ascii?Q?vMtaFTNEJQP2fnVYVJQmged16qta/MS1OcjxwXcN9v6Q5f/x9TUTCv5V1bnI?=
 =?us-ascii?Q?yuMxTfHqLOLYmmsmmSeZnQf79MMfHB36TYPbHv8uEKUJ1LSHPTxKJXPJkid5?=
 =?us-ascii?Q?evW5gvt/GESdj0kj24deYD2EPHflLX+c3EPkapyPIRy7Zx15QBlz363dHG0M?=
 =?us-ascii?Q?pBPGYIt7Qd4yNvNR1HFCa/LeUdl2hm/KamVO88bw9lYaPPjXTzC5sxsWTt4I?=
 =?us-ascii?Q?t+qtpz/4Ri1COKQdi1EH2FziNCpJ7z1X0wkqVVs4XVA70FIbc6smaJzW2noR?=
 =?us-ascii?Q?Crc6GCK63my8vb9EuOsKQ4RSMT6vPZwALwX4at20/QxnFom2gU4pH6w24wVW?=
 =?us-ascii?Q?o+P7hSb1Cwl0mjZPFwsF9KXVi3dWE/6MwFWPGevlgDo8jVZj3fhJvhk00N1f?=
 =?us-ascii?Q?gHKzoqMw6Shz/4UUoZOOppvf3HYqDLRzp42mGjr0BSo9r9B8mZcIHJhV6Mqk?=
 =?us-ascii?Q?j/+X3ZnEgnpXeyehxYZdc8w0zOauEqI6qNZdNo0Hz9EOcCawg3uRj3Cm2KUI?=
 =?us-ascii?Q?TTkGPOHLGXbSPe1S5LH1P+tyvpW4BrayYS7MoxKwBNXwrGrYv3+qZdItGfAp?=
 =?us-ascii?Q?xlbohu7hCqksTa4zXKNHokgTmxYnQxzf57dVCEhTyyRLx9Ri2ogRX17a/hBl?=
 =?us-ascii?Q?fRVkoU6zxkPj+v6NnlP5WE/hMfDLi4ZhyRlnLUx/jPksIQBo8dfeoSSl7exN?=
 =?us-ascii?Q?QUNrWRS4/MuK3r0ih48FcuUAmYwzlju3dQNvRtw+SxG6AwPZkSvYwXwRVfFR?=
 =?us-ascii?Q?P5A5KwABxbRpNk53UB5saRRJU64ULqanrUCahSus1A9bft/1uOmP66YWepaA?=
 =?us-ascii?Q?H50C9qeUCipIz7JFGaMEeoqvIhkmDTZvPgrEteKkZMpbg0q5iDXDmDSzZZI8?=
 =?us-ascii?Q?2nAbBPyDL7fUR/1PmjYCq5gJ4MgKLc/7tmt5emmcurlRafTLdQFbSxiAIfqU?=
 =?us-ascii?Q?Y/uqrABM7r9RbADRXWVdS6yff2OUYFTz3timyw82CRnBBxD235Ya/Hvy/4lG?=
 =?us-ascii?Q?VdT8PGNP1xYeZO5b1GUPg2CglhTxxQfPqQOW3cJWxU3/PSz7nGX3FJTCvLE6?=
 =?us-ascii?Q?VsjGJUZVJFZDDtQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GgmfxH/95jWOg4bUda+7aq/WaD4a0VRf5rPexof2UvFUKRe33LEhsgQM9kfQ?=
 =?us-ascii?Q?LB2/kHPYhi8uu3IOJsHqvZhrqn/2+LdwIQt8UR70AtHzpo3EBsD9HnN/BoTF?=
 =?us-ascii?Q?VZaBGpxwutDX9UlFk0P/h5dj4dDXtdp5FfnLecCikEXSpXWFuIFlbE4z417G?=
 =?us-ascii?Q?mVkXJOIjrvrBrfmxjEaY9xZv28xNsq9rieUHNvB+tODiSk79NBLNk30i6Tfi?=
 =?us-ascii?Q?9X+tObimqaenKjmrPbtNhh1tvHEO47Rmnj1xYkuRxDs/0RtC9jJFG8m7K4Rf?=
 =?us-ascii?Q?KNO+/hPAAKIOWgz9iLM9PetjOi8hbUmrqEhp+3KZi1wrRznVK+pFA1k/npyO?=
 =?us-ascii?Q?xIDBtDa3ELv5yHA5IfUJGpflG7azLWtNjM0pkvfLZDzpPgrF82iBSTq+bNEW?=
 =?us-ascii?Q?FwFkg1VytGyI6tWzmTN6jD2y8LmbXjMUTbuG/3PIiEcOWy7c9uEbXXlAPf05?=
 =?us-ascii?Q?ldDdS6msob0WJHTc+8zKrGsp5m53/0mVvE5vo0SIMb8TSSRF8nacvdzIDo2d?=
 =?us-ascii?Q?7W8S5XNJbJ2gkBykOeBBn/FvapMq8qD/ImR7wYxA+538H28QbqU4iinBqYoT?=
 =?us-ascii?Q?iMopjnfcmnbY1C2kF3z9saAG3sYVmBV82YeigjBmNmBQcRt6e/n0/rMhMFZg?=
 =?us-ascii?Q?fuDQMR+rjaBL2H5KnKHRl5SIfiXB+9o/oNeTozy1OabSDNzUSRshFXJG2PzI?=
 =?us-ascii?Q?k0UFwrlfn+kJgq1mjdLNFBa7Ovw0UWeRTl9BZOdZtw+70ow1zrjTTceRyXwS?=
 =?us-ascii?Q?f5nLLzi9CWutW3J2Q83LVq5jpHSPTTZeyxB7b6ql1mRSbFD4t0Y9VLUcbV3P?=
 =?us-ascii?Q?olQi8Ju2wSq2C0rTQP5fHATiXVFNaWVbxxNJ+wUrK5+HujO06u91TZB0oo+r?=
 =?us-ascii?Q?o9f+d5CwVOuoD9Gl28+iGHzwaQT2a2+QZ72yiE1Tr1sp9fnOBIdK0Sq/FGMw?=
 =?us-ascii?Q?6QZs97he/aiOazRoLIOY0GnoLf7XGfruxp1ne1bHf4EJK9lCdnUAoPl/Ompe?=
 =?us-ascii?Q?KCuQyz7lC7qe7mx4+Q6/KI6PGhoznUJ8RuTvWEXNyFlYNlgrLd6135soKIXo?=
 =?us-ascii?Q?BA9FWKmY8SNTJjIgne7bzz/La6REZa9xd8n9UlLXdOXmcyNxr2a4qZgMR8By?=
 =?us-ascii?Q?hgbGJR3YZbwuwLgP0jaFMyE9WRrnN/VRAV+o/Fo4GZRugcRbkT/K9YRIHl3o?=
 =?us-ascii?Q?p5878hVxjXftvmbQpAUAZpSrwf0B9DRm3c2XCn1/TYzLhvzLT3hriTg7q4w0?=
 =?us-ascii?Q?b87V5EFnqHKQWUfHd6LHp5KsFMQ4UFx2NCsRtfb8yT7xM/Oe3+W6AlLIo9GJ?=
 =?us-ascii?Q?GSvAf+BnSOvuApAZksaPYE5Nc60R07m868evbdiVyu8yxunHuEN/Z1EMPEsK?=
 =?us-ascii?Q?wydqq+9m5eKW2e8hYz1UJofo9E9Unezbduf2ajwSFhP8MRB40w71/PbmCOcm?=
 =?us-ascii?Q?c173iwTaiU+De5CCT8cq86MSPXbZD5vn3WB84WMB2znTU2EwvQ8f6l9HmKEz?=
 =?us-ascii?Q?o+nQEkFKBr4r54u3ZzEgoKIwUjfGAjMiMKqgBYrMJUTicLNoD9UDjYu2b0Yl?=
 =?us-ascii?Q?5xAXSPo2KODoZIXiPAiNPEdmVCWn+zWY54dbIiFBh//XYf42EGldiBsot+on?=
 =?us-ascii?Q?2O8psp86DfY21SaxismVzKM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f61a6c-bf48-4fec-23ac-08dde0034e67
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:04:56.2197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4Xe35PG6NAqUGn+iyJU4VVOrj43VasJPSAciJ2g55HYijzLhAhJxASUrxmGDNzq9xwbMLo/SeFRnqwgfpTey+Rg+FBffnJi7+SfT2KkYZPfGncSDiBCd1FEvj6P5Tkf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19831

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3b954c34c3fc9c353e3d0987d40e134e024986bc upstream.

Use enum values (`RZG2L_CRU_IP_SINK` and `RZG2L_CRU_IP_SOURCE`) instead
of hardcoded array indices.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 3433a831aef3..a7316ea9a6b3 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -213,8 +213,8 @@ int rzg2l_cru_ip_subdev_register(struct rzg2l_cru_dev *=
cru)
 	ip->subdev.entity.function =3D MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
 	ip->subdev.entity.ops =3D &rzg2l_cru_ip_entity_ops;
=20
-	ip->pads[0].flags =3D MEDIA_PAD_FL_SINK;
-	ip->pads[1].flags =3D MEDIA_PAD_FL_SOURCE;
+	ip->pads[RZG2L_CRU_IP_SINK].flags =3D MEDIA_PAD_FL_SINK;
+	ip->pads[RZG2L_CRU_IP_SOURCE].flags =3D MEDIA_PAD_FL_SOURCE;
=20
 	ret =3D media_entity_pads_init(&ip->subdev.entity, 2, ip->pads);
 	if (ret)
--=20
2.43.0


