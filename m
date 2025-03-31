Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE46C3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:01 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.25])
 by mx.groups.io with SMTP id smtpd.web11.48795.1743417952516858295
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:45:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Oh2q8wY7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU5wN0WJfHGr4vZ2Lb7og4QnKO0hS1sJGeg6B8ESJeJ9EEhTHchrf6penWH/AZ6XJuHLfu/85kQKpe2rFxfc1YEJku0r+vqsadJ7wcJNMgyagbX+5ZM/G6NmZaZZCiNe7fCL283w/xuZ1k7ejc/ZgPzAKEfPV32uSiEgElaQWeWSBJ1A/Cja63m3SV63Y5opqQMAE+LckcPdunGpsQ9o0b0OSytBsD9mA0yK3bnfNeB7+sfDlUB01OlB/1JZnh45wkHDTQQMfDz/eBh/QsrtTv9cxL9e5eWNGwnzTcTg5CXtz5FO9eAw+YKFglBbbCUULEhJyj9PNW66OmUo136Wbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl4K0H2q/sFCpH2VFd21odQ+H69S7/PnjAZrK8rZgdY=;
 b=yjcTI6ShieI+5riTCvkL6QJYLpEwPlhPjGumoZGWQ6uT51H4RCxrCydkaqKQNWldk+gocQSJ2FjJoLbjHFErqkDqlG8o7zIyoYpPH3pdfBjH6VxNs0qLZ/1oH02X4MELlL0AQwDNmalDagqVnLZTI9SVqOvZZVjO3KBBA8Xgq0pDUm+gKx6QNEtW5dlV+k9mC8gtit20NVW5rBXGIkd2NIA6TO/tyulZgEFQEvJjng8pqHxLC0V3d6UxiP47wUPOV0P9lnpMmG5AUzw1+0M3QeaycGpsJ7ufzJbz1P3gmpz/0Ve1tOqWgBl+ll7WEUJESoW2DdVkbn0LNB22cD4/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl4K0H2q/sFCpH2VFd21odQ+H69S7/PnjAZrK8rZgdY=;
 b=Oh2q8wY7Rr/aVLvhN3eeXKDi164ZE0YaXGYcVlWjnXpjCilUR0SgPhr3h+983Hg48Q2ObbqAfIwjFigBtMRrxb4qsCDxD8CcQpVweRBADBMdk7GFcL5Zk/raEhTHn5/ro6MOZlob45XMWGQA4KkbTphXpDQrbTWhf9CGt0hfDIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:45:49 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:45:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/43] dt-bindings: pinctrl: renesas: Document RZ/G3E SoC
