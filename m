Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B676C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:40 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.41904.1737546757961158093
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=PDqf7qYt;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43690d4605dso46726535e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546756; x=1738151556; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSbPKHTyonEsFGawfa/hjkEQNcbxdaEgGN/vZGtaVrA=;
        b=PDqf7qYtX3ogePm80rXJyVQwcDpaDp5tOV7lHXrsJE9TOuDPks23c17G8zkjcybe25
         FYuB64IjyhtAWr+frwXwosA5od1t9lS5D1iIfQHbVTF2CO6LJ2YMUqowMZXDXtbnC9hO
         kgey5jGrBobbsmNaKKeqhxPUQ+9Cj39TiLKj4ynO9JsOxSQ4Kr+tjwaEX/zbz2M/zTNC
         vnNKSgLo/rl5q0g2HkU7CPAfoOx9kxJJPtwGmDvoce8qHNN8zKbNCvGKb+CM93vFnVGs
         6U9gDCRPUl4o7MWk84M81499LMZTpn5v95XxLPO1NBf3adwiL1cG2LjibUiTFXenswte
         yFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546756; x=1738151556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSbPKHTyonEsFGawfa/hjkEQNcbxdaEgGN/vZGtaVrA=;
        b=rbCWlkDn2pxUgNQguu+jzRuO7ZzpxjZiK6g/gUL5WAXhop5siBqMtLVOD4DPJGaoDS
         dQewxAJb4mJhNKo0IydIm7FRmkQYLvJ2Tmss/jg2/80tpWpJJwBikOtdqRwkV/lse85A
         wmv9s8gLspryDPiA89HSwRg4daREQmXke84tywgHfoPawWbs8ghaHpq4n/2oJRSlkD4m
         9LM5+LXua8minXEHCcJzOG56Q87b3LViAN2Ij0shiSon/nZYmDZI3ydqdgyuMNb0DODd
         ukv3SZikWDg3eAK1VgzllMs4ZbZHo0lR/rqd3CzcrVhnMVcxSrrpYeTZC7rfbirfkjVW
         lQcw==
X-Forwarded-Encrypted: i=1; AJvYcCV0RrvnX/Ne4eHZF/YTQPR9kOn2BLfrO1kbhNXkcp7OtyryVdfMVjH5Gq8ztuAfnhVnY0gdu7FT@lists.cip-project.org
X-Gm-Message-State: AOJu0YyPj/u7dPYDE+SSAA8lFhAFo/BK7XJ5uBHyxM3VgcFCqldg5REq
	nN4cr4iAOk0SgwgRxZq9ILG/CUn4EItaQvg5K2m6uU1n8OP5vLXfRXPow4yRqL8=
X-Gm-Gg: ASbGncuwADd6yQU4kqfzY4U9QS6nhPVgzMBZwoOZnfKBExTlSjomCTnWXAxkrjRWKLJ
	6xgtS/oFUp0wcLYd6LigoILzM7KZ8wIDshtAxOyyz8+AXRbDf8xQa4JHHh2ilkI1CO5tQ/mu7ZT
	xJ1dMrRevRK/dd1KZ1k9eVN+FCg2la3nobT4XFLMp/mTneC1CbbQqp86i53QvaiThc3/sWueCYY
	Wl+FtKx0yIIKB/1AEON4dh+7RESLqHS9uFhI39pbSnIscDmlhhl1gO7t10FD3TrTGDyL32/Fl7v
	tYEGhhVVp2f4Py1R9LGQdL8=
X-Google-Smtp-Source: AGHT+IHxRikJOEZh0Qf8JBRE443w2vdxFyZV7fDRdPqXbdeFObcLv9A+b3vspi4gZIXTEhK2H/4Yaw==
X-Received: by 2002:a05:600c:190e:b0:434:ff9d:a3a1 with SMTP id 5b1f17b1804b1-438913c7f84mr200020535e9.2.1737546756352;
        Wed, 22 Jan 2025 03:52:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:35 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 03/16] clk: gate: Add devm_clk_hw_register_gate()
Date: Wed, 22 Jan 2025 13:52:17 +0200
Message-ID: <20250122115230.2885344-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:52:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17581

From: Horatiu Vultur <horatiu.vultur@microchip.com>

commit 815f0e738a8d5663a02350e2580706829144a722 upstream.

Add devm_clk_hw_register_gate() - devres-managed version of
clk_hw_register_gate()

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/r/20211103085102.1656081-2-horatiu.vultur@microchip.com
[claudiu.beznea: fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/clk-gate.c       | 35 +++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h | 23 +++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 070dc47e95a1..64283807600b 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -222,3 +223,37 @@ void clk_hw_unregister_gate(struct clk_hw *hw)
 	kfree(gate);
 }
 EXPORT_SYMBOL_GPL(clk_hw_unregister_gate);
+
+static void devm_clk_hw_release_gate(struct device *dev, void *res)
+{
+	clk_hw_unregister_gate(*(struct clk_hw **)res);
+}
+
+struct clk_hw *__devm_clk_hw_register_gate(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
+		void __iomem *reg, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clk_hw **ptr, *hw;
+
+	ptr = devres_alloc(devm_clk_hw_release_gate, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hw = __clk_hw_register_gate(dev, np, name, parent_name, parent_hw,
+				    parent_data, flags, reg, bit_idx,
+				    clk_gate_flags, lock);
+
+	if (!IS_ERR(hw)) {
+		*ptr = hw;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(__devm_clk_hw_register_gate);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b13ab221d653..0e41b029f898 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -517,6 +517,13 @@ struct clk_hw *__clk_hw_register_gate(struct device *dev,
 		unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock);
+struct clk_hw *__devm_clk_hw_register_gate(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
+		void __iomem *reg, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock);
 struct clk *clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
@@ -589,6 +596,22 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	__devm_clk_hw_register_gate((dev), NULL, (name), NULL, NULL,	      \
 				    (parent_data), (flags), (reg), (bit_idx), \
 				    (clk_gate_flags), (lock))
+/*
+ * devm_clk_hw_register_gate - register a gate clock with the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of this clock's parent
+ * @flags: framework-specific flags for this clock
+ * @reg: register address to control gating of this clock
+ * @bit_idx: which bit in the register controls gating of this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define devm_clk_hw_register_gate(dev, name, parent_name, flags, reg, bit_idx,\
+				  clk_gate_flags, lock)			      \
+	__devm_clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL, \
+			       NULL, (flags), (reg), (bit_idx),		      \
+			       (clk_gate_flags), (lock))
 
 void clk_unregister_gate(struct clk *clk);
 void clk_hw_unregister_gate(struct clk_hw *hw);
-- 
2.43.0


