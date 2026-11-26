Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.297.1795708146113469528
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:49:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XQm3AAXz;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5m7LPGAYg3F42IK/gdcf0JU53NuHi3rKYQDHjUgXbUqKcKbqLBkOt5Z4qlRxfFShanWtJlPlptzLbH8NnxUl8VQ81TDsMQ9O8puHZJR7OkBa9A3AUJ8GjUxpCvg33127n5lpMsOZH1KdF5dtiAfSOJxfVPSlteO7242iuQm/TnYCURbcLgjDhofpaxV/YDD99vk1sDE9ZHHc7ry9jnM7MWDZfCsM2K8bO8eLygaHlxFwEf8wYn5EY1u3r1m6tuGgHYJkny/ZPaef8gwhsXFUVg9oEQIt7N85EYheaCB+zxwzrOMDfLWbbktaId8F9eA5ci2zhiloSfddPQdljEdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbyV5OPeyPHT3a0y8Jnf/MREcvp79aGLrU52csYnsbY=;
 b=FlOSWX84xir0MLexmRXEswUrAiip5rTMgxrqNDgQ+KNRmLOWDozrD7yCmT+83cxZIdrAIQllupPVNCrGqxPMA3jGAn/xGCWtQ5fk7XahuUYzbjHbaso7eO1/6sZz2xDHX4GMbAmUt+/4lXekfyjhF+t3LtiX50pZe6oQhiaaCJwZGDl3ud81diBiLEEvke8lQQiFkUxdaSw/zI0byBilQvpIF1hLNVcpFtLBufIiqI0URRyVy2y0wuDLHmugo7fUqfbNpC7yVtxaZ/Y7Kw8/9ANg7kEiggnr5cqmzSXpbsFCNA6hWKRNCcqihwGqNICLGR4DQlF6paA1NtLaF7OmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbyV5OPeyPHT3a0y8Jnf/MREcvp79aGLrU52csYnsbY=;
 b=XQm3AAXzUUptxKCevNP4GE6usSsja6DbXgPj3XzlCbPsG/7Cem/3nPZQuct6PHJq0qvPZyv9tyJLTmo9CQTChr6qOnq3mS+6isCH7C1QpDHc/ZrbWZSAd/llhToJdHet/pTvGikZ9dI8zNyWKivQoJYmpA+gvS/NKJHu1okph2E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:49:00 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:49:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 18/27] dmaengine: sh: rz-dmac: Add helper to check if the channel is paused
