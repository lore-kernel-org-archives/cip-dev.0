From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:24 +0100
Subject: [cip-dev] [PATCH 06/42] reset: Add renesas,rst DT bindings
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add DT bindings for the Renesas R-Car Reset Controller (R-Car Gen1
RESET/WDT and R-Car Gen2/Gen3 and RZ/G RST).

As the features provided by the hardware module differ a lot across the
various SoC families and members, only SoC-specific compatible values
are defined.

For now we use the RST only for providing access to the state of the
mode pins, which is needed by the clock driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
(cherry picked from commit 362922a1a5345d17a9d4ad7e3f848aa4fdf79d75)
(dropped R-Car Gen1 and Gen3 support, replaced R-Car3 example with
RZ/G1M, dropped mode pins functionality description)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 .../devicetree/bindings/reset/renesas,rst.txt      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
new file mode 100644
index 0000000..fff2e8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -0,0 +1,24 @@
+DT bindings for the Renesas R-Car and RZ/G Reset Controllers
+
+The R-Car and RZ/G Reset Controllers provide reset control.
+
+Required properties:
+  - compatible: Should be
+		  - "renesas,<soctype>-rst" for R-Car Gen2 and RZ/G
+		Examples with soctypes are:
+		  - "renesas,r8a7743-rst" (RZ/G1M)
+		  - "renesas,r8a7745-rst" (RZ/G1E)
+		  - "renesas,r8a7790-rst" (R-Car H2)
+		  - "renesas,r8a7791-rst" (R-Car M2-W)
+		  - "renesas,r8a7792-rst" (R-Car V2H
+		  - "renesas,r8a7793-rst" (R-Car M2-N)
+		  - "renesas,r8a7794-rst" (R-Car E2)
+  - reg: Address start and address range for the device.
+
+
+Example:
+
+	rst: reset-controller at e6160000 {
+		compatible = "renesas,r8a7743-rst";
+		reg = <0 0xe6160000 0 0x100>;
+	};
-- 
2.7.4
