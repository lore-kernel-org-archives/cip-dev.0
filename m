Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0178CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:43 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.2])
 by mx.groups.io with SMTP id smtpd.web10.952.1755705937981693945
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZJv3rfI0;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.2, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSB6RPuJL4/59YCLlz/h0foUgvweDfyqARjuecVOUPtVvOBe0knGU5FR2nflbF7Jk+6x5e1+UHgD+n0hBc7GW86YjdQkBEcVFZgzy2joSBDNlUWYxtMZSCrLD3lBsg3L/GfLdVLc08vB/aWkE6GvVLaQI5VcgziZaitXjmlLvFALllHEdYS1ImjQvMo7wbH6CRn3bOrwM8lHzNPwlt9/CTVHuH6KIBJq/lgc0OfucnnkVQ1q2YqUm+IV4WCfEi5MEbtrjk2LjJlk6b667sbg2MZPyxOZ4Xk4j6RSoLKYtRuOm0Cld8nk4uuCsQ3v48WBLKr/cZWTl8mkRWVEA18ZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPH21nlMkmFn4I7TGLWVRnnlM3v6yKDtG4CHAEt4WoQ=;
 b=IOgfDGBDyGphVanf5EUmMeMkoDJ5IngZ1Ca2ZlPLBTnKIfNi4Efsg/oSj0XP1DRBxruasut9pk4lpvVP6QRvtIwj08pQbkoD5R2PLvCM/+y+DrL+o4dQm105qHgAWZw/dwL2ll+IbSVbUcead1fxJe9jqd0wyzt+kQICPBjnGFhnqem7elYJxEE/kydMZHnexta8WX/2XBDmR4BCqC+rzdn+TPiE4PwMB8pMKJfAR4DbJIO19E3ticeSsR1e1xRuah6r/mc4vtdpmjUK6qrulfqFqm+A9NH3rzkHXJq0qCyq7LwNOfI7BhclX5/vfj612wMqkIDAxhX6sdLTRiVFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPH21nlMkmFn4I7TGLWVRnnlM3v6yKDtG4CHAEt4WoQ=;
 b=ZJv3rfI0wDCaLv/YGnM6vm48fpPVI3myPs9Y4bv6WuBcm8UAMadkuT8YDXP92hQfV5QzelX3DhuzS7axGmzAIWDLoJtG9gE63NkEAMJcjGqOIASO+eByVetVPHJlS28m+yTitxlXBT2HnRzRAh9QCs2ti2c7+eo0ORqlgG1U8Mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:35 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 22/55] media: rzg2l-cru: csi2: Remove unused field from rzg2l_csi2_format
