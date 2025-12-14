Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38625D5B174
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:59:20 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24314.1765714238169179246
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:10:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FYZ8n8XU;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477632b0621so18924485e9.2
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714236; x=1766319036; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tyVvMguHrl8jq8ugbnPZ5Gt/i/5YkdTEWks1PCQHBw=;
        b=FYZ8n8XUYprQuWQ0wnG+bYvXWhqqGLVMCZvdTXgaY3vWuD77FvPoP3S4NZM1RcgsFg
         JY4OuCTNLYHQvg5FlnLORVN3RCZSFfj/KnJCQhQHmYC/9XNhTeMeriY5t7VuOHA1ijS6
         xR/QzNpqO7JJrKYw8dV59koIX9FhXZm6hAsKRdupD+Q/Yoc5Lm6kVq2tMXSocFvyW3uN
         0bo7e2/KMnbypoV0mbA5H1Og3LE93zKI2Zi66pfJDFgfWa5JdNafHWPoevnzBLlajqYs
         zESW63ZB/2NTjxaKcvcPHyP0g9VrEbThKHoBc96IO5XhX+412uLJxVeXEKyTmOylRzIp
         AwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714236; x=1766319036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5tyVvMguHrl8jq8ugbnPZ5Gt/i/5YkdTEWks1PCQHBw=;
        b=RPOL7C/EUHUB+CiAchREuxakJr4BgoiVGbKB0h5/bRQknAT723+mdZ5VgD2ThlvPUb
         N9+oQX+9q7q45aNZzJUi0sz9G2aHxiA0sEF5hfrvnhxmW7pFGfWKHgXfCyXMNa65O2YP
         ybiqEoPEpXkQzF/Tu+9lH1jqbLE7VcWqvq66T8V5CiV2tG5Qanipmp2XVy5juxiaHI3w
         +7raV1D5MqQTpFyebQ4ieokZUQfak2ua5DdRl47gHz79gA4zQBGEPSrKshmJZx5LRuvU
         N0NPpyHwxxeU9NIlx/8cdKMuEfr2jtkBpvo53VBxlFrRc5mUUnWWO2RZbn5iXyQ4TZpy
         Cn1Q==
X-Gm-Message-State: AOJu0YyjuWOynkMiNUToTM2rjq6wxQ+K6+sr0a7Gp6VrDig1hk+4vPQG
	mP2xvgJgTxZYmrDSfSa/wYAMC6A/1twUOrx76LnLc98rMb4pLffWDSrSeP+qhQ==
X-Gm-Gg: AY/fxX5m0J1R8GOSZ0G1QuG8AObwgGjQc5t8X30zjfBDSq3yfESD0B7ona7PtRfk84P
	gCOffk1IWTUDAYIME0JlUVUBag6loGc6i4nGPDFgboBL9pAK7LZYbs3Kfm8fiizw9rKx3504yNx
	7aPBkhK3a1USQQtbIDm9dCvjL6JZ8sKxJyzEhO2DSwJtNCdy+2RDh6gxX7BXdFOfETC2XFmWdBG
	s2kOnCu4cbprQE/RtapjewbV4Yd89LjOMiK6uXmufJoWRrqudBg8QBTgIqiYc6HsiQYlqNIeLg+
	gcC0y9DSF11Ga8LlPYpLTPHEHSd8OqPP5rte6LXrujRfh/+AUWdvIvqekCFux8CqNByCLeqAvun
	t4SfILFT8trHCNbq6mnoU+c3kX6Tp5wpcroEQCTef4l8vyN6EErBqgAsrNV/Sx6DlP9dK7exT4H
	eY+k5//GhS1w/aaF2HRYelCBhotted1uO6qz/w1qa7wlancag0F8oEV8+EF+CvGI6xjGQR1Xw=
X-Google-Smtp-Source: AGHT+IFZ1cfFcRwEXiW0y2zRaBPbpTpje32YcMJwHt4k11+CdhD5OMdpymg90tuCCuBUdyJ7FcejnA==
X-Received: by 2002:a05:600c:8b6c:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-47a8f8c2becmr91424185e9.15.1765714236294;
        Sun, 14 Dec 2025 04:10:36 -0800 (PST)
Received: from biju.lan (host81-152-191-146.range81-152.btcentralplus.com. [81.152.191.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f38a4e9sm158768465e9.2.2025.12.14.04.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 04:10:36 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 3/3] mmc: renesas_sdhi: Replace magic number '0xff' in renesas_sdhi_set_clock()
Date: Sun, 14 Dec 2025 12:10:31 +0000
Message-ID: <20251214121034.4352-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
References: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21021

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 5d0702dc9c2f6700140b7366dd9ec6c78cde3aa1 ]

Replace the magic number '0xff' with CLK_CTL_DIV_MASK macro for finding
actual clock in renesas_sdhi_set_clock().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250820104808.94562-1-biju.das.jz@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 9cbfc2230011..4b84dbb5f262 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -223,7 +223,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	}
 
 	clock = clk & CLK_CTL_DIV_MASK;
-	if (clock != 0xff)
+	if (clock != CLK_CTL_DIV_MASK)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
-- 
2.43.0


