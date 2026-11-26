Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.500.1795708578007463285
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XqkQ41/d;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.0, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7NioFnR2TED611wI85AqsKsXCxB5/m1GOOI87Nsan0RSnrgfaFYI0TAQaqmY2PrOYRdcSlLr4ckLfh4Uw/qDfKvzIXBz6KLdCcT8/O8kABILqVG/YMbBrWFZz6UwdNGR+9yaDrQTYj5VN3ssAlh9xYyMrVx3PU8Ds4Pe6QF0LNcd+lFjBZMDUOkfjXhVLQXsVhpobMdNMfubvsLHYwwg/W9WrsqE1iN8vixUHvXcdxsWQX2o5eBdUD0t4C6ceF25ZWpQrT7WbHOIqib06KudJyEwd7Ej52GjPqr022PvW4L9Nt1qKWK5E96R0qIQwHI5k184U35iM+wkou1Nfa3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlC9TFfLbSzSjqkHl6plZe8R7EXbopn/7KoPuVK7fhE=;
 b=UMCXz41UboxSSZs7Zxkn3TvS3tub/r3wVSoW6Wi66UwF4hxA+grUbzXCCTm3rZbye1o9cwcwu0k15gMFov3BYpwvV2IxWDZBgtCDhatAKtBxpzaioylm7nP2Oz/EokUhUltW7u2bkcDDNZG06jURM2Ox2/HKeCDPc22SWzhNB0m/A5d8zbDuAUGstds854An2HAMJ0rJPjLibOhn9fzkdNeo3/fX1LjIpupbO3NBBG44LqFGtAkeT4uVwix538mcq8s03W1lhHPlXUU3Bp0Z8PEgbnkJex532BlU6YEG/0/tlmPiYIjx4BGiyD6XIwB2nGqpu0ipaIZhJrKfWyTk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlC9TFfLbSzSjqkHl6plZe8R7EXbopn/7KoPuVK7fhE=;
 b=XqkQ41/dbHQgN2FR1JYpaQ6DJy15nBa53IJ7fNVXhJkWjs0vqVDCxD2v0w8Mu9fPyQpsYQnzBcmuQ/KkqT8lA1/DmrvLmS5xymlBrmvOLdghiaIhNfhVWhtlW6s8kXI1kTlialrEsAepYSf131V/uvfzFhGlX4oV2eVra1rf6eM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:14 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:14 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 03/23] dmaengine: sh: rz-dmac: Drop goto instruction and label
