Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD7CC83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74858.1752487721947632755
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: SYK3zZ6LTJmZAL2lHjgBag==
X-CSE-MsgGUID: taLY27ABSCe6qMwq/ZFx8w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:41 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D5D3E41D45A9;
	Mon, 14 Jul 2025 19:08:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 17/57] dt-bindings: can: renesas,rcar-canfd: Fix number of channels for R-Car V3U
Date: Mon, 14 Jul 2025 11:06:58 +0100
Message-ID: <20250714100802.80035-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19445

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 3abcc01c38bc5d424635df96e0677e2fbec021de upstream.

According to the bindings, only two channels are supported.
However, R-Car V3U supports eight, leading to "make dtbs" failures:

        arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb: can@e6660000: Unevaluated properties are not allowed ('channel2', 'channel3', 'channel4', 'channel5', 'channel6', 'channel7' were unexpected)

Update the number of channels to 8 on R-Car V3U.
While at it, prevent adding more properties to the channel nodes, as
they must contain no other properties than a status property.

Fixes: d6254d52d70de530 ("dt-bindings: can: renesas,rcar-canfd: Document r8a779a0 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/all/7d41d72cd7db2e90bae069ce57dbb672f17500ae.1670431681.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 133 ++++++++++--------
 1 file changed, 72 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 8347053a96dc..1eb98c9a1a26 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -9,9 +9,6 @@ title: Renesas R-Car CAN FD Controller
 maintainers:
   - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
 
-allOf:
-  - $ref: can-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -77,12 +74,13 @@ properties:
     description: Maximum frequency of the CANFD clock.
 
 patternProperties:
-  "^channel[01]$":
+  "^channel[0-7]$":
     type: object
     description:
-      The controller supports two channels and each is represented as a child
-      node.  Each child node supports the "status" property only, which
-      is used to enable/disable the respective channel.
+      The controller supports multiple channels and each is represented as a
+      child node.  Each channel can be enabled/disabled individually.
+
+    additionalProperties: false
 
 required:
   - compatible
@@ -98,60 +96,73 @@ required:
   - channel0
   - channel1
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,rzg2l-canfd
-then:
-  properties:
-    interrupts:
-      items:
-        - description: CAN global error interrupt
-        - description: CAN receive FIFO interrupt
-        - description: CAN0 error interrupt
-        - description: CAN0 transmit interrupt
-        - description: CAN0 transmit/receive FIFO receive completion interrupt
-        - description: CAN1 error interrupt
-        - description: CAN1 transmit interrupt
-        - description: CAN1 transmit/receive FIFO receive completion interrupt
-
-    interrupt-names:
-      items:
-        - const: g_err
-        - const: g_recc
-        - const: ch0_err
-        - const: ch0_rec
-        - const: ch0_trx
-        - const: ch1_err
-        - const: ch1_rec
-        - const: ch1_trx
-
-    resets:
-      maxItems: 2
-
-    reset-names:
-      items:
-        - const: rstp_n
-        - const: rstc_n
-
-  required:
-    - reset-names
-else:
-  properties:
-    interrupts:
-      items:
-        - description: Channel interrupt
-        - description: Global interrupt
-
-    interrupt-names:
-      items:
-        - const: ch_int
-        - const: g_int
-
-    resets:
-      maxItems: 1
+allOf:
+  - $ref: can-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rzg2l-canfd
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: CAN global error interrupt
+            - description: CAN receive FIFO interrupt
+            - description: CAN0 error interrupt
+            - description: CAN0 transmit interrupt
+            - description: CAN0 transmit/receive FIFO receive completion interrupt
+            - description: CAN1 error interrupt
+            - description: CAN1 transmit interrupt
+            - description: CAN1 transmit/receive FIFO receive completion interrupt
+
+        interrupt-names:
+          items:
+            - const: g_err
+            - const: g_recc
+            - const: ch0_err
+            - const: ch0_rec
+            - const: ch0_trx
+            - const: ch1_err
+            - const: ch1_rec
+            - const: ch1_trx
+
+        resets:
+          maxItems: 2
+
+        reset-names:
+          items:
+            - const: rstp_n
+            - const: rstc_n
+
+      required:
+        - reset-names
+    else:
+      properties:
+        interrupts:
+          items:
+            - description: Channel interrupt
+            - description: Global interrupt
+
+        interrupt-names:
+          items:
+            - const: ch_int
+            - const: g_int
+
+        resets:
+          maxItems: 1
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: renesas,r8a779a0-canfd
+    then:
+      patternProperties:
+        "^channel[2-7]$": false
 
 unevaluatedProperties: false
 
-- 
2.43.0


