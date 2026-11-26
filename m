Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.286.1795708121473175353
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=P9dwlvnO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.11, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7Y9n0GX9H8POr6SxcRpxvj8Sc+CdbkjjV+FO+YzqyhHX7qrvMUncXESwOLVeXMFBrDEK8KxjAEaXTCd9zrDFXauECmil4SrDJOM+WbLHTgDNseZQy1xh1Vn/wxQSTD6YUOW6xcOu+IBu9zosvrXc37FSC4HcZ074QFpZpHoC6ljT/Joh1K7ELYzyVzwQZe+++3d0pLFZjEHtXuFpNdKC605LaIXaMV8N9rUrneHM/y5rcLhT8SfwZdqM29fI+482a8CdCJaa+LfBzUVweCcuPxbH27o4sLDpfAgi/bSvWzr/EHuAQUzakgV63Ik3JC+b58IeTXVBJDa+Iw4hXT3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNu0MQUrEOQF+5N3rOvFzQl9IXtzDEScazBuSnZ408o=;
 b=g04qr5P+7/dbxsUzrX0fisqHWBoerp+0eQxSxziR7Y6LYdrXoH7k6JIrMI277D4DwQAzQWLYC07Y0OD6IyDMbDiW4qJxP0D/OZALZ0qOzdkBJPpdUL+hI2TcdZSbcc/65gpZYWsamjokXjNqRbUmqiOBZ0bZhzCM5cG0TLucp2S9hhVtdsocR02T1szeYSZTh6Td32fjYj+40BciXcNVI2DhyE+jQvYmapQMWQpXwmOtOZp206kZqLvmWpYsZJB1MUdKILWtRp/aqmuACf+xTD8CVY3egLVDm73S1OzTt6pxxNVPxgTEgpCrsf3AhYcnLNDNu6yoe0vs1j9zUeCf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNu0MQUrEOQF+5N3rOvFzQl9IXtzDEScazBuSnZ408o=;
 b=P9dwlvnOAPeiSxjoqEOz8Yss281QCOspTv00sr/BuSnUZkwKQEHXNN3du9CxQwFi45BFDuFOFnA3WxULme1LBgx3dZOnol1DpLhd39ULCQQNPTbhEDU4ruEXQJ7RBrQPviPYKumm5cSo5UugKAR+ni++czuEIE6Tqi+/fJ2j7GU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:37 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:37 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/27] dmaengine: sh: rz-dmac: Use rz_lmdesc_setup() to invalidate descriptors
