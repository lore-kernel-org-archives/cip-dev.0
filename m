Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.297.1795708146113469528
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:49:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vErS8MDS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pghvl7yQ4EJu3KLH3t7mHjPC+Rucq7mNEqts6j0VP3FVHBVal/GyWtRQksCKpoge48T5Gv1LfhJXca8pB+8VduJzAslYuZUAZxBbg4LRWb2PEhdOyKAIZM4ckj4snCY5Xh4sPRRIl3j8yfUIKD1OVhJVSDbJDLZqnHerP59dityjqff7mZLq42tb9pU/rhGRWeRQNf/fZZKeo8pIc3VxdmZRbNo+yP9sxPNxN+ScikBxC9oTZa5OusXJderkN5xdlF2MF/QY4CHjJxOTfFgL9jinV5nE8APDJj7pCzRFW5cR0LvYLHuAlu2l5gprWVP3lQNSLKzK1Fo0av/edXZVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVfJCL44iXCJZdgLRWZgGz+j6o+DWqsrd19ODvnLMiI=;
 b=fwWIk954q2zNU6O7lLVAOu/RJOpvyG9KlUM791BaDPCIN/4f4ve5nyPq7jdmw53KczxvomKGJzARWLenFE7C2iypnnGUSQlFg+MH1LIzVImwIUTmjswHEhfCUTM1gKuClgkPuraSeP9s8p1Uj5k/frAb2buzBgBTnUTeLr5CQGaMzC0ttIXAkqBSdIh2VXXquDuMjkU0ROv9aZsQM3VGACK2NW2DLz+sdDbXrW3a4UwJoSjQBRd761UvDosqu41c2NKuaQYOnthiR9LEMlLvwzKjJ/Dd11ujzbPVRGYvEYosMgHKQA/ePM893BOjbioZjWV0z0ns5NyAz4/iDbD1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVfJCL44iXCJZdgLRWZgGz+j6o+DWqsrd19ODvnLMiI=;
 b=vErS8MDSnxL1ZY3F6sMbJXKafBUl6kDdPQ33kaEQAVenMzvhpmp9Xy6f+eqCFeSVVXgHdsgSbDZ6s4mNrIMXDgdVNxEhWTtdSGCgC05xfhCUKwskQ59wpXb13KwEJGnrMlgSuVPtha0eHHuo3FvgPlsrSWlnXpb/Auf8Ncjb8Ps=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:49:03 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:49:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 19/27] dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor processing
