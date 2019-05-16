From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:53 +0100
Subject: [cip-dev] [PATCH v2 41/52] dt-bindings: irqchip: renesas-irqc:
	Document r8a77470 support
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-42-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit dcbabbbd2618991d349b3b4f75e6b2eb4fad37df upstream.

Renesas RZ/G SoC have the R-Car gen2 compatible IRQC interrupt
controllers. Document RZ/G1C (also known as R8A77470) SoC bindings.

Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* No change
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
index e3f052d..1ed382e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -7,6 +7,7 @@ Required properties:
     - "renesas,irqc-r8a73a4" (R-Mobile APE6)
     - "renesas,irqc-r8a7743" (RZ/G1M)
     - "renesas,irqc-r8a7745" (RZ/G1E)
+    - "renesas,irqc-r8a77470" (RZ/G1C)
     - "renesas,irqc-r8a7790" (R-Car H2)
     - "renesas,irqc-r8a7791" (R-Car M2-W)
     - "renesas,irqc-r8a7792" (R-Car V2H)
-- 
2.7.4
