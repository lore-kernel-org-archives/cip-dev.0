Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06742CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:54 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.5])
 by mx.groups.io with SMTP id smtpd.web11.1014.1755706123471187884
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pvNr1g3G;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.5, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcwoLg3GBKsl3H09LUzfiNJEoSg5994QmsF+WX3BFO1QI+9+9lfxSvM3gIp/vISPK3o4KIZWpvRFNzYTKDn84z+KTbtVRDOyqgdtmwgD6w6L3c3LC+LtbC5p5ScFRUvtxZeoPOIac5fKfkHpSQEnyrm2OG76SJX6nhc6NZ4uQRBNRjaLneXApZem32Knl0AjCjhcrnmC3+PwXc5WNuwHvd9aWqfuhEhW+2YTMEmJGH3WGDfYqCCLU/j5MA5GZqk80D5a7US4A/gmzVal5RDsLY506N91nCkwZTPwYINfTe6NSSPo8OVU29XxTYOoq+8UCDzCoLulFvSfEDeBsACxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpHGQZY1p01VmS73NbrVOh/OXf5CReC9HGAX84gYEp8=;
 b=XQlYu1SA8Ofi554lGy4rbxz1y8dOCW2ptw5Ndo4FmcUqLIWWx7iV94d6Mad4uCom88AX0DTFF2qwts6yMAbpF3rZsWb38w0X9og27LIKlhTb4sQ96o3pCWtjotqSFTml7mEp6pxPXPdRBnKvCtmRQyy0niWsMQoiVcFCm2980x/nTJCgaJZhFzxYHI/yNhdqa1SMwFWwIJwA297//EQ9bhuuclBxVbxwJiAAdxCFrRm8Ym0i5LckFuK3TdD3csSbeq53uYG+1zJywWMzwDa7EJeRy5C/ftz+ST429a2rB+x/psrAgaj9O1cmobsrvoxfuzSCG9/rzVL1dTX6UX2Upg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpHGQZY1p01VmS73NbrVOh/OXf5CReC9HGAX84gYEp8=;
 b=pvNr1g3G1vUL3ZJSN14+oWl8TxC3J+vXC603jsh0YEhW/oPlbH2TD74xS+39wp9kdgn/X9po/FrOnFlikS5HBYm4xrqH/5DPcnI9A69xpRGacYapO48ZIuNqvBzauWIyMpHyzqHuJiGDFl3zayHCRg9hM03iy1YlJI7iSTo7v7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:39 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 06/55] media: rzg2l-cru: Use RZG2L_CRU_IP_SINK/SOURCE enum entries
