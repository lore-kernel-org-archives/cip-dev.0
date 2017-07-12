From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 12 Jul 2017 10:21:08 +0100
Subject: [cip-dev] [PATCH  3/6] sh-sci: document R8A7743/5 support
In-Reply-To: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
References: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1499851271-20037-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Renesas RZ/G SoC also have the SCIF, SCIFA, SCIFB, and HSCIF ports and
they  seem compatible with the R-Car gen2 SoC  in this respect...
Document RZ/G1[ME] (also known as R8A774[35]) SoC bindings.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit c03e1b8703a4a0c8bac7f6b65d8fcb539ec62d82)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 73f825e..cbcfdc0 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -9,6 +9,14 @@ Required properties:
     - "renesas,scifb-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFB compatible UART.
     - "renesas,scifa-r8a7740" for R8A7740 (R-Mobile A1) SCIFA compatible UART.
     - "renesas,scifb-r8a7740" for R8A7740 (R-Mobile A1) SCIFB compatible UART.
+    - "renesas,scif-r8a7743" for R8A7743 (RZ/G1M) SCIF compatible UART.
+    - "renesas,scifa-r8a7743" for R8A7743 (RZ/G1M) SCIFA compatible UART.
+    - "renesas,scifb-r8a7743" for R8A7743 (RZ/G1M) SCIFB compatible UART.
+    - "renesas,hscif-r8a7743" for R8A7743 (RZ/G1M) HSCIF compatible UART.
+    - "renesas,scif-r8a7745" for R8A7745 (RZ/G1E) SCIF compatible UART.
+    - "renesas,scifa-r8a7745" for R8A7745 (RZ/G1E) SCIFA compatible UART.
+    - "renesas,scifb-r8a7745" for R8A7745 (RZ/G1E) SCIFB compatible UART.
+    - "renesas,hscif-r8a7745" for R8A7745 (RZ/G1E) HSCIF compatible UART.
     - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
-- 
1.9.1
