Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C6BC3ABCC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:23 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.10319.1746783136771461687
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=IgZZ9tWG;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f7ec0e4978so3490197a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783135; x=1747387935; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7N39nMVZxUUgmbB8JcP5j6xV9GRvJuLXpsJzbxlidY=;
        b=IgZZ9tWG4mjFI8jSt1jpztRZYKp6AANtg+TAyHXHcfb/Y/oe0QBHTuKc1w1V0rlfnP
         1SDdIAfrIm/K2UH5gi73dlSRf4WVAUBgBbvAshmS9UGkP88Kwu6gxB568KsM8/ZKU4FL
         e2PC9zpVzxMlsqqXsgKuLRwNSM5j8v6Zs5QCHVwdl75rJSJi0x3qYoQvDDYu+isMLsR1
         OplDgv/8akayM9KBpgaEsQnYd9ey/tOGWaYB4CNcsGDSTCEQ1ptQdlsZLAoqh3Fslfe3
         3XqJt+Rk0z7SLAp8hVaL33g0UCkZfFCtVT24yNM0viyXNpcuqGWNTGhseaG+JdF+5Q15
         CppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783135; x=1747387935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7N39nMVZxUUgmbB8JcP5j6xV9GRvJuLXpsJzbxlidY=;
        b=meviYNZmQhadLGh9R/GrpoM7XGAOiaVNVrvI2r55TWMrxenP6AS49dK3QpkkYBd78I
         aT/NcJh9+6Fec15iqJ6EZ3uci8Lp7vGHXpHR9UOF705/tId0HOcFQV6j6e3VqGvUkjKl
         xFPCdJ6ouiPG5Hrmbc0a4zNmotWTyn0Kt5QbbbrC3lkpIjoDUF+TREd3nH8KcOaqf1/Q
         qOXcDt3QtNlyrdDtUmKP+rJd/U7tmxSb4EiHHZuagZJkdjzq7XCj1pBoUewGXqmNzCnN
         nDMJBhvpJDQirQXuLRlMuc7zAZbcxapEY2DVMZK38Sxy6vtKuly4rk6lOcZfbQJH01bq
         2P1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqvyMw9PLhBIqqLxBCdtHy3i/57zAjFTk2DvKyIKy8lwC6eJ3jfeafCWlArEMGd8wT+JxQCzip@lists.cip-project.org
X-Gm-Message-State: AOJu0YyVpWGj0Wq9HNMjn4El0iu0G7DVssxWG/SC0ouU72lvfkLmypcJ
	612Klq8TaZ59ca6utLyPAqf3kHvXCLiI0NL1bYHIyxeuJ/V9dGAGdUdrC/Q0EaZKJwMC3m4X/jA
	M
X-Gm-Gg: ASbGnctbTTVBVFlXL5WK36uh5Y7kQLR+e/GM5L/Jnp5MF61AKjpqUkSbbAwzXeY5V86
	21eN0di3QT3ebb0pHyX2g8pSgJg8ioyE45vSmYL+Qlb+EikYb5FaGpa6y8MJQbsrQbVKvViMd0H
	0hjN/HPTJXLptI+8lWFlrh7Xj1pyc10cd2zVNf2VAn0Y48uEvI8LN4wGXGKcDXrBnna5pWqUeIC
	L4COeNKRa78rwIHYDu8BTGUwM8Zmpvezz48ZDPzKYnbeUTGk+RZaybA7jXa4bGYH97pIa828GBA
	+wH4By48xuhnf/ZlsJNbBBPhcoY3NvSL+tmdXAAUSyxCJ51iRVBSZYbNXdSbspykeS1DBg==
X-Google-Smtp-Source: AGHT+IEugYauWomyZQj5vAH6gOT9s9D7IOHRb8rnhuP/+5IrppLCy3+bzZJFkMQn/w16gBNShjh7qA==
X-Received: by 2002:a05:6402:2747:b0:5fa:8277:3d5c with SMTP id 4fb4d7f45d1cf-5fca081a975mr2026488a12.30.1746783135130;
        Fri, 09 May 2025 02:32:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 08/29] clk: versaclock3: Add support for the 5L35023 variant
Date: Fri,  9 May 2025 12:31:42 +0300
Message-ID: <20250509093203.4014750-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18795

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
index 1398d16df5d0..9fe27dace111 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -1133,8 +1133,14 @@ static const struct vc3_hw_cfg vc3_5p = {
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


