Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA07C0218D
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:31 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.7433.1737709226560031321
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ilkagwqA;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43618283dedso18771145e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709225; x=1738314025; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zy5Ld7NGydwRu6FAuloMv9y+mc+qqkUcwb3dRcSgM4=;
        b=ilkagwqAVV19suftjCYFmEydoNKAezUfPuSsNNw6X89DUIWDpsdDa8mddUj8zkgGhM
         eAgX2v8PBZDe1zk4t4yG6UtDQ0qfP8KVt99Nh2WYdTr85po3Zn6kpj0FiQJ34TBNkGBq
         IwIKytltd6zC1rTYO4clAAVaeED+87UtRPkfNWG8S8lme/15McfARMVS3GY/qIBRY/hd
         AtJEgcPFuPNZL46MMAMNtveV42grkurTBDETYL2aJxcPYgNf+OFbdDZGEW6qqsO+ogQK
         yaqOzSRDcm3XmcLvTQHSlfmn9V7wf+g3lYPF1a0+x1KV7d9Qlr/xlBqflQEa9tRq+JxJ
         VZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709225; x=1738314025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zy5Ld7NGydwRu6FAuloMv9y+mc+qqkUcwb3dRcSgM4=;
        b=wo52HgzQt/gdAPcjZ91LQlK76VinVXv6eE8qJ0UECKedgxZRughWp7mvhoQ3tbyX0S
         WMsoKr215HLX/+VPxqYjjq89NjsDTyFICNO7QANfLtuqxhwna8orHOKJFilipVDP7DUm
         npoeszDoq2uR3GnuVIIdWlAy/aYoCeEyQQ3tCBCIGlqJOMeYcKW7BljAjUOoI5mAEIU/
         x/RZy2ME8lCncDxumBNW17kd4uVuPAmlWm51rtCKVExZBbTaei7CMC+cBMjk1R6UrJxn
         ySjbgrC3FbNJD6KYaCVekPzqRkM83wBJZIsT6aR0Okpa2TZw8yJdBLZJxg2tsEGwp6uI
         DA8A==
X-Forwarded-Encrypted: i=1; AJvYcCV0laE3HPqopFCqbFHWr53rRUbfTIV1zFlhFySofkEdlsInXiSUHCiva8iS4QSw17EU+eW5Bktr@lists.cip-project.org
X-Gm-Message-State: AOJu0YxyITBD65kZ5wjtLC6aNtMh/G1X695IDO9QdqW+t76JIbkbqZdE
	17foXYi/C4C98CAyWPBBhk+KFJzpE+pAhcwNdC9H5F/ZTX0+1cSsXc4S401+gmF91l2SNpRCHd7
	w
X-Gm-Gg: ASbGncvO1ySCfaLgPeS3/qjryCjM2uhmDWEdZgaOdckFs6fpeRT5Y77DWTvTSWDNbVb
	rhpcDwcbabGTh0Tp37Z1M0DsEKv5XQgtVlYLBa0lI8dI24KZW1oWPU/x9Fyk+Nr/eRt11MvM4bh
	QfKbnUFd2qi/sO2bRILDb66otwKy8odQuNMQ2c4eoWiqSAOS6AIFxb604lMHvhhTjZgyUwigAbj
	uaghdzAZopY7OAKsXXjSwZNVICEFjsBxG47cpVnBniF3Pobej0tdivCTnBoG8oWW040fbgxDDFt
	yCo3zvYcXNtMFzR4JGQSdEkicde+AjduXQ==
X-Google-Smtp-Source: AGHT+IFCvEjAIVuoB/XThAjpm6EI1tQtHy3pzXl6cun2QCNbxzgtI7GPd3V4LsdK4gcHPWJlnPNuYw==
X-Received: by 2002:a05:600c:511b:b0:435:14d:f61a with SMTP id 5b1f17b1804b1-438914304a8mr212277605e9.25.1737709224988;
        Fri, 24 Jan 2025 01:00:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 09/14] rtc: renesas-rtca3: Fix compilation error on RISC-V
Date: Fri, 24 Jan 2025 11:00:00 +0200
Message-ID: <20250124090008.1401077-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17631

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


