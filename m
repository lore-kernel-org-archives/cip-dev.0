Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D83CDC190
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88497.1767701182206023545
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UiD2/Vtt;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47774d3536dso8451635e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701180; x=1768305980; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEf8BhaEqIkoXFhuH4yOrS21hTk8juRb5eJGyncmfew=;
        b=UiD2/Vttu+KoMjYqBI/ooM7Dk5ZFBpjy3qnlvRNaZkP5vyGn3l4BgIFCgjUG3irA0I
         f5OOzeHordUL5FZsaLMOESLwACx3ONuGO/ciUXHq7Fs5BBBz/6uGzIs8jeen2kYjeih/
         zZqmcbGUf4OaFS1FmozW34ZsC0wsb/EZ70+jpno/zh9UsFPZlyL/Q7YLvmc67sqbQQLx
         s7S2GizmtbqoTBYvQkfsGLQRKco9XzeEFNRrgnjNTiDAjM34mQCxHEDmQTwEz4lf7HZI
         H0xCbuGfaDGyCUprWI6+urlGOYEzREElznUN9rxQnMWiCkvpLbZlvYOcVE9gNUAFhSgV
         2FkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701180; x=1768305980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEf8BhaEqIkoXFhuH4yOrS21hTk8juRb5eJGyncmfew=;
        b=f94l3dxiEe0kn4rfkypsThpTuoTCArRzCOc+TWLmRvrpVTWnHHFeG4opjWFeIzwcWD
         c1/tz9IcC8wR6SnctZhLtxC29eZLSOfiyApMHvEJ8Y0QaEDueDE1RyenSVn1P9b8vRd4
         oeX4CLBKVvZEKl9LBzCG9Ta3RycNHBnbGfFPYG7ztcknP32fv+a/4Kuh1lbV8xzIAoA+
         tF6OiWBm5+WEdUmrr88KWbqw+Cs1sNRlvk7C+m1+TieugphgEj31P7ueRkwjCluMuyLS
         FXAcZDMDKGHqbW4lWxrb5tTZITbE7c3Fy70X1Yl3qsyIqzsyoAvgI470sjq8qiaSAx9F
         c9Qw==
X-Gm-Message-State: AOJu0YwLasR4GZZXL6RLoMwDiUUkb0TAYlag7jLCcrfJvjXZHrZBVU5q
	xbYh8wuWwrlhCxRQTQCCamhjTTHhK0a+8N8oori+Yc5cvEA2IPNdo6CsrBqoLQ==
X-Gm-Gg: AY/fxX5e04yRGoAyDOxYc8PgoKOMgUUZS7OGubV8M6vKO/1bWOBm5kUyVTsDxUYsHgG
	MrNa8+3nm0b+qX/4DD7tPq4PB2zM7wK2GbI7dbKYZvkiCJXZeypuyDUjGYpjTKoQpJsdgpldjtW
	J8NBQgXVFFag8gv6sRrpfxJwFGlQZ55B7jUCqvv9wUjCh7B285fV1ycZLajRxdbnawkb5sV9xeE
	+y4Bl3pyD15Jc7pBN0AKTawUZ+el8oAbSFKlpxJbKf7BCDPKZzwKtuIYD5TpUkJXs5MrYz1Z0my
	NEdzZil6UbsfzJHXXDHdwEjsLO5Bpq3CiVYpv/dJ2Y3nnHLPSI25IGUuf/iKzfR5SPBLOud51q6
	Xavr4oZHzrKV2x9g0VfbuDNClc5zV7kAnIJOd3J0M/3CyyVVuLgqD02FOrojsnt7niMOUNoMU6Q
	Zvgr980EmBjt/HFNBha91bShbmTzIQ
X-Google-Smtp-Source: AGHT+IHSBulIG/noWYe8UoaPtEAz4IsZ/gwrxVZ5mieoWU/4yHCDx/i3RH3XGaAeIMoUvFvAg7VrQA==
X-Received: by 2002:a05:600c:1c1a:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-47d7f417295mr31074625e9.8.1767701180374;
        Tue, 06 Jan 2026 04:06:20 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:20 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 02/13] pinctrl: renesas: Mark local variable with const in ->set_mux()
Date: Tue,  6 Jan 2026 12:05:59 +0000
Message-ID: <20260106120618.181104-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21362

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 731b30f6aab7c45bb89372c3c05b711cee362b69 ]

We are not going to change pins in the ->set_mux() callback. Mark
the local variable with a const qualifier. While at it, make it
also unsigned.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231204160033.1872569-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index b196105ab293..062e109126a4 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -559,7 +559,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	struct function_desc *func;
 	unsigned int i, *psel_val;
 	struct group_desc *group;
-	int *pins;
+	const unsigned int *pins;
 
 	func = pinmux_generic_get_function(pctldev, func_selector);
 	if (!func)
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 593b03bacad2..2e58495b26f3 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -165,7 +165,7 @@ static int rzv2m_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	struct function_desc *func;
 	unsigned int i, *psel_val;
 	struct group_desc *group;
-	int *pins;
+	const unsigned int *pins;
 
 	func = pinmux_generic_get_function(pctldev, func_selector);
 	if (!func)
-- 
2.43.0


