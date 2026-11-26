Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.309.1795708162899912729
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:49:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lqJvvUQy;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7OofCYBct6BXswjmEI3y7a1i34i5rpQ/srp2vB3Zfui96PIKzdv/t6IGqnWAdnBn6k+o+6zI4ni3Ey+dGeKhFdZXwlUE30gR/tySJ6070a3QHMO+/XQpgyj2tuNHTsR3zY9L5Zrx+PdiMjpXZESnyU7Nyhf6PG4ob/N1lErIE7RFm5L5iiLOstInOeCyyTetOPhWN1r2yvtd9s/G+a9TfZ2LGgtj+qxR2OVLCviPPFaOyeL3ViSsI5DLlPsptSNlmF/65bxC2XSxdsP2514Qxz/LE1uoGinw8lIqa1QyRoGw1KOBeN+/hAAtDDYhzHh8D+LqZjLbP4EAmWgAVLADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAdqTB2mlbSvtEdDHXoEYS+FKAg9NTi0PxopGjM1toU=;
 b=qopGpUUdTkcKy8YJli6zIljRv4ByLMkxnm48zUkUoxppH46sNS+4aw5G6ng49pEyyU7qr0N3Oxkxj3dxgW+Iv6RjCdJUcQvQJkSTfqVC/MeO4zPcCY/9MLknarT3ohYmCnE1UtkPKvFNT5geduWhAm8qVY1RdtWYo5g+LPcrMDS/KkvgVSfKrqo8mJiNx4XfOUFt5ioIvRFD4uuCTYuxk6By+N8Yf8S05gMWnW3hROK2EbPUCYwptKQpKAYTvaoJyjI+Xl3dpS50pvTYRv6C1tdSKFBmugJT2Jtp0SojuvKNjags8LyyTTKasTYXjXGgfr5Nujl0zXO3aVF0TdNT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAdqTB2mlbSvtEdDHXoEYS+FKAg9NTi0PxopGjM1toU=;
 b=lqJvvUQy3oHuJfCEgjo/napeuyNwjqjHvnLlPCD/n8vxQlN4eiDnN4LIuom9YEgZ/cjf5/4DAvNcq95D/BezZW69YCzX2+WeEqmLsmkaNZQd6Hba3L2PUvMYbFznVncWElSOpKVfM6z0L7ojvwu0OaxPwLX6jc2f0v5zcxSaEM8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:49:22 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:49:22 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 26/27] dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last descriptor
