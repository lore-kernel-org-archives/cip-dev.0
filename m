From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:49 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 23/35] ASoC: rsnd: Document r8a774b1
	bindings
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-24-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 01400bfb2ea76a399448486e2d26f2f1b5a77787 upstream.

Document SoC specific bindings for RZ/G2N (r8a774b1) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1570171940-42937-1-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 7e38861..a65c97d 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -345,6 +345,7 @@ Required properties:
 				    - "renesas,rcar_sound-r8a7743" (RZ/G1M)
 				    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
 				    - "renesas,rcar_sound-r8a774a1" (RZ/G2M)
+				    - "renesas,rcar_sound-r8a774b1" (RZ/G2N)
 				    - "renesas,rcar_sound-r8a774c0" (RZ/G2E)
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
 				    - "renesas,rcar_sound-r8a7779" (R-Car H1)
-- 
2.7.4