Date: Thu, 26 Nov 2026 16:47:39 +0100
Message-ID: <20261126154747.3832917-20-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f10b0d7b-4539-47e6-5640-08df4bd4cbad
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022115727099003|261021133027099003|261022105027099003|261009221227099003|261021121427099003|261022075727099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|261026130827099003|261026121527099003|261026140227099003|261028144727099003|261026135527099003|261021135927099003|261021130227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: UaMi4h4aed1OE9ZlebpOfyfE75yXu/iN1bqDHYwRfotXGtsdCR+5KWV/LYn4DuAx4/lmk8yua/xa7G88xllcUU4MfXKKfdoYzlQ0tXLrijFp/pksEMFtFLR3Dho//ga3VKwm5rDQ5flE9/Wps+Fv7nksJ55yCOBukP4Fd1KhQ9O9l30b6bY1BuaIorGudNT6NHrRNlhd1k2Har427siiF1HVUXoJzDQFYmk/K4ORlZ9xBKBlEBdpk5AvDWSUvT8heGlgfzCHm2XbKY06maZbYJkTEnpLvaOiG1uznen20OS7SCHASVbm9uHlKnI8PTRn2ROZyQAw/b6sywI+fG0lKCByNkRkLZbti+blAppW3i8u71WBd3hBvt7YwMp6Re7uhOr6g73QqL0TadptEJCbD+22Wttmj0ljtnPjok8vFmg2cGXernAz4wItFLzq3CJMGNaCDqBnhOk/fQHKrNan4OdckTH9VFeJdAKLdQevoBnl797D3en1Lbsf/HHM0WOZBJB2+u/7VBo0P5zoXw5501Q0n6GY5RJLk2C5/HMG5jvg3kZttE42S9CUnoUZjL+CyK0P3WeVRorJIVwytXz3S6C0X2i1LDNeuBGHKrQYhWI4Ut/PB85eJSEbzJEP/i9tPPyT/sFvK1IfKcNjx5AZ4qHZ1LulZ6kLTrcdHTt0+us=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022115727099003)(261021133027099003)(261022105027099003)(261009221227099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(261026130827099003)(261026121527099003)(261026140227099003)(261028144727099003)(261026135527099003)(261021135927099003)(261021130227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQAN8ohRAK3r8cdQCaL9AAyV9/1V4bBCwtr2vbrIKwIQeKjYbcY0Hw5FhYwj?=
 =?us-ascii?Q?JKJTUjpPG0m9mlAnW95CJVkQG8Nv3kqMQdMRnFakvrXS53vKoVTZsN/+f1cz?=
 =?us-ascii?Q?fyEaKOWd46fW4Y//9qqePeGhkukLOF74wSglrF1+fQAyzTSmji1FTBrIAhz7?=
 =?us-ascii?Q?ITPSJ7QnJ4nPuWh72V2pHdbc0BPIXrFkbFQJBE4OPkfWM9YHSsjtpT6DGbtj?=
 =?us-ascii?Q?VjnqEfU+3PRnfrplgR6fT9HevW+Vft8gNjBcbM8NI30Wb94GtzupYwjXklL/?=
 =?us-ascii?Q?2qBSfTQClR3sKOuxImjxASNTLinRn0L1ey10B+ZEQ0wW7pl/z3Ouo+LBNJ4h?=
 =?us-ascii?Q?XF24WZ1au1M20veiqABS9e6vUfZKYXin0BCQg3Mxcg7lXIxt/yW5HEtmlOh3?=
 =?us-ascii?Q?Z7famKKhTrog30cKhj77ROKKLIfQUcXCgiE/xWXmYElWSTBGisWImv71qSc0?=
 =?us-ascii?Q?8GXw3HJ5lXnSxatVZKixJfbMfftjamoHi+zD70FCjHDh0w/84XSTEdyuZvMN?=
 =?us-ascii?Q?gRuYoeqv7P85hFWl9Xxa33UBjXz+cCDp28Z2pBBiqMRgsu5htaRU6G4WgTCE?=
 =?us-ascii?Q?M9QYJqC+gogp9t2y2yy3CT3SaLCyeaqZUDGamm8Vb5juB/9u6HyWSyCJzLga?=
 =?us-ascii?Q?XsmLnWUbThm6TyhihWy9vSIAPGfnmXsgQe6/8S84IT464JXVSvxiBGBUfaG9?=
 =?us-ascii?Q?yXgcoq/Snq4UxJN2I3scxdZPlpftVkCx9nbU/xfj9xO/3eHYJen7P47JRFaU?=
 =?us-ascii?Q?75991AsD96eE/DvYtAax6BzBD7vDP2mheSImY8k+/Vj/bZdI77hxY2LvdPvr?=
 =?us-ascii?Q?Lq+C0c+7T2Gl8xoB+1PD5VTFgeuMPueabrStIbAykYWmWuGzB5sYRekohkLR?=
 =?us-ascii?Q?xrjr4er7cL4xFIYd0/atyWg/isXL6V96aJzKy1j+Vnd6k+LOqI5K4Ql4Jiz0?=
 =?us-ascii?Q?69Au2jd4W/HhWoCdxlSYrNAjV5xbMBPtA8JUYpmc0hqDB+RxQgGiq19I61oB?=
 =?us-ascii?Q?GtqmbnRHkkCfbE/6CnurFxd7iSkS4MNLG3TfLMVyefptlnNbbGJGNX06E/mz?=
 =?us-ascii?Q?vktLplc+evjnvark/lyrrBLkxUrhJdnijjI4vihPoLFwHmVSnh6WSLjReZOv?=
 =?us-ascii?Q?PN15DP1AIBfhcCPurGMuhfHaXcQUXVFKXz5TZ8AcBE0E5mz8MBpWGnKowCTc?=
 =?us-ascii?Q?8qOxa1vd+tr2V91UcwKPeyzmkaBW6vHsDHShur4IDkao5z5kdLs52NHAaQ1K?=
 =?us-ascii?Q?SxTBozaGIPlOaA9GTCgLjTmdvIj44zIYAZBra9H4VWbwVy0MqNzB5ldYxyhF?=
 =?us-ascii?Q?zbXqPiTJyAh3WjfIkCb2mlL0HKbvW7HOUsLS+iWtM89yeE9vq9lJx9j6k0hF?=
 =?us-ascii?Q?avj29GU5ZcrLfhQaRSWfSMeN7lN0Yg8McYFUh9lfBugLLtywcC1tUrH/Rp0U?=
 =?us-ascii?Q?R+Nukx8L1V/Rvz7y3PG6py/hNFRbk/FOCkDb/d3ighXBvxX9d6XxE5jsQFwb?=
 =?us-ascii?Q?LSlzp/jx9p8+kuVf2FzMmO5zUN7y2m+IpWfqfxRxY3XNNKgVyS1nfcgLzOO2?=
 =?us-ascii?Q?UuHtsTFZ40iho91YsFirA7diUqinITFrMST3/S/yOVC6e78Di5pAonfLa7xC?=
 =?us-ascii?Q?DmpSlYQdOG3ToLSRzEfV3YeUYoU7q7WUDKRcwX5srzcnHVLDA8hiFAn0rjrD?=
 =?us-ascii?Q?Bx0P37Xa67P72OM6ilaE2yv5+/PnPB/qTYo+6lMEzLpDsl/Xpti1MxEm2a+a?=
 =?us-ascii?Q?RCMxHv4FmIggQqjbg1pYEveBkqABVScHYM6uoGstrfRO85n3SUfw?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10b0d7b-4539-47e6-5640-08df4bd4cbad
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:49:03.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WX2fwsc5ilFzEytXi8/zoQPRAiEYuKi2nqR3a1zri951vxM0lvvBHUQOxDzE3OvBwR5omwWabHixjtG331Jo+2791XrvdUJ+PE8gujvDxM5uEfyCQn0bbP+RbUMuJRhN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25169
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit daa6d4617bee722e83f7d8584416e83b709c958a upstream.

