Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.304.1795708153933090326
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:49:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=F0g0zaMv;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.35, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRUjBZ4hQ4pVCj5wpFQaleiBxORNpUaZ/5V4qUTtBi3UzggN6ID+QwwWWIJCIrPZA6WwcQ1Ztfw+TrODGnBcnhs4aAsO+7HUF1lcMumm1S8keuKpH3rrCNjSTHmfgq48iyjUoFEUiecjDDtJSwKgkqDOQn2ol4q3SL8xojYJ9y1wAL2Sh7YunVrl+kbJd9oo2Jun2fi9626oQvQ10p3RldhAaGrXiPiORy7USJCB5yINtXewbSnFlaRNm9ptKjZUebWNw+xPiS2qiiX/DOA8IGSK9mCaZlUpyROR2GfG1hhOi7jolW/JfbNwT4yldIK+jdwNY3hm7LNj9wQDSsnVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5jSStM+inAnjZS48WHf/GdwFggybQp5gz85Aog9hWw=;
 b=ehEYTk1oE5tRSECWkI4czyTQOhg88vu31d4zVOyKj3+s5Wvl7O4Sc+xR+IzKa9vxBBT9jKlqEX5dQCVBasz8u6v4UArBSIYiH/sproGraO6+iS7fn6BszydUIN3NO3Uxob4a4SFWPLYWiR6Cf5RGRCeYQmK+JW20r/dLZD9UjgHn4kiX2r29J0jL0SfQsR8LSYWVMpN3E3RomhAP+OGF7sL+8bqHugS9LLgc2pETm7HJACGobOtmpzSpRTuQfBo4RCo7qJlt7RHvNlu+EP8sw1SnhYGhKpmEL97p4kw1GCk3kZh+cZbSwAIasNg//Gid4YIc7jBqYojO+aPCaNV1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5jSStM+inAnjZS48WHf/GdwFggybQp5gz85Aog9hWw=;
 b=F0g0zaMvPyn6R1kQzHwSdoD2S24Eyk+a2s6UY50b7Coct5RxPz/AvfP1U4MWDT7eRXaHADTK68ssOUIJYzuz37k6Jchraq2NhzokqSkJ5WLo9avZbv2r4BbwMzUASHpzJyxeBjgPRd//lnlO2eI4CYxjU7bwuaJf6c5glag+mvc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:49:11 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:49:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 22/27] dmaengine: sh: rz-dmac: Add cyclic DMA support
