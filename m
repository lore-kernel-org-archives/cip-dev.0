Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.504.1795708588960936951
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gOVNTSpd;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEtn2Sz3xGE7SDqbWPch7jwg1PcU52OvEZjeTJeX35xZ++2e0CKnkp96ahuqeCZMfXbpwrAXeba2SwxnePEyjOL/j994U2G5o3QXO8GnrkhngY1tPpspQmZJJdTCgwpr/iLp3YQ9Q3iXhNUm7pU6D6chlVCL9fRC21wmQrZIQ+SCCI/H3M5kGtAX+hgnKKAJ4pqI+8eQt/enswf79s8JKQeERZ1TpwzoeWtS7c+n+j7fLuQq7crF+E59rB5XE8cwUMY5iy/3+jQoU4iiYd9bl4xEy0RTZ2SRxs1sucspV3KADXG9MvC2/SOuOifUSDANFQyh3QejfM/Ye8ZqNzyvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gywZ1COEjN1E0/vy94+FNKhawT0QbWFQOfEmBNCa6k=;
 b=uWRjn+vpMZQF8+tyF0IKaFNXe8weZ+cl5vQ/z0w9Scmf2tRjcB+EhOTKUwR8LRZ8rdzIkqxV15diFfOWI6r9YQyo6xB5shJJKoQ6yQwBwzSLJx93s3dOZwje3fBewbeyYBTFto+0KonaA3bK4ib+5SuCIrB8JzdpCv7jisUPs5wm4p0+Hvc9B9SY4GlWEovv+peapkozDXqnD+C3llqqv+o+00zNEkSM18Q54x4FMaLqGb9+gWvTbgqkZ/42LNz8cixAPrdpwHRj/XV82/EdoYWENl90RgeciRjWmkxaa3AGZKQAb7xzNvRgHE6tr247Q+NCNSEwpit6iRFyu5oKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gywZ1COEjN1E0/vy94+FNKhawT0QbWFQOfEmBNCa6k=;
 b=gOVNTSpdvuaBrGfuBIDz48MhRi2FytFHXG3L48aq8rm6GTh+CoHpgCNtqAz1azHYwmrO0EtEMx5asWm3vor4pa/HxBG+OaQVMvHka29GcT/wkhQBZzHYQ0LAokghNJmqsAtVF6jG9qmccn0gKERCIeSh66nGp7dE56astcllNc0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:25 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:25 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 07/23] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