The driver used a mix of virt-dma APIs and driver specific logic to
process descriptors. It maintained three internal queues: ld_free,
ld_queue, and ld_active as follows:
- ld_free: stores the descriptors pre-allocated at probe time
- ld_queue: stores descriptors after they are taken from ld_free and
  prepared. At the same time, vchan_tx_prep() queues them to
  vc->desc_allocated. The vc->desc_allocated list is then checked in
  rz_dmac_issue_pending() and rz_dmac_irq_handler_thread() before
  starting a new transfer via rz_dmac_xfer_desc(). In turn,
  rz_dmac_xfer_desc() grabs the next descriptor from vc->desc_issued and
  submits it for transfer
- ld_active: stores the descriptors currently being transferred

The interrupt handler moved a completed descriptor to ld_free before
invoking its completion callback. Once returned to ld_free, the
descriptor can be reused to prepare a new transfer. In theory, this
means the descriptor could be re-prepared before its completion
callback is called.

Commit fully back the driver by the virt-dma APIs. With this, only ld_free
need to be kept to track how many free descriptors are available. This
is now done as follows:
- the prepare stage removes the first descriptor from the ld_free and
  prepares it
- the completion calls for it vc->desc_free() (rz_dmac_virt_desc_free())
  which re-adds the descriptor at the end of ld_free

