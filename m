Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40E8C83F27
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74778.1752487726107261575
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: jlfYsCi2QaOkGyUKcpHoOA==
X-CSE-MsgGUID: 5bErH3nrSkSUGh08bpsJIQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:47 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2229441D4BE8;
	Mon, 14 Jul 2025 19:08:45 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 20/57] dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
Date: Mon, 14 Jul 2025 11:07:01 +0100
Message-ID: <20250714100802.80035-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19448

commit 466c8ef7b66bf4595537333e96c7334e1ceb454a upstream.

RZ/G3E SoC has 20 interrupts, 2 resets and 6 channels that need more
branching with conditional schema. Simplify the conditional schema with
if statements rather than the complex if-else statements to prepare for
supporting RZ/G3E SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-2-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[Biju: Dropped R-Car V3{H,M} changes as it is not supported in 6.1
       cip kernel]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 89 ++++++++++++-------
 1 file changed, 55 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 9b3994d0eb86..10d668fedabf 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -43,7 +43,35 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    oneOf:
+      - items:
+          - description: Channel interrupt
+          - description: Global interrupt
+      - items:
+          - description: CAN global error interrupt
+          - description: CAN receive FIFO interrupt
+          - description: CAN0 error interrupt
+          - description: CAN0 transmit interrupt
+          - description: CAN0 transmit/receive FIFO receive completion interrupt
+          - description: CAN1 error interrupt
+          - description: CAN1 transmit interrupt
+          - description: CAN1 transmit/receive FIFO receive completion interrupt
+
+  interrupt-names:
+    oneOf:
+      - items:
+          - const: ch_int
+          - const: g_int
+      - items:
+          - const: g_err
+          - const: g_recc
+          - const: ch0_err
+          - const: ch0_rec
+          - const: ch0_trx
+          - const: ch1_err
+          - const: ch1_rec
+          - const: ch1_trx
 
   clocks:
     maxItems: 3
@@ -115,58 +143,51 @@ allOf:
     then:
       properties:
         interrupts:
-          items:
-            - description: CAN global error interrupt
-            - description: CAN receive FIFO interrupt
-            - description: CAN0 error interrupt
-            - description: CAN0 transmit interrupt
-            - description: CAN0 transmit/receive FIFO receive completion interrupt
-            - description: CAN1 error interrupt
-            - description: CAN1 transmit interrupt
-            - description: CAN1 transmit/receive FIFO receive completion interrupt
+          minItems: 8
+          maxItems: 8
 
         interrupt-names:
-          items:
-            - const: g_err
-            - const: g_recc
-            - const: ch0_err
-            - const: ch0_rec
-            - const: ch0_trx
-            - const: ch1_err
-            - const: ch1_rec
-            - const: ch1_trx
+          minItems: 8
+          maxItems: 8
 
         resets:
+          minItems: 2
           maxItems: 2
 
         reset-names:
-          items:
-            - const: rstp_n
-            - const: rstc_n
+          minItems: 2
+          maxItems: 2
 
       required:
         - reset-names
-    else:
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen3-canfd
+              - renesas,rcar-gen4-canfd
+    then:
       properties:
         interrupts:
-          items:
-            - description: Channel interrupt
-            - description: Global interrupt
+          minItems: 2
+          maxItems: 2
 
         interrupt-names:
-          items:
-            - const: ch_int
-            - const: g_int
+          minItems: 2
+          maxItems: 2
 
         resets:
           maxItems: 1
 
   - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              const: renesas,rcar-gen4-canfd
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen3-canfd
+              - renesas,rzg2l-canfd
     then:
       patternProperties:
         "^channel[2-7]$": false
-- 
2.43.0


