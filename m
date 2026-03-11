Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663B2105D291
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:19 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18262.1773227049998833224
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KfaxwtvL;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso19331845e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227048; x=1773831848; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2wIVQj2p8pptuteQA9wlqTeg7vTpryS+v/8xSL/RGQ=;
        b=KfaxwtvLFXweC8nqAd128EICB28d658Qvp3vfIqWCzLOlwFWC4Vk5gthEznZZAD16s
         c5EuyrE5DazraY9uWJhQcYfABsMfx0yNBGohxTv+vAE08TqlDkqZljzTwp6d8/8TaDaL
         ofrsqBUYLlI6Mc8BceiWIEf9Yfw0i8hUIGzNb+CpBeogMUHeoJrSARdD0dtrM7GmUy3d
         MgEbd2bBZQ7xSDGelZjSQWbunDEYkRWrXIZFykLoiHjrXzygjXAJP8M6fpB5HB9HbEaZ
         A0Mz/RdHjGE8SKH2lcBCJBhJyZUFiG793tps7ig6Y0neLFAjg8FG1m2pl1LQmhHNiu5U
         PtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227048; x=1773831848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e2wIVQj2p8pptuteQA9wlqTeg7vTpryS+v/8xSL/RGQ=;
        b=WE5PLpFs2aeTcC2WD8+0DJmsMyyvuX51iDzgnIFAyK/PNxNe5StmzXGPhD3Irupu8j
         Ww1RRag1bjhFi0rRR7Jhn9Yb3NALQk7QEDew9/DpUk5Qzuz0K3BmxiX9VtVod9o8WUeI
         2s6iQai53eT9/um28X/ZgjHbZpx47LXZOmpz8osS/91CO73kepVXXQrxzAIXxBUHUDVG
         +jb+F0dOesANUo+hw/fKhcdn8UIsXXSrKiVFCoeONH/k0S+svvtmQOTKVxRvxQClebXS
         fVFyocCjYN6TD4roO5vxI/IBLywFieaeKhJK+aVSbdi2jcdWg6HssNS/ET6F6T/dVett
         oPjg==
X-Gm-Message-State: AOJu0YyjAeg8OPMN1Yu7D0NcNi06/ysVDgzekfOTHszMxEEu4mLtOwjg
	7GKAcCo4A7djZ3p2T+Ernv2k5HkOURQ0yvlEjXrHeegUeUeosBD0WX0AACzqiPytf0E=
X-Gm-Gg: ATEYQzxvWqkfzGrG5R3sRAzmsdJQ0hUexGktj1IWt4HwrarpXq2DDc+k8MhNkwCCP70
	1h6sRZ2Ng3d4oK1wYbujD1/9EfXOGET0c39m91hV1rxfPQALfkjjbIdkp4dlYs6hh3hnqrQ7/gs
	uaW+nZuqvyBwYXLRqxldfd9TGOYE096CKrZjOSQRfc3d3+rWtQGwFb3D+y/XpVgsL7e0YcPOy6F
	FuODGaABkMqDeT4J1LkAA+TLkyz0/AEMqt3wAaKQrF4X7NKYJFjolRVhXMslGFyBeqfFop0jDjk
	uRM34savox5wzzRyLZ9/tnR/47z1J9fCovJI6yjiT/zRA0RiZ3Fhkak3td/htoEsWNgpwyFbxsL
	fAKXUcuScG7HzvzHhAuc17QYkiSN2irSpyVYwWan+Cu/0IS6PjQORE76798zfsRE1+D4s/3P5G3
	pDF7Y0o9PoHsYskIDGhOKFsIYEeqCb1dP6QKfYWL9PWnYjFkgO8sAAq2d0MbN4tjQ=
X-Received: by 2002:a05:600c:1d16:b0:485:3949:e5c6 with SMTP id 5b1f17b1804b1-4854b0a53eemr33048425e9.3.1773227048360;
        Wed, 11 Mar 2026 04:04:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:07 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 07/28] lib/bitmap: add bitmap_{read,write}()
Date: Wed, 11 Mar 2026 13:03:36 +0200
Message-ID: <20260311110357.1938200-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22286

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
index 29b19d2ba5ba..22e3269342f7 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -78,6 +78,10 @@ struct device;
  *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
+ *                                              map at start
+ *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
+ *                                              map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -601,6 +605,79 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
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


