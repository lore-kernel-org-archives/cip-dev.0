From: chris.paterson2@renesas.com (Chris Paterson)
Date: Fri, 29 Sep 2017 18:28:03 +0100
Subject: [cip-dev] [PATCH 01/15] ARM: dts: r8a7743: add PFC support
In-Reply-To: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
References: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1506706097-29770-2-git-send-email-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7743 part of the PFC device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 328968b60231e522ea7e81ae0c83f59f13626a85)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Conflicts:
	arch/arm/boot/dts/r8a7743.dtsi
---
 arch/arm/boot/dts/r8a7743.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index fde6327..7f4d8c0 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for the r8a7743 SoC
  *
- * Copyright (C) 2016 Cogent Embedded Inc.
+ * Copyright (C) 2016-2017 Cogent Embedded Inc.
  * Copyright (C) 2017 Renesas Electronics Corp.
  *
  * This file is licensed under the terms of the GNU General Public License
@@ -93,6 +93,11 @@
 						  IRQ_TYPE_LEVEL_LOW)>;
 		};
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a7743";
+			reg = <0 0xe6060000 0 0x250>;
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,rcar-dmac";
 			reg = <0 0xe6700000 0 0x20000>;
-- 
1.9.1
