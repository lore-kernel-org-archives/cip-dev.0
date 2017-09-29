From: chris.paterson2@renesas.com (Chris Paterson)
Date: Fri, 29 Sep 2017 18:28:16 +0100
Subject: [cip-dev] [PATCH 14/15] ARM: dts: iwg20m: Correct indentation of
	mmcif0 properties
In-Reply-To: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
References: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1506706097-29770-15-git-send-email-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Fixes: 4658c4b789d8e2ae ("ARM: dts: iwg20m: Add MMCIF0 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit bf38b9ac16c5c8a82d63c79391dd64c5924fc00b)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index f78dbc5..ff79938 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -45,11 +45,11 @@
 };
 
 &mmcif0 {
-		pinctrl-0 = <&mmcif0_pins>;
-		pinctrl-names = "default";
+	pinctrl-0 = <&mmcif0_pins>;
+	pinctrl-names = "default";
 
-		vmmc-supply = <&reg_3p3v>;
-		bus-width = <8>;
-		non-removable;
-		status = "okay";
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
 };
-- 
1.9.1
