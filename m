Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB9CFCE09B
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:33:53 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78744.1772134432326337751
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:33:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gkYhAZRv;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48378136adcso7577655e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134430; x=1772739230; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqzFidqYDU8S01nI/Y1yVznJojB6PbUsmuhkTwF0YWk=;
        b=gkYhAZRvU+QQY5mjmRAEPXwjdJAsNR7R206BfjUoVL9TvMKgEv+Suy52YFJ4eLc54l
         DBT+XMvBbQnC5QUThqU+JQ018PsSS+OztoYKJgnHqXj/Hnbw6tFhF9IaXC13fSj6XJYg
         5cDCtSla+KykT+nteOFWMJjRksVzKpGhX89lzkh/Wcy1AMNNOWX57datz5kISUB8pHrM
         BMXRa1VzMLnmiZE/BsPUkod+Z7Af7Kf6U8rRmO75nc8V3Tz7B1xUylLnlKmHEBIy4Nc9
         2JpYvmK6F3zcY8BfjlB/giyNZFLCI4+vQkSeeu0Q0qCApgQnfht70Cum1BmF1xSWe8iD
         lc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134430; x=1772739230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqzFidqYDU8S01nI/Y1yVznJojB6PbUsmuhkTwF0YWk=;
        b=VGI0EtePWuyD3aCl5sa+Go39qTat2gbhct1SHrce9Y5h/bQl3EDI+mIi//CaQkIQCr
         NfB8X2RPUgpqAOA6BMVYVQbNTQLGA2LvCWCVb4DYBkvxTKFxkrDxpuxFbSqvbkktgg8e
         luTdwelcVHXMzOU4u4Xz+Pz54vDlovSc4WA7uHn9kVF8Q9ETZSinvoWkcr3pIm0Gq5z7
         PxU37LvMOVci+6aPRw4zE41eEegJx/wAtOv6L2MVcTge+QneRoWAgHT5DjfzmW+wi7sK
         HkSJJCtP+J0Bn9MCc5cN1Qgsrp0nAS6jnpIlDmSdEV/RL4Gj3FO/usp12MYpugEZWzoL
         uyOg==
X-Gm-Message-State: AOJu0YxWnMnQtn2sR2k5HF7jMXeRKDSSyF1CsS0Rs9WnT0B8opCZ8K8T
	7GAoniHcXWSPLMt7KLQ6RNFQJNenQTpjOI9eT4/Sd3QjNc345TVf2djc8flY64Bc
X-Gm-Gg: ATEYQzzK3hE7PGz6IO3mvY/ML2qbeIxW9oPvhLcRIOJqzrTkDpQLpSRoysFLUfVfidn
	SsbYVXmwciR3T44UM4kUVH6DjljVqVXagussqd9rmKnT/NHttJjeh8++L/YlGmi4pf3GoZk08AQ
	JHmKERdEJX4R78ZWf411odp9sGxPGUshFThfpsXpSyTyIwHAIe2Gj7oDPnrsev2AuN12oHpcXg9
	8UiHDkd97FGrCp9my63JIUeCznw7dlBrRJeP6FhyAekki4LhvrA5JW5iUIKgYe4YU+fmPt63nOP
	0EC1Xd01rrV7QSWW+8GBM9seubT/y8ZtWa86zr6i4qet7QkTgzz5pVBR86WlbTFXktYBCUlF9+t
	DnUXHKoiTFZWbzJd0UmF0Lmu7cXuoozoLROpkcKGW5+/mtFFcIB7TJ1HbW1eHtCnAKtLUVX91tD
	swMZE6GVCAUjpnGxVwKEdzSFg2HiSjBAkB8phMp2HOYWfW+n4=
X-Received: by 2002:a05:600c:3589:b0:483:129e:b573 with SMTP id 5b1f17b1804b1-483c219eb09mr108961115e9.18.1772134429942;
        Thu, 26 Feb 2026 11:33:49 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm167721555e9.14.2026.02.26.11.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:33:49 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 1/8] iopoll: Do not use timekeeping in read_poll_timeout_atomic()
Date: Thu, 26 Feb 2026 19:33:25 +0000
Message-ID: <20260226193348.449329-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
References: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:33:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22003

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 7349a69cf3125e92d48e442d9f400ba446fa314f ]

read_poll_timeout_atomic() uses ktime_get() to implement the timeout
feature, just like its non-atomic counterpart.  However, there are
several issues with this, due to its use in atomic contexts:

  1. When called in the s2ram path (as typically done by clock or PM
     domain drivers), timekeeping may be suspended, triggering the
     WARN_ON(timekeeping_suspended) in ktime_get():

	WARNING: CPU: 0 PID: 654 at kernel/time/timekeeping.c:843 ktime_get+0x28/0x78

     Calling ktime_get_mono_fast_ns() instead of ktime_get() would get
     rid of that warning.  However, that would break timeout handling,
     as (at least on systems with an ARM architectured timer), the time
     returned by ktime_get_mono_fast_ns() does not advance while
     timekeeping is suspended.
     Interestingly, (on the same ARM systems) the time returned by
     ktime_get() does advance while timekeeping is suspended, despite
     the warning.

  2. Depending on the actual clock source, and especially before a
     high-resolution clocksource (e.g. the ARM architectured timer)
     becomes available, time may not advance in atomic contexts, thus
     breaking timeout handling.

Fix this by abandoning the idea that one can rely on timekeeping to
implement timeout handling in all atomic contexts, and switch from a
global time-based to a locally-estimated timeout handling.  In most
(all?) cases the timeout condition is exceptional and an error
condition, hence any additional delays due to underestimating wall clock
time are irrelevant.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/3d2a2f4e553489392d871108797c3be08f88300b.1685692810.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/linux/iopoll.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 0417360a6db9..19a7b00baff4 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -74,6 +74,10 @@
  * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
  * case, the last read value at @args is stored in @val.
  *
+ * This macro does not rely on timekeeping.  Hence it is safe to call even when
+ * timekeeping is suspended, at the expense of an underestimation of wall clock
+ * time, which is rather minimal with a non-zero delay_us.
+ *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
  */
@@ -81,22 +85,30 @@
 					delay_before_read, args...) \
 ({ \
 	u64 __timeout_us = (timeout_us); \
+	s64 __left_ns = __timeout_us * NSEC_PER_USEC; \
 	unsigned long __delay_us = (delay_us); \
-	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
-	if (delay_before_read && __delay_us) \
+	u64 __delay_ns = __delay_us * NSEC_PER_USEC; \
+	if (delay_before_read && __delay_us) { \
 		udelay(__delay_us); \
+		if (__timeout_us) \
+			__left_ns -= __delay_ns; \
+	} \
 	for (;;) { \
 		(val) = op(args); \
 		if (cond) \
 			break; \
-		if (__timeout_us && \
-		    ktime_compare(ktime_get(), __timeout) > 0) { \
+		if (__timeout_us && __left_ns < 0) { \
 			(val) = op(args); \
 			break; \
 		} \
-		if (__delay_us) \
+		if (__delay_us) { \
 			udelay(__delay_us); \
+			if (__timeout_us) \
+				__left_ns -= __delay_ns; \
+		} \
 		cpu_relax(); \
+		if (__timeout_us) \
+			__left_ns--; \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
-- 
2.43.0


