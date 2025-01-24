Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E099C0218D
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:51 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.7440.1737709250498944990
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZXamrPMB;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43624b2d453so19129635e9.2
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709249; x=1738314049; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m30FQ0NcTaiIggvJ8d7dRXmRasaCwH0mBB8X1dRTsrw=;
        b=ZXamrPMBex2J/ZBcDZPJkG73lyFTGmwi8zvU7+Cps05rxzEpH34h85X7B2MwqSsrtR
         bPJdqfHc/4Tiabk1/B2oaHCoMxC3WNMF8M1mAkLW0Z7+uTDG1J5QI+X/cSkyONSFuY06
         K6uB4jqb08ZOhOMcxRr5cBeq4C5xlEJn3eF8LZtWOByhGQ4uCJDSC+l+QjTra74o1jbO
         teG8d6+J21+3EDKrg6p6KP1LuSyrx6+k+01a/3ZOm55/M/Md+P1PH7IHb2srSjKuHVMx
         c3+MIXTqiEPggcjxhFukit2G1/HJ1FBuw/GXd+RZ0mC6pBOlYPR4xznDujD71TYkhZ3C
         Wc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709249; x=1738314049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m30FQ0NcTaiIggvJ8d7dRXmRasaCwH0mBB8X1dRTsrw=;
        b=AeTHF1j6nWGhRhwx3YwB4kgkw80t+5lIW39uu++0pfjaeVEsEPqpLhE1/7xsjDPiiq
         nUTYC97skznIic20bAQlv3m9cwJKpli2xFiHLsDtY/QKMiii4U5DdYq1+vrF9k+BXJ4+
         V5g5aQ3dLdNlQ1V73GwaSncjAr9E4qCHYLOGSpI+kUoWdiGFrMj6ciZkSXWIC2Y3eyWS
         5IJbWsItKPJk6OnFcf+C7zj3LtMol0BwUXTeXUFXGDhqSUYLddOfBw7F3FqjqmRvSYRa
         o0ZDDxjGJGDr3WIuliB02Plz6YgNsZqq1RtSY4aM1Iew88hkWSWN70TXoqWeodRvjp4c
         Kqjg==
X-Forwarded-Encrypted: i=1; AJvYcCVar9rEW41LQraHD5zoXLuQ7ZBYDcy1Y4RU/3SBeJR5mSXgmd1Im7Ncoc6EreChey9sSSOVOuVD@lists.cip-project.org
X-Gm-Message-State: AOJu0YwuEA3AwpJY2/eR9IMMAaeRTrM/PUdwiXgAlFltON3tgS4rVnRt
	EoZrUCmcoJCTiEKqRT7Bv/TZt+TzTlKrSgkbVdFITfPR4QdWwNUekuOd89EmKfsGPPxtcvx/LZc
	d
X-Gm-Gg: ASbGncuRt5A5gxploKvZO61AAHF50m/HaRLwJmRT7O+ddBmF7NTrTXhcKTdgkdGyvXs
	s5gPYGnuTaBGf2WelwqT3Ol2T/g0omGQYpAvEbXBL9mHTTo4MSr9q7/sXk9xvT8ap+6uaMlqZiQ
	lzeZdIPHPzaKzORn5Kdy7bOdI+0xeLqnEvtYCkKNlEeVXHgXte7ptfYCCC3em1oqgNj9RVPdmar
	KWIMxQMuXCsxKiikZT4olHbjwwwz2kqW48LHYifhiUzKWSScYHWTJbvbtC36ahRi9zHeLxtJtVR
	UFf7hi1GNq58gRl9h3hB7UHhngVPk7CwSg==
X-Google-Smtp-Source: AGHT+IEk7vSB+UWz34QNyblLIq+QC9JvnRojMWnBnWdm0moB9lIczxM54aH12ikR86OyiwnuuDh4qg==
X-Received: by 2002:a05:600c:4253:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-43894744f5amr293204735e9.5.1737709248940;
        Fri, 24 Jan 2025 01:00:48 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:47 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 04/16] clk: Add devm_clk_hw_register_gate_parent_hw()
Date: Fri, 24 Jan 2025 11:00:29 +0200
Message-ID: <20250124090041.1401132-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17641

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e1ef630c56d36770e180f0d0bf7b61b5289f5c48 upstream.

Add devm_clk_hw_register_gate_parent_hw() macro to allow registering
devres managed gate clocks providing struct clk_hw object as parent.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Pavel Machek <pavel@denx.de>
[claudiu.beznea: fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/clk-provider.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 0e41b029f898..9f34b4268e6a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -578,6 +578,24 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	__clk_hw_register_gate((dev), NULL, (name), NULL, NULL, (parent_data), \
 			       (flags), (reg), (bit_idx),		      \
 			       (clk_gate_flags), (lock))
+/**
+ * devm_clk_hw_register_gate_parent_hw - register a gate clock with the clock
+ * framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_hw: pointer to parent clk
+ * @flags: framework-specific flags for this clock
+ * @reg: register address to control gating of this clock
+ * @bit_idx: which bit in the register controls gating of this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define devm_clk_hw_register_gate_parent_hw(dev, name, parent_hw, flags,      \
+					    reg, bit_idx, clk_gate_flags,     \
+					    lock)			      \
+	__devm_clk_hw_register_gate((dev), NULL, (name), NULL, (parent_hw),   \
+				    NULL, (flags), (reg), (bit_idx),	      \
+				    (clk_gate_flags), (lock))
 /**
  * devm_clk_hw_register_gate_parent_data - register a gate clock with the
  * clock framework
-- 
2.43.0


