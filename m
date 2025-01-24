Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C556C0218E
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:51 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.7435.1737709246162725261
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Dgy7s021;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaecf50578eso430902966b.2
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709244; x=1738314044; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDZzIafRWGe3jNg/iY2dGBgYzIf/GSbAKZ3dLZhE8dM=;
        b=Dgy7s021zRaLT9Ras0k/kw4iOAmniWuqQbjX1aOMI2+77KjfbEz1LHGOGaLo2fDt7o
         Mg2hT5aJGO44kLn4eRWcyR/HxCJh1l6QapY95zuncvICW3Zrgr2m0q2pR3lYuQlpcm3Z
         OUwR1X5R+GyjtYpyrU3NeYFnn1xtaT5togDRwGtBG4sgZAXjv/GieVuFFVr0T24AQ+N2
         K7Tg4LOOWI+fovQzBAvbDXC6K5ap6HfmvjsSUD7IFANS/3jF+d5po1ChT+6jys8++r4c
         EHNDEVguPA+VnnWrsGL8ez8VNVBuiQ5bcmo91qjxI5l2nRLgf/47EPPrU8OU3csR9usH
         iuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709244; x=1738314044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDZzIafRWGe3jNg/iY2dGBgYzIf/GSbAKZ3dLZhE8dM=;
        b=Pj155IXb65QaR/JhMwwdCQHPhyID9sTEFNbuojTW3o2ZfC//bml/IXEpifGnTOErM6
         NUZfmoT3nbSv6riR16YJh8+lECgJkuwP6MGfzP2GdOhDrcCQ3KQFCTvdZo/7l6OuyRTV
         nA6hp/7tB6uJIKS5Ozy/JfI88I/Y4YOdLXxIQ3AacRg6L2WprtOWXkDDnhdCzKeILKFb
         KBztAyFYRgFg2aj8IT9zw6E+tQGh+XFZy6sBrDFuIXvvMVCBtbP6u6c/sP+s5k1en1jm
         Q7IaRqnmwRoAtfjK38GEt0+FdUkBb5vTjLrA3IsLv9Op3I876XyvDMuwtuJgrF13nV+E
         NeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXhg1x41Oy05f3dl1e76utVFIfXsaWUbsBkItObEXrkTAYgWbUIo88LSY2nZKeD4tEU2fXWZq5@lists.cip-project.org
X-Gm-Message-State: AOJu0YxqerD+X8uzax9P5Ne9mGJM3WF7zj/PfIXs7cwopzE2RZR/1SlR
	vLI9RyCV83BfZoH6XJtABySOOPpNYua0k+djfewAshLcw7jRLnZuc2yITkwfWdY=
X-Gm-Gg: ASbGncs3KQ/uG/UvBRm1QjwTwLieyoMQyqmAjJVf4aYttZphZWMP/mwtpQIZcwoNt39
	M2BpeoJlb4KGSMq0JltsIYU7iAyS3IV0KQ6px/k++5PR2Qudf2YDYoVf3d11/Lr2KisY6u875m8
	fL2fb1aoIFfSYFmq+XD06ZZaT8AtiQZxPIkjuTjjlYEYk9M/FwjXWwk5ZC8KymQ3wyUdq0nTPPx
	hRCPgTs7AJDxzZ37dItBiKLp2oidwvdvfkmf4E6zO3r5kgjX8JT3pj4CS2bDdNr+HBm6RZYSFJK
	WVED2k/gjndwNR5cc56wXB0eULij5ptjZQ==
X-Google-Smtp-Source: AGHT+IEx5g7FQc8nyJqDliHsNxmO10OgtXinEdUdY4FkAe/qtGVTmCG9W2dhkWTDd+PxMmivEJceTw==
X-Received: by 2002:a17:907:1c91:b0:aaf:c27e:12e7 with SMTP id a640c23a62f3a-ab38b15ce17mr2818304566b.23.1737709244225;
        Fri, 24 Jan 2025 01:00:44 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:43 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 01/16] clk: Add devm_clk_hw_register_gate_parent_data()
Date: Fri, 24 Jan 2025 11:00:26 +0200
Message-ID: <20250124090041.1401132-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17638

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add devm_clk_hw_register_gate_parent_data() macro to be used in the
Renesas VBATTB clock driver. This macro originates from the upstream
commit d54c1fd4a51e ("Add clock driver for Sunplus SP7021 SoC").

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/clk-provider.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 75cdef73e751..411f50478043 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -571,6 +571,25 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	__clk_hw_register_gate((dev), NULL, (name), NULL, NULL, (parent_data), \
 			       (flags), (reg), (bit_idx),		      \
 			       (clk_gate_flags), (lock))
+/**
+ * devm_clk_hw_register_gate_parent_data - register a gate clock with the
+ * clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_data: parent clk data
+ * @flags: framework-specific flags for this clock
+ * @reg: register address to control gating of this clock
+ * @bit_idx: which bit in the register controls gating of this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define devm_clk_hw_register_gate_parent_data(dev, name, parent_data, flags,  \
+					      reg, bit_idx, clk_gate_flags,   \
+					      lock)                           \
+	__devm_clk_hw_register_gate((dev), NULL, (name), NULL, NULL,	      \
+				    (parent_data), (flags), (reg), (bit_idx), \
+				    (clk_gate_flags), (lock))
+
 void clk_unregister_gate(struct clk *clk);
 void clk_hw_unregister_gate(struct clk_hw *hw);
 int clk_gate_is_enabled(struct clk_hw *hw);
-- 
2.43.0


