From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:40 +0100
Subject: [cip-dev] [PATCH 51/62] dt-bindings: pwm: rcar: Document r8a774[35]
	PWM bindings
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-52-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch adds compatible strings specific to r8a774[35], no driver
change is needed as the fallback compatible string will activate the
right code.

Also, this patch replaces the example with a DT snippet used
for adding PWM0 support to an r8a7743 based platform as the r8a7743 is
now the first platform fully compatible with this driver and its PWM DT
nodes refer to up-to-date code.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
(cherry picked from commit 9d7e72858d9d84abbbb49e98e2dafeee2f7fd9b6)
(removed r8a7743 example,since it is based on cpg-mssr framework)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index 0822a08..4493fc5 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -2,6 +2,8 @@
 
 Required Properties:
 - compatible: should be "renesas,pwm-rcar" and one of the following.
+ - "renesas,pwm-r8a7743": for RZ/G1M
+ - "renesas,pwm-r8a7745": for RZ/G1E
  - "renesas,pwm-r8a7778": for R-Car M1A
  - "renesas,pwm-r8a7779": for R-Car H1
  - "renesas,pwm-r8a7790": for R-Car H2
-- 
2.7.4
