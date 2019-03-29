From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Mar 2019 08:32:37 +0000
Subject: [cip-dev] [PATCH 4.19.y 4/4] arm64: dts: renesas: cat875: Enable
	PCIe support
In-Reply-To: <1553848357-30592-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1553848357-30592-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1553848357-30592-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

This patch enables PCIEC0 PCI express controller on the sub board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit ee20aeefb53f6ffabed5b1a3b859294197eeb351)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/cat875.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/cat875.dtsi b/arch/arm64/boot/dts/renesas/cat875.dtsi
index 805ffa7..14db667 100644
--- a/arch/arm64/boot/dts/renesas/cat875.dtsi
+++ b/arch/arm64/boot/dts/renesas/cat875.dtsi
@@ -30,6 +30,10 @@
 	};
 };
 
+&pciec0 {
+	status = "okay";
+};
+
 &pfc {
 	avb_pins: avb {
 		mux {
-- 
2.7.4
