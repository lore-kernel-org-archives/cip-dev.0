Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0EFCA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:53 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.20])
 by mx.groups.io with SMTP id smtpd.web10.963.1755705950313248058
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Wqo2h5J2;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.20, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCrx97ts5bGWNaQJxp+4MbPFX4KgC4/nt2PQEhbqcmUqUgq5Yj1quoxHOBTQGdolaQpQJ+MPIN/AR227aqw5dumm5XJSXtKrvzkUVZ8zji06ZRbfdxyAVDVi2g7TAm/idMLzN6O3Ekpm14gkCDuejiK6kIzgDQM5CELaqMjIzTtvFytTiVvSxgsqL+EGOYR67Lhje5nOqQKz/5gQECqjtaIUbaObC++wqTahLedKuhs4C8uYI64IFibWvWkKOmVa7RJhqfRNCGfYtAcp6Gb9YIVdGDaiWxg79nrgP40DYpn1c0bSrqJKarAj//AeTghVbP9M3L5B/e9cBOE4YDY1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8Hqk2TRDxTfcPwUqb5cE0r68ksorVVlDvFtviHywX4=;
 b=wx10Y/tZgT+oqVaoGKDWyEQiRg07WWURzqLw+zZ2FFr8cIU4GX2DgIaf99BicuvoQ/fTPwmYZh1BkICrMR5u2GJb+oj/C6bTNxH3mQYnyteuvfd2aQpQYFFNZ0+EG6SNvx8eLaw9if/7rEhNIZB1jJ4de6o0KGtN0WUqR5G729q4LbWI9V+D/uBGTF/T/3poZvGgzvvPMFCXcMND/2eapEebOTsq9iNDrZndg87pGQFUs9HWrYXDHIKSubPVCxtatSlCzPdFL/NH85bUawsaTIx2Kx0+DXYB+mafE3yr/OEceAt0vtsBq9G0lDiTlBY3x3X/OfhTr9bOnQNW8kpF6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8Hqk2TRDxTfcPwUqb5cE0r68ksorVVlDvFtviHywX4=;
 b=Wqo2h5J202hh+7eUfdS55qki44CXbceJP8N0xbwzB8Ggb0mZRKl+dcnIZ752P1qFAUhcNC9zMs9UzECl9O7TGUnNM+XYRnUFTjvSwcAbZW9obpQIs8iJPqAb/bUfwF+9O9/RMMQYG/jfzBxxjVBst7+7IQChVCgJqmP+gfnVHlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:48 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 27/55] media: rzg2l-cru: Move register definitions to a separate file
