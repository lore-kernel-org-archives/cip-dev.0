From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:37:08 +0100
Subject: [cip-dev] [PATCH 4.4.y 43/52] ARM: dts: iwg23s-sbc: Add pinctl
	support for scif1
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-44-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 01a12d4975fb09c10f64cb551d4903dacd032b79 upstream.

Adding pinctrl support for scif1 interface.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
index d21baad..48821dd 100644
--- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -30,6 +30,16 @@
 	clock-frequency = <20000000>;
 };
 
+&pfc {
+	scif1_pins: scif1 {
+		groups = "scif1_data_b";
+		function = "scif1";
+	};
+};
+
 &scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
-- 
2.7.4
