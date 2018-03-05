From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:01:58 +0000
Subject: [cip-dev] [PATCH 02/15] serial: sh-sci: Update DT binding
	documentation for dedicated RTS/CTS
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520247731-25239-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Some Renesas SCIF UARTs have dedicated lines for RTS/CTS hardware flow
control.  Whether these lines exist depends on SoC and UART instance
inside the SoC.  Whether these lines can be used for hardware flow
control depends on board wiring.

Amend the DT bindings with an optional property to indicate that RTS/CTS
hardware flow control lines exist, and can be used as such, according to
the Generic Serial DT Bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit b0405dc998e425bbb1f64488b6fda781b627056b)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index e0fd7ee..211f193 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -61,6 +61,8 @@ Optional properties:
   - dma-names: Must contain a list of two DMA names, "tx" and "rx".
   - {cts,dsr,dcd,rng,rts,dtr}-gpios: Specify GPIOs for modem lines, cfr. the
     generic serial DT bindings in serial.txt.
+  - uart-has-rtscts: Indicates dedicated lines for RTS/CTS hardware flow
+    control, cfr. the generic serial DT bindings in serial.txt.
 
 Example:
 	aliases {
-- 
2.7.4
