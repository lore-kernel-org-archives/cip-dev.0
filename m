Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABADC0218E
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:21 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.7425.1737709215747363814
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=M+TLbbOS;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso11920025e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709214; x=1738314014; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyh/eCeUAKyxfgbv4E+U4BbnwMoXJ6eA0t8m+1CZZmQ=;
        b=M+TLbbOSgCieHURNGNB7YRvEEbeXCJyze8psbII0Uym714hSPEEAH0Cw+WxoYPNvFo
         wTJ9J0h+FjCMeX047sx72+o8+5zWhgGP9pd/XNeWhcVcuSrpAWdIvn/XAAeHkQ2gZbUS
         02R7bjwE3l0TcRghqu8EJU47kYnRlYKoTGaQ6qXNgN4zbsawnGpzBNHOv/CDpNxHAdl5
         hKBzw5Gr+0jzFfPbkwgzP0DOsi6JAUSdz9oBwoQ+uU158Dkab/lXfxdKdgyiOG0E+R+3
         vfSDema+a5e9P1rcmFMu1pfdQCg8Cby/i5aODks2fch/ZexDM3guexPYNWl6nFjx47eB
         I7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709214; x=1738314014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pyh/eCeUAKyxfgbv4E+U4BbnwMoXJ6eA0t8m+1CZZmQ=;
        b=fzjn036eeZIJ924cT/R90q041FLp3YJpbK3XNDjgGyWqajRlDIusJpaS7+JR/MAEXb
         pDv2lHp18XscL7Fd2TSUVkr8441clCX9EKQqbb6RCZZGYh+fl7lvCPS71DiVx95ulWO+
         2+kXoB5FkIDTPFQowA9Vpm+8YxOZvzCZNphP2Y5b1ShvM8UStVbjHpLrLp5iiGtI2aWg
         A9fVEiM6dGq1E1LdzwVu4fNPWMRzSdjOGYVLYPDh5zVI5DAUd1hZLS3/rXiPASvSVV8J
         90YjszlNq0kXiHs9Xr5VnNap1z5+Z7JKud7ZRCrESSDRb+dlpmxQXqGNwISHrVCwPvpi
         sxVA==
X-Forwarded-Encrypted: i=1; AJvYcCXRN/6Rxr3Q9xlNjNa0N2vd349L9lIQvlbWao8f98kLzCdtVxCfKSCyPEAwi1r3bp45iPvquEf1@lists.cip-project.org
X-Gm-Message-State: AOJu0Yypj17J4lT3GqXPcyLmEVPfyn0Hmt+jA/L/s5Z6LfIQG+OY9kfU
	kv2O8EfyLnEFfmnW5zYEt+erX8Dg0GPreYrzFUgrsyMPJYiPvfJ+ntp3B7zbqLL3lMXEDzMwW3U
	j
X-Gm-Gg: ASbGnctDDLNr5evfsQ7QEMwKAJ8aWcOY4Oodda087ZqJ0ow7vTFxkqw4ZXQtiMJtlbj
	NtH01un+zA0h6sPqsDVE2GTItRQQbisjvum3XY5Zsms8qVh4gOEMO6JE1ouGqRBSl4S0uKq/yiU
	C8gxH3K/p0Uc6GgYMXdUCe5sO2iKKVuvkyGhHDee3F7XfFFCSOI1MPIiFvV0aUSS5jCXUXfu2Cl
	oBaVf9G0tttOjl+OFNV577pD3/giMYmJOmFuYaSzvcy75BoIEA0sWEvhtMXR7pxvIsDZPVhlvbb
	9MfGFvGFlhY6Su9OvN9Nks0nHT+Z/eN1VA==
X-Google-Smtp-Source: AGHT+IFe7KKJlE/8pIQktghnMMYR3CdDjrylsYfEnNGeU5lYi2D/Uf7s/gXBp+k76Fwf762yB1Ox2w==
X-Received: by 2002:a05:600c:1c14:b0:434:fddf:5c06 with SMTP id 5b1f17b1804b1-438b8841d5amr58998875e9.1.1737709214147;
        Fri, 24 Jan 2025 01:00:14 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:13 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 03/14] clk: Add devm_clk_hw_register_gate_parent_hw()
Date: Fri, 24 Jan 2025 10:59:54 +0200
Message-ID: <20250124090008.1401077-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17625

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e1ef630c56d36770e180f0d0bf7b61b5289f5c48 upstream.

Add devm_clk_hw_register_gate_parent_hw() macro to allow registering
devres managed gate clocks providing struct clk_hw object as parent.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/clk-provider.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 19bd0ad70b08..a0c7ff8d8928 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -606,6 +606,24 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	__devm_clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL, \
 			       NULL, (flags), (reg), (bit_idx),		      \
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