Date: Thu, 26 Nov 2026 16:47:42 +0100
Message-ID: <20261126154747.3832917-23-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 911b066f-afeb-40b2-a491-08df4bd4d06a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022115727099003|261021133027099003|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|261026130827099003|261026121527099003|261026140227099003|261028144727099003|261026135527099003|261021135927099003|261021130227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: drxJirFnjofsmpxiE2l3IcS8D5VVNJvGt7mOPgGOXRfG0tggYgj3LsHup5TFg5ipdG7kLY/FLK6w7QXylUQqTbNCphx7cu1Qgl/IUuZdKEd0hZuhWLkDzoz70Rvz0YlTnBlkUqJcj3PU4bZsUGhGtEw9MOk1kWpGu4YBa1hhiO/eDH/pZtjuDfn44YHx0qguYeCyphEY/m0lpK1h0lt5S1Qm6pQqzb6m6j42esIKbfeucYbosPltgrqAi2YpMh1w7yBl15A+icraQ1htt/82G5fEYzggVB4EZzWl++dTPM1FKkVZO24W0TXAhgwdbvmoRgbBTz6Lu9Iaif2h973aKMRy3A5/IKbUX4ODtSwXdQW7bCNbaj01vQEM4ipoPjkNXEsBovHPU8R+K0zt4BQuaIfLnZCkTZlqU+FsAd2aDljtIKtqFnZmqJ5eER1Pcq8G79BEXTzclxr4bDqUtFTmc+63kzydY76Ixei3MefJcMapvyIXf8qggCYTd1ZDzWyEddv2sEDEKNTeXHsZt34EeUv8cZsojLrCV2P9nowoiIjoL7esv4zL3OMt3ejc2hI9ugKe1dUI9i7MTi4VcTbdLnKVZg4T3WvGDrqT8p7wbACvHvyQKCXRQZNPe0krBs0VG8WWXJgggpkRSXKBvq8jqdOUD3UfxpPLiYRIYqB3l/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022115727099003)(261021133027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(261026130827099003)(261026121527099003)(261026140227099003)(261028144727099003)(261026135527099003)(261021135927099003)(261021130227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A0Y8u7c6yvMWDLlhYjQUqJ0XKFqOPFL91ji+EuOGaAiVc2hMJSil6Ubs8WLj?=
 =?us-ascii?Q?5Y0z4sAIj8CojefpgIFyxo0QTYLJiRH/pJIXgN3YPzXpLe16CpxXmfdiKAgS?=
 =?us-ascii?Q?PBADKchWAg1dToAwNkD4KdrszRBYJB7Hk6cGe9OQuikoX4eJ5aslh5Gz3u4b?=
 =?us-ascii?Q?lKhYYtmCTM6qIPo05jVgTQPqNGPT0Mzwe+MppqzMoupEfn5OcskTFoqJnXFR?=
 =?us-ascii?Q?maA+YQfRtGgFMgFUgbeGxjlOaYcKkL7/zRf0VzqV5Ia0PLt3f6+9EJ/2eeM8?=
 =?us-ascii?Q?AhDWqU1i4HliJ47Q3qmgJTf0lx4cTlvpIemH5Lrm65uRH54xNOPHv2rJm7kd?=
 =?us-ascii?Q?4DsRQme/1Ve1KvPM7W0RBhTkAj0xbo7LK1+rcTtNrvAdmKJj318bijpX6AXw?=
 =?us-ascii?Q?kGc/GCKMLERGIDFttFd1jp4uEBh6sKmo+Lq25nt+1DHXHeGSj8HIBLTkt4dk?=
 =?us-ascii?Q?nxIu9ZZ0c/su9QFjunQxBmIz2MyRtHeEATxHrYV4oennDgkQ3fsVBLCtlL5y?=
 =?us-ascii?Q?ZUX9MTmj8246o+BKI6DczzMIDKPMM7vNlbMZDt/DeZ0TpX87VW5IsrnGBaH0?=
 =?us-ascii?Q?g9v7xGoJ1dpk4JOMx7rxR0WDfLJIyQdYubuTemeQYcxIS0LyttGZGM/jrrrt?=
 =?us-ascii?Q?WPTZEqLuIhjYE+nnBO2iADv/YHpBlUjp28BRUFcYX5blkd01LDnJzYKExpKH?=
 =?us-ascii?Q?cjM89epUORYtU9tMNjFhK723wtGxvIelUsIAracszgKREGpLCsSS0uTf2H/9?=
 =?us-ascii?Q?5PGUVcCAlqAbVd0rw3pkBBz6OPyhNMqXhketGxAH2A06jRGkOI+/TzpEFOvC?=
 =?us-ascii?Q?CHIgCsy8vD+yPjiKYiKqYfYEcgQB9GK2qWlUK+QHcRn4Wd10DwL8rueFifJy?=
 =?us-ascii?Q?b9+YJq+QywIkmlcM3Y5eSYlBu5Dj6JiClZRqvD2E4hSaVlrvmy9pm0ZC7Gwn?=
 =?us-ascii?Q?SmEZ5VZSnhJex3lNzw82Wgc1gHp9kmK4Cw3Yc6je1jj8l3ToiUL9fMA49Dl3?=
 =?us-ascii?Q?oaYIVRfnTtjqDvS7f4db8ao3DUy6abNoRubUO74EqgdFZ2ZcezYOtAn/cuQp?=
 =?us-ascii?Q?VGkcYdnp9B44WqnmVtlB+i0kPVRNvFSDDbajNmF35Ai0SNE8LHDurBk1/RTk?=
 =?us-ascii?Q?f897etjdFbtmj7rWLtzUvy0zrqHXVUZLfwFJ/ceAx4NbzaoDSFg24IcP5jAs?=
 =?us-ascii?Q?Pr88RdInKkWPgQVUjieM8vumB7c+tr8rzTdeT9A47sx6k6iyBQ3sha375b7k?=
 =?us-ascii?Q?b4iCrMVUm7w5FqlzbKfb/YMU1Uc7YvzdRIOwzus/2EgM9AjlHk/ZPSpnq8xv?=
 =?us-ascii?Q?s4yJbeqLwzzJPjnNkBcWf/Ra2tylikWRlYO4mb9q9SpY7uXEI/Jm3bh7L4Qm?=
 =?us-ascii?Q?bxjdv/coex70yTvdsrrtWzS8wjhSM6QIQXMXKonUWKTNvyCo87ipvUHkacHv?=
 =?us-ascii?Q?edw9NqA99L+XBAmUe8HwDGyQ4lgypAloK8CVtLHdaLtZTbwf0XBQTBdrfzhz?=
 =?us-ascii?Q?1j/Mc53RVRkGUEX4LXGNwC6+QSBV9hohVn8MeKDQ0R40eqkf98Q/PWys+lgc?=
 =?us-ascii?Q?cQAxOxq1Pjf8Seg5n2JjSQdY0lr7xB9qsM+hyYS6IgBn1iUMWCSoOkRp+fxN?=
 =?us-ascii?Q?HQTQyF1325dGBQrbTZfLNlzbOhRaV+0ueO4PTa1Zx4KVQ8Y71rNatNj5U/S6?=
 =?us-ascii?Q?2d8QMrkR+on0eRFqHERIovt8cA2qhuIhkmE3yHJ2iX1JKJDr45/gzyDeU8DQ?=
 =?us-ascii?Q?kMejcrZrKaHlzRo6dQ4wn3aZkWYMRrqGBeXnmUKui+jOYBF1mp9l?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911b066f-afeb-40b2-a491-08df4bd4d06a
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:49:11.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51JWhLKrGb0L9jd5ba9QxjNAVSshYYgKitvTsOuENRx79/YQ88gKaJ6lx84wf7wuDqTaSFM2H4t9hQdt8CSy7itY/Rb5GHR1jrVZB5a+U2+YKvAa8mcdraeb05Yxv3xr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25172
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 172bfb57481c65fcc94ebcae3a730f6df2f953d4 upstream.

Add cyclic DMA support to the RZ DMAC driver. A per-channel status bit is
introduced to mark cyclic channels and is set during the DMA prepare
callback. The IRQ handler checks this status bit and calls
vchan_cyclic_callback() accordingly.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-13-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 136 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 130 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 1ebac606bb4b..d332907901d1 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -34,6 +34,7 @@
 enum  rz_dmac_prep_type {
 	RZ_DMAC_DESC_MEMCPY,
 	RZ_DMAC_DESC_SLAVE_SG,
+	RZ_DMAC_DESC_CYCLIC,
 };
=20
 struct rz_lmdesc {
@@ -66,9 +67,11 @@ struct rz_dmac_desc {
 /**
  * enum rz_dmac_chan_status: RZ DMAC channel status
  * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callba=
cks
+ * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
  */
 enum rz_dmac_chan_status {
 	RZ_DMAC_CHAN_STATUS_PAUSED,
+	RZ_DMAC_CHAN_STATUS_CYCLIC,
 };
=20
 struct rz_dmac_chan {
@@ -190,6 +193,7 @@ struct rz_dmac {
=20
 /* LINK MODE DESCRIPTOR */
 #define HEADER_LV			BIT(0)
+#define HEADER_WBD			BIT(2)
=20
 #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
 #define RZ_DMAC_MAX_CHANNELS		16
@@ -430,6 +434,57 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct =
rz_dmac_chan *channel)
 	channel->chctrl =3D 0;
 }
=20
+static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
+{
+	struct dma_chan *chan =3D &channel->vc.chan;
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
+	struct rz_dmac_desc *d =3D channel->desc;
+	size_t period_len =3D d->sgcount;
+	struct rz_lmdesc *lmdesc;
+	size_t buf_len =3D d->len;
+	size_t periods =3D buf_len / period_len;
+
+	lockdep_assert_held(&channel->vc.lock);
+
+	channel->chcfg |=3D CHCFG_SEL(channel->index) | CHCFG_DMS;
+
+	if (d->direction =3D=3D DMA_DEV_TO_MEM) {
+		channel->chcfg |=3D CHCFG_SAD;
+		channel->chcfg &=3D ~CHCFG_REQD;
+	} else {
+		channel->chcfg |=3D CHCFG_DAD | CHCFG_REQD;
+	}
+
+	lmdesc =3D channel->lmdesc.tail;
+	d->start_lmdesc =3D lmdesc;
+
+	for (size_t i =3D 0; i < periods; i++) {
+		if (d->direction =3D=3D DMA_DEV_TO_MEM) {
+			lmdesc->sa =3D d->src;
+			lmdesc->da =3D d->dest + (i * period_len);
+		} else {
+			lmdesc->sa =3D d->src + (i * period_len);
+			lmdesc->da =3D d->dest;
+		}
+
+		lmdesc->tb =3D period_len;
+		lmdesc->chitvl =3D 0;
+		lmdesc->chext =3D 0;
+		lmdesc->chcfg =3D channel->chcfg;
+		lmdesc->header =3D HEADER_LV | HEADER_WBD;
+
+		if (i =3D=3D periods - 1)
+			lmdesc->nxla =3D rz_dmac_lmdesc_addr(channel, d->start_lmdesc);
+
+		if (++lmdesc >=3D (channel->lmdesc.base + DMAC_NR_LMDESC))
+			lmdesc =3D channel->lmdesc.base;
+	}
+
+	channel->lmdesc.tail =3D lmdesc;
+
+	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+}
+
 static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 {
 	struct virt_dma_desc *vd;
@@ -451,6 +506,10 @@ static void rz_dmac_xfer_desc(struct rz_dmac_chan *cha=
n)
 	case RZ_DMAC_DESC_SLAVE_SG:
 		rz_dmac_prepare_descs_for_slave_sg(chan);
 		break;
+
+	case RZ_DMAC_DESC_CYCLIC:
+		rz_dmac_prepare_descs_for_cyclic(chan);
+		break;
 	}
=20
 	rz_dmac_enable_hw(chan);
@@ -585,6 +644,55 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct sc=
atterlist *sgl,
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
=20
+static struct dma_async_tx_descriptor *
+rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
+			size_t buf_len, size_t period_len,
+			enum dma_transfer_direction direction,
+			unsigned long flags)
+{
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac_desc *desc;
+	size_t periods;
+
+	if (!is_slave_direction(direction))
+		return NULL;
+
+	if (!period_len || !buf_len)
+		return NULL;
+
+	periods =3D buf_len / period_len;
+	if (!periods || periods > DMAC_NR_LMDESC)
+		return NULL;
+
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
+			return NULL;
+
+		desc =3D list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc=
, node);
+		if (!desc)
+			return NULL;
+
+		list_del(&desc->node);
+
+		channel->status |=3D BIT(RZ_DMAC_CHAN_STATUS_CYCLIC);
+	}
+
+	desc->type =3D RZ_DMAC_DESC_CYCLIC;
+	desc->sgcount =3D period_len;
+	desc->len =3D buf_len;
+	desc->direction =3D direction;
+
+	if (direction =3D=3D DMA_DEV_TO_MEM) {
+		desc->src =3D channel->src_per_address;
+		desc->dest =3D buf_addr;
+	} else {
+		desc->src =3D buf_addr;
+		desc->dest =3D channel->dst_per_address;
+	}
+
+	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
+}
+
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
@@ -732,9 +840,18 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struc=
t rz_dmac_chan *channel,
 	}
