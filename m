Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.477.1795708595616837997
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=l622dooq;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1e8GHf8pf79taP171jioY9LDsDb7Yu0VcT9z0L3PMFQNvh0kJkJyloiXNeo/xkOZkOclXjV2kmLijFwUMsMMroTr/7lMecxWUEIhmHBaDDePnoF/lIK5jQt/uQ3V45vrbAxX48F47wMJjD3wB8ZTt2AUd+XcL27yeTAtLbqzDYbSrvUcmmrgYxwSGhrfvR+BVGbJJxWCLHysjjQgPP/stL7XADmKMvmtZWjKZ2ZW+1KscW056V+GUdfshq/sugfLdu7CbtjNmzr1XkHZ7a4Y+y2w/u4qBZ2s5MckbHNu7LD+XxLlOb2Ql0RWxFt8/SeZqCQB+MVmhuwMOSD6mp6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0cJI8iEgDNf5KqE1Wg11jt7rekki6rGI8oubtdMw10=;
 b=XYC8KycGPj1AoPggpk10ImFqD5PpHwc7QIaYXcRLSUKOJUW0ItcasRyAw8a2S/AJS6Nq3fFAOrssSif3VleCkC2AFkYkvpBLJXgTZfhTUvGd3O0EMYEk5/zcv0d2OmoAbmiGUyVg9tKepK2jbXrD3aVknioR4IX6a0i1JDMG4rqtNilylMZBEyoe5ynhir/5oeyRxSDTnNbn73DhBMas9nMOt02bsUDL1lQD9kEfFnlE4DpkBJACe6HJ/5Pc5d+YMeoGd4P0TSOyuIlRdLT1ySspUKmQghjbX6JUAzU32nuAurNM92GIvAgmcxeQyc6i3N1URvMkBj3o36H4OErg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0cJI8iEgDNf5KqE1Wg11jt7rekki6rGI8oubtdMw10=;
 b=l622dooqkrq8D+4Zsf7c0FqLyNkiYznK8FitG1laNIGIo7MORjBv3gRjVVyjXqlF4jNy0S6LjSjNR53okgd+sBozZbE3ooAzA+vz/IPzody1SPrFZ5XjQpbutrfJ6HKNBGgQ+S9RHJTEZyWy9DEL62HgvOhLnC32lJlEpaqklRI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:33 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:33 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 10/23] dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
