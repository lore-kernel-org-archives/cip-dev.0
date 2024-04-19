Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC26C41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:17:57 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.15282.1713514672691968675
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:17:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KoIrbsr8;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5252e5aa01so215413966b.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514671; x=1714119471; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzUnqoqllAeG5Q4s0FFdN3G4tgjxxEE0jZzDkFXGTm0=;
        b=KoIrbsr8i3HyV5dUZytVX65phk7qeqHFpunwPqs2S2XFPBwlTx/uy1PCtxX/NT8pkL
         G7QT3JLdZhRW6Hs5cKvz0Aolw/WNlF9vpaM1IyeyFGUwT9M8zCKBr7o/CvGfuXD+0CNK
         mcCfSKD6Dw6XEsgH8lRaUlmTa7nORrI4oLtBEZDTBvAgrIqyN8vldJiDsIjY955CDg87
         /6qYjRLD2xPia5SyiJzDG99ZFDmS7sazek7IQpkdq95lQHye9JBTe3VrMGxPwQvLMw1W
         u54jCBdhofOv6tVMtGSCf2feKg/jiz/nVLCV+7FOIyoGg0Qeh+IQVj19XCu2dVCfDX17
         yprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514671; x=1714119471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzUnqoqllAeG5Q4s0FFdN3G4tgjxxEE0jZzDkFXGTm0=;
        b=bGaSJ9MbJtcmAGH/bvzRSrbAy/GjNp0DWv0E+TVVhz/xmVYPhsXTgXh4ch01mz7Y2f
         AVH5bhHNSF0AunhF6LjpxzxxXN6jBP1xpQ9zNEr/3HiU2Sgx7HP3avVk5SuS56WMoGdK
         L8FFzda8nW6JjKVayYUFbDORaCqz/y8MLsb7KEamApsAYE2//1EL2KvGKipedFLKOU61
         GwnXPDB0qMI4I/oSemF/LUAFQnZ9lDpV/6jvdc5kFX6Wh0CqCYUWOCvAIBwCQqlwfZ9F
         VsxTgKQTSdcYwWFM00jrERVhfqY1u3B6I9LnmjFwadXPoUMIej0MFjMuaGCiceFDwbtw
         m4TA==
X-Gm-Message-State: AOJu0YwjmEFCOTVm7JolsBUy9gbxaODwhg0FO4S3cpaL/227z3/mBKMT
	woofr7AFC41niFwzwkFdqpmEjor8h/CnT4GgUh56YryUYN4FQyL6UejNVpAXi6o=
X-Google-Smtp-Source: AGHT+IHL8fVjhZxyWCIizny+y61ohQhQi7z8yqIlHQ0U/SRQRCePjHJyr8yU2+unHG5XmNkClgGpXg==
X-Received: by 2002:a17:906:4806:b0:a52:5df2:ab4c with SMTP id w6-20020a170906480600b00a525df2ab4cmr965608ejq.16.1713514671108;
        Fri, 19 Apr 2024 01:17:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:17:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 04/53] clk: renesas: rzg2l: Use FIELD_GET() for PLL register fields
Date: Fri, 19 Apr 2024 11:16:53 +0300
Message-Id: <20240419081742.3496709-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:17:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15591

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 72977f07b035e488c3f1928832a1616c6cae7278 upstream.

Use FIELD_GET() for PLL register fields.  This is its purpose.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-14-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 330aa67fdab2..3035b1535344 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
@@ -39,14 +40,13 @@
 #define WARN_DEBUG(x)	do { } while (0)
 #endif
 
-#define DIV_RSMASK(v, s, m)	((v >> s) & m)
 #define GET_SHIFT(val)		((val >> 12) & 0xff)
 #define GET_WIDTH(val)		((val >> 8) & 0xf)
 
-#define KDIV(val)		DIV_RSMASK(val, 16, 0xffff)
-#define MDIV(val)		DIV_RSMASK(val, 6, 0x3ff)
-#define PDIV(val)		DIV_RSMASK(val, 0, 0x3f)
-#define SDIV(val)		DIV_RSMASK(val, 0, 0x7)
+#define KDIV(val)		FIELD_GET(GENMASK(31, 16), val)
+#define MDIV(val)		FIELD_GET(GENMASK(15, 6), val)
+#define PDIV(val)		FIELD_GET(GENMASK(5, 0), val)
+#define SDIV(val)		FIELD_GET(GENMASK(2, 0), val)
 
 #define CLK_ON_R(reg)		(reg)
 #define CLK_MON_R(reg)		(0x180 + (reg))
-- 
2.39.2


