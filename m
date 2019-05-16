From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:32 +0100
Subject: [cip-dev] [PATCH v2 20/52] gpiolib: Avoid calling chip->request()
	for unused gpios
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-21-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 3789f5acb9bbe088f70779002f32e7c6a64000bc upstream.

Add a check for unused gpios to avoid chip->request() call to client
driver for unused gpios.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[fab: moved changes from gpiod_request_commit to __gpiod_request]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* No change
---
 drivers/gpio/gpiolib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 487a864..d72218f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1024,6 +1024,7 @@ static int __gpiod_request(struct gpio_desc *desc, const char *label)
 	struct gpio_chip	*chip = desc->chip;
 	int			status;
 	unsigned long		flags;
+	unsigned		offset;
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
@@ -1042,7 +1043,11 @@ static int __gpiod_request(struct gpio_desc *desc, const char *label)
 	if (chip->request) {
 		/* chip->request may sleep */
 		spin_unlock_irqrestore(&gpio_lock, flags);
-		status = chip->request(chip, gpio_chip_hwgpio(desc));
+		offset = gpio_chip_hwgpio(desc);
+		if (gpiochip_line_is_valid(chip, offset))
+			status = chip->request(chip, offset);
+		else
+			status = -EINVAL;
 		spin_lock_irqsave(&gpio_lock, flags);
 
 		if (status < 0) {
-- 
2.7.4
