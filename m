Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC97C88E4C
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 08:11:52 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34547.1789114303725943288
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 01:11:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LYQWgCsE;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.49, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k320CbmzIpTJggFRSeEmHFELbnrm5RndkF+1dAZFT1ybaXFNfAZo8t84RCqlPfvz90qePpH9ikbshARvPiV3MXT9MlP+xvKO09cuISObUoR5hUFYoX93cZMSjv8pKbB4kkLBb9x0PbJalWuLLyzdqML7AHpGJAJo7aJANP0kRaoxsFrVQrZSH7ChTZ9Kpnf+JJrI8NB/cXdSZAqUgHh088z3phTLVvXwL5vzpc8Y5+GCVHMddnJYlTohfQXh+YhxN1AxW13xDSVQC3ge1/7dfTfw6diHjgmG+8L4pvk5j7/bYSH+Ts7mUIrR32NI9Irh0WhDimxyQW7UwdJ6Az7ZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNMG4/PJgaZ1SFKLYioksd/jT8reVY0nms9oHDKJB2w=;
 b=zAkzNqU5SKxkY3Rdbx3RB03EoC1JSEQcRvsnaWOW6TqkSpplXPUiR7hAAsBKhpcgPMV5KdHtY9Wuu8fuwn6ohr3jgMujKOmLm5aMrqypiWjGcsePnX8EKBICstAoolVtJq1LpNiDpHQELrCBU7/4eYtk4QVGIVUP7Hx32tkQ4ZkKPdickY7XQCYBpHvJBzxjioUVpEQcMJhbFyFmBqvqHXIV9M40H7PlJxXnPIn1Z901bb2su48Cxr8IXdZgMN6C883dijeOKry29oelkQGNzc66KfRBm2nqaymOshXPjNzsaQYkNdgdQoooit1FckMQw0CmZJW1o7lZYFRM8aQyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNMG4/PJgaZ1SFKLYioksd/jT8reVY0nms9oHDKJB2w=;
 b=LYQWgCsErLIym2ICSFKj2ZzTaSixOSEiPRM2e000XzAUhQoQRn+FtEZUH7iIVDK+4jQlaATDmWXFZA6aZ+9LqEH3wrXwOZ83rfcLe75rgql2BskHu8EvLVY79UioODyzebeVfDRrLXJU/x9uuvDUjBFE+ao39mjLULKjis68KFQ=
Received: from TY4PR01CA0041.jpnprd01.prod.outlook.com (2603:1096:405:2bd::8)
 by TYWPR01MB8693.jpnprd01.prod.outlook.com (2603:1096:400:16e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Fri, 11 Sep
 2026 08:11:36 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2bd:cafe::83) by TY4PR01CA0041.outlook.office365.com
 (2603:1096:405:2bd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 08:11:36 +0000
Received: from Ubuntu-22.. (gbr-5cg2238qm6.diasemi.com [10.24.0.235])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 34BAE30002A8;
	Fri, 11 Sep 2026 17:11:34 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/8] dt-bindings: dma: renesas,rz-dmac: document RZ/{T2H,N2H}
