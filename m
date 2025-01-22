Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760DC0218C
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:50 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.41913.1737546767994711193
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Wb4wlZsl;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so69948605e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546766; x=1738151566; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HPzZZCLSVbtc4np5bDYcl3oLJxIAIKhjbJRvMNwAW0=;
        b=Wb4wlZslTV6njyzpsmwbSYexXPhprLgo4EUD9PPSI8ESsSel3dXdMEObFgVHRHKlvO
         owakedk52cHlroE0uiYJC/uf4/+tqRR0S4dKwKo/m2J5AlDr7hkbRHyFdtgEFHCa7miS
         6XrWABVcQ3zsuJFo/Z7414D2t7iJupnstIywX5VvX2IzFqG+CqWv0t4ZON9rI4Sj7+aM
         Tzg7GA/pMMol7Tflp/iWxBvYBxG+aRILdEAmB0MCSREEf+7tqazTlMZ5UmtoWO9cgHEl
         AV7ISuGAMLgpqwKJO8Dp2FX9WxGiPpR+LgpMKWIZLUIXKUjZ87xXstThfRFvwySJyxbb
         WMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546766; x=1738151566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HPzZZCLSVbtc4np5bDYcl3oLJxIAIKhjbJRvMNwAW0=;
        b=LLFIfpbcV3MZ/epb4KqfFVQZH9r4NXgCdKqEkRmc4sZlF8SYNWPz0C0dx2XsgvjbYJ
         Wwr3i1mRCRav4p/kl6gRTUptTOCXbe3nqBh1+Yxo0Cy5HjA7bR3Oalk0/X4O0A5uVyHx
         vqjelbEhKlZ2yBlIKHEiuqdyZ2nGcju4PYUuVXyO5Mz2EEXGCCVMJ9QavfkEWY1a12ky
         7bFclC07bWDk3HnSoS8AnPD74ftYM9hPo+a62GcqGIMmZ9H4ktYRKMl8/NG5bwqhjWIP
         cnSFjHkS8n3IZRhqj63rYWFnq1cLmFdwEgvT6CL8v2NjJTelaZ/o2RImgYJUngnJNVMa
         mpUA==
X-Forwarded-Encrypted: i=1; AJvYcCUWYJb6H+q9HiUS4/UcvZinlE9eqwAUrGcoJj4ACV/CyRyZa5a8VO6Eu1b2hvPChP0Jo8YoA5QC@lists.cip-project.org
X-Gm-Message-State: AOJu0YzDSGHpKykXz2fhQmIP3Tpq1GF2cdzHgJg5aZhkcv0PminYx4yL
	GrufSopX05IpBvJQla2PP/elInW41T1ytfx4RoI9QyoLarzI4DZTphUjcHCK/hM=
X-Gm-Gg: ASbGncvTIj7xwDIsLNPgr585XCC3MQJTc3BR086LpvPM5CFBIhxP6w0R6q50Wxoqbix
	boCQspbL6N5363peWNAJ6WfnzWqUDKgl8u8qDGvZOlug44jnAJSAcgxv/e8Qa1kxCZp9BzYbydC
	sPMA2ooH1NlIfS6Ars6Vj680081vWNLAwwvpDzkMRDnLu/jN0r6veeO1+8ljCjjZBezzSfgQ3qZ
	wMXE7Flzu4e54P08HKswipO70gg/FEOSoTwtR879MRpb8a3N5wCUse5MuOL5HYhNfw7wJDzFO8T
	HITXCOm9C6FNQaAoBb0+lZo=
X-Google-Smtp-Source: AGHT+IGuQISCj7D0unMOLbt091WOqEYOutAXEKjhTGCDumCXxDah78RiHXd+3mC5MlIsHUFLtsvfBA==
X-Received: by 2002:a05:600c:468e:b0:436:5165:f1ec with SMTP id 5b1f17b1804b1-4389143145bmr202336945e9.30.1737546766391;
        Wed, 22 Jan 2025 03:52:46 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:45 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 11/16] rtc: renesas-rtca3: Fix compilation error on RISC-V
Date: Wed, 22 Jan 2025 13:52:25 +0200
Message-ID: <20250122115230.2885344-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:52:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17589

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