Date: Wed, 20 Aug 2025 18:03:38 +0200
Message-ID: <20250820160413.801341-23-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c05ba14-46fd-4cf7-b1f0-08dde0036604
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tAvVECrXdsg/XY3hC9D2mdnfj8UryasJKP6mW1UV/q8m4f8CDBCIGVvz+YK8?=
 =?us-ascii?Q?ClN2JC1yaNaIcvECKULa6BGLopxtMAYRaPWTa1w5bo4uxlingDWtyI0yh/VL?=
 =?us-ascii?Q?HlBXgG+NT4JC4YdwuNxmjcYFSUEqqQ6Wn+198+x26SrlYDIcT4f9hJODEQdN?=
 =?us-ascii?Q?CD3ComJpeYqhF16Q7OP/WnoHG2BUyUjnwt71WJNGGDCQ022txWgFQV5ZwGll?=
 =?us-ascii?Q?1rYe61ZFWk1m75qNId1mrYb9hPEWPT/gHgiNbKV9ExQ12HGnUX7IlQJq3PEQ?=
 =?us-ascii?Q?vLLhJbypisZh2MB7DxBYGCzx9ZsL2t+TqZ2MYSGsEYobttBjIWulEnTPi3rS?=
 =?us-ascii?Q?BhxslKOpSXKMNy+MpcG7EXDmd2KddjANckZAESdG2v8dKI5uh4Vfimazs6+F?=
 =?us-ascii?Q?wES03bHdOAEiIObtZreUqMt/ARFYHXpoIRJ+M35r3IHP7eZboqTdCgOyDyIu?=
 =?us-ascii?Q?Eph+EIZelP9cPgI1FHmZ+yvv3Kj0XM7yIe8TGWXrLxDLjiRU0GmVP35E+5VT?=
 =?us-ascii?Q?qXa663h/J+rYT/NNN2LF51vn8n4K6qv/c5iEH8DopAcPX51hKphxVM706sRo?=
 =?us-ascii?Q?a0LopnWv1gOMxE/erJuLGeOM09lbbk922Z0j5e15EeZCqwmCs/TZbIAbuITh?=
 =?us-ascii?Q?QhlEJYQAV28s/d3wIk34XSuw6PQLIgig7gKc3akAMsjYG3xI0AuL8TfinVZU?=
 =?us-ascii?Q?vZq2eTw6wV4zPjibaja7w89bRpLlwzCqbUGs9adIYTeeNZi1hU15OF8EdIRW?=
 =?us-ascii?Q?3n+lViIRw5otfGV+yITEORSRqKuo63/hML/p44gKuwqTTYGKfszIPSAFcTeQ?=
 =?us-ascii?Q?KpzO5twwCMLlR5QfnU4d/PQPCamTdlxJCLoeeIN6Gg20hwh4LT9gcihERp3m?=
 =?us-ascii?Q?8smNjSKPsxmvunk1vVcUZCBEFOD7EDY51ZQUiUwv7aVQ2S7RWqpAVifzH2UF?=
 =?us-ascii?Q?9AwIZRlksSwQaYBigMtDK7xsWbENQne27YfwVSNB398Bn6YWXGKLxGfsppQo?=
 =?us-ascii?Q?kWH1qYFcrQBhNilAGOmNCjYCI2aaA/JXXhiPpO49lbkFgclgrI+dFzJjEAa4?=
 =?us-ascii?Q?NzFXgardXSYnw+qbXw8pxCgmTNK++l4e3MMMvG5sfgAZOLfNpdHuzP+HQ1xp?=
 =?us-ascii?Q?e/Yr7Q6xpDHTvgo5FscDFG5/sEbFhisFJ5r4SS72pociSSWR5jJEl5gapVi6?=
 =?us-ascii?Q?olExn/loS1TokxOVYHen4xHU3UIIB75T7V+FqL4cK6KXNme3kRcoycaiG08h?=
 =?us-ascii?Q?f0Flmn+3ZlB57IqI0MbUjbHSG9SM/S2TTwd4IgLtQwusvk6EEKliBqHhwzvu?=
 =?us-ascii?Q?GFOxN4qCzrLl/x74ueJecdpa1hDojFqWnqn+JlncecB8CuBPBGXcE3UmbbWW?=
 =?us-ascii?Q?vepA6y6GdkkmVvh58VfCjT+IiVt8lOmYuKeyKlqfi9p1YevuJAjvQ3M4+mvY?=
 =?us-ascii?Q?Mjg7yprLywG6gMFzbzA/9wOLRU/BYyLIMRUb2cID7wm2f+eQ6vT5vkNk1sn6?=
 =?us-ascii?Q?D//WPNjE93yj4xI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?akAzfbQDK84H8Agd6xNZxtGy2XzKUHX/jt4l3k0qRlhqpVUggzepVHWnPS4T?=
 =?us-ascii?Q?zCTB9O1vp44jO9dX1HEOfMwNT0wIssz+umiud1h63oe+iUCCGdvj7BMi2R+E?=
 =?us-ascii?Q?RF/PtIKWdr77xNiTsZjuCSaLzPCOATjV7cRku7B9kX7l0OlCvPeP7zHWoSpy?=
 =?us-ascii?Q?IdizychkBDSe+UNjxW0y9I15ZHb3o6d3RAxE1IoSPThk1P3SDxGa7GVp1NkJ?=
 =?us-ascii?Q?rALH1lPmy0nvREgb0SRxDqzM4rlmggxTvvRgmdoQ1NTe6eU41IBvDg5vsKk/?=
 =?us-ascii?Q?YqXaxsuZym4WfS47ruWukOayIZjZrl/gmz1k1JUIJ2vPjTdmbWRZEnBKLCzu?=
 =?us-ascii?Q?ucBB7/14v2yY1Rwn4fSYJWT1vJ7aJEgovHgaHnh/k8kdu9/ZMki0HOnZXYpm?=
 =?us-ascii?Q?ZSx2KcOZfE39gjUbPP4tnKdbTgFfHQL9UPo+XyTubrsw4/ZMbrWB1cAAGR/u?=
 =?us-ascii?Q?0RRQ/nHxdQRZ71JvwFZfBp6dSdGEx9csC9ELcgxi0kWL4pq/pNejvud7gSah?=
 =?us-ascii?Q?1TaeAibpSakC+rBU85mLO9xGPxdK0BHp9jPd2XaFysbyHspwDL7imPvnzscj?=
 =?us-ascii?Q?pVT56LEJbcIDVBEmp4+LXnDx6El4X1lC2jubJcQBVcr+zO245POCgXxCdcv8?=
 =?us-ascii?Q?XKIKjdNNqqfeTQA44wNvJeo8zBlrfyGsso8rP9sysHDRG3X7Y6ticw9dCZMS?=
 =?us-ascii?Q?uX6Bs0tB6zGPnTsC7bMmZmBdPGV3bFf6GTx1tZ5ZcQYR4pzeN5gRJT4qrFAl?=
 =?us-ascii?Q?+K+yOzKVEdqfpCiqSjAKjvVns1ZIaI60DwQqk4DGju4yiWtWRSiFsfTg1ONx?=
 =?us-ascii?Q?e6x1IAuhnTCDdJp99LbLPW6OeYABG5+KKzrCymu8QscRNPWNy8A7YMwhyUm/?=
 =?us-ascii?Q?WGYr6siloNU7lWz8eSP6jfSThz2srDr1pYCbcn6PSUmMRJvM0gklG8uM9oHH?=
 =?us-ascii?Q?DTgykPmTVHb5vqrDaExrB1MljwnuXfJ5PU6tLEfGDTDxEhYYTb94jbBoz2rT?=
 =?us-ascii?Q?2Zxb+QISuAYOahKSkHQG6y+ExL0hK3fnWB3d85MpRB6HdJABZRF99+jBxySv?=
 =?us-ascii?Q?9b94BX7eN3Ul0HAPS0/Hq+v0UtTj1DOVctA9H4QKF+oRSjlKu4Fo6XzZUDE7?=
 =?us-ascii?Q?+zF6AysG6kTVivG32zXc+oUPpiStFiRDJbRLrC6EjHto1Xl+N55EyhHr5nxT?=
 =?us-ascii?Q?w7cNg2UaqOtnsrrB+5QqLJkaZlrYCQOBjulT/rO65ILFyIi9WO9RTZFZrHiU?=
 =?us-ascii?Q?V5/4m6i79JNxKTrE1G5KSX5fMs7UeOA64qCO8VIyR5KZI4K+q1P7iRMQaYoa?=
 =?us-ascii?Q?QQGhIS/dgzcTVNHZ84bVXDkh6b+hWZN3DSRySzQB+/BNW0C5f8j8DRhS7mgJ?=
 =?us-ascii?Q?epq6MZd96C6qmESFwGx5vdpoqlEGIZWl6GAiwh6BYyakwD2WD29+8H2jdTHf?=
 =?us-ascii?Q?S+Y2jtZr/qzXVv2eJJhqgQBQ1h7dHE6lfLOh2kS00a9cVDGgppEXpPu/uG3F?=
 =?us-ascii?Q?XaFC3WkNTvYfl+LcX+LyyOIYmtSodr585s3TtPesP/2fLkhH9jLERlqEucmW?=
 =?us-ascii?Q?BR9ZC/63fQUoC8X73wkPJoPMEB0XNTva9OrGgrg0EOehT9mgHFnqi2K4wOUg?=
 =?us-ascii?Q?h+TjCiV2yH/CiE1msPD/xck=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c05ba14-46fd-4cf7-b1f0-08dde0036604
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:35.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnVILpViGzGJaTiZJIyzqSr3B/tTvz5fDAhpYpECa+NwMc2yMTVeAIb8LdGZUb/wec+AZpaIvUHO6uAuY6FhuSnArfIQYxVFPIgpO8OjPx9l0BJl9aV3hI87LsMNTKeV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19847

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit fb2ebb89cf99e750ffdd570439d93234d06c031d upstream.

Remove the unused `datatype` field from the `rzg2l_csi2_format` struct and
update the `rzg2l_csi2_formats[]` array to reflect the updated structure.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-18-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index b0d83e0dd1b5..3416bbaf4dd2 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -184,12 +184,11 @@ static const struct rzg2l_csi2_timings rzg2l_csi2_glo=
bal_timings[] =3D {
=20
 struct rzg2l_csi2_format {
 	u32 code;
-	unsigned int datatype;
 	unsigned int bpp;
 };
=20
 static const struct rzg2l_csi2_format rzg2l_csi2_formats[] =3D {
-	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16,	.datatype =3D 0x1e, .bpp =3D 16 },
+	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16, .bpp =3D 16 },
 };
=20
 static inline struct rzg2l_csi2 *sd_to_csi2(struct v4l2_subdev *sd)
--=20
2.43.0


