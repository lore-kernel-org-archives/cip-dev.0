From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 16:22:17 +0000
Subject: [cip-dev] [PATCH 08/10] dt-bindings: serial: sh-sci: Document
	r8a774a1 bindings
In-Reply-To: <1553185339-26890-1-git-send-email-biju.das@bp.renesas.com>
References: <1553185339-26890-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553185339-26890-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

RZ/G2M (R8A774A1) SoC also has the R-Car Gen3 compatible SCIF and
HSCIF ports, so document the SoC specific bindings. While at it,
update the RZ/G1 and RZ/G2 family specific strings description as
outdated.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 6c4d975812677fdacfe657b8a1fae11de2fb4a37)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 .../devicetree/bindings/serial/renesas,sci-serial.txt      | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index eaca9da..1994ab8 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -20,6 +20,8 @@ Required properties:
     - "renesas,hscif-r8a7745" for R8A7745 (RZ/G1E) HSCIF compatible UART.
     - "renesas,scif-r8a77470" for R8A77470 (RZ/G1C) SCIF compatible UART.
     - "renesas,hscif-r8a77470" for R8A77470 (RZ/G1C) HSCIF compatible UART.
+    - "renesas,scif-r8a774a1" for R8A774A1 (RZ/G2M) SCIF compatible UART.
+    - "renesas,hscif-r8a774a1" for R8A774A1 (RZ/G2M) HSCIF compatible UART.
     - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
@@ -55,13 +57,13 @@ Required properties:
     - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
     - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
     - "renesas,rcar-gen1-scif" for R-Car Gen1 SCIF compatible UART,
-    - "renesas,rcar-gen2-scif" for R-Car Gen2 SCIF compatible UART,
-    - "renesas,rcar-gen3-scif" for R-Car Gen3 SCIF compatible UART,
-    - "renesas,rcar-gen2-scifa" for R-Car Gen2 SCIFA compatible UART,
-    - "renesas,rcar-gen2-scifb" for R-Car Gen2 SCIFB compatible UART,
+    - "renesas,rcar-gen2-scif" for R-Car Gen2 and RZ/G1 SCIF compatible UART,
+    - "renesas,rcar-gen3-scif" for R-Car Gen3 and RZ/G2 SCIF compatible UART,
+    - "renesas,rcar-gen2-scifa" for R-Car Gen2 and RZ/G1 SCIFA compatible UART,
+    - "renesas,rcar-gen2-scifb" for R-Car Gen2 and RZ/G1 SCIFB compatible UART,
     - "renesas,rcar-gen1-hscif" for R-Car Gen1 HSCIF compatible UART,
-    - "renesas,rcar-gen2-hscif" for R-Car Gen2 HSCIF compatible UART,
-    - "renesas,rcar-gen3-hscif" for R-Car Gen3 HSCIF compatible UART,
+    - "renesas,rcar-gen2-hscif" for R-Car Gen2 and RZ/G1 HSCIF compatible UART,
+    - "renesas,rcar-gen3-hscif" for R-Car Gen3 and RZ/G2 HSCIF compatible UART,
     - "renesas,scif" for generic SCIF compatible UART.
     - "renesas,scifa" for generic SCIFA compatible UART.
     - "renesas,scifb" for generic SCIFB compatible UART.
-- 
2.7.4
