Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B49CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:10:04 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.3])
 by mx.groups.io with SMTP id smtpd.web11.1063.1755706196987968649
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OB9XUIp/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.3, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WG2neOlD9wjThirI8OjcoOZ3ABypwiPqRZp8F85oRXcEjLgXKOILnpu+IluZyx54Lp92Cp1glqaUKfdpmAPZXg1MjvQmptR7WIh/glEkjnnCGT/ywHwWq6Ap0QdTSsCOYiKbzuEMgNy1I+kNq/J8uDRNQ59jl2M5XInc8hHp93apMshQvJSET2+41RBHhirrkTzmefjNvbu/m/ueQM590WrsR6pAgKnl+tMuXc5PqbIo5BS9xc7H/136lwK11jn4QspqAraR4peWT/Ha1Xj4dNNRnW5isaTo8cg7JAElQaacQA34HhwVvs2beV122z3WEiIKbxcwmeQGIcWE4DyIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrGg8ekeA7q6pw+oyzIxsbBskHZXs123RGwDf4ycn6M=;
 b=GswGIxotVcKseP/n8riLFNXwTJ5Mi8cuXpDlj3bS0/cAdyJAG3aDjnaEMjNLmWnRk+eN3A9SniOisL70H/uTVNIU9vgmIV9R3qsldZouxcFcW8LhaJoKhdIWLb2VdH3x6QN7Kiz5pMODQwmc4duPtoJ/JOC6gVsBYItfgAnjInt7/6E0C5V8cBpCn6PvDNTcsgra+XFd4gZLTpDBbr8ff7fB0wyRXwcQZso9hTvF8Z/uTRxYm2lIvvf6LFX0B8gALEIIS3Vc74x3BhQSq2l07JXRRWB8myap4F/NzlryJV70of8kkrEanfIRM+9qZIDhNvEJwpofxTpwKXJpsEy44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrGg8ekeA7q6pw+oyzIxsbBskHZXs123RGwDf4ycn6M=;
 b=OB9XUIp/N89v4aGs6nj+xr2jD8j8DRJv5TB7H0wmOwe2Kwe4u2TP2TYqittOgbOlR+BBtAekwei5I8HKG+XrZHFZFn31c2R/6b4LnwKWG4rSuDHn/czAEaOesP9OEZkV+SAURrkE8YWIvmofsS5WozOsbuxOHmua/Tht9gwVDXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:56 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:56 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 37/55] media: rzg2l-cru: Add register mapping support
