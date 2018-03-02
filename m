From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  2 Mar 2018 11:44:47 +0000
Subject: [cip-dev] [PATCH 1/6] ARM: shmobile: r8a7743: Rename SDHI clocks
In-Reply-To: <1519991092-4465-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519991092-4465-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1519991092-4465-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This commit renames R8A7743_CLK_SDHI2 to R8A7743_CLK_SDHI1 and
R8A7743_CLK_SDHI3 to R8A7743_CLK_SDHI2. This is to make the SDHI
clock names of the r8a7743 more similar to upstream definitions.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi            | 4 ++--
 include/dt-bindings/clock/r8a7743-clock.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 9255582..b1534a0 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -958,8 +958,8 @@
 					 <&hp_clk>, <&hp_clk>;
 				#clock-cells = <1>;
 				clock-indices = <
-					R8A7743_CLK_TPU0 R8A7743_CLK_SDHI3
-					R8A7743_CLK_SDHI2 R8A7743_CLK_SDHI0
+					R8A7743_CLK_TPU0 R8A7743_CLK_SDHI2
+					R8A7743_CLK_SDHI1 R8A7743_CLK_SDHI0
 					R8A7743_CLK_MMCIF0 R8A7743_CLK_IIC0
 					R8A7743_CLK_PCIEC R8A7743_CLK_IIC1
 					R8A7743_CLK_SSUSB R8A7743_CLK_CMT1
diff --git a/include/dt-bindings/clock/r8a7743-clock.h b/include/dt-bindings/clock/r8a7743-clock.h
index 53f54df..8e4b843 100644
--- a/include/dt-bindings/clock/r8a7743-clock.h
+++ b/include/dt-bindings/clock/r8a7743-clock.h
@@ -58,8 +58,8 @@
 
 /* MSTP3 */
 #define R8A7743_CLK_TPU0		4
-#define R8A7743_CLK_SDHI3		11
-#define R8A7743_CLK_SDHI2		12
+#define R8A7743_CLK_SDHI2		11
+#define R8A7743_CLK_SDHI1		12
 #define R8A7743_CLK_SDHI0		14
 #define R8A7743_CLK_MMCIF0		15
 #define R8A7743_CLK_IIC0		18
-- 
2.7.4
