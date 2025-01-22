Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0EDC0218D
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:40 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.41905.1737546759015433487
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Lk1Y0cRE;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4362f61757fso69879315e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546757; x=1738151557; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9jnL7JIOwdY+0ulZ0Hfgaqai/myVA0TJnq7pFltevQ=;
        b=Lk1Y0cREEXpgcfnBMbTHpVfyS3K2h1s5B3efu1JZopIy0AWIdJBYlT1YyXOWOnf7gt
         T8FeC1omIFMsCpXRnWGUE6n+GRVO7PfMk9vucnXQPVjjgnbrEL/b0K2bv8TL6dyLsjn7
         IQh/d2WXpVboAEGdqJt5aAC5CxGvLT7N5rj90peJhC/4y7u5qXpXj5GqF8CeMCKb1ULN
         PTF99LvA4k6qmqfaLDxklmx5E9r42atLpGJT8Kxpfd82DNBLigK5Y8QT/bVnwoixgxlf
         h7oYrGIcpD95FLPpszlzeP1HzMbJJMr7rsaaEqIuq9JNDl1Hr5C7DywtP/zXE/9snXJS
         NmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546757; x=1738151557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9jnL7JIOwdY+0ulZ0Hfgaqai/myVA0TJnq7pFltevQ=;
        b=AgRfoFOSHB9ld+dMpKHQM5wwvWkLikQGg7CzIjaBVwqvxA/Acw1fqvFaQeIaJTISRv
         ocHDsHfZbthiALDXwt6hKh2JCT09UEbG42x7yCWMceOGhBlrHP/CkEQPM5nSBBZTUFRH
         GicYVlu2XqFLNJ72YRi8f4Ek7wrATSsRMKuYSalnxCQZEAgTJ+sUCL/1tYlz/+eeSb8D
         Tkvz63629m7xcQzz7T7GLhvUsT09tWPzdmazj2bvHaIV4vdRYQwyOKQZ21zS6luv8997
         WkuK3nUs36v1EuN9qd+pPjs7ktET/H0V0NMlvg5bBqv1DvcoOUrddWYsa+75CeaAU38S
         PscA==
X-Forwarded-Encrypted: i=1; AJvYcCUK7iuNXJomYm1NYL3IQYF8NJ5BYqtxFgH+MwjscAIh3X/uZF4MjnE5mGQOVgq89ieOMgNFm+eL@lists.cip-project.org
X-Gm-Message-State: AOJu0YzAy+Wk/eM6xALrVdEqAadFA+hTrhYfb58zQQQxcnge4ah9kDYN
	8uwZy+0X1KJ7u21cZn2YzEgtFuzC1OEnA5aDqOFKX9V8mNCydLic0BUV4nHULmMg6Ufy163sDJn
	g
X-Gm-Gg: ASbGncvfMZ3feHkIJ65dS9Z9matMX59KC3TPtrMUopgOt8X0ytbI6DBPK/uXWKNfnHH
	mozG7BYtPoTbAHQadFOwGEtoO1e+xCfYgZQ+TDeDRIfZ1JJotH7ltO+4GV4eQs12mewZ24jpTlF
	4mxVGmOzUPwLkTxMDoWODFJJc4Drnyj6giXxP20Oo/3eqqW6KcnUkkg4ubIbi6VMMenrg3JD19q
	tv/CauHukSBG1jy4xA4nzctf0gGZ8aq4N7u/3shuLF/vFqwvcgVyObgWKIZ6ZpqTjAxc3dIwzqD
	B5dVg+Gc6fXDNcQn4coHUWwU15xt/2rC3Q==
X-Google-Smtp-Source: AGHT+IH7ABBNheWqC2b04OUFPl6GjReO2+p/ccyzbnKFtLvM79rFFh/7Jj+70cNblePgmZK9WYkGQA==
X-Received: by 2002:a05:600c:1f8f:b0:431:93d8:e1a1 with SMTP id 5b1f17b1804b1-43891430defmr169006045e9.27.1737546757444;
        Wed, 22 Jan 2025 03:52:37 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:36 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 04/16] clk: Add devm_clk_hw_register_gate_parent_hw()
Date: Wed, 22 Jan 2025 13:52:18 +0200
Message-ID: <20250122115230.2885344-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:52:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17582

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e1ef630c56d36770e180f0d0bf7b61b5289f5c48 upstream.

Add devm_clk_hw_register_gate_parent_hw() macro to allow registering
devres managed gate clocks providing struct clk_hw object as parent.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