Date: Thu, 26 Nov 2026 16:47:29 +0100
Message-ID: <20261126154747.3832917-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB12784:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b1b15d-9656-4d06-d839-08df4bd4bc05
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5AJehHvGFOFCu+GxY5fc0e6aheisr/V+HzoQ3fGtNdeyW8PUTXMqjzUCd4v9xRf7hobFy43tMZj6Zivv0/u9fGCAdSpEHl4tkIfP4d4rA26NIVoN/eMtzPXA+r2G+pIGMFlv4qiBnm/7B1CMAMqg4KsIe9Oh4Yo05BrXbcGu4XGFj1HNIA3Hpj8kvA23N56gwpfwIKarQzwJJ9nVchzK2KFRmF+m/dPTfVl5EMniixPPeg46icJT6W+KpvgZJIMCPUrqv/5TIjC5lVJuJSiP5cwBs8uYB0JRGn5cr+h8xmuqwgYU6Ixldi8KL7gS9bYhKb9F/gYsieiIeQmOoL0VLCX/VtDMaFjFUIz4z0pzmGjG8SGX6YEDF5ELxfTI0wT0ghsX3hd1+jKwZs8N4/OUji5bmiAOav26matTFbspdQos6RVKvYtWrmP1N+GMCN67oOjZgs6U4hYYboDDWrkC/k1HUEjMSQhfAgd01y5vkP57TMe9QTro/M1cIXRZYIroQ2Mb5UsIgFk8rJ07wiUhwbYuH1hP05irYLhugErCOPO5lpT7qjoVyVhaEX/U1gyKy9jtfeSOYpbYNESsusF4duV4pLZtP69najTIKzaE0/PaZxDbpogd2wLWfJ/N4Ecp/qm+qNgvgQD0+kXwN7LdnyNDL+S/FHfbdaXgbfuMJkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yECxk2xXs99kLfieTPkS2crL5RV4HF6Tp8K/Cp+Gmkz9PR7iZOgUoOGLogEg?=
 =?us-ascii?Q?cHYBAzS9bPXyXPLu45VqGzE+FlS57Ql/BYF4Mp8G/LYyN01rvii+2ISnpzb4?=
 =?us-ascii?Q?QCNf1dLXbx/fJTpYtNtsA2gKqHI7UvDykThSoMWV7DvV7TQgpvjU+0x4P6ER?=
 =?us-ascii?Q?ncxzq3/x/Ipewzf1Zue0Ceer4S4b7ZC2Dh7bZBuvLLjTXXCU7vPhk/HtMDwg?=
 =?us-ascii?Q?Vdn39nT7niTlV9pSJSKPUQlfC2VkuwKWNd3CIuPsb8sTkhoSplY0c0IeSip2?=
 =?us-ascii?Q?i0+FjNGLUmiljy5dARdzk9Vp9EhYisGPUpyMgYU/FPwfyPzKI/cbmp93KHRv?=
 =?us-ascii?Q?BloSsCwm2/S9lskCW+JdX1H9dxxF2IjJCOOpBoW/HXRWX2Pgz9GNK7HlF8Es?=
 =?us-ascii?Q?QzPqDU1T+ONBxue9dRzEHT+xRDwUZD3DoMcQRNZ4MMZuqE/kMkO2873FuFah?=
 =?us-ascii?Q?hkKP0xQ8rk5C+38gOTxA0wTfWAPYqJGKKgtilG3rIaYBmyol9u1dhACsCgGV?=
 =?us-ascii?Q?abP8d0N0GciEvOjjEKPElKUXwT/xmQdIPypaZ8lP5J9s1fYtzYV0QhfziJSb?=
 =?us-ascii?Q?91OV7rCrjkMCMX/+rg8fJ+yF7/sndEYNF1GtdjZZ158SjHyz1+P6LnUnDeFj?=
 =?us-ascii?Q?QfRn7Mo9FLtBpqWxRFm7RyqtyvdYOrAv+CC437HBke3SXliIlmPWVBfPihrj?=
 =?us-ascii?Q?14dSM3seLLxeuZj8Od5dF+tswL9EH/neHpYhjDKsqa1zn3IxsFnv5KFqxCdd?=
 =?us-ascii?Q?hw26fgXO1/Ay/HmvGteaBKPOpfrvA3H0J1lEtwI4UF841U1PhKw7aKwKxu6u?=
 =?us-ascii?Q?8Ng2wTRmMVVxHZUicWmxQ/n6aJCjMwS3f7fCBbNDp6in/acpVlHbOKzpmefz?=
 =?us-ascii?Q?rZhkBythMY0RbMGCq8mCfRE5rzmYD6lOg9vGjV23MMmWIt4Eci2/Kz83OLUo?=
 =?us-ascii?Q?VxkGXfWNdGsV0vps/cWgFcN0Z7q7pGDqoM0SaqyuIFbGyWPKT1v/Qi04HCyS?=
 =?us-ascii?Q?ZPyMTqUBKkpr4f338Uj63WxocEPWAKjjYLDi83ntKov3cckjMxH+sC6LRE1i?=
 =?us-ascii?Q?RCCXNUTXu2UJuTYvV66GXWIP4hIldQ5ni7BlpB5Za9oZ8XnK3MnZLs8ayXii?=
 =?us-ascii?Q?WYDoDWUk/8Ew9t0Q1c0VcAxQrzRmr8BLU2HHmArO9eF6Q3kYLSza+2MhtK5+?=
 =?us-ascii?Q?XwGig301pIK5ohn91NcnQLybW6Zgum7u3B2etEpPJD5cL4P0E8nETcUf09Rp?=
 =?us-ascii?Q?kYiGOrwzCRnixlwV4SAsckKXfg4G8zdb8YVNdeuMimDnXpld8yQCYPz/bgwy?=
 =?us-ascii?Q?A3XLg22AbLoKuwtRIaSHHW68BZDwoWp8AirBG0rhv548QY4vzJH8XEeWm9VU?=
 =?us-ascii?Q?jfsOXPtTrO7zbpB+VOKQf+Ifw3+Pp55cD8DHhUzTp1pEN2B8Lc2m/LALgT/3?=
 =?us-ascii?Q?W3aUTZ3ahbCanu2HYKvP/Ab9lIVggTC2RsaHtiq4/TJ642/Xh+XqIT1u3q88?=
 =?us-ascii?Q?TWxtbbIV9ejSdi0OegJJp3zeExfdW0saYOZD8UITcm3BFB+xSIRPkobRvEgr?=
 =?us-ascii?Q?ppWfuQmryupMGZjEbnKeOutukNpwModcQKZ3Q/k2D2EQYrdRsUsIbhoYlaY1?=
 =?us-ascii?Q?XLAxBJ+liPqvRn+w25ZSi0BKr8hcZAELgPThTzeg1QpFmQipzflL3DH/FGVC?=
 =?us-ascii?Q?lFcCJ+baK/ISZecx0eS33MNWzS90eEKMwh13tY9KAwaj5A3bK2/xeFHarkc+?=
 =?us-ascii?Q?E/MjaO9sxFfRAGPls026Cx/vwzzFnX3dB2OpTQoLUxT94rRLxtJa?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b1b15d-9656-4d06-d839-08df4bd4bc05
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:37.2269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMnnrTJxGKmQe0O9Ad0Fb3z2m8WvdhvtUth5ufDGmrC1xumXSExkkWWk2sDyK4J31OrryL5MOEiisgBNCASnaD4wc5hy83WBuZREhEJoSbZmD6jgv+G/R4rnTY7nfAz4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25159
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
index 13d964c0b126..b4ec34a86f91 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -459,15 +459,12 @@ static void rz_dmac_free_chan_resources(struct dma_ch=
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
@@ -559,15 +556,12 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct s=
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

