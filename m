Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11799.1793624542308511376
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 05:02:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=wXxiLB8u;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.1, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txMfXkSo0VMSsYQ73+yBukU+jnpGgEK1sMi05Z8ztCCsIDkce3n2w/H+oT97ijboAkZgJdDn7OTNNS51sWtr0McA2EkSwtP/hM3aA9xjzFMEzKARCJkSmbz4xVw3sRM6hiM2EXrSPTQv0TuOpnmoAvC15LYIsEk4btP5lqUkVsS8mTkLhxkyJP7GxfHBzD8GAWsYXEUAWnR5ROqR3TdqT59TjXbqUeuUjoUt1goaj7ShGMh15jLC2pzcL8pe2TGrGNCTKVipJAnGmjJwlZttJtXhPtr6HS/OfPg2EJZiZZEXWw8iIDTAT93enD+QCEvPfvIqlzueI/9ABTDEbmcP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPCPHMjhYKnCinlsYyuSiREkwPV0VXa7ZhnBBoo+juA=;
 b=QdoA8stEV8XHnINQFfNXo99PxytOAuJB4uVQmfSCxk6if/Mi+WGYkDt7JtglA2tMI2ZqP6N9X/bx9ME/h/W6vPeSVsS9k2AwFWwyWLEM5KMIWxbNZCztE+21n9OL/c3UxHMBcAoqSsvCbepyD1OMp7NPEJck06yhIJE2bOEoGJuGLYSmxNO8kuHaMBPaBtXGavOx3x7RDiVfYIHcwy2rOGEKEmQSvuSlhSgAa8JB1UwQv6pKu4Sdy40WT7SK0TKi0PLNZ2rignaqqI+JjNHIhJ/gfDfx1jtq15BASsNx75JYuko6ie+kTikwvY1xIl6cyY/76iQUxTpf1JADyxo5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPCPHMjhYKnCinlsYyuSiREkwPV0VXa7ZhnBBoo+juA=;
 b=wXxiLB8umVuwp6O+IkH0rmj5kOIWv+85noe7QyuQ/3Phf8D0hdlAMsAEngumiAZ+KTmc05SGQes1OixQJeRzU8/ODsJvP7zKtz3BYMp0Xtys9MbygDWL6+oKkVQoNgpe+bGb+uc7k6qy4rZtV+hm8IdV7l1O5hnyqcouRMJlnbg=
Received: from OS7PR01CA0033.jpnprd01.prod.outlook.com (2603:1096:604:257::18)
 by TYRPR01MB12489.jpnprd01.prod.outlook.com (2603:1096:405:1b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:02:17 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:257:cafe::61) by OS7PR01CA0033.outlook.office365.com
 (2603:1096:604:257::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 13:02:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 13:02:17 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id DBDFE3001283;
	Mon,  2 Nov 2026 22:02:15 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/7] dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
Date: Mon,  2 Nov 2026 13:02:06 +0000
Message-ID: <20261102130212.8115-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYRPR01MB12489:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a0b4e7-f20d-4322-8c81-08df38e185e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|3023799007|13003099007|56012099006|11063799006|261021121427099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: V38td002+ZPpdR1wwrhzSnlJy9lxF7ExJWkLbdmpXk0UGlJ6MH7/6eJWXv0lUSV+5wgmG7QaX8SSBMP3Yp7yp9DtJsIXxJM6MIXcUA//hZF74PF1OwEG7YxTafsZVJC+mz3ag4dzFi3HYakYWu80YSCoPCFdPq+jl6kbRf9jqPZwVibtP3bTOn/Nhruy7ymAwzyIfAiVt6DTdfhSlo1l3DEqNaxYUH0yfR6/GEc0UXXmUSdwnP+ZQIExbEk9kmbUrX918ZdWPu41T+vRmloZz4tiNPEfNmBerVjBOCadtJHXen2OGcd2eWwVb+jC/KUN7Ckq9WegdM+hxxmwU9N5F6A+5xXLtrFTQduS1/TsbEfxwFcWt5HOnEbTz14kVxGADlH1nuA/xWAHY7FFAQW06KDfIQrOye8ufketWxrxGU/POqvtaz66hMiGPJ+V0EpbXPcVrjxgnQQHjiWG5KDObSFkHtgv4ybqI7dNe6wBovzZABY3d9liilR5Ci0MeOp+ROCUtyJa1O109cEEmGT9+Z6gAA+Xz/WqPe9R5rT4lDqZ/6ViGlfpdH/cTMOwUab6Dwrjha4XysevKwqi0OuiAyC9TlY6mzchCMGS9T0m2a20yIYXDS0TiK16m70yhqxfpCRpJLVEfiWVhHwPhqo6nuxa/2U8t+hfmt+mMu7KYKA=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(13003099007)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7eRPla6XNsWJ5MNfpXd8A4HeJ+0ZBNGPA/IY9WCdJJf4bRA/gH670hnpBmTIZ/rkmKjUit3esT2hCbIPHxO1OQH+HZR1E0A53twsWQIboOgqXDXWH2sBy1pUH0PsqSw982rHISoKRO5xYAAHSjGt7y/WRjMoJVnKKRKKl60r2iH6M/YWo3mCwpdn8m3dqihyQARPiM/e3SKr41mdr43AiUo6KLsbLffmycG02gR65LalsLnHXshacPIqTylB4SYChU0/qIu+ZMjiqDe3mQLw8fCqB0QKaqPOp/qTNvEHvX4o2+Ps90LnouArZ3uhf1GZDBbKZLvcdHdY4YZU7zRUesC25Lq7BcOCge3X98axbjdtbqssOlB3i2Wf0bNpYwbxYL+T8DOE9S3NkNtpg1tNyWD7ap1wvYS3HgEKaq8RETYvq+OK29lYy3fLSwjbtnyA
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:02:17.4133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a0b4e7-f20d-4322-8c81-08df38e185e0
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12489
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 13:02:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24611
Content-Type: text/plain; charset="utf-8"

