Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.320.1795708138367463997
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=E4YnD+sT;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atVQ40USbMdLN6xg+NewduKXABNxpHVByzFqAWn0Oh4YcPwcL1UoS5cKOLEHER2QIzSb7hE3vEPqp+qT7WiqcYYy5a5Z615yojUbz7iaDtRb8O5WYqCMh6xPgjidd1++HP4HVTRK0B9I7QlFYkoDeb6SWKvnwTT4XbApE7yxMoZVNMNSDNgHF7wJdUUUGzFeTPkeZds5zn/9D5aQmSs2YHFzm2Z4MU8loQv11ZI6/co8pDhLk1dnsssHTWE5pehxZaa6pKBhurXSQaoVHn0hS/g2p/maiaitZRJQTU1F76Q8w+fLJWEGg3fboMYYZFQTg8VCr0BRR0PBy1RoBrk5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyH7uKJQXgFX70ttX8SXwq2FSbP4IQW2joBrdZaTpoA=;
 b=p+aQGf2F83n4SNL7HK11sfOl/bArpkPNf9mF9tahaQEoPd7GFsnHs7jXP8Aci6k/Cu5xoXQCUnJ4wtfdMxat1C7FZRjxpP21NFs5np9Lg77yTX24CQPe3mUbKnJe8nnD8xXmnK/Dgb6fa7J68oYv400xyj1xCFNuVE3HM6Z5oUZ7kk6D3r/2MmAuckD08mr8dOROptSLKKC1p6bE893o4RXuTleMr7drc7J/skDsQhewUS2QXBI19JaBP9Xz+sEHzr/9Z1SWK/QIuGHZ1MHk6qY2U3Zo/QQ76aq1smB0lcbApi7h1D8KKlFmL99oTE7cuxKAReSAUtO3khsTc9tVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyH7uKJQXgFX70ttX8SXwq2FSbP4IQW2joBrdZaTpoA=;
 b=E4YnD+sTX+fvwkRL9yPFZNA3mKEkUlDhMZYoDU5j8nwWKZw1MHY3DxZ/pU1SEax8UHm5dK7c4oUD4ZiaA0Y8fSYCFSS2QCZBNKzbNhpiq5u1cNcHqbC6qf5mNmNjd0lZTC1AWZsoTQ1bTikA+zL3+wJZDjTlW2131bmSohyyEek=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:55 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 16/27] dmaengine: sh: rz-dmac: Save the start LM descriptor
