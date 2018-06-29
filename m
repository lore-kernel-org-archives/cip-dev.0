From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:07 +0100
Subject: [cip-dev] [PATCH 06/86] ARM: shmobile: document iW-RainboW-G22D
	SODIMM SOM Development Platform
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Document the iW-RainboW-G22D device tree bindings.
It is just a placeholder for the time being, the actual
implementation is not available yet.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 61c687e8223f842ed71267ad142f5a920b32213d)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index ed0fb82..e27b38e 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -49,6 +49,8 @@ Boards:
     compatible = "renesas,gose", "renesas,r8a7793"
   - Henninger
     compatible = "renesas,henninger", "renesas,r8a7791"
+  - iWave Systems RZ/G1E SODIMM SOM Development Platform (iW-RainboW-G22D)
+    compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745"
   - iWave Systems RZ/G1E SODIMM System On Module (iW-RainboW-G22M-SM)
     compatible = "iwave,g22m", "renesas,r8a7745"
   - iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
-- 
2.7.4
