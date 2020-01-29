From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 29 Jan 2020 14:30:00 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 07/12] arm64: dts: renesas:
	hihope-rzg2-ex: Let the board specific DT decide about pciec1
In-Reply-To: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1580308205-20435-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 133e6c78c4937ea7449cf8542b14f7b37bf470ac upstream.

The plan for the HiHope RZ/G2N board is to enable pciec0 by default,
and use pciec1 physical interface for SATA (as SATA and PCIE1 share
the same physical interface), therefore move pciec1 enabling away
from hihope-rzg2-ex.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Link: https://lore.kernel.org/r/1570178133-21532-8-git-send-email-fabrizio.castro at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi          | 4 ----
 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
index 4280b19..6870e22 100644
--- a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
@@ -47,10 +47,6 @@
 	status = "okay";
 };
 
-&pciec1 {
-	status = "okay";
-};
-
 &pfc {
 	pinctrl-0 = <&scif_clk_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
index 6e33a3b..c754fca 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
@@ -13,3 +13,7 @@
 	compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2m",
 		     "renesas,r8a774a1";
 };
+
+&pciec1 {
+	status = "okay";
+};
-- 
2.7.4
