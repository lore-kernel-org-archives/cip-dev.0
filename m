Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BC4FD9E0B
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:42:43 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78966.1772134961254579439
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:42:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cSDAEHV0;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so15191835e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134959; x=1772739759; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqzFidqYDU8S01nI/Y1yVznJojB6PbUsmuhkTwF0YWk=;
        b=cSDAEHV0mPgT9hkNjdIbuhRbhF/SQZ/MZd4+1n0ckN/J0p/llCEARJvNvn3wfldVXA
         yuvOOPL5WSe4C85/1xmumWIcf4Qd/4vRO+qqT3IaS9jHWhHc/ToQgux3i/OhDAlWhUIi
         liiQr9qa/ZEL1jBUKS7T5YviM/2aD3ZygZeHUkShFqOM/6/W2x7vI4mPPlPcQoqAliDA
         YFnPCaISx5cafezo8p3/MsdtABz5YEMUxWxF9hgl0CTQx/V/S78JA7R8Sujw50T5sPuc
         Jv4daR2QayM8vJYNe+aY5a25hPsegdkM9fb6cJCgy/G1zKuKjUuXDGh0/Ksof/Mo8bcM
         +opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134959; x=1772739759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqzFidqYDU8S01nI/Y1yVznJojB6PbUsmuhkTwF0YWk=;
        b=qz5mx0v6RzfdrYY+LKYNuzfmFpLuk2q1/98MzI1TSigdZtTuI5+A1+HNIRxZsDjLNS
         kfDFa/u/1DqBjYadeR1p7OifUKvJdBRgIbg8u0D9AuDzi+cSsmLUrbiftb/iQt35Zkh8
         KJE+druKoTInjoazhMdySnlujAE86dgyHQLBLAt+wvzwWeM2wIFWRel6q2FLtyr7+AFR
         WqwJNA6q/XTqm6djYkahPqfJMXSyJz4ISXklYWwgAYi0ojy0Uq0+nWb6ZVbs2wUQaeyn
         UHcJjv6PtgaW927VtwebFk6Tjj60OIAl6y7rIKbUwTUmjyTGJVAes0doJ2GYPBvCDdbY
         1GWw==
X-Gm-Message-State: AOJu0YwZoLArvaP7QR1MAkqs13BwvtMJr4/DSqUy4EpTMNJJlKSfe8+N
	dZ4qsHu1WL+cH91JK7DsixdbOROb4Ccwo4Nw+TbRRz3ZoT0E7gMvVH8aWQbcxhl5
X-Gm-Gg: ATEYQzxKeNPw2EEihax7pgcJDetbY87/Tt/nWFJhFPBYK7Hl0uVQDUJkDNo1k1VlJFj
	T2KTbdOBTXp3jvhE3CFTzMUrG+6p02B8s7lFm5P7w55Bx112iExUY6nKvbSRisfSnreHC2aJGAj
	TA+gdF+RJJtYlBMtjPY1dv7l6kdkOHge9umYNrgrqXwIyaJLSUNRaybheujGIXN45NA7BdV6EEr
	d/BHlcYiOMIzPU6sSUX5xIsabCoRDqFsdso8+VGf2sq4p2lfu6hwP3oRhu2B5LbLRBb+5Tm9H5d
	exWkscmwKAhDBK8134ecsN5uQ3RJ7H4JLCv5PmqFxiVdtaK2JFpiVTPNhkwVpNoLGOpcujVMYW8
	q6p2rsiioeplT/BEk467jxpaIDOUrTGjBek7ZcfnMsKb8sWn4fl4dGEzow1Rgu140Ly/M+dRX2U
	x+Jbeq+VvuQuziVPeJ9JQhVM4kGUIlcNtsVuLilXGBv3tlsxQ=
X-Received: by 2002:a05:600c:3b18:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-483c9bb6615mr112885e9.7.1772134959336;
        Thu, 26 Feb 2026 11:42:39 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c6100b8sm1854324f8f.2.2026.02.26.11.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:42:39 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/9] iopoll: Do not use timekeeping in read_poll_timeout_atomic()
Date: Thu, 26 Feb 2026 19:42:22 +0000
Message-ID: <20260226194237.449383-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
References: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:42:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22012

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


