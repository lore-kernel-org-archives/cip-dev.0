Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.512.1795708598305193899
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nVxPTP7+;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBC7HYW6PeIB1tA1Jc3h5Nz4n9GQJNbGIA0PA99YjWutrGJs3wa4JZh73EslN3WtxN5XLXKt6KgzbT7ksGaiDc19ShpqdAUf0B2cANVTcPfuIwZqv4hjual1M4cnNdGVj3yuSsETpyTdCBkEFxFAPHPD3ZqcTZHd7XjSEgJiLOrnHUhe1RKI8Fd6fdo+uWDstb2Gd7/6MEdrUyBVhQymRm1uFW1naAPeCOJWVORGt5ITHIA3e6bSsuAbftH41wm0J+dptm1/z6MOVTbsyYBRN3JFQeKzx4dW56jaBgazNeXVGgSiBGqEtZYqTe9SUScricUs0ByuRBsEQUgALJIZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37gfim95htRdnwF33vSX1FPEm6h6HMOreoIgb1d5JFg=;
 b=CZfDN0e3Ht0nnFG44++C8s6vO99RNUradipZhOo/3xuc/UWnjp2m9OEdwjAfHTwHiblct42UnhFXDeeJWYE4NgZ+e4I2u/mFostB+oE9qEgamT518CKdWiWcoRzpEZtFChCADkiyDDvLqrt9kjOgU/BIewlUtu2rcvscb0YDTv3r+gv9XRfs1CDp7OVWCxrffHY3aXApks77EPEErNhkgudJYWIwK6O/H4hZyd4ei9leSVLgNnvwbwz3ppbuBWlfZSUbV52gKkw2oXkIb0/ECjlDza5qH8qSBfww5dc++jygOqpgkIT5hKXnpsS3/KWAw1lM9iwO14OHxQ4RVwj3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37gfim95htRdnwF33vSX1FPEm6h6HMOreoIgb1d5JFg=;
 b=nVxPTP7++FPzI+ZgjhxQyNznbklcZ5UpGi8odArEXODz2MVnL1O1FAWb3eIxLyOyPvCbvgZrLDMMB2ngNWuwpDpwLGJOo4FRrYM8GrgUmpCSbfFDXL1UsyqYu09C4mWXEbp2CGbTHSRhMKxzqrG+EbWgI0Dd2hmx9z8eJqYz6m8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:36 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 11/23] dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
