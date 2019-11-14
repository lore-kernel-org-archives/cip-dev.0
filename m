From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:32 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 16/21] dt-bindings: serial: sh-sci:
	Document r8a7744 bindings
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-17-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 9e3eb4eabdb6f652ca8a99f58f3eccf29610839d upstream.

RZ/G1N (R8A7744) SoC also has the R-Car gen2 compatible SCIF, SCIFA,
SCIFB, and HSCIF ports, so document the SoC specific bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 3772d4c..d2db856 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -13,6 +13,10 @@ Required properties:
     - "renesas,scifa-r8a7743" for R8A7743 (RZ/G1M) SCIFA compatible UART.
     - "renesas,scifb-r8a7743" for R8A7743 (RZ/G1M) SCIFB compatible UART.
     - "renesas,hscif-r8a7743" for R8A7743 (RZ/G1M) HSCIF compatible UART.
+    - "renesas,scif-r8a7744" for R8A7744 (RZ/G1N) SCIF compatible UART.
+    - "renesas,scifa-r8a7744" for R8A7744 (RZ/G1N) SCIFA compatible UART.
+    - "renesas,scifb-r8a7744" for R8A7744 (RZ/G1N) SCIFB compatible UART.
+    - "renesas,hscif-r8a7744" for R8A7744 (RZ/G1N) HSCIF compatible UART.
     - "renesas,scif-r8a7745" for R8A7745 (RZ/G1E) SCIF compatible UART.
     - "renesas,scifa-r8a7745" for R8A7745 (RZ/G1E) SCIFA compatible UART.
     - "renesas,scifb-r8a7745" for R8A7745 (RZ/G1E) SCIFB compatible UART.
-- 
2.7.4
