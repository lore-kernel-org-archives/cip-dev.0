Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F93CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:34 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.64])
 by mx.groups.io with SMTP id smtpd.web10.1091.1755706168715082516
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=BdBu40sH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en10Ap82CqqV8LP0gblLIws//+vGllR0t/qLso1hbvhJQxMcUo+tnapL3rcBA3b128KNKV33tUpqU3zcKPy8WDnEKxlVMeoUAld8O30oJqBzqQrZtr60u3Hwo2gezxhHZtXkOvLmG5Hc2BlYptUZEQoRdtI1OGr5s6VD32JdzqqLxWh2djXOx+6tmiFdH4xw+g/6lemdx+QyyJA4u+lnZMO+o3CxfWk3teCH2Xm5Wfd4olPYuw3Y98CZyi7fGKwx124lemCxrrsQe+y0bRkXhMe6IgndtEmIxhJNsKi6St8ELhL2nAc6ar+5LDKIwBbHhO11Rd7TlIjOC+Js1Z/bCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OozdVRWVCMUajabzfHo/bz/nRWRNCHs1cHN51UFrOj4=;
 b=ubTRXmVhT0UvkfURde5QxtLema/UQIY1GJ4p7w+JlhF7dE759N8gc7EPERDthZd7eWyZPQt5f1Ncg3/l4gOPD8k+w9bfp27LQNgONS46X8taprKZosK5WKvAjdgOPcZBnxFH4e0zu/8j6WRrcIZbE/raElo3Hq8lKbsTUdp/gWfHdZz1moXN/pWrrXszv5XCx1cLwK3trhP/xQZ13RrwsKKk+ry/I/ZRJQFMuhlzyYMY+kgeHqWpz1zzQ8sgRKLRVfJs9Y5+om0yN+oj4mSwdZhMZV2NMmhDnkk3DwHRidzATboI1qmaXO+lQbdNCLiQrBYwS7D7DzqJD7zj8ZOBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OozdVRWVCMUajabzfHo/bz/nRWRNCHs1cHN51UFrOj4=;
 b=BdBu40sH2EMu2pCdKQdfI5LR5p/HCFx4vo4eV8pmR931EgDuA63WlmEgL3y+kNC7FCNLTIeeQZIIqCMLlTJDnXTLSh0c5X4EvRvcf0bfmSeHOvGR4refAJbdHqvk8NFvurXhhSLDdf7vue6qHEuam6k5Ic/YtqY39DaS+jCSStM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:26 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:26 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 25/55] media: rzg2l-cru: Refactor ICnDMR register configuration
