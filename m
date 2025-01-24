Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E5CC0218F
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:21 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.7423.1737709214733621273
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Rufh8NYF;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so11615435e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709213; x=1738314013; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AGIwR5dix3cBevysVkNwWGSAXw1Uxe87cB4A40YKpQ=;
        b=Rufh8NYFvOs2Fs8fZw9iGJDXnyAv8nlksLGOA7zwDfXRum5LFt7lgMNvGYTkWEJHAh
         cPB1mq5hc2VQ5M1VhoZUJa+BBjwGsDx2FFf9uGSvRSLfYD7aOp3PtJq7q3nLw9K8ZK8K
         lYy1TO5xPGC6YQzEymPnHxBWbFfUNwqAT+AZs+UZW3us+N7h3h39m6Nmdbw0/9PPqXfK
         lulLeTW68vBjqH661Ks/FkEPt3Jn8pWVZqzN9TtHBOz4VC80suJre2FTMG9ycTHE9sKR
         xhvCvbmTGW+XNrZ42NJ0Lk8l3xCeT6uPaNrsTCvFb+wYoXKKp66YdWpX29zSaI5YrI54
         LThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709213; x=1738314013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AGIwR5dix3cBevysVkNwWGSAXw1Uxe87cB4A40YKpQ=;
        b=npx2IjSGgDS0hOgQeXt4m4vkxl0/NTSH2MUNSIGQvqGUsVwZWyj20E/y9V0wxKVdh1
         gzhxn7L9l6bLAxfAWsIKIF+S7qYbulQ41eLviRzSBygw1i0PF3XaVUK7hvXuidGxHQ6a
         9cRvDqz9PR7ACkUnWietKvCPvzKLeThdHHgwvby/EwoR3IRQhlaxrKhIBrMM7An1uvGF
         fXUGeh86ry6y/ctqE0nYZRmwXAW9VL7kJEdWDtug98AuLFO0CytMhJbuItbJRV1DLB0B
         lzjU0uAkh/EEh1SWB0cDOaGddb1ajl+Cw65tcFB1GJDgAjLRnRqzj8YEDen5X+N3t/5J
         KFZA==
X-Forwarded-Encrypted: i=1; AJvYcCUye1LgqojTyXLd3/k15r1VWJT4hK9XayGKrBzgEZtJB3RtXqEVNUvAuZDVTlNqJvGhhQ4bY8QJ@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy/3g+z44Ultls/cIdy7t4plbOqqINmFdd5EIPltho2QfTDsuFc
	5nw2utezEkc/CznKh03XwRkEDqrFX1K8nuRyyucbMn+tE1DUhZc/BRLKL3C228g=
X-Gm-Gg: ASbGncuw5Cksods2C4/gdKTf2ucq9Sk2hAHhrMQ+uZyuKJE+EzwJ0U0d7BwE2vQ+Hie
	1rzKS7vQcaCRfbZP4TRE1n2hD9yGHqHx3LZ9hvgfku6YFzn/ZHIkYkZC15o4jG8YdsIzmivAAZx
	JcFCBM4C7OfPHgR5pN5YZ9W3KgPguo89a/LFjo+i5CXJIcKbEU7DRx325SUGuC0T6qMcbQe8rmi
	lsU++cKki6EuUuWCPzBn1Mwm6sc+fmB+EulUcAivK0YJl7Zxw+yNFs5tchhKLx6AcguoZvzHu8m
	odZ0PDB/uqBnSifG0F4KtaUVSIyFw356Wg==
X-Google-Smtp-Source: AGHT+IGTXRHVzcFFcOctYNvN58+noNtE2IVj/O5waUOfPOx0UcJjj/GpPbe8QVXcdkOb5H+KrdkF3A==
X-Received: by 2002:a05:600c:a03:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-4389142e8b5mr263417155e9.23.1737709213134;
        Fri, 24 Jan 2025 01:00:13 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:12 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 02/14] clk: fixed-factor: add fwname-based constructor functions
Date: Fri, 24 Jan 2025 10:59:53 +0200
Message-ID: <20250124090008.1401077-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17624

From: Théo Lebrun <theo.lebrun@bootlin.com>

commit ae156a3633d377d43990eb539f8a007c0c2bf769 upstream.

Add four functions to register clk_hw based on the fw_name field in
clk_parent_data, ie the value in the DT property `clock-names`.

There are variants for devm or not and passing an accuracy or not
passing one:

 - clk_hw_register_fixed_factor_fwname
 - clk_hw_register_fixed_factor_with_accuracy_fwname
 - devm_clk_hw_register_fixed_factor_fwname
 - devm_clk_hw_register_fixed_factor_with_accuracy_fwname