With this, the critical areas in prepare callbacks were minimized to only
getting the descriptor from the ld_free list.

Introduce struct rz_dmac_chan::desc to keep track of the currently
transferred descriptor. It is cleared in rz_dmac_terminate_all(),
referenced from rz_dmac_issue_pending() to determine whether a new transfer
can be started, and from rz_dmac_irq_handler_thread() once a descriptor has
completed. Finally, the rz_dmac_device_synchronize() was updated with
vchan_synchronize() call to ensure the terminated descriptor is freed and
the tasklet is killed.

With this, residue computation is also simplified, as it can now be
handled entirely through the virt-dma APIs.

The spin_lock/unlock operations from rz_dmac_irq_handler_thread() were
replaced by guard as the final code after rework is simpler this way.

As subsequent commits will set the Link End bit on the last descriptor
of a transfer, rz_dmac_enable_hw() is also adjusted as part of the full
conversion to virt-dma APIs. It no longer checks the channel enable
status itself; instead, its callers verify whether the channel is
enabled and whether the previous transfer has completed before starting
a new one.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-10-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 233 +++++++++++++++------------------------
 1 file changed, 86 insertions(+), 147 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 0ba6bc545e61..e6eeb4fa55c4 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -78,8 +78,6 @@ struct rz_dmac_chan {
 	int mid_rid;
=20
 	struct list_head ld_free;
-	struct list_head ld_queue;
-	struct list_head ld_active;
=20
 	struct {
 		struct rz_lmdesc *base;
@@ -298,7 +296,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *chan=
nel)
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	u32 nxla;
 	u32 chctrl;
-	u32 chstat;
=20
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
=20
@@ -306,14 +303,11 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *ch=
annel)
=20
 	nxla =3D rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
=20
-	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
-	if (!(chstat & CHSTAT_EN)) {
-		chctrl =3D (channel->chctrl | CHCTRL_SETEN);
-		rz_dmac_ch_writel(channel, nxla, NXLA, 1);
-		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
-		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
-		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
-	}
+	chctrl =3D (channel->chctrl | CHCTRL_SETEN);
+	rz_dmac_ch_writel(channel, nxla, NXLA, 1);
+	rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
+	rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
+	rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
 }
=20
 static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
@@ -425,18 +419,20 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct=
 rz_dmac_chan *channel)
 	channel->chctrl =3D CHCTRL_SETEN;
 }
=20
-static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
+static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 {
-	struct rz_dmac_desc *d =3D chan->desc;
 	struct virt_dma_desc *vd;
=20
 	vd =3D vchan_next_desc(&chan->vc);
-	if (!vd)
-		return 0;
+	if (!vd) {
+		chan->desc =3D NULL;
+		return;
+	}
=20
 	list_del(&vd->node);
+	chan->desc =3D to_rz_dmac_desc(vd);
=20
-	switch (d->type) {
+	switch (chan->desc->type) {
 	case RZ_DMAC_DESC_MEMCPY:
 		rz_dmac_prepare_desc_for_memcpy(chan);
 		break;
@@ -444,14 +440,9 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan=
)
 	case RZ_DMAC_DESC_SLAVE_SG:
 		rz_dmac_prepare_descs_for_slave_sg(chan);
 		break;
-
-	default:
-		return -EINVAL;
 	}
=20
 	rz_dmac_enable_hw(chan);
-
-	return 0;
 }
