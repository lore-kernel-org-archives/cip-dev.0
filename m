Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB093C3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:07:41 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.28])
 by mx.groups.io with SMTP id smtpd.web11.49165.1743419252172756719
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=l3AjL1z6;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.28, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utoBGs8RS4PgERhhgIsYp8KtCVzYF/jcFUhmXsmMMLTd2J8wyawtkuw9fp4NvJv5UxXRfVEdc23m5b6y9G20RVxJDNBg+dkVZbX81y1mKEKh5V5BEKVKqsBwrSyF0DPDYf0oaEdOIekK+IOA4MPXWUsQNXxYLrFr7IWe5sx1GT0P4SeGH+NMmhamTxbBn3wbsmAyu01iqulWwDIj1JzF5YjFdCvIgUJ1I3wgXu42sz8SSMWVk2z9TZ0x0JlRNFVwpcW9MFRE4Nj5zt82wFUq2cosTnTur6uZSvbl7882gs+RAnG7G4n3KFV46QWnnt9okdcN7hFDJnpo18qcWW9Rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPiPcck4rLAOVVGZCuAcoHCrE1tYGs8n/rB8KHgiPTM=;
 b=GWFFvWg1+NParBXxByOIDYz+HMldmxKu2c49unp80IRA4pJGLwb+ypNIRNbY4v1RQpt9PO3PoTm5CXwZsST1pS5GFMy2qZQ8TyIUH/lhBm//cVgbA0tG/o79hq0oV0/YB9I7kcLod8ItREb4yeYHF1w00gRFp0AcXOOssZFvySiJZZRcS7PgHLcNnPVVTiOKpyAtfM0Iz2VpICBCHDLZlcx8KzE/elNluW23ZzNLFQ4pOIDl/zKoglkykGkGCCfm17lkBZn8nXKoTwhfsfOsenJPvd/yI/Bo6PNV1zo2+HckTWCV2KdZQvvtphKxq43AiKrcMWRQTP4q+OaImbQWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPiPcck4rLAOVVGZCuAcoHCrE1tYGs8n/rB8KHgiPTM=;
 b=l3AjL1z6L5c9qe8Fuw+4XYZ50Ub3iWk/eqYvGfWutKwiKj7qdCjGxiqzWdvUQA2JjhsQPwmmAYJqTEfml5fLNX6vjfhvitSRbax4fEUFEuOb58NSwOjVJy3A6MAS2RnUUj83lIHsNtFWj6MA91++gLfX0Q9GNuZZS5FhSY1NHaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:31 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 04/13] dt-bindings: pinctrl: renesas: Document RZ/G3E SoC
