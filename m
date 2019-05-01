From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:22:14 +0100
Subject: [cip-dev] [PATCH 4.19.y 20/29] dt-bindings: pwm: rcar: Add r8a774a1
	support
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-21-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 786e0cfa9d6fc1cc8856c1864c988d233649348c upstream.

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index e1ef6af..874c566 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -4,6 +4,7 @@ Required Properties:
 - compatible: should be "renesas,pwm-rcar" and one of the following.
  - "renesas,pwm-r8a7743": for RZ/G1M
  - "renesas,pwm-r8a7745": for RZ/G1E
+ - "renesas,pwm-r8a774a1": for RZ/G2M
  - "renesas,pwm-r8a7778": for R-Car M1A
  - "renesas,pwm-r8a7779": for R-Car H1
  - "renesas,pwm-r8a7790": for R-Car H2
-- 
2.7.4