=20
 /*
@@ -493,8 +484,6 @@ static void rz_dmac_free_chan_resources(struct dma_chan=
 *chan)
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
 	rz_dmac_disable_hw(channel);
-	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
-	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
=20
 	if (channel->mid_rid >=3D 0) {
 		clear_bit(channel->mid_rid, dmac->modules);
@@ -503,13 +492,19 @@ static void rz_dmac_free_chan_resources(struct dma_ch=
an *chan)
=20
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
=20
+	vchan_free_chan_resources(&channel->vc);
+
+	spin_lock_irqsave(&channel->vc.lock, flags);
+
 	list_for_each_entry_safe(desc, _desc, &channel->ld_free, node) {
+		list_del(&desc->node);
 		kfree(desc);
 		channel->descs_allocated--;
 	}
=20
 	INIT_LIST_HEAD(&channel->ld_free);
-	vchan_free_chan_resources(&channel->vc);
+
+	spin_unlock_irqrestore(&channel->vc.lock, flags);
 }
=20
 static struct dma_async_tx_descriptor *
@@ -528,15 +523,15 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_ad=
dr_t dest, dma_addr_t src,
 		if (!desc)
 			return NULL;
=20
-		desc->type =3D RZ_DMAC_DESC_MEMCPY;
-		desc->src =3D src;
-		desc->dest =3D dest;
-		desc->len =3D len;
-		desc->direction =3D DMA_MEM_TO_MEM;
-
-		list_move_tail(channel->ld_free.next, &channel->ld_queue);
+		list_del(&desc->node);
 	}
=20
+	desc->type =3D RZ_DMAC_DESC_MEMCPY;
+	desc->src =3D src;
+	desc->dest =3D dest;
+	desc->len =3D len;
+	desc->direction =3D DMA_MEM_TO_MEM;
+
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
=20
@@ -557,22 +552,22 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct s=
catterlist *sgl,
 		if (!desc)
 			return NULL;
=20
-		for_each_sg(sgl, sg, sg_len, i)
-			dma_length +=3D sg_dma_len(sg);
+		list_del(&desc->node);
+	}
=20
-		desc->type =3D RZ_DMAC_DESC_SLAVE_SG;
-		desc->sg =3D sgl;
-		desc->sgcount =3D sg_len;
-		desc->len =3D dma_length;
-		desc->direction =3D direction;
+	for_each_sg(sgl, sg, sg_len, i)
+		dma_length +=3D sg_dma_len(sg);
=20
-		if (direction =3D=3D DMA_DEV_TO_MEM)
-			desc->src =3D channel->src_per_address;
-		else
-			desc->dest =3D channel->dst_per_address;
+	desc->type =3D RZ_DMAC_DESC_SLAVE_SG;
+	desc->sg =3D sgl;
+	desc->sgcount =3D sg_len;
+	desc->len =3D dma_length;
+	desc->direction =3D direction;
=20
-		list_move_tail(channel->ld_free.next, &channel->ld_queue);
-	}
+	if (direction =3D=3D DMA_DEV_TO_MEM)
+		desc->src =3D channel->src_per_address;
+	else
+		desc->dest =3D channel->dst_per_address;
=20
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
@@ -587,8 +582,11 @@ static int rz_dmac_terminate_all(struct dma_chan *chan=
)
 	rz_dmac_disable_hw(channel);
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
-	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
-	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
+	if (channel->desc) {
+		vchan_terminate_vdesc(&channel->desc->vd);
+		channel->desc =3D NULL;
+	}
+
 	vchan_get_all_descriptors(&channel->vc, &head);
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
@@ -599,25 +597,16 @@ static int rz_dmac_terminate_all(struct dma_chan *cha=
n)
 static void rz_dmac_issue_pending(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
-	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
-	struct rz_dmac_desc *desc;
 	unsigned long flags;
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
=20
-	if (!list_empty(&channel->ld_queue)) {
-		desc =3D list_first_entry(&channel->ld_queue,
-					struct rz_dmac_desc, node);
-		channel->desc =3D desc;
-		if (vchan_issue_pending(&channel->vc)) {
-			if (rz_dmac_xfer_desc(channel) < 0)
-				dev_warn(dmac->dev, "ch: %d couldn't issue DMA xfer\n",
-					 channel->index);
-			else
-				list_move_tail(channel->ld_queue.next,
-					       &channel->ld_active);
-		}
-	}
+	/*
+	 * Issue the descriptor. If another transfer is already in progress, the
+	 * issued descriptor will be handled after the current transfer finishes.
+	 */
+	if (vchan_issue_pending(&channel->vc) && !channel->desc)
+		rz_dmac_xfer_desc(channel);
=20
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 }
@@ -675,13 +664,13 @@ static int rz_dmac_config(struct dma_chan *chan,
=20
 static void rz_dmac_virt_desc_free(struct virt_dma_desc *vd)
 {
-	/*
-	 * Place holder
-	 * Descriptor allocation is done during alloc_chan_resources and
-	 * get freed during free_chan_resources.
-	 * list is used to manage the descriptors and avoid any memory
-	 * allocation/free during DMA read/write.
-	 */
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(vd->tx.chan);
+	struct virt_dma_chan *vc =3D to_virt_chan(vd->tx.chan);
+	struct rz_dmac_desc *desc =3D to_rz_dmac_desc(vd);
+
+	guard(spinlock_irqsave)(&vc->lock);
+
+	list_add_tail(&desc->node, &channel->ld_free);
 }
=20
 static void rz_dmac_device_synchronize(struct dma_chan *chan)
@@ -691,6 +680,8 @@ static void rz_dmac_device_synchronize(struct dma_chan =
*chan)
 	u32 chstat;
 	int ret;
=20
+	vchan_synchronize(&channel->vc);
+
 	ret =3D read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_EN)=
