Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6106D29F87
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:58 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50863.1764872149360786686
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P1gzrIpp;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779d47be12so11773025e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872148; x=1765476948; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow4QaYv7aCZBl/kZX/vWP7QiG3ufZxzLH+BGiLZZQMA=;
        b=P1gzrIppWgMnBFlfeSuorHi3E3SaOFupkLpcaR/UZkq18AmdYDo4q9VF/sqQ7Qp760
         z7hzs0/rlEcxSkWYVHaA5Tcl21fmZtGB2h6YuoE5Ag7gijj7nNPzyOwg/w46P0dNtsXV
         mBKxUnB+G4a6NlZ9hGI3/lkqcxMeZS/Eams4Z/0Ri1FEsEu5s0Eb5Zo2lEubtBzhEF/E
         OGR7Fo4kQZRjhRTmQ/JEpBij8iCoQ3Smh8m0qIybugwb+DV1f3Bj/FFw/ZWnlHyuYIXi
         39ueKP8jGXtQOg0DHItuVcU0ifZMOwldGiQ3rasw49LuJjh90dcc9Ycn48EnsxEbQFS8
         s+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872148; x=1765476948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ow4QaYv7aCZBl/kZX/vWP7QiG3ufZxzLH+BGiLZZQMA=;
        b=ZID2nNictgebdBNd1YYJXMGGmdbsaVyREZHDjSOPiF57npkOVLU69fVsFgezSUXMeA
         eqbQMMCcRrflFXvJhmmKjPTHFnYeENWVa3YhYyWFeR8mDItavltwn67pTWhN50145WS/
         fsgKMSOklLnV3zobXJi0TrSi1iAop0zLFxVpJyCSUoPUVAE5XNxDwez0RtNlB5jBIQNv
         Y8zqtFPngFrGY4jkuxX1oMPO4uUaB1iFXASl5aXQnlkRAQhDeocErEMqHu3le5WOx4ou
         68knAa0wKQO9mv94qH4aIy2BGQHIkEiup3/cY+H/oLb0xbaEoR3MVv8xmIXpMsoATABI
         FkTg==
X-Forwarded-Encrypted: i=1; AJvYcCXaOq56z6d3GM2h/18tXLVXXOdvsgCMSImwmNzb84FPG2u/UFqpUAaJb/nWl61AT2duqLrl4zox@lists.cip-project.org
X-Gm-Message-State: AOJu0YxEVpL8r3O3N0zCBgXJgTbypF103lVvWjJVcfBDL0j1xctz/YF8
	8t7ZdV8dUoy2W7tjKjrpUUPz9pK8y90+HcMzaHxx0C6XsQsSlFOrR1a1Ga7FEz6/9AM=
X-Gm-Gg: ASbGnctLpr6h+IzzDfVl3iF0JoZIj3BrCpVXNlQ2H3eOmuKYkvVW7/UmqrUHcxw3ATb
	e6Ejjc/H23IL7u/gQXT46MhHOGQFNQmFGOTz7myZ474LCpnC9nag6lRVa/DvUf3C2mKRTLEpNi7
	M64J2B9TshHMWprLyvvmec4Za5gGRYAJrHkmoB4XXMIfvLU/W9PeP+BaTAvcJiTTUG1gOP11eyt
	pDm+kagNBbMouTHUz/mWj3qJtWMkpX3TVSrPlQ2ICW1LtEryQx1J/bJta1WszYZ/2yNPPI41l+T
	5RFUNvB8bagTUT0Cs0gWlC3c/AsBJj/qSjNNFzRptMGoNjcWp9EhMKBJV7GyYtTk0JjiJjEz6ry
	4uIwD9ItcgZ+nJ/TTiZIRaXIlU9SH8TZNiN/N61YCHxbbCmszJ6/gtJNM08Sq0tj3FZ1vt/PtVc
	F1zd7UHBTt3G43g9HDK3hCEfDerIfCJM2hNhg6Hn5W
X-Google-Smtp-Source: AGHT+IHKemwS0i8CG2Iqy2mlkz3DCrOvbld5FyAmiWIop7fwuIcvSJzl6WirWBrcAuTalcz4shuUjw==
X-Received: by 2002:a05:600c:198a:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-4792aedfda1mr65635325e9.6.1764872147654;
        Thu, 04 Dec 2025 10:15:47 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:47 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 11/19] clk: renesas: rzg2l: Postpone updating priv->clks[]
Date: Thu,  4 Dec 2025 20:15:22 +0200
Message-ID: <20251204181530.689132-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20877

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2f96afdffad4ef74e3c511207058c41c54a2d014 upstream.

Since the sibling data is filled after the priv->clks[] array entry is
populated, the first clock that is probed and has a sibling will
temporarily behave as its own sibling until its actual sibling is
populated. To avoid any issues, postpone updating priv->clks[] until after
the sibling is populated.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514090415.4098534-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by keeping code from v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 0d7e0fa73fff..96535174407a 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1390,9 +1390,6 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 	if (IS_ERR(clk))
 		goto fail;
 
-	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
-	priv->clks[id] = clk;
-
 	if (mod->is_coupled) {
 		struct mstp_clock *sibling;
 
@@ -1404,6 +1401,9 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 		}
 	}
 
+	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
+	priv->clks[id] = clk;
+
 	return;
 
 fail:
-- 
2.43.0


