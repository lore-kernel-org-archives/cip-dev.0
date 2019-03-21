From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 16:22:18 +0000
Subject: [cip-dev] [PATCH 09/10] dt-bindings: serial: sh-sci: Document
	r8a774c0 bindings
In-Reply-To: <1553185339-26890-1-git-send-email-biju.das@bp.renesas.com>
References: <1553185339-26890-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553185339-26890-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

RZ/G2E (R8A774C0) SoC also has the R-Car Gen3 compatible SCIF and
HSCIF ports, so document the SoC specific bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit a88c4736ea36396f4a7b1460202a8caa434238db)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 1994ab8..f620772 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -22,6 +22,8 @@ Required properties:
     - "renesas,hscif-r8a77470" for R8A77470 (RZ/G1C) HSCIF compatible UART.
     - "renesas,scif-r8a774a1" for R8A774A1 (RZ/G2M) SCIF compatible UART.
     - "renesas,hscif-r8a774a1" for R8A774A1 (RZ/G2M) HSCIF compatible UART.
+    - "renesas,scif-r8a774c0" for R8A774C0 (RZ/G2E) SCIF compatible UART.
+    - "renesas,hscif-r8a774c0" for R8A774C0 (RZ/G2E) HSCIF compatible UART.
     - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
-- 
2.7.4
