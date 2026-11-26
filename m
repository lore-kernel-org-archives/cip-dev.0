Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.515.1795708601204284955
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZjkBrDfJ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.6, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCAmqpdVyJambX6Bhfp8BBqgpTHhLOwIwXMA/TwQIif+X3v9ua2vvpBH+hRBN1aHhQPKS3oaAalaRmMvaIU6n7cAo+iIHZU82VKjBT/y+ZeSdTIfK2cLYcE/Z3S9stgLPf0O2NAdcC/kuDNr/+xMi0mBfyZvxbZTBI4UBPJLb2reBBRdnOPoljmbdBlprqoKDjGv5ACNSt7zxO9hrMUKb9fo1LHV8qdRPw+OGugly4uOnkRBvw8VtovTQnHqmyOlK1YlvFlFakMGOS8E7bl5JGzDdy2PbruAEtWqFmuMu8tM4uw/EHPPRw0W207oZ7PTDmOflPjH1diTpg8M722o7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJuS+sJa0TNHuabrPyl/Lq+O3RskmMz8FybL5vVDLzM=;
 b=RZOjnU7i/dfW0iUssiHKcqJhJjAdPW/2ogxCjFaxJwsHwa46rRlhBk+IWTOSx2S8dA3EWEFWhIlebP3R/IveP2hRmnaj7tBM5H7baJ8gIcZtfi4ZS4+GOgPGNQ85cej5+xa9YbQj7inOEKLN7ZZyyP3uJn6Kj7Z7SD+eF6bPT92yMFII9PJSn6pdf6gUSige/E2K7emFfGyyCYKSFbZQAoSm8dPvAzByLEjgLHRvIYXfBEwi/7++zyXmX1SV9tg7lNDXwekhahZa1qu3tbXAtQpUNVAy5GLZzBYxIzG5q8dy+2cvYw8cTDTOkEzccZ8mmiSL97hmDWKVtralPKsePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJuS+sJa0TNHuabrPyl/Lq+O3RskmMz8FybL5vVDLzM=;
 b=ZjkBrDfJQoEcszq+A/2ahTH40rjZRjTVHtCZtzTlTG2qim2lvhCNd6vwHPrqLtBXU19hiKYdq2mWWLi4N2H/nhVfVBbhyN4V2xP32peZdCNUImMh+uBv3N+cPYxG0Oh1rP83aZXpSDB0eU1rgJTtD1mmMIUahCvPf95ip2tgChw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:38 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 12/23] dmaengine: sh: rz-dmac: Save the start LM descriptor
