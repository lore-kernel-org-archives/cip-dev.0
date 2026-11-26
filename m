Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.474.1795708583622263499
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=e4Y5SjY4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.21, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDOWxl9r6AnD01QhteRc4eoKL90fbNam347OdYpY3aFNx0dferr2QsNpuWsOFQd1xj3xTNAfGVD2/rkX/XBpP66jkWxrTDovCdKZYxRcxBvT3ioPWwROqug+fzIYRfjxRyO/xxC/cMcuCup38LMnVpbIxsAyv+RcrV27e4uXn0sqC5onNV8kU8ti7Y7hWUrnpY8honVcdQBJfkDIUJbdLPWZYVlOnv13XGjkRV7xysykBGHDgepfjySuhcVWTTNBiGiHWbjwTUI0K4576veoYNmgtaYl+XX5LWWPTgKeqrgrvoDewjpI5KM92Ic2xmPocfb9ehrvqlupFJ/VqJ45hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKb/Az32eZMZHSYMlfZ9AzMVvu7J7UaOQ0ADeNV0sPA=;
 b=lykqvY+sRFbTFXVOyBYjMes009cTjn+rUp3OYoH+wfA0Zz4aq3z2gF4Tp8nI5dY7tu1yDZNVv2aoSzvYIAcgSnuRwpfRjzBJR3VEBIalBfb00aOYlceMOGF7bcAd3W/xe680P5ElCjn4Wlqoj3jQOhHNt5uJUE2HwTO6v1WMFjWobZj/qo6DK+44cjIVR1Uq0yda7ATSVib3/rX1KqlqiWgm8f/BCCmQ0gieO9y7wJH/3GGfjyDqYJQoBdMSCOawEQsIWfshZk9jlv32EMKyEP1Q8POwcms9WaeKtxf7UFIC9ELYImojL6rc1D6e9obhiHxj5w6lPLx/RhXA0L9RFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKb/Az32eZMZHSYMlfZ9AzMVvu7J7UaOQ0ADeNV0sPA=;
 b=e4Y5SjY4/x3Zs/ZKC36VsSANlEaVWAGqxnlXBTzGyylHna7be0MGQn4RNmOI5QW7LzMtns1QDt9IEdG2ixbr21S+t+rt8P4/CospWxBJYuXyTq19zSk5E4L+d2mE0KaoozXE7vjfW4DRAsXP6505G5sa0VQbpp7PLnuqD4ngNnU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:19 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:19 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 05/23] dmaengine: sh: rz-dmac: Use rz_lmdesc_setup() to invalidate descriptors
