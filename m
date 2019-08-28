From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:41 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 14/41] pinctrl: sh-pfc: Add
	SH_PFC_PIN_CFG_PULL_UP_DOWN shorthand
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-15-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit f1074e7281a2e83b1cca7dee8f7005fbcc1f594e upstream.

It is very common for a pin to support both pull-up and pull-down
functionality.  Hence add a shorthand SH_PFC_PIN_CFG_PULL_UP_DOWN.
This not only reduces typing, but also avoids the need for several line
breaks, and makes many overly long lines shorter, improving
readability.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c     |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c     |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 12 +++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 12 +++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 12 +++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    | 12 +++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    |  3 +--
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c      |  2 +-
 drivers/pinctrl/sh-pfc/pinctrl.c         |  3 +--
 drivers/pinctrl/sh-pfc/sh_pfc.h          |  2 ++
 10 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index 0b22fe5..bafc81a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -1265,7 +1265,7 @@ static const u16 pinmux_data[] = {
 
 #define __O	(SH_PFC_PIN_CFG_OUTPUT)
 #define __IO	(SH_PFC_PIN_CFG_INPUT | SH_PFC_PIN_CFG_OUTPUT)
-#define __PUD	(SH_PFC_PIN_CFG_PULL_DOWN | SH_PFC_PIN_CFG_PULL_UP)
+#define __PUD	(SH_PFC_PIN_CFG_PULL_UP_DOWN)
 
 #define R8A73A4_PIN_IO_PU_PD(pin)       SH_PFC_PIN_CFG(pin, __IO | __PUD)
 #define R8A73A4_PIN_O(pin)              SH_PFC_PIN_CFG(pin, __O)
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 43541b1..c07fdad 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -1528,7 +1528,7 @@ static const u16 pinmux_data[] = {
 #define __IO		(SH_PFC_PIN_CFG_INPUT | SH_PFC_PIN_CFG_OUTPUT)
 #define __PD		(SH_PFC_PIN_CFG_PULL_DOWN)
 #define __PU		(SH_PFC_PIN_CFG_PULL_UP)
-#define __PUD		(SH_PFC_PIN_CFG_PULL_DOWN | SH_PFC_PIN_CFG_PULL_UP)
+#define __PUD		(SH_PFC_PIN_CFG_PULL_UP_DOWN)
 
 #define R8A7740_PIN_I_PD(pin)		SH_PFC_PIN_CFG(pin, __I | __PD)
 #define R8A7740_PIN_I_PU(pin)		SH_PFC_PIN_CFG(pin, __I | __PU)
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index 087c2b3..c75d48f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -13,9 +13,7 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define CFG_FLAGS (SH_PFC_PIN_CFG_DRIVE_STRENGTH | \
-		   SH_PFC_PIN_CFG_PULL_UP | \
-		   SH_PFC_PIN_CFG_PULL_DOWN)
+#define CFG_FLAGS (SH_PFC_PIN_CFG_DRIVE_STRENGTH | SH_PFC_PIN_CFG_PULL_UP_DOWN)
 
 #define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_CFG_16(0, fn, sfx, CFG_FLAGS),	\
@@ -1493,17 +1491,17 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('C'),  5, QSPI0_MOSI_IO0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('C'),  7, QSPI1_MOSI_IO0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 38, FSCLKST#, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 39, EXTALR, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 39, EXTALR, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('E'),  4, QSPI1_IO2, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('E'),  5, QSPI1_MISO_IO1, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('P'),  7, DU_DOTCLKIN0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('P'),  8, DU_DOTCLKIN1, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'),  7, DU_DOTCLKIN2, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'),  8, DU_DOTCLKIN3, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 26, TRST#, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 29, TDI, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 26, TRST#, SH_PFC_PIN_CFG_PULL_UP_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 29, TDI, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 30, TMS, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 27, TCK, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 27, TCK, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 28, TDO, SH_PFC_PIN_CFG_DRIVE_STRENGTH),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 30, ASEBRK, CFG_FLAGS),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 32be7e3..d27a9c7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -14,9 +14,7 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define CFG_FLAGS (SH_PFC_PIN_CFG_DRIVE_STRENGTH | \
-		   SH_PFC_PIN_CFG_PULL_UP | \
-		   SH_PFC_PIN_CFG_PULL_DOWN)
+#define CFG_FLAGS (SH_PFC_PIN_CFG_DRIVE_STRENGTH | SH_PFC_PIN_CFG_PULL_UP_DOWN)
 
 #define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_CFG_16(0, fn, sfx, CFG_FLAGS),	\
@@ -1553,17 +1551,17 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('C'),  5, QSPI0_MOSI_IO0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('C'),  7, QSPI1_MOSI_IO0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 38, FSCLKST#, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 39, EXTALR, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 39, EXTALR, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('E'),  4, QSPI1_IO2, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('E'),  5, QSPI1_MISO_IO1, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('P'),  7, DU_DOTCLKIN0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('P'),  8, DU_DOTCLKIN1, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'),  7, DU_DOTCLKIN2, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'),  8, DU_DOTCLKIN3, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 26, TRST#, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 29, TDI, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 26, TRST#, SH_PFC_PIN_CFG_PULL_UP_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 29, TDI, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 30, TMS, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 27, TCK, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 27, TCK, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 28, TDO, SH_PFC_PIN_CFG_DRIVE_STRENGTH),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 30, ASEBRK, CFG_FLAGS),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index fd9ec59..70b05f2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -19,9 +19,7 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define CFG_FLAGS (SH_PFC_PIN_CFG_DRIVE_STRENGTH | \
-		   SH_PFC_PIN_CFG_PULL_UP | \
-		   SH_PFC_PIN_CFG_PULL_DOWN)
+#define CFG_FLAGS (SH_PFC_PIN_CFG_DRIVE_STRENGTH | SH_PFC_PIN_CFG_PULL_UP_DOWN)
 
 #define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_CFG_16(0, fn, sfx, CFG_FLAGS),	\
