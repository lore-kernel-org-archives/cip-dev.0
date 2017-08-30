From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:16 +0200
Subject: [cip-dev] [PATCH 19/25] gpio: exar: Fix reading of directions and
	values
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <948d8f26221894a285d503991baa3fb1ce761612.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 7f45a875da46a112f781c25cfa9bcb93aaed4712 upstream.

First, the logic for translating a register bit to the return code of
exar_get_direction and exar_get_value were wrong. And second, there was
a flip regarding the register bank in exar_get_direction.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-exar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 01f60ac86430..5e0f16738e26 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -68,7 +68,7 @@ static int exar_get(struct gpio_chip *chip, unsigned int reg)
 	value = readb(exar_gpio->regs + reg);
 	mutex_unlock(&exar_gpio->lock);
 
-	return !!value;
+	return value;
 }
 
 static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -78,7 +78,7 @@ static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
 	int val;
 
 	addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
-	val = exar_get(chip, addr) >> (offset % 8);
+	val = exar_get(chip, addr) & BIT(offset % 8);
 
 	return !!val;
 }
@@ -89,8 +89,8 @@ static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
 	unsigned int addr;
 	int val;
 
-	addr = bank ? EXAR_OFFSET_MPIOLVL_LO : EXAR_OFFSET_MPIOLVL_HI;
-	val = exar_get(chip, addr) >> (offset % 8);
+	addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
+	val = exar_get(chip, addr) & BIT(offset % 8);
 
 	return !!val;
 }
-- 
2.12.3
