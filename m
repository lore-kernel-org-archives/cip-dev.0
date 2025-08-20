Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA42ECA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:04:53 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.37])
 by mx.groups.io with SMTP id smtpd.web11.863.1755705887237728655
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:04:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=h0dOSMaI;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6l43WPLCS4UDvU8Inh89OHokmmSxGeYnnNUsBcPRUhh2+T8i4XtOHO7kis8HrFpWVoIK5i4gioeeuCD+GVzCmwzJc5aZO9JTt5N0yvGn4o9KEtWT1ogGV3b0SWskLYuWLNdqJMscssuUKOYlXyxdsLMb0B9nhElKeXn0Rl/C/0SD+V9r00VplwFWZ4sZG8iONlj0D0MpS+PaGFvDsME3jUB3fe95DTfDUTUSw7Q8xpkUESSoXLMHHQfURUbMeempZQk0SpIeTPPzhI2Qit7yOyBGZ+BdGTmZzOWBx1+KIyUP8l+70qWLDcvSkm3XZ3gJysX4IJqwXL5Fcd9TgStDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO0XoDH6sI7amNBbxvjXv3XS334NB74y4uK14I7SmAU=;
 b=EqimUNxHpJGhxuIYzsF3R29jNIt1fnXKhz4oelsFw21zEQh5DB90sa9u0IsHucVPj0wdDbKH742N+rWyjL3LG/2NQ9IfFWNYWX3kqT8qVBByaQZXnSe3u1HmdAYlaS8FM68OWrR1Og3JTE5T5akfQYhLiVJYdsnHvUWARlhX+MErn+jN1vOs8xLTcJJEhyCaQj0YbqNbYm4zcz/pfX7DGK6dvUQuT990gM95/0wlzccMlbLRimZrPAvH4liM8w2R81LZETonVFo7OhyiIcok/oKShPjy8G4RuFj2c36OZYFNcX4i1oXJIiOm0iZN1cXiQXhmQa+c4XkP/g4g3MZ64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO0XoDH6sI7amNBbxvjXv3XS334NB74y4uK14I7SmAU=;
 b=h0dOSMaI4gwIQDBXpSPEYt6trSymgU5dQRaDo4TBy0WJjwXFXUTEccuqp8qvR3FEc5DGFO10odqH5XU+pWB0+8utZWqNRL3FYFZxbMrlad63ScCcrugFkOeICY5BxetHZnsDNAA096n4vycRg/LwbNY0BlHwZ00AEWdV4U8OlMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:04:43 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:04:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/55] media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/V2H(P) SoC
