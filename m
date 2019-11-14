From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:34 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 18/21] dt-bindings: arm: renesas:
	Document iWave RZ/G1N SOM
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-19-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 1deb430d291270f9d0067061a5dc7409819dfcfb upstream.

Document the iW-RainboW-G20M-RZ/G1N Qseven device tree bindings,
listing it as a supported system on module.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 52ee47b..5e22f41 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -63,6 +63,8 @@ Boards:
     compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743"
   - iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
     compatible = "iwave,g20m", "renesas,r8a7743"
+  - iWave Systems RZ/G1N Qseven System On Module (iW-RainboW-G20M-Qseven)
+    compatible = "iwave,g20m", "renesas,r8a7744"
   - Koelsch (RTP0RC7791SEB00010S)
     compatible = "renesas,koelsch", "renesas,r8a7791"
   - Kyoto Microcomputer Co. KZM-A9-Dual
-- 
2.7.4
