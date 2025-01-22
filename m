Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8437BC0218E
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:40 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.41903.1737546756591169013
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LS49xGdy;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so67090045e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546755; x=1738151555; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czx0n57GKQ7ADNwcZUfpgZU8QtxHfQn25Ov/x51VkGk=;
        b=LS49xGdyHXKODFaqa30bTzBRF/NQV/LbmmFS+LXOr9eBc7JNcUoZGpVFq1RaEQnhcl
         +7/LIIklRhNKZf/G99hGYNDVj45WygA8QLSsasi2ZY+xct/kXNb2evJRV0AGIMzRQ62a
         x7EHWMrhgkMYtzSUjE486BBpg1ME0HDmReATqZ73rEYTuMs5dqufZs//9723pmm3V/uz
         YH+2/XpXXAizBDmSSqPL/bgyC5i5ORSReqKrb0ebHGPTHhzdiQZNmMMnTczZKdJy+uQ4
         K67p6lr6LTz8YjoGlJ6YdoSlcysqPaL0+q/l5cgLbbt2bMsrVTEufBnVBTgQ+DVm7WEw
         9OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546755; x=1738151555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czx0n57GKQ7ADNwcZUfpgZU8QtxHfQn25Ov/x51VkGk=;
        b=GNjpK500QNtNMdY4jmFILAYOLaxxDP27Is1hK1kP7sozztOgRtm0Bs2bOzOC4wy1c9
         MmxHeJ+WX2962VpFwC/nz8vGD7ca3QFb4Ay0GPE2uztsAoMalEoO/A446OhHMlk8zdBe
         iUNW8yQxCBK8GCwwfoXP0FkkGj29VU4AmKJ3B3X89sik6OJBkPW/1PVxJubd5zm7FMAJ
         F8MPGi0h+hLsMXjnnhecjAyg4c6N8LBzyBoC6umClmDu5eEIjty3tH2bdmrJCbw2tQBD
         i7av9j4ig0JdWz3jTG9/emn3Tw0wkYw7VZB6zyZ3w/CgkNCOeQrAinsMwpGIN4POli8C
         3KYw==
X-Forwarded-Encrypted: i=1; AJvYcCUhBC5egAK+zIB274BCK+6grWHTAC4QXzZLFS8k7v2H8UijxYQ57AhFFYjkudFVi71KGtFxtIU+@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz3Tjv6Vb+QMimpDE2B/ClvAUqodDfmPHDtlN76bak/gG3m4LYQ
	Fnx61SmHJRX2XUN3dbrqa6tzRdQjSWmkD3ZGWBv2x2KQty1y5ZmXF0QBQ2rV3iY=
X-Gm-Gg: ASbGncvrlJatlhqiYXnGq0mAgydoI4Q0lmk2uK7659R2OEaXixF0v9sMUSana1mwLVW
	s/mTcn9ZrBLAueHRhAdFhNO6aBbBwGMaukiD3v/zdcvwfZ7frJ3bVKN9x9WIGGsTkXKH+rUhVIx
	khn8uJR8BT1bbuVjYuCV3ua15SBt/XGR92XhF+h9vDSt3VeWzptiQCPuptoW9feAbCgHPDD3hu1
	kpkA4y+SIALbIlaovvObbZ63KQPF5YGaO+uFEtx6UUTzFKRBq8AATLcgonFL073bQhUJM+FbFtW
	gIvoRpccL9jgydf+e1oMdu8=
X-Google-Smtp-Source: AGHT+IH98yYJmWs4NBfMW2vpzQs8bM4IvpdituCn1mljCMNkL0mRXr8dw4fUK7mQYmHowc8O27jd3w==
X-Received: by 2002:a05:600c:6a94:b0:434:f753:600f with SMTP id 5b1f17b1804b1-438914376b1mr179408285e9.19.1737546754952;
        Wed, 22 Jan 2025 03:52:34 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:34 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 02/16] clk: fixed-factor: add fwname-based constructor functions
Date: Wed, 22 Jan 2025 13:52:16 +0200
Message-ID: <20250122115230.2885344-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:52:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17580

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
[claudiu.beznea: dropped the accuracy part]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/clk-fixed-factor.c | 59 ++++++++++++++++++++++++++--------
 include/linux/clk-provider.h   |  6 ++++
 2 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index bf55b9b71c6a..97623e100d44 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -72,13 +72,12 @@ static void devm_clk_hw_register_fixed_factor_release(struct device *dev, void *
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
 
@@ -107,7 +106,7 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
 	else if (parent_hw)
 		init.parent_hws = &parent_hw;
 	else
-		init.parent_data = &pdata;
+		init.parent_data = pdata;
 	init.num_parents = 1;
 
 	hw = &fix->hw;
@@ -144,7 +143,9 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
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
@@ -166,8 +167,10 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct device *dev,
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
 
@@ -175,9 +178,10 @@ struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
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
 
@@ -185,11 +189,24 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
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
@@ -232,16 +249,30 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
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
 
@@ -259,8 +290,8 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL, 0,
-					    0, mult, div, false);
+	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL,
+					    &pdata, 0, mult, div, false);
 	if (IS_ERR(hw)) {
 		/*
 		 * Clear OF_POPULATED flag so that clock registration can be
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 411f50478043..b13ab221d653 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -985,10 +985,16 @@ void clk_unregister_fixed_factor(struct clk *clk);
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