commit a61588a75d923c5935180e746bfe5f32d7467c5f upstream.

Add support for the PCIe controller found on the Renesas RZ/V2H(P) SoC.

The RZ/V2H(P) controller is similar to the RZ/G3E variant but includes
additional registers and configuration bits for PCIe lane control. It
supports multilink operation configured as either a single x4 link
or two independent x2 link controllers.

Unlike earlier SoCs supported by this driver which only feature a single
PCIe controller, the RZ/V2H(P) SoC implements two controllers. Both
instances rely on the system controller (SYSC) for configuration, but
the required registers reside at different offsets for each controller.

To correctly identify the controller instance and map the corresponding
system controller registers, update the "renesas,sysc" property to a
phandle-array. For the RZ/V2H(P) SoC, require an accompanying cell to
specify the controller instance index (0 or 1). For all earlier SoCs,
strictly restrict the property to a single phandle with zero argument
cells.

Additionally, make the "num-lanes" property mandatory for this SoC and
restrict its values according to the hardware capabilities.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260629220932.861445-2-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 34 +++++++++++++++++--
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.y=
aml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index 90086909e9210..09d78bd1a5770 100644
--- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -14,7 +14,7 @@ description: |
   with PCIe Base Specification 4.0 and supports different link speeds
   depending on the SoC variant:
     - Gen2 (5 GT/s): RZ/G3S
-    - Gen3 (8 GT/s): RZ/G3E, RZ/V2N
+    - Gen3 (8 GT/s): RZ/G3E, RZ/V2H(P), RZ/V2N
=20
 properties:
   compatible:
@@ -22,6 +22,7 @@ properties:
       - enum:
           - renesas,r9a08g045-pcie # RZ/G3S
           - renesas,r9a09g047-pcie # RZ/G3E
+          - renesas,r9a09g057-pcie # RZ/V2H(P)
       - items:
           - const: renesas,r9a09g056-pcie # RZ/V2N
           - const: renesas,r9a09g047-pcie
@@ -139,7 +140,13 @@ properties:
       - clkl1pm clock request state
       - power off information in L2 state
       - errors (fatal, non-fatal, correctable)
-    $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to system controller
+          - description: PCIe controller index
+            enum: [0, 1]
+        minItems: 1
=20
 patternProperties:
   "^pcie@0,[0-0]$":
@@ -220,7 +227,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a09g047-pcie
+            enum:
+              - renesas,r9a09g047-pcie
+              - renesas,r9a09g057-pcie
     then:
       properties:
         interrupts:
@@ -235,6 +244,25 @@ allOf:
           maxItems: 1
         reset-names:
           maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-pcie
+    then:
+      properties:
+        num-lanes:
+          enum: [2, 4]
+        renesas,sysc:
+          items:
+            - minItems: 2
+      required:
+        - num-lanes
+    else:
+      properties:
+        renesas,sysc:
+          items:
+            - maxItems: 1
=20
 unevaluatedProperties: false
=20
--=20
2.43.0

