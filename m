Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B623C3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:44 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.10296.1746783218742966592
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Lwh/Wl2K;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fbda5a8561so2764296a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783217; x=1747388017; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCKI+p9G8oY5XXMO75VFGO4+amOGTu2mPiRofB/MK80=;
        b=Lwh/Wl2KGY8z8gnJ7p4vEtd2XauVg29k54HTefqe1U5Nvd9Ix1PjdiGGNdzWRyFt5y
         WCYjCmH9osnl3xiCOddpMZt7bZzaUV7Rgkun7n3jbARsEfgdm+l4RXXUJQg0OE4ryJkk
         aTryeBHV9Z+HyqlXwUKZFD6ZEbeu+gnJW00rRFsEen5RcxS9lI2IPqxsCHXPkwm40UEr
         a7J1PBUyaKSCnoZrLzgj32bETlpVux5Fr6FaL+VHIIyczWTzlH04EeKsZ6xVeIa7trAW
         cwWo3HofMnK4SSWz09bdAUt/o3fr+QQsJGjUX9UWu7DrsgIV/Jm+fuM3iANBuKmzFfmG
         HGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783217; x=1747388017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCKI+p9G8oY5XXMO75VFGO4+amOGTu2mPiRofB/MK80=;
        b=j4fe1RFqDN5KLgxedUDCkjpBZP3PrfZpy0gJlJSOHsP6Z+8v2jONY/MovZ2dsUGb13
         VRIgXqzZ/0daSnq63IM/npJMhUVtJ4PIbKdEB86mPwAKPDaGgil/c2DX0iVtTOb8PMgF
         OIQ81fFBNP+59sMKC1Ek8TgSOUni2aWA4r1ZcjqSI2q9JTMCCocVkvbTdAu+2Qo4IcRa
         rvGbTv86Ohhjh+Tfgy7AWpurLC8obzZhPbEez0wSDxjemw/C3KciGwpPhnOf5wHMH8yB
         NVZpZazTRxVWd6Ez0B1HGvPTg1tay0cLbhhmDjZab/WPKbuB72YQxLrflwbFhoXDY9q9
         WKlw==
X-Forwarded-Encrypted: i=1; AJvYcCVb3kTK7991ohYWCWWLH075bpIZivzQ71jcLHzKZOvIBhAwksWUFf/jdRLepKr5HmqjkHRrtOBE@lists.cip-project.org
X-Gm-Message-State: AOJu0YxhfFRDrZ6hShhTdsRMg1F7ZIhTBVBuZOTmoNw1C/XccXro4IoB
	1y2NGXe0zTJFWaJG7dOQ2ndwUCZYD9Whpz9RQmLi1qHExuR6rsJBq8lbnxLlD4Y=
X-Gm-Gg: ASbGncu7lz3cIO+fd5aqiT6rlkrjJp7oh8bZYgYIXOJBJPGSXsUWf4A3z+LCnzXDEUV
	W0TdWdiy3qlyD+H+xGaqmE+2lZbvIK5OW/dwxy8GOSi365R+3+Gj9jXOke7hy5x3+jNpzCprR3n
	FcCC2wx5VnPrdH0nLQK381XBWtjJr6O7xO1x7XxqQLb6Sp1ET0sDjHGJp+usI8dcuF2mYFKcaa1
	MES21obz7LGpvS5iyKQkH2sSCXl23lGMmJqexb1PIT0pgo6ulCKUP04Kv8Mabr2lPiD3w1a85nr
	CLSq2u2tbPTjlxFpmzT78iZApfLvdH3g1lp3qtCGS5W+nqzY/bKFboFLz0V41NL6xSNkaw==
X-Google-Smtp-Source: AGHT+IH2fvspE0k6q9Le884navEJiD8LXZkvnxYKmn7F6fGBzaJH7r5I1w0GyBlrAFnsE3EuQYUeGg==
X-Received: by 2002:a05:6402:280a:b0:5fb:f347:88cb with SMTP id 4fb4d7f45d1cf-5fca075996amr2023596a12.13.1746783217129;
        Fri, 09 May 2025 02:33:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:36 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 13/34] clk: versaclock3: Add support for the 5L35023 variant
Date: Fri,  9 May 2025 12:32:57 +0300
Message-ID: <20250509093318.4014916-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18830

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d3dcc98f65dbd364ff839edecf39d1a1e949ee90 upstream.

Add support for the 5L35023 variant of the Versa 3 clock generator.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20241210170953.2936724-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index c3e33d210689..049444f6a7ac 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -1139,8 +1139,14 @@ static const struct vc3_hw_cfg vc3_5p = {
 	.se2_clk_sel_msk = BIT(6),
 };
 
+static const struct vc3_hw_cfg vc3_5l = {
+	.pll2_vco = { .min = 30000000UL, .max = 130000000UL },
+	.se2_clk_sel_msk = BIT(0),
+};
+
 static const struct of_device_id dev_ids[] = {
 	{ .compatible = "renesas,5p35023", .data = &vc3_5p },
+	{ .compatible = "renesas,5l35023", .data = &vc3_5l },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dev_ids);
-- 
2.43.0


