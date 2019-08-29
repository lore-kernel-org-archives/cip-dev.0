From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:56 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 51/51] pinctrl: sh-pfc: sh73a0:
	Use new macros for non-GPIO pins
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-52-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 25491559322e435c47731fd65f0dd9fb88a0b213 upstream.

Update the SH-Mobile AG5 pin control driver to use the new macros for
describing pins without GPIO functionality.  This replaces the use of
physical pin numbers on the SH-Mobile AG5 SoC (in 34x34 BGA package) by
symbolic enum values, referring to signal names.

Note that the user-visible names of these pins are still based on pin
numbers instead of signal names, to preserve DT backwards compatibility.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 1adb234..a748af3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -56,6 +56,9 @@
 	PORT_1(288, fn, pfx##288, sfx), PORT_1(289, fn, pfx##289, sfx),	\
 	PORT_10(290, fn, pfx##29, sfx), PORT_10(300, fn, pfx##30, sfx)
 
+#define CPU_ALL_NOGP(fn)	\
+	PIN_NOGP(A11, "F26", fn)
+
 enum {
 	PINMUX_RESERVED = 0,
 
@@ -1171,11 +1174,13 @@ static const u16 pinmux_data[] = {
 #define SH73A0_PIN_IO_PU_PD(pin)	SH_PFC_PIN_CFG(pin, __IO | __PUD)
 #define SH73A0_PIN_O(pin)		SH_PFC_PIN_CFG(pin, __O)
 
-/* Pin numbers for pins without a corresponding GPIO port number are computed
- * from the row and column numbers with a 1000 offset to avoid collisions with
- * GPIO port numbers.
+/*
+ * Pins not associated with a GPIO port.
  */
-#define PIN_NUMBER(row, col)		(1000+((row)-1)*34+(col)-1)
+enum {
+	PORT_ASSIGN_LAST(),
+	NOGP_ALL(),
+};
 
 static const struct sh_pfc_pin pinmux_pins[] = {
 	/* Table 25-1 (I/O and Pull U/D) */
@@ -1450,7 +1455,7 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	SH73A0_PIN_O(309),
 
 	/* Pins not associated with a GPIO port */
-	SH_PFC_PIN_NAMED(6, 26, F26),
+	PINMUX_NOGP_ALL(),
 };
 
 /* - BSC -------------------------------------------------------------------- */
@@ -1876,7 +1881,7 @@ static const unsigned int keysc_out7_2_mux[] = {
 };
 static const unsigned int keysc_out8_0_pins[] = {
 	/* KEYOUT8 */
-	PIN_NUMBER(6, 26),
+	PIN_A11,
 };
 static const unsigned int keysc_out8_0_mux[] = {
 	KEYOUT8_MARK,
@@ -3086,7 +3091,7 @@ static const unsigned int tpu4_to2_mux[] = {
 };
 static const unsigned int tpu4_to3_pins[] = {
 	/* TO */
-	PIN_NUMBER(6, 26),
+	PIN_A11,
 };
 static const unsigned int tpu4_to3_mux[] = {
 	TPU4TO3_MARK,
-- 
2.7.4
