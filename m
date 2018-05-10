From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:07 +0100
Subject: [cip-dev] [PATCH 18/62] soc_camera: rcar_vin: add R-Car Gen 2 and 3
	fallback compatibility strings
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-19-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Add fallback compatibility string for R-Car Gen 1 and 2.

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, e.g. Gen 2 and 3. But beyond that it's unclear what the relationship
between IP blocks might be. For example, I believe that r8a7790 is older
than r8a7791 but that doesn't imply that the latter is a descendant of the
former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme being adopted for
drivers for Renesas SoCs.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
(cherry picked from commit bd546882ff3476718d6df872c1c95aedcc5ed37d)
(removed gen3 devices)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 10 ++++++++--
 drivers/media/platform/soc_camera/rcar_vin.c         |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 9dafe6b..1abe1ef 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -5,13 +5,19 @@ The rcar_vin device provides video input capabilities for the Renesas R-Car
 family of devices. The current blocks are always slaves and suppot one input
 channel which can be either RGB, YUYV or BT656.
 
- - compatible: Must be one of the following
+ - compatible: Must be one or more of the following
    - "renesas,vin-r8a7794" for the R8A7794 device
    - "renesas,vin-r8a7793" for the R8A7793 device
    - "renesas,vin-r8a7791" for the R8A7791 device
    - "renesas,vin-r8a7790" for the R8A7790 device
    - "renesas,vin-r8a7779" for the R8A7779 device
    - "renesas,vin-r8a7778" for the R8A7778 device
+   - "renesas,rcar-gen2-vin" for a generic R-Car Gen2 compatible device.
+
+   When compatible with the generic version nodes must list the
+   SoC-specific version corresponding to the platform first
+   followed by the generic version.
+
  - reg: the register base and size for the device registers
  - interrupts: the interrupt for the device
  - clocks: Reference to the parent clock
@@ -36,7 +42,7 @@ Device node example
 	};
 
         vin0: vin at 0xe6ef0000 {
-                compatible = "renesas,vin-r8a7790";
+                compatible = "renesas,vin-r8a7790", "renesas,rcar-gen2-vin";
                 clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
                 reg = <0 0xe6ef0000 0 0x1000>;
                 interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index efe57b2..dfb2c72 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -1848,6 +1848,7 @@ static const struct of_device_id rcar_vin_of_table[] = {
 	{ .compatible = "renesas,vin-r8a7790", .data = (void *)RCAR_GEN2 },
 	{ .compatible = "renesas,vin-r8a7779", .data = (void *)RCAR_H1 },
 	{ .compatible = "renesas,vin-r8a7778", .data = (void *)RCAR_M1 },
+	{ .compatible = "renesas,rcar-gen2-vin", .data = (void *)RCAR_GEN2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rcar_vin_of_table);
-- 
2.7.4
