Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E260C0218C
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.41710.1737546755301197104
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bHqkMhfW;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4362f61757fso69878635e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546754; x=1738151554; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsxyHYEIFzrPUxfeETGqg0hmG4mEeCV26g2ghkEEU2I=;
        b=bHqkMhfWH50RloWDXfiqJ6Nd5d9L8MEBxQ3/zzw8l9Mg7OiQz58tCHZ92PfU7qmeNd
         rvRDSe+x7DfZHQfOr7hDTdwKIGC2thQLmqBSSlW77/ijwByn3dL0E+ww050uYBqBuXQZ
         uBepaTMStWxu8XU2R4+sddnjIL+UNFQ+KOY9e9m0xDxrPA23p6aHSpV8g5YnRph8moeb
         ZTl4cKO4fR8tfDpoSI4jtGftJHuCmSmaiduwoOYnAdIgpWBg7xryA2WKF14rVytma1wG
         D8mux24w6OiI2/fxiXBsrHR+EOn7fjRrOSppZSvNBPCLKSQ92nPqAYa5Fv8QVnfP85wS
         UJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546754; x=1738151554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsxyHYEIFzrPUxfeETGqg0hmG4mEeCV26g2ghkEEU2I=;
        b=Yb2tnr9glabgl4/pP663Pyjn99M1l8/B5xnl0nXpW80jqqYKDkMdnRFlbvSZVObgZU
         0Qa8qhczJlQl7jLbClvFaEeKXuchxBWSlY2q8bssYu7+CbQU33k+380a0dmCVprn8WXP
         XWJpTA6fmKESG+6Vdp/4TZV3ao4W+vIy1WQR3oqBxMllYdx3YZaHqGkM1bR+ESBbkcb0
         miA04urxVUVgQypptVxODm6rvD/uN7mc7D6iPngPL576eX+2F5yb9J2U1qPPiKEOm3ok
         EpXVu5yTKrmgCXzY1KeFfMCNIaJiZvZPr7YLSwwZN6omB4R4/90fDxUHrgbO498SNHnc
         Rzjw==
X-Forwarded-Encrypted: i=1; AJvYcCWhCJoZeavPRV/WcNr/p3zsWs1HAGPdQDrasLavaCHJWe/7vOKDV+lI+f5+cz60JQGGFV7FMWnp@lists.cip-project.org
X-Gm-Message-State: AOJu0YwVOse1YN2K0DCIpY0BOhuDZCHSFf2hUQv2Nl+7aeDs35T2Guta
	qHBiW9L+sQUieZxy1xhQPHZREgCgQhrS463zDwbatng6+DoT/88iBtg56p9QNdU=
X-Gm-Gg: ASbGncts6sn6o7ipp9NkozxFsIzOAXlLlDsy0LtL7WucA5tTB12GbHvlMwy/iBoanJe
	P9VcBLRrNrMVjABEOjnpi+St9TBvCezCAXmjvbI17pCKSQXEc+7fMxDHzrFIyaVQEPASIkh9X+i
	yE0g0CekjcbR3uMuQTQjc4KmGjxwOxFp0+Ktmp43bm8ETJNzspf5nSjTqTt/0Au90s7nbkIx1Bl
	DdtvXTZP3eTuKoKBf+RJN58OxBfiLlMfm9upzigBTFkXhTatOnmsqW4KFC5gOwMMzZsafzqN7yT
	Nyiks6EIEnsIvwh1v9+C3PJHMyraF6g5yg==
X-Google-Smtp-Source: AGHT+IHOdP0rGIh0VFc2nZOMX36Z9YR2CXWoAEV4uR7fj0Zuf4zXGyEDRBs8TQMacmeh63UEyF6YXQ==
X-Received: by 2002:a05:600c:b8c:b0:435:330d:de86 with SMTP id 5b1f17b1804b1-438912d2c48mr204988705e9.0.1737546753717;
        Wed, 22 Jan 2025 03:52:33 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:32 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 01/16] clk: Add Sunplus SP7021 clock driver
Date: Wed, 22 Jan 2025 13:52:15 +0200
Message-ID: <20250122115230.2885344-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:52:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17579

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