,
 				100, 100000, false, channel, CHSTAT, 1);
 	if (ret < 0)
@@ -738,58 +729,22 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(stru=
ct rz_dmac_chan *channel,
 static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
 				    dma_cookie_t cookie)
 {
-	struct rz_dmac_desc *current_desc, *desc;
-	enum dma_status status;
+	struct rz_dmac_desc *desc =3D NULL;
+	struct virt_dma_desc *vd;
 	u32 crla, crtb, i;
=20
-	/* Get current processing virtual descriptor */
-	current_desc =3D list_first_entry_or_null(&channel->ld_active,
-						struct rz_dmac_desc, node);
-	if (!current_desc)
-		return 0;
-
-	/*
-	 * If the cookie corresponds to a descriptor that has been completed
-	 * there is no residue. The same check has already been performed by the
-	 * caller but without holding the channel lock, so the descriptor could
-	 * now be complete.
-	 */
-	status =3D dma_cookie_status(&channel->vc.chan, cookie, NULL);
-	if (status =3D=3D DMA_COMPLETE)
-		return 0;
-
-	/*
-	 * If the cookie doesn't correspond to the currently processing virtual
-	 * descriptor then the descriptor hasn't been processed yet, and the
-	 * residue is equal to the full descriptor size. Also, a client driver
-	 * is possible to call this function before rz_dmac_irq_handler_thread()
-	 * runs. In this case, the running descriptor will be the next
-	 * descriptor, and will appear in the done list. So, if the argument
-	 * cookie matches the done list's cookie, we can assume the residue is
-	 * zero.
-	 */
-	if (cookie !=3D current_desc->vd.tx.cookie) {
-		list_for_each_entry(desc, &channel->ld_free, node) {
-			if (cookie =3D=3D desc->vd.tx.cookie)
-				return 0;
-		}
-
-		list_for_each_entry(desc, &channel->ld_queue, node) {
-			if (cookie =3D=3D desc->vd.tx.cookie)
-				return desc->len;
-		}
-
-		list_for_each_entry(desc, &channel->ld_active, node) {
-			if (cookie =3D=3D desc->vd.tx.cookie)
-				return desc->len;
-		}
+	vd =3D vchan_find_desc(&channel->vc, cookie);
+	if (vd) {
+		/* Descriptor has been issued but not yet processed. */
+		desc =3D to_rz_dmac_desc(vd);
+		return desc->len;
+	} else if (channel->desc && channel->desc->vd.tx.cookie =3D=3D cookie) {
+		/* Descriptor is currently processed. */
+		desc =3D channel->desc;
+	}
=20
-		/*
-		 * No descriptor found for the cookie, there's thus no residue.
-		 * This shouldn't happen if the calling driver passes a correct
-		 * cookie value.
-		 */
-		WARN(1, "No descriptor for cookie!");
+	if (!desc) {
+		/* Descriptor was not found. May be already completed by now. */
 		return 0;
 	}
=20
@@ -812,7 +767,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan=
 *channel,
 	 * Calculate number of bytes transferred in processing virtual descriptor=
.
 	 * One virtual descriptor can have many lmdesc.
 	 */
-	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, current_desc=
, crla);
+	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, crla);
 }
