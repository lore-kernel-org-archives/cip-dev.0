Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D912C02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:01 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.7455.1737709260723645886
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:01:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=AlC75qSd;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaecf50578eso430956966b.2
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709259; x=1738314059; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbqTs9unRn7Hi+pzk+KIjC3twFnxhii645av4K0DEo4=;
        b=AlC75qSdOh8UifSM5CSb0UpHlYYYNyya4oyOYg6QUr4Sb2sWnVwxymL82irJoXFUIh
         UpitgjpvA08fyOuZeDOsG5J8sbu/NY4Q7dHDCee7aOVaxr4prcZSvYDMFMDLN6rePA26
         DiJNSytR5DmmA/oZa4z/O6fuEUYDEinLIKgDIQxBh+9BJT6OsXqzUhWPARqRLYiPrpGt
         +3lZ5rB7IPTLMCH+/XoYblYflILSfGElT2PZ0sGizDp6pKycTjuFrLAKl29598HkbH4E
         WhP0b+00gCp5u+GbZsjusMniWNJn0EDQkwRJup/Gv3GateVN1df1nWThLq9V6p4kkOmT
         OxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709259; x=1738314059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbqTs9unRn7Hi+pzk+KIjC3twFnxhii645av4K0DEo4=;
        b=LI89BlohIpL3s1nO7gP9EFISoquq2G+GVx086ld8XmRlXxDjg8Kq5c7AGN1O81diwG
         /ua10dLZHAsSftzIzA2Ja/INbXN8qXxwOKKzyQbDYzQTS/rA2Re4ovgahY9Han73O1sR
         HQfST5vpzhzJlNm0MrPf2ncIgq5/wPTOvz+vtWHE0ymayp2a7t7NAgWbHxOdDcqZkI3k
         9ya1IMtRr+hvhoRBxTVfVqJHm9/NTHdxzvsfHBAPNqxwrH7mb4SDXfSr2CnYfufbU/8a
         TELoSMpm6hROpk1Cf4gyYsq1tJzRkmMcOyp28y8kajF9tx03eNkuxT1mQQRZu2sWT/CE
         e8VA==
X-Forwarded-Encrypted: i=1; AJvYcCUt1dBN8WTI4N9VIXCOfxF/DVW15d+OL6BAHBoJNx5TJbw8NEqRHFjpRdi6DKq5NXgItVDnnGJp@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy+l2495FCmpkTSu+zF2xjcYz4ZgMffxAilww+y7pQ2P4a2iBtt
	iVWiHSExgFoPPWjqCIpjknsUAXqktilt2iYQ/yqpFl2JqpJSuE2+WIp++UwsdMc=
X-Gm-Gg: ASbGnctCKP8jqmCA2p25I60ctyi3Uk1IrxHwcWkjliVmrWpyYYJVo15GxD4e0+S90SQ
	AyffDuBRO6c/ua9m8rv/sWfQKsAB1ji0dMVzYn59+P+/VfwzHUOmgdB2j4iy9fOVSqMJ0X4St8W
	EBx3J33pkEFDnWJv8asqiE/xAVj4dKmPRpXJ4f4z3nMDuVkYRzaYdWTSifibcW7QqHETAsc1IQO
	YxJEzsfway1I8H/zX+Gh71nnN//+Kkjf5sKR1TDN9Zvu/C8BTarFHnAFdcQREb2nuQHuICXu0uj
	POegWgi/X22ylVSJ6fYfDuHU9eC1DoI6bQ==
X-Google-Smtp-Source: AGHT+IGyLiUWG22pObAPr7VdBzxNahSr1JeaPqzIP9OocsnmCjibmLxpqQ7YECdsDeswyaxCht4syg==
X-Received: by 2002:a17:907:3606:b0:ab3:60eb:f858 with SMTP id a640c23a62f3a-ab38b381338mr2644968266b.38.1737709259045;
        Fri, 24 Jan 2025 01:00:59 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:58 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 11/16] rtc: renesas-rtca3: Fix compilation error on RISC-V
Date: Fri, 24 Jan 2025 11:00:36 +0200
Message-ID: <20250124090041.1401132-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17648

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 8f315a5c7376b2bc324d62a8400184da77f25e28 upstream.

Fix the following compilation errors when building the RTCA3 for RISCV:

../drivers/rtc/rtc-renesas-rtca3.c:270:23: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  270 |         tm->tm_sec = bcd2bin(FIELD_GET(RTCA3_RSECCNT_SEC, sec));
      |                              ^
../drivers/rtc/rtc-renesas-rtca3.c:369:23: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  369 |         tm->tm_sec = bcd2bin(FIELD_GET(RTCA3_RSECAR_SEC, sec));
      |                              ^
../drivers/rtc/rtc-renesas-rtca3.c:476:11: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  476 |         cycles = FIELD_GET(RTCA3_RADJ_ADJ, radj);
      |                  ^
../drivers/rtc/rtc-renesas-rtca3.c:523:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  523 |         radj = FIELD_PREP(RTCA3_RADJ_ADJ, abs(cycles));
      |                ^
../drivers/rtc/rtc-renesas-rtca3.c:658:8: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  658 |         val = FIELD_PREP(RTCA3_RCR1_PES, RTCA3_RCR1_PES_1_64_SEC);
      |               ^

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20241101095720.2247815-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
[claudiu.beznea: fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
index 5a8dd2ad6b60..e3a9bb16b1ec 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2024 Renesas Electronics Corp.
  */
 #include <linux/bcd.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
-- 
2.43.0


