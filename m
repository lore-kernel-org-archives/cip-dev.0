Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C069C3ABAD
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:47 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.20299.1745934459894119775
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=PXOtHxax;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso977141266b.3
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934458; x=1746539258; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pz/CvvQES+mXSuLnH97JmrlctgJyL6ku7ak79jzxDL8=;
        b=PXOtHxaxr6uVongtUXkf8VbbJlP+JkDlI0/VAhfCJuUxWN52U0MoC6Kd6bxupfvAlV
         VF5VQta2b3uU/cNAUp0JH0JbCnpbsieLRnUC9am6MA+qtMV8agxuN3RQ1Njf8jxtfyTh
         8Y2dp4QR91V8GqXP6pL17V2TGyRgiHRb+UXbYrCsaRA2M0HRDe9dmDuXMps19HUfcdUi
         iksMdLRXstoP+0nyOQmXW/tpzfmLRyuEOfN/RF1jdx4q3kYrCr+2IWAzs7YaM+pOOXrT
         sm4mwHRU644dnDmnIoznsY5gyeQ0DEN1PfWbBqtFlcZlImoIV9nmrvDYvWG+owHcMsyA
         HPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934458; x=1746539258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pz/CvvQES+mXSuLnH97JmrlctgJyL6ku7ak79jzxDL8=;
        b=ISYyaW76oru4Ho9U2/RFsYu25oVQfhPWODJEdS1urVxtA4Z67WbbHDiCA+CRFHGU5x
         yG5K/o7hojVm/jWce6uII03lJytC311z66lU/5sMy1dYmv9bWRLSP9po1sm8qeYNzhBQ
         3w1tiQ7w1uqHE3Wu6KHJgyMgOljGuQXmqn9IKzbXOWEEAh+DwQBRHWjG3DGEBcPw6UQ2
         QHTxUY/rM/EdcbvA7fGMRC/U/fIOWx02GbQBMq0ofjBzysMDN24dpa7ZI5OxwOo8VYDs
         kcxlVoZ/wnpUrg5lWcDtGtejlyV8mATkhbOQQuaKjIy7ghZG3P9ScNim7CG3+/J1BgY2
         ZBGA==
X-Forwarded-Encrypted: i=1; AJvYcCUyUNdMVnze+fL/94mx1I5+78u2p6VkBELBf/y1gP4rklFwy5rU5gwrRV26tI41juKq5iAAV341@lists.cip-project.org
X-Gm-Message-State: AOJu0YxQIi+wymcdU9iifwuWkUC1Kx1OI7Gpko6yrJdV9ksRvXLXsX3k
	FqDoXAphrdgYCBSe/RRYsHmtMM9x/W4jR8Kfp1RrLwj53q57IuTWL1BVbRLyq4Y=
X-Gm-Gg: ASbGncs6XEPSl7JA2qp5bvWNIZlb/pWsCUCVcp+1lQklyNlGpPsBY5Krq0F8026VnHt
	wGPp5A1gfWZlh0RFnfa7MqLXsJEsorEImToU7jmKdRZzJMlHD+qE/zBOWuL7POs7jtBhA5HC8WO
	MU3G3i2eU9zYq/roF6UXldDQzn0JOr6K6+qYd4rob5c5bbxEJAKbeHUfRt9jMhZG+5ms+uxsBwN
	bORkejlFKJcpJQBKDF+EeRBRSJ05QwsuGr2dvLgm9jPTKPY03fFtsoAL/pfFIx9E/NhqWT+V+h9
	UYLrTRl5ZVCitPeeDD3dZlfv2MN+UFV7kWtLlNoSdPYCIU5mvIHMH0eo2fWhUFgggpkoEdo=
X-Google-Smtp-Source: AGHT+IHYcD/TAN1+3wQ+j00N/5n4NX5o9iB5IHRrT7uX/SVvly4RZqg7TRowofNyc/CuN73wL+FRwA==
X-Received: by 2002:a17:907:f805:b0:ace:d70e:43b9 with SMTP id a640c23a62f3a-aced70e445bmr52994266b.36.1745934458242;
        Tue, 29 Apr 2025 06:47:38 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 05/21] i2c: riic: Pass register offsets and chip details as OF data
