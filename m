From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 14:24:01 +0000
Subject: [cip-dev] [PATCH 03/18] dt-bindings: arm: Fix RZ/G2E part number
In-Reply-To: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
References: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553178256-6293-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Fix RZ/G2E part number from its description.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 058ad7b6aa5204d3af878415c7b946748ab34f7a)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 9d74d81..7b1e257 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -25,7 +25,7 @@ SoCs:
     compatible = "renesas,r8a77470"
   - RZ/G2M (R8A774A1)
     compatible = "renesas,r8a774a1"
-  - RZ/G2E (RA8774C0)
+  - RZ/G2E (R8A774C0)
     compatible = "renesas,r8a774c0"
   - R-Car M1A (R8A77781)
     compatible = "renesas,r8a7778"
-- 
2.7.4
