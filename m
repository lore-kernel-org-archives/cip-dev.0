Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F86C433FE
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.31206.1643631558306709663
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:19 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108231905"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:19 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2604A4347FCA;
	Mon, 31 Jan 2022 21:19:17 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/27] dt-bindings: memory: renesas,rpc-if: Add
 support for the R9A07G044
Date: Mon, 31 Jan 2022 12:18:46 +0000
Message-Id: <20220131121903.8620-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7531

commit c271aa1f73515bcb35f977f30825832d41a2f504 upstream.

SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
the RPC-IF interface found on R-Car Gen3 SoC's.

This patch adds a new compatible string to identify the RZ/G2L family
so that the timing values on RZ/G2L can be adjusted.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211025205631.21151-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
[PL: Manually applied the changes.]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../memory-controllers/renesas,rpc-if.yaml    | 43 ++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
index ebc1052a5e9b..e733b01abe13 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -24,12 +24,18 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r8a77970-rpc-if       # R-Car V3M
-          - renesas,r8a77980-rpc-if       # R-Car V3H
-          - renesas,r8a77995-rpc-if       # R-Car D3
-      - const: renesas,rcar-gen3-rpc-if   # a generic R-Car gen3 device
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r8a77970-rpc-if       # R-Car V3M
+              - renesas,r8a77980-rpc-if       # R-Car V3H
+              - renesas,r8a77995-rpc-if       # R-Car D3
+          - const: renesas,rcar-gen3-rpc-if   # a generic R-Car gen3 or RZ/G2{E,H,M,N} device
+
+      - items:
+          - enum:
+              - renesas,r9a07g044-rpc-if      # RZ/G2{L,LC}
+          - const: renesas,rzg2l-rpc-if       # RZ/G2L family
 
   reg:
     items:
@@ -43,8 +49,7 @@ properties:
       - const: dirmap
       - const: wbuf
 
-  clocks:
-    maxItems: 1
+  clocks: true
 
   power-domains:
     maxItems: 1
@@ -62,8 +67,6 @@ patternProperties:
             - cfi-flash
             - jedec,spi-nor
 
-unevaluatedProperties: false
-
 required:
   - compatible
   - reg
@@ -74,6 +77,26 @@ required:
   - '#address-cells'
   - '#size-cells'
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,rzg2l-rpc-if
+then:
+  properties:
+    clocks:
+      items:
+        - description: SPI Multi IO Register access clock (SPI_CLK2)
+        - description: SPI Multi IO Main clock (SPI_CLK).
+
+else:
+  properties:
+    clocks:
+      maxItems: 1
+
+unevaluatedProperties: false
+
 examples:
   - |
     #include <dt-bindings/clock/renesas-cpg-mssr.h>
-- 
2.17.1


