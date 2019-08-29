From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:18 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 13/51] pinctrl: sh-pfc: Rename
	2-parameter CPU_ALL_PORT() variant
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-14-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit bd79c92039f117a3e448b9ef042595497a5218a6 upstream.

There are two variants of the CPU_ALL_PORT() macro in use:
  1. A three-parameter variant, to be provided for SoCs with a linear
     GPIO pin space ("PORT style"),
  2. A two-parameter variant, to be provided for SoCs with 32-port GPIO
     banks ("GP port style").

Rename the 2-parameter variant to CPU_ALL_GP(), to avoid confusion, and
to increase naming consistency.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c    | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c     | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c     | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c     | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c     | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c     | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c     | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7734.c      | 2 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h          | 6 +++---
 17 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index aeada74..cb4c907 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -9,7 +9,7 @@
 
 #include "sh_pfc.h"
 
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_23(0, fn, sfx),						\
 	PORT_GP_23(1, fn, sfx),						\
 	PORT_GP_32(2, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 7f1c675..22700cd 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -46,7 +46,7 @@
 	PORT_GP_PUP_1(bank, 24, fn, sfx), PORT_GP_PUP_1(bank, 25, fn, sfx),	\
 	PORT_GP_PUP_1(bank, 26, fn, sfx)
 
-#define CPU_ALL_PORT(fn, sfx)		\
+#define CPU_ALL_GP(fn, sfx)		\
 	PORT_GP_CFG_32(0, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
 	PORT_GP_CFG_32(1, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
 	PORT_GP_CFG_32(2, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 70aa490..00c1eec 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -23,7 +23,7 @@
 
 #include "sh_pfc.h"
 
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_32(1, fn, sfx),						\
 	PORT_GP_32(2, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 8046469..d2fd6e87 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -30,7 +30,7 @@
  * All pins assigned to GPIO bank 3 can be used for SD interfaces in
  * which case they support both 3.3V and 1.8V signalling.
  */
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_30(1, fn, sfx),						\
 	PORT_GP_30(2, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index c771a5c..332cb96 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -17,7 +17,7 @@
  * Pins 0-23 assigned to GPIO bank 6 can be used for SD interfaces in
  * which case they support both 3.3V and 1.8V signalling.
  */
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_26(1, fn, sfx),						\
 	PORT_GP_32(2, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7792.c b/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
index f49da5d..1131dd6 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
@@ -14,7 +14,7 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_29(0, fn, sfx),						\
 	PORT_GP_23(1, fn, sfx),						\
 	PORT_GP_32(2, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 47a4772..7b8dfee 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -15,7 +15,7 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_26(1, fn, sfx),						\
 	PORT_GP_32(2, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index 63e406d..087c2b3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -17,7 +17,7 @@
 		   SH_PFC_PIN_CFG_PULL_UP | \
 		   SH_PFC_PIN_CFG_PULL_DOWN)
 
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_CFG_16(0, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_28(1, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_15(2, fn, sfx, CFG_FLAGS),	\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 00081c3..32be7e3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -18,7 +18,7 @@
 		   SH_PFC_PIN_CFG_PULL_UP | \
 		   SH_PFC_PIN_CFG_PULL_DOWN)
 
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_CFG_16(0, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_29(1, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_15(2, fn, sfx, CFG_FLAGS),	\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index fcde6ce..fd9ec59 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -23,7 +23,7 @@
 		   SH_PFC_PIN_CFG_PULL_UP | \
 		   SH_PFC_PIN_CFG_PULL_DOWN)
 
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_CFG_16(0, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_29(1, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_15(2, fn, sfx, CFG_FLAGS),	\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 08c6635..1ef3960 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -21,7 +21,7 @@
 		   SH_PFC_PIN_CFG_PULL_UP | \
 		   SH_PFC_PIN_CFG_PULL_DOWN)
 
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_CFG_16(0, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_29(1, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_15(2, fn, sfx, CFG_FLAGS),	\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
index 42538ab..ed08cce 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
@@ -21,7 +21,7 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_CFG_22(0, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE),		\
 	PORT_GP_28(1, fn, sfx),						\
 	PORT_GP_CFG_17(2, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE),		\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
index 629fa0c..246ab41 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
@@ -18,7 +18,7 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define CPU_ALL_PORT(fn, sfx)	\
+#define CPU_ALL_GP(fn, sfx)	\
 	PORT_GP_CFG_22(0, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE),	\
 	PORT_GP_28(1, fn, sfx),	\
 	PORT_GP_CFG_30(2, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE),	\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 7b64da2..fadfe22 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -19,7 +19,7 @@
 #define CFG_FLAGS (SH_PFC_PIN_CFG_PULL_UP | \
 		   SH_PFC_PIN_CFG_PULL_DOWN)
 
-#define CPU_ALL_PORT(fn, sfx) \
+#define CPU_ALL_GP(fn, sfx) \
 	PORT_GP_CFG_18(0, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_23(1, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_26(2, fn, sfx, CFG_FLAGS), \
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index 06babec..a4d7f20 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -19,7 +19,7 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define CPU_ALL_PORT(fn, sfx)			\
+#define CPU_ALL_GP(fn, sfx)			\
 		PORT_GP_9(0,  fn, sfx),		\
 		PORT_GP_32(1, fn, sfx),		\
 		PORT_GP_32(2, fn, sfx),		\
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index dd5c0f4..b7c07f5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -14,7 +14,7 @@
 
 #include "sh_pfc.h"
 
-#define CPU_ALL_PORT(fn, sfx)						\
+#define CPU_ALL_GP(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_32(1, fn, sfx),						\
 	PORT_GP_32(2, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index f47a159..2ee4c79 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -586,7 +586,7 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
 
 /* GP_ALL(suffix) - Expand to a list of GP_#_#_suffix */
 #define _GP_ALL(bank, pin, name, sfx, cfg)	name##_##sfx
-#define GP_ALL(str)			CPU_ALL_PORT(_GP_ALL, str)
+#define GP_ALL(str)			CPU_ALL_GP(_GP_ALL, str)
 
 /* PINMUX_GPIO_GP_ALL - Expand to a list of sh_pfc_pin entries */
 #define _GP_GPIO(bank, _pin, _name, sfx, cfg)				\
@@ -596,11 +596,11 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
 		.enum_id = _name##_DATA,				\
 		.configs = cfg,						\
 	}
-#define PINMUX_GPIO_GP_ALL()		CPU_ALL_PORT(_GP_GPIO, unused)
+#define PINMUX_GPIO_GP_ALL()		CPU_ALL_GP(_GP_GPIO, unused)
 
 /* PINMUX_DATA_GP_ALL -  Expand to a list of name_DATA, name_FN marks */
 #define _GP_DATA(bank, pin, name, sfx, cfg)	PINMUX_DATA(name##_DATA, name##_FN)
-#define PINMUX_DATA_GP_ALL()		CPU_ALL_PORT(_GP_DATA, unused)
+#define PINMUX_DATA_GP_ALL()		CPU_ALL_GP(_GP_DATA, unused)
 
 /*
  * PORT style (linear pin space)
-- 
2.7.4
