From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:30 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 03/41] pinctrl: sh-pfc: Add
	physical pin multiplexing helper macros
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Ulrich Hecht <uli+renesas@fpond.eu>

commit 50d1ba1764b3e00ae8c331202d50c5535d6b3361 upstream.

Used by I2C controllers 0, 3 and 5 in R8A7795 and R8A7796 SoCs.

Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 7f31300..8a06ebc 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -389,6 +389,28 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
 	PINMUX_DATA(fn##_MARK, FN_##msel, FN_##fn, FN_##ipsr)
 
 /*
+ * Describe a pinmux configuration similar to PINMUX_IPSR_MSEL, but with
+ * an additional select register that controls physical multiplexing
+ * with another pin.
+ *   - ipsr: IPSR field
+ *   - fn: Function name, also referring to the IPSR field
+ *   - psel: Physical multiplexing selector
+ *   - msel: Module selector
+ */
+#define PINMUX_IPSR_PHYS_MSEL(ipsr, fn, psel, msel) \
+	PINMUX_DATA(fn##_MARK, FN_##psel, FN_##msel, FN_##fn, FN_##ipsr)
+
+/*
+ * Describe a pinmux configuration in which a pin is physically multiplexed
+ * with other pins.
+ *   - ipsr: IPSR field
+ *   - fn: Function name, also referring to the IPSR field
+ *   - psel: Physical multiplexing selector
+ */
+#define PINMUX_IPSR_PHYS(ipsr, fn, psel) \
+	PINMUX_DATA(fn##_MARK, FN_##psel)
+
+/*
  * Describe a pinmux configuration for a single-function pin with GPIO
  * capability.
  *   - fn: Function name
-- 
2.7.4
