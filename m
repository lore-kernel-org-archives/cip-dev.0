From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:51 +0100
Subject: [cip-dev] [PATCH 33/42] ARM: dts: r8a7745: Add Inter Connect RAM
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-34-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

RZ/G1E has 3 regions of Inter Connect RAM (72 + 4 + 256 KiB).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 825216b8160b53b83f405a1e7b6c647e4e99e25a)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 33236c0..0afd5f0 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -1022,6 +1022,21 @@
 			status = "disabled";
 		};
 
+		icram2:	sram at e6300000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe6300000 0 0x40000>;
+		};
+
+		icram0:	sram at e63a0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63a0000 0 0x12000>;
+		};
+
+		icram1:	sram at e63c0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63c0000 0 0x1000>;
+		};
+
 		ether: ethernet at ee700000 {
 			compatible = "renesas,ether-r8a7745";
 			reg = <0 0xee700000 0 0x400>;
-- 
2.7.4
