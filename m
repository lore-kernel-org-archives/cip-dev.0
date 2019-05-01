From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:22:12 +0100
Subject: [cip-dev] [PATCH 4.19.y 18/29] ASoC: rsnd: Add r8a774c0 support
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-19-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit ae38d267417291db40de7439f2b0b690ab615f0e upstream.

Document RZ/G2E (R8A774C0) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 8083f0d..7e38861 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -345,6 +345,7 @@ Required properties:
 				    - "renesas,rcar_sound-r8a7743" (RZ/G1M)
 				    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
 				    - "renesas,rcar_sound-r8a774a1" (RZ/G2M)
+				    - "renesas,rcar_sound-r8a774c0" (RZ/G2E)
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
 				    - "renesas,rcar_sound-r8a7779" (R-Car H1)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
-- 
2.7.4
