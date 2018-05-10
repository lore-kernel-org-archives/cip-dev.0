From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:33 +0100
Subject: [cip-dev] [PATCH 44/62] dt-bindings: pwm: renesas-tpu: Document
	r8a774[35] support
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-45-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Document r8a774[35] specific compatible strings. No driver change is
needed as the fallback compatible string "renesas,tpu" activates the
right code in the driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
(cherry picked from commit 3ba111a0182265b65e303c969294b8033ce9d122)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
index b067e84..90e0a0a 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
@@ -5,9 +5,11 @@ Required Properties:
   - compatible: should be one of the following.
     - "renesas,tpu-r8a73a4": for R8A77A4 (R-Mobile APE6) compatible PWM controller.
     - "renesas,tpu-r8a7740": for R8A7740 (R-Mobile A1) compatible PWM controller.
+    - "renesas,tpu-r8a7743": for R8A7743 (RZ/G1M) compatible PWM controller.
+    - "renesas,tpu-r8a7745": for R8A7745 (RZ/G1E) compatible PWM controller.
     - "renesas,tpu-r8a7790": for R8A7790 (R-Car H2) compatible PWM controller.
     - "renesas,tpu-sh7372": for SH7372 (SH-Mobile AP4) compatible PWM controller.
-    - "renesas,tpu": for generic R-Car TPU PWM controller.
+    - "renesas,tpu": for generic R-Car and RZ/G1 TPU PWM controller.
 
   - reg: Base address and length of each memory resource used by the PWM
     controller hardware module.
-- 
2.7.4
