Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB17C71153
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:09 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.7069.1749809708945316067
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Iu/kg+YS;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ade48b24c97so285311166b.2
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809707; x=1750414507; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVZnathdqWSPliV4N2/CcVk9Ik+y4W1g8AYHgGX+/h0=;
        b=Iu/kg+YSwqsXt9scKbJtsNzJYQkWRgj06UXc8zdmCkuo35IQwWRcRPTnq2DlNM0LEd
         v/exPx1/DWx6J6qds/ruk1sOX0WyKdzsX96i5/F34MMMzTS6edxUORIm7rXNrfwBBWmD
         pK0LCQPFGi3XdEUx8SlVDjK95oBsYzKwOu0EaWd+1a566UF7pd/y+K6QgMhpvxbCp8f/
         j1EHIhxIwZRC2jjcn52nYEwdAGjICzd18m/7xc4kSagAlheVbPQOeJaJ9xPsfBISLC2/
         +gollHdmQyqgvC7IwrHFqYqH7yp8BvV4itpQE6BPUCyTzP2I0ckl8WwpduzDGDXh2rV5
         ndsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809707; x=1750414507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVZnathdqWSPliV4N2/CcVk9Ik+y4W1g8AYHgGX+/h0=;
        b=o7YeZwCx1Xas2wjKvcFNaa6fWYd9azbSCdoePfCNzZTxEX15hY2ob9JwRwucCeiq1Y
         7x7J5CAEgysbzBUVLQNLkmqZfVySzu7DEZ9JeTjiocgMYKv7vMkR4MVCEM0+GL9s+uQ4
         EesddOSOvini6Wh6Sssn2vMllhwAxqYfXenqe6Co7KUSSylnNQ57bWd2xVZU5F8dOFq3
         MgpTQxefKGmLiynHKJdQCW24Mxc83cp/XQK+VQhguQruyTgXTQadurzF9qtomyKOZZyI
         4eHBiQPugy5fTLrYqI0COJnrUrsMAafdRJPRZ/LvC/23DtK749GHbjQndz20U2GOWWa3
         h8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVqzg4krWtn2nk2qDKNzdCYlpsvK2zvCPEA1wzXXQSdQpJ7YEbhFh+I5S26+YB/jVmza76S/ELu@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw5BPpRE0ZUjah7luJc8UICXEuD7dG0d5t7t2CeAz6yyJBPBsgz
	WFkSCyv8vOGEa/6XFl6crvHSeyzNyOWCTLtyDMvRhoHDgGhk4h0LJsHNKUq+OVpJzps=
X-Gm-Gg: ASbGnctRQu2MIZknTEoDnn2Bjqyc7YETlKjqaMt50EXje8uXkbFYGHBWbQtNNOBybXW
	zsgmifRnZdMzTmzTwWn5yYBePYmZEzqL8RQEmIEys2Zey8ejo00OVsweYmarS/tSDzcwphubEYM
	qB0Q5+yIrlLXL6JjaPajglQwpg9ligxkew9v4Ke/t5XztDATdMIeIMz9zrDrek81T2WP6ZN2G1a
	GmYCQOdQd4v3AUGZ9ZIHBynR4rODp2cLguYw8xzhV5Dh0aVGXhI0hZQxiGbSId6Qwj0rq/gHUuB
	esVf6e7vAYEFplu4BbeqKKn1tS0eRrjZnlWHOLrOudkCud6REo/ZB4g7V2j5vx0X7Wry0Bg6eei
	AgkkXf6nb8eUwJfBW
X-Google-Smtp-Source: AGHT+IGTzPMActBDjR56kols01ko1so9WMc+gyXdbCDDDPYLuGdw1Zw8ZF2FgLOUwiyeaT6xoPvilQ==
X-Received: by 2002:a17:907:6e89:b0:ad2:549b:4c8d with SMTP id a640c23a62f3a-adec5c7c4dfmr231501266b.51.1749809707247;
        Fri, 13 Jun 2025 03:15:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 04/12] iio: adc: rzg2l_adc: Use read_poll_timeout()
Date: Fri, 13 Jun 2025 13:14:53 +0300
Message-ID: <20250613101501.262091-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19045

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b7549624af04eb52cb28df57bee2bcc88be1adc0 upstream.

Replace the driver-specific implementation with the read_poll_timeout()
function. This change simplifies the code and improves maintainability by
leveraging the standardized helper.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 08b4d43aa3ea..48021edd622e 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -13,6 +13,7 @@
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -111,7 +112,7 @@ static void rzg2l_adc_pwr(struct rzg2l_adc *adc, bool on)
 
 static void rzg2l_adc_start_stop(struct rzg2l_adc *adc, bool start)
 {
-	int timeout = 5;
+	int ret;
 	u32 reg;
 
 	reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
@@ -124,15 +125,10 @@ static void rzg2l_adc_start_stop(struct rzg2l_adc *adc, bool start)
 	if (start)
 		return;
 
-	do {
-		usleep_range(100, 200);
-		reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
-		timeout--;
-		if (!timeout) {
-			pr_err("%s stopping ADC timed out\n", __func__);
-			break;
-		}
-	} while (((reg & RZG2L_ADM0_ADBSY) || (reg & RZG2L_ADM0_ADCE)));
+	ret = read_poll_timeout(rzg2l_adc_readl, reg, !(reg & (RZG2L_ADM0_ADBSY | RZG2L_ADM0_ADCE)),
+				200, 1000, true, adc, RZG2L_ADM(0));
+	if (ret)
+		pr_err("%s stopping ADC timed out\n", __func__);
 }
 
 static void rzg2l_set_trigger(struct rzg2l_adc *adc)
@@ -335,7 +331,6 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 
 static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 {
-	int timeout = 5;
 	u32 reg;
 	int ret;
 
@@ -348,14 +343,10 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	reg |= RZG2L_ADM0_SRESB;
 	rzg2l_adc_writel(adc, RZG2L_ADM(0), reg);
 
-	while (!(rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_SRESB)) {
-		if (!timeout) {
-			ret = -EBUSY;
-			goto exit_hw_init;
-		}
-		timeout--;
-		usleep_range(100, 200);
-	}
+	ret = read_poll_timeout(rzg2l_adc_readl, reg, reg & RZG2L_ADM0_SRESB,
+				200, 1000, false, adc, RZG2L_ADM(0));
+	if (ret)
+		goto exit_hw_init;
 
 	/* Only division by 4 can be set */
 	reg = rzg2l_adc_readl(adc, RZG2L_ADIVC);
-- 
2.43.0


