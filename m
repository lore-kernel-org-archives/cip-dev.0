From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 17 Sep 2019 14:07:58 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 30/32] arm64: dts: renesas:
	r8a774a1: Connect Ethernet-AVB to IPMMU-DS0
In-Reply-To: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568725680-32730-31-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 57cfa7314697cafecc1d0f79af72014bd02f8ce5 upstream.

Add IPMMU-DS0 to the Ethernet-AVB device node.

Based on work by Magnus Damm for the r8a7795.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 3e67e12..e0fecd6 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -1113,6 +1113,7 @@
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 812>;
 			phy-mode = "rgmii";
+			iommus = <&ipmmu_ds0 16>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.7.4
