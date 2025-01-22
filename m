Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D17C02182
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:30 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.41869.1737546685381102887
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qLMAyZyr;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361f664af5so77993795e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546684; x=1738151484; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIusFfIulEkImaMM6nQeNJ7aWzOksXms0pWRi/lmrVw=;
        b=qLMAyZyrF2Ky+fAsFCYBxU5ijzSDUreumKQ9jicOIqW93MBcrJei+IdF4xC8+t/ZDU
         VIlCJoqcNBZBVdF2QcWW5X3rytrIQE3fMCch6IzJtBmQq9rApU4UXovZCxx3YOwcBRLL
         vaD/tBcWQd1MM7PFQII58F3gymRpPOvI0BLQHHAFw0uBIrgq8khswxP5Pi/lsCCvIeXl
         Z0nFMU8hzRJ1lbqutfGR4ptK+qDP8fe0IfOv4ZZ/2VmMfiUMbOQ2zfTdRNR0kogFrciU
         s7vtFvvDHegMF2qfTP1ryC9h/rvEzP18mxCDsQ6mAgUxox4+C86agFx0jGzEG2voQn/d
         iilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546684; x=1738151484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIusFfIulEkImaMM6nQeNJ7aWzOksXms0pWRi/lmrVw=;
        b=bDD9M779dBkif/FSopajpBZjlTDPI96XzNtCE6mdrKiKU7fIgDDplSDJrTNZx2at+b
         VVFbm91cq27AiekoSVBJPHYFX1MtE8Rq5CQBB71/mIC38b20AuiuAGZYpepArOQ9bS5Y
         ULdSW07kHACuNeJtFP8FLZSVqSYcK+K/uqmVTtj8tqf5Buj346kIwqbUlKB4+pZ+szra
         RUVOZopHRtDOWpSIZYNR/866Rc7v/2quo+3DdAD23S6cH2UIu/T5vFMQ61FDi/tLUcOU
         CJEvzWmr56r5WXMyhhqYjVhwZ6mWFtXOihIo9OrKTL/i1/efUrT50S9DYrxMoVAE9YOu
         S8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZOCoHShB+E+G+a65R6eUw2P29HgZYRr3sHPnpMtLinjgK6jeHH6Zr+ygAJsc6rVkST9XpWyhg@lists.cip-project.org
X-Gm-Message-State: AOJu0YzVcRinFx6BjdbV9CztDcB+iX1wx/TCjMYIAiv0JX/10TCPcmr8
	AAJqSlzoJeEgO+y6BrtDADsOwUGSgsamDCkfnIwTQwtmZYH4j8wwC5O/wqluAj41vBmwv/bgeax
	4
X-Gm-Gg: ASbGnctlL8WiR7StShmRfh0v92B0AUpFeo6X+QVVn9XAZKNSUzCvWxqiIUo+sfuxj34
	VgSSPCCzue81DGc5NTxrxDUz/zOqmbQzv2sYEi97RGHXmSCvnu2imB7eNv5ElMieOrTuiwBhjqq
	MjfTfqYvhIjOEVkb5rYAdE9GBTIYMiWW7xTiuNcljMPjlF6yfbWGPDE4mv/pKVEwGQZ7EQa4zb6
	/0vJm/WvJ31NGDI+VXWon4jHU2+4AkNFJC84QSyf2cJ0uijpvRYJpp0admwtpMVGba2+24A8OLv
	tdXRgBGeX4g4OClJPKoYf28OmiTGeLZ4LA==
X-Google-Smtp-Source: AGHT+IGxk32RwQLurWY1PRpzIPJEOvV3j6Y788LoL4Xdg3P/W8pLkZemxP06NOdq/+At+2OpOtJt/g==
X-Received: by 2002:a05:600c:35c5:b0:436:ed38:5c85 with SMTP id 5b1f17b1804b1-438913df210mr214808675e9.14.1737546683836;
        Wed, 22 Jan 2025 03:51:23 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:23 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 01/14] clk: Add Sunplus SP7021 clock driver
Date: Wed, 22 Jan 2025 13:51:06 +0200
Message-ID: <20250122115120.2885015-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17564

From: Qin Jian <qinjian@cqplus1.com>

commit d54c1fd4a51e8fbc7f9da86b0cd338a4f7cd2bb2 upstream.

Add clock driver for Sunplus SP7021 SoC.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
Link: https://lore.kernel.org/r/20221219015130.42621-1-qinjian@cqplus1.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
[claudiu.beznea: kept only the code from include/linux/clk-provider.h]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/clk-provider.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d2c799595d5e..53dd7c9dcc94 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -606,6 +606,25 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	__devm_clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL, \
 			       NULL, (flags), (reg), (bit_idx),		      \
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


