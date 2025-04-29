Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590F2C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:47 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web10.20298.1745934458491446850
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mjk3XMQ0;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aca99fc253bso915722866b.0
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934457; x=1746539257; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzgNccGgZh2BtoOtShxzlLS0JpJgUVRC5kQGVQ7nWeo=;
        b=mjk3XMQ0jBp62t2FL7LLuJT2PhGlP1JZs2YOMs95kYkDpKxmryoAHJmIr5a/t++CL9
         Dy6GJYH4Au/rGHwub18SpZzNkQn2JAG8M/z+n0xAn68qh0J19kSdpasfsK14oaG63jXF
         aTO9YBIhZizBkfOSsO18YxXEbMANGMIqSY0prSZCUpsWTIfB+fdofV8C1wokaNZq1qD0
         ff0hb3zHuBDiQr/lLzYmv8f/H4mF2KuVBa4fF1zhkiQZah//B2vT2/Nv8rSEzgXSXlrQ
         gzu2718TAtMXjI3bjBPTs/RdSw6Y5CwzfvhJLo6gd/AwqRPDKrvWb2hrjuFZ1HZeJk7Q
         2zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934457; x=1746539257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzgNccGgZh2BtoOtShxzlLS0JpJgUVRC5kQGVQ7nWeo=;
        b=WIxXGPyiHk7Evswyk37HfCAi5hXFRv1Vgx0PU8ZrtHHEV6ecYBSaDMMGqAQE8xr0Bq
         Q2fFov8LTQjxdrtDOs8qPq+sChH4Lr9A5mj2uRPGtyyUXcEXcqvdfzsZGwxXYh5OnfjS
         xWpoIYHMMYbVbd5sJOCktF58Ipv/v4jalznA7TwTwVHZ681IRjnpJGEakNVqEAjI6LVz
         ai7m2aPRE6wbEHuAW5E+/eW0DSu5DMRs8tHuYAAs46jZGQ1tUdSfjE+Cko66HJxODFXw
         Joy4+s4NOERTBAeJmvNEjuMHiE0hrBJSsRxMzH2lPrqlkcdxng2hrCOjUU95gWJczvzi
         6YUw==
X-Forwarded-Encrypted: i=1; AJvYcCXxsYLvc7HCFY9xJ/4+zqGuDmvWS5Kx7w6A656Rzf4tOmlXZ9OZKhyX6NctsFsgfMPw9cwrxpYK@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx+nxUsVscknZ/SUKNcJdrSFZ39PVNLM6WmL8M7WD6AOI96kCyJ
	e+sEvzTfCLpZLmiLDTeoC+HNctESGKdChxtrZsKSxtN+VX4/5vJ1PNVPLDllMBw=
X-Gm-Gg: ASbGncum2fbcWPAjgl6E4m7dtga0UWWRZGS4fyrWltp/+RIMyMiSpS/8Xh0FEmc8rtI
	wXpERMEDL8POlgFn8fgcBpEM3++mRr9SqPfGZ2I8BG1UFtqeETfCAuxB47Y1ArdjQRA7s3D19/V
	LAnH83AqwBhYIFfdOnOAch63CBU4Yf2eg9tKFdG7hzcdoj4Mk1B0wq2SO+gfeaZbH/IT7H5HJ51
	LL5BQsZjjh22DQ2TLvgM17J00PtrdckClAcVUWrvtIiWQKSpG/kkyLYZpOUXoPNDn0Z7VJUVeyM
	xAsyThsEyAe5V7VnJYKvskaw+VFydzisjexfVJJaXrXr/VWBt2JSfBCncGCTdnLmk+WGwTg=
X-Google-Smtp-Source: AGHT+IFw1KaXfl+5+xl3BiE9J43hh7bLNuisl+AlIVm2XqP4rKDG5er2t8kG4dATpHtCP9xZuX2DnA==
X-Received: by 2002:a17:907:c22:b0:acb:86f0:fed8 with SMTP id a640c23a62f3a-ace848c021dmr1316783766b.12.1745934456801;
        Tue, 29 Apr 2025 06:47:36 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:35 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 04/21] i2c: riic: Introduce helper functions for I2C read/write operations
Date: Tue, 29 Apr 2025 16:47:10 +0300
Message-ID: <20250429134727.2429662-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18717

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 26c7871100f2933a2827b217320366e89cef5a4c upstream.

