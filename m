From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:39:03 +0100
Subject: [cip-dev] [PATCH 62/86] ARM: dts: r8a7745: Add operating-points to
	cpu0
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-63-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

shmobile_defconfig builds cpu freq into the kernel by default,
therefore we get error and warning messages at boot, when
hotplugging cpus, and when waking up from suspend to RAM.

Although the r8a7745 SoC does not support DVFS, defining one
operating point makes cpu freq happy and therefore all of the
nasty messages disappear.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 077a28a..5f1cc84 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -29,6 +29,7 @@
 			clock-frequency = <1000000000>;
 			clocks = <&z2_clk>;
 			next-level-cache = <&L2_CA7>;
+			operating-points = <1000000 1000000>;
 		};
 
 		cpu1: cpu at 1 {
-- 
2.7.4