Date: Thu, 26 Nov 2026 16:55:34 +0100
Message-ID: <20261126155545.3834937-13-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80a7bbb3-72c0-4d6e-4569-08df4bd5db10
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261026130827099003|261028144727099003|261022105027099003|261022115727099003|261022113327099003|261026140227099003|261021133027099003|261026135527099003|261021130227099003|261021123027099003|261102123227099003|261026121527099003|261022075727099003|261021135927099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e8ls8QKc4tAe5fW/9bc2+md0JohLjrywvnksJ8EIUynpLuc7eWklI7tNdX8E2AteOxovS7vVKeoYF13Jb9MENI/enYUgjkc5g3W5+2RHIetWP2/aw/mXtMInV9CaMtyuL53bpnbSEZVynLJ2ocn1VFNlWGJ2SFCTq7+VwN9qxSDAwazg5KDdhFVKbxp2AKhzp3UPTkhWKX73gulCSXTJ4mtjdtdj0T/YwC8y/cBxebdMNKW0nJ0zTjKvuoDAUQVThP5JS5YTpqTH98v4bh7x9tpsIf+a2N98BKJ65pq2uwqTXQO9W1R7BM4WZ4gVMJrxShkxYMJ2o7JoC3GO4jOCUYlldwFMu/+HyW26TvgbVGt2edAmx9g7GmldegpgnJj1WM2NcmvUnErNG/pmVWDcJ/kjSM/V6/CxGnihjXzAPRxNS8XrSXglGw0zizrROiebB1yPdNQXvzttmuX6ZEmn4kKuS+idab9pVh9dQeSKel1kXau6S/xLMfGdvVYoauMwOoisQtQFjZDGWO+2je9leuzqTx6j6Ufss9scQ4XJQC5kfE6mNnk4HIjUMF3AaPNkfdQB4IqvDBaX0aU6Y0+eMLxeL7nPHRM5Yhmt0rVZwMxvP9QgpsLun+qTeYoN+HxC7J5I26lwBa814YsKOGgvKEPr6aIZPY9w6Fs7F7AamVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261026130827099003)(261028144727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261026140227099003)(261021133027099003)(261026135527099003)(261021130227099003)(261021123027099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021135927099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FSCrgAhmJt1h6Etxl7npup+34rtL3L8oEQO2u4dJxqJOaZq6/lAK4NTCr4Xj?=
 =?us-ascii?Q?160YN7bDLdsNT2lYpIdlV4n+eakvaU5167d7Smd14rHb9uF3ZiNY3w0SZtoW?=
 =?us-ascii?Q?NEgseFvPRbz8w3jJmbqwKJ7S4Yd9wt4OUscC1uCKEMe+sRFOfX66cW4I5uaZ?=
 =?us-ascii?Q?Lv+i6TVloEkrSmtcxOw6AW0o3e7rUZIexUtqxNamtBiHm87C4tBhB3Xgrlvy?=
 =?us-ascii?Q?8/8QRIcSs2dV0MReBnnkMeMnpwLJL0wBqzxZ4CWkep88FzhXGijcO3IlBmvF?=
 =?us-ascii?Q?sCEw/2TZzIRs788wY+Pv+bdVq3NWKho2a41iAjPS3ZmvCl0aEU5lSTcgSx+Y?=
 =?us-ascii?Q?joOaAnkAqRWQOe+pHZNF98RbjYgsW+29tT9LJfcE2UxxYzB4SJtFaxfMiuU4?=
 =?us-ascii?Q?uPgy/b3fMNIiNoqiRyuTA5AJAKbuTE1dDmK8aKvzhX3iBoGjBXbuGEcWUBBG?=
 =?us-ascii?Q?txx3FQBokfh3TlzKPsR767V/0gBsXpN2NGawi11UdxK7Fm2gROPmEww84/0s?=
 =?us-ascii?Q?3NzljkOEei1hZKeo1kVFvMHt0vi5AIQz2g298ww5/egH62rJD/9rQK63BpHm?=
 =?us-ascii?Q?se7XIzX4ntT+bByZtCxrw5RA735i+PFOBY+bBIWAEvoOA/kNu505sxlaTt7x?=
 =?us-ascii?Q?kEdPc7+u804A/6/yhRTcFIEnVvCLiQo8bYdC/pWZJwvp2/6A3YbXcLI1M79I?=
 =?us-ascii?Q?TONHoDLEPSit8BFUCRjDKb3ByqfJ83+xwMCi/+9LZJBfXwq4lkSOOXY1vWtp?=
 =?us-ascii?Q?/SE47Q7S4SkFXyMVHa7/qD8U2svLmJD42cKH/rjEqQ8K1CX7yeIny97KmTU1?=
 =?us-ascii?Q?a+99KW4Hmk2snRGtgcHIcYYmgZnx59VwKiCbm+QTZ0q3cA67zlEzKvNhVsWH?=
 =?us-ascii?Q?1RZ/oTu1rc0ucef5E8OE7Vzf38RdZ63hSc0LlD4bEzKtBBKO1K2ZXrDU6iDl?=
 =?us-ascii?Q?uaZ8JTmJPFpOjF+5c9BeAz7o6ApvnHzOxJCWzCetG7ldBRwTNjxzRdVUr1te?=
 =?us-ascii?Q?5bFoOmkKplLznRsIPbcrUToTrzjRpRCVkZV39A9gEC9SWPWb/XnT1BYMOieH?=
 =?us-ascii?Q?JJriv53cAwclh8jmCoO2fx8JH6Hg20614VhNFJ05yrSe21tT4c+GpufrBCzX?=
 =?us-ascii?Q?SakZKYOo28kAZRYkkVlgSjRMUGaqMP6rFls8wSxn4V+IQv5s4ivqEv8CtuoP?=
 =?us-ascii?Q?3Z6DgdSa0TtxoKae4qJbKUuQqHj+7LpEumOPZCqH3pDOrSaV6FMKsHqVWxA4?=
 =?us-ascii?Q?WSbudBLC2bp+8KDtkLiQxLOIbKZfwBBgxx4oYDFCHsMZa9xVYp1uEsJgH/nC?=
 =?us-ascii?Q?ZOr1NCS7l5Il7PpdO0V5ydPTx8c7LhDX1Cy3RpO6ZDtrLFdbOBqvQp5VeXn0?=
 =?us-ascii?Q?UCaEqG6+gI4cMldDvUOC7ckXYBA0A8k+lCpiiIND7gVkZeDjPGup/CPEWIbZ?=
 =?us-ascii?Q?AGzcBdWfAyzojY3Fnbczr7R2PWM8NJct5HdbPG/s/j4wCLjlxTqcNOB+1Rzo?=
 =?us-ascii?Q?Gl31J4rVi8IWTHJ3rUV01ogE6ToLr9Jq7H+8xiF85IGp+KR3vrDP8b4/GmUr?=
 =?us-ascii?Q?nAWRJxoFkSA+6ad5+9KXd5zwQ8mlRUJMumnx/bwOl92DZ7JrBKywQk46FOxd?=
 =?us-ascii?Q?BB/F5y1cya30uP5XAaKYd/ZGfJZ2LA/7OZ01lHeAScSxQMnh3VsIhBaOtojT?=
 =?us-ascii?Q?y+GtK0mS4frM4BrRas4GO50HgwiFxv9xQ4tET5iZiw5hBUIznLVG/Y59kOCh?=
 =?us-ascii?Q?0aoaGy1dcXOWbyowHR77HMgJjfiQPf0+IQRjIquNSIuWCqaM7VDY?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a7bbb3-72c0-4d6e-4569-08df4bd5db10
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:38.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqEWgt8Nmm6UguCLv9McwG5x2nm12OmOIgEbSm95f/xE2tH9FRvI3FaFDbCKJsnSedXVDu3hfkNsAPZhancCSMEGVrYm39RbpKX5jN3hKS+ZYVd0xJ2K0SRRPskP04JH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25203
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
index ee609e072568..2bedee219938 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -58,6 +58,7 @@ struct rz_dmac_desc {
 	/* For slave sg */
 	struct scatterlist *sg;
 	unsigned int sgcount;
+	struct rz_lmdesc *start_lmdesc;
 };
=20
 #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
@@ -343,6 +344,8 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_d=
mac_chan *channel)
 	struct rz_dmac_desc *d =3D channel->desc;
 	u32 chcfg =3D CHCFG_MEM_COPY;
=20
+	d->start_lmdesc =3D lmdesc;
+
 	/* prepare descriptor */
 	lmdesc->sa =3D d->src;
 	lmdesc->da =3D d->dest;
@@ -377,6 +380,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct r=
z_dmac_chan *channel)
 	}
=20
 	lmdesc =3D channel->lmdesc.tail;
+	d->start_lmdesc =3D lmdesc;
=20
 	for (i =3D 0, sg =3D sgl; i < sg_len; i++, sg =3D sg_next(sg)) {
 		if (d->direction =3D=3D DMA_DEV_TO_MEM) {
@@ -693,9 +697,10 @@ rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct=
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
@@ -794,7 +799,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan=
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

