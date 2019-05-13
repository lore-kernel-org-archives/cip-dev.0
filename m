From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:37:16 +0100
Subject: [cip-dev] [PATCH 4.4.y 51/52] ARM: dts: iwg23s-sbc: specify
	EtherAVB PHY IRQ
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-52-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 938fbd1ae2aca6e0547411687f0cc32d18427eae upstream.

Specify  EtherAVB PHY IRQ  in the board specific device tree, now that we
have GPIO support.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
index 56182ee..22da819 100644
--- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -35,6 +35,8 @@
 
 	phy3: ethernet-phy at 3 {
 		reg = <3>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
 		micrel,led-mode = <1>;
 	};
 };
-- 
2.7.4
