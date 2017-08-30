From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:13 +0200
Subject: [cip-dev] [PATCH 16/25] gpio: exar: Set proper output level in
	exar_direction_output
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <e22647dc53be3355c29b0cfd2e7bba2cb7cb1e7a.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Axel Lin <axel.lin@ingics.com>

commit eddeae073760aa3186e2fa0d14a12794687fa786 upstream.

Current code does not set output level in exar_direction_output, fix it.
Also move the direction_output/direction_input code block to avoid forward
declaration for exar_set_value().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-exar.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 4fd6aea59c75..866302332373 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -59,17 +59,6 @@ static int exar_set_direction(struct gpio_chip *chip, int direction,
 	return 0;
 }
 
-static int exar_direction_output(struct gpio_chip *chip, unsigned int offset,
-				 int value)
-{
-	return exar_set_direction(chip, 0, offset);
-}
-
-static int exar_direction_input(struct gpio_chip *chip, unsigned int offset)
-{
-	return exar_set_direction(chip, 1, offset);
-}
-
 static int exar_get(struct gpio_chip *chip, unsigned int reg)
 {
 	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
@@ -116,6 +105,18 @@ static void exar_set_value(struct gpio_chip *chip, unsigned int offset,
 	exar_update(chip, addr, value, offset % 8);
 }
 
+static int exar_direction_output(struct gpio_chip *chip, unsigned int offset,
+				 int value)
+{
+	exar_set_value(chip, offset, value);
+	return exar_set_direction(chip, 0, offset);
+}
+
+static int exar_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	return exar_set_direction(chip, 1, offset);
+}
+
 static int gpio_exar_probe(struct platform_device *pdev)
 {
 	struct pci_dev *pcidev = platform_get_drvdata(pdev);
-- 
2.12.3
