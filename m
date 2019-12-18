From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:12 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 02/39] dt-bindings: arm: renesas: Add
	HopeRun RZ/G2N boards
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit d30286ebbace486af71d3fc35a6ea941c19eb66d upstream.

This patch adds board HiHope RZ/G2N (the main board, powered by
the R8A774B1) and board HiHope RZ/G2 EX (the expansion board
that sits on top of the HiHope RZ/G2N). Both boards are made
by Jiangsu HopeRun Software Co., Ltd. (a.k.a. HopeRun).

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1568724492-32087-1-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Biju: backported to 4.19-cip kernel]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index e24dd16..7b83c02 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -92,10 +92,13 @@ Boards:
   - Henninger
     compatible = "renesas,henninger", "renesas,r8a7791"
   - HopeRun expansion board for HiHope RZ/G2 platforms
-    compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2m",
-                 "renesas,r8a774a1"
+    compatible = "hoperun,hihope-rzg2m", "renesas,r8a774a1",
+                 "hoperun,hihope-rzg2n", "renesas,r8a774b1",
+                 "hoperun,hihope-rzg2-ex"
   - HopeRun HiHope RZ/G2M platform
     compatible = "hoperun,hihope-rzg2m", "renesas,r8a774a1"
+  - HopeRun HiHope RZ/G2N platform
+    compatible = "hoperun,hihope-rzg2n", "renesas,r8a774b1"
   - iWave Systems RZ/G1C Single Board Computer (iW-RainboW-G23S)
     compatible = "iwave,g23s", "renesas,r8a77470"
   - iWave Systems RZ/G1E SODIMM SOM Development Platform (iW-RainboW-G22D)
-- 
2.7.4
