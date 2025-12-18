Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8999D6E2D7
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1412.1766076970895295352
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OBgj3Aq3;
 spf=pass (domain: gmail.com, ip: 209.85.221.67, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-431048c4068so535277f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076969; x=1766681769; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O05izHp+Y3/yhvf4IhjvzJbglPcV3Gu3zBNH/Zaa3F8=;
        b=OBgj3Aq3WFv1SldqiAoA6ocCeP7NEgZR025GFFtjs70xASoS6w1qxQACAW5P7Vh3N+
         5JuHpyPr59RCJ/dK6yyBGmMz9uYigEOL4r4wgg/fsSm5izhNBMQTDP26vQjAdpfQPxjr
         7SJKDOTaVBTPU8dnCwt4y4hycBkJHpXX8YbkXS1alfFhrrSCprh4z+mMVpxGsEXzrW6C
         x1YxvbSi45W4tuz0P2A/5FrI4y87wlrYP2arPYkLgavk/ZHsMEO97v3lSMyBpWHgFsyX
         2HB+VpfUz16PPM4KJroWqdIP/JEebFDeoMzylOPOyy/NV9JkC3wRiM1PZJBnhM3dKz3i
         ZC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076969; x=1766681769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O05izHp+Y3/yhvf4IhjvzJbglPcV3Gu3zBNH/Zaa3F8=;
        b=SeBlrMpG5k/tcxU7Lbo2FRGXbs7mHZwpJNg3zl1jNeRW4tBDuQaZob+QM+3DjyiKUl
         dISRpnYLiXO6AUQExO51b5uark662Z9DsSmABgQh4n2xaRNvnqjgpRmqp7noov7m9Xew
         J0nfQHu3KlBIEsKAhgsBKqC8bl4KI9JDNrr5HzP891xqpGCNLStdPIuXjUm5ThflDsuU
         eFwNyT/p/ORXfSysmT05fihQOO8mpavpj33wAg0CVNbIXBW/pRC+5dprg2b5DjkqyTOm
         l2KmtMnqZK535oCGlrPbqFOJms8q49qEmmIG3qO2+mjh8uBWZIKWKSl0awCmEQCKnBL7
         zZlg==
X-Gm-Message-State: AOJu0Yx4e/uwSnaj0a8rPNccH9cJTUVYn+T+I/27SUKDseD5/vkAqlc1
	pb1NTq7ylXwITjh+uR/iZZiUaJRYoEU9lAvdpvMOcYOiBTa1HqBIxWnSeNka43Ai
X-Gm-Gg: AY/fxX62Y2oHCS7B7KhgPIhsY38lx4qBvDCKmq5jZBMuXtMfGC3W2kb3+w4UAC4EPTx
	ihgF1S+K9wzYUbBhCqpe4z8EkqgkElpP2ujh4PRFXyqQUgK2me85kiWm9bv86EN9HSmBdO1iItY
	DMqBy8bW6sImthQrHmvUQlBdNyoM7zx4PE+k8BjbQ4C+CMqBZQBpvABrg0ZZWGIFg6JGoj46yBd
	QVNpTNoEvapMKAJ9lnUcC8iQm2iIy1GjjIbxjVQ90mz7zyCUZ9EAE/jtI55be8pSKhg2S+VcFgK
	wcpeqSGFluiVfHRLOHfGUYeMoFDaDrHu0OWaoqM4TSK9MlV3XNzXJDjM1AHLkcpbzvERkrXpsyv
	jjBc3lFMEHxzQ94++fU+cgekd9oQsUj0mzTQhCgTQBf2AswV+awjxY26EOGJDihJ4dqJXwQxHFu
	T27uv/cdJZPIqUyZ2VNA==
X-Google-Smtp-Source: AGHT+IGrHuJX+H1Hi2Xhv8PFQoYIgLlh26yONuv5UjyQ58u+4eelYdICoXWZZKzbiZRPJae+srwugw==
X-Received: by 2002:a05:6000:2586:b0:430:fdc8:8bd6 with SMTP id ffacd0b85a97d-4324e437897mr281382f8f.31.1766076968974;
        Thu, 18 Dec 2025 08:56:08 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:08 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 17/24] can: rcar_canfd: Invert reset assert order
Date: Thu, 18 Dec 2025 16:55:16 +0000
Message-ID: <20251218165600.258194-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21154

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 41c13eaf39932fc79aa1ac245a9b97090fe23d5e ]

The two resets are asserted during cleanup in the same order as they
were deasserted during probe.  Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-2-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 6bf217dea628..9029275eba8b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2194,8 +2194,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 fail_dev:
 	return err;
 }
@@ -2216,8 +2216,8 @@ static int rcar_canfd_remove(struct platform_device *pdev)
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 
 	return 0;
 }
-- 
2.43.0


