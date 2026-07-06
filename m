Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE352C43602
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 18:23:43 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.156743.1783362222313392636
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 11:23:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=q4feaibR;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.69, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZgesjRnMkhMLMsJ8mYPCMNiT11unLmVtFuyOQE0XDhdvqCXubEOQULSkAL1LnZ4n0/U9HGeN9UD3dr0FBp+1A2v+kUGkMHFL29ahFt6V/2KZVQEunIJF2GyWJ/PNHrAYAxeHxYMQxBb/ZHVkzXVH9nvrYD+S4fl8kUE4v3VO1v7eTv7Cm0oFIBaaIG/dFrWYSN531yA9vvxIwIBdnN0xBteoKsW2F9UMw9KWiw3/cwCxL2sAuXvghE3a5OhyDAzLrsBrUAhBuZf4iXp2CYXuwtFwfIExY4Y56WA9Gg61oBD436nDoKjy9RkiC4xn5OTOA6qqk77DAfGSSWEi0T2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfRHSRbPXVGyIxfVl5fBhfPpkxzZJOTToYtzsIcBF6E=;
 b=HACh8QO/5TUi9aUbZ1iILWXGqsa7JkhSQ+y5t/iIN7JbVoJNNlq/l5vE5KTIguPrQj0pZ6BFSF2xIso2YPRAYho/Tk5lWHjIAKRZBmaa3A8CCTj1K6kZKAGB5BALBPa4/t7/4k3e1SPGNXIo1qdOYmD1GZyAR8EpfHgTB7A9tCeFiV6GyXhjG0Jnk8lVb8Bk8ApwAXaHR4MUVOBiEhlgjnTBfAIrQeQGBu4Jtq1Vita3ZqnSo+vdon+9NoIAuXrqtsQ12JZX/PM1nSyouJQYplb7dCk6nKzU/VnaeZo1SW29g0hTRPXUGXrwM5mtjogc7ug1k2nV+x0WAJ5x8HZRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfRHSRbPXVGyIxfVl5fBhfPpkxzZJOTToYtzsIcBF6E=;
 b=q4feaibRGvTVf7v2Q/SuLKUdY6Pan6g4qsPxLwT1RGuhR2ESTSmfgWfkwvmCsf/r22lv9/SrkHWGuXnusMCzLhBP9DPfT1kR2PTWVEQxpax0SPli/7vfcykodWS8neyc2dYKz3G6nIQWjEf0iveMw4oWm0nm8EW9absX9QA2L5w=
