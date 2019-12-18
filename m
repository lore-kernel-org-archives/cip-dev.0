From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:11 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 01/39] dt-bindings: arm: renesas:
	Document RZ/G2N SoC DT bindings
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 28a5f64ad9c41bfc8a12982fb95637e842b3cd7c upstream.

Add device tree bindings documentation for the Renesas RZ/G2N (r8a774b1)
SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1567675844-19247-2-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Biju: backported to 4.19-cip kernel]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index b847173..e24dd16 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -25,6 +25,8 @@ SoCs:
     compatible = "renesas,r8a77470"
   - RZ/G2M (R8A774A1)
     compatible = "renesas,r8a774a1"
+  - RZ/G2N (R8A774B1)
+    compatible = "renesas,r8a774b1"
   - RZ/G2E (R8A774C0)
     compatible = "renesas,r8a774c0"
   - R-Car M1A (R8A77781)
-- 
2.7.4
