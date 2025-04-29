Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD390C3ABB0
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:07 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.20346.1745934480190643328
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:48:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Smr4YRXa;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2c663a3daso1194138266b.2
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934478; x=1746539278; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBh0VtvA0bdGwydjFJP9tmT8PaEiwF5yU6SYfHp3kDw=;
        b=Smr4YRXab6Mi+sihWPD0Brzz/VYhWMFnOYJ5Tsw6yuNsrzuyPmB7xis1p5gPkyEKPO
         obAzJ3EKprXdMh4ueVsDJdLO/Y1DuB0hgIJP0V1j31ahVlu9/l0rtp06iiUilvPRPX78
         JYU6KBgbozKmPxupey4nTbywnrp7E1Q754Mpl5wBAI+6xy4opGl9w58VPP0xHFt6AGer
         DtZ8Qv8YkRXwfWRRfkBWfaLZMlSZtAG1C4R4qlcS+JQgqsnL1Mio0x8BwYdxorc7eHUs
         GPDn8xpsFXyglOeCM8bwRE+X1iCz/ik+7jqhZxX8h/DnBSc0GGGOHZ0aZPsKe2ajK2eq
         M/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934478; x=1746539278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBh0VtvA0bdGwydjFJP9tmT8PaEiwF5yU6SYfHp3kDw=;
        b=KvLgMzYVpSFcWpBmdDihBwwp2TyS81Y6fME8cZwtQeyv1/CDHEVXtBUMSgubS1z3xN
         P0zghKn19QVk90n/imPDeLVGdDYLF/6KUWjbpyCP8/ACP58uIQcG5x7CWNasuqJOT6Ax
         Rr80x8QEjo8b2otoFZrwuB53Hsw7CZhMnrk1eoP6V1UMyiZv5de7woZcy+cbu1xuNX8J
         GYC0WP93kFVj3E2BnF6meuwbhAGN8W9VMiNePI17Nv1zJN0EcXPZhjdW8J41t1xxALca
         duRaqbxAZUzd3aq+d6BiR4ae6R82KQbvhPfV2hrqrpaZ5gsdTijF8azmS9PseAPLsrnv
         chdg==
X-Forwarded-Encrypted: i=1; AJvYcCUrO+4lT5OfX9Ule8xLLixY36r1D4+e1jNf2+VdsspBuHvT99B2jO/KNWZqknWpmj4Ij/07pHu9@lists.cip-project.org
X-Gm-Message-State: AOJu0YxGunBbn60CyspMwgErdYzyFbiWmg32e+C5FrH5EdYIf3OAMNZy
	MXUrIU5xzCOeA9GyPIeLasXh4rJhLuIFqF3p5dzGLtP85/qMDIMDhrPvKQhokuY=
X-Gm-Gg: ASbGncvPt9jCpaNNriBZLA1NkiSTacKAxwyN4Lrx/OWNzR1V75elfEOWiwpXqtPRWxF
	PckNJFtCPF/wjJzNNuU7emq2+NmxbkIv5+Y5HcOY2rO7V9AwgmpgiXLcOqcZ+LMlVPOxdCajIfv
	BXPJMsRzKUq7a9jMi920tNHI0Uizp62JK8/Xt2DkvmPLLOD7GJFEutE6c9geOk9r/lXyUvwGPas
	uvvbMmb8Ah5WRilak0xmkHjMrZT7FhoKMYr2KD0gk43AcMJxcZmCbL1+dy6ixnvtS6rd7x2beaE
	WJiLHxwOidHTLHI+hjep3UNDuWjBXH3ExsTr8muWCSCSJbYPwIgzsZuXb8oSTO4pgFG25bQ=
X-Google-Smtp-Source: AGHT+IF4p58E5uUTCqRIyqf71a6f/4b+6ljP09kJt8K8WuqR91LgOeLcf0WfwFUwbO7keXpZHGLCTA==
X-Received: by 2002:a17:906:f114:b0:acb:5ec4:e944 with SMTP id a640c23a62f3a-ace848f793fmr954976966b.15.1745934478561;
        Tue, 29 Apr 2025 06:47:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:57 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 17/21] i2c: riic: Simplify unsupported bus speed handling
Date: Tue, 29 Apr 2025 16:47:23 +0300
Message-ID: <20250429134727.2429662-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18730

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 71dacb2565ed9d2839adb8e2a80ef30185c29035 upstream.

Simplify checking for unsupported bus speeds and reporting errors by
factoring out the calculation of the maximum bus speed, and by using the
dev_err_probe() helper.

While at it, use "%u" for u32, and improve the error message.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 8070d60d6974..1528912d7a13 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -317,16 +317,13 @@ static int riic_init_hw(struct riic_dev *riic)
 	struct i2c_timings *t = &riic->i2c_t;
 	struct device *dev = riic->adapter.dev.parent;
 	bool fast_mode_plus = riic->info->fast_mode_plus;
+	u32 max_freq = fast_mode_plus ? I2C_MAX_FAST_MODE_PLUS_FREQ
+				      : I2C_MAX_FAST_MODE_FREQ;
 
-	if ((!fast_mode_plus && t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) ||
-	    (fast_mode_plus && t->bus_freq_hz > I2C_MAX_FAST_MODE_PLUS_FREQ)) {
-		dev_err(&riic->adapter.dev,
-			"unsupported bus speed (%dHz). %d max\n",
-			t->bus_freq_hz,
-			fast_mode_plus ? I2C_MAX_FAST_MODE_PLUS_FREQ :
-					 I2C_MAX_FAST_MODE_FREQ);
-		return -EINVAL;
-	}
+	if (t->bus_freq_hz > max_freq)
+		return dev_err_probe(&riic->adapter.dev, -EINVAL,
+				     "unsupported bus speed %uHz (%u max)\n",
+				     t->bus_freq_hz, max_freq);
 
 	rate = clk_get_rate(riic->clk);
 
-- 
2.43.0


