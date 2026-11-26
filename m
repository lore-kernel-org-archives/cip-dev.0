Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.465.1795708574133239809
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=K5xbgddN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.44, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHnT3sfWywHGMDvz3xDWReku0ejrtBzESXnlx7amAZi1VAmkKHt5XkbwqMgYVdHG/L/RZFhw4Wy2yLX58VDaqp2TdlW/jzIeMUzGM4A0tT7a7kQHr4O9jrrdnlXveqti4zu/3/ePu7whYSM2MSdLvn1qlAtI7Egeqf37/En+m/RgDDPR6ZhtYc4iEpV7gxX6iNswo1Nux6/y8T8YGjhpHvl3YddeWZ8AG16osXJbpqt2Lw1ZHcrKIluJhEUnrftr2hlgssUiQOgg7zt6VqnEXC8iMP0+J89sknYNyC8LdwfGBeqaDVWqmw1PvEGWYj8TghfttEnbWviiDe1xEVfl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOyBbln//zmvMJnM9EUpAOcn+9UMnKuUiesGYmKOEwU=;
 b=r3AE0UzlUKDEocSiURqSn7t9flaFyUX48pnjmUfziEHpK1rUPu1e1kGVuifeQWq8CrQKlOxLbYvETr+v3sZBQdgN6cPFQ06z9IntBc5rszmRF489jkBMKsscGtW7U+wTeFK4mItlUmqonNSD23QEfDvq9SDc6rbvVmtnfXrIQ41vDT/F2JOHn1l7ejDD8aUtIItNSZrtrzzkQlF1q34NB+Rrt9H6anzLmmC5z9D8Um1i/stHe2gk515JjRNvRLax5v94BLv3RQE1fAx3v9az9wJ586l3DpRvCNsPrraU9qCM/hP+BgQj3lpwa+QTNQfuEBc4LLXGHhO+Q6XKG7TIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOyBbln//zmvMJnM9EUpAOcn+9UMnKuUiesGYmKOEwU=;
 b=K5xbgddNWKqI8hAHP7Qruj9NXythl5H1mjrPcXXZywOP5JY4/sAXBqyebElX4FGqZ+jdw4DJdQKP2DxxYnm992Qrb5R9vA34juu2ym7lJ7KaNIPi/lUvDJwxOLEy6x62h6EwN0ayA++LgnDcslbbeZsbkxN7J7cGkPiGDpumRyk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:11 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 02/23] dmaengine: sh: rz-dmac: Drop read of CHCTRL register
