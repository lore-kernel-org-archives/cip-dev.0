From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 15:28:07 +0100
Subject: [cip-dev] [PATCH 3/3] ARM: dts: iwg22m: Enable cmt0
In-Reply-To: <1532615287-1183-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532615287-1183-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532615287-1183-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch enables cmt0 support from within the iwg22m SoM dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 7d1671828696650db6123ab1d7a592a0bbf42ff2)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
index ed9a8cf..8d0a392b 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
+++ b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
@@ -29,6 +29,10 @@
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
