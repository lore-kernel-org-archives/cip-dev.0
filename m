Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBBCC4450B
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:57 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19074.1782820129518647957
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=a/05QDnD;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-473dc4cf238so1273368f8f.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820128; x=1783424928; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUBOggrD8kDray9qm34pKQ3mLi3p5+WaIEHowX3BlIA=;
        b=a/05QDnDxsjKFPbjjJ/mcSD5B+V2v7v6GakvB30q1vqoT4qS99c04EJ2UUeeCmoVlN
         KQrB3dnWUNQsqm3vX5SkWE/7rmRt7alZPFeApA5ZZYKKn68Tp5jGTDXaTvWOsqP6OesQ
         ynY66ZnaWIki1z+Wzrj5tMjIOshzWveEdUQtp+1jprU7Ic09t10HInpPvPoXpVzQYfs1
         zDhe9ZEL8/ZmSfWfTZ7ux7e4fohzUwy5VWBCqJe4WGmOyGR76oQBWMrA6ARU4yVGwEi9
         AxO4kxRpPlNzv8rxkU+TcorSSzcVXCuYhttCuHar8fp24wRjS4QQMzDYa3i9+nAIFZ+T
         mi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820128; x=1783424928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FUBOggrD8kDray9qm34pKQ3mLi3p5+WaIEHowX3BlIA=;
        b=gq8DG40tfuFOTyPGwXvRGKt7RlOPZsBL+uKahXbaSlo0DJPbCtEtVU2eSwUQUMIv7F
         gUZ++OGG+9lEISqht92mML7yBk0mvQyo4uv5zmU+zeHoRl9nirqRheVRnN8CefdbcuBQ
         vF5BbMvrS8D1LL5W5u0wUVKZNVT5oGMc2DDIex4K0D2mUI1NsrvTK2CxObhI5kilIT/N
         lbp4ApCrBGCKMVxCZC6LBgKNAdqjod0WkjJQ2ZyoHr+qAVXUfWWbq9+Xo6I873K9FFFy
         IAaoKwvlC8Tc96au6xAp1TjWHW+MIww8Od+xGSqi6FYnUlOXH4YF7v6mGZe2445kcYqL
         43Qg==
X-Gm-Message-State: AOJu0YyYOOSBQwCJXsJsiZ8bf9Hf0lMVNr2ZXUXnwMzMOb0LLm7pT07q
	onduTH/LkMk+V9gOh2P3mj/ilsDTZtyDcxaag2M9ILITHSTwaW24woKZILtOyydB
X-Gm-Gg: AfdE7ck8BL2baWGPpSw0Kj5IBoDSUFaF5OPh62FmLtbmzL+11r4CtXohsSVBVagYKy3
	3mE/gj1/epSvqA8GG3QeQ3SrqQ8idQmqYl58Mz2RIw6OX7W9D0+Ph8yl+SsrQYJeq54f9ci0AdT
	JnJNxQgy26PKyP1ZQP3WBeJ7U+lPVhQ6Gd1RcLv9fqjoTcOXDgWjmKCRQS4QTVMdRf9CacZMQdo
	yVR6t66R2mfOS4VA1QTQdrPRm7SzCJdBQ/Rj9jb6ijCOiHlqjQtNIQ9DUxYe7lVyi6b/cQOr2aL
	8zpb/lpwQBT8K4WacU5D6O8FgpyQJiukW8fUEYzoPZuJnCEURV1wZ9MjsnpBdTFBr5DArSql24d
	BIJea8n5OwhukHmea6pXANUELAKWBtHKCU3kRmzyRqgYxjmZnetHTWnCPD+63TaVLUR6RcWJhit
	wjNhF0Yz1jLPLMilMxIW88hpA1Xb5K3xoLBMBOag==
X-Received: by 2002:a05:6000:40dc:b0:475:e7f7:ef76 with SMTP id ffacd0b85a97d-475e7f7f236mr2436963f8f.13.1782820127769;
        Tue, 30 Jun 2026 04:48:47 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:47 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/39] clk: renesas: rzg2l: Re-assert reset on deassert timeout
Date: Tue, 30 Jun 2026 12:47:32 +0100
Message-ID: <20260630114813.92739-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23337

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

[ Upstream commit f8c5f0dc77d86da36bcbf0684c6747a2937cc3cd ]

Prevent issues during reset deassertion by re-asserting the reset if a
timeout occurs when trying to deassert. This ensures the reset line is in a
known state and improves reliability for hardware that may not immediately
clear the reset monitor bit.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/20250903082757.115778-3-tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 25e565100986..bd562aa6f301 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1780,8 +1780,14 @@ static int __rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 		return 0;
 	}
 
-	return readl_poll_timeout_atomic(priv->base + reg, value,
-					 assert == !!(value & mask), 10, 200);
+	ret = readl_poll_timeout_atomic(priv->base + reg, value,
+					assert == !!(value & mask), 10, 200);
+	if (ret && !assert) {
+		value = mask << 16;
+		writel(value, priv->base + CLK_RST_R(info->resets[id].off));
+	}
+
+	return ret;
 }
 
 static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
-- 
2.43.0


