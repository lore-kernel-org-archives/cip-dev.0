Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF63C35FF1
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.49])
 by mx.groups.io with SMTP id smtpd.web11.34804.1741778686841613467
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=jby+Eatt;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.49, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjjjDASRitnfSl8rRQURpVV05RmmHx/xgfXkjj1FY1NFAxv4mNDpSMmkfXXZvPTGP3hL/AdfMKQ9BlmdINia8Al71YXP+5ci7oAgBVKgRQAh9U7SXCiuH83aeomqT5YcOOx5e/Iy60VsJROi7fgKSO0bMP+YZkz9nzhUxyQnLYUnmegfTAP3otsqeiVyWkbTqiayKuqEP/5xScEZiff1zFRetrjI24jrmjh/6YdSPaKiEDmNTfclm/DiM4kumSmitF0Xi9T9KOI0OqgHYxEKLny0LWwxDfXMF4N5OADK9wZ8Z6qb5HybZe60E2bZe9yQNCcq+zZZHQeMB1jag2BwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD+g4nohCRzXzJC7o2bumN+mDECfBcDpnn0ukQFqURY=;
 b=QjZJS8f7L/f9RMmIEHVtQn1jp5lYQA8EjYG7iX/qrGx7EpvuUFOlOJ5XwWvr2/QieBDByYygLuyRsEvmopOSS4KjtS0NPqOXXIDg/iI05mnOTc0lKHx1yE45PRmFPhM/QXfqTcp/K4JnucPEj9mNXXY8akUVeKUzxRwhf6w9qmzNy/HWXjXDGnBeIKZrKWufz/HlBgcAAHW8KsPfk5DWyn8oCwV3EHivVUbZv6MVGWk1K9yyW5r0Wbn9uICMDimXmbhzLTg3CVeSeast21wVAjKG5fPp5/i6Jyp5zD7CvxjrLS1Z51K7cJiQpTRmpj6ZwvCrOnNsQbn205z2Rsp4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD+g4nohCRzXzJC7o2bumN+mDECfBcDpnn0ukQFqURY=;
 b=jby+EattrZjRxHFlHlVeiBPcpgcsfsSLi4Lply3U2pQ34Je5Blxd8kvb4V9DJBHQpVIRNopao+9r//W9GzJHR9RsVknRNPqQj9C/a/9ot4FKqUibNttVYjIz69EbQnOEa6/NVdf8SxyRbIZZbduL2z8gkdPResTFDDkOaW7oSQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:24:44 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 23/85] dt-bindings: pinctrl: renesas: Add alpha-numerical port support for RZ/V2H