Date: Thu, 26 Nov 2026 16:47:38 +0100
Message-ID: <20261126154747.3832917-19-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB13015:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c5e40f-cad8-4813-8660-08df4bd4ca0e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WaVj2AzCYo00Fa5YAlyP5V5MSSsaykG86o+/GM7fg+e0bl+IPO/RawpocUIn5UC009sGy41VjxSipLa84zdFRWYxAQ6jOSSj/O7IsHHoUHmHA2UhjfQw3yztgzdcvA9+DZi6FwcBmlt9k+95gF1nnJqzZ2jEqD8T7PaIffiTK1ex48yb1IZT8IYqpMAt0k3S0cLga8f/KmOZj3BQqeOegoNrlB7m8Vkwq5YJVNCI1TVjPeNkWN3pSrVvtI8BdOh1vCS2VFmN6ZXWf2IjF6WtYM17qsepUL+3avPw3CZzKmHEocmnyyJoMYZzswP0lDkRjHyuDp7bhzdXmav4Dvd+Flx2jGucxclxJpKMlbQV2zWT73MYkCWJd3Y1vYjrBv3wLtUXXpNNXlgVtZxmT+NG8SUwGdNvaJ7Z9mj4l/hmQBwVM1PgPiG9Bt3Lakqh9J7gimAXjTcw2HdPBG/pPvRaeeM41hGktl5DmYSPRq4QV2b1eGV+30os5gzMnnVTzvurJFQHxvn5Ln6d/rm7ZBt0cdJ/SLgthQiRJ8c+swg81posBhg4SF7IS3VscOQ/7iEmbrtUiJ6GhBFKWth7xqeYII/97Z9Iw+aN90JEs6sYe7lrdWGQOOKDEAL0N1Y9L625k4HM8FkNJgLN6BiYGCu7eXgRPbeMU5ZtfC4U7oL2K7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F5R6oewaMCzt/0cG/FyvdUjTkS1vajTgBqBvk6/PUzRtdiBS9EJrnwoNtJgv?=
 =?us-ascii?Q?jLSOFI911kY1aj/Lgk2H76bdX8N28U2imoB11K2DjuMLgK6iPjhHeVPRdsFQ?=
 =?us-ascii?Q?elF3kGerwVBiURcTemdtws1wZVJrsru/avNlfKEseRIcAsT/MW51cIXzvDVm?=
 =?us-ascii?Q?0IicKRsgSvzYLcYSsNjyCZ17SR+BERi8URXFwBFeHAgHtQ31Cwi8DiIRENoq?=
 =?us-ascii?Q?VjjJMhAOaQw1vavmeOdUuutR15e5Fe4CMTBlacxQBjFW0/JR6BphghgEEE7p?=
 =?us-ascii?Q?sDxbnytEfdzxLMXig4BGSyogcsOapGDRgzWGpf2WfVOXO28TeLDvZaFTEiNa?=
 =?us-ascii?Q?tSn4nbSLokixl7Fuv2HK/Puo8EHKH444qN1QGVEqeQqmxS7veIPUgnb95coR?=
 =?us-ascii?Q?wHcRWVt2PUnV2STyiLKobcH3jP2fAG+VYkZG5Eh3gQdiN1ioJWgogxZyQ9F7?=
 =?us-ascii?Q?4KZZ+1UVlnbwwttk4uGipm3CGcyNOwOJD/FA15W4WR4QPrjYufRXIo27gL+i?=
 =?us-ascii?Q?YlLZ8+OLXt7y41BZrwSWhQ+J5Bj6OdLUnnFph/m+NpibClbX5JxpeZeZhQqj?=
 =?us-ascii?Q?0xqh/qRoF6wuWZ+ufeP6MZ2c0s1UhpCMnW1ZHsM/7mYYWsovFGTWu9VFgsW4?=
 =?us-ascii?Q?C4uH36nSyVaBa6zMuW/WEQVtbJ12SSZ3TfwBcvi6nodQ1lNaw+4dBfuwMLtj?=
 =?us-ascii?Q?rI2tlS5nEuIbCrWNhgYnTL7ZqhgMephW2coRUihZGMgTPBsbKbqNGt4JxSeY?=
 =?us-ascii?Q?7VooAL3okPHsBQFXdhTqSIUmNUIpr5KePUl/+MMgY3TVM5Mz73iMMu0IZtDd?=
 =?us-ascii?Q?6FVnmO3AV6wiJ2ZGqmVrc9vMblD3YF5mJBi3Wnwq1j3iZPYEL2IFzrr4/FOW?=
 =?us-ascii?Q?CL90J3K3k2ND34doPoHJgPL+lqK26IvwG0Qxc9NG7XjqZyxu17DXtq25AImx?=
 =?us-ascii?Q?Vr5MXlO8IzOwYJCJokspJx+G5G7lmzcQx90wsKeOOP1Jwwk2uB15+QhsCJX0?=
 =?us-ascii?Q?u1aJodIqAWIpAO7Rk12IqaRh1i1ZrNjg2XKD0pzCPItio5HuxvTuwZr+F0D7?=
 =?us-ascii?Q?VYVi6wJA2/OXjeHdwqikCDcfeV//BxP3rGw880qtxbxvmpQmHukKDsA9LjGJ?=
 =?us-ascii?Q?XCTsfOoPAzlrLxleA7k83HlpimaB9zOo0UI4O0YTOkl4kxUUBe2eDi40IiYp?=
 =?us-ascii?Q?wLqwuHZDcqUk4L0dU5DA+GQMpwFxhLkbhe/UXLPUVuq2Mpd7BaMfjoPgC2AN?=
 =?us-ascii?Q?NStRqWHJ8hJDHLG9e7voJSznH4xeqBnPdWQk/8igU2+ugIhf8HqQGKQbo1Rh?=
 =?us-ascii?Q?l1oTRHiJRfGp+yyKuNLwoMU9o08mZe6/2HLRErnnMdwmHCl2PnHMPHb/V/HR?=
 =?us-ascii?Q?EZGGJNFcRLiV++7Ev8Z5XyI4YZWQlxGrmGWGByYQS7JK8u0CybUN8aFDoJ6w?=
 =?us-ascii?Q?51o0a++bBgpK9FXgKljl7Homppnpz0+lWcYD22VMR1HNSKypwYSwdrgVAMvh?=
 =?us-ascii?Q?BpzTIS4xBPYEFdFOXyHVunABsE+SNX4S7ZVH7JzR7vi8rPStnqiQltftDydH?=
 =?us-ascii?Q?E5GIY9dmuxXf5Y4iBLkgJUsuwVv8VdrpcDRce1inPalLadb82R8YG7Sxq4y6?=
 =?us-ascii?Q?WtId9NsxaK7hAHCdqxzB/yk8TVINgshHcNfm3/ikOd4HQQ7fqZbfjmrXPwJa?=
 =?us-ascii?Q?hgRFWrCDgmFdKIDrIfUd/8QdSWMCg6agTixaI9PA4fVCq+XfdfTaXS/4rB5h?=
 =?us-ascii?Q?mOX4NHthdcsyPpSv04jENZS7Wt0qj6rugms8eEhIvb29XqxLttjr?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c5e40f-cad8-4813-8660-08df4bd4ca0e
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:49:00.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpwH2HrbhqL4yI3cLOF2KJop9uEskDTIY+LneFZIv604jrq9GBkb9OJPt6zcAX/8xJ0CKBr/2J+mNVxYEcENncua4H7JzZbNHBqWnmIDOgknBTjS1femZ0PJH8y0cwcs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25168
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1dddc864dfa844efaf36345eb58b121b2cdffa5f upstream.

Add the rz_dmac_chan_is_paused() helper to check if the channel is paused.
This helper will be reused in subsequent patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-9-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 73a2b61e718d..0ba6bc545e61 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -285,6 +285,13 @@ static bool rz_dmac_chan_is_enabled(struct rz_dmac_cha=
n *channel)
 	return !!(val & CHSTAT_EN);
 }
=20
+static bool rz_dmac_chan_is_paused(struct rz_dmac_chan *channel)
+{
+	u32 val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+
+	return !!(val & CHSTAT_SUS);
+}
+
 static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
@@ -821,12 +828,9 @@ static enum dma_status rz_dmac_tx_status(struct dma_ch=
an *chan,
 		return status;
=20
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		u32 val;
-
 		residue =3D rz_dmac_chan_get_residue(channel, cookie);
=20
-		val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
-		if (val & CHSTAT_SUS)
+		if (rz_dmac_chan_is_paused(channel))
 			status =3D DMA_PAUSED;
 	}
=20
--=20
2.54.0

