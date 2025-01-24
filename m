Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D975C0218B
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:01 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.7447.1737709251853211047
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hwfkHA5l;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so3099030a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709250; x=1738314050; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WUbikmmdFs6DqjBocKLpWYwpo+iLOaUCsX5Gpawot4=;
        b=hwfkHA5lae0z6BR4pcCIMUGR9EdXKVsPbCrE9VYQo8bjNC2uDC+Uk1LzwMYbhS+Hpe
         hSEYSRqRKBYJovfu4+tqks8zpW4XkmQFC4h9ZyDiVh66Zgpgztd53bdecoQPczHK8M84
         puPj2jchgSu4DaLYJVKfJd/sbUqx41LpZpFQ7Gn20yBUs2fEssxOVHgvJED/2y+t5V93
         EmnKbLo557mIoiChXWn2XOK9e5FY0LbkrS1t9FDLvQ5ATFGRjIjnbyj+pIXgY47VODWK
         K1+rKHWoxKnpnu0MNfqV9memqsGCIihcGY6q0OrTx0kE7I8tOi2vAEzy3ZDRAjQTL9aL
         Zh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709250; x=1738314050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WUbikmmdFs6DqjBocKLpWYwpo+iLOaUCsX5Gpawot4=;
        b=FiNsdDjXHCnx8cpF73wGzJHGy6uNXsJRbazw8Aq2+ey7hMB3Dso7mDEQNu6IY3wWmF
         vJvb/t2fFPT15W1rhxXAXpYvrSukvz+cL+HFbeL5LMOzxdJsqApCbjr8b0ci+IvdKzdb
         tY4mh1OE+Y5qBqll6M7Ews2U/A45oqKKzLXZq0h4g90S/NHddce0TsZB186H3YSdgejo
         WyZgdyO14T+162bXqAfVd434E20rqBirsgYDaoHUHZrIPRArVh+YepV2HrlU5iwknIdC
         iJ8SaSTY4/emP4wGeET6C7bTtJM6H/pf70MyCE6o036jwTFliGTIgeFQpO8Aspy0y9JJ
         nBgg==
X-Forwarded-Encrypted: i=1; AJvYcCUaWvutj7Dq8IsQDL729uUA61JLDUH32FVUPlBmTjmDMHSbJUlGkDJoZ5I/VV01ALZhZqPTBpMK@lists.cip-project.org
X-Gm-Message-State: AOJu0YwbdLYzeD7qiZHQqDrflg1laNWygXaSI3jTrvgnM+bX1oARwmK8
	ifzyZQhLtlUyrl8fmI2J3qOJ63GTMoKfHzaMqVuJT/mSoaY7dir58klTYFooa62nID/KOKI+FTP
	D
X-Gm-Gg: ASbGnctmcP1zzpmiEqkrPZZnAhCQN/RBuKzpmXpQbtOUAxgYQzKQiA7H2BA+AMJonBZ
	eCaO67JRrC5lhAczLOHS1gVqM8PoO3r429a3iNM+rQgZLVrL/sgIaEReiRLRMU12oUeGdfjz+Rh
	H4f2kdrnz7csO8xVu+2io1MfVpXEj31BLTRbmuOuUwCmWf6LliCMOU5KQ+UCAx3FW/BVF5wWqY6
	Zx16TjnS7Swx2q/L6xqTpFTrIssYwWuOkatNoCyIlioBzaYlk5dcdNyrSA8QMwgPfrqRY1YMVj+
	0SCMz63xtWDDRaRUfZNOfZy5qXEHvHAVUQ==
X-Google-Smtp-Source: AGHT+IFivPr5/JAwE1TYS6xdPNkEMCkNmIqZroOjx2ZZD9UeGcHzvaXt1hCaRM1b0pFtWtVigev0Pw==
X-Received: by 2002:a05:6402:524b:b0:5d0:9054:b119 with SMTP id 4fb4d7f45d1cf-5db7db07787mr63196152a12.21.1737709250169;
        Fri, 24 Jan 2025 01:00:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:49 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 05/16] clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
Date: Fri, 24 Jan 2025 11:00:30 +0200
Message-ID: <20250124090041.1401132-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17642

From: Marijn Suijten <marijn.suijten@somainline.org>

commit df63af17f3375239e0be124844f304b4a4b60665 upstream.

Add the devres variant of clk_hw_register_mux_hws() for registering a
mux clock with clk_hw parent pointers instead of parent names.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20220629225331.357308-3-marijn.suijten@somainline.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/clk-provider.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 9f34b4268e6a..50eaf1946009 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -988,6 +988,13 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 			      (parent_names), NULL, NULL, (flags), (reg),     \
 			      (shift), BIT((width)) - 1, (clk_mux_flags),     \
 			      NULL, (lock))
+#define devm_clk_hw_register_mux_parent_hws(dev, name, parent_hws,	      \
+					    num_parents, flags, reg, shift,   \
+					    width, clk_mux_flags, lock)       \
+	__devm_clk_hw_register_mux((dev), NULL, (name), (num_parents), NULL,  \
+				   (parent_hws), NULL, (flags), (reg),        \
+				   (shift), BIT((width)) - 1,		      \
+				   (clk_mux_flags), NULL, (lock))
 
 int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
 			 unsigned int val);
-- 
2.43.0


