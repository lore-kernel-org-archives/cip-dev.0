Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD79DC83F22
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:17:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74913.1752488245150104217
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:17:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: EK3FvlObTOSFAg74TsUPpg==
X-CSE-MsgGUID: MTGIA9ywSX2kvC/LHQbRwg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:17:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 21F4C400D4D1;
	Mon, 14 Jul 2025 19:17:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 16/36] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
Date: Mon, 14 Jul 2025 11:16:16 +0100
Message-ID: <20250714101650.80381-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:17:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19502

commit e623c6e56bdf776b001313934709f9ff38b7dda6 upstream.

Document support for the CAN-FD Interface on the RZ/G3E (R9A09G047) SoC,
which supports up to six channels.

The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
and RZ/G2L, but differs in some hardware parameters:
 * No external clock, but instead has ram clock.
 * Support up to 6 channels.
 * 20 interrupts.

Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 76 +++++++++++++++++--
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 4a83498b2a8b1..f4ac21c684278 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -42,6 +42,8 @@ properties:
               - renesas,r9a07g054-canfd    # RZ/V2L
           - const: renesas,rzg2l-canfd     # RZ/G2L family
 
+      - const: renesas,r9a09g047-canfd     # RZ/G3E
+
   reg:
     maxItems: 1
 
@@ -59,6 +61,19 @@ properties:
           - description: CAN1 error interrupt
           - description: CAN1 transmit interrupt
           - description: CAN1 transmit/receive FIFO receive completion interrupt
+          - description: CAN2 error interrupt
+          - description: CAN2 transmit interrupt
+          - description: CAN2 transmit/receive FIFO receive completion interrupt
+          - description: CAN3 error interrupt
+          - description: CAN3 transmit interrupt
+          - description: CAN3 transmit/receive FIFO receive completion interrupt
+          - description: CAN4 error interrupt
+          - description: CAN4 transmit interrupt
+          - description: CAN4 transmit/receive FIFO receive completion interrupt
+          - description: CAN5 error interrupt
+          - description: CAN5 transmit interrupt
+          - description: CAN5 transmit/receive FIFO receive completion interrupt
+        minItems: 8
 
   interrupt-names:
     oneOf:
@@ -74,15 +89,33 @@ properties:
           - const: ch1_err
           - const: ch1_rec
           - const: ch1_trx
+          - const: ch2_err
+          - const: ch2_rec
+          - const: ch2_trx
+          - const: ch3_err
+          - const: ch3_rec
+          - const: ch3_trx
+          - const: ch4_err
+          - const: ch4_rec
+          - const: ch4_trx
+          - const: ch5_err
+          - const: ch5_rec
+          - const: ch5_trx
+        minItems: 8
 
   clocks:
     maxItems: 3
 
   clock-names:
-    items:
-      - const: fck
-      - const: canfd
-      - const: can_clk
+    oneOf:
+      - items:
+          - const: fck
+          - const: canfd
+          - const: can_clk
+      - items:
+          - const: fck
+          - const: ram_clk
+          - const: can_clk
 
   power-domains:
     maxItems: 1
@@ -145,11 +178,9 @@ allOf:
     then:
       properties:
         interrupts:
-          minItems: 8
           maxItems: 8
 
         interrupt-names:
-          minItems: 8
           maxItems: 8
 
         resets:
@@ -183,6 +214,30 @@ allOf:
         resets:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-canfd
+    then:
+      properties:
+        interrupts:
+          minItems: 20
+
+        interrupt-names:
+          minItems: 20
+
+        resets:
+          minItems: 2
+          maxItems: 2
+
+        reset-names:
+          minItems: 2
+          maxItems: 2
+
+      required:
+        - reset-names
+
   - if:
       properties:
         compatible:
@@ -203,6 +258,15 @@ allOf:
       patternProperties:
         "^channel[4-7]$": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-canfd
+    then:
+      patternProperties:
+        "^channel[6-7]$": false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