Date: Thu, 26 Nov 2026 16:55:32 +0100
Message-ID: <20261126155545.3834937-11-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: ed5f263a-7573-46c4-678e-08df4bd5d7f4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261009221227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qZNPnDTopE9d8FBcwLevXOVR3MJaAbRV7r97YgbfGwLQzrOmmiKac5GpCidtGmfRlzMUq4zYpfFHVF1hb+ts3TdU6R2l3qNAPuMWL093zpITscsHgrep42LL0JQPieHL/ifAguP3Ia0TcH7UdXmOffbEvdT+ekfMaGGO6Og7NL4I+SmHpTdvDM+UkqQbFqI3mSots5N7eLm5rCp8gqjr6J2XCOR6g0/PeNbPHGbngVYJ40FIo0nnXpUMDcPyq4DC+NcDipKaT9pm365awlPoFM39/fAx0iKoL9NlCvtJ00BNa87MlJnHtWSRX5een0L3/XMg+UBQUEtRlurVkfM6UvHhv4PK1m1DtaGp0/W3B0/3JItABZvdQWLy87mgTrX53DyfBmzNeMVUnUf5rmsGSNPqECdOfgJqIe+b7eT1KuI7iLBewvWX+/x38ibwjtQbxeNEV1UTNxz1bH2qelpFAn4lxJqYE6FSGRjk24eyXVx37q146FVWJi1MclBzn4ehflYpQMXitsSPfHMRb6p0aTq+QJXhBU+UlBlh9PWFTfWhMqbmJBfkdW8cD5jJz9baGPvWksa5QQP+69nJje+UvuDdgCdeYAeIbleBzAHK45tJX6c7tcI0wwcEd2/4FLr6QbUA4u9IyqcCgEGjjbWEPb3J+Iwe/xU1atoTmbX10Vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rLW+iyJw7DVnesZ71StFjvESpynr4db+U5bqrr1a/Q9lxzYkB9ZR5eO7+zcw?=
 =?us-ascii?Q?i/Maqdgry3lbIwebrv/1UnQeWcXtfzytmoO+fejN7Fl/JgY/hQO7WywPzjYY?=
 =?us-ascii?Q?JafHzxALOBmxT+voHXOf1H+oZ/M3bSafYFViwGCPC+ixAuXW6LdReInrPIUv?=
 =?us-ascii?Q?CmIdI9CAOaic8A8s2FLg4uKIR2RSR4vFjvBg3ntykR7j8Xy6r08W7LxHg8+2?=
 =?us-ascii?Q?WaP15ge6A4pROyYsuEwwe3Mjn70+DlOpuNtJ2FfPrXifgPSSAGsNQLlgixCf?=
 =?us-ascii?Q?mIRDvYLlhQXhIPmELBbRmWSLD2xy1yTENIMWmyjiYDF2U+zy5LnrWzbJcec/?=
 =?us-ascii?Q?o/OSYZY6TfvUXeB245l3JHRPRBSYRqSQSwY5wv8EK2EpvkEz2IH0RCHh3cW1?=
 =?us-ascii?Q?3Mv62I6Lccd13Gjc7+AQSSw7bgpoteL1gvHvp97i/EfCuwDHtZXjnRAebqfE?=
 =?us-ascii?Q?iZquIrL/zS6AnihVCa2aPsG1Awvx7ZM16kaExtbz3d+8f2Tlq8r+ZkRG6wSX?=
 =?us-ascii?Q?hsmUAny/dyA4Er1kgUxAf3Yb3jrawWl3C9NxCkHrK3WrVrrAF4nU/jyqlQD/?=
 =?us-ascii?Q?3DRE985PfNTymrEOdLweZ1hoX5+votQ5XaEbTOiFMbWDeDgicf6JU830CDri?=
 =?us-ascii?Q?W0fgM1megLDMR5wdz3wXWV6f3e3kEm3taZXeTgPSRVoKF2o9urKbrQSv78oi?=
 =?us-ascii?Q?BcyJJaI1sUzKmH8P5DqU8suniZ3beGFQbIta86DqEtV1Noog+yaIFoXy1Hgq?=
 =?us-ascii?Q?cY/QKt7ewJwqMx/WsPZtnkrJxJjF0gh2/ffZFNS2Ke59sIcO8Bflms0KwJxi?=
 =?us-ascii?Q?SpYJTBVAYW6TRwBHsZp9tvOu8SNPqSdbOQSZbhSFDlDlLz2t3dtZ9xZ/lWSC?=
 =?us-ascii?Q?FA8uxyBuWsDgIRsVsI2eW5vaDigQX7sfBwHi5tETRzYcLVX+Wj6rZOQju0uW?=
 =?us-ascii?Q?xRzCv2zD0K+xkibVw5jWFJOBzjwva32WWLqs8aMZoszMIZuU4UVYyCMkcT1M?=
 =?us-ascii?Q?B6koZC727qeE4AJtp2HJTdRAjO5d/6iFYfA5fVWJT/bJTNcUdcT0oZ7L/ll4?=
 =?us-ascii?Q?WtJrS+4HMdxUVYXUHyfT4jPvNfi6Ey744KQsRJvKqSXf6v9SxT0wpsbqn1FM?=
 =?us-ascii?Q?YYTMKF2HGLqAEd+/6lGn9uOjOucP/1gekwRhuZ+sZlJma1gvmiPCg3nWLR7x?=
 =?us-ascii?Q?uri8l5L5MKhnlFiDdnTMDh9V5lbYEPwlnr4TAWjXVGQGr98rKr5Wc0jUPGXO?=
 =?us-ascii?Q?3ug0tt6rELMQRQE7qwOJGo9y6DWprUnX0ElG95LVAIkwEMJjBFrmbdYu3E3A?=
 =?us-ascii?Q?VVGr6TqpCMJtBmisjACWE5HjZnU5XhWvu4yhiVQ34EOEJn4daOVuO1Q9NznK?=
 =?us-ascii?Q?AZyXBEThSd2rNM7s/BURegDyHWQRv3F96b4SQEtb1D7fJ6MmbNe3jixBrp5U?=
 =?us-ascii?Q?ESY5ReNf0SD35pob3kFzkLSwEy05Wtb5W7r+5BV0acSZ5Abqx1w5dGf8lVS3?=
 =?us-ascii?Q?hC7asQzmrk/wBTH4vqpu4mM7J2jwi7HARQhPzhVDupLJovEPg71UTjr6utST?=
 =?us-ascii?Q?i3cv4fuD4JnErpwakO9qrvP9ofNUgnrXG3kzGJYFiTSZuMhyLb8Y5q3Hyhlc?=
 =?us-ascii?Q?qakLdiDfCl1x+HtXgRnLOmaMGxm5WYespLrTqXdyaRBbnpTWjmntxaHlh6gv?=
 =?us-ascii?Q?5WgOVkBiKLCN6L1WJAlovoXMuTUvCIjcJIrR/O/J1KNiqL4UDBPhAgqxpHab?=
 =?us-ascii?Q?zrZaHkv5IVD4V6jymWBunxe0eS5D5qlpjVnphmJE9YI2H0VI8uzV?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5f263a-7573-46c4-678e-08df4bd5d7f4
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:33.5853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrJ7Xyr3vpULBy4PvCApazGEC6GWLLJ9j1KsmkanpzIPeJDF+vGoboR9CVOEOQT9T+e2fB8YBNtk5xEXovgvaj0mdY0Z0pmmwsCnjGEq/uF05R+6JSAqiMtY65l2uWv8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25201
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 38d4d021228386b8e3fbef2bca5f1e91eacd4fe6 upstream.

Use rz_dmac_disable_hw() instead of open coding it. This unifies the
code and prepares it for the addition of suspend to RAM and cyclic DMA.

The rz_dmac_disable_hw() from rz_dmac_chan_probe() was moved after
vchan_init() as it initializes the channel->vc.chan.device used in
rz_dmac_disable_hw().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-5-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 8bffec73f556..04f072c6af88 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -873,7 +873,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_c=
han *channel)
 			channel->index, chstat);
=20
 		scoped_guard(spinlock_irqsave, &channel->vc.lock)
-			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+			rz_dmac_disable_hw(channel);
 		return;
 	}
=20
@@ -1000,15 +1000,15 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	}
 	rz_lmdesc_setup(channel, lmdesc);
=20
-	/* Initialize register for each channel */
-	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-
 	channel->vc.desc_free =3D rz_dmac_virt_desc_free;
 	vchan_init(&channel->vc, &dmac->engine);
 	INIT_LIST_HEAD(&channel->ld_queue);
 	INIT_LIST_HEAD(&channel->ld_free);
 	INIT_LIST_HEAD(&channel->ld_active);
=20
+	/* Initialize register for each channel */
+	rz_dmac_disable_hw(channel);
+
 	/* Request the channel interrupt. */
 	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
 	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
--=20
2.54.0