Date: Thu, 26 Nov 2026 16:55:25 +0100
Message-ID: <20261126155545.3834937-4-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 71c88473-208d-43c6-9287-08df4bd5cc9a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261026121527099003|261009221227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9s0rVEadQcPt35GxSXZT7hN7a88F4cmsTxkVLPYGZorb1JgP9U9ZQ/Omtd7glQQGKjZlhm1Eq629mLqDIFpZRKaiHTqrAVUN5lKodlSp8Wu5vYmkBkAfTZ1Q05wL3S5rydchcQkx+7tM+YxzzXwH3A/nmVnaWKyOfwwDULvgmHDndbULPK6b+sgLkNPelfLdJfU4NeHDO3zKuf2gnXFPtDxc4sgk1aQJmMecRHdZv2Y/8JaCbdFqIvlbfQtwCyG39nTzcAPaS9xpDzS5C8iTKJndS0VZUJYPHxfvzcG1cIHNyP1QEuhukFZUXMkqnzafr5qYETWfK+5FB+mXK9tgN2qBQZDeSFZDnizXhaLhq5P52jmiw61lTFozprNKsLqDxaSufNiBfT6O5U6YXM3NXwurWAa5D5dYSzVB+J85XiSl6uEMOqbVo6cEf3/dz79FkTxwTCdg7VsyAqBcOBczYMHwowYZ3JgKE8s41idE6VZ8G0d30cbbrE/YLal7EiDbCDBdKVAFEfYaJXd1Feo9nds4e7p7ttfJSm4F3v6l/g+vSVvWXVz6iRhnw0LO8qBuYLuZo+YPj/CiV3z7V0m8fiiZ3mx37U7aQIVtULLfh8AtHqlvvZwTs1iE/HM5tU2O/UwqNDd6ywvFKq1WlY6MofRwVslh30MY0t2C59+ma/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261026121527099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PSdqyrdQCvFNWiLQquqNCxjeJ2c4a2p1yaIL4lFt9rkMLMscljQTOtpxW85+?=
 =?us-ascii?Q?eO85uIkpqjvchoNHhfg2JpBqYWoIIcOEVWj7WIwEJfyLxnbC0NdojPsOHKXD?=
 =?us-ascii?Q?TERZ27Lm2qDZT/dXtNqU6Z3vCdwyYg6Gxdv6yIaAVGuh5ozqEpZjLR6y4noC?=
 =?us-ascii?Q?Hiwl53WaiUrn+3bJNE8FYrnGrWqdKdk8Tsq/og0wTSHnv/v24QnEamd6PwFw?=
 =?us-ascii?Q?Z2PkjjFRYRoVgMWpZhoLKv4ZlgPw+lACrxmBf/aGu1Ha014QkxAb3X9u6pLw?=
 =?us-ascii?Q?OzUQX5rWuIPZ3ONLrjVR18LD2KOX1oR1W68u6C8iojQI4MoUoplarH6HXfKh?=
 =?us-ascii?Q?eCSFt9RDXaSsuQMFqSkBRHUZnksw5JNkHGd5NE/IDA8+P1k4eatKVkZYdfBo?=
 =?us-ascii?Q?SJusItw8s/voXkxBEBFx6tz5r76Ay+6ko9MaKkrvtoLpDvIoHhKNPHBX2omk?=
 =?us-ascii?Q?tg5tBVZMBwi3XBL04DNN1ZPJrCQfWMTkHwqunY0R1GoX2UanBDW4hsqrOOjp?=
 =?us-ascii?Q?B6Y/NkZ7O/Lpto0RHHo5OV+TYFXYi8dM6TWTx0UjqtpXXUDshCAZtLIK7mw9?=
 =?us-ascii?Q?hecPyzbkyPLBujQj5AIDucXHh7TsZMRErSS9vk8tQLeq1LW/42aLSp6IB2WK?=
 =?us-ascii?Q?lU7EamvTCKQNigJmkkEowoZVTB5+vT135piBgUo1HhhrYf4FZJOnIhfauYs6?=
 =?us-ascii?Q?fIPSdCZGgZ2n0457Upcvz7FPefVYUHpkXBXl4nxz0U3/6DmWxxrfcBheEPKz?=
 =?us-ascii?Q?HK+Lf+6r6CGCYKLT9rtgrf/fOQWMr3HzZEa6jOwpgmHG/M7GwWtKzyh0QLRR?=
 =?us-ascii?Q?lSRRjsesF87JYIQPuNkLm6lch+5TVXy5xBZoTJza/wGEeiQIK3JydY90AMAB?=
 =?us-ascii?Q?r7iwh71hrIMLEwKgVWxTgwt9uryX8YIH05JfZnp8q4XfC81GuMrMSw5aYm4y?=
 =?us-ascii?Q?DKR8OlIYv+yg685EZGkRwTTLr6tUyIswHpVPh6IAcTd+c6E5rCWNcmiatrlb?=
 =?us-ascii?Q?Cd+tDTsOk92+64IzBqoIV7sGCOOAhiRShF1v73WCChSmECrrOazC1FNGMr+6?=
 =?us-ascii?Q?h6WZa0ug3S7awqnRTMWV4Bs4cbt6FaX3PvU9Nv95McgFNwYciR+Oic6gLDh5?=
 =?us-ascii?Q?TnKjli/Jey5rcytuWyEJByIq0rCSXvd0rlUmt/BheOF5HYhJHTh6YFudu7ac?=
 =?us-ascii?Q?uoGXuYBKN8wboxoWVPsX0WBjjbPLolfrJFpAPORo5OAdbahTfWOzv9rd3wBx?=
 =?us-ascii?Q?825rGtXcRZqnygEE4v9SjwISFIuENIuYtA4G2XTJFWqlgkvD0hNblFyBPrTe?=
 =?us-ascii?Q?uILm5COMj3CJhS52MVmTyQdSq/xlYBiQYc23t9E8k+2o1iji1Bi8FI7lL3zf?=
 =?us-ascii?Q?rvKWNE49+vRhP4gQ4f60zgrqzOFRD9UTQ/3uQHjOZrgoxlBjkFuJhjW1dddJ?=
 =?us-ascii?Q?pgXQcwN4ljRcJyxOUA16+uFA8pJZJ/89fUSCvdvW2agzUZChurAW1mLOoKQo?=
 =?us-ascii?Q?t9mTaJRrqA/2/4vnV2dh6o8kBr1W1EXfIGuB/BC04vB9osWIHiTO+gMJylgy?=
 =?us-ascii?Q?URu/VuOOE96BSv8c86eL+boJleglGtgTAZVBzrBaed56fd5jXCsNhAAJxW1v?=
 =?us-ascii?Q?m/NberSLhCsryJ2NRyoUbkMoiw6KqcJ8sav50OixJoAcH06h+V7b6fkCxbZz?=
 =?us-ascii?Q?4iqkkWGbSlYHVAmQk436frsmqrGcFdHuhCBHQ8YactO/rKjBiAuXn+Qefe8B?=
 =?us-ascii?Q?eZceoduQCgNQxqkC3b7h1IiSxvVitv4Fsgn/AOaEaGBTKaRm7ap+?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c88473-208d-43c6-9287-08df4bd5cc9a
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:14.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP3zfCecwd4724UOu6x8v8BsYH0P+58x9anz8o9dGfYIBt4cN9hL3FG+CGEoRYOg7X3yGSX7uRQn3nzzoV9cJMko9D5iof4gROZQSODr2wpSKceTnECmhBbTES465V5f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25194
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

commit 7badd294fc82629378b153327c57b8ba453688c7 upstream.

There is no need to jump to the done label, so return immediately.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-5-claudiu.beznea.uj@bp=
.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 49603a03400e..d9403ec2fbbc 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -705,7 +705,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_c=
han *channel)
=20
 		scoped_guard(spinlock_irqsave, &channel->vc.lock)
 			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-		goto done;
+		return;
 	}
=20
 	/*
@@ -713,8 +713,6 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_c=
han *channel)
 	 * zeros to CHCTRL is just ignored by HW.
 	 */
 	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
-done:
-	return;
 }
=20
 static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
--=20
2.54.0

