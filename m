Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A890D29FA2
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:19 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50553.1764872174753271456
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LhE8dT3F;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42e2cf93f7dso892933f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872173; x=1765476973; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud1VAdSqjBRjK3xQjU5W/iMYBVfbXxCj6cPXUWJ1ldk=;
        b=LhE8dT3FI+yeS8T3eQOE9re54pCBb4WoUOezgRojp61w/GfezieUURJxwzZQh0ZhwG
         UURB0CXtGwX1+RXB0RMmc+LFP71H4Zty7pbfGqteElJYghnRT0gcP6h9DD1Kct+jPfZz
         85pwRa7u2nHep81qlC32DCKg+Mm1Ld0y6FtRT2JmQTYmD9mp3jX8tD7dFkOFu7vA6AI3
         lJMxXaJ1iZxaqOOjmZANL9Y/xAkiGCX++s1JGeq5nv17k4C+tN8smCXb0zKMEnl7LGEd
         Yp2KV7vidPqZ+ME8j9TpQjaxLw4YtF6YhSphyXPTmI3Z8oEbCv+GSiRgbzRMUsJp+e2E
         WDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872173; x=1765476973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ud1VAdSqjBRjK3xQjU5W/iMYBVfbXxCj6cPXUWJ1ldk=;
        b=h+n4f7NmekfUMHHVXbJ7ur49cBZrVRc9K2YAgey6iD/cOXxwtUsUBgdcSYt2adB2Xw
         wnvEhp3h9U3ofV+wy421fJtjn36RQ6q92CsHKYopfUKiIVQnDp0z9tv40DVlx3ncoOhw
         mFKfnjO1rsph4CPJiIwJW+lN1sP2aYEFXYDHWTE+rvgmMFA1ASB3CWckvCNMAvLdKqRU
         NIvbXiYXOXvyss10fog1BrxyEQ3TwbfT8G+28vJGG7Q+1QxJ3B7/7XlX1zADZF6Dy1gx
         P3nA8lXhPl+owIf9jzB+yMi0pv0e/MhtSq5SO4miKpslwFsLYNZtnVNoT7w/s7AQ2Nel
         oWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTFUInRexUjHpRjVM5Rb9wZNju/Lz8pdX2no8gDJJuSoanxi+9g/mF1qxDTIUGKfpeP+FOlvTv@lists.cip-project.org
X-Gm-Message-State: AOJu0YwUt0GIwBQRquxTXK+8aFQnvIj5ILIVp+JnuKhc35yByNW//iJ3
	cPZsdD/P737Cx6YiyeNPB5MI3YLQwkxpkkwj7fzzfoR14PWcwif/wIFMCVIiAsvo7nc=
X-Gm-Gg: ASbGncsWiJRaNE/F8E138Xxc2SGK4n581WdZXxSPggbEGC4OxMSWcRRO2tUfar8dNc+
	DwmWeCOqeHc/BjzS9Bt7743bhRgWQoWqdEAI1tsJgzM/wzCTcpe1KpWjqLGUiLrk2P7cy+AsmBV
	9csEfZNcOpiyPUNpmhelN4Ci+Mkj/IblsV138kIu2GrKc17FNhlspv4xZxCfzCofXDtwvExnvxV
	BKkovz+uwhfKuHJ8bgOTixaElGtniwMdn5i3b1GTe4GEbOTYZ6vQoqOgIJH2Gzpbc8IdRt/xtDt
	C6CWi7rthNDOjt4wAmEZK5jIX8CiNah07BRyOTXRTtY4+mmvWJrCeXGn1OTkPJrkYfRiUy8rOKJ
	89AhPM/qZZ96s4QLgLH9OhSvobpnXPWRPSaH77Ib6zOBVvGglKkpeg1uEAZ4dhB9JqYy74oWrrH
	tjvNZUl+tgm2vhSA6NflypLFHa6VPU5fRIj1Z20X4w
X-Google-Smtp-Source: AGHT+IFFFSsYsNGdHGng4GNwHgD1AhknC120xjMhWpPiacvk+lqCnySJe2SGK39iz/mZ/IxO+uoF0g==
X-Received: by 2002:a05:6000:200c:b0:42b:396e:2817 with SMTP id ffacd0b85a97d-42f731c2acemr7741206f8f.40.1764872173118;
        Thu, 04 Dec 2025 10:16:13 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:12 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 09/19] clk: renesas: rzg2l: Move pointers after hw member
Date: Thu,  4 Dec 2025 20:15:50 +0200
Message-ID: <20251204181600.689203-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20895

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a68ea80f85bbf7b69f69ef9e17e3e1be14d948c8 upstream.

Reorder the pointer members in struct mstp_clock so they appear immediately
after the hw member. This helps avoid potential padding and eliminates the
need for any calculations in the to_mod_clock() macro. As struct clk_hw
currently contains only pointers, placing it first also avoids padding.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250514090415.4098534-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index e4f2d974f38a..dd94eca21b19 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1190,19 +1190,19 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
  * struct mstp_clock - MSTP gating clock
  *
  * @hw: handle between common and hardware-specific interfaces
+ * @priv: CPG/MSTP private data
+ * @sibling: pointer to the other coupled clock
  * @off: register offset
  * @bit: ON/MON bit
  * @enabled: soft state of the clock, if it is coupled with another clock
- * @priv: CPG/MSTP private data
- * @sibling: pointer to the other coupled clock
  */
 struct mstp_clock {
 	struct clk_hw hw;
+	struct rzg2l_cpg_priv *priv;
+	struct mstp_clock *sibling;
 	u16 off;
 	u8 bit;
 	bool enabled;
-	struct rzg2l_cpg_priv *priv;
-	struct mstp_clock *sibling;
 };
 
 #define to_mod_clock(_hw) container_of(_hw, struct mstp_clock, hw)
-- 
2.43.0