Date: Thu, 26 Nov 2026 16:55:24 +0100
Message-ID: <20261126155545.3834937-3-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: cfc06dc3-0ecb-4c8c-db27-08df4bd5caf9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261026121527099003|261009221227099003|261009223027099003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: KBDvpq51xJqqjQozJ/XiKDYSo6nC84wI2/ek2cGVHzSyYoB1GbrJB08yIqiwWjK1BuyghXIMuxK+o7bFt59MJK5xKP3k+Qcqjwm0dDlX/aXWuMTBinLENtgoyXBOMfvMVVgHWXsELBhmtAZKbfams0eDTWeqmQlJUdGJZeTvLI+uYN9XPMdyjUEl6dkSGwx1FxMvQ/FXHHM4ESCE31Ld0ZAnxLm9/FxniLPiqvvn3H7XfK/BF2UzVnRv44PVPVulU76b6BsbzxTT5hC429XC6K8bJuUoimRSIRqv1NHUqjMRqcTXULiam/69ZZVaxcim/bYb869a9lnyICSFh1XMXcg2jJpFgkOsD2gTpRXQGOf7ta1D6F2dJfVw6myyOXiycgNzAoYAljda6ua5/D+53ZjSopISmkwI0bZticgPXYvjlPlW3aMW4TjITcaWBJSTbQj2aR6HP4sqtpATS+JLlcspmnDc41VC+3uBKLzCfkPnIH5KPbjrFKZqMqdNoEUT+Eot6I9OmKH87Oe7R6KTBaQEVhRgx01GDJtwfRa+haTT2vd0r2ZQU2N1JkI3k/q0GML5v0pr6yLINu8FceV4gbSPVEM2ZcatBK6W2q/QyN9dNUHJMfXznaPM+5chNvHXCdNciPxp6JKdi5wmd06ltCf12hoQoGj/4EVNR2EenuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261026121527099003)(261009221227099003)(261009223027099003)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ldv/S6mQV8o7SUZvX9Dz4vrROmDxDHPG67ZzEw++NUI7Huch3f/s76a5l4gW?=
 =?us-ascii?Q?SQujLALxARajsuyuN9iSJOThLLlJX4UALBH+bVRAbRP3EAumd9/Bokr7hFGv?=
 =?us-ascii?Q?stLGYo/oJ8BKSv9itw8IcIkg6mvWNYrFGgczgbCT2NVn14hBozRmdLEz0zWZ?=
 =?us-ascii?Q?ig2R9uRVRF+146nw/3m1PkzK66JURNd10WGet91sKArIbz0CEFKdbGWk5iYA?=
 =?us-ascii?Q?EPY/Mo3QBNVqHmmoFuK31+W4NDUKKeHt64Etdkc6Lu41z9k4YgNS/Z+3ptlg?=
 =?us-ascii?Q?IkTy+zOqjUCQyRfa9RDQ8kRrKMkd+HdkUUy9bC1RndbN3IlUR5xzNr+fM1mk?=
 =?us-ascii?Q?f2BHcUTfK/ma35RMz6AJkT6H1xOQSzziKQgh826VzvEhaYfAoNAqfBREOsUH?=
 =?us-ascii?Q?7P0EBC4CM9VuSJhyj9LYWyUCMi10gbFK+zxyndSKRV7AXpMmHwFc0H45idJS?=
 =?us-ascii?Q?18Jzr1XJRkkzPaOcgLr53BbXcWV3QsS53bo22W0x2zkKh29k0SBqa88lRRx9?=
 =?us-ascii?Q?OF1h76bVjnkQcH8kHbD2bgWIu2hk7nrIug/rSE4ixj+fSD5CH4GkyXGpXe1N?=
 =?us-ascii?Q?aYKtByqbsG73yyOz7z9RZpll2HfcuSHe6dG1467ALqHcngHuaIb3TXSgLlYQ?=
 =?us-ascii?Q?Ty62kmT+vcYo77LKbiO9SoMI4tBIBNuLwDNFCnNH8t/nxRtwKyukJ5V1IFCN?=
 =?us-ascii?Q?aVCatIV8R/rCIYCvFW48hiauhBSsTGwRHPThPD9P0UjLc/kJDw6+K95kYWKc?=
 =?us-ascii?Q?IplScxQwDTN00Bd9GaelpCOH1/PcdwxgjVU0XCXxsbw3fpZVhBZrSPMODtHt?=
 =?us-ascii?Q?nADAANjeU8j8rtMglPgql/tAx9QRaiUA17N/rXRITv2Y40WtTOEQAqoLmeRS?=
 =?us-ascii?Q?1XG6hZPiHDdQykVQ9Ggol210s+lV7VA1Pzi0qy1/fegMVFlnlDJ7ybUI/PvK?=
 =?us-ascii?Q?Uwu6Nk314IRK4rM5n65HXR/n2oj4YqiJVdsWb9k8uWAfH76u8jHzG7SiBGfG?=
 =?us-ascii?Q?UAzzyBfQRKKxmnxQp6ea08q1fCH4DlzaEapO+7iXD+RRUijk9deabIbcFUMh?=
 =?us-ascii?Q?Bs69s9iDUhlGjwP26sBsFwJTWHGzPVtguiJBif4tzO0DgaPPQ5P482BeV2Bz?=
 =?us-ascii?Q?YwmjBa4O+9GoYTRgV+mKhg/31pf6z3PEIo+5XggXmOz4B3ESfE8/RaBCubYP?=
 =?us-ascii?Q?nD7ACC74Bnx0QWWsvNxNVrZo/KmZu5DJd38Iqqxv401lImBw7M0CunmpFJZu?=
 =?us-ascii?Q?29eUPZ7498yx6AJOnw0ZrMApUUzoK6QZjh8pxbMsiuChd7wXq5ShtxNJvgJf?=
 =?us-ascii?Q?ecsqfmdCNkNDE4KzZykEhqXEWYjpND8J/+wdBFPNykCxvbyvGDiph5ZE0FF1?=
 =?us-ascii?Q?AHHYVmhz2+Z9FSex2BWRWpMQactSolgtHkwbvmvIQSRqO30Hy30y1YOA7tN3?=
 =?us-ascii?Q?dh14jnOBnBacDV+v+K+UUHTaEonfg8X9Gs+OXNni2B4zKWJJPTIAzjGATjDw?=
 =?us-ascii?Q?1MTjSmCbDLjRJC3t1mMGa2w8bwYkcfcbP7ECn9uEwpoNwN8630BWOnUEeUzs?=
 =?us-ascii?Q?0WdZajDFpWHOIEsPM3h8osKN2fuqPzE9w+zbOB7p1E1eihmlM95IkVC9z74S?=
 =?us-ascii?Q?Z7nuvv0/HdEW/qL0/jLdzOiqykRhgYvgCZV5evygpwMf0xEApuT5uhIec3q6?=
 =?us-ascii?Q?rvbKTEUFEN0jSKicIxO/eX1BJLzwb85S9WcTWRhkBsmq/2esJtQwJdnJIwU2?=
 =?us-ascii?Q?ljvpzfizdF71MoGCm2Jo9GACI9qJWJFfUst48vj1oS4NiHeQUnTQ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc06dc3-0ecb-4c8c-db27-08df4bd5caf9
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:11.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUU8Zwzq0ZYZwRGpmVnW1YVmbMPDvJt6eJm0DlaiYCUiKyJ63t0P2L4sD8jL+yggW2WJUbVB3eq+6iT/sG8v55/ioK2nrVjsmDIjsUnuasM+Y5MSV2O3wxxf8Gv57I3O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25193
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

