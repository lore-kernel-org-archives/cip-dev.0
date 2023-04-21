Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA4FC77B7E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6178.1682061505900396648
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156787011"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:27 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E46B741AA65A;
	Fri, 21 Apr 2023 16:18:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 22/33] dt-bindings: net: renesas,etheravb: Document RZ/V2M SoC
Date: Fri, 21 Apr 2023 08:17:18 +0100
Message-Id: <20230421071729.130347-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11295

From: Phil Edworthy <phil.edworthy@renesas.com>

commit a7931ac16128bb3af5c4ac482057a711da117856 upstream.

Document the Ethernet AVB IP found on RZ/V2M SoC.
It includes the Ethernet controller (E-MAC) and Dedicated Direct memory
access controller (DMAC) for transferring transmitted Ethernet frames
to and received Ethernet frames from respective storage areas in the
RAM at high speed.
The AVB-DMAC is compliant with IEEE 802.1BA, IEEE 802.1AS timing and
synchronization protocol, IEEE 802.1Qav real-time transfer, and the
IEEE 802.1Qat stream reservation protocol.

R-Car has a pair of combined interrupt lines:
 ch22 = Line0_DiA | Line1_A | Line2_A
 ch23 = Line0_DiB | Line1_B | Line2_B
Line0 for descriptor interrupts (which we call dia and dib).
Line1 for error related interrupts (which we call err_a and err_b).
Line2 for management and gPTP related interrupts (mgmt_a and mgmt_b).

RZ/V2M hardware has separate interrupt lines for each of these.

It has 3 clocks; the main AXI clock, the AMBA CHI (Coherent Hub
Interface) clock and a gPTP reference clock.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/renesas,etheravb.yaml        | 82 ++++++++++++++-----
 1 file changed, 61 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index 86c3252971c8..846ad0352c71 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -42,6 +42,11 @@ properties:
               - renesas,etheravb-r8a77995     # R-Car D3
           - const: renesas,etheravb-rcar-gen3 # R-Car Gen3 and RZ/G2
 
+      - items:
+          - enum:
+              - renesas,etheravb-r9a09g011 # RZ/V2M
+          - const: renesas,etheravb-rzv2m  # RZ/V2M compatible
+
       - items:
           - enum:
               - renesas,r9a07g043-gbeth # RZ/G2UL
@@ -159,16 +164,33 @@ allOf:
             - const: arp_ns
         rx-internal-delay-ps: false
     else:
-      properties:
-        interrupts:
-          minItems: 25
-          maxItems: 25
-        interrupt-names:
-          items:
-            pattern: '^ch[0-9]+$'
-      required:
-        - interrupt-names
-        - rx-internal-delay-ps
+      if:
+        properties:
+          compatible:
+            contains:
+              const: renesas,etheravb-rzv2m
+      then:
+        properties:
+          interrupts:
+            minItems: 29
+            maxItems: 29
+          interrupt-names:
+            items:
+              pattern: '^(ch(1?)[0-9])|ch20|ch21|dia|dib|err_a|err_b|mgmt_a|mgmt_b|line3$'
+          rx-internal-delay-ps: false
+        required:
+          - interrupt-names
+      else:
+        properties:
+          interrupts:
+            minItems: 25
+            maxItems: 25
+          interrupt-names:
+            items:
+              pattern: '^ch[0-9]+$'
+        required:
+          - interrupt-names
+          - rx-internal-delay-ps
 
   - if:
       properties:
@@ -229,17 +251,35 @@ allOf:
             - const: chi
             - const: refclk
     else:
-      properties:
-        clocks:
-          minItems: 1
-          items:
-            - description: AVB functional clock
-            - description: Optional TXC reference clock
-        clock-names:
-          minItems: 1
-          items:
-            - const: fck
-            - const: refclk
+      if:
+        properties:
+          compatible:
+            contains:
+              const: renesas,etheravb-rzv2m
+      then:
+        properties:
+          clocks:
+            items:
+              - description: Main clock
+              - description: Coherent Hub Interface clock
+              - description: gPTP reference clock
+          clock-names:
+            items:
+              - const: axi
+              - const: chi
+              - const: gptp
+      else:
+        properties:
+          clocks:
+            minItems: 1
+            items:
+              - description: AVB functional clock
+              - description: Optional TXC reference clock
+          clock-names:
+            minItems: 1
+            items:
+              - const: fck
+              - const: refclk
 
 additionalProperties: false
 
-- 
2.25.1


