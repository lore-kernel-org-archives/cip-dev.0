Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A0EC3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:15 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.10356.1746783308876789331
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NukEUT6o;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so202169866b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783307; x=1747388107; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzFriyDy/RxiDg0ruOMyhKrsxou7jJqrqrow5GAQsSk=;
        b=NukEUT6osNeZ9AP+pOM723rFCK7Z62W8HFCND68qI0ukY2A1Rtu0WQ5isoy7GQHL36
         MDBZDfjmhB2+w4U2a6/7twKPITqlQEXJyUhTp6MNf5AE1XcvQ39K/PMMcV+KDwdj4K0G
         0P22oL0SkKJqcFRp2DnlKBMcFliF7MyYdewIzkzjW0smA+R7SLNCISBqZh6enCTIixl/
         sSBWYCsQIMSerbTSHGwTqgtzUbtoY610e78deOzXgn9SIjDfKdTeJ3Jp4P34NudbSLH/
         AhsCcFl5t7pEr6N5N90jaHc36PtlnCDqDj6b0pKafNjP9OQWowCLVrKe7xgtqew1JXRE
         qZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783307; x=1747388107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzFriyDy/RxiDg0ruOMyhKrsxou7jJqrqrow5GAQsSk=;
        b=k5aGOmC16wRl34FxH0n0kIHImX6KA1po1ZuLFzYbmfjfq0nB7itHosRUnKNYo79MwE
         Z0U8nHVGRdG/FpUiDpY54hQMBXnvs/+6qu6UZtc59tHvi1ikiO9cS4lkp3UJDaQ0MMd/
         y4d5pdLDHr/x3dLdGaJOa1HThEiI/5YQAr56HCF+WbV3GF5R+/GCDvCtpiOaoIF8th7C
         lFrgTBLlLjLF50llUzDy9JnBcGh8v0zBGzuCrrQ6Ze847k67ZS6QLb1Yze+rKj/v7UE8
         qHf0R1j22buQlERrtLZTxUBfRhQPEN42SUuT7d656RefLFhWUbQleuJYykMxAhio0ZZK
         p/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5u11rzXdGnI7LZBoEYhsNfYE4zMI8Z1uSlnBz6kc0VlU8e1h7mH5bZjGZGTXf51Ro2sb12Szq@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx89ETY8jsz1V3TseXQlxkYki+YfoZYwr3ASfNuqVzG+BGYAkBL
	nVjDQ6Xc3b2JKcWLMekApPm9Q4YcG4Akmyxza00EBhOQtjzFYjXy1PjJFUw9rAS2kMk0QTA6UtE
	V
X-Gm-Gg: ASbGncuC5rGGtJlRxPYbNFr5BW8mJn+LJRghj7V032bGBR25ptNGYtIwJck2V5URzoh
	Ez7QxWq1Q9dX1a4Anwi9kUduaJ9P9HsInP3VW1cVnJ5W+0eYPnAvjxfQbq86CoRrnxJ8fbTx6j0
	MC13d9+lp7NtgVnyjNPf95lfhThgsVpGizYi/smZ0xezak7X1ks+ql2cS2IHrPZOo4Fo47zGYAK
	lWivNdXtLiV8Oo/fCw/unx+uwjNSSkjLqiHe+XJx4XZqQcH+YKcBucL57cFfgtJtTMVPp7s2o4q
	1DiYswGjNTOiXw7GTAJwNuzR2s6hLxJzU+xCnogBBMZTy7RQy2uNhx5EYIIG7x/p0HxDFg==
X-Google-Smtp-Source: AGHT+IFt1fCmz37eK/jFvOKybSOrO7AA52z+GjwHcvZiIu0iVKjrKL2k/3QanRQGLG+00LWZFrbodA==
X-Received: by 2002:a17:907:3f8d:b0:ad2:1355:874b with SMTP id a640c23a62f3a-ad218e54d64mr287945966b.4.1746783307237;
        Fri, 09 May 2025 02:35:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 17/37] ASoC: renesas: rz-ssi: Use only the proper amount of dividers
Date: Fri,  9 May 2025 12:34:22 +0300
Message-ID: <20250509093442.4015145-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18869

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 55c209cd4318c701e6e88e0b2512a0f12dd02a7d upstream.

There is no need to populate the ckdv[] with invalid dividers as that
part will not be indexed anyway. The ssi->audio_mck/bclk_rate should
always be >= 0. While at it, change the ckdv type as u8, as the divider
128 was previously using the s8 sign bit.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Fixes: 03e786bd43410fa9 ("ASoC: sh: Add RZ/G2L SSIF-2 driver")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20241210170953.2936724-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index a2cae68245a7..9b99a0318572 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -259,8 +259,7 @@ static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
 static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 			    unsigned int channels)
 {
-	static s8 ckdv[16] = { 1,  2,  4,  8, 16, 32, 64, 128,
-			       6, 12, 24, 48, 96, -1, -1, -1 };
+	static u8 ckdv[] = { 1,  2,  4,  8, 16, 32, 64, 128, 6, 12, 24, 48, 96 };
 	unsigned int channel_bits = 32;	/* System Word Length */
 	unsigned long bclk_rate = rate * channels * channel_bits;
 	unsigned int div;
-- 
2.43.0


