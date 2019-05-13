From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:52 +0100
Subject: [cip-dev] [PATCH 4.4.y 27/52] serial: sh-sci: Document r8a77470
	bindings
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-28-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit ef9604b622ce3b77e0ec6b566a016ddd64c5deb0 upstream.

RZ/G1C (R8A77470) SoC also has the R-Car gen2 compatible SCIF and HSCIF
ports, so document the SoC specific bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 211f193..3772d4c 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -17,6 +17,8 @@ Required properties:
     - "renesas,scifa-r8a7745" for R8A7745 (RZ/G1E) SCIFA compatible UART.
     - "renesas,scifb-r8a7745" for R8A7745 (RZ/G1E) SCIFB compatible UART.
     - "renesas,hscif-r8a7745" for R8A7745 (RZ/G1E) HSCIF compatible UART.
+    - "renesas,scif-r8a77470" for R8A77470 (RZ/G1C) SCIF compatible UART.
+    - "renesas,hscif-r8a77470" for R8A77470 (RZ/G1C) HSCIF compatible UART.
     - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
-- 
2.7.4