Date: Wed, 12 Mar 2025 12:22:00 +0100
Message-ID: <20250312112302.1605750-24-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: b1672f48-276d-4006-6a20-08dd61587d07
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?39QMeIocdcwxNBn9MZt8wcMvf2ViF8fRbwOl1O0MezK34tDm0XfW+hMRF5q+?=
 =?us-ascii?Q?J8uWFcXVxhhtvMZYVAM3aiWxX3NBAw8/EJQe6ydUfsr6inGKAmKW5vRexV8s?=
 =?us-ascii?Q?J1jgCKQpbDb2LiDd5JwwLCOj1c+K/PtHZF6dKrdKMxGaz8ZN2xOyi67MH6E8?=
 =?us-ascii?Q?i6OfAuMDdBv1N+eYAcu8M1993kkMdSPskbwOiIoZqnQMSPgKq1/PUPdRKPvq?=
 =?us-ascii?Q?gemUQ/CWGsI0iStGjxt54ORhD1NEZQPBVDPFspvRDSLh/nRk+PgL8yqM4I9V?=
 =?us-ascii?Q?uvq/0Op6aav6ENYaHVcenPO0hZNpqEJJu7YcSd3pWBfIOYs1N1RyKgmv4YD5?=
 =?us-ascii?Q?ksic8ZVRWwC9FLgdRZKNanjk8ZPYVwK60DqAs+3uAw0BGVb7/kUBUb3b8fEc?=
 =?us-ascii?Q?KeVcL7VGUzwpnP2GDbsP9a29YfeeUgY5R0w2ZWWQtvoFK3wV4VqcL1JpqRv6?=
 =?us-ascii?Q?FAAG45BuJ4gSrqrpLwJ0433tMQLIZzzTM5H47ENE93HMQStQB9wIts3e8biZ?=
 =?us-ascii?Q?N54FFXhF6izQk8TlAZzGi5mqPSjQ7aNCEesf4x5maMm+v7gCq04IDlJ4RYom?=
 =?us-ascii?Q?S7ITIkrHYSUt8KKtuh+gRlNcWKhpMCjmWR3kTFdlwN1CskRimOmvFWgXPg2a?=
 =?us-ascii?Q?pZzKl0u0MmHbkWP6wnD7YMrMRc+Cx5TRneVP3WCI3c8TbltO1kCskFlTc6+z?=
 =?us-ascii?Q?YbAqg54ap6Kgh4tCst+zrqxKoZg1Dl3+LocAW/j4VyUULxLOMPZ/H5CHZemD?=
 =?us-ascii?Q?1Wv+u3/67w6dsfjuZmlCNZGlI+6UIXohR4FndFFf0ABFSqNENic72fY5Uu6J?=
 =?us-ascii?Q?8KRUeq239yi3qBaz8iCGsOdFbxPXiwp03Ue+ol8csSxkicArY2w3F9kiHx0B?=
 =?us-ascii?Q?z1NrkeMiR/ftHyPv+nMmJPzioLr9PVnHOTdDw8dzV9r9e0TFLy3atlwz92fO?=
 =?us-ascii?Q?wP7tXihBXOOfdhyXBtw1ruKiflIOXN1QiQrtb6MQj5TiQuBaMqZv61ewMt/U?=
 =?us-ascii?Q?HkI74K9CcoU69CyS4NVwMDB4M68mNAociRz3teuKnILhX65d6MhD9lQvTYwk?=
 =?us-ascii?Q?T7+arx5CPLvV1OwhNx9Vb0PK3CYB/uYyu0fws1kMdXugSO0RPvgXg1oNVvxC?=
 =?us-ascii?Q?f6HcftdLwTpl88cpEAaRt+Qg0stgobCSXJ9ybaU/1nKmFBGsBfHHdg2LtOhk?=
 =?us-ascii?Q?ywXu08Wt0ll6NGKwYjELgeDkHHC9SwD+OV/6B8GltaRYl/yakascPY9Z5RUV?=
 =?us-ascii?Q?sZEtIp7w08bOqVJZnxfFCmhLQnn7Y3Be9zfmplHs6Njg0bffOpnUrIDeRiCX?=
 =?us-ascii?Q?ZxkOMFB3p1ATL+MiEJI9nULIdhIIpgHlPeCgax0+VmSTx9aeIHu4cqoR8K2h?=
 =?us-ascii?Q?bHOgcNOhORr+rGfX5gapuQmN3TQhcd1e4yRj6uoRZtRZq8AcIumQz2yu6IZA?=
 =?us-ascii?Q?+BKLB4TWoPLqgb6M1oChi8MmML4EOhvQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yTRZ9EMR8rE9hR9rsCjIs/ZcpsD8u6uXnsdIvVh1Wa/Pqc07FPl1FX9bsEkc?=
 =?us-ascii?Q?LF8eRnO3dFy5M/xAMhcb+HLCLulv3Q3EBB+5lcYiK5hK0R6zD4FeUoW4Jtos?=
 =?us-ascii?Q?6+y4ZcH/gMf/uCEBiitVH3xylOy/CzZy3dCOGthE4QFusQSTc6flpqa/AT5Q?=
 =?us-ascii?Q?wJpF6z1n7pIOmEVc1MBVVMFJMOJURwhwOKv7B6RblszqQZsd5xvC7fFuz3Qj?=
 =?us-ascii?Q?yAmwG4JrNmvypzmaDfIlwAmSwTSLeQC8iO35kN4Y1NmUNpKjGExiaMG/hxQV?=
 =?us-ascii?Q?Ji9K646Lr048eI2vJ8WEeIlC6zR20hMimRHaMe93d0i77Bp+B0kjESDz8LCV?=
 =?us-ascii?Q?lIGNQCNISWN/Bokf2tPeKxtOux/EsNVmvL2VPngGacFQ8F4yP5QF6bZB0iT9?=
 =?us-ascii?Q?J44TeXnbWdJI7oMHUjaPxaZXQ0pWWWqhox+y+/f4gBMLz6gFdSd4JU3TY9kT?=
 =?us-ascii?Q?oFKnodjgOW3iUR/xTZ/tRRX+HJNmC0vxSBf+qEeRnQbQF2Uqi5nzjJJXn38r?=
 =?us-ascii?Q?vvHAsdek0BATvP0By8cD1iSfLc7U52+t4E+HriPpbJSsOHX+qbwSsWfmdIQY?=
 =?us-ascii?Q?C2T/YZaEGg7uuzZBEBLeGg0bqkf3n7NfYXfq8hzR2aYcmCR+J/7iPfBTb3nc?=
 =?us-ascii?Q?5BGptOiE0ZUHcNtwVEwARyAQDnNJc65IwBfO62htfIZQWqysyiLNdKotFDSs?=
 =?us-ascii?Q?YvprEE6ThNIaBpa2z9+Jfg4C+VDO+fuMekVElJNDT6u/fXYb6gGl0JPr4iEJ?=
 =?us-ascii?Q?0HvJNsmLKrG6Cd4FBXfYHt37jBFnKvgzfEon+t1ls8crpHNJNDPIO95AXKiA?=
 =?us-ascii?Q?2DT37405PyJyvzeePiTr0lx0dAaCsYdV/8ncHx5GN3tvXyTSH4SE73N9FXUW?=
 =?us-ascii?Q?LFl4Aqi4W9geoWnEhI9LzzuJFzmdLEtuGNbe5XRKQDyeNByeJqm0D53HKXex?=
 =?us-ascii?Q?yz5/6TjgG4FlVO0+8BNyFba8P8Bdc1+CXomaIwxnM1sd+i9z/KmRY+FT0h9h?=
 =?us-ascii?Q?jJhhoEax40z48edbbMC5f7OgSh2/cSYfl88PzL+qE30ytfBtLdbsLZgg/11k?=
 =?us-ascii?Q?gP6LHFxr84mc582JnIrSg6EB/3StI9nvWZdpGbtkSY0A32kc2hlqznG6Um37?=
 =?us-ascii?Q?iOTdUADOmm9aV7RKXdcqiM9DKFK/iE1tbEOvEd+2PWn2HbYxsikOaHWRw6bj?=
 =?us-ascii?Q?7LM+XT1sMYtunWp8ABz+VRvo+olB+vMw2RbPzREdiJtOEdZkekPxcBJ52sGd?=
 =?us-ascii?Q?qcMzRzblAXEcvCo66Hodyg+hai1HW1Qarj1j6CMzasiJsB1ON07mapwMB5Jl?=
 =?us-ascii?Q?63iHITA7JS4jDohknxxFiRfj7ednAyneYx9JPAMYSnECXHPTQ60iVr+oVqJY?=
 =?us-ascii?Q?O6A3c0ad2emZgWFOGCtI5e+2y+ZIjJ+SWCCE/SyLoLoTZnB+BwidT5Kgojqj?=
 =?us-ascii?Q?WxzKh/rJ3aD0QeqdbNPJsgg5GAwBkxljC4Dc21n3FE2Z5iryfBizTGUkq+3E?=
 =?us-ascii?Q?m0Q+lUo3cMULLzAFS3yxGYpl0CVSH8K477yl+Yon+VM9AJY+rN5wjylLmgoT?=
 =?us-ascii?Q?xJBk4Zo5O6vXkQJWOLxMl00AAGy9UHkEIHiTrrOqwr4kiXbRc1TGzwOwDaMF?=
 =?us-ascii?Q?VXaZE1s7TdDsUTiqRDpWeys=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1672f48-276d-4006-6a20-08dd61587d07
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:44.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xso7S+o+V8VYwKo48B5J+/GKFNU4K6xa/PP6pSEtbNEJpaJY5JVc+VuY1vQ+KOiMaj+Lji09yk8OB2kpEsIp+M+AseuNj1lldiT2kkQ9FnwXABa+Nsi7FnVNJKTQrIp6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18114

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3e4863d24818a41db42b4f2680715f204657839e upstream.