Date: Fri, 11 Sep 2026 09:11:25 +0100
Message-ID: <20260911081132.11879-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TYWPR01MB8693:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 614ea51a-f5d9-42c1-5846-08df0fdc4ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	OlOgL5G66F5blABAl3D/gbpRLSyrB+DjM1G7TjHgp721Kyu9BlYbnXzKiXYRN4eTeAKzWrh1Sp7MnCMM1RHNDXdIvVAa8dRf40jKgCFyn+CAdxRiaj3V1WReXwir1TATsZC1pYQoUOm+ej+9HYIiTs8AO/THt8MlAYRJZuw80/7y02pdUbB92CBCzBf2jB06RT401JSE0iVGtDWTPQ4bT6uKKY1Hq4qC7APJmmrP40KxGnBVL6uu/q8IGzgjzSQ05x2G02z+KXI1rnI6H3QF+n/QsghQLthZfALQhXajQGrJpLWtB38C0pAafecjfNVHknRLTolZyFH/tWd9Sn5VdbvO0pEjH52wa404kFK7sK+erIilVIvglFlggcP7th0Lbee50/ZJQ4NHWLiZlvZn3D+C11oC8Zd4RAT/OHFC7dY6Hj+Kbgmqneb3yWtE9s0DC//Z/gMO8MYW2JuWFL/v1jXDURL1Ds9yiWQbGFrz6CcPNOzk4L6sOYPI4j+18rmYzKLyL4xWCmdl+STa9gnWJbKws+8rBovXdDaUzrhqFlQWlUW5KRBytBaw6g9o308fl0y+PKDiFkp9FsIW2tMkYrkwVhWsmmcPVj7xTze7l/HWY3oxTtUGUrLi4NHFoVrLYiNj+6bLXGbx/QTkV1LpgA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	46CwakzvO1jroQBbOmUTIJvgDn52ZzZC4qdNHzk682b9/wzQg3G0FK6yxMHN6gPxzPrDLBLh9WF6yurExw4UVJYLktLxR1rRJkjPwvLIcLCZuqk/YhMVDHutnIyAZVFd3IZrYmU8atWZRrwgpmpb/euomV2nD+rPxXpX2t2vic/xQmV7cXi3eAd2aAK8eVtVk711WLiBEWjmPVbhtmxrmByAodI+6cb39WMqjIK1PJejZ/8cwT7GSWVPN81x1NwKdkw6dOJDoqZpBdVsaQ/WXTPPVRlmtjVe96G5wbMFTrq0392nEjW3088ByPIfBiJ87AO1sEcTiGOa2h5RjxhtNGx7JLLxj9UyaTwtKwng6dfRIpF4EC1ebGWjuzt56484T/wOu+m/Tn7AmwcwwgjivNH18nVYDdyFvOHHm1Nl0Mum2n9fzvYlRDwdsm5S9NxO
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:11:36.5089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614ea51a-f5d9-42c1-5846-08df0fdc4ccc
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 08:11:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24119

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 40dd470a95c0674515ca606757ffe174bd7d3f90 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three
DMAC instances. Compared to the previously supported RZ/V2H, these SoCs
are missing the error interrupt line and the reset lines, and they use
a different ICU IP.

Document them, and use RZ/T2H as a fallback for RZ/N2H as the DMACs are
entirely compatible.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260105114445.878262-4-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/dma/renesas,rz-dmac.yaml         | 100 ++++++++++++++----
 1 file changed, 82 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/D=
ocumentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index bc1c7f64d68d2..70bc4fa0acde5 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -28,6 +28,13 @@ properties:
=20
       - const: renesas,r9a09g057-dmac # RZ/V2H(P)
=20
+      - const: renesas,r9a09g077-dmac # RZ/T2H
+
+      - items:
+          - enum:
+              - renesas,r9a09g087-dmac # RZ/N2H
+          - const: renesas,r9a09g077-dmac
+
   reg:
     items:
       - description: Control and channel register block
@@ -35,27 +42,12 @@ properties:
     minItems: 1
=20
   interrupts:
+    minItems: 16
     maxItems: 17
=20
   interrupt-names:
-    items:
-      - const: error
-      - const: ch0
-      - const: ch1
-      - const: ch2
-      - const: ch3
-      - const: ch4
-      - const: ch5
-      - const: ch6
-      - const: ch7
-      - const: ch8
-      - const: ch9
-      - const: ch10
-      - const: ch11
-      - const: ch12
-      - const: ch13
-      - const: ch14
-      - const: ch15
+    minItems: 16
+    maxItems: 17
=20
   clocks:
     items:
@@ -121,6 +113,35 @@ required:
 allOf:
   - $ref: dma-controller.yaml#
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rz-dmac
+              - renesas,r9a09g057-dmac
+    then:
+      properties:
+        interrupt-names:
+          items:
+            - const: error
+            - const: ch0
+            - const: ch1
+            - const: ch2
+            - const: ch3
+            - const: ch4
+            - const: ch5
+            - const: ch6
+            - const: ch7
+            - const: ch8
+            - const: ch9
+            - const: ch10
+            - const: ch11
+            - const: ch12
+            - const: ch13
+            - const: ch14
+            - const: ch15
+
   - if:
       properties:
         compatible:
@@ -171,6 +192,49 @@ allOf:
         - renesas,icu
         - resets
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-dmac
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        clocks:
+          maxItems: 1
+
+        clock-names: false
+        resets: false
+        reset-names: false
+
+        interrupts:
+          maxItems: 16
+
+        interrupt-names:
+          items:
+            - const: ch0
+            - const: ch1
+            - const: ch2
+            - const: ch3
+            - const: ch4
+            - const: ch5
+            - const: ch6
+            - const: ch7
+            - const: ch8
+            - const: ch9
+            - const: ch10
+            - const: ch11
+            - const: ch12
+            - const: ch13
+            - const: ch14
+            - const: ch15
+
+      required:
+        - clocks
+        - power-domains
+        - renesas,icu
+
 additionalProperties: false
=20
 examples:
--=20
2.43.0


