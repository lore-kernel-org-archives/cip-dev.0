Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E313C0218E
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:30 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.41683.1737546686712926045
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P5LeqyxE;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-438a39e659cso27481695e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546685; x=1738151485; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AGIwR5dix3cBevysVkNwWGSAXw1Uxe87cB4A40YKpQ=;
        b=P5LeqyxE5qLJ3nQsnDhwzMyKsPVadmgdU2BwQd58buFF2nPXaVCSpNTO/F+R8Lzxmv
         YgNagi41Ga98cw2wUNM+cTUIds7XWzzoq0v1PJWUadIfQK4xWTEwMU7zQ0zyJY6i39D+
         qXC+lmxjyS5nIGgObBpvcNg8i6SFPln8Jk5YzmC8oagcyOApL3EO3HXS/3lf+Oh/Mm7I
         V5HfHSeqjKwekO4obreUJI5UTAIcQqAKyKCfv4DaVbiAoG2iF2btNhOCLlkcuMbBYqTw
         gmXUtMfHR6oktqztFh/baIyzvwIqm8I8ZS7dCySY+pv4aT92eiMPZOwQphqi4hQO+ETd
         CIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546685; x=1738151485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AGIwR5dix3cBevysVkNwWGSAXw1Uxe87cB4A40YKpQ=;
        b=qKG1J1ILsL9+JvobBbmn2Kars5RsClQ7440UO7nlCYf0oZVL9f8xUHYdaSDPbke95Y
         ONWM7Ji1u0ckuCrdzHLYWlHPEiSGu9NPePogtN2Z+tmnpTFzluveDlemETi+XouowYbS
         wCWWtF8QBRhpEDsMAqbPCwS7M21aMoPz4JVXqmZqKSEnxr2AJUQZq8NNh4RPUxWZwvt1
         +XOI5gvbfV5Cy7cTrBB9xKd0Muw/njsQ5qxePL21YOtpEcUvUjWnpaY7FWbj7bXdAjvO
         dwzjVvMYw0CKqQbZcclL843q0R5A5bzDtDWI8CF/ttWE3nEG6xWpzTXf/y9fhSgFG0Jp
         f3rw==
X-Forwarded-Encrypted: i=1; AJvYcCVC8fG/XcB6TOip4hPO1PynD23Vc7x96/ELHZ3X9ObaG14BzvgGrrmDc5AbldA17w+kHJWZE98x@lists.cip-project.org
X-Gm-Message-State: AOJu0Ywh1JkLYlDsY8i2wLHrBEjVNpCg/UF/qWPQqcbtWRjhWyaTufnI
	DZeqh8XX62mXAzmaM9EAmLObqq02ujh1lA81r71bRDVjRtPxhkgsrc+ztMJPizJd4TSMdmzyoA9
	O
X-Gm-Gg: ASbGncvYCHvuTKwE5TyLBOomU/38qJGk12Xm4c1Konn+4bl7zdUQmCRKGswOcsHADTB
	Tmt3+f9Fm6HD1FK1PLuTq1VvDrgS/VU6nLG0Nf8DvGc0dDTO647edPON5FQCbMYV9ssEp/8X0fY
	RN6GzPUrf6Qq8VMUMCkL+RdFvrVGqR6+aPLsN7oZPL31sSx/dx8zShz3ye+lOKFP6Xd0WgfeWuZ
	/Gy9kObezlADBzu4OHei5+C1oAq0UUZcj3MEDqR83pE7s3vWG1596CEKEmlfvW5FGwGtCS7FYOq
	eeVrNfpiDBf7Y4igOmIk/5w=
X-Google-Smtp-Source: AGHT+IE+jsbv3OVqDcIl7LmmSrVlN9W6L/Hh+LaNfU2AGisQCRNIqaYEgS508G8gByNHcNw3/ae9tA==
X-Received: by 2002:a05:600c:a03:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-4389142e8b5mr193890985e9.23.1737546685033;
        Wed, 22 Jan 2025 03:51:25 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 02/14] clk: fixed-factor: add fwname-based constructor functions
Date: Wed, 22 Jan 2025 13:51:07 +0200
Message-ID: <20250122115120.2885015-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17565

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


