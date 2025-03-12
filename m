Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E260C35FFB
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.31])
 by mx.groups.io with SMTP id smtpd.web11.34812.1741778700318022484
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YNJ9fhNN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFtq8bo3xA36xi80QSAMlnAdyOXg2YU9PXjp40HRsiocD1WDkiIP326iZNTLYMesw2IxPv3+QxQS/sZP4KUby/bqyPh3OCT2WsUdZ3turf0WwuhilycUVAVi05vY2SQH4frdDGoRfMWphp0AyJx0SRlN4xS1IGJR1/nLMtdS/woAt+aXMbhYnRuaTGkc3XJ/L0qLeBhTOQdNLX1g40UQXgumQnxzd9i9RhNGhT+lbeuBmhH+24Jzsa3gH0W2QxJ34qtImmnOztv1WH/qIlnYhO01Kyy9TD9B729YJLYQFz9JEPLow1nSlVvPTF6cjEVeAM2Y4SQVwF3NnxAysxrlSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5KPkrROtvrXZ7jp+v5XhXuoZD6BvmUaksFZ2anWDLk=;
 b=ZfYEtng6fr1YCNBChToqELScQk1HmqXJPx2kF6zlrSxzeYnst1RuA0E4xP5TuK14g01GT2P05VAfLxYkLv5NieE6cMF1bqumCECM7IsAptVATWnh2K/tZR6Upo3TpqkZluzHlFPCALpbLSto+oxWPATQ1q47EIiVcURw1gXw08ForvbXu/2sUehaUcnKIX62X27jROmFyz8gxFxDWHCeYH8nwvWcy0vmrpMVARBh6ftvuQ7L1a1FRO0wNoBs2Mx4LDUwLgAZAQezdkqk16D5HHaMs7HTxpQHlSWWSm+n1fuEZ1/bBYJwziJehe5FKoSOCEIJ2v/xflTxcJR3+MdjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5KPkrROtvrXZ7jp+v5XhXuoZD6BvmUaksFZ2anWDLk=;
 b=YNJ9fhNNw/FCWgoUk910ew5SvZg4mzjoVto/R1ZjRUHxIBK80uROMLuoRT1qmIKfigGXdw9nvywkDciEgcjN3re5p/KrJuDAADQt+waxduCST0wAIdf8UkYmGP5qkUEcH+Zy7DCdTt6Dac0EvTXhFxdnXQDbSMyo7ELug0f0cII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:24:58 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 28/85] dt-bindings: pinctrl: renesas: Document RZ/G3E SoC
