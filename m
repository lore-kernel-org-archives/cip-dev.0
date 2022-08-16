Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524CFC25B0E
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:34:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.15008.1660653254165494760
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:34:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600";
   d="scan'208";a="129665706"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 21:34:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EF50F402D0A2;
	Tue, 16 Aug 2022 21:34:15 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/31] dt-bindings: net: can: renesas,rcar-canfd:
 Document RZ/G2L SoC
Date: Tue, 16 Aug 2022 13:33:39 +0100
Message-Id: <20220816123406.27553-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:34:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9222

commit 1aa5a06c0a5dbebd0351ffe5db77c06e9089e4fc upstream.

Add CANFD binding documentation for Renesas RZ/G2L SoC.

Link: https://lore.kernel.org/r/20210727133022.634-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 69 +++++++++++++++++--
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 0b33ba9ccb47..546c6e6d2fb0 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -30,13 +30,15 @@ properties:
               - renesas,r8a77995-canfd     # R-Car D3
           - const: renesas,rcar-gen3-canfd # R-Car Gen3 and RZ/G2
 
+      - items:
+          - enum:
+              - renesas,r9a07g044-canfd    # RZ/G2{L,LC}
+          - const: renesas,rzg2l-canfd     # RZ/G2L family
+
   reg:
     maxItems: 1
 
-  interrupts:
-    items:
-      - description: Channel interrupt
-      - description: Global interrupt
+  interrupts: true
 
   clocks:
     maxItems: 3
@@ -50,8 +52,7 @@ properties:
   power-domains:
     maxItems: 1
 
-  resets:
-    maxItems: 1
+  resets: true
 
   renesas,no-can-fd:
     $ref: /schemas/types.yaml#/definitions/flag
@@ -91,6 +92,62 @@ required:
   - channel0
   - channel1
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,rzg2l-canfd
+then:
+  properties:
+    interrupts:
+      items:
+        - description: CAN global error interrupt
+        - description: CAN receive FIFO interrupt
+        - description: CAN0 error interrupt
+        - description: CAN0 transmit interrupt
+        - description: CAN0 transmit/receive FIFO receive completion interrupt
+        - description: CAN1 error interrupt
+        - description: CAN1 transmit interrupt
+        - description: CAN1 transmit/receive FIFO receive completion interrupt
+
+    interrupt-names:
+      items:
+        - const: g_err
+        - const: g_recc
+        - const: ch0_err
+        - const: ch0_rec
+        - const: ch0_trx
+        - const: ch1_err
+        - const: ch1_rec
+        - const: ch1_trx
+
+    resets:
+      maxItems: 2
+
+    reset-names:
+      items:
+        - const: rstp_n
+        - const: rstc_n
+
+  required:
+    - interrupt-names
+    - reset-names
+else:
+  properties:
+    interrupts:
+      items:
+        - description: Channel interrupt
+        - description: Global interrupt
+
+    interrupt-names:
+      items:
+        - const: ch_int
+        - const: g_int
+
+    resets:
+      maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1


