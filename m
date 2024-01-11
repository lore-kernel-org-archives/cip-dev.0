Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67781C47DA6
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 19:08:16 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.1119.1705000090685533082
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 11:08:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BpYt3/ir;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: theflamefire89@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so64228075e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705000089; x=1705604889; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkqbZsH/PyEXNWR4TAZzFe8avEAGQDWyvPBjkesY+TA=;
        b=BpYt3/ir9Uji4sTLhKXcB/ORbDblxskPokf0qmj9rCk4IWecyXGrD0oMziCLfp9PJW
         OSUf2r/Gb1tq6z5kU6JPJUjAN1wQOAJp0Q1lnBTMVzmnvmVYTnpvCOgQhErm/sugw312
         9sZku4jdqkwnjovpeATIis+o9j4HvBevIvaSsCdnAeHqqX+chTvz8pjAzu92nLwwfeAW
         47rKIRxLQHOQClxkMmVwvUuVnSio41xe/6O1rup2UVsCAOubxPe5sJnOLi7nV/JNSKIA
         3/nLuOPH8j4FUiYH1+XJHSumUvqqlQhZslypnH5qt0MS2uFVWecTgS7LmdYSnxDoQOl7
         GbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705000089; x=1705604889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkqbZsH/PyEXNWR4TAZzFe8avEAGQDWyvPBjkesY+TA=;
        b=BbW2n2Y0jwSli7s6q8LvkH7VW+Oo2d3MW1o1uM/P2m9IZR7gG5eIVc7VBfKIHQl5sT
         jQvM4QsinN5pRYktAOgmLRUnFASNHQsauxV++b0XK52/jEreWu+t4jXbUK9A71h99nnt
         dcYT5tbK5rxrLdiKMn/LjRtMvc29nOYFhouDKvBIn25bZHTRXQZepvkxbPW6BemkjfCW
         lkIcTL8N4J8sl5iHUm6ZMZagtoxfuJhNfawZPowBzKdeQ+cVLc/1wE9+gA5m4Rd4Pue/
         ueXrzDAjZTJ8UH1CSx3at64S1nZO7kTZcd/AB/ccgb4l9xzEnYeKgv/JlPICRaowgp9e
         ivSg==
X-Gm-Message-State: AOJu0YwSHaNx1i8uTK0r/5k5sr/mFaxsU/wYTjNVxkssDrL+1BrQrnEA
	xXXTV82Bf+7iAgqDq42qcFPLIL9hZoU=
X-Google-Smtp-Source: AGHT+IEU4L6MU+SA/3Qx0ISQMLT8jE0MptJ5tbTql9F2uhQfUljqpKnaBneeODYfXd2sJiYpIjOoqA==
X-Received: by 2002:a05:600c:1909:b0:40c:2411:80 with SMTP id j9-20020a05600c190900b0040c24110080mr135769wmq.121.1705000088855;
        Thu, 11 Jan 2024 11:08:08 -0800 (PST)
Received: from alex-Mint.fritz.box (p200300f6af47620043a7429456d42e7a.dip0.t-ipconnect.de. [2003:f6:af47:6200:43a7:4294:56d4:2e7a])
        by smtp.googlemail.com with ESMTPSA id p12-20020a05600c468c00b0040e56830a35sm2964641wmo.18.2024.01.11.11.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:08:08 -0800 (PST)
From: Alexander Grund <theflamefire89@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: [PATCH 4.4 3/4] string: uninline memcpy_and_pad
Date: Thu, 11 Jan 2024 20:06:57 +0100
Message-Id: <20240111190658.153488-4-theflamefire89@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240111190658.153488-1-theflamefire89@gmail.com>
References: <20240111190658.153488-1-theflamefire89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 19:08:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14336

From: Guenter Roeck <linux@roeck-us.net>

commit 5c4e0a21fae877a7ef89be6dcc6263ec672372b8 upstream.

When building m68k:allmodconfig, recent versions of gcc generate the
following error if the length of UTS_RELEASE is less than 8 bytes.

  In function 'memcpy_and_pad',
    inlined from 'nvmet_execute_disc_identify' at
      drivers/nvme/target/discovery.c:268:2: arch/m68k/include/asm/string.h:72:25: error:
	'__builtin_memcpy' reading 8 bytes from a region of size 7

Discussions around the problem suggest that this only happens if an
architecture does not provide strlen(), if -ffreestanding is provided as
compiler option, and if CONFIG_FORTIFY_SOURCE=n. All of this is the case
for m68k. The exact reasons are unknown, but seem to be related to the
ability of the compiler to evaluate the return value of strlen() and
the resulting execution flow in memcpy_and_pad(). It would be possible
to work around the problem by using sizeof(UTS_RELEASE) instead of
strlen(UTS_RELEASE), but that would only postpone the problem until the
function is called in a similar way. Uninline memcpy_and_pad() instead
to solve the problem for good.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alexander Grund <theflamefire89@gmail.com>
---
 include/linux/string.h | 19 ++-----------------
 lib/string_helpers.c   | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index c874f5ea9bb3e..9f745d7e9f3f7 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -204,22 +204,7 @@ static inline const char *kbasename(const char *path)
 	return tail ? tail + 1 : path;
 }
 
-/**
- * memcpy_and_pad - Copy one buffer to another with padding
- * @dest: Where to copy to
- * @dest_len: The destination buffer size
- * @src: Where to copy from
- * @count: The number of bytes to copy
- * @pad: Character to use for padding if space is left in destination.
- */
-static inline void memcpy_and_pad(void *dest, size_t dest_len,
-				  const void *src, size_t count, int pad)
-{
-	if (dest_len > count) {
-		memcpy(dest, src, count);
-		memset(dest + count, pad,  dest_len - count);
-	} else
-		memcpy(dest, src, dest_len);
-}
+void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
+		    int pad);
 
 #endif /* _LINUX_STRING_H_ */
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 5c88204b6f1f1..f46075b3d9e41 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -534,3 +534,23 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 	return p - dst;
 }
 EXPORT_SYMBOL(string_escape_mem);
+
+/**
+ * memcpy_and_pad - Copy one buffer to another with padding
+ * @dest: Where to copy to
+ * @dest_len: The destination buffer size
+ * @src: Where to copy from
+ * @count: The number of bytes to copy
+ * @pad: Character to use for padding if space is left in destination.
+ */
+void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
+		    int pad)
+{
+	if (dest_len > count) {
+		memcpy(dest, src, count);
+		memset(dest + count, pad,  dest_len - count);
+	} else {
+		memcpy(dest, src, dest_len);
+	}
+}
+EXPORT_SYMBOL(memcpy_and_pad);
-- 
2.40.1