Date: Thu, 26 Nov 2026 16:47:46 +0100
Message-ID: <20261126154747.3832917-27-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: bac06f01-8c36-4fb2-4bf4-08df4bd4d6db
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022115727099003|261021133027099003|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|261026130827099003|261026121527099003|261026140227099003|261028144727099003|261026135527099003|261021135927099003|261021130227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: D3oGQU+0ei1gr1zAPOdEYYj3roHPbdjEnGj4sW6KgSDnNvbSZja3/XVCPen4MODiAPJDN2Yjn/Ho6OpJtgK1Duzq3en4y+7I9p/VoyvBypzbOREZVHI/hJyB9NJ15Mg2VMuATXxqD49ar0Kgpq33atB4pypE2ijO/o140Ri1Qly7hgIycdoHYQUrPpIisuhN3xFvPhgiEeansRraOrAkrBnSEeeh78/CZEN+vV5fp2E/YkB4C1870DzzvjSxRmOi0unKk3PKmOTVhixQQ6IhoK4RkgGjAF4z8A1RWROZ8qGqPSiJj2Q4cVYI0lXCe5w9vd3Er7culfv20ASUkYwAho5OEAo4GYqnNh6rvhWCGrLriGGQDPQHslJ+Tt210Bzvy6d8Sh95OVTehk5jMOZGC/VwRz7ph2ctnK7L+/3ml5EFn5r8eXSzrHMnzYDPL/R00RszSd912JUbrjLNmlIRaw/J6BvyRzkEX+lrD6lRsCqEu9aX6D4y/ZKR5s6Ih2HwsGT+LfgMkp92Xqqst8waEVSjToZV8FvvCeMnPgM/EFbqZzw4q48Scb/2x9iPCCwdhP9LOVddWn1TtF5CX6jMIxFt8Cxhl3PL+bIGg+6ne/S0c+tYXr+koPt6ymbXDJUVWELk6qkVKcb6PyWhIvE/VOQliHbpVeYoTRBEvSWrkMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022115727099003)(261021133027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(261026130827099003)(261026121527099003)(261026140227099003)(261028144727099003)(261026135527099003)(261021135927099003)(261021130227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BWj7sAesfdNkGOXyg22GlvgK/ie1bmnU5u6+I1U9yH47azl6MdMgF70N22Pw?=
 =?us-ascii?Q?DZA/qNvz2VTplCq/zEbKq1+HflrgpIIpn7GyvtXoELjzmQvxUSobmLhtjnK5?=
 =?us-ascii?Q?obeUP6FS8d0F3AeYrBaaURZK5I1tlDY+YrcY2sgbFg8ypoW42M3s03KAJ3ie?=
 =?us-ascii?Q?uvU8coJC5hT1fd1bpnu0NdRyqpvnYW9hek1Oef2pT2fJdnq3Kmb4KlagWinV?=
 =?us-ascii?Q?Y49JPM0anmlj3VeGBEK8hW4VG95Sthaph2fbE8tKZlvXtKKAX9XcM8bfW3jl?=
 =?us-ascii?Q?dfklAYuJPYwK+kdWaFb/cIYDf19+Ex9c37xkdkTvMsa5rOEKHAH4dJjSXiwG?=
 =?us-ascii?Q?304cS51Y7TxdgIGhWZYEZGayDx5iW+hgKxElXO/ONQYlpsBRG/8RYPkq85lH?=
 =?us-ascii?Q?ztS0akN3akp4zTWwbZ74oIWQd48rO08ovz6eXYPDsFGpfl4VKWaE2ExGWR59?=
 =?us-ascii?Q?fmutVDX/PJrMMPQvFQ7KYRnEiwVQkdQAAoopk6mMN7unon5rssFQX2OKiOzE?=
 =?us-ascii?Q?KYrR4wphWm33n5DPkozVXRRKQNupeC6I8XtpMggfsLU5WkZdgmxKB2s9NizY?=
 =?us-ascii?Q?7xWonKO1rFHhL2IDD2XI9RdU5oQYqXkFj566SaMdgx1rScaA69DG6VemsGsd?=
 =?us-ascii?Q?yv2AwaMAnxyXLYMP8Qb+sXOuJs1JhmzQQAtc7guV4UsqiJltjly8Ha9fOUsm?=
 =?us-ascii?Q?U9k8gM4gwgmGayV09SOKHYNJNUVucclKA61ntOGvvnk1O3BDxNLHRwhTCmlo?=
 =?us-ascii?Q?J7gJUaKctItSGwK0ddsNF18CxNlv088r6F+4KUhw4mjO62MXbFBfKd9kVxjk?=
 =?us-ascii?Q?EhDctSxArFCyDgSwjT9mXv3N2JkWJ5NDaQtDE3r3UELhD9hEYqA1jTSjS33A?=
 =?us-ascii?Q?xUXdaSzy+DfuBIN+9wyNVLw0VBnJ7mDQqIivCcbr8XPik0AzhQO1JQ2CjMLA?=
 =?us-ascii?Q?TkheXzgkGuLxVZT9IUmt5+NBziNaOOU7kEYN44zFUxwWbdtR1Vf/iM6udP+/?=
 =?us-ascii?Q?tPjkoo7a1Jj8Q7T4qDD8mVp/6HMGwQoR7V+vvIpISmnwET5Sl6ic8nckF5Dn?=
 =?us-ascii?Q?djgASixoarIoWc6wmYPtksjCawMv0/eSsXh7lwGA6jivUdm1vj7yYeB2LYBp?=
 =?us-ascii?Q?Sts9XA9AHf7MFjDCjGhqzNXgbZm6Ya2cJD7nofcTxb1gY+S2eXKrlNbt+k4D?=
 =?us-ascii?Q?mYfBj5m9lH3G7tPIn+Zp9S2axqnoTyIk5E6UiLD0OMHJTpUq4JkmdwaPtEMC?=
 =?us-ascii?Q?qNuO2iEPjPqabw/9pSTQZGd8DRkCjXlraOcpPeTi2BI3Vj5W3YFY0aNE7Gu4?=
 =?us-ascii?Q?vrRIdPZyw+E8O9kb8njKh+BBkk/KIlm8aoiO850BKDZcWjcrNujuaQ3kwh6j?=
 =?us-ascii?Q?pOz0Z4tcVWS9gzS0+votOIIVFDbBM7hNli0IDcxIoTvHT4sUgl3VjbmcElBC?=
 =?us-ascii?Q?81axyuAWhumNs3S2jFcHxKcLiPnY17BMBxNHWNG5U1GOKNDjWqS+JbLAQyYr?=
 =?us-ascii?Q?te0hxQZy+sjy3WWbEbtnsF4QxulM0mmbCwQvnUnrtiChMJnZRwmK/zwQo3Vg?=
 =?us-ascii?Q?WPz5ZIL1qHi77kHU++hhEGoBruqbH+fZXEM70sDEvZFV9VnzyAKObScictNv?=
 =?us-ascii?Q?miBwGrniYHQ5t4cj1LnbbScE19Uk2vFB/StHZ7JQ3T/afkgUV+Pgigyedyxq?=
 =?us-ascii?Q?YVfTXckUbc7JIuFQ3mEBAZLAq6Aw+JDNHsYFdU2yrgm2Lkaxu/YUk2DDbj/N?=
 =?us-ascii?Q?Yi+saW9AFGJ1UVZsNn81RZZaMgNnmuxH6fIoSLQKD5U+kzCuG3eR?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac06f01-8c36-4fb2-4bf4-08df4bd4d6db
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:49:22.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEjGbg0z9V9nrEYEmo/poS/gJrbphvFr3wYISnxRtl4zr299tZSWwjOE0RECGoqG3XYBcHqGwzzvtYWIxhHubw7EUIlf7by2FcKzkXVveTnwppFnBeNclv2B4EDA/xPF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25176
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cd2d36e8ae61832aaac3bddf5aafdab72821e6b9 upstream.

On an RZ/G2L-based system, it has been observed that when the DMA channels
for all enabled IPs are active (TX and RX for one serial IP, TX and RX for
one audio IP, and TX and RX for one SPI IP), shortly after all of them are
started, the system can become irrecoverably blocked. In one debug session
the system did not block, and the DMA HW registers were inspected. It was
found that the DER (Descriptor Error) bit in the CHSTAT register for one of
the SPI DMA channels was set.

According to the RZ/G2L HW Manual, Rev. 1.30, chapter 14.4.7 Channel
Status Register n/nS (CHSTAT_n/nS), description of the DER bit, the DER
bit is set when the LV (Link Valid) value loaded with a descriptor in link
mode is 0. This means that the DMA engine has loaded an invalid
descriptor (as defined in Table 14.14, Header Area, of the same manual).

The same chapter states that when a descriptor error occurs, the transfer
is stopped, but no DMA error interrupt is generated.

Set the LE bit on the last descriptor of a transfer. This informs the DMA
engine that this is the final descriptor for the transfer.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-19-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 351753dd5049..c72e76a1d926 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -199,6 +199,7 @@ struct rz_dmac {
=20
 /* LINK MODE DESCRIPTOR */
 #define HEADER_LV			BIT(0)
+#define HEADER_LE			BIT(1)
 #define HEADER_WBD			BIT(2)
=20
 #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
@@ -381,7 +382,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_d=
mac_chan *channel)
 	lmdesc->chcfg =3D chcfg;
 	lmdesc->chitvl =3D 0;
 	lmdesc->chext =3D 0;
-	lmdesc->header =3D HEADER_LV;
+	lmdesc->header =3D HEADER_LV | HEADER_LE;
=20
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_=
no);
=20
@@ -424,7 +425,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct r=
z_dmac_chan *channel)
 		lmdesc->chext =3D 0;
 		if (i =3D=3D (sg_len - 1)) {
 			lmdesc->chcfg =3D (channel->chcfg & ~CHCFG_DEM);
-			lmdesc->header =3D HEADER_LV;
+			lmdesc->header =3D HEADER_LV | HEADER_LE;
 		} else {
 			lmdesc->chcfg =3D channel->chcfg;
 			lmdesc->header =3D HEADER_LV;
--=20
2.54.0

