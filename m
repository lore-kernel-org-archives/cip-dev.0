From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 14:23:59 +0000
Subject: [cip-dev] [PATCH 01/18] dt-bindings: arm: Document RZ/G2M SoC DT
	bindings
In-Reply-To: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
References: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553178256-6293-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add device tree bindings documentation for Renesas RZ/G2M (r8a774a1) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 01588646dbce3bf9a79a190f3949677067cc1e20)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 89b4a38..8acd3cd 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -23,6 +23,8 @@ SoCs:
     compatible = "renesas,r8a7745"
   - RZ/G1C (R8A77470)
     compatible = "renesas,r8a77470"
+  - RZ/G2M (R8A774A1)
+    compatible = "renesas,r8a774a1"
   - R-Car M1A (R8A77781)
     compatible = "renesas,r8a7778"
   - R-Car H1 (R8A77790)
-- 
2.7.4