Date: Thu, 26 Nov 2026 16:55:33 +0100
Message-ID: <20261126155545.3834937-12-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS9PR01MB16957:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c0a08c-b83a-4af4-f20a-08df4bd5d990
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|260925021911599003|38350700014|261021121427099003|56012099006|10067099003|260925021311599003|260925022911599003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z4tTanndyRm80zLQUNp9saykabhIJpbe5vUR23j6aLNtTd9N3CeQGbE1gvnw9aEccnDw1Vos/i5NRDN+487cTUgYgAxzc1MvT8YbjilOxlaQX/HRHz6D7P24bHFqdvQl6wvp/37fHOUYDLa504eoCPvqlTLyNdhU22oiXUuS3hj6HzqyEQWgL1ZTxLb6VIg0MLyfMySuAfKpK+491xbFZ25CkyvKyBddfVx6oArrosznevE7XMivmXPtw5JUM2whH7PrG/n1ZdunWAA5q+9ENYrxyGh6el1EVnLd0Gg9yRACL73Q04aUkFHNSfrCgYQACAKDMAsf27Q+uIUo2riF6zNYJ+PbRtdEG151kBYSAx7IOoxoylf1C2n4jlPqaWvrJE95pQcRwApBwgeNXOuGX4C0IxH5N85joORD3Lslv1tq5RX3KorDyv4dzHRuGySzDEqSWxZnhiLuQxH76jpYxqWZJ0FqeDnVsrI4S8BdZJW0/+CrgtnFqBYfZPcBJR2z2/QVCWOjNP5QGXzmoCH/XBswl5bHDsov1Jy+pgKy62qxZCru+J7iwdN6kwQlgKG9Bd/xtxkehhVk58YVvMB0UTXPTZwyOzNuKSBGcgZmVcCgqL6iafHYEE2k0wsbbjMKBptOytGkm3UBU8/CNnokxGH5YrZqn2xOYEINT8vJGcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(260925021911599003)(38350700014)(261021121427099003)(56012099006)(10067099003)(260925021311599003)(260925022911599003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/BZ4prkcbQ84RwGDnSTzGXEjPR+q8l8PMCu0/DOAmLTQlnQnYNFPcAbhfAc?=
 =?us-ascii?Q?5BTElJKr2VSbDaHjAJgPtyIzvwrwUrhAWxRzRQaA2bZJVI9OGCyTgx+sz9ir?=
 =?us-ascii?Q?+c9RrthXJHwy29RVYLrySYyofKRZ4+eoS6nJh+j8mvqDZ7D9aIv3mlZUBYL8?=
 =?us-ascii?Q?mfeEURtAcvRyxiNezUUbaBcIIgAcbyV3uO9Rs3XaQqjs9QwhIGTHK7csIuE7?=
 =?us-ascii?Q?N2Gs+2WODozK57kKY93YUEprlJfnMtb9Xgdem29BsF2q+V7e/+0psHH1KOwi?=
 =?us-ascii?Q?Ba4vf+ybknF8wZZ9b6oFBjMxtRD/cnyoDW2Ieoxh05orjt7hUkS+PWF09Jeq?=
 =?us-ascii?Q?SAlxbyMtw4U6j6gc6M+uh7JdISDvLh2PNNg6dJ+REMjatzJXOjxwJ+8RnPTd?=
 =?us-ascii?Q?KTN3OPC20atQL7d4+4tJTd6L5TB6w+WcIMYidMHLNZ8UX+HBOt6qH4WR7sQP?=
 =?us-ascii?Q?5NQb0CU3aqZQXbVFRyLYzCrOAeRXIJe/2BnxstIi3au1+pbCwK7A6KwaniM1?=
 =?us-ascii?Q?N17i80kIxTtsHM9ZHgjnuVBwk1+/pwoU96RXqSYGrHuTlV9qV3B7e8ASjeSe?=
 =?us-ascii?Q?NQwlZKPY0R8S4IpDGxx9YjzfnjCBN/bB5q9QdU3AJOBo0lBkP5qTK7uYR+4J?=
 =?us-ascii?Q?XCzPeQwG0XG0p/Y9/C9dxiYhTJ7r26V2fMgvzUckC2S++5ZvsyfTcrj8+FK4?=
 =?us-ascii?Q?tYR7NGBQzf1kV9alPkbflTpmTjZMvdxqXblITdMTkNa/6+33EAH9vEq/XTmz?=
 =?us-ascii?Q?zJwOsDSNFvUEw7ivX8DpW6Ky3PGJD9GQTWhaS0Xt1bFZ8DBdwHR/wOpiBIj4?=
 =?us-ascii?Q?QnVYDOTlvQ8kzePyG0J8f+L+TQPa+hzQwV3vhzfGbkuXTnhQubhkvWi+gPz2?=
 =?us-ascii?Q?tzfB0nJ/W73YCUtfYNd0VQqPLeobak8zIzUXqEPdy143GHsaxpF8TkMHfxax?=
 =?us-ascii?Q?Xrhczx2yplwpFw3/bOygxiYy4/wVj3HSdcVgNuXqvOKaofhodrYOlDpndabN?=
 =?us-ascii?Q?j/jLhP3Ur52gnZKp0sl+knN+Hie7rTy6iBeva5k6aIl21aNSogU0LhJoJfbE?=
 =?us-ascii?Q?GrEMk3peL2sF18BZmCOkMs7I7qjma1SzCCg64FEi4lo8bAeBh19puyFXKM/G?=
 =?us-ascii?Q?93ef/oZyVaN5gCuOlDozsNqqH+DCdT7o7JyGR4usyS3tSOh1gdFL+I1ZvURW?=
 =?us-ascii?Q?GUpIMVkX8DFc8T+gT5CmCCR+BAN+WWef67F/Y3QZyUhk4yETgN4hOGwSLRnY?=
 =?us-ascii?Q?zm2mN3zSHbk87OTM1tYeirUWdFTM/5pSaEkAuTsNBVN8YNlFWU08uxxl0Hlw?=
 =?us-ascii?Q?DfZcizEiXyQX0sztX6qK2t1lwHSh4ETS6iZZE5z3NClQ6egJoMcvVap6Ld1E?=
 =?us-ascii?Q?DCWy/GZfDKwnxLXPAcOrfMMwieVbwpwqJkmNOn5MV2RV18VFNVSvhnizCbGB?=
 =?us-ascii?Q?g7SwkjQ1NVR5WS8Rkevg10EQ+vm8PDyfdVwPcTv7S9KZb8jQlIVsyP2aOakg?=
 =?us-ascii?Q?gh7MDAM28+98D2kgeUG5C3WrFSshidXsG4shMZJX4hh9kM/tSQcgIZbwbTZt?=
 =?us-ascii?Q?wnOT9OdhW7lExmnnEawETzgAlhIOc4VP2MbItX+7BRqfFnU2/GvwZODz6M8z?=
 =?us-ascii?Q?Uf/uekDZw4S4U2pzDG1JsP8KmJh7aknPlBSfApX9XO/6zMTS+n6BKfXCY5W4?=
 =?us-ascii?Q?3np6uxycswo3Oov0Fd5isBDph0uIPR1J6ePCRnjz0eiN1z7gvrXJO0FVrZNY?=
 =?us-ascii?Q?Gxr+8RG53tTs8pP0B2azdpbfxDDe7S1oDUlbiOQWYg/gHFkCRFK2?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c0a08c-b83a-4af4-f20a-08df4bd5d990
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:36.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFEvPYR6n3xzoaQSiJSo9NiK+rt1n5lTzz+92tilGtyfnsix+PH+Jp2dBbLtctTKobC+6/rtNf+myylPHuY2KGuBpn8YxihZs6LfFvNtxWwBx++pb7+qd7LnIncxP9JH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25202
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 32a69f1487819766d2084ed32b1350b18f971c10 upstream.

Add a the rz_dmac_lmdesc_addr() helper function to compute the lmdesc
address, to make the code easier to understand. The helper will be used in
subsequent patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-6-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 04f072c6af88..ee609e072568 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -259,6 +259,12 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *chann=
el,
  * Descriptors preparation
  */
=20
+static u32 rz_dmac_lmdesc_addr(struct rz_dmac_chan *channel, struct rz_lmd=
esc *lmdesc)
+{
+	return channel->lmdesc.base_dma +
+	       (sizeof(struct rz_lmdesc) * (lmdesc - channel->lmdesc.base));
+}
+
 static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 {
 	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
@@ -284,9 +290,7 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *chan=
nel)
=20
 	rz_dmac_lmdesc_recycle(channel);
=20
-	nxla =3D channel->lmdesc.base_dma +
-		(sizeof(struct rz_lmdesc) * (channel->lmdesc.head -
-					     channel->lmdesc.base));
+	nxla =3D rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
=20
 	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (!(chstat & CHSTAT_EN)) {
--=20
2.54.0