Date: Wed, 20 Aug 2025 18:07:26 +0200
Message-ID: <20250820160758.801813-26-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 8867e864-6f10-437b-946d-08dde003ef33
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?usWFhQSJ2hmeLtrQfnnEvnQldSj+r6P3Q9qc6XvL3xKaOrKaLTkF5oVSH5C2?=
 =?us-ascii?Q?wA4wsCeD+HWR/fK67b885pKlBXLoPGwHXYeLTWpl5XQccHOwPK6RG++jFGgu?=
 =?us-ascii?Q?no0MiKY4LOegLiSOLmytOuJkGPY982h5+QFdVOXDVsjfRKxW02ZJ/yK13fCD?=
 =?us-ascii?Q?hPjaj9GUjKCzW+i0M818oYjn8LHqv9wM4MaYTr0XWBWakyHHkM11n80dY5bQ?=
 =?us-ascii?Q?Qaqfq2al6Q6U5+UDgtiYfGgbDEfAha69txPkvfVT4TNShZtnf95Xd2T5TkFJ?=
 =?us-ascii?Q?aPRbBdQ7bQKN1MSjt05fD4yR3Mc5l4wxHTpLPvvpdEgmc09iCxtogcqLOVGV?=
 =?us-ascii?Q?g+uJRMloeEH399727HKvKYX41/rwAj6u6JlfIvGxsmt9VHALQtejlN0vuz4M?=
 =?us-ascii?Q?wSQoJJdDOaHPnB+5yurUkafJVfHK8aS471yrYCZsfGWc9eqAtUu/26Uc+RPU?=
 =?us-ascii?Q?jj1f7sRQhozh34Rh6Zp9XZzLH8YnxxjPhD+HoRTBtbCMhpXYv8YCHSE7kqyQ?=
 =?us-ascii?Q?LfiKE3gMEXYzMBaD3wdw3y3pv7TNwpWFs5erOkj4ox+Hv23vvK1m2/sJmQ6y?=
 =?us-ascii?Q?c1E/e1AY1LyrC49GCwLpohB2G7R9z67QLiHXkHja17yIWBdHDoQNcYt9zBlz?=
 =?us-ascii?Q?Zr4RP7jz+WiSrgn4U0DEGQg+p9E5VzaYsXVNSuoXLg7Y37fdWE6m43rqebQD?=
 =?us-ascii?Q?xm8CaIQ7zMDbyyGvrw2cL2tGc4/eNdnNkKaXXcf61GPaUmt69o1AUvK8T82q?=
 =?us-ascii?Q?yYb/sEhgCvCX2EQG/WvHKT7lh5UnQWVFbNwbdImGbbK0vIwiaQGcHnVOj5A0?=
 =?us-ascii?Q?MWlOD4OU4BNUXX6KypM9JIiiGq/RTj3Pb70JMRPoYMpIso+YLF55Jirw3k7U?=
 =?us-ascii?Q?YHjeu0lnRsQqConpit0eSC2xQ9NnQNOUlhnawJnu8D8RriBJOqP8C/zABkQC?=
 =?us-ascii?Q?RxqFg6FuBzmAn9y6wiKqfu4JS5j+9DcpocT752wU7K0TVuUertFEtoaub6yP?=
 =?us-ascii?Q?j1YVaqPna/UPS9N9R+ijtpmo57VCtmr5qvlyYfVfAtoqAJ0KJzxG3Ivru2aB?=
 =?us-ascii?Q?S7TgYOL3uKf8tRi06TCaJR86K27Ez6yLX6wXoxC7dDZEhSoSKM6AyilIfTA+?=
 =?us-ascii?Q?RkwCHRvcVc5b/Vk98v39DcN9R+dvrhyPCa637RDfpWE1Q9E4U0cbo7sPm2y+?=
 =?us-ascii?Q?IChWEd9Ws2JApJEB3Z/OCxiJzhXbnJASX2yIbpb2xI90Oq0e9avsF1WauLB5?=
 =?us-ascii?Q?gNuG/cS6ezK9YXvur1kCPmjW/nDMqTdKN9pUuiquv3frA5AzsAqcq55pxHPT?=
 =?us-ascii?Q?KqgmrKCwBraZ6ZGnGx3gM4uKIOV04qhvK4xRGYwe9Ry2c0Nx1k/3JpSY/5BH?=
 =?us-ascii?Q?s/r34SLsBOxWiOAlAe+xys/NY2rSrj7Dv+gVsGAOVX4W1lb+l+QtXW8uAdE6?=
 =?us-ascii?Q?fioY0AB/vDg260BodCt6XbJWkjEuJKqSc+5xS+ydn76fTMZnnvXNOVwH5sPV?=
 =?us-ascii?Q?sFMpGmRG7Z9nR+Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Zz/9bUvTWn6Np0KmFmMRT/orvazjMF206syRXS1pOofx2LHNoL8TTKDSzQZC?=
 =?us-ascii?Q?jVrI4wUJ3otU7dxjCPfvQ0JMJWTUTkyVFdIsftTCVttXg/0p338TBTcXsgoJ?=
 =?us-ascii?Q?a6ZT46IPiCbp4BX7nGlzZYNmMd0bswmOXOVwNc2ccNQkIjce08sbLJTSfLWc?=
 =?us-ascii?Q?tv89j4KUTHEWfbLAupCith0DIRcE6P5HqpSCpblxQRPasQsvai8G/vu5i6cA?=
 =?us-ascii?Q?hy9CME6X4lKsjl0NFAee2NeZuG659RnpNGLu7n+MvWnlH+hgHwseQ/EfZONQ?=
 =?us-ascii?Q?cke4UGZFWSzEDhcRxP7wE09b+GvaC6Oh8929FpwNWbb0IMwcRDQTJRZA6gyx?=
 =?us-ascii?Q?zewdRM0c2/S9CM94A42yGbymyw4R/+34SBkMUXTRt5uWl686klTQ+ZbY2pNn?=
 =?us-ascii?Q?ksJJ2Me1lxXI2NrxxP/p5w4FDjqNhgVR55r3w8sW4hc5VRIza9Q2/EVgCZrN?=
 =?us-ascii?Q?nTyUwqK8zgRfHbFumKkHSbjnM8NeHVt80GwVLgqkr9yO3nbNLKl81qMoOd60?=
 =?us-ascii?Q?BYBRewmvrpov1kvIBZxwTUcppyNDD229pxIEGgoZ4uiERTOiWeUQ5yqAVn/F?=
 =?us-ascii?Q?BrM/9IluoB+BizTaHgQmofE4n4ku5QkMcMTE12Aa0BzGCAtWtgW2SNO3nwXM?=
 =?us-ascii?Q?G7bDJlIumQcS1xgWHefJd1douKAJw7k20Ef7WlQafXQYBGO+7MEvTy0+7TCB?=
 =?us-ascii?Q?3sROvaquM1JTQ7Dsy4UsyKYdtSpumHi6RhWuzeOymp+kJcA7rdkXwbATUWH/?=
 =?us-ascii?Q?lWxI9PURizgVGKYlEzz22gS2NrUSw7aEng6DyZ6blSsMHpH8DsLDOPc7CH8u?=
 =?us-ascii?Q?Sh75D/33svtyGpV3MOSINer8entVXiJkZIgHqFSBN/huRfoJS/azEYPP9HVS?=
 =?us-ascii?Q?lSq+48wzyeEQ9XUxUPrfcoZi72suSs0cnonj74bTAR4ipJvigbcHBXDzl1+6?=
 =?us-ascii?Q?ItNanOvwEsH+Imgo90aFjkUVAOuSJBiqH+4SCW7LsUOnUjgXg2c1iVdJArmv?=
 =?us-ascii?Q?Xyye/AnYAG6wviJNIsep33WTSzgrykejC5/R5Do4ahBFMRpe/1ULW2+wLLM8?=
 =?us-ascii?Q?zn/dgCMdvCBsjsWYe/J3jHO2XQ3y5fHEgtjn00HEYkpLx12l5HMlxH4NNCDj?=
 =?us-ascii?Q?itZ2hig0tOa96kA8VD5mzCUeVzDQJcc4tvkzk0R9F6GF4iIp4/kYh44BCPC2?=
 =?us-ascii?Q?crmiB8FTbl4StO0LckWryOsIZQj4f8B7VuXyGP43hGyXnLc75fRTzxJ8EBUp?=
 =?us-ascii?Q?ibKif9uAV6gC6Tbs7FzfcoF6qFYXPZOx9TWu3DAB42wY3EhKSOM1EIN6T3kk?=
 =?us-ascii?Q?Kjx+bCkCOMNopMvp1LoYnH5s/0Nd6ViBD6X5lDKzOQbg6QlwKETv/yuSVpHr?=
 =?us-ascii?Q?ZTyGDI3HZU/s5DWm4qLd2XRLblN8B21J0X0HgLrmx1LZICA0ez1E8nmY/yYF?=
 =?us-ascii?Q?/sqKEEr6KYFergTKMnl1CpV+yoG5DKBq0awWKWqyK8B9f3jEfz1Cxy1dektz?=
 =?us-ascii?Q?srRA7SoTpftihCCMnXPs/rym+sMeBd+0Z444B6zedCcPGx981OS6FK8MH2sP?=
 =?us-ascii?Q?KLxdgCYirQaenySVSiKD1jEKnmT2kGEEWqcX/NAfolYwSi39knTPL7ZoQ1nG?=
 =?us-ascii?Q?OZTv2dfsj/tKFh2djzrWiE8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8867e864-6f10-437b-946d-08dde003ef33
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:26.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZO4p2Ia7aXLJ0NUdJdFmu907UwnLinP3HYXDR4ITiscwxIg+gC9jGwpxzc8+uYQuuB4o/5y0CiacgbsTWTQDy0lZ9+4xqYRvpHIXd14d+qkyLgEfxCV0f3bpARNXAjc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19906

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c6ed80fd67438c113928f4d0d883f24d63874794 upstream.

