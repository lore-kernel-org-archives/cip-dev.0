Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B701D10611F1
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:30 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18307.1773227126896415641
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qqeEpORj;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so43321475e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227125; x=1773831925; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtYPNYwoyyBWPsd+500W+Lsaqcq9TBMbdIjIYI5SCGo=;
        b=qqeEpORjvr61k24H/MH48d1JXIBJUDlctapwY/RFXpAEA3nlxbRsQECf4d/BRVIXcd
         8dqr5YKCW6mjyQwcGRrNEPDrGpxtx8NV0SjZWiiaa7UVuoeV7RWuidzdOCarc4Txr8Kj
         1UEzkSmUApNafzjWKZGDuZmOwKWXV9cR3CkG87XPTW7jEYJkKZp8K719V/Uz3EBoF7Hj
         EmteuJEJh09msw3uCT1OuXZlA4Fndl5eG91lHmlj+qn96IVv0F2NUOO+A0dkOi5SOMXi
         juafgbjE2/FAmzzg9U11tniIHLCZcWgOTSC22RIgYe9lcEOUqk10EtIckLQO6/mOB7qE
         mF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227125; x=1773831925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EtYPNYwoyyBWPsd+500W+Lsaqcq9TBMbdIjIYI5SCGo=;
        b=OhzIFxPjWbOy9RNT2LkWkBKDFP2Vu9alUIkXUQX7nCEh/bkIKJCPOvlM1sUDSbASfN
         cR10DvjGmBSlFFqdphb5P1jM0AVyfNnirBvHjquzQeZQ77ARXCraMjR7ddDJb8XqNTsc
         3axIcwKEnW/Zju4meXm5l1xKzPmiRZArXIyRurJPvEiSL6xTusSRQqNYIlTBxnCQp9Wu
         jhfTPcTic58pTv28GVVcccJB6uqhFIT6gF7fFEdT7p2/TpoofG4EbsEg+WPOdTz6WuG+
         Iw/XOJkubIajY76PuWN6OkJwwJHjVAKZC2m/hPlYWI30KC+3Fei3oGW9P8QFNi3xwSFj
         y8Wg==
X-Gm-Message-State: AOJu0YwywrJUupQwyGvyprQpLCxzY5WbGT2BUsijEM2h536Bow94whct
	ZQpmIiOdbEl2poT3bkKbteexSt5z56xTAnkfhlp+bg+ribS10kxcjTS3T2l6K+yzkPs=
X-Gm-Gg: ATEYQzwhsylw8FrYOMbbKvw9bRFe5VzGBlPoroRy6lbZhTrxh/zFsQWJQ8UUS4uIICa
	MVwQyQgCznKKcG3jvcHtustC9+egIoLTyRGutfN/Ft72drtWDG2ASf+JI2G3RaauMJorL8e16bR
	06AGBbO+Oksa3CeMh8nQTc4NbKPoMlOYh5Ntx1vkaDuM7n0YRYM6jttUL2UOBS5fia0Z3lOsVzt
	Ds7PRgdDs31fORGLSUJgyzPYoDMmMHegjgaeckl9vuyQy50s7YWNL/agqH9Bhfm3SDFiEwuCL0x
	3VECVoKmRvSKwNib6S3AC6Y9yDZMc1YoFFxoahsdQBFJyVK2bv2mEv3f3+W5hHVdmCeOTsT0yAZ
	2CsOFch8YZZpXOhigfsYqct7cAVH02y/uZGhCB8UatSCnYMZ3WMAPk/HCVA8wmJrvtB8QLsHNjI
	LcopJ9dHXK9K74Mxz2jA7OPQiH8rqyOpZcoil+r8eK5vbyzUtoBSxtGdYUiE6aeM0=
X-Received: by 2002:a05:600c:3b18:b0:485:39d1:b4ca with SMTP id 5b1f17b1804b1-4854b0b32femr34170715e9.9.1773227125109;
        Wed, 11 Mar 2026 04:05:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 02/17] lib/bitmap: add bitmap_{read,write}()
Date: Wed, 11 Mar 2026 13:05:05 +0200
Message-ID: <20260311110520.1938414-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22310

From: Syed Nayyar Waris <syednwaris@gmail.com>

commit 63c15822b8dd02a2423cfd92232245ace3f7a11b upstream.

The two new functions allow reading/writing values of length up to
BITS_PER_LONG bits at arbitrary position in the bitmap.

The code was taken from "bitops: Introduce the for_each_set_clump macro"
by Syed Nayyar Waris with a number of changes and simplifications:
 - instead of using roundup(), which adds an unnecessary dependency
   on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
 - indentation is reduced by not using else-clauses (suggested by
   checkpatch for bitmap_get_value());
 - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
   and bitmap_write();
 - some redundant computations are omitted.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
Suggested-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/bitmap.h | 77 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 3c8d2b87a9ed..729ec2453149 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -77,6 +77,10 @@ struct device;
  *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
+ *                                              map at start
+ *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
+ *                                              map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -613,6 +617,79 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_read - read a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
+ *
+ * Returns: value of @nbits bits located at the @start bit offset within the
+ * @map memory region. For @nbits = 0 and @nbits > BITS_PER_LONG the return
+ * value is undefined.
+ */
+static inline unsigned long bitmap_read(const unsigned long *map,
+					unsigned long start,
+					unsigned long nbits)
+{
+	size_t index = BIT_WORD(start);
+	unsigned long offset = start % BITS_PER_LONG;
+	unsigned long space = BITS_PER_LONG - offset;
+	unsigned long value_low, value_high;
+
+	if (unlikely(!nbits || nbits > BITS_PER_LONG))
+		return 0;
+
+	if (space >= nbits)
+		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
+
+	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
+	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
+	return (value_low >> offset) | (value_high << space);
+}
+
+/**
+ * bitmap_write - write n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value to write, clamped to nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG.
+ *
+ * bitmap_write() behaves as-if implemented as @nbits calls of __assign_bit(),
+ * i.e. bits beyond @nbits are ignored:
+ *
+ *   for (bit = 0; bit < nbits; bit++)
+ *           __assign_bit(start + bit, bitmap, val & BIT(bit));
+ *
+ * For @nbits == 0 and @nbits > BITS_PER_LONG no writes are performed.
+ */
+static inline void bitmap_write(unsigned long *map, unsigned long value,
+				unsigned long start, unsigned long nbits)
+{
+	size_t index;
+	unsigned long offset;
+	unsigned long space;
+	unsigned long mask;
+	bool fit;
+
+	if (unlikely(!nbits || nbits > BITS_PER_LONG))
+		return;
+
+	mask = BITMAP_LAST_WORD_MASK(nbits);
+	value &= mask;
+	offset = start % BITS_PER_LONG;
+	space = BITS_PER_LONG - offset;
+	fit = space >= nbits;
+	index = BIT_WORD(start);
+
+	map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
+	map[index] |= value << offset;
+	if (fit)
+		return;
+
+	map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
+	map[index + 1] |= (value >> space);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
-- 
2.43.0


