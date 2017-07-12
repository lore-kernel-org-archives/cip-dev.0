From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 12 Jul 2017 10:21:07 +0100
Subject: [cip-dev] [PATCH 2/6] DT: irqchip: renesas-irqc: document R8A7743/5
	support
In-Reply-To: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
References: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1499851271-20037-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Renesas  RZ/G SoC have the R-Car gen2 compatible IRQC interrupt controllers.
Document RZ/G1[ME] (also known as R8A774[35]) SoC bindings.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
(cherry picked from commit 87e5fc99b0280b492724cc7f2d8d9ad37b980087)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 .../devicetree/bindings/interrupt-controller/renesas,irqc.txt         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
index ae5054c..e3f052d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -1,10 +1,12 @@
-DT bindings for the R-Mobile/R-Car interrupt controller
+DT bindings for the R-Mobile/R-Car/RZ/G interrupt controller
 
 Required properties:
 
 - compatible: has to be "renesas,irqc-<soctype>", "renesas,irqc" as fallback.
   Examples with soctypes are:
     - "renesas,irqc-r8a73a4" (R-Mobile APE6)
+    - "renesas,irqc-r8a7743" (RZ/G1M)
+    - "renesas,irqc-r8a7745" (RZ/G1E)
     - "renesas,irqc-r8a7790" (R-Car H2)
     - "renesas,irqc-r8a7791" (R-Car M2-W)
     - "renesas,irqc-r8a7792" (R-Car V2H)
-- 
1.9.1
