From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:30 +0100
Subject: [cip-dev] [PATCH v2 18/52] gpiolib: Extract mask allocation into
	subroutine
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-19-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Stephen Boyd <swboyd@chromium.org>

commit e4371f6e079294369ecb4cfa03aaeb60831e8b91 upstream.

We're going to use similar code to allocate and set all the bits in a
mask for valid gpios to use. Extract the code from the irqchip version
so it can be reused.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Timur Tabi <timur@codeaurora.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[fab: removed change from function gpiochip_irqchip_init_valid_mask,
reworked return from gpiochip_allocate_mask]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* Reworked return from gpiochip_allocate_mask according to Pavel's
  comment
---
 drivers/gpio/gpiolib.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 827510d..adb4740 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -279,6 +279,19 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
 	return 0;
 }
 
+static unsigned long *gpiochip_allocate_mask(struct gpio_chip *chip)
+{
+	unsigned long *p;
+
+	p = kcalloc(BITS_TO_LONGS(chip->ngpio), sizeof(long), GFP_KERNEL);
+
+	if (p)
+		/* Assume by default all GPIOs are valid */
+		bitmap_fill(p, chip->ngpio);
+
+	return p;
+}
+
 /**
  * gpiochip_add_data() - register a gpio_chip
  * @chip: the chip to register, with chip->base initialized
-- 
2.7.4
