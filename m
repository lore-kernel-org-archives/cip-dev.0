From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:12 +0100
Subject: [cip-dev] [PATCH 23/62] ASoC: rsnd: Add device tree support for
	r8a774[35]
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-24-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Document r8a774[35] specific compatible strings. The Renesas RZ/G1[ME]
(r8a774[35]) sound modules are identical to the R-Car Gen2 family.
No driver change is needed as the fallback compatible string
"renesas,rcar_sound-gen2" activates the right code in the driver.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit b0a858a47a7889757dbc9ac9872685955eaa5cc0)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 3f03fd0..649cd3a 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -3,9 +3,11 @@ Renesas R-Car sound
 Required properties:
 - compatible			: "renesas,rcar_sound-<soctype>", fallbacks
 				  "renesas,rcar_sound-gen1" if generation1, and
-				  "renesas,rcar_sound-gen2" if generation2
+				  "renesas,rcar_sound-gen2" if generation2 (or RZ/G1)
 				  "renesas,rcar_sound-gen3" if generation3
 				  Examples with soctypes are:
+				    - "renesas,rcar_sound-r8a7743" (RZ/G1M)
+				    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
 				    - "renesas,rcar_sound-r8a7791" (R-Car M2-W)
-- 
2.7.4