Introduce helper functions for performing I2C read and write operations
in the RIIC driver.

These helper functions lay the groundwork for adding support for the
RZ/V2H SoC. This is essential because the register offsets for the RZ/V2H
SoC differ from those of the RZ/A SoC. By abstracting the read and write
operations, we can seamlessly adapt the driver to support different SoC
variants without extensive modifications.

This patch is part of the preparation process for integrating support for
the RZ/V2H SoC into the RIIC driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 56 +++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 6f8ce656183c..46fd6c249c7e 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -106,9 +106,19 @@ struct riic_irq_desc {
 	char *name;
 };
 
+static inline void riic_writeb(struct riic_dev *riic, u8 val, u8 offset)
+{
+	writeb(val, riic->base + offset);
+}
+
+static inline u8 riic_readb(struct riic_dev *riic, u8 offset)
+{
+	return readb(riic->base + offset);
+}
+
 static inline void riic_clear_set_bit(struct riic_dev *riic, u8 clear, u8 set, u8 reg)
 {
-	writeb((readb(riic->base + reg) & ~clear) | set, riic->base + reg);
+	riic_writeb(riic, (riic_readb(riic, reg) & ~clear) | set, reg);
 }
 
 static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
@@ -120,7 +130,7 @@ static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	pm_runtime_get_sync(adap->dev.parent);
 
