Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7607DC0218C
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:51 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.7446.1737709247422418163
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JfaRP5nF;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so3444179a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709246; x=1738314046; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/j9L8MoygLCP+eAzrb3Sudr807COGZZUyuDmw1NOUKo=;
        b=JfaRP5nFp9TukINDigJYYOc8XBhbEvJsBtZ1lFgzUYaSu0qoFcTMH2WFAC8tJXGmYi
         skjKSyh81l6paM/AEy8IPNxW+D43nKFp7OGDwj+diJWwHfeBw5LaPSA0ueXWVYFx3m8y
         WuaYzFNnXLZAeXIEqqGjk5vY1ifTcKjSTZWjkTnv9jhgWQ4S7FKoaew/jkh0xOdODauI
         +DOg220YVJOzawRxl2Yo2/BF5w/7SsctMTINpBEdZD4iXC4eMK2okpvUy5WSSw2UjIBN
         YptCcRZszIevdmCufNs5ljK1nHkgda3ENE3hxo0vnTP5/nHL/MCEDN5/btF4sAT7bceU
         7Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709246; x=1738314046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/j9L8MoygLCP+eAzrb3Sudr807COGZZUyuDmw1NOUKo=;
        b=t+3XJqCc3Xg5c+Ak26rx8ujgu1IuiorHE1d5SYKzoestDxx85/lLfnCYnYkEwoDZSJ
         ROvpo/gQWsABAM+QaAaFJVVZ9Dh9ny1Vt/AIxo+EGul5mnFIG7dXP264SucVzxUkq0P+
         BUH4Z2CglN2e6Uzw/9RqvxuNWnk8LBk8aAeF3GWfJvaPyFy2YM/fss1h/j/WBo1T7ALc
         lxbCgmuCYbZ5nyO0aCSxrNASbpQlXzXhniHC9PXWPqrz1GErzF683Cp1Ckb3fDhV2AwJ
         fH0cCQ4m2x5ACRddJHdeecZmG8ZXQoIsTQJVM+JU0UMRyasqmIuvpmX3pSh6qpg8YxFK
         Cmzw==
X-Forwarded-Encrypted: i=1; AJvYcCVPbn4bz1u+SD0e5MDB9aixqZogZVlSdVXdbBFdEwbB+pCECKu+Y/Ipco+rLJLXLE6CjTiuKW/O@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzq7eFwFVS07dxMGDlm03jjL04hU6auIIv8tYbKICtn0cI5V74g
	PYw7PjA33CiKE0ygT4/CmVE6E84v1AwgMG8wxRsIK8hjv/JpG1TmhjaP9r77Gz4=
X-Gm-Gg: ASbGncsn/UI/l/dKdM18MAeCD3iscwL8WYTeA7CWJBOSRPS91shFq1rcOSsrk/TgoWS
	A4s/8qbc2eZb5V8H7cmYFYlMfyfGU4Dpv1XOpQmgWUX4vWTtXARJePDjlAE/mDVqJAztrcC5ZOz
	5eYrNsd48bCZGrZeQijR6qRSYJv9Ckp0LRAr51F3vaefle1egmfDc2EyNzqxcxv8CiN3NweuFdc
	BMK15Y3ZW+mla786lKzF8pl3HpnnDj7zhdIL9GjqJI/ShNPurao3rOxaSrubO92QOfthKNbZxi1
	3nVGbgIHQgwsb42V89DiyNH6quaAy0qZSw==
X-Google-Smtp-Source: AGHT+IE+b/UbJbOSV/Qqae3kijcthPmQO96sTQtMcZsPgJ26Hq63iQU3NwozLnupIuHJKdRXhWHRVg==
X-Received: by 2002:a17:907:3606:b0:aab:dc3e:1c84 with SMTP id a640c23a62f3a-ab38b274a03mr2403097066b.17.1737709245733;
        Fri, 24 Jan 2025 01:00:45 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:44 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 02/16] clk: fixed-factor: add fwname-based constructor functions
Date: Fri, 24 Jan 2025 11:00:27 +0200
Message-ID: <20250124090041.1401132-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17639

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
Reviewed-by: Pavel Machek <pavel@denx.de>
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