Date: Wed, 20 Aug 2025 18:03:43 +0200
Message-ID: <20250820160413.801341-28-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: 63efbd5c-ff24-47a3-b53a-08dde0036d4d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?U8Lc8HW987astF+hYXA61Xwp7b2gRC3q84Qb/blhKpyw2FiZJM2lbqq+9uLo?=
 =?us-ascii?Q?6fiDGH42TK4QuVS7GGdh8NFu6VGdjbAwZOvGiMwJ6c/u9ngcx7XnrqlC01IM?=
 =?us-ascii?Q?Ucl1vrRugtHElB00gqB64nvq0SwxAwpzBuNtr/Wd9mJXoF0sfUYo7xW9TFG3?=
 =?us-ascii?Q?g6j/xBDG3ncr0jDOB0ZkbGYBUtoQkGA+y8bRHRx6mtbWhj6kXzGIK4POTLEB?=
 =?us-ascii?Q?BflvCSSInOJREySl+cEkCoEkSHYqKHkqmsTNnb+idYyKiCtfw3c36ESEmBFd?=
 =?us-ascii?Q?fH4LG4rz7HNk0Koo/hulYn99LN9wlmQcGXZtlT9zYRo5LQ1lwFIfzTR1+D6V?=
 =?us-ascii?Q?2IKBL2jiWaLl+XFQr5sE0BcRocLYSM3Zq1oHjYDgriBHveMsXMZFzlYmO+Zo?=
 =?us-ascii?Q?M5VCQYNf5O3JC6ettyQWyM4ivXuAsxP4aCzDaiuace1CSOYeoilV5QiVblxE?=
 =?us-ascii?Q?2uDScKAJpxzCo7IeOibVJZClAGtA7b99gEUenn6K9he8PEM5Do5hd003mjdF?=
 =?us-ascii?Q?pQ1BPbyPToSXZYMRJFyMcjItXvLGQ6Am4MY640qoEjujUGdW0d5hmGOCbFEO?=
 =?us-ascii?Q?7NeCVf1mmRk2dzu5ntQYpplKhewe24xvgl39K+v+a+yrHLpxIAYmNL2PlZST?=
 =?us-ascii?Q?QgogIpg1T8K5g7R+z6bV03drKHo0nNUnHzXapNYPdd3nuacId2fPrH3j7N55?=
 =?us-ascii?Q?xfMgeG1IgHXKkY/eQGL1HZ3B/EpRMLjFvKi/is8kBX2zTBw1Twd+/PY83d0x?=
 =?us-ascii?Q?/o5Nb1c90xafQDNbdYygeNadyPp+WX3gN2hYoYygYgsc1/XEZUBglwq6KHf+?=
 =?us-ascii?Q?MIgszH0weJn1UW0h98GwVUoy/cDZzi6gw04J0Uu621DnnSxrn1GD2ClXu+Rh?=
 =?us-ascii?Q?HUoLI/si1COFLrWLkmbZQ/64Rj1+h75wx4wJQ/22Ogob92gQ4pcKFqEUUBWD?=
 =?us-ascii?Q?5ZpPAtHEgJ3/MsQLe1shDbXcKos3SKHgP9KaFRZQxXnnn7t73ktx/PQ29G2c?=
 =?us-ascii?Q?Fff+amduaSAz3qn66ND33wgtzlnCrHAcljkRR2dQg7ViH9Xtj+Gyi/4x49vE?=
 =?us-ascii?Q?RbE/tqVl50bMiQf9E6d7TO4wkw/XJbpN5+qy5U5b/CRG1VveRMY35clL5UJQ?=
 =?us-ascii?Q?GGVKpesbjk1b95AOT5K+VTR3G9p7ZEOWGA2FEPsrlke9tRm1n4IkpSJBwPPc?=
 =?us-ascii?Q?3EXL5OkhlH2adGw0lNGCWjwf5ET86xnEy4qrz8eSixk+ZulgU+oLM2cHAemt?=
 =?us-ascii?Q?boCSKmImiSqOm4iz+/vv/lyMP8QuGDeJa4bQlgIo7Raxons87LTVnjuXkFyu?=
 =?us-ascii?Q?3LLtg5Sb0pPT2+77T+1ztlS/mDVWrn7ldNG3Oy8VjxVwqJgCuLKKthm3cDEx?=
 =?us-ascii?Q?af3YxIR9awtiLSREH/1X0TardP045YaWOuF2jNzqbYBRvei3ziUwO4Jbnwkv?=
 =?us-ascii?Q?MFsqgPjVlNS6PBnRgIC2wcXZOGWmf1C33kU0wJ89oNEqbzO4keXXPw5Ouv/B?=
 =?us-ascii?Q?lu3CjObWO1R8Z+M=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cJxR0VSGrQnaea1BxoyPjVQqbpcf7MW11L+peNyNuTwdh7phy9l/mwv1ly/q?=
 =?us-ascii?Q?2Rgz7ffWQokOjtHmE9Wfh5XsE+gRIT/l2++51YbAMgRxVWV5mudUvhMxeW7g?=
 =?us-ascii?Q?2ppBHjCj9ArVTalRCCcjppBhNoKCBW930IF5YTHg0xAbkmUZwlWtvhbrEZlA?=
 =?us-ascii?Q?Hu8tkspAR56THeIN1RvmA/Oj20xJ0kv+qMG/6R0jeULBVOWDy4WOxUkEDFwG?=
 =?us-ascii?Q?w5bpjhyaMgvk9z29mVLo4ROAWSAt5zNWzv1wGg9iXksR23QGljr4DAjb8TqT?=
 =?us-ascii?Q?TqE8IgNFB0T6/s9qSU/dxPwusKQlxzX6CutlzbRYI8f4pcXRiCAsO84CR4FR?=
 =?us-ascii?Q?/nG6m6nY4lPXmDKrSv2X5n42ltwxV8XyeDTjXwWy1a/WonlN5o0wuzCkieIu?=
 =?us-ascii?Q?HOlf9U55owAuVZ9CMXTbexCNRX/yFO2mRlb868osBOgzpyGRVTswltXqViAn?=
 =?us-ascii?Q?P9XU2qlIxqHn/zVPc1H/7SH0LJhB050FBTcXABvEYMvZc28BEj6ySSr4KQwJ?=
 =?us-ascii?Q?w6BMBKyHyuQygz9c5KJS/OFE8f/XvuYt8WJT5jxLTFo/JtePeYp993Uv6Qyx?=
 =?us-ascii?Q?J4elz+QQYQRyqWkD7Wjp9DE/65uuGPl1MRtqRPqGfzHk2VDKCJ7K8XNCMRDX?=
 =?us-ascii?Q?poXBnhBWFo4mcun9Gg48DPr6MGlVJuJo+mKTuFb4kiTGQKdhDTwJTxaRuLfN?=
 =?us-ascii?Q?TUBjlArYjjJCr9VbTbxLL9w19yjK8aoridp1kBwNbbXG1Ztqi3sbrXqQpN6b?=
 =?us-ascii?Q?m/hOsGhHUaS2hsKQONg0GPrJRZ0lvTaIzCjJc+6q1DL88EuUgRjWzoZEv07l?=
 =?us-ascii?Q?JI9+Pjq6hlCWxO1Syuq7H8cbsIi8Nst5sw3JIUUvIcUftNhP6uB+eX8tYib7?=
 =?us-ascii?Q?KJ3a7xpsvQdKLwTNqLzCMfV7CfZt19nADFBJKkSY8x/kkisuZ9NPXz0YCpDU?=
 =?us-ascii?Q?Iw7ne0r8pDtsFzFURHW4vWSt32rrlWYcPcgfmKaV0lAyuhaqGTmqdLKCjBb4?=
 =?us-ascii?Q?AV4Ny+s4vfZ2FUsJL3CWicOw14dBaUfShlin4sg4aBYZ2H8ZRvwWo1zBFl42?=
 =?us-ascii?Q?n/+W2cNL65fUoN0FFt+2jahkJ2dPIhDKasbxJeidO7uOhQAAmupE5pQ0/cu2?=
 =?us-ascii?Q?Q72DBzEP9Y95nEBDQjY4tYc2HmYL6rgP99Ft8IguEvyQcpO6BZit5IhV1msU?=
 =?us-ascii?Q?xoN0D693Zz5eyaivfm2/wEmWPR+b9dFImZsqfUMSw/tBl3ZxEJ0trpBZMiUj?=
 =?us-ascii?Q?hojfLPNcnrhldpWPMS5UxgNMKmIOPYD5oKIJCoV4jm9d6BnV46JHGfTnxM3D?=
 =?us-ascii?Q?ubYDBf6Nw+9jCTyhwUCg+jGyhBoUyDaIQxCgqWgXaDo7faHK/zXj+ZfQ+pyg?=
 =?us-ascii?Q?3WTe3zO8nH5e3YVnVbpLprqzGgqfeySgiv3GAuJB1wQLsosfaazN28Jztj1v?=
 =?us-ascii?Q?oOMmUyrVDHQOInevrUrPOWSyKyvrMy5tPKxOeqsOsfn2rNtfYKsdypx/MppI?=
 =?us-ascii?Q?txzlUooJcyOWHDNqphbTwSwsBPCFRFlooWAPQXO2etf4BMiTdDEWH69k+4j/?=
 =?us-ascii?Q?tUHJrcRJG3qYp9ID4wTj9R7Br+o61XXdlb3IZTLeNm+9j48guCkLIKV5+KQv?=
 =?us-ascii?Q?kT7m8QGtgRGICqnGBy03qPE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63efbd5c-ff24-47a3-b53a-08dde0036d4d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:48.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAclw67JnTxqGxxtG2tBxIjkNM6ItS6NEVtwPUrb8fMRTfxLP9d+v2MNi6EpSYJ3/58ReMdxCumuD6cSOy4AVnVrXz55FtPR+QeK1DFyev0XF8/71EZvZwANQT+rh3iE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19852

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c0fc8dd01ffc37f3ce4132b7b2b579fbf64aaca7 upstream.