Date: Wed, 20 Aug 2025 18:07:38 +0200
Message-ID: <20250820160758.801813-38-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6aad032-e8bf-43f6-3ea9-08dde0040111
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0zU0fwgB6x5h3vcRm3JiJzAnnuCGAgYKN0xG57yAOvOOvQ8mOxztM8nFuDwb?=
 =?us-ascii?Q?euKHkyZ7g9njiPmTuO2IY19+x3SSqih6BpCtWoabPks4wsVo9eAdWA++XVZh?=
 =?us-ascii?Q?sDBxsnYbm0WFyB0Qwy/SO8INXON2IpWhP3jqyYXMylsr7qyAklao0BtbPZDS?=
 =?us-ascii?Q?6PP2n/HGUUURnj39+xDRWZq//AOo0UwGgbL+sY9nz251+ogDgnsTWzffD9e3?=
 =?us-ascii?Q?ekKEGpL/1Fz3UET9gn/mBP+4cT+qcmpwQ55L53/tfeBChEJKloEYAZPirM6e?=
 =?us-ascii?Q?nWWpL8j62thFhdDGD+LaBgoENi4Q7s9tFlGlZKbzaPm1jEd/W3gQVt5/MDr8?=
 =?us-ascii?Q?pboIBq1Qm7wnMYc6k/5Zc8fP4li4HwbQf6yLVLk6FNW6w/v9XJ68u4wtZGHr?=
 =?us-ascii?Q?X5h4W6fZXa4C4+NtoHl0sraXAbYSvbCyWhhOW0pJ1YxuQsr+aXJz4YrkEn1L?=
 =?us-ascii?Q?B8BYZ05Vz71bZtLpQDh/tsIi3GgAjDWNlH/dqDR40HtC5X4/0OFXkq9u3pRP?=
 =?us-ascii?Q?lgaSSvtrHfVXawNpPjqwpoSJtU9lsn2w9QG1xq8il/8BkZ213P8ORDKshGWU?=
 =?us-ascii?Q?VzRG6zMmmk/EOzF2FmBQ0RguOxxPgIksG7GvPbeF9A5bLfPyHq64Za7k59BR?=
 =?us-ascii?Q?mrzOhL/Dta8tIviQiNeJhqeSv2FmdppI4gh9GaG3F1s8uTHLBywTDVE9UH/Y?=
 =?us-ascii?Q?Jv2oyW0Pylu3SrDitFhAxmT493TKuaYkqPMp0+cntq+vhwSupTfbAlHqrg79?=
 =?us-ascii?Q?me2Oywe6B46SKvHmMYhgfilc0n2bHtdlyCNAbKFsBHNj/6+3mavdCRLEUDj5?=
 =?us-ascii?Q?xQj9BlKqUzzttvxiwcKrw4uOWfSnrWMe9e8dsIziH65st48ck2jBVopUNHbx?=
 =?us-ascii?Q?k6DDCI4DG+OJXRZNYwULv9LsVJunYBhueXTn5HL6RQAzzsmR0v1BbLp59e4B?=
 =?us-ascii?Q?MQB5V2XrLOaJhOUQXumEK1Pr9/VrA5QGtT+1qocQBYNJuUzg66Pm7xLF4cNQ?=
 =?us-ascii?Q?BMB62FaMFvr+NsgW9d6i2t78bZ+d/B2ESvRugTGrHEIbX457PuNf6xkEhBRF?=
 =?us-ascii?Q?g6dB+4a1bA/GoYQG110dcjSP29zqFSV/MImFuwjYsSIMMh7IfPDTcruS8/VH?=
 =?us-ascii?Q?bMAIspyWRCeWAO/fVEg1vGBhS20TmKn8aNDHAmeYd3CmuyUvt7Dc+lLzw+B+?=
 =?us-ascii?Q?3yLmhpbh0M4zvwHi4SMl0/K07VHspNQBYA9U7DiJI1iIRLgu+723xbYRvbDt?=
 =?us-ascii?Q?9Td5uH9Aaudqw48vMwFhswvvB71gIZcjkJPmdfqbR7zcgHmKY/WoaPcanogs?=
 =?us-ascii?Q?NwbYwCam+40j11aoRip/lqmg9YsqorBPa6ZUBxWxha+4gyBe3qgs6fc0nJW7?=
 =?us-ascii?Q?D8nbMHiqx7xdq3Zd+Luh4DyNMXfMeKDVM6DoPCSgXc6VKt1ACh4uyBa6cs6y?=
 =?us-ascii?Q?uSpbiMsKxKepnoH9X314YngQ665KiQl2kDMIUOccaS3YWq21U47gGnAnEAlc?=
 =?us-ascii?Q?eyoBcKsMOo0caJs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ijf6+T9IaV5RUAfcjL7ghIAxcl7UR+vUakggdEtilbX3zcUVHB12AmnDk+hp?=
 =?us-ascii?Q?oVwQsaWWsLb2PtGzGmTM4JnEM0hRTOcuLZtdumPpX5fl2god4ydsd6RRSjXQ?=
 =?us-ascii?Q?yvStLEuedVW/DR6iFzWRrV0ghZTz0rUl+kR2+YdOCY+wIXu8PUu8RylEH7/Z?=
 =?us-ascii?Q?UrZOagOZ8j0VZLV2RcDeeCeOTPKcgMeSV4UPsEKokLdM0q4ozIUMT4ocBeo3?=
 =?us-ascii?Q?Z7gcUrju5C99Anqf82PrRowycIGoJ8lfoKxWu6N4ER+m6k8SptjhccWDrNRr?=
 =?us-ascii?Q?Vipd4/MOq1qXeeSBaqVt75eYyntZt2/cXU5J6KNv100YK2srLgYgYBwK0X5T?=
 =?us-ascii?Q?qKSVn3DVvJg/vy0hCbeJ6qf39yMWezDLU2DxqpgZgm8EGYWX8YJhmX+ZGrlx?=
 =?us-ascii?Q?YXGe63T3Lh6/83ivjBNMas1LBabP3G6VclEc7gVTG2OzP3WJ+/usoYeRxjLK?=
 =?us-ascii?Q?g7fHN+CDzXE1Iufoi1HPDR+AjIqvf09znTULGhOFBRybdjII0uFrE6VtlFcX?=
 =?us-ascii?Q?uKV78BjkRU3oBfny49Gl7+xLgKyA2N9KV8GHy4zwwnYqhOZQyP5LE8Y7a3Fh?=
 =?us-ascii?Q?R7/VcPZjrEuIHvUDASh39V8COIM/gUJH8Yob35djkkDsRL2hhhz0GsE6zjVx?=
 =?us-ascii?Q?n8Ek3hUIqIcl+mhFZxXmnT2oDNFZaT755eqyzXPIhWVzkRa117MVCgrxlBXc?=
 =?us-ascii?Q?yd83rJ0SNDje1wDBrENIzvUBeo7k5R6YwuUBz1ECrgIz0entBfAxycQFhOdI?=
 =?us-ascii?Q?y23DgB5WXQaDo4NdCpm06ki5ElKKRtNppJzXJJb7vnajRtaPsfKa8SKrW2fC?=
 =?us-ascii?Q?CKVG/hrcHuchIPNEHPKNfT05rl98773I0vxC7p6kWZ2105FFMjNM6kxk00TL?=
 =?us-ascii?Q?el7lGAnypzzjDk9lJsP4erIT01/mO6k9JVuuLzkmVdjfQioTIRgdO7tOhZ4W?=
 =?us-ascii?Q?1qyzWyw2mVDu4QHAPbcKC6xsFCylWW3r7pxLvwtzgeYoduwDqdfhl5RfXEQR?=
 =?us-ascii?Q?0VnTacPXFZZhzBoYG0YACQTrk77TP7HDGmG5znWKslsLVpb7V7aKa+PeYwaV?=
 =?us-ascii?Q?h3/Wkh42oVhDK4npc7+q4yzBZEXlnR7nppoiLbn8UJvyNeZ8VvMAO/wQbAao?=
 =?us-ascii?Q?Y8GKt607Vf1FCfq2WGMkc5lQ0DrC4NLcmGic89C2kpgu1t/IyJg2awOgZeJq?=
 =?us-ascii?Q?7Az1icXF7ax9ixgq7lickgwn3b8hvjNy65bB2e3b6Wq/5P2AGLkU/YHwWPxu?=
 =?us-ascii?Q?qYdVF2vbvZR6ApxDMiqkoRrB6WPcwKRjDTwoqM4WAkCKlZyR8k+PaiJZrZvE?=
 =?us-ascii?Q?8lOwLNJlGxaJJ2rfwg68kaUp6IzXK6PAjsXMf9fTfysGxaAKI/UTQ2UxpkIE?=
 =?us-ascii?Q?zqm/tAUZ4KE6K0+7rSYDBflXokjPzWXCWrodqfLcplpJyfetfDnatFgAWduj?=
 =?us-ascii?Q?MnEjeepjF69TmQRD3ZbNQVR0lU+aTn2UYWGgzJzYL/o9XUnsljPQBNGj26N6?=
 =?us-ascii?Q?FsFugTrcgPSmlGtP8OHbKb/y4zUPWC1+NDzcZB9tn8ZKFEuh9S/OD7koeHtR?=
 =?us-ascii?Q?skRUPr8NiW9OjMrw1+4ju0Kc9Bo3kVsmkaK55t5maYDNC4emdkUfut4qgNAx?=
 =?us-ascii?Q?yVj+cKkT0vKlfd969jagdh8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6aad032-e8bf-43f6-3ea9-08dde0040111
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:56.1899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYmabRk3lhfj08M6u7Y2D5G9djZXZyJdp+4Lh1MhzlWzauXR5XPmMGY7K2m2zh2qa9S9eYpykkutBqxusRkNiMMUdshfa31+Z7o5qy1JIHtwMmDhL2jXqR8E1AA8fJlA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:10:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19918

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d9063dc50255db21b5a5e6ceada1e3a8927e44a1 upstream.

