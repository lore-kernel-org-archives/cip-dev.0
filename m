Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.488.1795708616325332204
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:56 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IPNH8Cap;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.22, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/DgODdUmVdIpv+ObZQ7Wvso6J6Qp5b4DDolrRZg6FCnxIWOOuJEPY9q0FeizqjLjmSIl82Xz3s7PohC7OaGrngYAzb5b0QDsCtf4HijBqXY8x9R4BRvsQ+BsgzA0wE9Ayu0jOWms1louoRbDy0/Rj/N+Jrs4kbRcaWJJZpFjx1jZJQs5y9fTfwKLwY16anSDCQ2hTD+4LeYY5buP9BE8Zh1DPOH36CZogc3w3nJUtjxo911HHFVjApZDLiUtd0ox32P7GFIZ9aywYo5OqRXdprgEfeubrOdrK0zyUHFaWhqiEiocUQihXgRHxxBaYLeKclFpMvqN65r+1Xf0G74bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWuJpYhHPAEQ+mZ66qaRpqlnYV2NWToYRiiDgMJ0V1U=;
 b=uT1LmB7NFEhq6ig1f/fQKULNIpJY6RxXo0JJ5bpgwK1Ub56NtViFG9QoD0PF3coxIeWrW8YxaRNyp7caGVG7zGwZdu/XOMdtyZGyKvk3lbJvVSdUqVEk/N4RaR3f6dlg6A8ZiIrEGPEQ9c+7vly4SAL+ELQawghDdlOTajMbYhI5UQU6VGN/PtlCQUX/4NTquidZzqa3fw1Xy8dwwemQzrY/0OjPVeX5y0Pp+MKgYNsOv9qO+zMlW06C4/iPoYL1mahr607y1UG4qqOx/k32khpkCme45SiHdCPHw/es1cDY2xIYQsDC+/ZK78rZnosjg3+ai5HxMkt+JUNAAq+jQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWuJpYhHPAEQ+mZ66qaRpqlnYV2NWToYRiiDgMJ0V1U=;
 b=IPNH8CapDClUJKb1QE64LV0sdIuWAFXeo0Bsj3WgnX2xyPhCvYvtdmkejrkAd7vmderd+hzvZ1iusK1iTnVzxPp4Sj8cu7bEEFdsgVfCZoYKYCw7oecYfT9/LF6PAjvdq+AwM0WT2604wRZkBAuug51BixtwJCSHKGY1veexAvc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:56:54 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:54 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 18/23] dmaengine: sh: rz-dmac: Add cyclic DMA support
