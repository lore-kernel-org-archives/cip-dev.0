From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:55 +0100
Subject: [cip-dev] [PATCH 37/42] ARM: dts: r8a7745: initial SoC device tree
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-38-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The  initial R8A7745 SoC device tree including CPU0, GIC, timer, SYSC, RST,
CPG, and the required clock descriptions.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit c95360247bdd67d39b55f7e743153efa64e4efe3)
(cherry picked again only to get rst node)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 2e79205..f19aed2 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -214,6 +214,11 @@
 			cpus = <&cpu0 &cpu1>;
 		};
 
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a7745-rst";
+			reg = <0 0xe6160000 0 0x100>;
+		};
+
 		irqc: interrupt-controller at e61c0000 {
 			compatible = "renesas,irqc-r8a7745", "renesas,irqc";
 			#interrupt-cells = <2>;
-- 
2.7.4