=20
 static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
@@ -823,21 +778,17 @@ static enum dma_status rz_dmac_tx_status(struct dma_c=
han *chan,
 	enum dma_status status;
 	u32 residue;
=20
-	status =3D dma_cookie_status(chan, cookie, txstate);
-	if (status =3D=3D DMA_COMPLETE || !txstate)
-		return status;
-
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		status =3D dma_cookie_status(chan, cookie, txstate);
+		if (status =3D=3D DMA_COMPLETE || !txstate)
+			return status;
+
 		residue =3D rz_dmac_chan_get_residue(channel, cookie);
=20
-		if (rz_dmac_chan_is_paused(channel))
+		if (status =3D=3D DMA_IN_PROGRESS && rz_dmac_chan_is_paused(channel))
 			status =3D DMA_PAUSED;
 	}
=20
-	/* if there's no residue and no paused, the cookie is complete */
-	if (!residue && status !=3D DMA_PAUSED)
-		return DMA_COMPLETE;
-
 	dma_set_residue(txstate, residue);
=20
 	return status;
@@ -917,28 +868,18 @@ static irqreturn_t rz_dmac_irq_handler(int irq, void =
*dev_id)
 static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id)
 {
 	struct rz_dmac_chan *channel =3D dev_id;
-	struct rz_dmac_desc *desc =3D NULL;
-	unsigned long flags;
+	struct rz_dmac_desc *desc;
=20
-	spin_lock_irqsave(&channel->vc.lock, flags);
+	guard(spinlock_irqsave)(&channel->vc.lock);
=20
-	if (list_empty(&channel->ld_active)) {
-		/* Someone might have called terminate all */
-		goto out;
-	}
+	desc =3D channel->desc;
+	if (!desc)
+		return IRQ_HANDLED;
=20
-	desc =3D list_first_entry(&channel->ld_active, struct rz_dmac_desc, node)=
;
 	vchan_cookie_complete(&desc->vd);
-	list_move_tail(channel->ld_active.next, &channel->ld_free);
-	if (!list_empty(&channel->ld_queue)) {
-		desc =3D list_first_entry(&channel->ld_queue, struct rz_dmac_desc,
-					node);
-		channel->desc =3D desc;
-		if (rz_dmac_xfer_desc(channel) =3D=3D 0)
-			list_move_tail(channel->ld_queue.next, &channel->ld_active);
-	}
-out:
-	spin_unlock_irqrestore(&channel->vc.lock, flags);
+	channel->desc =3D NULL;
+
+	rz_dmac_xfer_desc(channel);
=20
 	return IRQ_HANDLED;
 }
@@ -1020,9 +961,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
=20
 	channel->vc.desc_free =3D rz_dmac_virt_desc_free;
 	vchan_init(&channel->vc, &dmac->engine);
-	INIT_LIST_HEAD(&channel->ld_queue);
 	INIT_LIST_HEAD(&channel->ld_free);
-	INIT_LIST_HEAD(&channel->ld_active);
=20
 	/* Initialize register for each channel */
 	rz_dmac_disable_hw(channel);
--=20
2.54.0

