From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  1 Feb 2018 13:46:23 +0000
Subject: [cip-dev] [PATCH 1/7] dt-bindings: i2c: Spelling
	s/propoerty/property/
In-Reply-To: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
References: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517492789-44830-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
(cherry picked from commit ddf3dc82f10e15469b3967ae777d39745d3aab16)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-imx.txt  | 2 +-
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 2 +-
 Documentation/devicetree/bindings/i2c/i2c-sirf.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
index eab5836..b967544 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
@@ -11,7 +11,7 @@ Required properties:
 
 Optional properties:
 - clock-frequency : Constains desired I2C/HS-I2C bus clock frequency in Hz.
-  The absence of the propoerty indicates the default frequency 100 kHz.
+  The absence of the property indicates the default frequency 100 kHz.
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
 - scl-gpios: specify the gpio related to SCL pin
diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index ea406eb2..dea14f7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -17,7 +17,7 @@ Required properties:
 
 Optional properties:
 - clock-frequency: desired I2C bus clock frequency in Hz. The absence of this
-  propoerty indicates the default frequency 100 kHz.
+  property indicates the default frequency 100 kHz.
 - clocks: clock specifier.
 
 Examples :
diff --git a/Documentation/devicetree/bindings/i2c/i2c-sirf.txt b/Documentation/devicetree/bindings/i2c/i2c-sirf.txt
index 7baf9e1..2701eef 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sirf.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sirf.txt
@@ -8,7 +8,7 @@ Required properties :
 
 Optional properties:
 - clock-frequency : Constains desired I2C/HS-I2C bus clock frequency in Hz.
-  The absence of the propoerty indicates the default frequency 100 kHz.
+  The absence of the property indicates the default frequency 100 kHz.
 
 Examples :
 
-- 
2.7.4
