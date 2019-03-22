From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:19:26 +0000
Subject: [cip-dev] [PATCH 5/9] arm64: dts: renesas: r8a774c0: Add PFC support
In-Reply-To: <1553246370-60751-1-git-send-email-biju.das@bp.renesas.com>
References: <1553246370-60751-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553246370-60751-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add PFC support to the RZ/G2E (a.k.a. r8a774c0) SoC specific
device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 788e55b66c13e8e77003e9226677e49eaaa9f751)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 4f6caa7..8c25c06 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -114,6 +114,11 @@
 		#size-cells = <2>;
 		ranges;
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a774c0";
+			reg = <0 0xe6060000 0 0x508>;
+		};
+
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a774c0-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
2.7.4