Received: from TYCP286CA0369.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:79::13)
 by OSCPR01MB14854.jpnprd01.prod.outlook.com (2603:1096:604:3b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Mon, 6 Jul
 2026 18:23:37 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79:cafe::71) by TYCP286CA0369.outlook.office365.com
 (2603:1096:405:79::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 18:23:36 +0000
Received: from Ubuntu-22.. (ed-eng-lt-ism.diasemi.com [10.24.0.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 59F6F3000152;
	Tue,  7 Jul 2026 03:23:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/8] dt-bindings: memory: renesas,rzg3e-xspi: Add RZ/T2H and RZ/N2H support
Date: Mon,  6 Jul 2026 19:23:23 +0100
Message-ID: <20260706182328.5237-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|OSCPR01MB14854:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d8e2b4b-89b5-4320-6733-08dedb8bb210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|22082099003|6133799003|3023799007|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	0W43Fp8ky7rDR76WTC33fT0wYryDvnQ0femBxH1oqAW4LPYm+XkIKbAbMlJHswZoUY5Z9ftbVEQdd2Gzawe8SCJTmWOh2We9B56y2rWeRyB54F+WQLUC/Cn5z7zXYlsiI75UR+6LIDZljHlLJsPSMJFbAfKAAEfus8H2IE7cDsbrebVINEnhoFw1z7qiFSuWeGfh7L12zNxB7A67ViHrKj5HkCCQHVXooL8iOy9wbu+6JS72iPwVkKjhcFGk/gKFu4XmUJNHRiPsRkaeEW1hixz47LWMiff7JiffsLG9JUkw9tnzttXUYrF4pECoD5fC5BdxbWltADbf3QRnAUBvBQ29wCyV0CTPzmsrIUrtRlqsqo6J1oBtP9IEOYi1SlgHpgJ9peQ4UduImrPFjhkOLN7zzXx/MaaeONGjYRetIMMmgNYkjHfNapROr2/3EPGnHEdhMbJ4RX9jXKdcugC+oB3fP0pADp0OT2ZytHLlT7iOI3prYkD+HVahDJsciH7nlxI/PE4RVuCluxY2/ZBVoWu3/X4LyQCiHJglWuBg+G/+kzzI37s7BVsjLNsHBfKiGlbUzkioL4LoXKRbVXvLz2fLqmTwNOlwAKjzWDlNpYo8h+aIDB5vRSo+nnL90v33VQUaDJ9U6Vvj/J/Wi3d1DBbFix95/e1C91OanuTHcMY=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7g0FrQPT8P1CXuMFu8Z67uELCtaiSu8GzeKOD68X/0OnxvM98+8CyCIUOaqKx3Cq2F/CT4o9riEL+X7i36puYosIkoFcT9QRBS0LVXx9/RR153Z0NaiOVHez8w4QZEJv3KhrSE6ZuziMWynmBKcGCdU55UshjqMCr7Qbgx4RZ5Ev/Vy8iTdNX4tXwbskIV31ESUtyG3ePYTL6b/70SdRL9tlS39vXBz3aq0thDciuNGyi1zT5I+3nemKLux8v0knuz9TMLcNSK4IbA2iqx86kYXDA+NckQSCeuICNQKCsSFQi8ezHuRJS+OBS7QUROnmdw71SmNSPF2/4NsngGOyuNnpBYlyNxWdv6kMKyCQYsiIsky2FYaRlvSeCghe/OH3TPXfR8s0lr0QNcjRcJMB8lqtawlViuH1zUUSH4Koboid6tE4TKi0NMN2ogTpaLL+
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:23:36.7030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e2b4b-89b5-4320-6733-08dedb8bb210
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14854
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 18:23:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23464

commit a6954060adc9d956a99f909f46bf9fb0348c4fa2 upstream.

Document xSPI controller found on the Renesas RZ/T2H and RZ/N2H SoCs.
The xSPI IP on these SoCs is identical to that found on the RZ/G3E SoC.

The RZ/G3E HW manual (Rev.1.15) references bridge channel 1 and its
bits, however the hardware actually supports only a single bridge
channel (channel 0), matching the RZ/T2H design. The references to
channel 1 and its configuration bits will be corrected in a future
revision of the HW manual.

Update clock/reset constraints to handle the SoC differences.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260515115202.1515577-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../renesas,rzg3e-xspi.yaml                   | 60 +++++++++++++++----
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,r=
zg3e-xspi.yaml b/Documentation/devicetree/bindings/memory-controllers/renes=
as,rzg3e-xspi.yaml
index 7a84f5bb7284..cdeca4c795f3 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xs=
pi.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xs=
pi.yaml
@@ -30,6 +30,8 @@ properties:
           - enum:
               - renesas,r9a09g056-xspi  # RZ/V2N
               - renesas,r9a09g057-xspi  # RZ/V2H(P)
+              - renesas,r9a09g077-xspi  # RZ/T2H
+              - renesas,r9a09g087-xspi  # RZ/N2H
           - const: renesas,r9a09g047-xspi
=20
   reg:
@@ -53,28 +55,38 @@ properties:
       - const: err_pulse
=20
   clocks:
-    items:
-      - description: AHB clock
-      - description: AXI clock
-      - description: SPI clock
-      - description: Double speed SPI clock
+    oneOf:
+      - items:
+          - description: AHB clock
+          - description: AXI clock
+          - description: SPI clock
+          - description: Double speed SPI clock
+      - items:
+          - description: AHB clock
+          - description: SPI clock
=20
   clock-names:
-    items:
-      - const: ahb
-      - const: axi
-      - const: spi
-      - const: spix2
+    oneOf:
+      - items:
+          - const: ahb
+          - const: axi
+          - const: spi
+          - const: spix2
+      - items:
+          - const: ahb
+          - const: spi
=20
   power-domains:
     maxItems: 1
=20
   resets:
+    minItems: 1
     items:
       - description: Hardware reset
       - description: AXI reset
=20
   reset-names:
+    minItems: 1
     items:
       - const: hresetn
       - const: aresetn
@@ -109,6 +121,34 @@ required:
   - '#address-cells'
   - '#size-cells'
=20
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,r9a09g077-xspi
+          - renesas,r9a09g087-xspi
+then:
+  properties:
+    clocks:
+      maxItems: 2
+    clock-names:
+      maxItems: 2
+    resets:
+      maxItems: 1
+    reset-names:
+      maxItems: 1
+else:
+  properties:
+    clocks:
+      minItems: 4
+    clock-names:
+      minItems: 4
+    resets:
+      minItems: 2
+    reset-names:
+      minItems: 2
+
 unevaluatedProperties: false
=20
 examples:
--=20
2.43.0