Date: Mon, 31 Mar 2025 13:06:50 +0200
Message-ID: <20250331110659.252237-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15065:EE_
X-MS-Office365-Filtering-Correlation-Id: 37269b83-3f5d-4584-eed5-08dd70443b86
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8HQj5g1c0XGJedbxtzBAhRXrB4b6fLndXIblsIgmt9xigjlkQuseVsF/BGHZ?=
 =?us-ascii?Q?2D/NPhxBtjfXNCrCYW/H0ztPXzCXTiSDxXtGna7QNWYQlGdyQKTwQGzGz+6k?=
 =?us-ascii?Q?bIW55rJxsiwJ+ET36W5IvamF74h6Moxd2EtHXG9Ra4581yN0cGKL4OPsiZ/+?=
 =?us-ascii?Q?jxA6wVZN/OT/rMDt5wEfBQxB3QvimiA2lLBDTkgYyIy75c1VDtmMVrpe1HPV?=
 =?us-ascii?Q?NCbDa60CPhZhOgBc+O6IKnWVRxa3ZSo+r4ZhrIpTTPKlBr5rys4St5w8TibN?=
 =?us-ascii?Q?kOWg37yJS9X8gIZWpNBQt7M2azQVVyfft8oUWFSimCo/iDXTp7YvHXF+2RqI?=
 =?us-ascii?Q?xie2uJe7EUvi6+QiP3swPdBTM2ELHSeA61wrMb0RibKy3tkQ/tFIhGYb2n0I?=
 =?us-ascii?Q?bHuidRh6g+/K+MynqUPbO7j5lDaUcL9lPJrmCa06j2iHAWKGX6hieiGmZyUM?=
 =?us-ascii?Q?pD99P8IeQDgPfLKz4jZSlSEtk9ZGSLNI9NZlDFn2rqIZTvq4Ht9BXTKTy9+j?=
 =?us-ascii?Q?SNbZlYyifkdYtoZ+fvKVd9n2GrXfxryxyvwaZ6jEBVcT9mpVqdUoCneXhLJi?=
 =?us-ascii?Q?3jRsaOlLEZ9YErdqIZJEKlB+PU/yl5k0W4Fy3uUVWZH6LqVY77H/lVRjCSxq?=
 =?us-ascii?Q?BiLhajfoKji9HdeavdmyxsZmplBagIvhTe1gpMAnCk7grghV4WflJVhG+B39?=
 =?us-ascii?Q?fe6/v1cHgobSH2pPmcRycsjSXYn5s3FBXHynM3h+6b6I1JTC+fQvksN8NJNZ?=
 =?us-ascii?Q?Kiw9zZ//FZvyoUbzm4y+MdYprzdAu+nzghpzNTWOF+4Dm9uEpuHl0gVqYa+s?=
 =?us-ascii?Q?h0QVJYRoEaHoejJaIMGlMkbN13cyBdEnbl+/yp+doKAYY8KUHFhhugJwNKVJ?=
 =?us-ascii?Q?Sar3DNghhipM1DNWPX7IopXQnK3jH+hSdTkQKrUe+EvJczyCAi2Uj6NteFJa?=
 =?us-ascii?Q?ua5fojoCyYgMXMnCSpkx5ClDZXySoDJ58cOEGWrRkrke3hBuRyDD+9t2uBDC?=
 =?us-ascii?Q?a5GKK2dH/Y9XDOy/yMv5+aISEpaoSwMb2HGJXsh/I7SqOROGffWbmjUTA4PU?=
 =?us-ascii?Q?9dnUxm1mHrTyIEtOz2lfTHlCBKKJB4hQQMr+x3LTMlusw4ZGZlnbqiXMZ/yw?=
 =?us-ascii?Q?e/EbazTVVPzlsub6f1uEG1Eu1ENwv4PepXKNot3jXviiczddPnyXIwv8GgHF?=
 =?us-ascii?Q?5qzg2rafRORiaMRnruV7b+SzZ/+LSZdhZAK5Jlaq4PPhd+8aQsPwhXKvX2zc?=
 =?us-ascii?Q?CIj8DTjcawyzXnYOPc9WfTkFGiy4tPASEmeV7D5cM/It7It4AvjvZFhbBqbx?=
 =?us-ascii?Q?QbsOBmHDoR5/ujwm93ab2W2GBBaQLwcjgIl2LFVi5BBIuzEX2gB6AOfGP1ED?=
 =?us-ascii?Q?f6puIZjL9N7i7BOKGq2KUni9ENjA8U1VeR11Afjg0OYxU1lk8H6ZHTb1xw/C?=
 =?us-ascii?Q?ZxHi7Tr3wGvlSimP2ItozLaZKPb/ZE93?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GFfLmoaFTkqr7jjdVXbpgxcKMFiBlqTkSJXtbggy6xiLCHULgUIwiqspgbJC?=
 =?us-ascii?Q?K1xwcxo8gzF4namLJIIctd/MSpI50jbdaXQD6dgfKja1LOv8xXrq/YRsPDE4?=
 =?us-ascii?Q?Vsbllgp7J8AxcajNjolE5oe1VFYdVrW9UGr9WSaT+MJFKuf2xnnBLspJ5Aha?=
 =?us-ascii?Q?/4azJMXbUSZmUVJr6hLNsGJCvusEtrAvyNzepCdn++Gwil/4t6RymswmwtQM?=
 =?us-ascii?Q?VQ6gDIrDzEGZNU50T8upUsgMoUevEeQ1SV21knCSk4fkHXpnLVcX77XFW8IB?=
 =?us-ascii?Q?0sA2Pe6lzrlqe7t2NDNG56jcQHuX1el6uNJjDqcebYdS9wsQt0W3xDbJTt00?=
 =?us-ascii?Q?qHwAGpJK/Zhl1sRqoMgMVyp0fQucGQS8bJ003RbCHjtf7CYcTfp6BaC7iTT4?=
 =?us-ascii?Q?lcE2yuNAP/NHuHVMgor8h9zejWOOCIqb9TKiKn3xQPJTZz/HFgbLNrjuTnV1?=
 =?us-ascii?Q?L5nSzBbaXfe0JFaxad6z1hU4F62ngWYzAVbslA4VC1b7OQOsaG2JYbSPKPUK?=
 =?us-ascii?Q?X5vEzvHGFg/Tt4zWDNWIuzC2S9v0jVT/7dRxrm/FZpj7ZbnFNK/Lb2jItxEU?=
 =?us-ascii?Q?r+oJcHxMGj2VEAdg/eNURZdk+bUOSyPVA/aAIJEt/uJhPXLpUpVwU9FwMQeO?=
 =?us-ascii?Q?8dp0h+kQ47kebmaONOnivmlSKvduwiMi1GiQx2EnGIKtdYie447bTrBoEV4B?=
 =?us-ascii?Q?Mvv0P3MTZRX4RQrGKCkA4yWuUVXfbV41OKpUu+NxTsp/IciPEqEfEbqaKMZu?=
 =?us-ascii?Q?qcAn/9cqbhYHj3agStvzewIheAeay5eRX9C0H7atr4IhuNFwc1OuSDFCtoCy?=
 =?us-ascii?Q?Pyp+65BPbIUf6KG1VyfE/DfbKrNc+O1bMsylQdKzb21REFGMnbFlpslgw/E0?=
 =?us-ascii?Q?0sTxH1j7c0n8jtwgG+jQKNUmx10+9JLVs/lH1sWo9Zj3tGfXsRBrjHrqaQM+?=
 =?us-ascii?Q?l6TYy7WNBBkZkwDDPO6tGdt5X0Y5BqSfwVJhqErevDq7uUXIODca7jDx18yO?=
 =?us-ascii?Q?/mGGuNT8GRQ6lDDorzxQbrKwS99Cs9EbWSOVX18+Tsj3kP0bDW8ILhoAMBPI?=
 =?us-ascii?Q?6j8Jhhc+L8USOzXZb/KMcl5pFkQHrMnlhFTvsvSvmhVLe54yKCIrrYWRcitI?=
 =?us-ascii?Q?r9t/EtvwcA7krul0wIVr+QLCzN3/x5BD+0ngHVJ/Mvfm3YXybib8ujG3yrfL?=
 =?us-ascii?Q?SU5hFZsC9CRZIWw+qb0jyEtKtjfnZnbj3olXdOCcHpjmoWRXaZWfce/326NW?=
 =?us-ascii?Q?c59fvrKuscBKqfeWoz/7zsqqudvvWeeTuKkKTesUhO+D5I7zEdz9l4TduhFb?=
 =?us-ascii?Q?XymeNKLUYd4rDdY++AaB/S4aiGa0g6NwPIAIkehWQJakJ4E/A82gUr9VLapW?=
 =?us-ascii?Q?z3IOFB1yfceM5j6bP5HrgzqLN5mxPcdZuVuLqk/g/RLsZzzHhcSbB9EaYAKy?=
 =?us-ascii?Q?+N7xfFR+TrW0rVCczGbRAFRCVnAT0YP5Q5l21wsIPntLg9cZIm/3NHyD3wIQ?=
 =?us-ascii?Q?zb5XRFnTekxGmiDA91GQ5fAJly89yCxplgeoLcea3VAxm84yOBNjQSc+mIwz?=
 =?us-ascii?Q?e1cIe9eK5PG+QJYuJzagOtdmuo8cKuOeWq51vSimSWKRcYUd3ue+2S22E4Ye?=
 =?us-ascii?Q?KqywzgODNQdcZtHW3mQQ5G4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37269b83-3f5d-4584-eed5-08dd70443b86
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:31.8410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp3ApiFGN0AAbEGs+lAxzBkEyrn5b7R3f5ai5q2SvT55cmv+YvwN7vEHJ1lbjJDEbvvdEoaOul6j09K2yhkdVo/xoQ1o3cMBhksbdFw9Q2b6SUIAmchvnOUjh+cYGgCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:07:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18436

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
index 7b9b65612dc7c..11e22610125da 100644
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
@@ -156,7 +157,9 @@ allOf:
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


