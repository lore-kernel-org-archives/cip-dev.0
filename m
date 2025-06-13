Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D86C71156
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:50 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web11.7101.1749809747330904010
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=iqyzHvaY;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so3835530a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809746; x=1750414546; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRympOkkMNN9qtsyZR+VoGzCST8xX2sACQ3A+K2zSdQ=;
        b=iqyzHvaYXWA9Cat9TDArQG/2ETMJD5WYK1xU4vtduk/Ie7DI4wBRbouontYW+a3V0F
         zvAV4TeTdOTtNWRA+ByatGHl3xTS16uFybzxJ5AOjni7VNWS9piX2YLfGUU/T9sLFtyZ
         Rj7nUZTlUQDdaGwm9NVt8PGyGTBl+T9tB7EELFkIu5CGrZ6M3AObb0bVjmcezOpMaPmu
         3kyb/Q3NJCop7iOGsw6aUqcGB3oy5OX4gpbnxR0DSQvx1iiGg162ekqJ+BtLWFYRX29u
         F3FbcvNha6vL2A5ZRlIKaSqUf/+M3fdmN8KCmFWPyyc0b6mkWsOdg/xojz5uVvMOlkQB
         TPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809746; x=1750414546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRympOkkMNN9qtsyZR+VoGzCST8xX2sACQ3A+K2zSdQ=;
        b=YgSPtbajF2nmRdkK+8s0QtbuvEXZrLVtj6kFShQxGSv5Qr6WqLUYtvn7ZvsPsSE6qj
         IL9VvKlh98mEHdCUKnp8W7oavBgSqtyQGesMmQQvqlmpQSLxo2YSxWIo15BjguEUx7Tj
         jy7Zney9oDmD8v0Ze3Mr5ZuChV6igXWxIsNG2JTGEbffB7+kIqVzfrQAB/afjdJHvl6u
         anPJeptSjiJKW4jyq6rIztYRDOqifgV6JB0WEOApw7tC0yMWILqXp9CTNK16wsl9IfE2
         rp0WXPElFYzuwXXQhDIJKyYDYgzbDL1PX4aqCQdjyxBFCjABHM/QxF4JSAWkfcqmyK0W
         otNA==
X-Forwarded-Encrypted: i=1; AJvYcCWm5y4MkSImLO8Aum7v0l4hs6/qanWU34r+Ombf9KZISkMake4P5ISjyATsyejF8yXP/syXTipf@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx8pBEpIOF4N7TiABKrbRDCl05Xa6AkAu9r/OLuDqQl0vgpCfZ1
	cMn1kHGQN7vALQQKWKCky5WWDutAWnOmKSIZRQ/yxxQ/B6rKY6Jfp0q9XwitnnbgnA4=
X-Gm-Gg: ASbGncth2dg2JBtig6fMKQxagJDOx2dMqru3iMUodl+Tq9e23ZeXV3UquxBgLo108K7
	E3cNpkh1MfxWodD8ckEfrOqF/4Xge2EGsNN3jf1RusByD1UwS8wEpjJq3YeJX2fMRlQlsljDqu5
	UBsZY+1DzWDblUemg1fY1Jg28N2rXWSMicQZRn0LcRVA5smnqz79LMZMldGfnD1jUy9Z4IuhppX
	wHcMMuv+od6q4Ptd4tgvYOWc6A1pJZW6HduEnf/0uRkFYrFbtc6XpGC6MkhRgju4tEbr4nrs6b5
	aji6jmfbf7dcFuJbzdlNhIb3t159qdUmbDIWZBUX5FcxN3m9kGC+YydrwuZjQqZSqKxlcx6fEXC
	iyCSQivx5uSflBs8n
X-Google-Smtp-Source: AGHT+IGzGDlup4Hb7BVBI7wC+Ydc2fxfd1H6MgofBTHiE0d05USsYC+MFXCSdO1j0ivqwbw3a90kvA==
X-Received: by 2002:a05:6402:2813:b0:607:77ec:fa8c with SMTP id 4fb4d7f45d1cf-608b48c7595mr2185993a12.1.1749809745763;
        Fri, 13 Jun 2025 03:15:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 06/14] iio: adc: rzg2l_adc: Simplify the locking scheme in rzg2l_adc_read_raw()
Date: Fri, 13 Jun 2025 13:15:28 +0300
Message-ID: <20250613101537.279131-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19060

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
index b5754fa71585..93ee448bf575 100644
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


