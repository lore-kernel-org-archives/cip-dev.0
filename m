Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF6C71151
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:50 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.7074.1749809746359715200
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RxK/5+4l;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso3436045a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809745; x=1750414545; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dl+6uWMvWRjWkZ9Pg5K2nlkexgmygQFdVjZgyPmJc8=;
        b=RxK/5+4lyK6akn1O3XRh6Fjw7BoJRsG3Fbeppv7xlPHNi4LOodLWwHxJLaPBj2Awqz
         2V8Rpm0uX0b+Ws1FpgiFS5xctdQ/3xnha2p1mUW5uWQ0I6vWbXA/YC9wIW62jOAdPkWn
         B9SJd5d3lDdkYUw5lC9gPEFAYaTNS8qv4H5oTLhk1seB2peX3idMoto7vCsrPDNeDAQJ
         Cpsqp9vB1a3DSoOLLTePbuyLyZFea36E89xNn6/9Rfl738boQNAU6a9iAY8HqSwj1kdV
         0n0Relk8TyXGPaKFvSyyakB2tDd6mD74/qDPVyIOIdZQLBECAG3sBkd73kK0h7D25MLV
         0CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809745; x=1750414545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dl+6uWMvWRjWkZ9Pg5K2nlkexgmygQFdVjZgyPmJc8=;
        b=S7pvNC0SlhA2Ep7zJLKlajuNc8cPsrs+vQqtUpYwNK8qA+uVXVBJbCYDOCq3cqVo5x
         82WB1jQBKUO/NiRogL+AAMG0JtoejV95IlrKjsMm71LPGOjMpOHA9oc91DgiG0Wy6rJT
         fveKxlkpB3+61hnM1fsJ7tKew+Sdh9tChzVXv1RnJgYU8STzE1IQSlNCgniayhvddiFN
         HLyYBgt8+mbm8D8p78vO6U0/pNZZEXRvg+SIDBnCRQAdQJEr4TEE/FKeP3UBbfqja859
         aAPcw13PGJwqZzxjU/9/OpXsUblbeX4p9GXIERo7WInCXzp5bQVX4LARZbWKpApOiu0n
         w+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUOsIHPFhZdOpRIe/xqiyQEcn6BR9lyjrwLaQBa43zFUmyuvRbhV4b0z8rmLfqowtVHGkNPjpEF@lists.cip-project.org
X-Gm-Message-State: AOJu0YymHliSn75LwV2TUPNu5cwfxCgiWSmvP7b3Z84DhDGXzPhS9I/Z
	OZKmQZull3h9Jf6bK8grQr46ZCJ++qFamNXdNj0QTQ28LfGP1qoVdQhIpMpnFXTgMR3oRGnHmCA
	qc8sK
X-Gm-Gg: ASbGncvdzqB579pwIbW1339y8Ps7mP1b+sNN/0hej0MxqwQaTVz/uB5pX388nPsWxob
	o1DKbD0m5WlaZ0IgNCjnapmqiqnDgeBK7aGOeI8TyOO4UM78TtqdQuEXBPDGEUujTeevSUvwTkp
	q46dvrqbiYfF/70+LOHdDXAiJPOxw2yJg20OBogOnsE9qWDnd/gTVrCVh7t38NjZgJys5g4j7Eb
	62J1Fs3bjOBKu5Edw99Mo3eTcPE9tfStgahfrrOUnszUiM8dx2Y4LWrXRubw3hZcrgc8RYvw/9D
	BaVU++qaaZjmtsAdN/1n3Dk30wc9ypPSDoHJUgCmbozoa3pgPde1O1NUOjpN6cnPsYe8gFJmmkB
	/EjQitTciy3W2hOL/
X-Google-Smtp-Source: AGHT+IEkznEOqKe0szkG2+Y7zw1dKus4J9QpgIPctcyAdvsqjh9r+yZxb8ANY6BFfUb8XE6odtflkw==
X-Received: by 2002:a05:6402:5113:b0:607:2d8a:9b2a with SMTP id 4fb4d7f45d1cf-608b4a34ed1mr1851821a12.31.1749809744724;
        Fri, 13 Jun 2025 03:15:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 05/14] iio: adc: rzg2l_adc: Use read_poll_timeout()
Date: Fri, 13 Jun 2025 13:15:27 +0300
Message-ID: <20250613101537.279131-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19059

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
index e234d0e50ba3..b5754fa71585 100644
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
@@ -112,7 +113,7 @@ static void rzg2l_adc_pwr(struct rzg2l_adc *adc, bool on)
 
 static void rzg2l_adc_start_stop(struct rzg2l_adc *adc, bool start)
 {
-	int timeout = 5;
+	int ret;
 	u32 reg;
 
 	reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
@@ -125,15 +126,10 @@ static void rzg2l_adc_start_stop(struct rzg2l_adc *adc, bool start)
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
@@ -344,7 +340,6 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 
 static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 {
-	int timeout = 5;
 	u32 reg;
 	int ret;
 
@@ -357,14 +352,10 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
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