=20
 	/* Calculate residue from next lmdesc to end of virtual desc */
-	while (lmdesc->chcfg & CHCFG_DEM) {
-		residue +=3D lmdesc->tb;
-		lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
+		u32 start_lmdesc_addr =3D rz_dmac_lmdesc_addr(channel, desc->start_lmdes=
c);
+
+		while (lmdesc->nxla !=3D start_lmdesc_addr) {
+			residue +=3D lmdesc->tb;
+			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+		}
+	} else {
+		while (lmdesc->chcfg & CHCFG_DEM) {
+			residue +=3D lmdesc->tb;
+			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+		}
 	}
=20
 	dev_dbg(dmac->dev, "%s: VD residue is %u\n", __func__, residue);
@@ -927,10 +1044,14 @@ static irqreturn_t rz_dmac_irq_handler_thread(int ir=
q, void *dev_id)
 	if (!desc)
 		return IRQ_HANDLED;
=20
-	vchan_cookie_complete(&desc->vd);
-	channel->desc =3D NULL;
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
+		vchan_cyclic_callback(&desc->vd);
+	} else {
+		vchan_cookie_complete(&desc->vd);
+		channel->desc =3D NULL;
=20
-	rz_dmac_xfer_desc(channel);
+		rz_dmac_xfer_desc(channel);
+	}
=20
 	return IRQ_HANDLED;
 }
@@ -1182,6 +1303,8 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
 	engine =3D &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	dma_cap_set(DMA_CYCLIC, engine->cap_mask);
+	engine->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	engine->residue_granularity =3D DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
@@ -1193,6 +1316,7 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
 	engine->device_tx_status =3D rz_dmac_tx_status;
 	engine->device_prep_slave_sg =3D rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy =3D rz_dmac_prep_dma_memcpy;
+	engine->device_prep_dma_cyclic =3D rz_dmac_prep_dma_cyclic;
 	engine->device_config =3D rz_dmac_config;
 	engine->device_terminate_all =3D rz_dmac_terminate_all;
 	engine->device_issue_pending =3D rz_dmac_issue_pending;
--=20
2.54.0

