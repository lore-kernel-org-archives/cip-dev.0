From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  6 Dec 2019 12:12:26 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 10/12] ASoC: rsnd: Add r8a7744 support
In-Reply-To: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1575634348-10954-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 765f50d464457c6a397506b3f3dc58dacc227c6d upstream.

Document RZ/G1N (R8A7744) SoC bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 649cd3a..23656d1 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -7,6 +7,7 @@ Required properties:
 				  "renesas,rcar_sound-gen3" if generation3
 				  Examples with soctypes are:
 				    - "renesas,rcar_sound-r8a7743" (RZ/G1M)
+				    - "renesas,rcar_sound-r8a7744" (RZ/G1N)
 				    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
-- 
2.7.4
