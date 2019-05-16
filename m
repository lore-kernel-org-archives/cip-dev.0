From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:33 +0100
Subject: [cip-dev] [PATCH v2 21/52] gpio: rcar: Implement
	gpiochip.set_multiple()
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-22-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit dbb763b8ea5d8eb0ce3e45e289969f6f1f418921 upstream.

This allows to set multiple outputs using a single register write.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* No change
---
 drivers/gpio/gpio-rcar.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index c0fd5a5..411e93b 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -349,6 +349,25 @@ static void gpio_rcar_set(struct gpio_chip *chip, unsigned offset, int value)
 	spin_unlock_irqrestore(&p->lock, flags);
 }
 
+static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
+				   unsigned long *bits)
+{
+	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
+	unsigned long flags;
+	u32 val, bankmask;
+
+	bankmask = mask[0] & GENMASK(chip->ngpio - 1, 0);
+	if (!bankmask)
+		return;
+
+	spin_lock_irqsave(&p->lock, flags);
+	val = gpio_rcar_read(p, OUTDT);
+	val &= ~bankmask;
+	val |= (bankmask & bits[0]);
+	gpio_rcar_write(p, OUTDT, val);
+	spin_unlock_irqrestore(&p->lock, flags);
+}
+
 static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
 				      int value)
 {
@@ -500,6 +519,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	gpio_chip->get = gpio_rcar_get;
 	gpio_chip->direction_output = gpio_rcar_direction_output;
 	gpio_chip->set = gpio_rcar_set;
+	gpio_chip->set_multiple = gpio_rcar_set_multiple;
 	gpio_chip->label = name;
 	gpio_chip->dev = dev;
 	gpio_chip->owner = THIS_MODULE;
-- 
2.7.4