Date: Mon, 31 Mar 2025 12:44:37 +0200
Message-ID: <20250331104514.79090-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: d7421fa6-6467-4d35-4274-08dd70413338
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?kjpBLvGcn0qg5zcpiK8EMC3CKxbhcNYdXGn0HbovqSA0icfheRq0BLsbI1FN?=
 =?us-ascii?Q?v5QOuZx72rRquRqEyoqb4Q2cM2mw8OIKkRHUijMPCuK3PVKErPHjL5paEiPa?=
 =?us-ascii?Q?7QpLdL9kEEoIIW1ATlbOkxEmGMGZi01b7cXGEnoUQhJbCAfrol6IGaf10BLg?=
 =?us-ascii?Q?aITvNDgOUKdrLd7+keuu2BZyl5vMrI8Es2nLLySb3SV8TXxpUSDmkid0957U?=
 =?us-ascii?Q?Jcp2tm8RMVqliQ7SbzveuCC4sEwBgBKgSY0WWQe3uNQFCvFvVO1zC6UDTBOL?=
 =?us-ascii?Q?YeK47MIQLli4y5cvzq4rn16rI1ON7gCW3rPHg63qA5LmYVAsbm000XNZMc+L?=
 =?us-ascii?Q?xLvgQKpjSs2PGfE1Vd5EEAlpEOJGhnCtA1cCLeEtXwLnbZK0tsfkqJEAXUdb?=
 =?us-ascii?Q?5Zv1lIIUQVT1eUGWk5cY2A35laKvTQzZrgIUaYNujMguKrNsd2z4Rd8zOVVN?=
 =?us-ascii?Q?1KtJAb5rjFKSdfph7XFEu/AWNq7lZNjyS9UXvbme+u1/XmPltvXoqKRCHqBT?=
 =?us-ascii?Q?iAnnL6fiI5KPmb4+FDHDcYuRjJosGnFGjbEuXwY3OF1hJ9sQ4mA1w580AXAz?=
 =?us-ascii?Q?Xch8bbpDoCpRpZbBV55xtb/ZrTRkHmeuEoXQw8b1fyhjlEi7QSIsXfv+47tM?=
 =?us-ascii?Q?YtNnw9di5d4qmuxPbUSz8m7NHnQrYqW+D+rGIu93S6SCpIqfSuzGsCBHVLgx?=
 =?us-ascii?Q?peRTZp/d7l46Ek/mLIiAwPA2PbMU2I8mU+wjSj1LvpD7MBPgGjHiHQod4qJP?=
 =?us-ascii?Q?BCNAKjfvJ740czAJr3H0RvipPvJWId7uAMTBAMn/zGDyJEwr73lCHWoOm+Px?=
 =?us-ascii?Q?Yj2hmsxqSzYIZ5j59o4LorbrUq3kPgOyOEwvRnDUN5vcJzRnD0xcaESFJCrl?=
 =?us-ascii?Q?i058mcymRz/Skcu0nV1rQLO/lCOkGD9PdS1Ap3iP3eoW9NuvjCmOlVftfM3R?=
 =?us-ascii?Q?FZK74m2NQA/GLmoU5rcSSFjQxpIj3x6RqkzATYy2tt98v8KD5a7WVDm62cM2?=
 =?us-ascii?Q?whxKdM/HXjhODa87B4OIhFJ/7ljY8akpDyUR0DAiPV5a/QJ06xF3w2hAxQ+S?=
 =?us-ascii?Q?yVbCegUbN6Cv4hVWuE8mkwByvMOAY9X5V0SReHvQeKJLrUOLFSDzWa1d5Koc?=
 =?us-ascii?Q?Ty+/TJV1A5hU9eb3I+++479vHF/mqcJGjnyHzXK+ub8QGf0hpefx/Xt4IZ1f?=
 =?us-ascii?Q?f5i6XBTOzAQ2bHbaUvhrKMOMH5STWT/GKxtU84doVhycgpGtFnnup0+zpcos?=
 =?us-ascii?Q?unxDHpwA3ByoxWAXIVBSwOHXfnhFuKL0cFvur6nWO0Os+woakMOzRS91W+ni?=
 =?us-ascii?Q?kCJ3Wl5a97Z835otFIQMdF5wuFmFlpwERnfpZ2CWOOccuA7dM3bTYF2rrNN3?=
 =?us-ascii?Q?u4CnBJgy/TIBfIq2315aufZVMbMwl3ksx8Xt8AFyQqBi6d7zb91dsDkr52Dz?=
 =?us-ascii?Q?juydxFtQflArx7seKMGeSD9wIOutTa08?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?r/N7OmBfRINpK29rwatI6O2irJhldWv/6yfSXeB8xatTwCEzrVm0Kp60cm8/?=
 =?us-ascii?Q?gCE5PpPEJ8jMnBEVDCYD8Iz0I6FEkRIY+2REHXaN4obxy7j4bS44nvqs0hH5?=
 =?us-ascii?Q?/i21i1oRuvyOEHBEprGT0zS0koDTSzOEdUf2Ovb5B73Z6qEBwKV3jd8JNtqd?=
 =?us-ascii?Q?08vWD5S40Ul4cIO5Vbktqd70bELvehIxOAhrzfpz/p/nwI/R/zI9/hqVLxN6?=
 =?us-ascii?Q?3LpapF4qrVFy36s5SKfcMi4z9SElKdmOaYSsfBZRQZaZLA7EUDJTfNaXntN2?=
 =?us-ascii?Q?FFnDu5Trc97qWxrb5mXcpXqWXHzRtOODOFaEFugsjQexPblGbpyoMzeyigGn?=
 =?us-ascii?Q?PWcDdevP1rcKNm25LuXW/4OCtSI/ZfezYIf8C/p0q6QUrLXJDOB6H15VWC1K?=
 =?us-ascii?Q?pGOv/qnGoPnIisNtW4KKc4pzy+02lhiJ7JRaZZY0d1VIm30y/XjhfZhG+0CY?=
 =?us-ascii?Q?/Lc14SdE3RhlK1lPVW5v5Lza8b0K0OYLcoYhtG9gkEXrjt6FRWIrwwXdmcEU?=
 =?us-ascii?Q?OChzRECTNNd7g3NtwhVYazK+MbdTbSV6jGHzauPoFv2E2Jh5ju0WpxCPZjm2?=
 =?us-ascii?Q?OSb9raYYcEH2mhNbTkRWK6YmiU+UnQTHNrhBY/GZl5Eoov4RcLtQTym5EabK?=
 =?us-ascii?Q?NcQyjdFxIQXqm0sWAzkk8D+Shq0sNsaYz37GHfo/wEUMPDu668niBxmdoSLr?=
 =?us-ascii?Q?MMIJ/blWCPB7ZMwws6W6g1H5VdekDX8oBmtS2ywxGAEHdA/3O/P2TcDPeOjH?=
 =?us-ascii?Q?WBqwNr0ZXuBcxijzuZxmlLBZp2MPnBJLqLTS4jMtxJNrwn6Dd5GCEMkP1ASR?=
 =?us-ascii?Q?kMq2shRfTSif6TrtO4jnvUFpjIFqhkrmwKwtJG2Y3qN0jiWYB54gxdV8O4M2?=
 =?us-ascii?Q?Zy3pOfu43F3Ia9+Eh63J1P/DXZitlpT9bdshBx8lvYMmDGSLb9oKPoXLkSAB?=
 =?us-ascii?Q?U4dc3kvqzOOtYC6ES2nVAwLOWC+6s6CGK4QdvLblLgDLYJhzNjuvwUyM1JhQ?=
 =?us-ascii?Q?9vm9+3j7POafTnZ13fkW4/jGl1DOeLtlXpBhVt6rWzp+Vo0RYA25BBq3UkN+?=
 =?us-ascii?Q?25XwvseT41Q/U1S6rJLWWgS/3ElN4EpTwj5ae+fJVXH4cOTBZV3mzC4q9JzJ?=
 =?us-ascii?Q?xz+gi5hK8SUHiizv2TcXLOoiMWzF3H/xydhWcrwG72giTDFQO6BizcBzKHnR?=
 =?us-ascii?Q?MBUUIcC9yzGPPBuuGVdFOjY5geQqEu4ojwt6VDMJ8rluqOXmXLPLIdEIzSfe?=
 =?us-ascii?Q?FUFRuBjVRuCuyRifeGSXgXgpNrxdxaon9uXYXTPfLvq81A2mXpQiBP68qkb9?=
 =?us-ascii?Q?SB+b0vQHE8xVZXJ2keqWzah0Y7yvQDxGSWK/CDirPbmPd+/zzxquq8nMjjiu?=
 =?us-ascii?Q?zHse70xLhXUZoc/K4hx5r9UINPSSXKidFiv3OzR4heG2xowsPBCRYtqzG+zR?=
 =?us-ascii?Q?rpb7ZzsfoaLEr+quyfIho88HUswVlURbfYoDDdbEDapq3lH1+i105EaG6wMT?=
 =?us-ascii?Q?iSeyIhkZ8HgMdT72pXhRYXDJgHgYCjGRJSB4hYM1ti4srHNO4YhOaO9Wvc6b?=
 =?us-ascii?Q?wCG7x7LF976Gi8z304LuBHT7ZXlRibOMDqwESlkiXDYosIPBhokE6aPs8+iV?=
 =?us-ascii?Q?ovXiBYtY5tXZw3ITM13033I=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7421fa6-6467-4d35-4274-08dd70413338
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:45:49.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGIbJogkBzCCnKQ5A0DSogfP7hwc8Tu3zj3bOG2kZt42lZiVKAyFMSeqZjMd0T4pQJNteQg90pkJAyckDcRL95yVyy7/aNDtfnHeaXUHEVQ3oOINlKTgTkW/KknbZ+Hr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18394

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 5c7fb203d0dbfbfeed51991a4f98499b245634a7 upstream.

