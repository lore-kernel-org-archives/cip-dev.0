From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 May 2018 18:36:07 +0100
Subject: [cip-dev] [PATCH v2 11/11] ARM: dts: iwg20m: Enable cmt0
In-Reply-To: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
References: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527701767-41785-12-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch enables cmt0 support from within the iwg20m SoM dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit cbeb319b9f220982acc2f533ffee5042a6763c39)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index 75a8ca5..1d3e950 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -34,6 +34,10 @@
 	};
 };
 
+&cmt0 {
+	status = "okay";
+};
+
 &extal_clk {
 	clock-frequency = <20000000>;
 };
-- 
2.7.4
