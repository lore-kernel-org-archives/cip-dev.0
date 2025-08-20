Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC30CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:34 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.8])
 by mx.groups.io with SMTP id smtpd.web10.1054.1755706108679269701
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gwtbVWOP;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.8, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0DRFhk33/LmsfhLtD4qM0B6z2nTlrTYOa+orD1dVN0KIWhjZ2V3Tq+woTaxypvGc1+pnFtk2DlhDIDqGtcRUDQHBcQjNQRIazk6ZMwgnUen3zj1DBHKtrnCkoOEcdLg7fPhmIWFl82QJky+MAeN41WWO1PTp881a3H8ScTzhmMYYQVqJ2Y73/rjxp7k641s3MJHxq/O7/y58VymoeyTm5r9cp62JOoHRR6Rn/a6r0ibkOq1smaaNYvFn9tjdAvnnxo9+ctl0wJklp11TlAL4aZ3wSIPrhY6W4eXiJUD+IJBRa087WAbIy8BlhiiU83MWjbzIfeG5V5G3fwFx4qaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO0XoDH6sI7amNBbxvjXv3XS334NB74y4uK14I7SmAU=;
 b=b52trjqPnQDpiK1TL29Nr3SlyXmCdRqsVdP8NgUCHhPDq7OWG4m7kC6TAfOuRIeOoza93hSwGTt5jawjYGEuQDGRg0ZXfnYrshC8gWTOuq5VU0txj9aIL4I93EBvaUsixwNJzd35UNbVJLvDvxxOUBi9sp1MFsRTjmelgwspJFWu0BIX270I+htI7koJTwUn4mZO+QlLvAoIiUzCnn0T3Powl+o5XplwsRXYv0YGSvRrl7vDnfx3pc7GPU0p+FTpKmUY/Vevr7bjW/7JNe0HonZUVVH9MtNd4cAkJzqWfXqx/nTxhqpDOf2rdSg7lTBEVbFiqYtF1lQSAB8Fezjr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO0XoDH6sI7amNBbxvjXv3XS334NB74y4uK14I7SmAU=;
 b=gwtbVWOPpfzTZDIx5FAmcV6DG5jEVuo9Cz3j9wxsVLn6RXutqCjGsS4aiAs/JsbxXDI3FY/xzsUw+yG4msis7q2PsJVzwsQGVjVXNRMa/Awbzy3DdUCJgdRKaeDk8GFDIHORFUzd6SPGd7U0lhDDxLw6RrPVeVabvmAXaZlZmR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:08:26 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:26 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 01/55] media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/V2H(P) SoC