Add documentation for the pin controller found on the Renesas RZ/G3E
(R9A09G047) SoC. The RZ/G3E PFC is similar to the RZ/V2H SoC but has more
pins(P00-PS3).

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216195325.164212-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  7 +++-
 .../pinctrl/renesas,r9a09g047-pinctrl.h       | 41 +++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index 1a16fc06c96a7..716df90d5c09e 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -26,6 +26,7 @@ properties:
               - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and RZ/=
Five
               - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
               - renesas,r9a08g045-pinctrl # RZ/G3S
+              - renesas,r9a09g047-pinctrl # RZ/G3E
               - renesas,r9a09g057-pinctrl # RZ/V2H(P)
=20
       - items:
@@ -125,7 +126,7 @@ additionalProperties:
         drive-push-pull: true
         renesas,output-impedance:
           description:
-            Output impedance for pins on the RZ/V2H(P) SoC. The value prov=
ided by this
+            Output impedance for pins on the RZ/{G3E,V2H(P)} SoC. The valu=
e provided by this
             property corresponds to register bit values that can be set in=
 the PFC_IOLH_mn
             register, which adjusts the drive strength value and is pin-de=
pendent.
           $ref: /schemas/types.yaml#/definitions/uint32
@@ -145,7 +146,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a09g057-pinctrl
+            enum:
+              - renesas,r9a09g047-pinctrl
+              - renesas,r9a09g057-pinctrl
     then:
       properties:
         resets:
