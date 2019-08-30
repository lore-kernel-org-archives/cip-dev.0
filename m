From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 30 Aug 2019 08:31:54 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 1/5] dt-bindings: arm: renesas: Add
	HopeRun RZ/G2[M] boards
In-Reply-To: <1567150318-36833-1-git-send-email-biju.das@bp.renesas.com>
References: <1567150318-36833-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567150318-36833-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 70ac79f5d1ef95e61b174e95192b3555a4caef2f upstream.

This patch adds board HiHope RZ/G2M (the main board, powered by
the R8A774A1) and board HiHope RZ/G2 EX (the expansion board
that sits on top of the HiHope RZ/G2M). Both boards are made
by Jiangsu HopeRun Software Co., Ltd. (a.k.a. HopeRun).

Useful links:
http://hihope.org/product/detail/rzg2
https://item.taobao.com/item.htm?spm=a2oq0.12575281.0.0.6bcf1debQpzkRS&ft=t&id=592177498472
http://www.hoperun.com/Cn/news/id/379

We already know that the HiHope RZ/G2 EX will also sit on the
HiHope RZ/G2N, even though the HiHope RZ/G2N doesn't exist just
yet.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[ Backported to 4.19 ]
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 1556460..b847173 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -89,6 +89,11 @@ Boards:
     compatible = "renesas,h3ulcb", "renesas,r8a7795"
   - Henninger
     compatible = "renesas,henninger", "renesas,r8a7791"
+  - HopeRun expansion board for HiHope RZ/G2 platforms
+    compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2m",
+                 "renesas,r8a774a1"
+  - HopeRun HiHope RZ/G2M platform
+    compatible = "hoperun,hihope-rzg2m", "renesas,r8a774a1"
   - iWave Systems RZ/G1C Single Board Computer (iW-RainboW-G23S)
     compatible = "iwave,g23s", "renesas,r8a77470"
   - iWave Systems RZ/G1E SODIMM SOM Development Platform (iW-RainboW-G22D)
-- 
2.7.4
