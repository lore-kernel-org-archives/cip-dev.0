Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E8BC38147
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 12:40:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.630.1702384840537154755
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Dec 2023 04:40:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,270,1695654000"; 
   d="scan'208";a="190069294"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 12 Dec 2023 21:40:41 +0900
Received: from localhost.localdomain (unknown [10.226.93.124])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7662D400517D;
	Tue, 12 Dec 2023 21:40:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 01/14] dt-bindings: gpu: mali-bifrost: Document RZ/G2L support
Date: Tue, 12 Dec 2023 12:40:22 +0000
Message-Id: <20231212124035.151367-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
References: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Dec 2023 12:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14044

commit 570df0a51955b4741ca3a87b065ce4d7927bf325 upstream.

The Renesas RZ/G2{L, LC} SoC (a.k.a R9A07G044) has a Bifrost Mali-G31 GPU,
add a compatible string for it.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Link: https://lore.kernel.org/r/20211208104026.421-2-biju.das.jz@bp.renesas.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/gpu/arm,mali-bifrost.yaml        | 45 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index b1844b9c295d..3b32d34f5a8e 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - amlogic,meson-g12a-mali
           - realtek,rtd1619-mali
+          - renesas,r9a07g044-mali
           - rockchip,px30-mali
       - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
 
@@ -25,19 +26,26 @@ properties:
     maxItems: 1
 
   interrupts:
+    minItems: 3
     items:
       - description: Job interrupt
       - description: MMU interrupt
       - description: GPU interrupt
+      - description: Event interrupt
 
   interrupt-names:
+    minItems: 3
     items:
       - const: job
       - const: mmu
       - const: gpu
+      - const: event
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
+
+  clock-names: true
 
   mali-supply: true
 
@@ -47,7 +55,10 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 2
+    minItems: 1
+    maxItems: 3
+
+  reset-names: true
 
   "#cooling-cells":
     const: 2
@@ -70,6 +81,36 @@ allOf:
     then:
       required:
         - resets
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g044-mali
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+        interrupt-names:
+          minItems: 4
+        clocks:
+          minItems: 3
+        clock-names:
+          items:
+            - const: gpu
+            - const: bus
+            - const: bus_ace
+        resets:
+          minItems: 3
+        reset-names:
+          items:
+            - const: rst
+            - const: axi_rst
+            - const: ace_rst
+      required:
+        - clock-names
+        - power-domains
+        - resets
+        - reset-names
 
 examples:
   - |
-- 
2.25.1