Date: Thu, 26 Nov 2026 16:55:27 +0100
Message-ID: <20261126155545.3834937-6-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 01be978a-4e63-4a12-5cfb-08df4bd5cfc3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DvX0nc34bFH29qcQ01JAxsk/082VbGnOdbtFK3b/1vGwFt7lhybviqypq8PnNl5/5XTkUC3Wpe+27knHVoz0KY8ZRCxC9VgGHXwY53BACrg/nn0nGQrkNX1JRLsZzoxkXI3PLfsvzpE4YAmSifHP407nwdftG3xTC85F4hKvBJBQisB3va/pUbKtQjiHurnRrKCjwW+wzSl38OrbtAmHsQoDQWEMGyJaUgzV7L3VdgzXkqhQxv8WREr1qihsa66vzxkxyU0qCXzA38Byn3jAt/8rIDi+QbV/Kj2aF0VYQBYy/c9WLWoXVC1JwG7ynAqxTzQaXGA7evcuidbXYHv/nkn5tZukIj0wCbXAiOkUDMp0n5B4eIsTTKK0rc5qKOO0Xk+ET77mVkOeCl7zd2KA4Rv69carSuxnakLyrVlRjE9a9QmNU6yjBrpgeSh4/1jou54GbLLJzhA0Y0VNTXsdF/Fry9GkMX5462Y1/4lYRteC58Ojh0eKghRd0dxtnt79q56/jCFZa1PCYwn1sL+r9zPwSDO6f8gzEo5ggmALd21c7PBcB2KAkgRWRjueIOLa09ZSZjOpExaUdx1+TSs2IG0s2kbkzMUKIly7zjgQZJKG0uQI16i3ZT6BpGrnb2PSNvKopBq9F6FjGkhSl3zOVtrwiJtM3G7mbf5iU6VPXIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TPm01gqw8iP/anGZCzHfaHbEnQf/vGmhNLTag7NVoui/lLbCLmGCdpELtoo6?=
 =?us-ascii?Q?xGWH82crAYPHqblkvmwLFvXmG+PfuABL3LMOyy+IA+M9UYrckCFWViDHoL0G?=
 =?us-ascii?Q?Ocbqq7xop3cDpnlezvM0aSRC3lTW1sWAxFfjQuKDb0+tNcXDO605RsHTP0mY?=
 =?us-ascii?Q?C3hzaSFADt5WN6kLAJWFnhm8YX36xYOujB877Wu6k7DlZsXfHjmSxNSjDmzS?=
 =?us-ascii?Q?qoUvcP8t8uWShs7gv7mYaTbSPIZabOChrrtxKzpdBip4feBbb6O3kNE+BCXm?=
 =?us-ascii?Q?TvWlWaANYzVq4MYo2o40ERMJxf9KDJhc6DDgUEEZ4UDzzTzCffBemc5VxjZx?=
 =?us-ascii?Q?YZam+54/bmAmt/wEZWWCGFtnKtOEABex63zk2uwbPGS0gwMrMszX/R5azOkZ?=
 =?us-ascii?Q?Kxn+UTywshXH4TbiqsYr3khLu89RrxZXV/Sw10mDSQ15hjfppCRH6JBtBhbV?=
 =?us-ascii?Q?62D7jlv4vLu4mfwFdimWbAySIgrJcf4UsgEbY0nEQT649isK+uQCIwquWjLI?=
 =?us-ascii?Q?FUQ5/HzkOOry3aaw4LH4rhT/ZPk2DW5sVtbP3EhsumDrbZdRtr0futCoTTXs?=
 =?us-ascii?Q?DqlwZ+ckbsp2lPbSthm4A77DoKA3jankgeWQN+eVF3A9aYLoNtfLeqATIvcQ?=
 =?us-ascii?Q?TO2BCzIJ53KS2O3ZzeXgvsNLl57kRhhdUEUKqHgk50d2s0XBG66XMDsO52ZP?=
 =?us-ascii?Q?M4IZemIN9JQCYI2UNKg5W0cRVn2gmBXvUzMEUm2ONJFei9ycNnyLV1r2Uj84?=
 =?us-ascii?Q?/IImYq3Dp/3ZtMjcC2/4/5ghwP3xgenGmmlX6LK3T4nP+aeQmAe+YcPb74Rm?=
 =?us-ascii?Q?uYpqppfWYTxvWpQACyNsvgLAgV6jZtieXdsF5W3ld8ymosYk0SIPwaxh9zcf?=
 =?us-ascii?Q?LgLCWOQaOHGO7sEa11oMNQ2ZJpTn78fN1pCbkAzbSAeF33vsevd1jWXEp5Ph?=
 =?us-ascii?Q?j8rhX6BmlSda/wID0h2CO6Ma2p5cEBwgZzPlTVntIobLju0zc6US6YCHO5im?=
 =?us-ascii?Q?66ApNCtBd7VvmLMQzzq/3gxNKYYGJ11M2AMbQAevx6w1EYoZwqAC0iKZvQ0p?=
 =?us-ascii?Q?NNbbrfaJTFtdKabw7CzakJeO40Ku9bnd8pfmUDWZjZ/5zQH/ED18fGktrWZF?=
 =?us-ascii?Q?usLQyJFD7URF/JZ8Nwohgu+fs5JaPBb+4t/Fwj6VOGZabJc0xc8WA5l/KKqZ?=
 =?us-ascii?Q?vVI0vUM4haRiXtLrIcUqVQaYtQladvGwy6u4Aj9nvLFQJqfh2hN0qend7P2Q?=
 =?us-ascii?Q?R4exKND6aZxvWB1UBh+p3u178Q6CAnnLKQhubHjTpj7PA/cVq6+HrYytMoRc?=
 =?us-ascii?Q?OBV291pn12NPGOQlq6W6hM3vcgbomVDfEM6ftLDuc+6Vqf0u2mqP86+MMdIk?=
 =?us-ascii?Q?qf+cgVLtl2cPTn9jZ7IsENg3CxfdTtNOdLQ5w9LSuzGFScAimSuFBaojbyBc?=
 =?us-ascii?Q?yNG3TS8JLLO2+ufRKdGAoalYuZqUwsdM4QLCSpGaYnZfnhtVqzGyeIG4lbNc?=
 =?us-ascii?Q?uxLXPHhdHnOMLh3Qz/lKgNlFhQPqf/mv0ht8QkWpxPcVzqDw3FRv8L5tL0Af?=
 =?us-ascii?Q?ZvWj9tqzsEf7PtiwOJN5qCQ5an+gxb4qog83GzfOjepaK3kxtSWpwOfa/I7E?=
 =?us-ascii?Q?mHwjRzyjhLrgdct1sW0MSCdM8PdWshd4LjESUaQ+c1eQDi10juQq2YQPs3ar?=
 =?us-ascii?Q?QIlHPHBwYJY5fA7zhDSGc4WiaArxxBpq8RQYKjagYrH9yM609ND4/Xl//zOb?=
 =?us-ascii?Q?W9hOO4w3l5lbo8Ln/DEKTytmkPv6V4CIIgecoXmF/GpfkbyM/Aum?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01be978a-4e63-4a12-5cfb-08df4bd5cfc3
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:19.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLWZ//oFojfcDMPs2nFH2+/NQi6J5zqMoGl9YpXB3ajRT6zvs2n7GKl9y3blhlEBAZKfAsEUWAYRUs8gC37o7iNrbung7VrpvhegxezYlE5Kfr7q7AIrl5wNrGHKT0ef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25196
Content-Type: text/plain; charset="utf-8"

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit bfaa60be647842cece968769f208e57fa5dee594 upstream.

rz_lmdesc_setup() invalidates DMA descriptors more comprehensively.
It resets the base, head, and tail pointers of the descriptor list and
clears the descriptor headers and their NXLA pointers. Use
rz_lmdesc_setup() instead of open-coding parts of its logic.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260316133252.240348-7-claudiu.beznea.uj@bp=
.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d10511edfa50..531515b2719c 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -460,15 +460,12 @@ static void rz_dmac_free_chan_resources(struct dma_ch=
an *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
-	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
 	struct rz_dmac_desc *desc, *_desc;
 	unsigned long flags;
-	unsigned int i;
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
=20
-	for (i =3D 0; i < DMAC_NR_LMDESC; i++)
-		lmdesc[i].header =3D 0;
+	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
 	rz_dmac_disable_hw(channel);
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
@@ -560,15 +557,12 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct s=
catterlist *sgl,
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
-	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
 	unsigned long flags;
-	unsigned int i;
 	LIST_HEAD(head);
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
 	rz_dmac_disable_hw(channel);
-	for (i =3D 0; i < DMAC_NR_LMDESC; i++)
-		lmdesc[i].header =3D 0;
+	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
--=20
2.54.0