Date: Thu, 26 Nov 2026 16:55:29 +0100
Message-ID: <20261126155545.3834937-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f305afe3-9fb5-4a1a-732f-08df4bd5d319
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261026121527099003|261022075727099003|261009221227099003|261009223027099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aXKUSRHhlcSB9Rno07UFy5GU5g/igLQQCkvwb/ZrFI/nH6lSb/vgOZxw5R8m33SBXWqc+/NJ/mVqQvPMYqNIGdcSMQNF97NMWK7o3m43M+KjvQB4HQt0VhCbDsqLbXbtHNZN9OsGGfQZmBt0A9wzscRD3B8ZnroEh+97aLqhk+V7WwvrCC+Lx/79ZPPyaBTBIGN3HZ1QkIKRz0m7a7K/3E9iV9nnd0xZ3gWCQfJJ8T+9oUbKoIAoZibNQ/LCNB1dVhCrU9ZvSvV2AL9ZlJ0G0rcaICD6lv1oMyCviLGem2ceuOK2bZ/Igezz2ryf6dyWJCzBaBIbdkacL/djk0aXBRrYJmI5JhHVTgRzTJsjojOoPupyVF8RS2lpXRIRg9+0sK7a08C6Jvah60CyyJOdQ62YOMmoMZO/nfEndDeatIGnd6zt9q63KFOx5KFHaO2SltkXQBHGOpn9xeiNrele5ZTVYi0MXQ/2DdWaKkJLbYNLAhsNF4dFvPfWmD8/CQdHzq03OQAJB9gVT+WAIeD4qdSQvbjjU+YrmVDrFTvLc21iMxaqFFYQcOR5011nP7hgdX3Gj5wuvziUW3znPlRuD/oRN1yXnZsYIruNrojrtKaIQAv33Kd6TrGOoRNbbWtMHHLMa47t96zL1dCE3Z1mm1qmmpRgXGIGbfkZJXGkpzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261026121527099003)(261022075727099003)(261009221227099003)(261009223027099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h9mbKuByTx5AdxlAG+rgGMtfORAnbUsR+GhzeLVF1qNF4qdkenc2NGg5HlWY?=
 =?us-ascii?Q?0o8S56fLq4gboDWuNI+PInulfq/xctTOlDICj/33dICwWNGoFIvdHGjGCafV?=
 =?us-ascii?Q?dG8iqlTB4dPgfWqEQ5n/dX91T7+I45vFr2wpszRRa3IQRNELOsV9E4ny+b25?=
 =?us-ascii?Q?Ckg6KoCYSjiThgK23lQXIPndjIozuRdiQt6AvetvzF2Mw65p8bVJH0qj5Jke?=
 =?us-ascii?Q?dBvdgGjtdyPhJfRiGAxkz5pBszK5jaWID0o5+0xoaG3H3MpmdkvJ8pAq5a9a?=
 =?us-ascii?Q?CVN7600qTEhEzYqWcsvwVa3me563DQc5IPQzTMK2ZFciJMvFq97kuASe3rJG?=
 =?us-ascii?Q?tvcRGpwsLdDEDFBp6tUWYL0ZMzWeXJAs0xjI+yOS6c0BO62wH13U43aogUz+?=
 =?us-ascii?Q?6kS7wdZ4ONNGRUJf6AAe1QgIBH07sYM3O901k3KuXDVIjPfvkLYfnrH3fVqh?=
 =?us-ascii?Q?wqJyWQMf5l4dOmxy6gL1NUm0OwA16b4Ja2tU+2tDfYxB0H0aDZPUXA5bShms?=
 =?us-ascii?Q?PTP/N8J/129XtzQF2J9awuq78GDfBLfApPCuk5SI03Z3kMIvHsxBzBjebw8k?=
 =?us-ascii?Q?RDkU8MmcDK1JlB8ixbBCGBn29J16Zd9TDiIiFPsnkcyECfoLyHlfATHNQmvi?=
 =?us-ascii?Q?9eim/RkXTaaPbdQULkTG1PT77U/SsIXIPPM5bE5PezPzZViSqAF8FJVwVLdZ?=
 =?us-ascii?Q?uhutcqi6nxfPmA4vZclj44lLl0TPH7nJ440jFz/zOb7UG0GyFlYMWcbtrZaL?=
 =?us-ascii?Q?OJDZV8qMX2z1KifVzalhnmyUckS0w1u3PDJ7hE1xVny77Wd7OUhYHop5fv/p?=
 =?us-ascii?Q?vuqCUyin4CzmtGbumyt7mkGniibgb1PJ9DLZ/teb9io1Xud/h9SpOEC2I/94?=
 =?us-ascii?Q?OKY+Q9EeXeczwzy7JTYyjwE1DjK0nZhnOtHI2weChr6DaqlG269xyDDwBM1B?=
 =?us-ascii?Q?O2wosn28uPs6fWU5S+UTMg/Iwt4pp3fW2Mg/vNOexHx5snrYHCTM0U1swV3p?=
 =?us-ascii?Q?VaW8R75Q3iWIQr+LHtQU391WsHbsZgrxD0zQvsqG6CQJB3OtUKnaGJu+kIJx?=
 =?us-ascii?Q?5DIkKVqfG+NYgfsRVhvDe5FvWz0Sl4h69jFOptdBaz+PmDfnRXwmp2eZFXSy?=
 =?us-ascii?Q?sz+sO5J3pKvLIuarrwEPUxVc/Twy3mg/VgkX6vQJjeGn/+4sB+++Rx4WUjGk?=
 =?us-ascii?Q?tZRSXNSWZFKVdyC9ObBQ3+lzlZe4v6NgF4Fok0o9813HiqkPXdYZchkLd2YZ?=
 =?us-ascii?Q?j3cvnLBkPKvMajD02jvR5p23ukE1ClOS4n4rrODtnptYRQSWMT0uWGiBS9f3?=
 =?us-ascii?Q?if1GT96MSi39c4aP2zV/83aCaV2Ie8AXXlCA8Is2em6V92eqnF7rAlci71Bz?=
 =?us-ascii?Q?JfvjgFxLpWgwrY1xTUxEB24mFz8kYbqI4IelaAAAXyXxKH90LmUthG7gRyjp?=
 =?us-ascii?Q?PdUjjV2791EmlZotbOVVsHtcVwlsR2D8YWv/ADX/RO33b+Ct7q1mVwlTy2fl?=
 =?us-ascii?Q?QZnXiZPCwc0LOoGFSPIwJtFM0Y4mDG/kUR6O5D2KptIu8CDVI2McpdNPOJ15?=
 =?us-ascii?Q?PdTDPJyandOlUSoXm8H9wbkxGxEFcyAaMyPSlPYuMKnOGJAkSJQ5vV3Mq7vz?=
 =?us-ascii?Q?L4yXtqS3X2jnua/2fSGtwCfebC+K3mKFxJKcHcG0VIHE78QOf55RWgtH5qk3?=
 =?us-ascii?Q?EOMvoanQivBY1dELN8Nw6K9Hsfoct/u/amybrVf8fukGTgzMHG6Uc2ueJMTh?=
 =?us-ascii?Q?SiNev1xJBkYXXgVXCIzkW66juo1cwM99PcHpm9n+ro0lQLFnLHXw?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f305afe3-9fb5-4a1a-732f-08df4bd5d319
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:25.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgBCGnEgfDFIufhLQNrpY/BuoPZJ4WCy0Zz8IxuuxVbx4xMZGUIZCDsNZd2jtrHabvEV/I+2Ig1BzVq15fV6M2qsrtjbTAH6TUHbRD0CfRTROwKAn5/IOiOcMIJkUhHb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25198
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

commit 44f991bd6e01bb6a3f78da98eafa6d2a72819a2f upstream.

The RZ/G2L SCIFA driver uses dmaengine_prep_slave_sg() to enqueue DMA
transfers and implements a timeout mechanism on RX to handle cases where
a DMA transfer does not complete. The timeout is implemented using an
hrtimer.

In the hrtimer callback, dmaengine_tx_status() is called (along with
dmaengine_pause()) to retrieve the transfer residue and handle incomplete
DMA transfers.

Add support for device_{pause, resume}() callbacks.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-9-claudiu.beznea.uj@bp=
.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 49 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index b518c3d9c00f..2959bea7aa3f 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -140,10 +140,12 @@ struct rz_dmac {
 #define CHANNEL_8_15_COMMON_BASE	0x0700
=20
 #define CHSTAT_ER			BIT(4)
+#define CHSTAT_SUS			BIT(3)
 #define CHSTAT_EN			BIT(0)
=20
 #define CHCTRL_CLRINTMSK		BIT(17)
 #define CHCTRL_CLRSUS			BIT(9)
+#define CHCTRL_SETSUS			BIT(8)
 #define CHCTRL_CLRTC			BIT(6)
 #define CHCTRL_CLREND			BIT(5)
 #define CHCTRL_CLRRQ			BIT(4)
@@ -805,11 +807,18 @@ static enum dma_status rz_dmac_tx_status(struct dma_c=
han *chan,
 	if (status =3D=3D DMA_COMPLETE || !txstate)
 		return status;
=20
-	scoped_guard(spinlock_irqsave, &channel->vc.lock)
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		u32 val;
+
 		residue =3D rz_dmac_chan_get_residue(channel, cookie);
=20
-	/* if there's no residue, the cookie is complete */
-	if (!residue)
+		val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+		if (val & CHSTAT_SUS)
+			status =3D DMA_PAUSED;
+	}
+
+	/* if there's no residue and no paused, the cookie is complete */
+	if (!residue && status !=3D DMA_PAUSED)
 		return DMA_COMPLETE;
=20
 	dma_set_residue(txstate, residue);
@@ -817,6 +826,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_ch=
an *chan,
 	return status;
 }
=20
+static int rz_dmac_device_pause(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	u32 val;
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+	if (!(val & CHSTAT_EN))
+		return 0;
+
+	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
+	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					(val & CHSTAT_SUS), 1, 1024,
+					false, channel, CHSTAT, 1);
+}
+
+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	u32 val;
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
+
+	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
+	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					!(val & CHSTAT_SUS), 1, 1024,
+					false, channel, CHSTAT, 1);
+}
+
 /*
  * -----------------------------------------------------------------------=
------
  * IRQ handling
@@ -1150,6 +1191,8 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
 	engine->device_terminate_all =3D rz_dmac_terminate_all;
 	engine->device_issue_pending =3D rz_dmac_issue_pending;
 	engine->device_synchronize =3D rz_dmac_device_synchronize;
+	engine->device_pause =3D rz_dmac_device_pause;
+	engine->device_resume =3D rz_dmac_device_resume;
=20
 	engine->copy_align =3D DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
--=20
2.54.0