@@ -1559,16 +1557,16 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('C'),  5, QSPI0_MOSI_IO0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('C'),  7, QSPI1_MOSI_IO0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 38, FSCLKST, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 39, EXTALR, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 39, EXTALR, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('E'),  4, QSPI1_IO2, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('E'),  5, QSPI1_MISO_IO1, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('P'),  7, DU_DOTCLKIN0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('P'),  8, DU_DOTCLKIN1, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'),  8, DU_DOTCLKIN2, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 26, TRST#, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 29, TDI, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 26, TRST#, SH_PFC_PIN_CFG_PULL_UP_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 29, TDI, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 30, TMS, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 27, TCK, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 27, TCK, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 28, TDO, SH_PFC_PIN_CFG_DRIVE_STRENGTH),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 30, ASEBRK, CFG_FLAGS),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 1ef3960..77661cb 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -17,9 +17,7 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define CFG_FLAGS (SH_PFC_PIN_CFG_DRIVE_STRENGTH | \
-		   SH_PFC_PIN_CFG_PULL_UP | \
-		   SH_PFC_PIN_CFG_PULL_DOWN)
+#define CFG_FLAGS (SH_PFC_PIN_CFG_DRIVE_STRENGTH | SH_PFC_PIN_CFG_PULL_UP_DOWN)
 
 #define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_CFG_16(0, fn, sfx, CFG_FLAGS),	\
@@ -1561,16 +1559,16 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('C'),  5, QSPI0_MOSI_IO0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('C'),  7, QSPI1_MOSI_IO0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 38, FSCLKST, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 39, EXTALR, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('D'), 39, EXTALR, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('E'),  4, QSPI1_IO2, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('E'),  5, QSPI1_MISO_IO1, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('P'),  7, DU_DOTCLKIN0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('P'),  8, DU_DOTCLKIN1, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'),  8, DU_DOTCLKIN2, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 26, TRST#, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 29, TDI, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 26, TRST#, SH_PFC_PIN_CFG_PULL_UP_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 29, TDI, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 30, TMS, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 27, TCK, SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 27, TCK, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 28, TDO, SH_PFC_PIN_CFG_DRIVE_STRENGTH),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 30, ASEBRK, CFG_FLAGS),
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index fadfe22..b654e06 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -16,8 +16,7 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define CFG_FLAGS (SH_PFC_PIN_CFG_PULL_UP | \
-		   SH_PFC_PIN_CFG_PULL_DOWN)
+#define CFG_FLAGS (SH_PFC_PIN_CFG_PULL_UP_DOWN)
 
 #define CPU_ALL_GP(fn, sfx) \
 	PORT_GP_CFG_18(0, fn, sfx, CFG_FLAGS), \
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index b3e1baf..39b86da 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1160,7 +1160,7 @@ static const u16 pinmux_data[] = {
 #define __IO		(SH_PFC_PIN_CFG_INPUT | SH_PFC_PIN_CFG_OUTPUT)
 #define __PD		(SH_PFC_PIN_CFG_PULL_DOWN)
 #define __PU		(SH_PFC_PIN_CFG_PULL_UP)
-#define __PUD		(SH_PFC_PIN_CFG_PULL_DOWN | SH_PFC_PIN_CFG_PULL_UP)
+#define __PUD		(SH_PFC_PIN_CFG_PULL_UP_DOWN)
 
 #define SH73A0_PIN_I_PD(pin)		SH_PFC_PIN_CFG(pin, __I | __PD)
 #define SH73A0_PIN_I_PU(pin)		SH_PFC_PIN_CFG(pin, __I | __PU)
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 654dc20..d0f56ed 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -570,8 +570,7 @@ static bool sh_pfc_pinconf_validate(struct sh_pfc *pfc, unsigned int _pin,
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		return pin->configs &
-			(SH_PFC_PIN_CFG_PULL_UP | SH_PFC_PIN_CFG_PULL_DOWN);
+		return pin->configs & SH_PFC_PIN_CFG_PULL_UP_DOWN;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
 		return pin->configs & SH_PFC_PIN_CFG_PULL_UP;
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 2ee4c79..22df2e2 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -28,6 +28,8 @@ enum {
 #define SH_PFC_PIN_CFG_OUTPUT		(1 << 1)
 #define SH_PFC_PIN_CFG_PULL_UP		(1 << 2)
 #define SH_PFC_PIN_CFG_PULL_DOWN	(1 << 3)
+#define SH_PFC_PIN_CFG_PULL_UP_DOWN	(SH_PFC_PIN_CFG_PULL_UP | \
+					 SH_PFC_PIN_CFG_PULL_DOWN)
 #define SH_PFC_PIN_CFG_IO_VOLTAGE	(1 << 4)
 #define SH_PFC_PIN_CFG_DRIVE_STRENGTH	(1 << 5)
 #define SH_PFC_PIN_CFG_NO_GPIO		(1 << 31)
-- 
2.7.4
