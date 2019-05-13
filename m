From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:47 +0100
Subject: [cip-dev] [PATCH 4.4.y 22/52] gpio: rcar: Add GPIO hole support
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-23-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 496069b87eea631274c2c35fb6f8c45ad838436b upstream.

GPIO hole is present in RZ/G1C SoC. Valid GPIO pins on bank3 are in the
range GP3_0 to GP3_16 and GP3_27 to GP3_29. The GPIO pins between GP3_17
to GP3_26 are unused. Add support for handling unused GPIO's.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[fab: removed change from gpio_rcar_resume]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpio/gpio-rcar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 411e93b..e829f11 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -357,6 +357,9 @@ static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
 	u32 val, bankmask;
 
 	bankmask = mask[0] & GENMASK(chip->ngpio - 1, 0);
+	if (chip->valid_mask)
+		bankmask &= chip->valid_mask[0];
+
 	if (!bankmask)
 		return;
 
-- 
2.7.4