Date: Wed, 20 Aug 2025 18:03:17 +0200
Message-ID: <20250820160413.801341-2-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9833ca-8428-402f-9789-08dde00346c5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FHp+o25DtqXZ1IGP46/KL3S0EdeMpAtdemLjEiN0TnP0ne4aQy4AzduHMygt?=
 =?us-ascii?Q?K6zr9K0Dfq9pn6fwfWGlO/Ck1a0At0d5WU7Tnj8+SG7Di5/DwlP3m+8Tj68R?=
 =?us-ascii?Q?QCewblByvwFdx8cMZCh2b6ux/RTKhbID389ueZZEHSNdXMIUjMycEspJe3zp?=
 =?us-ascii?Q?6X6A+Kz5f0q/XE3+9yoBXLNl6duN8PxfriSeDe7Q0TFILBQeicd8TmzoCypr?=
 =?us-ascii?Q?GYc+wp984HSZQe1kP0E9vaktZVc/TO2b458kjrT5doG6/2J3XyMRMExUIaqy?=
 =?us-ascii?Q?ltx1X62Jo4bewYnJT1kJX2hf0F1eGA3R/lOZnqFgNBVK148g2LJSu7ObJSu7?=
 =?us-ascii?Q?Z2A4NgNk2rUz5XgTn2rX1EBkLFCnE3QH/sgYQw44k4K+x8EWicvELMeZkZoZ?=
 =?us-ascii?Q?pRb+5bZ80++fIQlYZ4pCGdHBj2c6YpWMWFdo1Jf4dWppVwQjS6MeUDl97+j/?=
 =?us-ascii?Q?PURETk2X46LPFvhdmXP9mryPOT6imJnqmNqlJwgWkQK2MVVqxWKktK0Sswzy?=
 =?us-ascii?Q?Sc710Vz53qal1c9fWgTwlF+l4QQ/s0WhUpP92TfNbQ1jqUJa8+LdGg/qouKo?=
 =?us-ascii?Q?1NwoxasE2YPYgCVrYjsPufbu4F782SKf0g3MSxtYp5sTIuxwg0ee3eRg4PQs?=
 =?us-ascii?Q?T4tN+eAaW/ftJ3dqwd4LAl9TQoi7RN1/Zq10rO7bCAZamjWAtrKXGsmilmoY?=
 =?us-ascii?Q?hkmus7YSRu/L3HK9LGN9sSfqAwlS0QU7nG575+bkzVmD88pboiSOjThPG4u1?=
 =?us-ascii?Q?RlITZ2i9qOpIHosIA/hosMFdwzHmShSo5f0CRDMULM3WvsdZJHTRoGG2U/YH?=
 =?us-ascii?Q?fkbtpeaFt4YIleDveJ6Gthl1H2l3ORusyhc8Ix7mJAz5A9FYQ9HUWFPPXUH0?=
 =?us-ascii?Q?HJduhN9bQQCNJR2m78+vJCbig8mdI0muOUAEUFwynyEs7oIqmfkQkHai7NgE?=
 =?us-ascii?Q?wU3RqFiAaxST0ROj1lOcgqz9J7JZiSBFcnVb2X+KqNUU69m9kZJQ4Z/F7Yer?=
 =?us-ascii?Q?TP1IqtfFB+GPsqzW1A2iBl3TWO7pu6v425UNqTnyy/WmIvxvGw9hPSjBwjiT?=
 =?us-ascii?Q?P5gOP3SZCF/GGeb2X89eR7NjOSZbWfnCK1YXmnvmg0twFurJSOnW/v+VtsTK?=
 =?us-ascii?Q?a9yzYIgdpxBh9Iop7J7Kq74GcuFTKzOXRhcWrMoNNKHwtkhI0x/nkFojSdjX?=
 =?us-ascii?Q?5DZ/IbH4QRDsmwVmBqW+gITe8Y0Nb4SEf1cWP28y33wF+TyyNxVJKRIq/en5?=
 =?us-ascii?Q?iiiGouaYGvnxD4KmodMATvm2tB6/zcEJdDLyBrBHtH7V6xMa0xdg2+0XSqfi?=
 =?us-ascii?Q?tSi1jtAjjwnV95LasbqkMl1rqbina8lJ9IPo6b14r9gKWfl9Zpb8pvp6pDpW?=
 =?us-ascii?Q?rlSaXy7Q3Zr9tyaCREWg0OZe1tr1rEybDpUM1vat47g6dDemHrw2FHxqOMxO?=
 =?us-ascii?Q?zqOrqlvb9UAwkubEKjwdzSzIgX0pBzG1S9SB6aN1q5jWEwffbeZSY4W2Vd97?=
 =?us-ascii?Q?rbAy+cmfU3XIa8c=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2iQh49lKT3rmSXFPXQqWyBWkSnIBSbJ5vmI1n5JIIhl7X0XSbJrCN1/uTC/e?=
 =?us-ascii?Q?MA9JrKzmj68k52Fn6zKT/+3m+NkHBGqlTP4epYmamXJ1G3ObpxXXE16iwTP1?=
 =?us-ascii?Q?YHbAeff7SxmtPD9KMuyjDypEV8faW0ZIQmw+VxSLB6zcnafqWt7O4XSqToLr?=
 =?us-ascii?Q?ioUcj8dYfVdmHo/6RFssFq5It7USAmAW9HhfhnOVUY03k4Esw82tLi+2MI40?=
 =?us-ascii?Q?CKojdU+zaW9/bpJamVZ20uyhhm+OCe21DqatIGg5czDfvm/hy/Zwn5h/U+8l?=
 =?us-ascii?Q?1d3dFBNi4wyMkwXSIo0p5a5GJlrbEVDxvvdNoTHdcTkUhnWm95awqqbsIhyG?=
 =?us-ascii?Q?21OwwOi7+r3XX+nIgU2H7VPdIn2nJxXrPyRstNCTwk45gDa3RxPKO0GDaV/J?=
 =?us-ascii?Q?zVyElYe36nDKJZY1os+lkaO2X2UpD2UAdhXDxE3hGGAdc9X7nz5yG8ZHPDkH?=
 =?us-ascii?Q?uuKFf9rUjxpF2Wj0yhZGWcGd13OgKh/ehwTIrVYIDKTeGuNCs21eCkSPGJNC?=
 =?us-ascii?Q?Tf1Kiz0/IA/+Bd3/aYwyDuALlkPQC/PMh7uEYBENdZjT0wuO4gL/YTG1TbgY?=
 =?us-ascii?Q?vmmoccHnUJnl1BJv93CUM89P9CWWxe2yLAQBKEU2gsZb+r2QNif0rMtG9Zol?=
 =?us-ascii?Q?FtDYT290mY5iGF/NjoKAirwLRHh417ylr+9tLv2EgSNufY9rtks48YcPPzeb?=
 =?us-ascii?Q?+RXh5ThZHYDQf+aFE34ypTnd8j9QRXGGdwYR3aQ62KsxP8O7S5l+X51kaYu5?=
 =?us-ascii?Q?49VJKsdYcBmhtE9P34OB46XheSefi1RNujVwOU/ER2xWC0VQHrIzz3PsPS6r?=
 =?us-ascii?Q?xTTHVo8X7lpQwUowaxkhc8Fcg1+XhM49kgMRWYRPyMELMtKgbetOAC3Scwsr?=
 =?us-ascii?Q?4LpBd3MBQkn62NCN/GpQQ1yE9t/qiWbXQWGWMFCV07L3sbGwEP9GkdNuweKO?=
 =?us-ascii?Q?LgOsOoLPiC5TGSdy2MmcsLucen0kj0SShtK3dFq0KQ6EGU4q9Kx8Naj3Iig4?=
 =?us-ascii?Q?q2CRK0uR9GLl7Pi2Ae7twNt/wnEYdvrtdLDD7asUUJn3pjzRLfDhCeqpF2fn?=
 =?us-ascii?Q?Fgv7nOthtUyC5uqG6vApuDCvlIFOJfxYeT8BJG7EcupL9PidDJylrlLPHaiV?=
 =?us-ascii?Q?192oaqNgqAMnUYddy9BBnlt5bYyE+W/pSQbl6hsvtoXPZ0zRPpT2HY+k4qmd?=
 =?us-ascii?Q?cZWEA0AxIBlG3JjOId6n9Q7mEqEYz7SqmUGFa+An2NeELGEyYcN9y9N6uBGs?=
 =?us-ascii?Q?VVVfiFeHtoSq9mQSAPbyPbUry/frI73W/qKa9Wvrcx1IE3wFgeC8clWkFnou?=
 =?us-ascii?Q?AFoeHeNYP+l3k935tNiT6ODYlPuVCMIlZKySu5/evoP3xtNogYxFUmb/3hO7?=
 =?us-ascii?Q?ETlU7+/qKlZVz1XeqwCpdEUPsyLWsrgAn0Cx4otLLtlbOaGdhAs0BJSBlhKH?=
 =?us-ascii?Q?vTg5HpewL86dDjWCOQSg1UUkb6oFslscJ04SwUV0OuT9dh58Q6XJG0pICIG7?=
 =?us-ascii?Q?7CL5Njbc2jvZAT13N9xsFPTzYqyMNNlHin6y5EGTbsz3w6B9jCxpRt/ZJejQ?=
 =?us-ascii?Q?NNlaDAAlF095S4zOd5BmhQ2/nWkB0ikk9E+YxnDiMjG5I5jF3aRss7GXunMA?=
 =?us-ascii?Q?QivQ4pElR3Ud8nkM2tM915s=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9833ca-8428-402f-9789-08dde00346c5
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:04:43.6369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93ulfKPNjTpQMD/uVOAh4e/nTBeSklCRDax50OcRCfHA3kARUYka2cD7otyVWTGWEULniwMvDMrdZ5AljYpL8OITMSr38sSfggOvUwBKmhSbuEOqHZ9AGciEYfYC42dR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:04:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19826

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