Date: Tue, 29 Apr 2025 16:47:11 +0300
Message-ID: <20250429134727.2429662-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18718

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 748ee3b2a477821957adfe0ee7d1fd11d0f9a512 upstream.

With an increasing number of SoCs reusing this driver, each with slight
variations in the RIIC IP, it becomes necessary to support passing these
details as OF data. This approach simplifies the extension of the driver
for other SoCs.

This patch lays the groundwork for adding support for the Renesas RZ/V2H
SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 56 +++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 46fd6c249c7e..3dc806f72b78 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -47,18 +47,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
-#define RIIC_ICCR1	0x00
-#define RIIC_ICCR2	0x04
-#define RIIC_ICMR1	0x08
-#define RIIC_ICMR3	0x10
-#define RIIC_ICSER	0x18
-#define RIIC_ICIER	0x1c
-#define RIIC_ICSR2	0x24
-#define RIIC_ICBRL	0x34
-#define RIIC_ICBRH	0x38
-#define RIIC_ICDRT	0x3c
-#define RIIC_ICDRR	0x40
-
 #define ICCR1_ICE	0x80
 #define ICCR1_IICRST	0x40
 #define ICCR1_SOWP	0x10
@@ -88,6 +76,25 @@
 
 #define RIIC_INIT_MSG	-1
 
+enum riic_reg_list {
+	RIIC_ICCR1 = 0,
+	RIIC_ICCR2,
+	RIIC_ICMR1,
+	RIIC_ICMR3,
+	RIIC_ICSER,
+	RIIC_ICIER,
+	RIIC_ICSR2,
+	RIIC_ICBRL,
+	RIIC_ICBRH,
+	RIIC_ICDRT,
+	RIIC_ICDRR,
+	RIIC_REG_END,
+};
+
+struct riic_of_data {
+	u8 regs[RIIC_REG_END];
+};
+
 struct riic_dev {
 	void __iomem *base;
 	u8 *buf;
@@ -95,6 +102,7 @@ struct riic_dev {
 	int bytes_left;
 	int err;
 	int is_last;
+	const struct riic_of_data *info;
 	struct completion msg_done;
 	struct i2c_adapter adapter;
 	struct clk *clk;
@@ -108,12 +116,12 @@ struct riic_irq_desc {
 
 static inline void riic_writeb(struct riic_dev *riic, u8 val, u8 offset)
 {
-	writeb(val, riic->base + offset);
+	writeb(val, riic->base + riic->info->regs[offset]);
 }
 
 static inline u8 riic_readb(struct riic_dev *riic, u8 offset)
 {
-	return readb(riic->base + offset);
+	return readb(riic->base + riic->info->regs[offset]);
 }
 
 static inline void riic_clear_set_bit(struct riic_dev *riic, u8 clear, u8 set, u8 reg)
@@ -454,6 +462,8 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
+	riic->info = of_device_get_match_data(&pdev->dev);
+
 	adap = &riic->adapter;
 	i2c_set_adapdata(adap, riic);
 	strscpy(adap->name, "Renesas RIIC adapter", sizeof(adap->name));
@@ -500,8 +510,24 @@ static int riic_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct riic_of_data riic_rz_a_info = {
+	.regs = {
+		[RIIC_ICCR1] = 0x00,
+		[RIIC_ICCR2] = 0x04,
+		[RIIC_ICMR1] = 0x08,
+		[RIIC_ICMR3] = 0x10,
+		[RIIC_ICSER] = 0x18,
+		[RIIC_ICIER] = 0x1c,
+		[RIIC_ICSR2] = 0x24,
+		[RIIC_ICBRL] = 0x34,
+		[RIIC_ICBRH] = 0x38,
+		[RIIC_ICDRT] = 0x3c,
+		[RIIC_ICDRR] = 0x40,
+	},
+};
+
 static const struct of_device_id riic_i2c_dt_ids[] = {
-	{ .compatible = "renesas,riic-rz", },
+	{ .compatible = "renesas,riic-rz", .data = &riic_rz_a_info },
 	{ /* Sentinel */ },
 };
 
-- 
2.43.0