Date: Thu, 26 Nov 2026 16:47:36 +0100
Message-ID: <20261126154747.3832917-17-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: b32fae38-f7c9-4bfe-cf91-08df4bd4c6ee
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026130827099003|261026140227099003|261026135527099003|261028144727099003|261022113327099003|261021130227099003|261021121427099003|261021133027099003|261021123027099003|261021135927099003|261022105027099003|261022075727099003|261022115727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DIaQS9kKR2x/kUq4mw7ZUzGsol9jbvhAtEjFIIVPhJckxiUeo4Piyiqfzg3TbvMlSLoYns0z99x6WB75WzPXnKYIxy/rHm2qWPwR/WhPEmQj14y44va3VnBrHQhtaJkXr3SV3pd66MulRqhqQ9upig74/bYrxbacyh3MlrjYdUvj6RDH0tJ/DzMWEFzqIZ8uI3WFDQEC6LKZvR82/Klcm9hSt3sWWQ/0dsMnSCEYv/dmqB5xyR1O4ku8fCKn1ROsRW3ynMhe4INY3PBUAk3PASTT4E1hYdxqu5aIArsLpFVPviOn5PNuqriaBI0cXSh5TiUXA9bd1qFCGhwuAymW6lyBSwffKWfXaspmbo9De0pOxTBOhSWYDAJDXD+KhaPN0C3JNtUYy8V+ugjsfTSM3RUbgDPUs5xNCGnk7EgF2CqJ3EB7gCa/8NT1LCUxGUzPI5guR2y2K+RBo7amOD+J/rYZMFcqfaJn5eJU+tSl9i3QFl9mox0U2U3pCrRRI/NNGFCPriKOqoZchSj2m2fvbZXNRuNjTscYJ0xYAb88wK3vVbva5GBzwX1LJ1rXLW+PqMnidtJKaBwYxiyu2CEsPk5qZpigdG04Eaw8YtLzgY/lK1mpNxMb9k6HKytcNfuStflnmJG/2Qoh+Wt0KXgfJxC8FsaJvi4LIJdPvJQ2Sio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026130827099003)(261026140227099003)(261026135527099003)(261028144727099003)(261022113327099003)(261021130227099003)(261021121427099003)(261021133027099003)(261021123027099003)(261021135927099003)(261022105027099003)(261022075727099003)(261022115727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5pwQ8mOzul5XXhIG3mtyQYxx/lNs8YrG+U1igtr5DOLEzCOun4NeHUaY3B6j?=
 =?us-ascii?Q?/2TV81hhcHiCYtI+kvDG7grj1a2hqLVnE3/eu0O3HJ55mfUPqBDOk66vWaE5?=
 =?us-ascii?Q?fa0l8aGYz/Stu9HQHwKAy58uAz+3lIlPo0kyonms+VqwGLwQaNleVL1SPOhn?=
 =?us-ascii?Q?dIx1I7i+q+1Pn3QCT5g8E9ud8G0l3JXfrAwO7nKlBeySvxnopvG8lu0UP7Yv?=
 =?us-ascii?Q?16RrVjZTXQuL4Bkwe4sbpK2gMi8yOAze9V8kd2NECiRaop06DincSzTCi6gI?=
 =?us-ascii?Q?WCg3YjslZeqLAM6HGhech4Ye8HKOMcNrEWUXemdkxYHNqpuj+kleIVZzKj5h?=
 =?us-ascii?Q?GMAuQh8L1vKDfl47VALiEcY9iuekvnqqRXe7MqSZrNAM+e9pq+xOLJHgqxOv?=
 =?us-ascii?Q?ycvredimDqNd/GVWJspfXPYRiA+sW9uB+z5cQoiHJD97pQcZrV1kQ0sBGBjr?=
 =?us-ascii?Q?S8XEJBWMGDt4RnLULufy2HgZja8Dq00RlChvQKZlgI5vbGAQfBuoQWXttzrA?=
 =?us-ascii?Q?YcTD43Oom+JJoi5kAIaD1cQnuqWNmgACPbx0imL0XkvNej8oFVv6rIWGzTPW?=
 =?us-ascii?Q?buWuxTqRezsx9CjVzMvvBmvD6GJuan1OVHleH+CgdqcCmnn2ymnNagQ/MCwW?=
 =?us-ascii?Q?8jD/CPdNHKuK8nvHo2cgyo+Ck9hmUKO7kzQdi3nuuVpyEDRyjNgKl4Sm0+wX?=
 =?us-ascii?Q?gZcCK8j/GHRrNesQR1bi8N5g/ViArPJrsA0VE9G4xMesrT0X0EJ1M8ZNqvbV?=
 =?us-ascii?Q?Z235XLpNQ0WL3kk2xmMa91WWCSVL8GksrcMvpx3MxiF+jw4AXwsx/p9t6ela?=
 =?us-ascii?Q?mHXCJOhtimVZeaQjBQGz+5pAbyZw/2ntOfkQ8zxEVAv24cagpUUKF38xF7cy?=
 =?us-ascii?Q?nhvR0VqyDm0opv+7e3kl0ho0tH6+WOER73wI1uqW3NlJ3J9ynhFLTrRC98w8?=
 =?us-ascii?Q?+oWz0pJM7jPtT4MKfVRnazksXMuxqXiEjS/2TT1gOvJ7StR0rPplvVJkNXnp?=
 =?us-ascii?Q?Gzie84BQ7d3rAC+I4QlwgNOnBfmNv1VzcpHtzDlzyTx6YdbjJFERV1UMXZ6J?=
 =?us-ascii?Q?DIKMflEZxFYmckKZRZdmlypUDqpiPvIMRtG2klANL45CrFTHKtDBwbpYMnTW?=
 =?us-ascii?Q?dZ85OzPsQDa8XfU0KT8KkFNxjGSOglL0XBoNvOBIo5Lxz3S1FBWeJZ/ugopU?=
 =?us-ascii?Q?LygctetcrEUWs5/87WiJ8g23O9GIG6TgWx9S+DN2GUcdoVeWwsZMUBFGD94m?=
 =?us-ascii?Q?PNE4PYC5W+eglvThYjFd4aO1ZosDqThjVOMOJUJd2qwcoxgoDtLs6C4DfJIF?=
 =?us-ascii?Q?VUXYedYepQMgUhoLj0xa9pRYbm09c8NsE3SjBym8ZvJxEHk263irjRJY5qU9?=
 =?us-ascii?Q?0CG1tsKyIbvNqFwlp3InmN3chI9TxRiPvd6Z+aqsd6ziSaW69NMqWuQ3LY2A?=
 =?us-ascii?Q?sTLv4SjkyuooyLqxjueSMKu63yCsOfOJPda5iDBdYtgUrq4tw6oMOHdhLgcs?=
 =?us-ascii?Q?Xi+43SmJ6uKyFYw3AhQUQ3P2LUGwabBxubjUfQew3fP2McknfonRIWbPIViY?=
 =?us-ascii?Q?uHo+xRy0Si6J6B9THTYxqmO1ngp6ROY2yykPx5Dm/impbPkKLpLWvx3y5P0+?=
 =?us-ascii?Q?NklgIZ4uSVOxyJqwDyKKfWgLvLZsYZkrBi9urpJN6+aHWG6Hxa5nwt5YyNRU?=
 =?us-ascii?Q?9kgq/zb4xRPc9bUKq4wcFDKzVTaCFRDQDl1Isae6KYOaIHlYSBhP868vrjM6?=
 =?us-ascii?Q?XG2FEn6emIZG9Tf1M5lq5GhVc79Z4RQsX9GDnRoJ+y8Z1+t3V9yg?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32fae38-f7c9-4bfe-cf91-08df4bd4c6ee
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:55.5286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkMc3wIU23bjN9Tf02zEOzQiECmXo5OBhg24lxBci/TkiSOyXAn/bPojH8SSzJ203DQ6/+5BORKbjNUWlgQgKReTIWYuOQAQixxJXHCICmqnJKLGI197dolxknz482eu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25166
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e21aa306e82067457f2297ae56af4c91db86c59a upstream.

Save the start LM descriptor to avoid starting from the beginning of the
channel's LM descriptor list in rz_dmac_calculate_residue_bytes_in_vd().
This avoids unnecessary iterations.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-7-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 196fc5aba6c8..0a632dc8f534 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -57,6 +57,7 @@ struct rz_dmac_desc {
 	/* For slave sg */
 	struct scatterlist *sg;
 	unsigned int sgcount;
+	struct rz_lmdesc *start_lmdesc;
 };
=20
 #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
@@ -342,6 +343,8 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_d=
mac_chan *channel)
 	struct rz_dmac_desc *d =3D channel->desc;
 	u32 chcfg =3D CHCFG_MEM_COPY;
