Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE24C0218C
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:21 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.7423.1737709213628221883
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YBf8IQBz;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-438a39e659cso11546525e9.2
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709212; x=1738314012; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrRBnKcgXqxrStIRsxwt5XKoQfgDG5P+3dvITQgP9pM=;
        b=YBf8IQBzpi8WuHAzOVgYvplW2Cgx5n8PMho/nl7MKzQjuXm+b7XHapLTo1iH5jpMXI
         OviEfohQP2RaAzfC894vqR5zUr0j3NgFQF5Rf1tUd994aprVSfpaPGmiI6WF1F7L0ujw
         uU0v1JVAh8PSr3VzMAsTMZo0bfwRpPStwa0TFFf2e0guHpt9uTRClVbgzzT7gXmLnUZa
         MyOQGzeILYugLEDu52qZGFRqW9r8UiHF//BS1Cbnnlu4tkLbQMyIcouSl9PJxl5INBNN
         DbiQPXYGoFgB5c98nP/c5I7a5/NgzrAMgu6ljbZOE4h5XtPHhNYCMtA0dGzURVdRNoHO
         oJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709212; x=1738314012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrRBnKcgXqxrStIRsxwt5XKoQfgDG5P+3dvITQgP9pM=;
        b=u1dXlHozC41LGGFNfaqXgLJG0Za7K7ZKt4CDo4DCKlHZHaMgVeamA1Yg+bZkQQv7kY
         ZbZ62T/PWl/yV+ALEMvXl2RBXpnN4dh7kcvTCozE75e3Pu1UrHN5hc2a0nFud02x0AOJ
         5D3/3J+mg4eE+PDxFIvrR5x3G5fkYpERVPW8X8TvSClFlFO5IaRpuE3zBlsENYRpfdmc
         L27FRuNjXdo4ttKgdDFjP5mCeZ2anNZMHm0YWMM4Zjw3RGWbIjUsXr3mjhfH/NBL2clH
         a4S5RkSGonRefEBmlbCu8YSj+Tu/BcEoRUN4fSnAsfQr2Is5crXevUREK028AbeeZb+P
         iWag==
X-Forwarded-Encrypted: i=1; AJvYcCUQBS20quUI3jpvRYCfG9d6O5d844YJvw3TSYlx9D2qzc09/WRXLD2Ko/oGVY1F9dGVk6OsWVP8@lists.cip-project.org
X-Gm-Message-State: AOJu0YyUWkNFA7t/OaxjE8xLsxZnv1tFrwh4nH1ijU/TesFUrZUH/KF5
	GfOKxXPC4K64VK+JgM2DbGXUEGpfk5J9/ivl9TBtXjp9zSL4DNEisbRdXr+m8vQ=
X-Gm-Gg: ASbGncuMZSRAfxhmIgTnjs0M1jHNN8OuTWDbG7nacChfW5YI5aRbTic923jg6qoCf93
	TfQoIaYIUeSCeMWW33By4h9zCRrrl+vOmVTgCDXAkZJ9nHhQpZ7Gi27HrJEC0HjHdSg0/SFRn1A
	g12LGr/v+8sc/P9IRinhOl8NOTvTakNr0z9Bb89q9TixrMgpYJrqsJLgB8udu/mk55x+pP3aiTk
	YOfyM76O40WB/TVWDwXbNsazYfyR69FAcqQZyXSvsWDNnJCQPKi7HE7JK6mwy6TSDEJe1atnTyM
	zo2O5SuRuu3HIaivO/GB1ZBe3GwmpQoARg==
X-Google-Smtp-Source: AGHT+IF64M7rRMllY/S/3UQs+862UjI7huFE2teaXa7sJsSOi6iOafpkNKBNJ6l1XmCfXvDbgip9lw==
X-Received: by 2002:a05:600c:1d16:b0:436:a3a3:a70c with SMTP id 5b1f17b1804b1-438914390dbmr243973575e9.28.1737709212027;
        Fri, 24 Jan 2025 01:00:12 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 01/14] clk: Add devm_clk_hw_register_gate_parent_data()
Date: Fri, 24 Jan 2025 10:59:52 +0200
Message-ID: <20250124090008.1401077-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17623

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add devm_clk_hw_register_gate_parent_data() macro to be used in the
Renesas VBATTB clock driver. This macro originates from the upstream
commit d54c1fd4a51e ("Add clock driver for Sunplus SP7021 SoC").

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


