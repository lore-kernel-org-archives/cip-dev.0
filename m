Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073DCC4332F
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30861.1641817416053116503
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554171"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:37 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 70EE842AC9F7;
	Mon, 10 Jan 2022 21:23:36 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 03/61] dt-bindings: net: renesas,etheravb: Document
 Gigabit Ethernet IP
Date: Mon, 10 Jan 2022 12:22:33 +0000
Message-Id: <20220110122331.24114-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7368

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 1dbd981fcf2a4498bbf66b55b830ca0aadff9476 upstream.

Document Gigabit Ethernet IP found on RZ/G2L SoC.

Gigabit Ethernet Interface includes Ethernet controller (E-MAC),
Internal TCP/IP Offload Engine (TOE) and Dedicated Direct memory
access controller (DMAC) for transferring transmitted Ethernet
frames to and received Ethernet frames from respective storage
areas in the URAM at high speed.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210727123450.15918-1-biju.das.jz@bp.renesas.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/net/renesas,etheravb.yaml        | 57 +++++++++++++++----
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index 8d1f467c95ba..ce4f816f0769 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -42,23 +42,20 @@ properties:
               - renesas,etheravb-r8a77995     # R-Car D3
           - const: renesas,etheravb-rcar-gen3 # R-Car Gen3 and RZ/G2
 
+      - items:
+          - enum:
+              - renesas,r9a07g044-gbeth # RZ/G2{L,LC}
+          - const: renesas,rzg2l-gbeth  # RZ/G2L
+
   reg: true
 
   interrupts: true
 
   interrupt-names: true
 
-  clocks:
-    minItems: 1
-    items:
-      - description: AVB functional clock
-      - description: Optional TXC reference clock
+  clocks: true
 
-  clock-names:
-    minItems: 1
-    items:
-      - const: fck
-      - const: refclk
+  clock-names: true
 
   iommus:
     maxItems: 1
@@ -144,14 +141,20 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,etheravb-rcar-gen2
+            enum:
+              - renesas,etheravb-rcar-gen2
+              - renesas,rzg2l-gbeth
     then:
       properties:
         interrupts:
-          maxItems: 1
+          minItems: 1
+          maxItems: 3
         interrupt-names:
+          minItems: 1
           items:
             - const: mux
+            - const: int_fil_n
+            - const: int_arp_ns_n
         rx-internal-delay-ps: false
     else:
       properties:
@@ -206,6 +209,36 @@ allOf:
         tx-internal-delay-ps:
           const: 2000
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzg2l-gbeth
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Main clock
+            - description: Register access clock
+            - description: Reference clock for RGMII
+        clock-names:
+          items:
+            - const: axi
+            - const: chi
+            - const: refclk
+    else:
+      properties:
+        clocks:
+          minItems: 1
+          items:
+            - description: AVB functional clock
+            - description: Optional TXC reference clock
+        clock-names:
+          minItems: 1
+          items:
+            - const: fck
+            - const: refclk
+
 additionalProperties: false
 
 examples:
-- 
2.17.1