Date: Wed, 20 Aug 2025 18:07:02 +0200
Message-ID: <20250820160758.801813-2-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f443635-d5c9-4d1b-d1a1-08dde003cbb6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5NQdERVzMb6heYWI2+5m4vlhB6grWG8nfm9UOBt1hG7v1EkUCVNOiHTWrkKD?=
 =?us-ascii?Q?zrmMFPm60oP0cN6tMs/msvELXyjIDWOS89eAQrjp56oGChF9AShDpg8YpGD6?=
 =?us-ascii?Q?d/qiv6+1uwraO+PX9jrfXAKtFM+tLIs3EgW/KtmBUEp+po5YypZeZeKb6Zan?=
 =?us-ascii?Q?rlJDL/6IphGrGVxmfaN4f+/9S2Rd7vrYqUKx6IgBaLArNNDVRpQ5a9CHk745?=
 =?us-ascii?Q?nY72YoEYDsNwu51kq0+Nsdh4Usavr26cnvvEzH934DQqZoxBx8gSVfTnd9Fi?=
 =?us-ascii?Q?ifT6xNKf7OU+NeJXJwjAmjh7be+EbKVAf68JqeW1vzCG/dfzUujW+pPRpzUA?=
 =?us-ascii?Q?ulRNYwEkTHNefXPGCGCKR96pcW9soszGjyLUDUbTtVP8BgxgbuX/jMaO+nVo?=
 =?us-ascii?Q?TGdS+8MB5brp1neSrcLWkuIAsQQOB3MN4F6A5NJGb/mgjza+NJeeNdraf34A?=
 =?us-ascii?Q?ScKIoWOK7ZgeF7zkfoJfkolryqZ5Gr9EkFQo6A53TkX/SOWOUBbl61131oBp?=
 =?us-ascii?Q?8HmRMaCWNCnpOMyESrGkirPoyGhiVctI6rglledO4O+6iAlwFVP+TDVtn1zz?=
 =?us-ascii?Q?LBCJ4iroADMVJXU9R7+pSKia1+mRiKSjtjd/eYxDRBY/r1rcxIN1FpwcmVsE?=
 =?us-ascii?Q?eKhzsgMd7RXJ+h1QBkedtBIk3yqv+G6bST50XuB3BebliFjfpf5GkZm2ah6a?=
 =?us-ascii?Q?Pr3t3B6PK/x4pIZwWsQf2tnIK+I64juHEV9b65UKRQB1/9HOIf+KoRcE7M1+?=
 =?us-ascii?Q?g/ealla3PmZPC04lVlAD+BPnrpuCe11QUb+hRJ5WSzCgY6JlLO5gCuAgfh14?=
 =?us-ascii?Q?e1k8xU8atRa77Y/3kXstRrpsPPWLE1AAs7pZNembrh2JqjRwwV/cwXpR5D5d?=
 =?us-ascii?Q?/I/c3yLMxls+7E8/h7WdN7c6SL/zc8oiSY0/iZ1IWCssbLT7JK5Rci+iOTqW?=
 =?us-ascii?Q?Vo5bUK6Pda/jeFbM90i6el7euh1vrPQyvcVVfcnVc7LdywL6Scc/m+VHqg++?=
 =?us-ascii?Q?hz3jI5cj0AlYlfbxPYp6IUYJTXgQrAkRs9x36kZfbr4cjogziXE43PZsHxKj?=
 =?us-ascii?Q?jBp4fEvqLzzlK80PQZZKdpsQjcOMaTcqFJ2iuvtwgGxdCgg33x7KTQ09AewA?=
 =?us-ascii?Q?DwkTvn/QN81aNhcgaUtfyxjTVfqH3eLqT1L7kbc3ZAjqcFOhfTkX7IeknRW7?=
 =?us-ascii?Q?EYdEu4CJsirlDx5XLtinhXk2GyDuUe0NcKODJRcuH86C1fr5oHx5VHhQtnRa?=
 =?us-ascii?Q?wjHFX9hJCVZh1qRqROBFKukLAqhTiO2NdXpwQiSObcfEtZ5vIm3jWaMejSvw?=
 =?us-ascii?Q?ovxbWeIXXz1EB9WhyzVr2ZXDbaayG3IHj5x5FXDhmIzFdj/A8ICfB/BHtS5W?=
 =?us-ascii?Q?gwfpZgEJOClxqNOnDbRZX/d2uug9/ArNb3unwZXX4uoVbRB+tnRfC+13cE2c?=
 =?us-ascii?Q?EQboyt2+xSLlwPrm1x3HMCypzzjs4bx3KGZ+EwYUxK8p9Mdue4VNRio3y/hX?=
 =?us-ascii?Q?vSPjYa/m7Sm1g3U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9iEs2+KeLCbh6M2UIDvPcggWl9Pjj30e0LxOGKE1t3NYLx8/0fW0CqysYxm/?=
 =?us-ascii?Q?CwrYpBFePNQyOo/9OpOD+1OsGCaJD1pHdhK5wlzoWyvFOtsN3jBCPLIIcvyK?=
 =?us-ascii?Q?kqLQ2MTbubsIdjwCo5URB0klvxJcXyKXhkmwP44zkIZNJHn40JTtuD+0QtRm?=
 =?us-ascii?Q?LhabAXpiLtsEkE2OuzzpwNNE29lTu2NKFGsuylUUqqeCkoNWfKkR5oSYVZkD?=
 =?us-ascii?Q?v2nKW6y1Ovm9t2Kl1pw0ak7ykvDj+/aGkbsPbZmMaTbv+PPhvK8CugX5nOME?=
 =?us-ascii?Q?mOFOj1WwUqpUmKboT4IyhAhnXsRq2gRo00xOFYz1Se5kayXCyekI805XqStj?=
 =?us-ascii?Q?gCkjAE+O3hTAHiGSvagY2aROlM1+ed1miNZ82ujhkJM+F57XVpaXMOplKIc/?=
 =?us-ascii?Q?UkrhR8RuwT7mK7OXWcObRYqgUqcO7A5H2yXhSHuCDSSK1eM5WlRPjO9tkF0M?=
 =?us-ascii?Q?Pr5Pa+esWTOQ8XZWkW86NbvWE1SXRCGZDr9koHrR284D3mgvLdIDIIbGRV50?=
 =?us-ascii?Q?Mr4pef1lDwuDaqTmeR1e5q0BmhQA/x8uPREBZbjkL2vydJ/RVCqfN5JxexKD?=
 =?us-ascii?Q?NfWoDOMxz644ZADPePHc6defHGhwaHWzuWTXPzYbwpqpavzjagvCNb9W/zXJ?=
 =?us-ascii?Q?WDRmdY3vFQv/nI+/MVg3BHoWxTFVnH5fhOpzJXUKxM1Te7WcOIkh8T9fCAAr?=
 =?us-ascii?Q?6hbWUePuoW7LN45SNn8miklLWMC6dopEpYtnkLz5HsY8kpmqxPmimjJK2qpX?=
 =?us-ascii?Q?O50dlPM3/uokA5UqBC4tC0AdscKKbKaLpYLZjyDC5ptLdzLUsl13pirgoMZX?=
 =?us-ascii?Q?i6TiSWN2xQ3Lj2HFYceHnp8lNPVs/kXEll8VVrR/Aqt/qh49RYHsWTRbzYpO?=
 =?us-ascii?Q?gDXHNVhO2fTjr4SM5pbQg/qGaB749FWzeGNpfSmirk5qNJQsHRVMzLyI94xQ?=
 =?us-ascii?Q?S5vBiBpxJEz5/wMurUVoVbFsN/5ETifLjToz/m31TipQFmm3kfMCYLORtFPR?=
 =?us-ascii?Q?fVi+HssEkSRx1nPM0lBdwzy0xyT1Fmy/L0Y92zee+Y1cxvDWRMn4++zsZ7YP?=
 =?us-ascii?Q?ctrwUZcn7NPAC1rG4xddcHoNqiTJUQWzcwxUT8h3rwnOJ9j9kgia8m4sX3h4?=
 =?us-ascii?Q?GDx5dSdEiEH8OFMSys/WUTntjgNoW6sbSbofytzoKlbkKanUmfgUPd3oKJc8?=
 =?us-ascii?Q?beKhEp4F19IXwJ49R2oKhJ2Rx7iYzn4DM0A/uNaPQvERrtKs6mTTlqfVwLsx?=
 =?us-ascii?Q?+8ozGtQWXdU7MIKvRnoYp+Xz90vNAG2Zn7aBfEaaZXKFyyptJeJ+va8U4tqS?=
 =?us-ascii?Q?YwuyoDpkfxoaOeG8rExxSW/bvj7Wy/Gc7WfWFAIUnsg86SDXwsck2XqBov6Z?=
 =?us-ascii?Q?XgUd7QP6oMR7qgKZWp6+PRRXNS4h0RAdfzGeeg5ed9b3KDbWNGsscEMdUuLq?=
 =?us-ascii?Q?mK+j7NYmj/G4WP1iqCR55DsiqO4A0opCeDH4B3uL/T919prRiUcqHlkAQRj0?=
 =?us-ascii?Q?qQgm9D9ZnKef1qPFWtXgiFelUR+Y5JRajO+hk+Rdp77lJS9c3Q9J7+Xu51WV?=
 =?us-ascii?Q?Tcrt3ztUuJjGNReNs7bGyWLe2rABL08aD2q13HwDXbdBW6xAUUkL+e9de+mV?=
 =?us-ascii?Q?D2Nqhioj4UVKNWf6IX+d600=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f443635-d5c9-4d1b-d1a1-08dde003cbb6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:26.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSjzNzeNA7/oybwepxep4Rp0uTJSWSCR2yQfDqp+tayoJ5OAiqS9MVPg7UAaDHLel9NDAzcxHz4j4iMxepugNgmkI4ycCGWWxoml+hl19Af28RvtK5zzgzrOX73kTq06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19882

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 52e39050616aa7e72ea0f6330501368d5f6925e1 upstream.