The `struct clk_parent_data` init is extracted from
__clk_hw_register_fixed_factor to each calling function. It is required
to allow each function to pass whatever field they want, not only index.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://lore.kernel.org/r/20240221-mbly-clk-v7-2-31d4ce3630c3@bootlin.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
[claudiu.beznea: dropped accuracy part]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/clk-fixed-factor.c | 59 ++++++++++++++++++++++++++--------
 include/linux/clk-provider.h   |  6 ++++
 2 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index f734e34735a9..6b30f6a05613 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -79,13 +79,12 @@ static void devm_clk_hw_register_fixed_factor_release(struct device *dev, void *
 static struct clk_hw *
 __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
 		const char *name, const char *parent_name,
-		const struct clk_hw *parent_hw, int index,
+		const struct clk_hw *parent_hw, const struct clk_parent_data *pdata,
 		unsigned long flags, unsigned int mult, unsigned int div,
 		bool devm)
 {
 	struct clk_fixed_factor *fix;
 	struct clk_init_data init = { };
-	struct clk_parent_data pdata = { .index = index };
 	struct clk_hw *hw;
 	int ret;
 
@@ -114,7 +113,7 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
 	else if (parent_hw)
 		init.parent_hws = &parent_hw;
 	else
-		init.parent_data = &pdata;
+		init.parent_data = pdata;
 	init.num_parents = 1;
 
 	hw = &fix->hw;
@@ -151,7 +150,9 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
 		const char *name, unsigned int index, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NULL, index,
+	const struct clk_parent_data pdata = { .index = index };
+
+	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NULL, &pdata,
 					      flags, mult, div, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_index);
@@ -173,8 +174,10 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct device *dev,
 		const char *name, const struct clk_hw *parent_hw,
 		unsigned long flags, unsigned int mult, unsigned int div)
 {
+	const struct clk_parent_data pdata = { .index = -1 };
+
 	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, parent_hw,
-					      -1, flags, mult, div, true);
+					      &pdata, flags, mult, div, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_parent_hw);
 
@@ -182,9 +185,10 @@ struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
 		const char *name, const struct clk_hw *parent_hw,
 		unsigned long flags, unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL,
-					      parent_hw, -1, flags, mult, div,
-					      false);
+	const struct clk_parent_data pdata = { .index = -1 };
+
+	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, parent_hw,
+					      &pdata, flags, mult, div, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_parent_hw);
 
@@ -192,11 +196,24 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL, -1,
-					      flags, mult, div, false);
+	const struct clk_parent_data pdata = { .index = -1 };
+
+	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL,
+					      &pdata, flags, mult, div, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor);
 
+struct clk_hw *clk_hw_register_fixed_factor_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div)
+{
+	const struct clk_parent_data pdata = { .index = -1, .fw_name = fw_name };
+
+	return __clk_hw_register_fixed_factor(dev, np, name, NULL, NULL,
+			&pdata, flags, mult, div, false);
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_fwname);
+
 struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
@@ -239,16 +256,30 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL, -1,
-			flags, mult, div, true);
+	const struct clk_parent_data pdata = { .index = -1 };
+
+	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL,
+			&pdata, flags, mult, div, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor);
 
+struct clk_hw *devm_clk_hw_register_fixed_factor_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div)
+{
+	const struct clk_parent_data pdata = { .index = -1, .fw_name = fw_name };
+
+	return __clk_hw_register_fixed_factor(dev, np, name, NULL, NULL,
+			&pdata, flags, mult, div, true);
+}
+EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_fwname);
+
 #ifdef CONFIG_OF
 static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 {
 	struct clk_hw *hw;
 	const char *clk_name = node->name;
+	const struct clk_parent_data pdata = { .index = 0 };
 	u32 div, mult;
 	int ret;
 
@@ -266,8 +297,8 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL, 0,
-					    0, mult, div, false);
+	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL,
+					    &pdata, 0, mult, div, false);
 	if (IS_ERR(hw)) {
 		/*
 		 * Clear OF_POPULATED flag so that clock registration can be
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 53dd7c9dcc94..19bd0ad70b08 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1104,10 +1104,16 @@ void clk_unregister_fixed_factor(struct clk *clk);
 struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
+struct clk_hw *clk_hw_register_fixed_factor_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div);
 void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
 struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
+struct clk_hw *devm_clk_hw_register_fixed_factor_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div);
 struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
 		const char *name, unsigned int index, unsigned long flags,
 		unsigned int mult, unsigned int div);
-- 
2.43.0


