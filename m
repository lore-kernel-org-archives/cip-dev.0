From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:32:00 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 13/57] gpio: rcar: Pedantic
	formatting
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-14-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: "Enrico Weigelt, metux IT consult" <info@metux.net>

commit b183cab7fdf79843f79398af139e02186692c6c7 upstream.

A tab sneaked in, where it shouldn't be.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpio/gpio-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 74489c1..c8d526a 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -495,7 +495,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	irq_chip->irq_unmask = gpio_rcar_irq_enable;
 	irq_chip->irq_set_type = gpio_rcar_irq_set_type;
 	irq_chip->irq_set_wake = gpio_rcar_irq_set_wake;
-	irq_chip->flags	= IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
+	irq_chip->flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
 
 	ret = gpiochip_add_data(gpio_chip, p);
 	if (ret) {
-- 
2.7.4