commit be342fb7f2bb5f641419fef3109eaffd469b0d44 upstream.

The CHCTRL register has 11 bits that can be updated by software. The
documentation for all these bits states the following:
- A read operation results in 0 being read
- Writing zero does not affect the operation

All bits in the CHCTRL register accessible by software are set and clear
bits.

The documentation for the CLREND bit of CHCTRL states:
Setting this bit to 1 can clear the END bit of the CHSTAT_n/nS register.
Also, the DMA transfer end interrupt is cleared. An attempt to read this
bit results in 0 being read.
1: Clears the END bit.
0: Does not affect the operation.

Since writing zero to any bit in this register does not affect controller
operation and reads always return zero, there is no need to perform
read-modify-write accesses to set the CLREND bit. Drop the read of the
CHCTRL register.

Also, since setting the CLREND bit does not interact with other
functionalities exposed through this register and only clears the END
interrupt, there is no need to lock around this operation. Add a comment
to document this.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-4-claudiu.beznea.uj@bp=
.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index dfe9ab617e34..49603a03400e 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -696,7 +696,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_c=
han *channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
-	u32 chstat, chctrl;
+	u32 chstat;
=20
 	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (chstat & CHSTAT_ER) {
@@ -708,8 +708,11 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_=
chan *channel)
 		goto done;
 	}
=20
-	chctrl =3D rz_dmac_ch_readl(channel, CHCTRL, 1);
-	rz_dmac_ch_writel(channel, chctrl | CHCTRL_CLREND, CHCTRL, 1);
+	/*
+	 * No need to lock. This just clears the END interrupt. Writing
+	 * zeros to CHCTRL is just ignored by HW.
+	 */
+	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
 done:
 	return;
 }
--=20
2.54.0