Move the RZ/G2L CRU register definitions from `rzg2l-video.c` to a
dedicated header file, `rzg2l-cru-regs.h`. Separating these definitions
into their own file improves the readability of the code.

Suggested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-23-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../renesas/rzg2l-cru/rzg2l-cru-regs.h        | 80 +++++++++++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  2 -
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     |  1 +
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 69 +---------------
 4 files changed, 82 insertions(+), 70 deletions(-)
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs=
.h

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h b/dr=
ivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
new file mode 100644
index 000000000000..1c9f22118a5d
--- /dev/null
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * rzg2l-cru-regs.h--RZ/G2L (and alike SoCs) CRU Registers Definitions
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#ifndef __RZG2L_CRU_REGS_H__
+#define __RZG2L_CRU_REGS_H__
+
+/* HW CRU Registers Definition */
+
+/* CRU Control Register */
+#define CRUnCTRL			0x0
+#define CRUnCTRL_VINSEL(x)		((x) << 0)
+
+/* CRU Interrupt Enable Register */
+#define CRUnIE				0x4
+#define CRUnIE_EFE			BIT(17)
+
+/* CRU Interrupt Status Register */
+#define CRUnINTS			0x8
+#define CRUnINTS_SFS			BIT(16)
+
+/* CRU Reset Register */
+#define CRUnRST				0xc
+#define CRUnRST_VRESETN			BIT(0)
+
+/* Memory Bank Base Address (Lower) Register for CRU Image Data */
+#define AMnMBxADDRL(x)			(0x100 + ((x) * 8))
+
+/* Memory Bank Base Address (Higher) Register for CRU Image Data */
+#define AMnMBxADDRH(x)			(0x104 + ((x) * 8))
+
+/* Memory Bank Enable Register for CRU Image Data */
+#define AMnMBVALID			0x148
+#define AMnMBVALID_MBVALID(x)		GENMASK(x, 0)
+
+/* Memory Bank Status Register for CRU Image Data */
+#define AMnMBS				0x14c
+#define AMnMBS_MBSTS			0x7
+
+/* AXI Master Transfer Setting Register for CRU Image Data */
+#define AMnAXIATTR			0x158
+#define AMnAXIATTR_AXILEN_MASK		GENMASK(3, 0)
+#define AMnAXIATTR_AXILEN		(0xf)
+
+/* AXI Master FIFO Pointer Register for CRU Image Data */
+#define AMnFIFOPNTR			0x168
+#define AMnFIFOPNTR_FIFOWPNTR		GENMASK(7, 0)
+#define AMnFIFOPNTR_FIFORPNTR_Y		GENMASK(23, 16)
+
+/* AXI Master Transfer Stop Register for CRU Image Data */
+#define AMnAXISTP			0x174
+#define AMnAXISTP_AXI_STOP		BIT(0)
+
+/* AXI Master Transfer Stop Status Register for CRU Image Data */
+#define AMnAXISTPACK			0x178
+#define AMnAXISTPACK_AXI_STOP_ACK	BIT(0)
+
+/* CRU Image Processing Enable Register */
+#define ICnEN				0x200
+#define ICnEN_ICEN			BIT(0)
+
+/* CRU Image Processing Main Control Register */
+#define ICnMC				0x208
+#define ICnMC_CSCTHR			BIT(5)
+#define ICnMC_INF(x)			((x) << 16)
+#define ICnMC_VCSEL(x)			((x) << 22)
+#define ICnMC_INF_MASK			GENMASK(21, 16)
+
+/* CRU Module Status Register */
+#define ICnMS				0x254
+#define ICnMS_IA			BIT(2)
+
+/* CRU Data Output Mode Register */
+#define ICnDMR				0x26c
+#define ICnDMR_YCMODE_UYVY		(1 << 4)
+
+#endif /* __RZG2L_CRU_REGS_H__ */
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 766ffaaa6130..e4c9a7b49302 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -31,8 +31,6 @@
 #define RZG2L_CRU_MIN_INPUT_HEIGHT	240
 #define RZG2L_CRU_MAX_INPUT_HEIGHT	4095