-	if (readb(riic->base + RIIC_ICCR2) & ICCR2_BBSY) {
+	if (riic_readb(riic, RIIC_ICCR2) & ICCR2_BBSY) {
 		riic->err = -EBUSY;
 		goto out;
 	}
@@ -128,7 +138,7 @@ static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	reinit_completion(&riic->msg_done);
 	riic->err = 0;
 
-	writeb(0, riic->base + RIIC_ICSR2);
+	riic_writeb(riic, 0, RIIC_ICSR2);
 
 	for (i = 0, start_bit = ICCR2_ST; i < num; i++) {
 		riic->bytes_left = RIIC_INIT_MSG;
@@ -136,9 +146,9 @@ static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		riic->msg = &msgs[i];
 		riic->is_last = (i == num - 1);
 
-		writeb(ICIER_NAKIE | ICIER_TIE, riic->base + RIIC_ICIER);
+		riic_writeb(riic, ICIER_NAKIE | ICIER_TIE, RIIC_ICIER);
 
-		writeb(start_bit, riic->base + RIIC_ICCR2);
+		riic_writeb(riic, start_bit, RIIC_ICCR2);
 
 		time_left = wait_for_completion_timeout(&riic->msg_done, riic->adapter.timeout);
 		if (time_left == 0)
@@ -192,7 +202,7 @@ static irqreturn_t riic_tdre_isr(int irq, void *data)
 	 * value could be moved to the shadow shift register right away. So
 	 * this must be after updates to ICIER (where we want to disable TIE)!
 	 */
-	writeb(val, riic->base + RIIC_ICDRT);
+	riic_writeb(riic, val, RIIC_ICDRT);
 
 	return IRQ_HANDLED;
 }
@@ -201,9 +211,9 @@ static irqreturn_t riic_tend_isr(int irq, void *data)
 {
 	struct riic_dev *riic = data;
 
-	if (readb(riic->base + RIIC_ICSR2) & ICSR2_NACKF) {
+	if (riic_readb(riic, RIIC_ICSR2) & ICSR2_NACKF) {
 		/* We got a NACKIE */
-		readb(riic->base + RIIC_ICDRR);	/* dummy read */
+		riic_readb(riic, RIIC_ICDRR);	/* dummy read */
 		riic_clear_set_bit(riic, ICSR2_NACKF, 0, RIIC_ICSR2);
 		riic->err = -ENXIO;
 	} else if (riic->bytes_left) {
@@ -212,7 +222,7 @@ static irqreturn_t riic_tend_isr(int irq, void *data)
 
 	if (riic->is_last || riic->err) {
 		riic_clear_set_bit(riic, ICIER_TEIE, ICIER_SPIE, RIIC_ICIER);
-		writeb(ICCR2_SP, riic->base + RIIC_ICCR2);
+		riic_writeb(riic, ICCR2_SP, RIIC_ICCR2);
 	} else {
 		/* Transfer is complete, but do not send STOP */
 		riic_clear_set_bit(riic, ICIER_TEIE, 0, RIIC_ICIER);
@@ -231,7 +241,7 @@ static irqreturn_t riic_rdrf_isr(int irq, void *data)
 
 	if (riic->bytes_left == RIIC_INIT_MSG) {
 		riic->bytes_left = riic->msg->len;
-		readb(riic->base + RIIC_ICDRR);	/* dummy read */
+		riic_readb(riic, RIIC_ICDRR);	/* dummy read */
 		return IRQ_HANDLED;
 	}
 
@@ -239,7 +249,7 @@ static irqreturn_t riic_rdrf_isr(int irq, void *data)
 		/* STOP must come before we set ACKBT! */
 		if (riic->is_last) {
 			riic_clear_set_bit(riic, 0, ICIER_SPIE, RIIC_ICIER);
-			writeb(ICCR2_SP, riic->base + RIIC_ICCR2);
+			riic_writeb(riic, ICCR2_SP, RIIC_ICCR2);
 		}
 
 		riic_clear_set_bit(riic, 0, ICMR3_ACKBT, RIIC_ICMR3);
@@ -249,7 +259,7 @@ static irqreturn_t riic_rdrf_isr(int irq, void *data)
 	}
 
 	/* Reading acks the RIE interrupt */
-	*riic->buf = readb(riic->base + RIIC_ICDRR);
+	*riic->buf = riic_readb(riic, RIIC_ICDRR);
 	riic->buf++;
 	riic->bytes_left--;
 
@@ -261,10 +271,10 @@ static irqreturn_t riic_stop_isr(int irq, void *data)
 	struct riic_dev *riic = data;
 
 	/* read back registers to confirm writes have fully propagated */
-	writeb(0, riic->base + RIIC_ICSR2);
-	readb(riic->base + RIIC_ICSR2);
-	writeb(0, riic->base + RIIC_ICIER);
-	readb(riic->base + RIIC_ICIER);
+	riic_writeb(riic, 0, RIIC_ICSR2);
+	riic_readb(riic, RIIC_ICSR2);
+	riic_writeb(riic, 0, RIIC_ICIER);
+	riic_readb(riic, RIIC_ICIER);
 
 	complete(&riic->msg_done);
 
@@ -366,15 +376,15 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 		 t->scl_rise_ns / (1000000000 / rate), cks, brl, brh);
 
 	/* Changing the order of accessing IICRST and ICE may break things! */
-	writeb(ICCR1_IICRST | ICCR1_SOWP, riic->base + RIIC_ICCR1);
+	riic_writeb(riic, ICCR1_IICRST | ICCR1_SOWP, RIIC_ICCR1);
 	riic_clear_set_bit(riic, 0, ICCR1_ICE, RIIC_ICCR1);
 
-	writeb(ICMR1_CKS(cks), riic->base + RIIC_ICMR1);
-	writeb(brh | ICBR_RESERVED, riic->base + RIIC_ICBRH);
-	writeb(brl | ICBR_RESERVED, riic->base + RIIC_ICBRL);
+	riic_writeb(riic, ICMR1_CKS(cks), RIIC_ICMR1);
+	riic_writeb(riic, brh | ICBR_RESERVED, RIIC_ICBRH);
+	riic_writeb(riic, brl | ICBR_RESERVED, RIIC_ICBRL);
 
-	writeb(0, riic->base + RIIC_ICSER);
-	writeb(ICMR3_ACKWP | ICMR3_RDRFS, riic->base + RIIC_ICMR3);
+	riic_writeb(riic, 0, RIIC_ICSER);
+	riic_writeb(riic, ICMR3_ACKWP | ICMR3_RDRFS, RIIC_ICMR3);
 
 	riic_clear_set_bit(riic, ICCR1_IICRST, 0, RIIC_ICCR1);
 
@@ -482,7 +492,7 @@ static int riic_i2c_remove(struct platform_device *pdev)
 	struct riic_dev *riic = platform_get_drvdata(pdev);
 
 	pm_runtime_get_sync(&pdev->dev);
-	writeb(0, riic->base + RIIC_ICIER);
+	riic_writeb(riic, 0, RIIC_ICIER);
 	pm_runtime_put(&pdev->dev);
 	i2c_del_adapter(&riic->adapter);
 	pm_runtime_disable(&pdev->dev);
-- 
2.43.0