=20
+	d->start_lmdesc =3D lmdesc;
+
 	/* prepare descriptor */
 	lmdesc->sa =3D d->src;
 	lmdesc->da =3D d->dest;
@@ -376,6 +379,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct r=
z_dmac_chan *channel)
 	}
=20
 	lmdesc =3D channel->lmdesc.tail;
+	d->start_lmdesc =3D lmdesc;
=20
 	for (i =3D 0, sg =3D sgl; i < sg_len; i++, sg =3D sg_next(sg)) {
 		if (d->direction =3D=3D DMA_DEV_TO_MEM) {
@@ -692,9 +696,10 @@ rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct=
 rz_lmdesc *lmdesc)
 	return next;
 }
=20
-static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *chan=
nel, u32 crla)
+static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *chan=
nel,
+						 struct rz_dmac_desc *desc, u32 crla)
 {
-	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
+	struct rz_lmdesc *lmdesc =3D desc->start_lmdesc;
 	struct dma_chan *chan =3D &channel->vc.chan;
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	u32 residue =3D 0, i =3D 0;
@@ -793,7 +798,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan=
 *channel,
 	 * Calculate number of bytes transferred in processing virtual descriptor=
.
 	 * One virtual descriptor can have many lmdesc.
 	 */
-	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, crla);
+	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, current_desc=
, crla);
 }
=20
 static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
--=20
2.54.0