Refactor the ICnDMR register configuration in
`rzg2l_cru_initialize_image_conv()` by adding a new member `icndmr` in the
`rzg2l_cru_ip_format` structure.

Suggested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-21-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h |  4 ++++
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c  |  1 +
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c   | 12 ++++--------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 327516272e53..c40754732576 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -31,6 +31,8 @@
 #define RZG2L_CRU_MIN_INPUT_HEIGHT	240
 #define RZG2L_CRU_MAX_INPUT_HEIGHT	4095
=20
+#define ICnDMR_YCMODE_UYVY		(1 << 4)
+
 enum rzg2l_csi2_pads {
 	RZG2L_CRU_IP_SINK =3D 0,
 	RZG2L_CRU_IP_SOURCE,
@@ -67,12 +69,14 @@ struct rzg2l_cru_ip {
  * @code: Media bus code
  * @datatype: MIPI CSI2 data type
  * @format: 4CC format identifier (V4L2_PIX_FMT_*)
+ * @icndmr: ICnDMR register value
  * @bpp: bytes per pixel
  */
 struct rzg2l_cru_ip_format {
 	u32 code;
 	u32 datatype;
 	u32 format;
+	u32 icndmr;
 	u8 bpp;
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 07859c89be77..ad470de440ad 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -16,6 +16,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.datatype =3D MIPI_CSI2_DT_YUV422_8B,
 		.format =3D V4L2_PIX_FMT_UYVY,
 		.bpp =3D 2,
+		.icndmr =3D ICnDMR_YCMODE_UYVY,
 	},
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index df6114cbe5c7..a686a5cd4f59 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -88,7 +88,6 @@
=20
 /* CRU Data Output Mode Register */
 #define ICnDMR				0x26c
-#define ICnDMR_YCMODE_UYVY		(1 << 4)
=20
 #define RZG2L_TIMEOUT_MS		100
 #define RZG2L_RETRIES			10
@@ -279,18 +278,15 @@ static int rzg2l_cru_initialize_image_conv(struct rzg=
2l_cru_dev *cru,
 					   u8 csi_vc)
 {
 	const struct v4l2_format_info *src_finfo, *dst_finfo;
+	const struct rzg2l_cru_ip_format *cru_video_fmt;
 	const struct rzg2l_cru_ip_format *cru_ip_fmt;
-	u32 icndmr;
=20
 	cru_ip_fmt =3D rzg2l_cru_ip_code_to_fmt(ip_sd_fmt->code);
 	rzg2l_cru_csi2_setup(cru, cru_ip_fmt, csi_vc);
=20
 	/* Output format */
-	switch (cru->format.pixelformat) {
-	case V4L2_PIX_FMT_UYVY:
-		icndmr =3D ICnDMR_YCMODE_UYVY;
-		break;
-	default:
+	cru_video_fmt =3D rzg2l_cru_ip_format_to_fmt(cru->format.pixelformat);
+	if (!cru_video_fmt) {
 		dev_err(cru->dev, "Invalid pixelformat (0x%x)\n",
 			cru->format.pixelformat);
 		return -EINVAL;
@@ -308,7 +304,7 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2l=
_cru_dev *cru,
 				rzg2l_cru_read(cru, ICnMC) & (~ICnMC_CSCTHR));
=20
 	/* Set output data format */
-	rzg2l_cru_write(cru, ICnDMR, icndmr);
+	rzg2l_cru_write(cru, ICnDMR, cru_video_fmt->icndmr);
=20
 	return 0;
 }
--=20
2.43.0


