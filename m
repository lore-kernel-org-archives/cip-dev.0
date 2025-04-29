Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7958BC3ABB0
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:47 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.20339.1745934461023667418
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=FR6Il8Yt;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abec8b750ebso986479566b.0
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934459; x=1746539259; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1caPG0Bg9QooMiw/Htr0sR+hqCJGoSF4vo5Pu968co=;
        b=FR6Il8YtIMg+fUSZoHtfcwq4XR5qN62B3px7HXglDeMRhCnRBe2bhgTzwSONhm3RHm
         6GNwXJk+rERTm2q6w8XaYikdLUsXij9lc732T4etpoTdnbfTNMzFupGUNbj3ad5Gg9Hm
         2En9H72VSh4P08t32sjioB17OMuR8kWjb8KJn0ZchwrdJHlxKn2zV75TchdmOzkSVojW
         f1azz3ixIxWGpEQsNyXcLj3EjG8N7eGXjDYJs1rGQMLrvAdjnbFCH5JS10dnNwAmGhT0
         06P+h92LC46YmNN/3l/oOd0tvZkeKClAwd3Q61J6TrmoB5kFfgp4zGzTmADXEkGi3I3Q
         weCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934459; x=1746539259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1caPG0Bg9QooMiw/Htr0sR+hqCJGoSF4vo5Pu968co=;
        b=fcEsJrj53xMTPltzN19seTtRWl4QQYfNWbWuZvBTRppw88Xf/+gs0Fe0mVSH7UjIsZ
         g7bFcd41g3DDFnUAShBfblOlDS5tsG9IjC7nw8BaCaOXqoCTfq4iSFfmWu3qoycnvoZ4
         yInONa6AD0EF5FnZsSH5GMpRdeCeHB9PtulKvIX+Z0DYsIbO1J83GAcwOGdYiiFBYr0H
         fiv4hoyEAJw4a8XjoGTQY++m/yCF4NX229Cz5KPOfHnaCdmrR8FkScDSCSzq7DVV0p3P
         0FnI0lB+0puUdOCB/T6shLlcB8eBjLiDvPKeZY8FCo1gm3y1V5uZc2S6Fbcq4jmlXQv8
         K6+w==
X-Forwarded-Encrypted: i=1; AJvYcCUIR6xHNybxhDkrcai26WVSkK4xkmuevwict3ob109dlkFPeVtjjyJy4N/9lhRdRsf8N8QVXaSA@lists.cip-project.org
X-Gm-Message-State: AOJu0YzDEm1B+nu6UR9ozPi17LLdOjfAh3j3bz2ncMxk+7Og8XFc0R6N
	oCBGPmrx8y+sPJjB/9I7nOQwgp1j6N84SsZpDAyjmE+WQTSoTLhXOPTGcRjKa1E=
X-Gm-Gg: ASbGnctKqKDDHiHBbnoiI+YQ3uBN5os2SLv9UgphOgkfsg9O7RaUqI7b2qkFhlbc02T
	+5Kvk5ObIWUr39Rm1nRpMzETk0Y8CHJpAPYxMistHxqrgoLLJ1+5DBgypfgZaz7cK8NqNRPVPd0
	qFsyvAQvaYVdSIR9Q/o3+EbJcpPtBP9i54dUD720K9lfucCYO4BBaRdsbEVYyiORG2jP8TzutDp
	Ix7L/rlF72CR9dtbMyD+5ZIy5abS3KhHcfqdhClBgdCiKMoUrZur5dlZbGkQsxSh6JRbmK1Z+P2
	UbMzw2Rlq1QlRsMXTqVv0UwmZQW2PAzOLGnRYVfH3tSM6P+f8KfTJX2EEvyhrra8rd9c/yY=
X-Google-Smtp-Source: AGHT+IGU5zUFDk1bdX0dSArET5bUkukH1eG9j2bfnhnCJ0SZpIPBFa2AhgnQbSXR4nnHXt5MbxCSDA==
X-Received: by 2002:a17:906:dc91:b0:acb:4f46:9d18 with SMTP id a640c23a62f3a-acec849d0d6mr319229566b.3.1745934459417;
        Tue, 29 Apr 2025 06:47:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:38 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 06/21] i2c: riic: Add support for R9A09G057 SoC
Date: Tue, 29 Apr 2025 16:47:12 +0300
Message-ID: <20250429134727.2429662-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18719

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a45f95d7480544fdaa9d566cb4956d0ca5d0dc33 upstream.

Extend the RIIC driver to support the RZ/V2H(P) ("R9A09G057") SoC. It
accomplishes this by appending the compatible string list and passing
the RZ/V2H-specific OF data.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 3dc806f72b78..9df80c4c2b5b 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -526,8 +526,25 @@ static const struct riic_of_data riic_rz_a_info = {
 	},
 };
 
+static const struct riic_of_data riic_rz_v2h_info = {
+	.regs = {
+		[RIIC_ICCR1] = 0x00,
+		[RIIC_ICCR2] = 0x01,
+		[RIIC_ICMR1] = 0x02,
+		[RIIC_ICMR3] = 0x04,
+		[RIIC_ICSER] = 0x06,
+		[RIIC_ICIER] = 0x07,
+		[RIIC_ICSR2] = 0x09,
+		[RIIC_ICBRL] = 0x10,
+		[RIIC_ICBRH] = 0x11,
+		[RIIC_ICDRT] = 0x12,
+		[RIIC_ICDRR] = 0x13,
+	},
+};
+
 static const struct of_device_id riic_i2c_dt_ids[] = {
 	{ .compatible = "renesas,riic-rz", .data = &riic_rz_a_info },
+	{ .compatible = "renesas,riic-r9a09g057", .data = &riic_rz_v2h_info },
 	{ /* Sentinel */ },
 };
 
-- 
2.43.0


