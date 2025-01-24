Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675D8C02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:51 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web11.7439.1737709249506588361
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KGC3ViT7;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so3098967a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709248; x=1738314048; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayo5CdKb59CJTycFx199jUbaakFVXPAo61jdVUzYSeM=;
        b=KGC3ViT7DgntE8bXib8K/4LLEAhfBEt6CjsygJdKzanbnWsfnShiGT893vEbfalFog
         uue7pBy5Fs/0+wKznoi6DwS3ph72H/p1HS+dR2owPYRmQV03AQTQ6djnMy9j+pLxgMUY
         CBVmGcwTzqZxBdYlL6K+ecGXevirLTJLIX5eFLbEyEsdY53EBVQUGP5Dr+tWFAWn5G8A
         SktsKuDyeFJuJwslCTJydS4LAhXGuoU/SlfgfCOAELQu6DmxZIVDY13p3wpM24wxx7bE
         oecbMUvzpCF8gpUfXaiFQpWSGQDmDqnwgyWMg9iNjr6cpNvmeyNQgUoSlWrJdcCjC5Lp
         JHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709248; x=1738314048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayo5CdKb59CJTycFx199jUbaakFVXPAo61jdVUzYSeM=;
        b=tT+A20ZxzNCcQpz3K1iqweqTRGwkLhVQgw9dhrnjfTjGWostBAJZVv78JPF23wPGlw
         JYuPJ1wEmMnqNDLH8uwVSoNfXXRLTXuGvrk4fvQ3Epz1R1qMIHFiA/y97wPo4RjEbRT3
         AO+IbV8WaKDBQ2yHRXiUOGzUe6SNluolTwJXINKGIx69SzpGVlKLrvcuN3ZCNrXhrFN3
         dScOCtSw6lvllnCg1uW/fw4vrqA1dDpmYNYvzMsCFyDWA7nQuYqrQ3rA8xO3mx0Wm3AR
         NRMp5lEzu1TPFEm5CcRQQvgdsr5TCoe2obkgVbvJQWIDc8AkCQQtTliBdAvI3KkE0SP1
         X5pw==
X-Forwarded-Encrypted: i=1; AJvYcCU0waGxPMEYnWxdEkVAUD/Jj3Dwc3M1dO763GbGfY819UHnXiZ+a0w9Jk39R6FbqbV8c0r54kVJ@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy4aj8fDJ+mreKxK1yBlhYW2HbnJ8LpQqXzNf1SLPT5DrgVxmFT
	yfEoeGv6xLSh7JXzzEV6Rt1MaDa6fZBfCoQrqRyJjz2elY/C/kUoLSnlYTDTI6VaO7OuRdI6acu
	h
X-Gm-Gg: ASbGncslLm/DB+Z2YKITou55MK/SzJ6uOdB2dvBA5j/Pyyaih5+AcEC46/vz7Hn/svk
	cxPQjNNY/w1/7FZJHeKlqdk5xSGeEw5LHWnZZiP6fI5NZZ6kXtX7juxfl9J6r5BldVFZHPo2emR
	tpkmm6v56n4oH5PtwJhS7nfLIEysLERi3Ynini12Jb9YbgWJkX9Q9N/aCWoaTGqnLHUYzYLWQf0
	a6zjhMUlBiSI9ZtioYoIdIBQiPr1+VsM7Z1zrd/e4XaO9ODmeNkzanZ7CmXSmYmT61AeoZF/ack
	fECJYdp0Nm2MF2EIzIuX4BtMiJ5x8LdUPg==
X-Google-Smtp-Source: AGHT+IE5dVdMgS3tX9U8KiQIkD7cdOVEfNBTI38CbSxzSyNOkZQkro0Lon3N/Ue2a5/i/r2BmmowSw==
X-Received: by 2002:a05:6402:26c9:b0:5da:1219:c81 with SMTP id 4fb4d7f45d1cf-5db7d300633mr67864465a12.16.1737709247384;
        Fri, 24 Jan 2025 01:00:47 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:46 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 03/16] clk: gate: Add devm_clk_hw_register_gate()
Date: Fri, 24 Jan 2025 11:00:28 +0200
Message-ID: <20250124090041.1401132-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17640

From: Horatiu Vultur <horatiu.vultur@microchip.com>

commit 815f0e738a8d5663a02350e2580706829144a722 upstream.

Add devm_clk_hw_register_gate() - devres-managed version of
clk_hw_register_gate()

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/r/20211103085102.1656081-2-horatiu.vultur@microchip.com
Reviewed-by: Pavel Machek <pavel@denx.de>
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


