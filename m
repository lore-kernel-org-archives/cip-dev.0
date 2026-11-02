Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11642.1793624002229672323
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 04:53:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Z1gHeeq7;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.46, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tm5oYvVv7V5HJIbv7yWe8qlyuoI1kajbOJBfIPR6Pa0bLj0Qo4wrEVgbM//DOtClnVOM32emt7rZvidSrfY/m+XF0JcBasdrq/sOcdK8oEwCyar/XmAic7bA5q89wb8TbOgGzRCw69P0UUNXBllhLJh2BAQAERb6BFumXy3fbQQ1vlMKkI6G0her1hREGJgp4QbCL41QWdpmwEpGAazsjUw6j0+mAznEwgVuudkArGYdcdevXv9gv0dVUnAzr9yyQqj0KB/fovFjX/Fgzx6e0YuPRH/dBHDrJFCos49WSAicm0HXriUrxOhEGHvKvlQDjzTreqx4WbqmK26uJZqCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPCPHMjhYKnCinlsYyuSiREkwPV0VXa7ZhnBBoo+juA=;
 b=Sw1opU1IOoqPswNyymqfJqzOk9uavj3HDgEux4e52yHRJ9P5o/m6YLOf2SaQAW9CQX96oBIBDEpwUAhifbqP9Xzrxu3Jw5W52L46tCOy6hPfzFtojC5Wfg/BBM3035j0Bvz2IvLd/PUXesMMqgotnMUFQpgeDF6Kit+u5v5X8flBXFrPWu8l7RJcN7qXwkWY5y5kGzsfBFrtBS6bAWwh1RiE4T/EhjUldfhxovL+JDjHAOUwgRjtFQKVPyBHkRq5ooOmDHicm0BI4JKOxxGa+5CZQ//T3kJwjvHQ9ezyFXXGcdBgY1M3+R1yyko6nc3J0CSI85IgCFAQhJI4715nLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPCPHMjhYKnCinlsYyuSiREkwPV0VXa7ZhnBBoo+juA=;
 b=Z1gHeeq7dPt54QDXAYpRz7BSngVCycXRKU1Ti0Xvgx3+HNvGIBmQJy0qn9KX8eLoVE0cWzVdrai1HaDNmw6nnVEHqgWH0rqz5WJqsR6LtOIhZXT2X/f4r03tLtAUaS1y/vA5hjCFfxXbOae/98AQQlLNOG550E+kjOxcifZo/nc=
Received: from TY4PR01CA0109.jpnprd01.prod.outlook.com (2603:1096:405:378::10)
 by TYCPR01MB10293.jpnprd01.prod.outlook.com (2603:1096:400:1e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:53:14 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:378:cafe::e) by TY4PR01CA0109.outlook.office365.com
 (2603:1096:405:378::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:53:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 12:53:14 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id E79B63000230;
	Mon,  2 Nov 2026 21:53:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 1/7] dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
Date: Mon,  2 Nov 2026 12:53:03 +0000
Message-ID: <20261102125309.7743-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|TYCPR01MB10293:EE_
X-MS-Office365-Filtering-Correlation-Id: a990eea3-31dc-41f3-1974-08df38e04242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: DFzWrx/42HYQJ6HbdGoLHTIPEOBPz40fSH0VJFcr0oYtpBqQJbtxkNpdlx3lydWWHGd2pTUbBQ+lEyVW7R3rV4OC7dNQBjhFXF1+OC9dbKNE5LpMpien0Y36VdgMidBC8z8rCwp//JeR2CS67LDxjB6oKyLd8TPWp+Nmj7l57627BI1EfWgbZYnS2bx6H1GBAn51IR79K3cHQteijfofcyjnrjTkrdFlMO/09/7hSoTyffpo37QpUKX6pmUjHfRJToPcRlBzhTSsQbDfqFNXwQcRN65fvvyTSWQAOWMLLHlNyITrYiDUpWICOiqRu4PF2kYB3MK9Bhbj9FVBlwV44gUEU0sPUC3KmRkviOl4lo6KNsJcJlDuGudpDOctHtLbj3J70IXsPE5+/kTV63d8kpsAXWqKN4abt4SMcoheC6zUGW08UDRe0a+8F/v9Wc7j/aL90DDG5/xhp8q3QWn7x45xNiYP1MpkZkiyu1F1zshohyDAPvfEasT0hP210iqBv7fCNuDWtWwW52ieueAeYGbN+joVVdMuK7eJ5klLqOmvYdR01ylpIP0aW12B04oaVI2mbQfj7P1duqoVVjY+5acHe4cgifS+/Hr6ELZJCiB3RT55+C2AQWAd7O/+OQPFBODInU8VFLvfuu9z7oJL5hHlY9tmZDxg8YUtqBcFzkY=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TdoSMUJQeRTGLY3cvGFfXPPDXQ7SZWiI3P/wMhlKH5ThYG7PVDBYlHzTg6RJqUfHcYOsgq0QegDYkKpda5FbrQb8KQnGu64vzo30steD7OOmLRRRhpxmt6HvVSeaimIAxVUvTEO41HyYMx+ptYkNoanaLaBoZq+aSJfpzMRmLqg0kw3WCObslwOjzr1R+VZyZ5cWnAXIA5cKCjdGHWO5bAgM52z9LrhOhEZ63nG+ohlWm12Z7slqRjIMO7sIk79FsTVzAw8A5BVFol0R84TnXHa57xdwl+cEkkDFrn4wst+3KlJoRdZCxJbYJvDeafo/G/VVtX04VGKuYx+PGzn1PZ6VyvMKjHsZEdM2oru6hQOlD9DqP6p9oD1cwAiss8le809Y0phmf8hbhrPvoo2zsB1N5ulX9ZzprJ11NXqjX9FIR4ZgcXPqngB2ZJx9ENBP
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:53:14.4854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a990eea3-31dc-41f3-1974-08df38e04242
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10293
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 12:53:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24605
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

