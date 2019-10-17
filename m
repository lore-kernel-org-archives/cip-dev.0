From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 07:57:54 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 1/6] arm64: dts: renesas: r8a774a1: Use
	extended audio dmac registers
In-Reply-To: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295479-39328-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Basic audio dmac register only supports busif from 0 to 3,
in order to use busif4 ~ busif7 extended audio dmac registers
need to be used.

Based on similar work from Jiada Wang in commit 7a516e49d975 ("arm64:
dts: renesas: use extended audio dmac register").

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 0a6f4f9..26c767f 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -1397,7 +1397,7 @@
 				<0 0xec5a0000 0 0x100>,  /* ADG */
 				<0 0xec540000 0 0x1000>, /* SSIU */
 				<0 0xec541000 0 0x280>,  /* SSI */
-				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+				<0 0xec760000 0 0x200>;  /* Audio DMAC peri peri*/
 			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
 			clocks = <&cpg CPG_MOD 1005>,
-- 
2.7.4