Date: Wed, 20 Aug 2025 18:07:07 +0200
Message-ID: <20250820160758.801813-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: 00893390-3007-40f5-b8eb-08dde003d335
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3X+zWogRigcb0sGBnFvc70Cw4Cw2cJo4YYwu/HyJRHg2J8kSMuIzXva0LQ7K?=
 =?us-ascii?Q?jOUt7eWWguUpLhwiSCLP9+3LOWVH7Er6VoBJ208rjkANPlgQuzZtc+LEbEUd?=
 =?us-ascii?Q?OKG9pFYpuFuTAFttuTpHvWs8VKMt20pF7yDab69GMC7pw4BnWknE4f3iEqWZ?=
 =?us-ascii?Q?b4k2NdYRdC7UeXB2Ytl0xhzSx9taIHixyMX4EaPmtDkgp4TeA4acoOfA/VZG?=
 =?us-ascii?Q?A7Zx2Ed/N3pixVYmyuwNRcesLbXaJvBhjVraDZzQsz3P6JREr+q53dOqR+ba?=
 =?us-ascii?Q?LUhD3gF8o1cr/7wlJYtlWT9Bwp9C703Xgnd4wFoLSJrifgn49KQhvZdjuLfI?=
 =?us-ascii?Q?rBNgdBzWJhSi81B0HbDJHFqDtisHZL5Se/UFiFwQF30PqrJdhxUVM7AYB+NE?=
 =?us-ascii?Q?OfdMVPTe0xC2HcG/P5Qnk0A7Xo7ExZyx/1O9T7ze1K9p4Swv5iuyWkSE/UUJ?=
 =?us-ascii?Q?2ECr445A0610d4FC1EPm28iSwQ8Ko5CVfAit3ebSt+j9WmYp45nx1O6jS/ms?=
 =?us-ascii?Q?XRs4b0qp38k2R68pIHgO2VcVJgsbwMG3XDSXbgtkL+vUqTOCO6ns6i/orcPK?=
 =?us-ascii?Q?LCGc5mMGGrmEAA9JqpUfI7mwtLr3KsQa1mhNYumUhVjDZKF6qgjT4Uk01XDS?=
 =?us-ascii?Q?thlW/djvPcKSIhJnITq7B/p9cKc9YEX27rBc3bOhCMGsrHPBR/LfVLBfdEt9?=
 =?us-ascii?Q?DPPuectuwUAETrOFvZK5zzYl+mB3+P3e+/zSJFYHAUJ4PMzZdW6blmaFt9Ml?=
 =?us-ascii?Q?asiGJTcSjAedPUabOzfno7PnRoRmD72HW9gyuYnKQn7Q5zdBcfHlgWi5MCgv?=
 =?us-ascii?Q?wsqEniDaiydy2eqfqKIeFRgB/W6swSIh88OYCVHBxbvVrlomyTJZDAmVPYVG?=
 =?us-ascii?Q?05TAajwG0Q0Lruk7KAbIyykDK9dI2BW5TuJT4eJH/nxyRbzeRi2QyMqVsW89?=
 =?us-ascii?Q?x87ms466JDyAo9tZwIFSHen5BQH1x3qw87eiC1HDBrJa9JfrwraLKlc2RVxQ?=
 =?us-ascii?Q?C2CDxPiN1KvknMjw+KE3/2paSoM/TCUu8KGV8pmNEh0nppdrnrU3iekkQCGt?=
 =?us-ascii?Q?RLU/KlK5QVp+hkfHI78pEoAwcFptesmfUYh+WDLSxM9zxei03eAo+hdccJ34?=
 =?us-ascii?Q?+1F64MNVCSHc1JESTgwCf7YwqCIkPxmyOWs+MoHbT7o+JDcwZ8CuHy1mzfbP?=
 =?us-ascii?Q?+9M3buOn/SBiKC5qC8jjL0OUK4FSLWJqvNhULp2TsHVhcRzKvWNHi3MbFOYc?=
 =?us-ascii?Q?LIZRhCpnKzGRS5pe6dLy5n3klDw/6SqEp5gwGi2t4p/LOtC9vmINtHb2ybYl?=
 =?us-ascii?Q?zh9djhq0kH6ed2n+5mct922/k1nnnYbNzVOZ33MkM7CfmlrrtXiUOEraM5oT?=
 =?us-ascii?Q?+PRggKtMhEUnrgcKnDJIIckNuymZ6IkwybLiUgrPNMBdn2I1mROPq1G7NbZ0?=
 =?us-ascii?Q?qIl9J4VlW8dqxWNJiayEe1olXReFwvJbny76zHI39SPOHo+QSDzmr1d1N1nN?=
 =?us-ascii?Q?GmuH5TNq/rzkkes=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WbqdhTF+4eRxEiAZf5bg7qCobZIgqCv4kwO1/tPtO1iPBVynFKMKQeDZhdhU?=
 =?us-ascii?Q?G1qe5aKYvMaOcMgfdb62gFvnXk8V2W6clLYAF/W5Td4uvy1CDT+12y+q4w52?=
 =?us-ascii?Q?AF8Zn3VToY1onPHB/iPUvqbHrkQDpRtaM28nv45vrfYfWlKMfzSVKTUoXuoz?=
 =?us-ascii?Q?K/eTweUdmfsktdWq+b4Jr+weP/M9MBSXDEpgCeBRekJn5+jE/goCj7mO76dr?=
 =?us-ascii?Q?XvlG3LBfLEIRSMcDxedJJsQyhsKbzbZGJX0+6Wy4jVS3GS/avdW3Dl2fU48B?=
 =?us-ascii?Q?usI6VFxAwletbErvg51BpWfQ0DeKlhPzGqSoJDq0VNS+GccZwCF9yyFc7UIk?=
 =?us-ascii?Q?mOp5XwAxQj1pe7JmxHJwKD4Yi9iAHcRm6e/SygdpbLP9l/6npZS92A8rMHfr?=
 =?us-ascii?Q?6utXsTFVxa+NKr4KCPnEz8OssqOOtB3OKqefMEgK1DqoJactvTztbw7HQpcw?=
 =?us-ascii?Q?E+Bw7/s4nvTGcOBeamQoPCck6Rw7OU5H7ypwjJO3h9K0lw8VcVsqN8ZOh4jj?=
 =?us-ascii?Q?FZQwduQu3DuRN+oLNS6sEdBpsryg3RbzAZCqJWuU3ShFJmEWm3ahk5QqqUkC?=
 =?us-ascii?Q?/BIPAobx7yp9ewe3e6n0bFRAoz85ACOH795yDlZV19mrRL2Egh+j4cSJt6+H?=
 =?us-ascii?Q?4gaoxUJB6bkKHABfhAsV7iSlHVa8KR2BcFwnSNP4QFbe2KXvvB7k1uk+JfGO?=
 =?us-ascii?Q?h2qFW3FxrgX6wBSlFT2B/vPbCmDQ73igWLfqJSUcTA6HngQaicSY5ZOfsXiu?=
 =?us-ascii?Q?Du026knHdnl7c7xuk7aUFw1Syw79pCcvSNgMxZPNXP1GzzHrLgNq41cy30do?=
 =?us-ascii?Q?khNT0MZnQyxCK3vqvxSjW6SMO3TB2DmyIJHcQpN/+zjjQHOofwtHlQZD5N6j?=
 =?us-ascii?Q?16Vwm6NuZqyUZJNk3vKLA6I9EpDFj2xW5Q/kQNfzLcvFT1s2QlKYHWCpYDLE?=
 =?us-ascii?Q?9AQxvBMw3jQDrdGnbMKsCcx83yZeLdPjsI/phTcHzzK8tPE0+JUuXWJe2sU4?=
 =?us-ascii?Q?xTVlBu6pnlD71CNOwipbnMKdDIjKo3S9CgI22FWEZquXwOTh1VxN5uZabYS9?=
 =?us-ascii?Q?gvUh1XXZ3H9BPH/9Wp3u+6XRAzKqbHkH/tLAYPj4fPhYPAwRhSpujcSahxXA?=
 =?us-ascii?Q?TrRnRMEYCj2SF43DffYACHsuGJEvqjWV7nVm3tu0Rfh+5L3SlSACSx9UdgPc?=
 =?us-ascii?Q?aV3HT8YOznhSsAFv92ri1O+bJYup2yfTGAckBvpHEQS8g6k58W2sgSO1Uohy?=
 =?us-ascii?Q?jmiKmrmmX89qZIIrSEp2SvV9/or7C4G2ZDAWba9e/zLtJSQb4uFYY/3WNs/f?=
 =?us-ascii?Q?dqXDXmbypuO7cYPe5PsQA2fyJcMXH+RrY1gibB2HKSKH/wq1rawyNWCVpPBd?=
 =?us-ascii?Q?PCD59qfaDIKuC4Uwr7EQUy/5a33YhpIwgMPdBrivWuNViKNT4H5zoq1uKG4g?=
 =?us-ascii?Q?+zuvHK1NR5hGsH5B5AtG2oKWVScKy5D0YwNmkMrWGI1VdyPRSugD6s2lpA1p?=
 =?us-ascii?Q?Epa45hBZ7njubJpq4ZhqtLW2DtKAFmL8aqjH5DPS9gRXBjRyLX6ib03fWJOE?=
 =?us-ascii?Q?xerpeuqf6yj4JjSEeIGYcKEpm4N4sb/54+n++77zwK3CFmXAO0Z3RdsTB6f7?=
 =?us-ascii?Q?lSyUBVvy8YyfIH61p1lEkM0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00893390-3007-40f5-b8eb-08dde003d335
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:39.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DTG9FxYiPRrgpKdr6n5ORIZgO7DewYPFlUEVrTCicPNk/RGKX/7p75HExpXp18QvdLDAHoNlmu3RNw/UsaD5ujle+VMae71TvZuv21+ssXGqyaJGDpk6GN7Dt+UCaAg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19888

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3b954c34c3fc9c353e3d0987d40e134e024986bc upstream.

Use enum values (`RZG2L_CRU_IP_SINK` and `RZG2L_CRU_IP_SOURCE`) instead
of hardcoded array indices.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index ac8ebae4ed07..9f0ea1de50da 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -217,8 +217,8 @@ int rzg2l_cru_ip_subdev_register(struct rzg2l_cru_dev *=
cru)
 	ip->subdev.entity.function =3D MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
 	ip->subdev.entity.ops =3D &rzg2l_cru_ip_entity_ops;
=20
-	ip->pads[0].flags =3D MEDIA_PAD_FL_SINK;
-	ip->pads[1].flags =3D MEDIA_PAD_FL_SOURCE;
+	ip->pads[RZG2L_CRU_IP_SINK].flags =3D MEDIA_PAD_FL_SINK;
+	ip->pads[RZG2L_CRU_IP_SOURCE].flags =3D MEDIA_PAD_FL_SOURCE;
=20
 	ret =3D media_entity_pads_init(&ip->subdev.entity, 2, ip->pads);
 	if (ret)
--=20
2.43.0


