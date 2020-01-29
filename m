From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 29 Jan 2020 14:29:57 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 04/12] arm64: dts: renesas: r8a774b1:
	Add RWDT node
In-Reply-To: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1580308205-20435-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 7213aea4afad4a0642157fce76eb88736bb9b29f upstream.

Populate the device tree node for the Watchdog Timer (RWDT)
controller on the Renesas RZ/G2N (r8a774b1) SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Link: https://lore.kernel.org/r/1570178133-21532-5-git-send-email-fabrizio.castro at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index f42f646..de904426 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -127,8 +127,13 @@
 		ranges;
 
 		rwdt: watchdog at e6020000 {
+			compatible = "renesas,r8a774b1-wdt",
+				     "renesas,rcar-gen3-wdt";
 			reg = <0 0xe6020000 0 0x0c>;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 402>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
+			status = "disabled";
 		};
 
 		gpio0: gpio at e6050000 {
-- 
2.7.4