=20
-#define ICnDMR_YCMODE_UYVY		(1 << 4)
-
 enum rzg2l_csi2_pads {
 	RZG2L_CRU_IP_SINK =3D 0,
 	RZG2L_CRU_IP_SOURCE,
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 1a3d33bf5b13..581bdd372ad0 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -9,6 +9,7 @@
 #include <media/mipi-csi2.h>
=20
 #include "rzg2l-cru.h"
+#include "rzg2l-cru-regs.h"
=20
 static const struct rzg2l_cru_ip_format rzg2l_cru_ip_formats[] =3D {
 	{
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index dae952e05944..a0fd84e5f242 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -20,74 +20,7 @@
 #include <media/videobuf2-dma-contig.h>
=20
 #include "rzg2l-cru.h"
-
-/* HW CRU Registers Definition */
-
-/* CRU Control Register */
-#define CRUnCTRL			0x0
-#define CRUnCTRL_VINSEL(x)		((x) << 0)
-
-/* CRU Interrupt Enable Register */
-#define CRUnIE				0x4
-#define CRUnIE_EFE			BIT(17)
-
-/* CRU Interrupt Status Register */
-#define CRUnINTS			0x8
-#define CRUnINTS_SFS			BIT(16)
-
-/* CRU Reset Register */
-#define CRUnRST				0xc
-#define CRUnRST_VRESETN			BIT(0)
-
-/* Memory Bank Base Address (Lower) Register for CRU Image Data */
-#define AMnMBxADDRL(x)			(0x100 + ((x) * 8))
-
-/* Memory Bank Base Address (Higher) Register for CRU Image Data */
-#define AMnMBxADDRH(x)			(0x104 + ((x) * 8))
-
-/* Memory Bank Enable Register for CRU Image Data */
-#define AMnMBVALID			0x148
-#define AMnMBVALID_MBVALID(x)		GENMASK(x, 0)
-
-/* Memory Bank Status Register for CRU Image Data */
-#define AMnMBS				0x14c
-#define AMnMBS_MBSTS			0x7
-
-/* AXI Master Transfer Setting Register for CRU Image Data */
-#define AMnAXIATTR			0x158
-#define AMnAXIATTR_AXILEN_MASK		GENMASK(3, 0)
-#define AMnAXIATTR_AXILEN		(0xf)
-
-/* AXI Master FIFO Pointer Register for CRU Image Data */
-#define AMnFIFOPNTR			0x168
-#define AMnFIFOPNTR_FIFOWPNTR		GENMASK(7, 0)
-#define AMnFIFOPNTR_FIFORPNTR_Y		GENMASK(23, 16)
-
-/* AXI Master Transfer Stop Register for CRU Image Data */
-#define AMnAXISTP			0x174
-#define AMnAXISTP_AXI_STOP		BIT(0)
-
-/* AXI Master Transfer Stop Status Register for CRU Image Data */
-#define AMnAXISTPACK			0x178
-#define AMnAXISTPACK_AXI_STOP_ACK	BIT(0)
-
-/* CRU Image Processing Enable Register */
-#define ICnEN				0x200
-#define ICnEN_ICEN			BIT(0)
-
-/* CRU Image Processing Main Control Register */
-#define ICnMC				0x208
-#define ICnMC_CSCTHR			BIT(5)
-#define ICnMC_INF(x)			((x) << 16)
-#define ICnMC_VCSEL(x)			((x) << 22)
-#define ICnMC_INF_MASK			GENMASK(21, 16)
-
-/* CRU Module Status Register */
-#define ICnMS				0x254
-#define ICnMS_IA			BIT(2)
-
-/* CRU Data Output Mode Register */
-#define ICnDMR				0x26c
+#include "rzg2l-cru-regs.h"
=20
 #define RZG2L_TIMEOUT_MS		100
 #define RZG2L_RETRIES			10
--=20
2.43.0


