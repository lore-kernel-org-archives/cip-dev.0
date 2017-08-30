From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 20:52:33 +0200
Subject: [cip-dev] [PATCH 6/8] pwm: pca9685: Allow any of the 16 PWMs to be
	used as a GPIO
In-Reply-To: <cover.1504119155.git.jan.kiszka@siemens.com>
References: <cover.1504119155.git.jan.kiszka@siemens.com>
Message-ID: <5073132a570210d4f5c2790ccae6e18d285dfcca.1504119155.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit bccec89f0a35f65302734d1cdb01479df0f33ac9 upstream.

The PCA9685 controller has full on/off bit for each PWM channel. Setting
this bit bypasses the PWM control and the line works just as it would be a
GPIO. Furthermore in Intel Galileo it is actually used as GPIO output for
discreet muxes on the board.

This patch adds GPIO output only support for the driver so that we can
control the muxes on Galileo using standard GPIO interfaces available in
the kernel. GPIO and PWM functionality is exclusive so only one can be
active at a time on a single PWM channel.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
[Jan: adjusted gpio.parent to .dev for 4.4]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pwm/pwm-pca9685.c | 164 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 01a6a83f625d..cad6cdf06d03 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -20,8 +20,10 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/pwm.h>
@@ -80,6 +82,10 @@ struct pca9685 {
 	int active_cnt;
 	int duty_ns;
 	int period_ns;
+#if IS_ENABLED(CONFIG_GPIOLIB)
+	struct mutex lock;
+	struct gpio_chip gpio;
+#endif
 };
 
 static inline struct pca9685 *to_pca(struct pwm_chip *chip)
@@ -87,6 +93,151 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
 	return container_of(chip, struct pca9685, chip);
 }
 
+#if IS_ENABLED(CONFIG_GPIOLIB)
+static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
+{
+	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_device *pwm;
+
+	mutex_lock(&pca->lock);
+
+	pwm = &pca->chip.pwms[offset];
+
+	if (pwm->flags & (PWMF_REQUESTED | PWMF_EXPORTED)) {
+		mutex_unlock(&pca->lock);
+		return -EBUSY;
+	}
+
+	pwm_set_chip_data(pwm, (void *)1);
+
+	mutex_unlock(&pca->lock);
+	return 0;
+}
+
+static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
+{
+	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_device *pwm;
+
+	mutex_lock(&pca->lock);
+	pwm = &pca->chip.pwms[offset];
+	pwm_set_chip_data(pwm, NULL);
+	mutex_unlock(&pca->lock);
+}
+
+static bool pca9685_pwm_is_gpio(struct pca9685 *pca, struct pwm_device *pwm)
+{
+	bool is_gpio = false;
+
+	mutex_lock(&pca->lock);
+
+	if (pwm->hwpwm >= PCA9685_MAXCHAN) {
+		unsigned int i;
+
+		/*
+		 * Check if any of the GPIOs are requested and in that case
+		 * prevent using the "all LEDs" channel.
+		 */
+		for (i = 0; i < pca->gpio.ngpio; i++)
+			if (gpiochip_is_requested(&pca->gpio, i)) {
+				is_gpio = true;
+				break;
+			}
+	} else if (pwm_get_chip_data(pwm)) {
+		is_gpio = true;
+	}
+
+	mutex_unlock(&pca->lock);
+	return is_gpio;
+}
+
+static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
+{
+	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_device *pwm = &pca->chip.pwms[offset];
+	unsigned int value;
+
+	regmap_read(pca->regmap, LED_N_ON_H(pwm->hwpwm), &value);
+
+	return value & LED_FULL;
+}
+
+static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
+				 int value)
+{
+	struct pca9685 *pca = gpiochip_get_data(gpio);
+	struct pwm_device *pwm = &pca->chip.pwms[offset];
+	unsigned int on = value ? LED_FULL : 0;
+
+	/* Clear both OFF registers */
+	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0);
+	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0);
+
+	/* Set the full ON bit */
+	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), on);
+}
+
+static int pca9685_pwm_gpio_get_direction(struct gpio_chip *chip,
+					  unsigned int offset)
+{
+	/* Always out */
+	return 0;
+}
+
+static int pca9685_pwm_gpio_direction_input(struct gpio_chip *gpio,
+					    unsigned int offset)
+{
+	return -EINVAL;
+}
+
+static int pca9685_pwm_gpio_direction_output(struct gpio_chip *gpio,
+					     unsigned int offset, int value)
+{
+	pca9685_pwm_gpio_set(gpio, offset, value);
+
+	return 0;
+}
+
+/*
+ * The PCA9685 has a bit for turning the PWM output full off or on. Some
+ * boards like Intel Galileo actually uses these as normal GPIOs so we
+ * expose a GPIO chip here which can exclusively take over the underlying
+ * PWM channel.
+ */
+static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
+{
+	struct device *dev = pca->chip.dev;
+
+	mutex_init(&pca->lock);
+
+	pca->gpio.label = dev_name(dev);
+	pca->gpio.dev = dev;
+	pca->gpio.request = pca9685_pwm_gpio_request;
+	pca->gpio.free = pca9685_pwm_gpio_free;
+	pca->gpio.get_direction = pca9685_pwm_gpio_get_direction;
+	pca->gpio.direction_input = pca9685_pwm_gpio_direction_input;
+	pca->gpio.direction_output = pca9685_pwm_gpio_direction_output;
+	pca->gpio.get = pca9685_pwm_gpio_get;
+	pca->gpio.set = pca9685_pwm_gpio_set;
+	pca->gpio.base = -1;
+	pca->gpio.ngpio = PCA9685_MAXCHAN;
+	pca->gpio.can_sleep = true;
+
+	return devm_gpiochip_add_data(dev, &pca->gpio, pca);
+}
+#else
+static inline bool pca9685_pwm_is_gpio(struct pca9685 *pca,
+				       struct pwm_device *pwm)
+{
+	return false;
+}
+
+static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
+{
+	return 0;
+}
+#endif
+
 static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			      int duty_ns, int period_ns)
 {
@@ -253,6 +404,9 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
+	if (pca9685_pwm_is_gpio(pca, pwm))
+		return -EBUSY;
+
 	if (pca->active_cnt++ == 0)
 		return regmap_update_bits(pca->regmap, PCA9685_MODE1,
 					  MODE1_SLEEP, 0x0);
@@ -334,7 +488,15 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	pca->chip.base = -1;
 	pca->chip.can_sleep = true;
 
-	return pwmchip_add(&pca->chip);
+	ret = pwmchip_add(&pca->chip);
+	if (ret < 0)
+		return ret;
+
+	ret = pca9685_pwm_gpio_probe(pca);
+	if (ret < 0)
+		pwmchip_remove(&pca->chip);
+
+	return ret;
 }
 
 static int pca9685_pwm_remove(struct i2c_client *client)
-- 
2.12.3
