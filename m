From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:42 +0100
Subject: [cip-dev] [PATCH 41/86] ARM: dts: iwg22d-sodimm: Add pinctl support
	for scif4
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-42-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Adding pinctrl support for scif4 interface.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 67dbb081815e013e1e7911305b43b44537a78ed2)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index cbc19fe..442a5cb 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -24,6 +24,16 @@
 	};
 };
 
+&pfc {
+	scif4_pins: scif4 {
+		groups = "scif4_data_b";
+		function = "scif4";
+	};
+};
+
 &scif4 {
+	pinctrl-0 = <&scif4_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
-- 
2.7.4
