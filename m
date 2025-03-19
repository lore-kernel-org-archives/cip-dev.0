Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1A1C35FFF
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:00 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.40])
 by mx.groups.io with SMTP id smtpd.web10.4361.1742379415027532589
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:16:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Nu4iamF4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfLFwl38aiimJ312NmDZ6VOmKuwX+EJzTznYxEuWpXIgbFv+AjoCMx/8HoxChQZBnJdk80lzeuUiDMOSVuhu56eG0/k3uhLzMm48HU4J4NedrmXsy0cdhbmYJzrU8C9w4B2kwZ4t8WlPiVztgjp5Om6geAPNCRbVlpKWASfn0bExazNlA+YxExidMvyiBmi63+D4FlTKXrsZziycNMv7rgdhRSfSTvxVu8wE4ODcekOxsBkvrAqadrthrFPnzSjUb7ziG8IVEAKxKQ7HSGs1c9eQDb+UL0YV+I4DR8XOcZ1xpJVY73deTKQk6IcfV/fP854je/a9U9qEL6noTNqr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0MnnoCBH8djbOv8PTU+RgLklDgyy141P2hnnLyexBk=;
 b=xYn/O7zQsmAHnlmhqaaW60yT7KNHvth9bbMdixsyKdD1rbyC6x+P72cQiAgFHky1whuXvFzcmhvlLtjL5+LPqLhUwWPNFSyz11/a1h89PRxCddlM5Fg3MCbnIXTnF1euvXY3zHsYd4Wg5a3UhBmbDmSRrI9KxpCpvWW2we5uYwPASNlwttft3DN9wkXxEE2gt0ccFS1iYDEarU58Jxgw03gchPuFf01gTxY97jBCD4NaE3CsV2GBel5nJgg4xx3YbaHoLW0yjWYrE4F10gRDyV/ZCXz2czOI0Wt61CVXoWg/3My3zWVc0TLvxIJ7UxnTYQajIEwzlDjoQvrh5Td3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0MnnoCBH8djbOv8PTU+RgLklDgyy141P2hnnLyexBk=;
 b=Nu4iamF4FGRyEwrBXtSwXx1Z3nG4UCvX3LveEwux1tCGuGjemANBY+L+Vd2pbNXSMfB1NYSkpnjvQKRlk3IanwtzjhoDyjeQOCW/OdW2PwLVqc4DZSC+7tJ01Q3WfsgjDaX15p50ssQ+ilB1W178nfy3KyIv8D7iYHoMHJxCYjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:16:51 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:16:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 02/12] dt-bindings: serial: renesas,scif: Validate 'interrupts' and 'interrupt-names'
