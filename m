From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:46 +0100
Subject: [cip-dev] [PATCH v2 34/52] dt-bindings: arm: Document
	iW-RainboW-G23S single board computer
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-35-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 7625f03be3177d63cc6e5763b0c2dfecc371ca95 upstream.

Document the iW-RainboW-G23S single board computer device tree bindings,
listing it as a supported board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* No change
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 3b51d7e..423575a 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -51,6 +51,8 @@ Boards:
     compatible = "renesas,gose", "renesas,r8a7793"
   - Henninger
     compatible = "renesas,henninger", "renesas,r8a7791"
+  - iWave Systems RZ/G1C Single Board Computer (iW-RainboW-G23S)
+    compatible = "iwave,g23s", "renesas,r8a77470"
   - iWave Systems RZ/G1E SODIMM SOM Development Platform (iW-RainboW-G22D)
     compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745"
   - iWave Systems RZ/G1E SODIMM System On Module (iW-RainboW-G22M-SM)
-- 
2.7.4