Date: Wed, 12 Mar 2025 12:22:05 +0100
Message-ID: <20250312112302.1605750-29-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 8901d336-acec-45c6-015a-08dd6158858a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wtjhOvsr4/IC9sEQP3ujLt935yAZCGRfk00Kz+KlrAz9T9FN7B+UjER+qOFF?=
 =?us-ascii?Q?KjWdkknQDljfHANoTUxdTxtmJCWKaDh5qW1xHmOvXa2aKsSpDuIGpjf7raAv?=
 =?us-ascii?Q?29+kIv6y+Ki6T1mhtFSHTqJ2DYO3Rd6VuNiIkI5CrN9bmsGcm0ghbWuevHGW?=
 =?us-ascii?Q?8K0KD+dzlu7+uP0JW0w4LXFdi2g+B2xnPLZE7n1VyUAlaV6Tr8JTcPy7KILE?=
 =?us-ascii?Q?hSKFUri/wGEOdJE5/d35uVp0DwI07sXyniGn39JW5mCdx+TxXHvfbJPhChuH?=
 =?us-ascii?Q?A8uS2yUwNEnBtLgqUe8jXerwtlTJtXL3N0kJM/HsYihUVN0V6/3TDvEiN24v?=
 =?us-ascii?Q?nJWRx8g0ckA0cRhBscf1F/liyiCvXH6bA5KZWKV8cywrbrGlUB7pCVVqGcpG?=
 =?us-ascii?Q?j/ztY9lDoYuMr3NsKBD19QdqzMdTrWO578F36NCcHPsCeIXaSAT1FZuPBfLj?=
 =?us-ascii?Q?evy0FjKgOlEY96KawmzgflVUKE7zatS2SOwxQ3cIlNXyDHZMGJ5dlCJGXV4h?=
 =?us-ascii?Q?dt/2AgvbDH6DNVl2GzqSOKaDrS/Lrm7TsNHvB/nnBAKxfWUaUzC6ciYagN8z?=
 =?us-ascii?Q?2S5chPrN5cw++6svR4yWwklTRbtEN31mjAyiUAhyEg65Rcq1C5/+VS6B2rt9?=
 =?us-ascii?Q?1QkUYDIjnT5RdRrybi/fZUFxb91c4JrFZwmLmz5u0m4F0D1YPfKkx7Jz4j/W?=
 =?us-ascii?Q?HeyosaL//Eb2rIAlMcPiJQFHsIvl/o44UXCCRQD+n+S7PBDxpBCRWPUGfjLC?=
 =?us-ascii?Q?6D9DbN0GPLQnzS+9Pa/EqwcyVNZWahI4VeR99DjjEnk7vdOA5JSYCeGL0l0c?=
 =?us-ascii?Q?op0eoKofjdx5CUmm1suS5a+Sf6aM7BpyZFdkWpRA3QtmarAIQFMt4ZfytGeI?=
 =?us-ascii?Q?XXBHTgjRlqPFbJbbWu6TvoGYdOjIRS8DzLON+A0xoR4wtWQAklFgHkEAPokq?=
 =?us-ascii?Q?MiWvajWrfoKDjZWeJiOHoiprfxitXqo6In5H0HmZKReMXcLa2D/62UmukuOe?=
 =?us-ascii?Q?m7ZSmTySj8DX6mSsAFwhoTcdPOdCkGAEangD4d4iAVqUEi0Q9QolrIy6/l8W?=
 =?us-ascii?Q?HGM6DZdqzXCntwJVg+wBLX7xEHzHkcKugD4K0jkyvVS5mPCuzPt0zXN3BpY4?=
 =?us-ascii?Q?6uPsaiCdiWTl+gY5SodM5Py4st7xusXSkgEYAdc8+UfCZsxP7mkmBZCMwHFx?=
 =?us-ascii?Q?sXrPp4v7QXgt4F+DsTzXojbA+AvWL9RJ7uVF9qN2zE9IoLiToPe9gPbXBUY5?=
 =?us-ascii?Q?YducjULyp9SQ/1qGf0UnxUbwgCmW/ibQoUS/DFNNevKXKDovCcE/1AoyMHps?=
 =?us-ascii?Q?+BKJ/nJTEPgFIFJ2S1Pf281KI+vI9OAKVcgnmdQAzx3J0PWkVLXOF5HbHoSd?=
 =?us-ascii?Q?ALh/ziYaZkZczyLR3kyexQ404Nk/nPJc1j2hxEu05IgE6CqWnkC2AUjy0SVV?=
 =?us-ascii?Q?8emV6oOwfa4KNqRu4gcDlTRL0ejf1wVX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YSbSj0rDq/aHivRE9rfT6603I38gqH7oVeaSRTIdFrW+JdygsP0oum9Mc8nL?=
 =?us-ascii?Q?to8HZeJdUGnfxET7yg/0Hwbzowog6mks8mXNhq/e9iawE83q4EeHT2bh2Tqf?=
 =?us-ascii?Q?qMmZN2kOw39ybXyP6Uqp4KzF6Pfsujk1/1W0b2i5k6mNgoFZNbLEnE61BL6v?=
 =?us-ascii?Q?bFlZjXR/63hx45GM1BjGDKDUfQOVOhmby1VpVMT0EFGtXRLtEu1UA4P6O6pC?=
 =?us-ascii?Q?0d8ScXAIyuIgdml6UED+0mO8Hr7HCv0Bu0UY7Hoj+pwMSgyGLp3kPU+nTtdu?=
 =?us-ascii?Q?31+9XWsyf9gKzo42pqvdOgoI9XumIqghW8QHUJ1xq0aFlvSyqokfHiJby3Xa?=
 =?us-ascii?Q?dVLBs1Z8ChARq7G0V8nGfldAG/xPrVsLaVrVAip6mxb/jednQc7Z1spJfIKm?=
 =?us-ascii?Q?3WqH1oZds2S6ExuHGS9yPANDp/xFeXHat3moMMmsaKn5sk8MXoLTCyYem/kN?=
 =?us-ascii?Q?daC1zm7G3GpeimVk8jpF/Zokym2E7QTV4DoPrYvao0bbbUwczOAQpzw3Ur44?=
 =?us-ascii?Q?lP4XPHdSD3wAHE9/uE97fKlDKB+BfRTxOFlRFBCX/RcuGZrExhwgQWZoNTKr?=
 =?us-ascii?Q?xX8f4YVAbeL3Cg0wJgDQoXu+Z6IhEhpnJfqsorIuQYHxda/Q7KCrqkfiDSs3?=
 =?us-ascii?Q?tKwlhTGQi5vKKVgVu+hl+WR+gP2a5qfAT1b6NS8aqAenNaRbF0e1BxEQpCWc?=
 =?us-ascii?Q?7J6S1xH1qJvMMEwx0teUKDApagaOo6kBddJRGleuglI/OTuERNvZ9v1rPGcZ?=
 =?us-ascii?Q?bgNlvM3P6mICQ3B1awYWQG9YrlhI8qO6b16G4l3mV0c4uPwqGZ/wQ/JH1kOY?=
 =?us-ascii?Q?Qw4H7QosBPWq96VAkK7DdR+X0NLUAI46UYsctekcm0Lhuh+lr9OfQSffXM6F?=
 =?us-ascii?Q?MNkW7DUQWl5R2TCzgTcOqPPRIt1/hXkScWRb8euNPj1bCEkY8tGwwM1b4KTw?=
 =?us-ascii?Q?VILCsj9aNchSiozRV0hG4jJz0VLPCYwx0KDzqVzfcXwtzD1yD5Jrz5TC4pir?=
 =?us-ascii?Q?lg8jZNpoxa0qz4V6cfqNs42UY3gouGIETyvjWGPZ7jWUhu5vQhcM5ZDRQLRX?=
 =?us-ascii?Q?4g3oDgA9dOwbso+v/gVYhff05TVwzSJXxPAFSYLkitOZKeBTgHQurW+37w6Z?=
 =?us-ascii?Q?MFZF/iPb4dQrT2Q4ervt5LLpaYhTJvSmFGjpoR8hnMBb65tQb8+Rq5x4BZ3a?=
 =?us-ascii?Q?t2os9zuMENGlimvBJi6zErtuIBW8eRlbANUbfuuWyfHdst5foNAtkTlBIU+O?=
 =?us-ascii?Q?aloeCPb4U2dKo3HAUe5URdgdeXph/qOYfDjDuXTvoGegtd0vgI1BljNLPoZ3?=
 =?us-ascii?Q?BQebyNwk4AMQ/bYtiS5gbAdSCdSNXcMQ/87lpKSVNg2YzrFQOgLRzgByiEel?=
 =?us-ascii?Q?Op7XYFo0y+JTgwtw5COKDLZHzXeO8KOH2Rm60hlw1obp17wlerAjSrtmm9XX?=
 =?us-ascii?Q?DymYL2YpAT8kKEJ1L/Vlkpo9U6YlK1m5I8931mTk/FcQGaj7FWbsB41pVCK0?=
 =?us-ascii?Q?/Zj1AP5uEXydAi3B15BI8AC34QQ3g3ReUhjYWF2MACagj84RLzHihNcgaJv9?=
 =?us-ascii?Q?NZgZEj1dz2SCVL+OGxd1JgwJhjvOVWWxnY38DOhlERzM7WGG39C5vNsmMCcm?=
 =?us-ascii?Q?CDTKNIRtiN/t50srF0cZ1tg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8901d336-acec-45c6-015a-08dd6158858a
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:58.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4oSEUOgWsbbWYAec9eApTeqLL3NRpcykJHTPc+MPjTARfDeYUN5NgQhO2vJFzlSivaeryy82+DbooVS3OmsWGWm1+Z16DddZM4Of2S4ZiDnYWYxVUNrWrv+j8sCyNE3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18120

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
---
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  7 +++-
 .../pinctrl/renesas,r9a09g047-pinctrl.h       | 41 +++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index 1a16fc06c96a..716df90d5c09 100644
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
index 000000000000..5917096720bd
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


