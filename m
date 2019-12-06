From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  6 Dec 2019 12:12:19 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 03/12] dt-bindings: irqchip:
	renesas-irqc: Document r8a7744 support
In-Reply-To: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1575634348-10954-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 0c4cb97d4ec9d98fc5e30317326f28ed206f3ac6 upstream.

Document RZ/G1N (R8A7744) SoC bindings.

Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
index 1ed382e..eea4c7b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -6,6 +6,7 @@ Required properties:
   Examples with soctypes are:
     - "renesas,irqc-r8a73a4" (R-Mobile APE6)
     - "renesas,irqc-r8a7743" (RZ/G1M)
+    - "renesas,irqc-r8a7744" (RZ/G1N)
     - "renesas,irqc-r8a7745" (RZ/G1E)
     - "renesas,irqc-r8a77470" (RZ/G1C)
     - "renesas,irqc-r8a7790" (R-Car H2)
-- 
2.7.4