Date: Wed, 19 Mar 2025 11:16:19 +0100
Message-ID: <20250319101629.2407727-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB12680:EE_
X-MS-Office365-Filtering-Correlation-Id: c5489d7b-363e-40e0-526d-08dd66cf2a62
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ujhDwCPkgkVVh+F/i5IOtqgZxaLViyhWCjN1Em0gh9i3FhKJyglUzepu+iTc?=
 =?us-ascii?Q?zcwtCId81pvhjr4ggsHfjNOu3Ls8F+bqhMhgZjPxXiJWvbdekOT4vyNcA9Zn?=
 =?us-ascii?Q?YbQ5OOoBNZnwN+eAEqs/CxOcoIsrE/03AkLRoF7aNfGlrOicJTcr5ct12V7R?=
 =?us-ascii?Q?LEK9xtCIdzbXolB4HWuBm3mSgXylmZD/7D4AvdnEORACmfdAXCRCCftVqcev?=
 =?us-ascii?Q?X5HQBfu1J0nXaHplWGNzg+VVwoSclkVwJpdG0tUEuTMIlwoVYccDZg4pX8+i?=
 =?us-ascii?Q?vGRbFme1C08ri0mnAKm7DsYVB+0Gcm8uLOso4Ne28sg50+XyZhg+xSIpHTYw?=
 =?us-ascii?Q?/lErkAFymdlX3icCf5Kb+Moutd4vSBi1jg00uWR3Hi0WjFbe85sgzKNA9oua?=
 =?us-ascii?Q?eyYuolryPNTfSPcAFOFJHA4nkZBhrDSW6gWj18/g0zFZZKUCxWGwRHEzY6G6?=
 =?us-ascii?Q?d8Apzw9ox9ttTCbNyLgdLKKzXmVbxuaqxgmr7EV38Zed08i6Z26QEpKslm5Y?=
 =?us-ascii?Q?txFFzpD6qqADyUreU5odbWll6Sn1GUnicMNv1QWA6so8+cfRsuQlvWRNMLgu?=
 =?us-ascii?Q?X6suy4PXRxPSoeNRwP1Km0Om9r44BvItLg6wwxT86brsUvoUrNhPEe4n/NWV?=
 =?us-ascii?Q?VN0K6RHMmaxpMVTz3C+5XP1Bp9k/RkmSzscivgpQr2Apc7cjbI0Vf+UmNbdP?=
 =?us-ascii?Q?lsffG9FKfFKfSJAakYPnMx3TNt4d/5q3Qu4bUw3yEIFSbzy+0++NAvriGITZ?=
 =?us-ascii?Q?jNgVcNss0T3L+0SgEpAby5NjPDeCQFK9NeaUKQxCpLO/3TxEcATNSBlOwXGM?=
 =?us-ascii?Q?idkwRV9mRxZMM6A1DDGkExdHr9c6EsaT2fR7i8a1q+ParIULmfC0y5bXvldq?=
 =?us-ascii?Q?Xfn56MgiRTDNyERhUe1qwuw6rhxfwv3jLgTQiMXjTXTWRnbiXTLotCFJ7j9v?=
 =?us-ascii?Q?VQaWszpFTuJ9KcWqYjOLMlayNY4a30JKqa2z8yqpWGKSN+3UUHedTO16ZK99?=
 =?us-ascii?Q?nqeaqQqx5SVcwI2AjRiokGgFcS1MQ2Wmrv7qCunD4rydP+N3xZ+HPZQGUwKW?=
 =?us-ascii?Q?FObQbLkUUaCaF4iGTmQYZBB4+a9xD5LHPLLDhPdCtpEmJSdW/agD6BNzDUws?=
 =?us-ascii?Q?TnB7MM7d0isJqFCEb8ReBODL7aqXaReUYj3QVEzwORPcnMFlpmEzlzOXvgPe?=
 =?us-ascii?Q?GG82iHgkAjVSwyQlBGU+KPMi312nSZyBviTEDTHNVxVZjGHFTK8NTB3NQah3?=
 =?us-ascii?Q?NKxgOiiwZfN8BuFXoym5nfvuNhwqL7q0aJeGG+CQhNoKF3C3aGpD264qaodH?=
 =?us-ascii?Q?wdF44aQLX3Jyfqz8P1s7/A5CYvDfHHJwiZzdX3k2wuaSaZmfeDQqncqZMXsi?=
 =?us-ascii?Q?lkqggxFn+eqsqiWKqWqqP1whOWPHr+tYVdUbQFsTDA5u2WOyNpgq2HlEPVlU?=
 =?us-ascii?Q?0Dz9KFBaIdVHCi/q3NQMIJjKdzjBHrBL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MnFGcNhWrxiP4AvNz21/a0I1W1eIMup2BS/zBnEcoEbGbV5U7z8cgyVkv0s/?=
 =?us-ascii?Q?z34e1LY8PbL+fuA504OMngBut+E2lKhELxmK3nb+kW1ni0P0M5YBLwg0XaM2?=
 =?us-ascii?Q?2nCmNPl+KPeU5zCX2MvHKCOrGy4d72NvGm4H9BtfvXSqI/WJeXNId3BtMN6r?=
 =?us-ascii?Q?L9PwsPxGUa8OozYzXtM7eflc7QJ8d2ofTAGUha4MGmJVLHoGTUlztnrmVeaM?=
 =?us-ascii?Q?9v2zmPbiKHQ89SPlXHwLkGHZWYr9fWw3qncFx2DYmoz0gIk5wCP/Q0wn6v5P?=
 =?us-ascii?Q?WdmCp/lTPsOxKWLYZLQbeDQKuukV9VYCQGGCzXziAv0LCbbcEzQnrGMirCRH?=
 =?us-ascii?Q?8sPtMvx/A1anfqcGs2wGfwS/RNSsmwS8CiCgNwlQJ5Ud5i44ueNUl+S9Uod9?=
 =?us-ascii?Q?Jfhsr5U4XYxhhmOKhOFw/di0BLeo+andmEN16OYJGCHdEze96nYKy6TcEvO/?=
 =?us-ascii?Q?dQMV3Ek0wIK8qg1rH6g2CqyGF7TIByX7Ms7iGn+E6A9JkGSqlKRV3MR/IiPd?=
 =?us-ascii?Q?McXCSHyy+7TCKGEQu1DxA1dfPSYc+7EQOuTo3pwmAFkm2UrL1uWST/lRxGci?=
 =?us-ascii?Q?ZEOZ+rxJc7f8HgHG0gqYw0CUAgKSAlR0x77fqz07o67lyBRCTBBReEsVE4vv?=
 =?us-ascii?Q?6w+kZoWSKeNF3mnrKOqC5fadFYHv9aE4Hrr4U8jnX5T6GXh045bZ8ZGQLGop?=
 =?us-ascii?Q?fo8BCblppm2wYVC7MBikN6gWYmNnGEzN5Pb915CKyHLjgsjGohiC1vYynvpl?=
 =?us-ascii?Q?lKlCrRZO+hIQVz6Sv8U+Tj36/fssTfxI1EdkiotNRFFWgbw5r7hYE6MNt04D?=
 =?us-ascii?Q?1uzO8BOT4kTYpOI8i+sUi+v1kpbevmr/4yiJ2VvOHodbJgBXlnGTXycHW1Y8?=
 =?us-ascii?Q?bcrrA2mbYrpkAX1Z2ZcfgCyAiM46dxu5YjP8wmfxfKDA9LYUeL9xEkgy7MKo?=
 =?us-ascii?Q?eLZXHxJpUGL3w53DVd78iigitaEd2Ch3uePMtwOHpF/sAAAXuLOiG9VIrQTL?=
 =?us-ascii?Q?7RLstfi3V7dSM31ZH51l18+K3qNr/jUr4oPkOplxkUB21qgMX+9DcZ1mRG9g?=
 =?us-ascii?Q?z8Xu5s+KWZXtN0EeUHINov4kT8Fdrtu8l7X3X427LWlW1oTRR/BmL7aMczVI?=
 =?us-ascii?Q?KOFjyl/DOMQp1Eqc7NJnHZKycJqhDEnS/nG9z1fX/Po+llXepANJo6ToW6FL?=
 =?us-ascii?Q?vvdhOxtgKFQU5IOG8OnuFM5R7h1+rgIrvo0HgzgEepzUf+Ggy1eCbmAw781Y?=
 =?us-ascii?Q?cIoIY4KyqP3bXoW+3Tw3HVf4WrtkcUbUQhI00Ra3gscNcCknH848P7qJLCtb?=
 =?us-ascii?Q?y1SWW7qa9GAReHE+FvHhjBQltp1WRvEsbyaGvvnLLbBWLPSeAqmFfTNZqBpP?=
 =?us-ascii?Q?+/RwkvMiO6xVubrKB9z3fL75YiKMIUeL9YXzQX37xGrnHAh4Tbql+V3EgKhr?=
 =?us-ascii?Q?EomNcEsmJjO0EJ0zDi2WgNuMrpZtSJnTvymZqWcKRCp88QcVwJtAqs9WyW0m?=
 =?us-ascii?Q?Y3exZZzf+UQzcT3UUz6CVcN0+RFkVZJqMXl633+cFH0d377UQFcoO6qMlKsE?=
 =?us-ascii?Q?CBLggEdgb1dYxNyz20eC727Uy7E1UwPMm+08Kt61DVsZDUO/VuLXZbjzfxrr?=
 =?us-ascii?Q?E3c0r6ZRnSUqsxG0UZHhmAQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5489d7b-363e-40e0-526d-08dd66cf2a62
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:16:51.3063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG0F4EMVCmMW9kCCg+Wd4iow6nkhWI76cDk1NeIg7pk3jE61+8ShTC21VP8z3i5I4arKbuDo3Y4igyNWuRuHulg3rjGiRmsLLtyEWP6Vb6Qm47XBmcQaxeqt2z5zbEtP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18263

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d057a1e3e475c6d9e24ce2e79c3f3daf367e33d8 upstream.

