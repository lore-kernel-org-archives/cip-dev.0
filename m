From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 31 Jan 2018 11:15:51 +0000
Subject: [cip-dev] [PATCH 06/10] devicetree: bindings: Renesas APMU and SMP
	Enable method
In-Reply-To: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
References: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517397355-23341-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Magnus Damm <damm+renesas@opensource.se>

Add DT binding documentation for the APMU hardware and add "renesas,apmu"
to the list of enable methods for the ARM cpus.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit e454b359b7a0a6f59e3d83394e6d4e598554cb33)
[removed r8a7792,r8a7793 and r8a7794 devices]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
 .../devicetree/bindings/power/renesas,apmu.txt     | 28 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,apmu.txt

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 3a07a87..9ef9a20 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -200,6 +200,7 @@ nodes to be present and contain the properties described below.
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
+			    "renesas,apmu"
 			    "rockchip,rk3066-smp"
 			    "ste,dbx500-smp"
 
diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.txt b/Documentation/devicetree/bindings/power/renesas,apmu.txt
new file mode 100644
index 0000000..bc8de21
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.txt
@@ -0,0 +1,28 @@
+DT bindings for the Renesas Advanced Power Management Unit
+
+Renesas R-Car line of SoCs utilize one or more APMU hardware units
+for CPU core power domain control including SMP boot and CPU Hotplug.
+
+Required properties:
+
+- compatible: Should be "renesas,<soctype>-apmu", "renesas,apmu" as fallback.
+	      Examples with soctypes are:
+		- "renesas,r8a7790-apmu" (R-Car H2)
+		- "renesas,r8a7791-apmu" (R-Car M2-W)
+
+- reg: Base address and length of the I/O registers used by the APMU.
+
+- cpus: This node contains a list of CPU cores, which should match the order
+  of CPU cores used by the WUPCR and PSTR registers in the Advanced Power
+  Management Unit section of the device's datasheet.
+
+
+Example:
+
+This shows the r8a7791 APMU that can control CPU0 and CPU1.
+
+	apmu at e6152000 {
+		compatible = "renesas,r8a7791-apmu", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x188>;
+		cpus = <&cpu0 &cpu1>;
+	};
-- 
2.7.4
