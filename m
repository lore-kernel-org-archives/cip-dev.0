Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18867E6749D
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78200.1766402236923126642
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WqffPFd+;
 spf=pass (domain: gmail.com, ip: 209.85.208.67, mailfrom: biju.das.au@gmail.com)
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-64ba9a00b5aso3446688a12.2
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402235; x=1767007035; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24fYFQcXD9yclg06CXlFM/XyXkMEX3z9Ail42OrBZXA=;
        b=WqffPFd+G5mqTaBajLEZfNq8y6q0WDg9y6wNQwGqHW0cvmepAAsieeo3rm4zTnNZdx
         QhKnV7e6KUbv3FPNyYXFlOfmDCFHpcsNg/QGFj00r1kK0kd8Uw2HTRwXdjMqLBvC/gD0
         CWwOw5XVamd3WaliwBPbfLpFHGU0tSigbLz/oeiJum3p0/uLe9xxNFaZ8WF3ISOBtcxT
         c/K+Kozk2jFl0/p/KVo67AEAylQoEmhxczm7866nBwecC7FsDDbkX/r+2OlhAEUXxCWP
         VLlrXW+YOAa0dmxqivKx71+Ag+5kbXzYJkqA2CjykTaOgLE/NNGjW/r/b6OXFyyR8k5D
         72Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402235; x=1767007035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24fYFQcXD9yclg06CXlFM/XyXkMEX3z9Ail42OrBZXA=;
        b=noeHYnkljNiO3pLquJMBRNQGooP9OTyJZrWhh6AqfmuJPw+H/Mm+A8EYGVkcvavY/3
         MrlskOJ2QttwkW2nvxsZw4QpYpjqxw/F/VWg2N2CIdSmBGNa3/JWDwx/MxsSX/4SG3d9
         XEE81xtk0iPfiEkxT13j4cWG3H3s5d+DykamG/la2kAR+p19NTKPLB61iXM2NqmBJPbI
         xogM9WhINclQf3hkFhgLSWEzSZlwzMCubXMcTEmyCmJ3F8WBpZ0imE+5/PWgt8Yqf+B2
         hc7CwkXTy71N8SExvbSDpf8BDTTfBDtJYEiSLTADbsuGKeAZ29z3m6xbV/jqlzvhWzGp
         IcVA==
X-Gm-Message-State: AOJu0Ywp/jo38rQnwa8X3McLfIqIjdfBvM2h5Bbedn7jwovcqA5479L7
	K11iSdel/lGO6QIaSHPM/7fE+x/x0zspLcOjOVLoBK67Aa2iZufi+ZRN+phFP1bi
X-Gm-Gg: AY/fxX4z53StrjCleZALilg1PADTbEBqrHOPUBp19JXE6WfWrEJ4S5MXsCD/HlpCWB6
	HD2crbsWyTJCAxezpb9RCI0UTYF0poEV73qo+3X88zQ4U4f3PVoAJhcAzbJYoWxpcSq2vi7a7oc
	FPdnQzP0LZApVbjjZjSR4cZ+msCwBgpBlQqsbE0jWFNJbW3Sm29dxUV20e463xNO7Tg0DYPh8x8
	UbBaOheBJ/8cCROFxadWQxz5wfuwAvbePHj9wngicvmuuVRE79plgFfDMySvM+ADyOcATYgpPny
	hiwsmF2XjNbYS8Rmzn/hM3iv++AQ01aNW7Cnva+NHYviZaNGU+F8c9GUd5gvlftluJ7dyYGZVbR
	U/PGmwj403eh6oU4xRRM045nnXEZ83nUnaR1ya+wflLPUunyUwMYa45VJ15U9Z2PBiYLceZGwR+
	KeiJlSN8xpck1e4fa80gkLNsj6fBCnfwoCSGc=
X-Google-Smtp-Source: AGHT+IFsG1BJQbdpjPdFjfBSDQfoBShtGDfTEksLcUpHP96BHu6P8oRKbw2mQzXoTvcfnlP2vfKYeQ==
X-Received: by 2002:a17:907:96a7:b0:b73:8e7d:4fa3 with SMTP id a640c23a62f3a-b8037051234mr1192518466b.32.1766402234799;
        Mon, 22 Dec 2025 03:17:14 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:14 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 17/24] can: rcar_canfd: Invert reset assert order
Date: Mon, 22 Dec 2025 11:16:49 +0000
Message-ID: <20251222111705.27028-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21203

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
index e7f6e6b31ac5..7132db201a72 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2193,8 +2193,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 fail_dev:
 	return err;
 }
@@ -2215,8 +2215,8 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 }
 
 static int __maybe_unused rcar_canfd_suspend(struct device *dev)
-- 
2.43.0