This commit adds support to validate the 'interrupts' and 'interrupt-names'
properties for every supported SoC. This ensures proper handling and
configuration of interrupt-related properties across supported platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20240604170513.522631-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

 .../bindings/serial/renesas,scif.yaml         | 73 ++++++++++++++-----
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/D=
ocumentation/devicetree/bindings/serial/renesas,scif.yaml
index 77587b0c8642..20132a3202fd 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -85,11 +85,6 @@ properties:
     oneOf:
       - items:
           - description: A combined interrupt
-      - items:
-          - description: Error interrupt
-          - description: Receive buffer full interrupt
-          - description: Transmit buffer empty interrupt
-          - description: Break interrupt
       - items:
           - description: Error interrupt
           - description: Receive buffer full interrupt
@@ -97,21 +92,17 @@ properties:
           - description: Break interrupt
           - description: Data Ready interrupt
           - description: Transmit End interrupt
+        minItems: 4
=20
   interrupt-names:
-    oneOf:
-      - items:
-          - const: eri
-          - const: rxi
-          - const: txi
-          - const: bri
-      - items:
-          - const: eri
-          - const: rxi
-          - const: txi
-          - const: bri
-          - const: dri
-          - const: tei
+    minItems: 4
+    items:
+      - const: eri
+      - const: rxi
+      - const: txi
+      - const: bri
+      - const: dri
+      - const: tei
=20
   clocks:
     minItems: 1
@@ -172,6 +163,52 @@ allOf:
       required:
         - resets
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen1-scif
+              - renesas,rcar-gen2-scif
+              - renesas,rcar-gen3-scif
+              - renesas,rcar-gen4-scif
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+
+        interrupt-names: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,scif-r7s72100
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+
+        interrupt-names:
+          maxItems: 4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,scif-r7s9210
+              - renesas,scif-r9a07g044
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+
+        interrupt-names:
+          minItems: 6
+
 unevaluatedProperties: false
=20
 examples:
--=20
2.43.0


