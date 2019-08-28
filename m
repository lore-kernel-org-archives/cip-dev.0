From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:32:37 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 50/57] arm64: dts: renesas: Remove
	unneeded status from thermal nodes
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-51-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit c79661eb5060e2bf18875d86caf3324b4ab4c03f upstream.

The thermal device is supposed to be always enabled.  As the default
value of the status property is "okay", there is no need to make this
explicit in SoC-specific .dtsi files where no override is involved.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[fab: dropped changes not related to r8a774a1.dtsi]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 046fc93..012cbb6 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -358,7 +358,6 @@
 			power-domains = <&sysc 32>;
 			resets = <&cpg 522>;
 			#thermal-sensor-cells = <1>;
-			status = "okay";
 		};
 
 		intc_ex: interrupt-controller at e61c0000 {
-- 
2.7.4
