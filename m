Return-Path: <SRS0=QJpm=CM=lists.cip-project.org=bounce+64572+5389+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AD0C433E2
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:11:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6115C20665
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UTdSLUl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6115C20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5389+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sTy4YY4521723xV18jbBzHFJ; Thu, 03 Sep 2020 07:10:58 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.14861.1599142256595384961
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:10:57 -0700
X-IronPort-AV: E=Sophos;i="5.76,386,1592838000"; 
   d="scan'208";a="56080047"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 23:10:54 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A2C7642CAFF0;
	Thu,  3 Sep 2020 23:10:53 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip] gpio: rcar: use gpiochip data pointer
Date: Thu,  3 Sep 2020 15:10:52 +0100
Message-Id: <20200903141052.12720-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hSDDSw419d15nf7enFkYpU3tx4520388AA=
Content-Type: multipart/mixed; boundary="vlziqYY6ej3zc5jXths9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599142258;
 bh=H6iyf7HlUfUS/Ll6BMXPOT+uWNFjvX/g8EdsLLg/YVI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UTdSLUl0i4uoWcJ1zL1orpVOwmjbFXIyJSXlHbyrZYYD9p22dWAK9UDTWb5AM58I0FF
 MXrsDPaH/9VsQzKhQ3cI8mZZf8Dc0drJJbgoX95WJi2UtvnhOkg7oTlsDwRUm1X0ElqEd
 ZENvdmgqDpuigX2Ldygqp2Rjk+JcN9Q6WwY=

--vlziqYY6ej3zc5jXths9

From: Linus Walleij <linus.walleij@linaro.org>

commit c7b6f457cb53bceece484f4c528d1c149995e6c7 upstream.

This makes the driver use the data pointer added to the gpio_chip
to store a pointer to the state container instead of relying on
container_of().

Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[PL: Fixes 6e52cced1aa58 ("gpio: rcar: Implement gpiochip.set_multiple()")]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpio/gpio-rcar.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index e829f11aca8f..cffeebd2ac4d 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -84,8 +84,7 @@ static void gpio_rcar_modify_bit(struct gpio_rcar_priv *p, int offs,
 static void gpio_rcar_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
-						gpio_chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
 
 	gpio_rcar_write(p, INTMSK, ~BIT(irqd_to_hwirq(d)));
 }
@@ -93,8 +92,7 @@ static void gpio_rcar_irq_disable(struct irq_data *d)
 static void gpio_rcar_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
-						gpio_chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
 
 	gpio_rcar_write(p, MSKCLR, BIT(irqd_to_hwirq(d)));
 }
@@ -137,8 +135,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
-						gpio_chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
 	unsigned int hwirq = irqd_to_hwirq(d);
 
 	dev_dbg(&p->pdev->dev, "sense irq = %d, type = %d\n", hwirq, type);
@@ -175,8 +172,7 @@ static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
 static int gpio_rcar_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
-						gpio_chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
 	int error;
 
 	if (p->irq_parent) {
@@ -260,16 +256,11 @@ static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
 	return irqs_handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static inline struct gpio_rcar_priv *gpio_to_priv(struct gpio_chip *chip)
-{
-	return container_of(chip, struct gpio_rcar_priv, gpio_chip);
-}
-
 static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 						       unsigned int gpio,
 						       bool output)
 {
-	struct gpio_rcar_priv *p = gpio_to_priv(chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	unsigned long flags;
 
 	/* follow steps in the GPIO documentation for
@@ -293,7 +284,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 
 static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
 {
-	struct gpio_rcar_priv *p = gpio_to_priv(chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	int error;
 
 	error = pm_runtime_get_sync(&p->pdev->dev);
@@ -309,7 +300,7 @@ static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
 
 static void gpio_rcar_free(struct gpio_chip *chip, unsigned offset)
 {
-	struct gpio_rcar_priv *p = gpio_to_priv(chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 
 	pinctrl_free_gpio(chip->base + offset);
 
@@ -333,15 +324,15 @@ static int gpio_rcar_get(struct gpio_chip *chip, unsigned offset)
 
 	/* testing on r8a7790 shows that INDT does not show correct pin state
 	 * when configured as output, so use OUTDT in case of output pins */
-	if (gpio_rcar_read(gpio_to_priv(chip), INOUTSEL) & bit)
-		return !!(gpio_rcar_read(gpio_to_priv(chip), OUTDT) & bit);
+	if (gpio_rcar_read(gpiochip_get_data(chip), INOUTSEL) & bit)
+		return !!(gpio_rcar_read(gpiochip_get_data(chip), OUTDT) & bit);
 	else
-		return !!(gpio_rcar_read(gpio_to_priv(chip), INDT) & bit);
+		return !!(gpio_rcar_read(gpiochip_get_data(chip), INDT) & bit);
 }
 
 static void gpio_rcar_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	struct gpio_rcar_priv *p = gpio_to_priv(chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	unsigned long flags;
 
 	spin_lock_irqsave(&p->lock, flags);
@@ -541,7 +532,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	irq_chip->irq_release_resources = gpio_rcar_irq_release_resources;
 	irq_chip->flags	= IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
 
-	ret = gpiochip_add(gpio_chip);
+	ret = gpiochip_add_data(gpio_chip, p);
 	if (ret) {
 		dev_err(dev, "failed to add GPIO controller\n");
 		goto err0;
-- 
2.17.1


--vlziqYY6ej3zc5jXths9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5389): https://lists.cip-project.org/g/cip-dev/message=
/5389
Mute This Topic: https://lists.cip-project.org/mt/76607574/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--vlziqYY6ej3zc5jXths9--
