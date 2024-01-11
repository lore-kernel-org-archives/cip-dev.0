Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5668CC47258
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 19:08:16 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.1117.1705000089309606570
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 11:08:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YqAqYg4j;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: theflamefire89@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e5f615a32so9444925e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705000088; x=1705604888; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPpfficv0BuJb/aoQ4lMKtbb3XZTVeN6zAa5Fp50CQQ=;
        b=YqAqYg4jkP/XGTrKrYw0qgOvIL62d8pT5ltrwtRelVI9e7TToSWA6HWJLYH4WCphRy
         +czjtRAy32KGPns73LM99shYwmNq6Yd9YkQpPVYV5qVdmFkUxrxn2xBpaTEIgnD7X9Ol
         d8W0d2OSjCe5owho2oEMCQV1iDO62FV1VQk9qzzfFKSOAMv5GpRvDZQlawzRssaX46Gi
         qOihsIMtmYLJA3NrlIQBv79WyMNVtQQD1UQTNsqGjlOlYMla1BnU72Mhpia/holyzc3A
         qZJs/NbAtuqtHznCIzZemtfjaSlJ5PcnRxd0lBP8xWam2mTeMaHTmlwJyiWylUC4tv/T
         ifNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705000088; x=1705604888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPpfficv0BuJb/aoQ4lMKtbb3XZTVeN6zAa5Fp50CQQ=;
        b=qSnWDEA0+j1R+vgA8F2fEZ0fNEXexo2xTfCGlS7QyCMdCY3A3DpQOs7qX9rlO4xe3x
         19IgQ8PiZTJ7y69XjMky1tJZicfRwZdpI9umy+F/x92/sak3SAedh1ezNu84ghYRpIIv
         TsovZCtkl5NTEjJDirW+WzG9ULA2dObPbqMpdwwb7qEneJWoJ3oacR6S38dcwAxSamKV
         9a0s2WX2tKPf9e+VklrtjYe6WYWHgxKoR7gC8nM7YXPifgyptdTC7Md25Lz69jBtFCyY
         fG7NPDjjoqK8xd3NH8PU0B8aHdW2Sulx2Fnt8sHtrW6QQdp/mz0IqeslfYB+mOHuuHVq
         iEvQ==
X-Gm-Message-State: AOJu0YyysFDQqrEmgaTy6HdGxeB/1mfdiJwLsIghQTZcOkZQu8mZqyzQ
	UwrF+1EtPYd0WAONRj2LspzENINEscw=
X-Google-Smtp-Source: AGHT+IHTRObukcB4T9YCre+Ds1MAzRUTJHho+mG5qj5PHhu2yiL3Ua9mXyHHfCwYj5mkjR+Oav9s8g==
X-Received: by 2002:a05:600c:8506:b0:40e:545b:80b9 with SMTP id gw6-20020a05600c850600b0040e545b80b9mr75896wmb.8.1705000087764;
        Thu, 11 Jan 2024 11:08:07 -0800 (PST)
Received: from alex-Mint.fritz.box (p200300f6af47620043a7429456d42e7a.dip0.t-ipconnect.de. [2003:f6:af47:6200:43a7:4294:56d4:2e7a])
        by smtp.googlemail.com with ESMTPSA id p12-20020a05600c468c00b0040e56830a35sm2964641wmo.18.2024.01.11.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:08:06 -0800 (PST)
From: Alexander Grund <theflamefire89@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: [PATCH 4.4 2/4] string.h: un-fortify memcpy_and_pad
Date: Thu, 11 Jan 2024 20:06:56 +0100
Message-Id: <20240111190658.153488-3-theflamefire89@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240111190658.153488-1-theflamefire89@gmail.com>
References: <20240111190658.153488-1-theflamefire89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 19:08:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14335

From: Martin Wilck <mwilck@suse.com>

commit 1359798f9d4082eb04575efdd19512fbd9c28464 upstream.

The way I'd implemented the new helper memcpy_and_pad  with
__FORTIFY_INLINE caused compiler warnings for certain kernel
configurations.

This helper is only used in a single place at this time, and thus
doesn't benefit much from fortification. So simplify the code
by dropping fortification support for now.

Fixes: 01f33c336e2d "string.h: add memcpy_and_pad()"
Signed-off-by: Martin Wilck <mwilck@suse.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Alexander Grund <theflamefire89@gmail.com>
---
 include/linux/string.h | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 84af888924e11..c874f5ea9bb3e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -212,20 +212,9 @@ static inline const char *kbasename(const char *path)
  * @count: The number of bytes to copy
  * @pad: Character to use for padding if space is left in destination.
  */
-__FORTIFY_INLINE void memcpy_and_pad(void *dest, size_t dest_len,
-				     const void *src, size_t count, int pad)
+static inline void memcpy_and_pad(void *dest, size_t dest_len,
+				  const void *src, size_t count, int pad)
 {
-	size_t dest_size = __builtin_object_size(dest, 0);
-	size_t src_size = __builtin_object_size(src, 0);
-
-	if (__builtin_constant_p(dest_len) && __builtin_constant_p(count)) {
-		if (dest_size < dest_len && dest_size < count)
-			__write_overflow();
-		else if (src_size < dest_len && src_size < count)
-			__read_overflow3();
-	}
-	if (dest_size < dest_len)
-		fortify_panic(__func__);
 	if (dest_len > count) {
 		memcpy(dest, src, count);
 		memset(dest + count, pad,  dest_len - count);
-- 
2.40.1


