Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886EDC71148
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:30 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.7119.1749809783534737934
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YWwEB8n0;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so338063966b.3
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809782; x=1750414582; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWS2UZaFHNN3IePHCkmTt8KfCyo3ljxiI0stKM1xJEY=;
        b=YWwEB8n0vez2HR74w8HCShb/q8a070vyVza5NBUjQ4a7bF/K7wnKh5YfOqiqb06pUr
         dh4ACpu2hRCqUT9jyNEa9EUcIftJ1ytUMrFlbQGJuGlStvpOAPqLnnSENs6zbm4M+jdE
         rrXYgMEAFAIX0qAhOIEYRTTF37GyCHi9WSzCPaORhClECv8UvKm1/Py+ovH5x5ZYhs/S
         wHjttfWIH820t8YWxOiCoWR8LFRl+k2UC4swMWHWYTU+ny6id24X3IYbyCSel79JrFzR
         NCSghFEa+R+sB17lTZJ8KpTM19ffN4vLLAqxrL/UTeib/Ga9O1hIqeSVbpdi8p9O8ZsT
         WFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809782; x=1750414582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWS2UZaFHNN3IePHCkmTt8KfCyo3ljxiI0stKM1xJEY=;
        b=RjeJT7HwcI07kSfUKY6MIOO7FyCy+RIXda6wL7jsdeZKMmNbgmGuDVUcVTbtWFQzuU
         h6bkRKCnf3mzwtyEp8X7ZA0DzvGFu1PyP9gRoVRdht3v6la0I5aygYdyKiw+Uhw4jjfC
         nPHlYppNiG6vNwozbduHNm7QumBVmDTOKVddOApg0MdYn3wt7pJ1B9JPSTZEDRJqzC8r
         R8YxgcjuFhQlAC2r2qRG0Xzudv541pa/vfuaGPCECWZAl+dbf1yH7hjFThBSu88wUVA3
         c4TzI3bNrpmoM9ODrESxFQ+vIAFGExLfwV235Dg3w7DhnnCWQDnBWOTELWpopCWCmBUJ
         hLyg==
X-Forwarded-Encrypted: i=1; AJvYcCVhrRenPlFILUU3tIEg9XxTkuhCPabMyRKbEYzDC0LIiCz50VYyJriL025urhpYFKFw29YwqH0K@lists.cip-project.org
X-Gm-Message-State: AOJu0YzwZ08Gi4asFRsy2O4CcWRfjsFbNJix2a/aNRgCPgsXZQWB7m3e
	Vdc5p+tJ8F2BMQltNgtQFyu3PJQQHTdB7jwAwWjVSBGk8uU675Mm5xFNzD9KAMePkuc=
X-Gm-Gg: ASbGnctgIjMVEXJiIH6Lldtj+eTAj5o/U4AZg6+2tG+E39H8GItwbC3KDir2zNYgN+T
	Zpd33rJrySlCRASWD3xXdnDpGZK/VdfkEETHVgPoisyPj4Hqf43cFKM7Z/X3zQvKNRXbyUj0GLn
	hZqu5ZANygJehPClN94qv/eNRDkrwMnV7Ud0R6R1XiqgsPqwVlYI16NLKlopwSbiw8EnyuFcQ/v
	2N6Y9cjP2hr3GqLVrVcXl2ih4zjiaqXP/CQjF4sW6jj3QDG0qZlbyZbK737E0ZqQUItu3PKm/fL
	d/JIndrnD0nvA3KTCyi+Cn7zyPttLowtvvFhNidinkkm79u8J3wtJ5lneZ54+4lYiIs68I3EWsI
	KGDFc5YsyVOvHiV/f
X-Google-Smtp-Source: AGHT+IEnhLUhO2uJ4v/FwqAORN4RpbTzsLBwpdu6IdxyiOzKngbKJqyw4q+v8dx0Flyoocd8lfrB5g==
X-Received: by 2002:a17:907:9349:b0:ade:c108:c5bf with SMTP id a640c23a62f3a-adec5d17f56mr230751866b.43.1749809781905;
        Fri, 13 Jun 2025 03:16:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 06/14] iio: adc: rzg2l_adc: Simplify the locking scheme in rzg2l_adc_read_raw()
Date: Fri, 13 Jun 2025 13:16:05 +0300
Message-ID: <20250613101613.296649-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19075

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5d7fb2d589c56877bf220f73debd134c09e8209f upstream.

Simplify the locking scheme in rzg2l_adc_read_raw() by using
guard(mutex)().

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-8-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index ae8a7a02bffc..ef7b14747409 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
@@ -220,21 +221,21 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
 	u8 ch;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
 		if (chan->type != IIO_VOLTAGE)
 			return -EINVAL;
 
-		mutex_lock(&adc->lock);
+		guard(mutex)(&adc->lock);
+
 		ch = chan->channel & RZG2L_ADC_CHN_MASK;
 		ret = rzg2l_adc_conversion(indio_dev, adc, ch);
-		if (ret) {
-			mutex_unlock(&adc->lock);
+		if (ret)
 			return ret;
-		}
+
 		*val = adc->last_val[ch];
-		mutex_unlock(&adc->lock);
 
 		return IIO_VAL_INT;
+	}
 
 	default:
 		return -EINVAL;
-- 
2.43.0