RZ/V2H has ports P0-P9 and PA-PB. Add support for defining alpha-numerical
ports in DT using RZV2H_* macros.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216195325.164212-2-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../pinctrl/renesas,r9a09g057-pinctrl.h       | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h

diff --git a/include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h b/incl=
ude/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h
new file mode 100644
index 000000000000..2e83bf43160b
--- /dev/null
+++ b/include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for Renesas RZ/V2H family pinctrl bindin=
gs.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __DT_BINDINGS_PINCTRL_RENESAS_R9A09G057_PINCTRL_H__
+#define __DT_BINDINGS_PINCTRL_RENESAS_R9A09G057_PINCTRL_H__
+
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+/* RZV2H_Px =3D Offset address of PFC_P_mn  - 0x20 */
+#define RZV2H_P0	0
+#define RZV2H_P1	1
+#define RZV2H_P2	2
+#define RZV2H_P3	3
+#define RZV2H_P4	4
+#define RZV2H_P5	5
+#define RZV2H_P6	6
+#define RZV2H_P7	7
+#define RZV2H_P8	8
+#define RZV2H_P9	9
+#define RZV2H_PA	10
+#define RZV2H_PB	11
+
+#define RZV2H_PORT_PINMUX(b, p, f)	RZG2L_PORT_PINMUX(RZV2H_P##b, p, f)
+#define RZV2H_GPIO(port, pin)		RZG2L_GPIO(RZV2H_P##port, pin)
+
+#endif /* __DT_BINDINGS_PINCTRL_RENESAS_R9A09G057_PINCTRL_H__ */
--=20
2.43.0


