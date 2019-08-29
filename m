From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:20 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 15/51] pinctrl: sh-pfc: Add new
	non-GPIO helper macros
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-16-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 4818f448986dd8d0e28b648be5f99c3f29abe6bf upstream.

Add new macros for describing pins without GPIO functionality:
  - NOGP_ALL() expands to a list of PIN_id values, to be used for
    generating symbolic enum values,
  - PINMUX_NOGP_ALL() expands to a list of sh_pfc_pin entries, to
    list all pins and their capabilities.
Both macros depend on an SoC-specific CPU_ALL_NOGP() macro, to be
provided by each individual SoC pin control driver.

The new macros offer two advantages over the existing SH_PFC_PIN_NAMED()
and SH_PFC_PIN_NAMED_CFG() macros:
  1. They do not rely on PIN_NUMBER() macros and physical pin numbering,
     hence do not suffer from pin numbering confusion among different
     SoC/SiP packages.
  2. They are similar in spirit to the existing scheme for handling pins
     with GPIO functionality.

Note that internal to the driver, non-GPIO pins use a sequential
numbering scheme which starts after the highest GPIO pin number in use.
This value is calculated automatically, using two new helper macros, for
systems with either 32-port bank (GP port style) or linear (PORT style)
pin space.  Sample expansion:

    GP_LAST = sizeof(union {
	char dummy[0] __attribute__((deprecated, deprecated));
	char GP_0_0[(0 * 32) + 0] __attribute__((deprecated, deprecated));
	char GP_0_1[(0 * 32) + 1] __attribute__((deprecated, deprecated));
	...
	char GP_7_3[(7 * 32) + 3] __attribute__((deprecated, deprecated));
    })

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 22df2e2..3c4b2ac 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -605,6 +605,24 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
 #define PINMUX_DATA_GP_ALL()		CPU_ALL_GP(_GP_DATA, unused)
 
 /*
+ * GP_ASSIGN_LAST() - Expand to an enum definition for the last GP pin
+ *
+ * The largest GP pin index is obtained by taking the size of a union,
+ * containing one array per GP pin, sized by the corresponding pin index.
+ * As the fields in the CPU_ALL_GP() macro definition are separated by commas,
+ * while the members of a union must be terminated by semicolons, the commas
+ * are absorbed by wrapping them inside dummy attributes.
+ */
+#define _GP_ENTRY(bank, pin, name, sfx, cfg)				\
+	deprecated)); char name[(bank * 32) + pin] __attribute__((deprecated
+#define GP_ASSIGN_LAST()						\
+	GP_LAST = sizeof(union {					\
+		char dummy[0] __attribute__((deprecated,		\
+		CPU_ALL_GP(_GP_ENTRY, unused),				\
+		deprecated));						\
+	})
+
+/*
  * PORT style (linear pin space)
  */
 
@@ -669,6 +687,24 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
 		    PORT##pfx##_OUT, PORT##pfx##_IN)
 #define PINMUX_DATA_ALL()		CPU_ALL_PORT(_PORT_DATA, , unused)
 
+/*
+ * PORT_ASSIGN_LAST() - Expand to an enum definition for the last PORT pin
+ *
+ * The largest PORT pin index is obtained by taking the size of a union,
+ * containing one array per PORT pin, sized by the corresponding pin index.
+ * As the fields in the CPU_ALL_PORT() macro definition are separated by
+ * commas, while the members of a union must be terminated by semicolons, the
+ * commas are absorbed by wrapping them inside dummy attributes.
+ */
+#define _PORT_ENTRY(pn, pfx, sfx)					\
+	deprecated)); char pfx[pn] __attribute__((deprecated
+#define PORT_ASSIGN_LAST()						\
+	PORT_LAST = sizeof(union {					\
+		char dummy[0] __attribute__((deprecated,		\
+		CPU_ALL_PORT(_PORT_ENTRY, PORT, unused),		\
+		deprecated));						\
+	})
+
 /* GPIO_FN(name) - Expand to a sh_pfc_pin entry for a function GPIO */
 #define PINMUX_GPIO_FN(gpio, base, data_or_mark)			\
 	[gpio - (base)] = {						\
@@ -679,6 +715,26 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
 	PINMUX_GPIO_FN(GPIO_FN_##str, PINMUX_FN_BASE, str##_MARK)
 
 /*
+ * Pins not associated with a GPIO port
+ */
+
+#define PIN_NOGP_CFG(pin, name, fn, cfg)	fn(pin, name, cfg)
+#define PIN_NOGP(pin, name, fn)			fn(pin, name, 0)
+
+/* NOGP_ALL - Expand to a list of PIN_id */
+#define _NOGP_ALL(pin, name, cfg)		PIN_##pin
+#define NOGP_ALL()				CPU_ALL_NOGP(_NOGP_ALL)
+
+/* PINMUX_NOGP_ALL - Expand to a list of sh_pfc_pin entries */
+#define _NOGP_PINMUX(_pin, _name, cfg)					\
+	{								\
+		.pin = PIN_##_pin,					\
+		.name = "PIN_" _name,					\
+		.configs = SH_PFC_PIN_CFG_NO_GPIO | cfg,		\
+	}
+#define PINMUX_NOGP_ALL()		CPU_ALL_NOGP(_NOGP_PINMUX)
+
+/*
  * PORTnCR helper macro for SH-Mobile/R-Mobile
  */
 #define PORTCR(nr, reg)							\
-- 
2.7.4
