Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84DAC05052
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:07 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web11.15260.1713514684759223922
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XX76nLv9;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.171, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d715638540so22160191fa.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514683; x=1714119483; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj437jskGkSLGzlrRwaD8VVZiwYXk8zUEwBscyRDn4o=;
        b=XX76nLv9Pzw9KW0/pG6Nk8kSD13vu8vvRIACYVgJAxPrFXn5vfy9f1ztRXWIH/wy1/
         hRzd1ogTgT5UzoGVJbE2k1iI93ErIdRP6gwAThmjiH3r+w+kyyCUZoKFklIZEJaM0Vs9
         2XADP6F1vGEyHi76WBEP0bxrYyziazZbg8/IuvFKC0tXlLsvIman0THl2QxbwEuHDRzR
         aXobCYMKCz3/1N5NGoCyPo5ah0COlb3Lk4/kEfLohtWrL2AIS0x1/8eGIlYzBdCsHipO
         lKQaDmLrOsdaz/5WerfalHVs5cRNd5+4ypryCcBaZRemM9skslBlt4apCZ1x4oEBZjF+
         I0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514683; x=1714119483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fj437jskGkSLGzlrRwaD8VVZiwYXk8zUEwBscyRDn4o=;
        b=uhONjKX87RmAgLUm89piN6ZEpNACRU38Dc7KqrF0PbhhVJKTGwd6lvHG19cwQH5Cj9
         lYN4jhvPuzyFY+K3tb9pcTJ9CtAMrXf9579qsxGkrDDCqt7Sp3wMBGl/CvBfhpAUIyBT
         UOHUFAjEA5bmSPCwnP/g0qsL/PjOwM4L1b6zPjMP9seqwbeKdoC/WJUWhpIAGJC2tbYd
         wMy0do9h63loEzThtcp78gCxbb6awx/TrasCMurwpB0cQSU4Q76MYZQ5s8NnFhNs9cOr
         dKJ3ZHuxZv1aM5VTdKQ5zzEe4/maD2M0TAQc704v7Ur+0Gs9/1LwuBhchSaMj0VRtDXc
         H+xg==
X-Gm-Message-State: AOJu0YyoIC8iPyuy2Nzoh78UWNqO6Jjetxv7TBeVnFaGpS3VqD/9sIaR
	TsIdNEklPDDZahtGze46zzFP0OUVuEq+xl9rgCY15pB/O62OdRZM/j0D2bA0ddM=
X-Google-Smtp-Source: AGHT+IHMXR6GRJei6LySh7X9KPzBxGeS4XSvIOqpX8mBNje/lRAe5WMmOORwNI1VadnFkZKehLc3eA==
X-Received: by 2002:a05:6512:220c:b0:519:3243:3083 with SMTP id h12-20020a056512220c00b0051932433083mr970604lfu.14.1713514682744;
        Fri, 19 Apr 2024 01:18:02 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:02 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 12/53] clk: renesas: rzg2l: Use u32 for flag and mux_flags
Date: Fri, 19 Apr 2024 11:17:01 +0300
Message-Id: <20240419081742.3496709-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15599

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 897a3e34d6e73d2386715d5c44c57992f2c0eada upstream.

flag and mux_flags are intended to keep bit masks.  Use u32 type for it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-15-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 91e9c2569f80..097fd8f61680 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -92,8 +92,8 @@ struct cpg_core_clk {
 	unsigned int conf;
 	const struct clk_div_table *dtable;
 	const char * const *parent_names;
-	int flag;
-	int mux_flags;
+	u32 flag;
+	u32 mux_flags;
 	int num_parents;
 };
 
-- 
2.39.2


