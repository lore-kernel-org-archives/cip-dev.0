From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  8 Nov 2019 16:36:48 +0000
Subject: [cip-dev] [RFT/RFC linux-4.4.y-cip] gpiolib: Fix bad of_node pointer
Message-ID: <1573231008-24239-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Not every driver initialises of_node from struct gpio_chip,
therefore the replacement of of_node from struct gpio_chip
with dev->of_node in the below commit won't work on every
platform:
baff4777cdb8 ("gpiolib: Support 'gpio-reserved-ranges' property")
The final result is that on some platforms the kernel will
try to dereference a NULL pointer, with obvious consequences.

This patch makes sure the pointer gets initialised before its
first usage.

Fixes: baff4777cdb8 ("gpiolib: Support 'gpio-reserved-ranges' property")
Reported-by: Johnson CH Chen <JohnsonCH.Chen@moxa.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---

Hi Johnson,

could you please test this patch on your system?

Thanks,
Fab


 drivers/gpio/gpiolib-of.c | 4 +++-
 drivers/gpio/gpiolib.c    | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ec642bf..36b60dd 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -338,7 +338,7 @@ static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
 {
 	int len, i;
 	u32 start, count;
-	struct device_node *np = chip->dev->of_node;
+	struct device_node *np = chip->of_node;
 
 	len = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
 	if (len < 0 || len % 2 != 0)
@@ -445,8 +445,10 @@ int of_gpiochip_add(struct gpio_chip *chip)
 {
 	int status;
 
+	/*
 	if ((!chip->of_node) && (chip->dev))
 		chip->of_node = chip->dev->of_node;
+	*/
 
 	if (!chip->of_node)
 		return 0;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d72218f..0fd443a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -296,7 +296,7 @@ static int gpiochip_init_valid_mask(struct gpio_chip *gpiochip)
 {
 #ifdef CONFIG_OF_GPIO
 	int size;
-	struct device_node *np = gpiochip->dev->of_node;
+	struct device_node *np = gpiochip->of_node;
 
 	size = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
 	if (size > 0 && size % 2 == 0)
@@ -354,12 +354,16 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
 	int		base = chip->base;
 	struct gpio_desc *descs;
 
+
 	descs = kcalloc(chip->ngpio, sizeof(descs[0]), GFP_KERNEL);
 	if (!descs)
 		return -ENOMEM;
 
 	chip->data = data;
 
+	if ((!chip->of_node) && (chip->dev))
+		chip->of_node = chip->dev->of_node;
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	if (base < 0) {
-- 
2.7.4
