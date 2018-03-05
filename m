From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:01:57 +0000
Subject: [cip-dev] [PATCH 01/15] serial: sh-sci: Update DT binding
	documentation for GPIO modem lines
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520247731-25239-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Amend the DT bindings for the Renesas SCI driver to allow describing
optional GPIO-controlled modem lines, which can be used where dedicated
modem lines are not available.

The property naming is dictated by the Generic Serial DT Bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 0c529b3fc6c66e618088aa3a998d760d1ad05272)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index cbcfdc0..e0fd7ee 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -59,6 +59,8 @@ Optional properties:
   - dmas: Must contain a list of two references to DMA specifiers, one for
 	  transmission, and one for reception.
   - dma-names: Must contain a list of two DMA names, "tx" and "rx".
+  - {cts,dsr,dcd,rng,rts,dtr}-gpios: Specify GPIOs for modem lines, cfr. the
+    generic serial DT bindings in serial.txt.
 
 Example:
 	aliases {
-- 
2.7.4
