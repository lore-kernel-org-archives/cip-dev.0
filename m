From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:15 +0200
Subject: [cip-dev] [PATCH 18/25] gpio: exar: Allocate resources on behalf of
	the platform device
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <63c276f06a8c9d4e4ea4c93efe427037fd2cd92d.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 5dab5872e59390aa9cca26ee629b95f7179f6c77 upstream.

Do not allocate resources on behalf of the parent device but on our own.
Otherwise, cleanup does not properly work if gpio-exar is removed but
not the parent device.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-exar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index f956b8fd67ca..01f60ac86430 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -139,7 +139,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	if (!p)
 		return -ENOMEM;
 
-	exar_gpio = devm_kzalloc(&pcidev->dev, sizeof(*exar_gpio), GFP_KERNEL);
+	exar_gpio = devm_kzalloc(&pdev->dev, sizeof(*exar_gpio), GFP_KERNEL);
 	if (!exar_gpio)
 		return -ENOMEM;
 
@@ -160,7 +160,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	exar_gpio->regs = p;
 	exar_gpio->index = index;
 
-	ret = devm_gpiochip_add_data(&pcidev->dev,
+	ret = devm_gpiochip_add_data(&pdev->dev,
 				     &exar_gpio->gpio_chip, exar_gpio);
 	if (ret)
 		goto err_destroy;
-- 
2.12.3
