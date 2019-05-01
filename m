From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:22:19 +0100
Subject: [cip-dev] [PATCH 4.19.y 25/29] arm64: dts: renesas: r8a774c0:
	Connect RZ/G2E Audio-DMAC to IPMMU
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-26-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 52a20e64cce7f25727e6ca5de19424222bdd220a upstream.

Hook up the RZ/G2E Audio-DMAC device to IPMMU-MP as stated by the
RZ/G2 User's manual.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index fbb67b3..54ab2ee 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1510,6 +1510,14 @@
 			resets = <&cpg 502>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_mp 0>, <&ipmmu_mp 1>,
+				 <&ipmmu_mp 2>, <&ipmmu_mp 3>,
+				 <&ipmmu_mp 4>, <&ipmmu_mp 5>,
+				 <&ipmmu_mp 6>, <&ipmmu_mp 7>,
+				 <&ipmmu_mp 8>, <&ipmmu_mp 9>,
+				 <&ipmmu_mp 10>, <&ipmmu_mp 11>,
+				 <&ipmmu_mp 12>, <&ipmmu_mp 13>,
+				 <&ipmmu_mp 14>, <&ipmmu_mp 15>;
 		};
 
 		sdhi0: sd at ee100000 {
-- 
2.7.4