Prepare for adding support for RZ/G3E and RZ/V2HP SoCs, which have a
CRU-IP that is mostly identical to RZ/G2L but with different register
offsets and additional registers. Introduce a flexible register mapping
mechanism to handle these variations.

Define the `rzg2l_cru_info` structure to store register mappings and
pass it as part of the OF match data. Update the read/write functions
to check out-of-bound accesses and use indexed register offsets from
`rzg2l_cru_info`, ensuring compatibility across different SoC variants.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-12-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 43 +++++++++++-
 .../renesas/rzg2l-cru/rzg2l-cru-regs.h        | 66 ++++++++++---------
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  4 ++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 58 ++++++++++++++--
 4 files changed, 136 insertions(+), 35 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 4049d3f5a88e..e84def4f6e3b 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -22,6 +22,7 @@
 #include <media/v4l2-mc.h>
=20
 #include "rzg2l-cru.h"
+#include "rzg2l-cru-regs.h"
=20
 static inline struct rzg2l_cru_dev *notifier_to_cru(struct v4l2_async_noti=
fier *n)
 {
@@ -317,8 +318,48 @@ static void rzg2l_cru_remove(struct platform_device *p=
dev)
 	rzg2l_cru_dma_unregister(cru);
 }
=20
+static const u16 rzg2l_cru_regs[] =3D {
+	[CRUnCTRL] =3D 0x0,
+	[CRUnIE] =3D 0x4,
+	[CRUnINTS] =3D 0x8,
+	[CRUnRST] =3D 0xc,
+	[AMnMB1ADDRL] =3D 0x100,
+	[AMnMB1ADDRH] =3D 0x104,
+	[AMnMB2ADDRL] =3D 0x108,
+	[AMnMB2ADDRH] =3D 0x10c,
+	[AMnMB3ADDRL] =3D 0x110,
+	[AMnMB3ADDRH] =3D 0x114,
+	[AMnMB4ADDRL] =3D 0x118,
+	[AMnMB4ADDRH] =3D 0x11c,
+	[AMnMB5ADDRL] =3D 0x120,
+	[AMnMB5ADDRH] =3D 0x124,
+	[AMnMB6ADDRL] =3D 0x128,
+	[AMnMB6ADDRH] =3D 0x12c,
+	[AMnMB7ADDRL] =3D 0x130,
+	[AMnMB7ADDRH] =3D 0x134,
+	[AMnMB8ADDRL] =3D 0x138,
+	[AMnMB8ADDRH] =3D 0x13c,
+	[AMnMBVALID] =3D 0x148,
+	[AMnMBS] =3D 0x14c,
+	[AMnAXIATTR] =3D 0x158,
+	[AMnFIFOPNTR] =3D 0x168,
+	[AMnAXISTP] =3D 0x174,
+	[AMnAXISTPACK] =3D 0x178,
+	[ICnEN] =3D 0x200,
+	[ICnMC] =3D 0x208,
+	[ICnMS] =3D 0x254,
+	[ICnDMR] =3D 0x26c,
+};
+
+static const struct rzg2l_cru_info rzgl2_cru_info =3D {
+	.regs =3D rzg2l_cru_regs,
+};
+
 static const struct of_device_id rzg2l_cru_of_id_table[] =3D {
-	{ .compatible =3D "renesas,rzg2l-cru", },
+	{
+		.compatible =3D "renesas,rzg2l-cru",
+		.data =3D &rzgl2_cru_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_cru_of_id_table);
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h b/dr=
ivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
index 1c9f22118a5d..fc0fd0c97c86 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
@@ -10,71 +10,77 @@
=20
 /* HW CRU Registers Definition */
=20
-/* CRU Control Register */
-#define CRUnCTRL			0x0
 #define CRUnCTRL_VINSEL(x)		((x) << 0)
=20
-/* CRU Interrupt Enable Register */
-#define CRUnIE				0x4
 #define CRUnIE_EFE			BIT(17)
=20
-/* CRU Interrupt Status Register */
-#define CRUnINTS			0x8
 #define CRUnINTS_SFS			BIT(16)
=20
-/* CRU Reset Register */
-#define CRUnRST				0xc
 #define CRUnRST_VRESETN			BIT(0)
=20
 /* Memory Bank Base Address (Lower) Register for CRU Image Data */
-#define AMnMBxADDRL(x)			(0x100 + ((x) * 8))
+#define AMnMBxADDRL(x)			(AMnMB1ADDRL + (x) * 2)
=20
 /* Memory Bank Base Address (Higher) Register for CRU Image Data */
-#define AMnMBxADDRH(x)			(0x104 + ((x) * 8))
+#define AMnMBxADDRH(x)			(AMnMB1ADDRH + (x) * 2)
=20
-/* Memory Bank Enable Register for CRU Image Data */
-#define AMnMBVALID			0x148
 #define AMnMBVALID_MBVALID(x)		GENMASK(x, 0)
=20
-/* Memory Bank Status Register for CRU Image Data */
-#define AMnMBS				0x14c
 #define AMnMBS_MBSTS			0x7
=20
-/* AXI Master Transfer Setting Register for CRU Image Data */
-#define AMnAXIATTR			0x158
 #define AMnAXIATTR_AXILEN_MASK		GENMASK(3, 0)
 #define AMnAXIATTR_AXILEN		(0xf)
=20
-/* AXI Master FIFO Pointer Register for CRU Image Data */
-#define AMnFIFOPNTR			0x168
 #define AMnFIFOPNTR_FIFOWPNTR		GENMASK(7, 0)
 #define AMnFIFOPNTR_FIFORPNTR_Y		GENMASK(23, 16)
=20
-/* AXI Master Transfer Stop Register for CRU Image Data */
-#define AMnAXISTP			0x174
 #define AMnAXISTP_AXI_STOP		BIT(0)
=20
-/* AXI Master Transfer Stop Status Register for CRU Image Data */
-#define AMnAXISTPACK			0x178
 #define AMnAXISTPACK_AXI_STOP_ACK	BIT(0)
=20
-/* CRU Image Processing Enable Register */
-#define ICnEN				0x200
 #define ICnEN_ICEN			BIT(0)
=20
-/* CRU Image Processing Main Control Register */
-#define ICnMC				0x208
 #define ICnMC_CSCTHR			BIT(5)
 #define ICnMC_INF(x)			((x) << 16)
 #define ICnMC_VCSEL(x)			((x) << 22)
 #define ICnMC_INF_MASK			GENMASK(21, 16)
=20
-/* CRU Module Status Register */
-#define ICnMS				0x254
 #define ICnMS_IA			BIT(2)
=20
-/* CRU Data Output Mode Register */
-#define ICnDMR				0x26c
 #define ICnDMR_YCMODE_UYVY		(1 << 4)
=20
+enum rzg2l_cru_common_regs {
+	CRUnCTRL,	/* CRU Control */
+	CRUnIE,		/* CRU Interrupt Enable */
+	CRUnINTS,	/* CRU Interrupt Status */
+	CRUnRST,	/* CRU Reset */
+	AMnMB1ADDRL,	/* Bank 1 Address (Lower) for CRU Image Data */
+	AMnMB1ADDRH,	/* Bank 1 Address (Higher) for CRU Image Data */
+	AMnMB2ADDRL,    /* Bank 2 Address (Lower) for CRU Image Data */
+	AMnMB2ADDRH,    /* Bank 2 Address (Higher) for CRU Image Data */
+	AMnMB3ADDRL,    /* Bank 3 Address (Lower) for CRU Image Data */
+	AMnMB3ADDRH,    /* Bank 3 Address (Higher) for CRU Image Data */
+	AMnMB4ADDRL,    /* Bank 4 Address (Lower) for CRU Image Data */
+	AMnMB4ADDRH,    /* Bank 4 Address (Higher) for CRU Image Data */
+	AMnMB5ADDRL,    /* Bank 5 Address (Lower) for CRU Image Data */
+	AMnMB5ADDRH,    /* Bank 5 Address (Higher) for CRU Image Data */
+	AMnMB6ADDRL,    /* Bank 6 Address (Lower) for CRU Image Data */
+	AMnMB6ADDRH,    /* Bank 6 Address (Higher) for CRU Image Data */
+	AMnMB7ADDRL,    /* Bank 7 Address (Lower) for CRU Image Data */
+	AMnMB7ADDRH,    /* Bank 7 Address (Higher) for CRU Image Data */
+	AMnMB8ADDRL,    /* Bank 8 Address (Lower) for CRU Image Data */
+	AMnMB8ADDRH,    /* Bank 8 Address (Higher) for CRU Image Data */
+	AMnMBVALID,	/* Memory Bank Enable for CRU Image Data */
+	AMnMBS,		/* Memory Bank Status for CRU Image Data */
+	AMnAXIATTR,	/* AXI Master Transfer Setting Register for CRU Image Data */
+	AMnFIFOPNTR,	/* AXI Master FIFO Pointer for CRU Image Data */
+	AMnAXISTP,	/* AXI Master Transfer Stop for CRU Image Data */
+	AMnAXISTPACK,	/* AXI Master Transfer Stop Status for CRU Image Data */
+	ICnEN,		/* CRU Image Processing Enable */
+	ICnMC,		/* CRU Image Processing Main Control */
+	ICnMS,		/* CRU Module Status */
+	ICnDMR,		/* CRU Data Output Mode */
+	RZG2L_CRU_MAX_REG,
+};
+
 #endif /* __RZG2L_CRU_REGS_H__ */
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 8b898ce05b84..00c3f7458e20 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -80,6 +80,10 @@ struct rzg2l_cru_ip_format {
 	bool yuv;
 };
=20
+struct rzg2l_cru_info {
+	const u16 *regs;
+};
+
 /**
  * struct rzg2l_cru_dev - Renesas CRU device structure
  * @dev:		(OF) device
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 9f699f95cf8e..826ca25ef6e6 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -42,16 +42,66 @@ struct rzg2l_cru_buffer {
 /* -----------------------------------------------------------------------=
------
  * DMA operations
  */
-static void rzg2l_cru_write(struct rzg2l_cru_dev *cru, u32 offset, u32 val=
ue)
+static void __rzg2l_cru_write(struct rzg2l_cru_dev *cru, u32 offset, u32 v=
alue)
 {
-	iowrite32(value, cru->base + offset);
+	const u16 *regs =3D cru->info->regs;
+
+	/*
+	 * CRUnCTRL is a first register on all CRU supported SoCs so validate
+	 * rest of the registers have valid offset being set in cru->info->regs.
+	 */
+	if (WARN_ON(offset >=3D RZG2L_CRU_MAX_REG) ||
+	    WARN_ON(offset !=3D CRUnCTRL && regs[offset] =3D=3D 0))
+		return;
+
+	iowrite32(value, cru->base + regs[offset]);
+}
+
+static u32 __rzg2l_cru_read(struct rzg2l_cru_dev *cru, u32 offset)
+{
+	const u16 *regs =3D cru->info->regs;
+
+	/*
+	 * CRUnCTRL is a first register on all CRU supported SoCs so validate
+	 * rest of the registers have valid offset being set in cru->info->regs.
+	 */
+	if (WARN_ON(offset >=3D RZG2L_CRU_MAX_REG) ||
+	    WARN_ON(offset !=3D CRUnCTRL && regs[offset] =3D=3D 0))
+		return 0;
+
+	return ioread32(cru->base + regs[offset]);
 }
=20
-static u32 rzg2l_cru_read(struct rzg2l_cru_dev *cru, u32 offset)
+static __always_inline void
+__rzg2l_cru_write_constant(struct rzg2l_cru_dev *cru, u32 offset, u32 valu=
e)
 {
-	return ioread32(cru->base + offset);
+	const u16 *regs =3D cru->info->regs;
+
+	BUILD_BUG_ON(offset >=3D RZG2L_CRU_MAX_REG);
+
+	iowrite32(value, cru->base + regs[offset]);
 }
=20
+static __always_inline u32
+__rzg2l_cru_read_constant(struct rzg2l_cru_dev *cru, u32 offset)
+{
+	const u16 *regs =3D cru->info->regs;
+
+	BUILD_BUG_ON(offset >=3D RZG2L_CRU_MAX_REG);
+
+	return ioread32(cru->base + regs[offset]);
+}
+
+#define rzg2l_cru_write(cru, offset, value) \
+	(__builtin_constant_p(offset) ? \
+	 __rzg2l_cru_write_constant(cru, offset, value) : \
+	 __rzg2l_cru_write(cru, offset, value))
+
+#define rzg2l_cru_read(cru, offset) \
+	(__builtin_constant_p(offset) ? \
+	 __rzg2l_cru_read_constant(cru, offset) : \
+	 __rzg2l_cru_read(cru, offset))
+
 /* Need to hold qlock before calling */
 static void return_unused_buffers(struct rzg2l_cru_dev *cru,
 				  enum vb2_buffer_state state)
--=20
2.43.0