The MIPI CSI-2 block on the Renesas RZ/V2H(P) SoC is similar to the one
found on the Renesas RZ/G2L SoC, with the following differences:
- A different D-PHY
- Additional registers for the MIPI CSI-2 link
- Only two clocks

Add a new compatible string, `renesas,r9a09g057-csi2`, for the RZ/V2H(P)
SoC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-2-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../bindings/media/renesas,rzg2l-csi2.yaml    | 59 ++++++++++++++-----
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yam=
l b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
index 7faa12fecd5b..1f9ee37584b3 100644
--- a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
@@ -17,12 +17,14 @@ description:
=20
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043-csi2       # RZ/G2UL
-          - renesas,r9a07g044-csi2       # RZ/G2{L,LC}
-          - renesas,r9a07g054-csi2       # RZ/V2L
-      - const: renesas,rzg2l-csi2
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043-csi2 # RZ/G2UL
+              - renesas,r9a07g044-csi2 # RZ/G2{L,LC}
+              - renesas,r9a07g054-csi2 # RZ/V2L
+          - const: renesas,rzg2l-csi2
+      - const: renesas,r9a09g057-csi2 # RZ/V2H(P)
=20
   reg:
     maxItems: 1
@@ -31,16 +33,24 @@ properties:
     maxItems: 1
=20
   clocks:
-    items:
-      - description: Internal clock for connecting CRU and MIPI
-      - description: CRU Main clock
-      - description: CRU Register access clock
+    oneOf:
+      - items:
+          - description: Internal clock for connecting CRU and MIPI
+          - description: CRU Main clock
+          - description: CRU Register access clock
+      - items:
+          - description: CRU Main clock
+          - description: CRU Register access clock
=20
   clock-names:
-    items:
-      - const: system
-      - const: video
-      - const: apb
+    oneOf:
+      - items:
+          - const: system
+          - const: video
+          - const: apb
+      - items:
+          - const: video
+          - const: apb
=20
   power-domains:
     maxItems: 1
@@ -48,7 +58,7 @@ properties:
   resets:
     items:
       - description: CRU_PRESETN reset terminal
-      - description: CRU_CMN_RSTB reset terminal
+      - description: D-PHY reset (CRU_CMN_RSTB or CRU_n_S_RESETN)
=20
   reset-names:
     items:
@@ -101,6 +111,25 @@ required:
   - reset-names
   - ports
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-csi2
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+    else:
+      properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
+
 additionalProperties: false
=20
 examples:
--=20
2.43.0


