From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:30 +0100
Subject: [cip-dev] [PATCH 41/62] ARM: dts: iwg20d-q7-common: Sound DMA
	support via SRC on DTS
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-42-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

DMA transfer to/from SRC

     DMA      DMApp
[MEM] -> [SRC] -> [SSIU] -> [SSI]

     DMA      DMApp
[MEM] <- [SRC] <- [SSIU] <- [SSI]

Current sound driver is supporting SSI/SRC random connection.
So, this patch is trying
SSI1 -> SRC3
SSI0 <- SRC2

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit b4b2094511166d904e6f15df8eff9d2776bf138c)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 6c16f99..937c6fe 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -202,8 +202,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi1>;
-			capture = <&ssi0>;
+			playback = <&ssi1 &src3>;
+			capture = <&ssi0 &src2>;
 		};
 	};
 };
-- 
2.7.4
