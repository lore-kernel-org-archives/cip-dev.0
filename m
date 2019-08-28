From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:02:43 +0100
Subject: [cip-dev] [PATCH 4.19.y 12/60] gpio: rcar: select General Output
	Register to set output states
In-Reply-To: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566990211-24785-13-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

commit 3ae4f3aac05ab9cc7d93ef3e87bb0bd159cb6bfa upstream.

R-Car GPIO controller provides two interfaces to set GPIO line output
signal state, and for a particular GPIO line the selected interface is
determined by OUTDTSEL bit value.

At the moment the driver supports only one of two interfaces, namely
OUTDT General Output Register is used to control the output signal.

While this selection is the default one on reset, it is not explicitly
configured on probe, thus it might be possible that kernel and userspace
consumers of a GPIO won't be able to set the wanted GPIO output signal.

Below is a simple test case to reproduce the described problem and
verify this fix in the kernel on H3 ULCB by setting non-default OUTDTSEL
configuration from a bootloader:

  u-boot    > mw.l 0xe6055440 0x3000 1
  ...
  userspace > echo default-on > /sys/devices/platform/leds/leds/led5/trigger
  userspace > echo default-on > /sys/devices/platform/leds/leds/led6/trigger

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpio/gpio-rcar.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 3aad2b5..74489c1 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -48,6 +48,7 @@ struct gpio_rcar_priv {
 	struct irq_chip irq_chip;
 	unsigned int irq_parent;
 	atomic_t wakeup_path;
+	bool has_outdtsel;
 	bool has_both_edge_trigger;
 	struct gpio_rcar_bank_info bank_info;
 };
@@ -63,6 +64,7 @@ struct gpio_rcar_priv {
 #define POSNEG 0x20	/* Positive/Negative Logic Select Register */
 #define EDGLEVEL 0x24	/* Edge/level Select Register */
 #define FILONOFF 0x28	/* Chattering Prevention On/Off Register */
+#define OUTDTSEL 0x40	/* Output Data Select Register */
 #define BOTHEDGE 0x4c	/* One Edge/Both Edge Select Register */
 
 #define RCAR_MAX_GPIO_PER_BANK		32
@@ -243,6 +245,10 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	/* Select Input Mode or Output Mode in INOUTSEL */
 	gpio_rcar_modify_bit(p, INOUTSEL, gpio, output);
 
+	/* Select General Output Register to output data in OUTDTSEL */
+	if (p->has_outdtsel && output)
+		gpio_rcar_modify_bit(p, OUTDTSEL, gpio, false);
+
 	spin_unlock_irqrestore(&p->lock, flags);
 }
 
@@ -341,14 +347,17 @@ static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
 }
 
 struct gpio_rcar_info {
+	bool has_outdtsel;
 	bool has_both_edge_trigger;
 };
 
 static const struct gpio_rcar_info gpio_rcar_info_gen1 = {
+	.has_outdtsel = false,
 	.has_both_edge_trigger = false,
 };
 
 static const struct gpio_rcar_info gpio_rcar_info_gen2 = {
+	.has_outdtsel = true,
 	.has_both_edge_trigger = true,
 };
 
@@ -408,10 +417,11 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
 	int ret;
 
 	info = of_device_get_match_data(p->dev);
+	p->has_outdtsel = info->has_outdtsel;
+	p->has_both_edge_trigger = info->has_both_edge_trigger;
 
 	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
 	*npins = ret == 0 ? args.args[2] : RCAR_MAX_GPIO_PER_BANK;
-	p->has_both_edge_trigger = info->has_both_edge_trigger;
 
 	if (*npins == 0 || *npins > RCAR_MAX_GPIO_PER_BANK) {
 		dev_warn(p->dev, "Invalid number of gpio lines %u, using %u\n",
-- 
2.7.4
