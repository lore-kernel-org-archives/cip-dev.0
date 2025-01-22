Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4563BC0218C
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:40 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.41875.1737546695784171279
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=j6dMI5PZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43624b2d453so74268275e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546694; x=1738151494; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zy5Ld7NGydwRu6FAuloMv9y+mc+qqkUcwb3dRcSgM4=;
        b=j6dMI5PZCTlUhqglFX9R6gmMJ22O0Jd8mVCKWrHaAYPMiJjmNu7q5iMRc5lv5yw9YX
         FflP1U+ZvCL7U1iE1gTXuOc9C2eamC48c/Us8JhOJ7a5v0K+9YnnybO0vEJaFCJdUmbz
         1mXE0JRHdJMb5gJteRROrCRg9PNfatFHEvikqSsueZt83e/msIxquOJ7OtCXNtkVyMha
         d/0zA8OKta0nSwhnc19fB8wOgmBmqTdKLnzq3xuizsQ+Cg5ucTupXNqx1yXhtcS8RUm4
         dODzZxmn4+oLZfImUhjX/rf7ifPec8U3uVpQDTz8iiLuAGcNEtANEwGKn21mv0oIJmA1
         JfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546694; x=1738151494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zy5Ld7NGydwRu6FAuloMv9y+mc+qqkUcwb3dRcSgM4=;
        b=F24sPSsNeCZTLffWT60jRqF/cVpD6vYS1RXRwS4C93GYsh/cke96w9mU5Wec/xp3u3
         OgZ8eY10eD2rhY3NqfWZFgVXaYzRaSO7bWtBr9UwepqcYFdvrmNCgTlJUIBUG3olWomt
         VIcHcScRR48b/83CKtmz9rLDrZyi3EPPzwk8jpVPlfGSQv7j8cHvYInDAKUlJ04xOFUH
         +NpS25DbCQ6TwV5ntHSwXvswVtYCvkHKbE8YfxtaqNFYENGNbTP+Caj412xtSJMdLgsa
         uRlqsEAF43s3Aei7En2kDRzaI0FV31+e+qzEqS8dUxkLx2lrvlPMKJMai+1TCI6CON4w
         wclg==
X-Forwarded-Encrypted: i=1; AJvYcCVc8WT26GETBNo7/tQsaKNZ8hOSUZl5Rg/QanRm+2THKff+8jiDVNR6Lp7uUa6NgDehGpg6tjFv@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx3lDWHyLRFuC80Y1XF3lia8u8kYNq5cgICoRBHNceFEpvivC/N
	/+cxm/fhqlYaZ7WP6pSZ5vqDolh+4PAUN1Z/XHXlbFO4EEtT6GbolW1P3z1VmyY=
X-Gm-Gg: ASbGnctmOIBsVIQEwL28/KwX3fXrdoSj8AXcxha09XzvqGXDA/51PH/Uq49Q5sFtTEH
	LmsMAKtR/JfiKs5R/M3vQYnUmH5XH+mi1N4oXUf8hzg1Hcnn8ZnWpaua3L3YPx5eyI6TUAgP0xO
	kzzJuXflOQzozKL3++HBitXz84UMpar8zMtSo/NqU28y3+k9jAuY6gt+HMEF2p7/2B4l6Ens5FM
	/p4deDfUL8ZDmv3ykQMQQV3cTCsFY6it4DdwBv46BgEso4GkL+45lCR8EAcjJCDdfWWISRAJM3/
	Eh4b4IMr+62V0Bh1tAv4fRjIyyvss8W21A==
X-Google-Smtp-Source: AGHT+IEIVad2LLZxOF/EZpp7ogaRu0TSKk1siGYUxappoq8TPl6+Vj3pcWt8oC3NnhVRc8IZRRqUDg==
X-Received: by 2002:a05:600c:4253:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-43894744f5amr212454725e9.5.1737546694179;
        Wed, 22 Jan 2025 03:51:34 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:33 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 09/14] rtc: renesas-rtca3: Fix compilation error on RISC-V
Date: Wed, 22 Jan 2025 13:51:14 +0200
Message-ID: <20250122115120.2885015-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17572

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
index 7683df87eafa..4bc28680f650 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2024 Renesas Electronics Corp.
  */
 #include <linux/bcd.h>
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
-- 
2.43.0