diff --git a/include/dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h b/incl=
ude/dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h
new file mode 100644
index 0000000000000..5917096720bd2
--- /dev/null
+++ b/include/dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for Renesas RZ/G3E family pinctrl bindin=
gs.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __DT_BINDINGS_PINCTRL_RENESAS_R9A09G047_PINCTRL_H__
+#define __DT_BINDINGS_PINCTRL_RENESAS_R9A09G047_PINCTRL_H__
+
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+/* RZG3E_Px =3D Offset address of PFC_P_mn  - 0x20 */
+#define RZG3E_P0	0
+#define RZG3E_P1	1
+#define RZG3E_P2	2
+#define RZG3E_P3	3
+#define RZG3E_P4	4
+#define RZG3E_P5	5
+#define RZG3E_P6	6
+#define RZG3E_P7	7
+#define RZG3E_P8	8
+#define RZG3E_PA	10
+#define RZG3E_PB	11
+#define RZG3E_PC	12
+#define RZG3E_PD	13
+#define RZG3E_PE	14
+#define RZG3E_PF	15
+#define RZG3E_PG	16
+#define RZG3E_PH	17
+#define RZG3E_PJ	19
+#define RZG3E_PK	20
+#define RZG3E_PL	21
+#define RZG3E_PM	22
+#define RZG3E_PS	28
+
+#define RZG3E_PORT_PINMUX(b, p, f)	RZG2L_PORT_PINMUX(RZG3E_P##b, p, f)
+#define RZG3E_GPIO(port, pin)		RZG2L_GPIO(RZG3E_P##port, pin)
+
+#endif /* __DT_BINDINGS_PINCTRL_RENESAS_R9A09G047_PINCTRL_H__ */
--=20
2.43.0