Date: Thu, 26 Nov 2026 16:55:40 +0100
Message-ID: <20261126155545.3834937-19-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: f7776ac2-cb17-410c-0b6a-08df4bd5e454
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026130827099003|261026121527099003|261026140227099003|261026135527099003|261022105027099003|261021130227099003|261022113327099003|261022075727099003|261022115727099003|261021121427099003|38350700014|261021123027099003|261021133027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: 3EXlVwGu7bHZ/tSmXTMhmVHogmVIIq+Qp3q5tBPwVyOc9p0PStGNRNAO1hugKtptwcdk0JSvvOKB9312tT6NaKz97PWmvMz+IEq22qAmlQa0gHrX2nSZ9u22yKj/IcYyd7IiUkV5FcNnXeDKei8yybXZlgI0C4s9XNCzhIFi0Y76h9RJ3E8zvuhq/j53qAHudgEzUVQLErlKtwOMGxc5B8kTrxbLW3w7juXbFlWp5iEUNT40wwiv23STEDo41+V+MCdSK16KpfKw/SaO8tLU8IMCscasJDC0MsunYuyi/Fu4rCNf/g8Oehp1AO8XPbLu57Q9yuifD8BQNB6zwbk53fRleOxNn2vbEaUQknA8dZjvkCVhB9Hr4VytqWh+JUd7ZFSk/cHqiUfNY3vhxVZGZALnQZeXdjc52D1+hqCvz9rr9OMs+GGQjVrxSFr0V5erm4FUMo+vwp+B0prOB0P6xSLZrWEY72N3mFiA5uO59H+8v8M+1h6xcIp9FevXReATinsfxjkbd834IAvlAmSzFiX4ZkAHtx7BUdmjWUQPaaD4qXtxLyy3nYVbeMUCWR2MZ9tkR3tGicEimuFwrOA9EgUJX+VaQVgu9j9av5gvJdDK570yJSWb7Mue+f7k9m6m/GCvmAJE8/h1Zi7X1sDsWUj/rCGjGJdrHKmi4IIboLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026130827099003)(261026121527099003)(261026140227099003)(261026135527099003)(261022105027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021121427099003)(38350700014)(261021123027099003)(261021133027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FvHBdMn4Pz13vj1ZZsHfu+gZxfmbwnmhE9PpBw+KIiC655vmIVmGMa9qtPgO?=
 =?us-ascii?Q?dED1R/HVFI/8nUuDPIwc/+Pc7CM91ZJRi+QjHINhF5z9iOz3C3CxJ3gu15B2?=
 =?us-ascii?Q?XA3RaxosFF0hl1ew3wj1beilfo4Zn3yLI3Jimd9Pn04sENOhsqOSA1wuegdV?=
 =?us-ascii?Q?WXemelQh21Bus/Gubivlxmf0UuyHPLY4/nF0+OXkA1xLsV6zbpXiIEqY9VC2?=
 =?us-ascii?Q?vEmx/l8jNYDS6YrTGfotN7K2h6INpHrbsEgCluH1jWlI3AZTLs/u8MTafGhj?=
 =?us-ascii?Q?1LBM8F9C0a4pYvA3gqHAD66MCPIMh48lq0SdChdKvrFmOIk3UHtnbLwbrQfu?=
 =?us-ascii?Q?KfRYJpUzApcfgai3oJ3sfC/xxqy6Rcm8Dgyq7kUirRufiKdzj2gZA2T73pff?=
 =?us-ascii?Q?mZOyIsrj/5HMCRuU9NesqWXoYFRLG/BmPtT7GXtxPXckW7TNGNInZqO+Du+g?=
 =?us-ascii?Q?M/lnVxkl0Ex+Al7P9iUxQwIv0ata6p4YjyHi1YE2f/QsbxMc6ya70tjfHWNE?=
 =?us-ascii?Q?ZregZR26aYG3Y5IquNBDk/Upfr9zGcmXGoJ/7XyZZrfA601k61ncctWkGWbj?=
 =?us-ascii?Q?7zr4FYiaSQGvta23TZzHLir//9toRpVjuA+Ro4XrRogwiUNr0smvtaJDIODI?=
 =?us-ascii?Q?K3X4z3z2blnBGsWdzt6iiXWv2C1QmGCD4P5yxbrFxddWAVcli2a8vWgtS4F3?=
 =?us-ascii?Q?IehZfgW3Fk6lLfpzQA12rF7usXz4qNVwuGupObaLZQNgGt0Tf2N0CDdOqTqb?=
 =?us-ascii?Q?OT2Qpqk0ABKe3KnxxjhTKhHjdGykywrWv8l6tghEGVRG75dpHAG6WFMcew7V?=
 =?us-ascii?Q?iDcs24QGo4JbvX3NJ8gHcsxkHGXkVQBwxqV8vD2uFto3nkk+7BWBRIUdVbu5?=
 =?us-ascii?Q?qFx8TTogWr24NizabY6a8uzgdjurAbTWP2EPtUBi+H/wuxuoU2l7NH8NIIDI?=
 =?us-ascii?Q?zX+6I2sUlYFc0owEUgqF41E8R2z48KPXnq5eeYpZD2uDPhvbmRbDvzlaAvgX?=
 =?us-ascii?Q?kUHzBOvvYb1bxLZXxA0hShbAm3JPY4AVsZ1d8lakLbc6AxJcP4Io3DPhfvEW?=
 =?us-ascii?Q?YkOrhyf8DuLjPco1dDjYjjkLnwrqvyGeCJytqXQR6zTayaLMmckyOegrLK0C?=
 =?us-ascii?Q?xYHytmZpEW+qETIQtWzZ2/y5DYglvH4WZT2SpsIvyqWJEzfWNm2BdxeFlnzJ?=
 =?us-ascii?Q?K4z4hLuFJsS6rx1d6HBoyY6QPGYKAo5sj0ioIRZvuvzKRf3dQwKA9jijyU3w?=
 =?us-ascii?Q?0Svhr4GEOhbWgySrMG9my22/zLfOpi0d/6cW1mcYfuVmfubNdDQDJeMjIfS8?=
 =?us-ascii?Q?AisI8exn7POz2lnKdl+vH3li9xS8hYs5uHWpHe+BWk5LMaxUzsqKfNVPbgGz?=
 =?us-ascii?Q?grQFL1Aby0eR6jYrBESgyv4EUoZVKbfIuFGmutU9awhJLjwLh0x7S53gebSU?=
 =?us-ascii?Q?kc8t3qC0hFtxHQlIpnJ607eD79/mEnI4y6ClxB+X1H6AItVkSxh7WnZDKqi1?=
 =?us-ascii?Q?cBxWcUd7Mjj/x9MEbJ32Ew4tARNsnwMbZCeSnmtJdXOuB3RkPwvkVpXxO9c4?=
 =?us-ascii?Q?OAbhK7AUpWm8oyaPbt4s3PfAnwjRZ2vNzWeu3qKEJMpvisYbcfFMuZ1+0CW3?=
 =?us-ascii?Q?6+r8tjUk3GYQPkwXupEswp5SIlefQYSt/pDKZbj6PmIxq1N3qUpVAqqjd/Rf?=
 =?us-ascii?Q?gHZWIbaCs59odL49r4IYQCOWP5hqzzy5YaI3VIPmo1EbMeqQHO7TESuD2Uhv?=
 =?us-ascii?Q?DTEH479RCW9yyV4IobmIQP0EhkfFbrQ0TeXOh7Bw4ESCRNbUcn9L?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7776ac2-cb17-410c-0b6a-08df4bd5e454
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:54.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHNjTuBJTvnHlmQs8hPi03Y1OaNITdIPhYq0cvBTjKVVudLNp85Wt6cVcCcT/OGURuzIK3lSiDdSf4ZzD3AT2Mj8H9UR/HCiW20rvZQ5nTCGfXV1fHn0oWQw+JPwdAIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:57:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25209
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
index 404af9b8a8f9..cbb6c74c02e5 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -35,6 +35,7 @@
 enum  rz_dmac_prep_type {
 	RZ_DMAC_DESC_MEMCPY,
 	RZ_DMAC_DESC_SLAVE_SG,
+	RZ_DMAC_DESC_CYCLIC,
 };
=20
 struct rz_lmdesc {
@@ -67,9 +68,11 @@ struct rz_dmac_desc {
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
@@ -191,6 +194,7 @@ struct rz_dmac {
=20
 /* LINK MODE DESCRIPTOR */
 #define HEADER_LV			BIT(0)
+#define HEADER_WBD			BIT(2)
=20
 #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
 #define RZ_DMAC_MAX_CHANNELS		16
@@ -431,6 +435,57 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct =
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
@@ -452,6 +507,10 @@ static void rz_dmac_xfer_desc(struct rz_dmac_chan *cha=
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
@@ -586,6 +645,55 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct sc=
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
@@ -733,9 +841,18 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struc=
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
@@ -928,10 +1045,14 @@ static irqreturn_t rz_dmac_irq_handler_thread(int ir=
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
@@ -1183,6 +1304,8 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
 	engine =3D &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	dma_cap_set(DMA_CYCLIC, engine->cap_mask);
+	engine->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	engine->residue_granularity =3D DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
@@ -1194,6 +1317,7 @@ static int rz_dmac_probe(struct platform_device *pdev=
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

