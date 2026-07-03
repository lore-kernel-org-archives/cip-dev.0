Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF3AC44506
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:06 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89967.1783073279171565349
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:07:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=OWQdcIiZ;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b779003fso1684945e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073277; x=1783678077; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eE4sNc9Wld57cnpi2gjGt1RfCVgwEfV0QG5nyCCTT08=;
        b=OWQdcIiZXSJjjgUwQ6A7s9Bv8XiI1kSp5j6tWM88ulqCwO8aFP5qy1Hb633nytrVTb
         H7v399w8DIT9DVR1WGyIrizlXC2PTYVYvB33c+Kte2hX6zy1PWIFKUKDVbMXgJwtzMeQ
         Z/AVXYepGf7KsNWdPtwpp+mB+YuNcuvK2PWX6fv9u6QmVYjBNRi3O7m65MuW4OaA+GDI
         yoyT9iPSIVjOGbhA9A/1sEbaa6AcBUhX9WrF/Vmsn6yWPqhl6Hinf0/xp4wU1gliIFGS
         BHfsbsyUuWSYoyxK1hFLXPvMAnjvBmR2/6aCKyEE7x4bKd1dFHt1RK5RJzNZQcBmYkoM
         wbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073277; x=1783678077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eE4sNc9Wld57cnpi2gjGt1RfCVgwEfV0QG5nyCCTT08=;
        b=G0EvyHgZtfIPnwegRSpZtykjFXDxyqCEfmSOFgCfkqku1GZiJcoEon8+bIt+ctP/y9
         dxmHfTfPo+bygf0e78Z75NreBRZbFhG3G9yXY+OiRJfGi4oA/Bnby0VP7t+dHeLfBnNs
         1FMt7xsglaDkAMJxLUSl+F9CfWWO8qLQvPZdlkTg/aCZReDh6wgTM7svvNSGd9XA7mXI
         xMKTjSE3EWtZUX44fSj28VyU8wOPYRlfFFeMEdmmYMcA0rgUoRbNnBPYYvgPbQaK/BLS
         CPd0i/womQPpGOqqwBb1IZ65Mz2Bbi8RPvWIhhvbFUTkB7omtsccfdRq+MjGXONQjZCh
         aRWA==
X-Gm-Message-State: AOJu0YxC6/JHNAkeruXQtiN93gUW8czwN/eHtHLtas5i7ZX8VoJ0Upc+
	hW+yyTWgREdfNuCDk70pjuqA8SgtW8lKWOfkMcpMmMjL6xb/xi9KmeluS5wsWemR
X-Gm-Gg: AfdE7cmYnUmYRs/UZeSUcTLD7RnStSGEpn4wS3QiP1chB+1EtdcHetlFaDjKFlUxboi
	UJ1lIBoVDXXj08SErIGz2zLSJKYKlhK6yEQU05x6OIC3z1ynt/2O8CfyJCOpY8A7QhqlhtiXfIW
	dB7p3n9pjVYhUbsaj7juQC9CmpJBGu1x4IIBfASfK9+fzhFac0cs0zJCbBC7C/Zy5hJh2LAQL+P
	7JeqD7BNbH5Yb/+BJ/oJWntiI1VO7ld3nT5sfhBLzInfEDio1hg3mAl/zpTiT+cjhg+I56/kueT
	a8XZ+bJ9FG8lje0jNeY5JQeJdiFXM33i+RGxfMQXTGH7njwobAGvrTCseth7888PEh3JFkzXxf6
	8zpO/abqFp5Y1dxixrE09xeywbg58/aIfTVUQYl627w3KHs01fATliPCseaFsRljGE+eN3AD9Yw
	2esXREkpJfmrzdlmsRV7dP
X-Received: by 2002:a05:600c:8711:b0:493:c601:3e23 with SMTP id 5b1f17b1804b1-493c6013fa3mr81867425e9.5.1783073277308;
        Fri, 03 Jul 2026 03:07:57 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:07:57 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/26] irqchip/renesas-rzg2l: Use local dev pointer in rzg2l_irqc_common_init()
Date: Fri,  3 Jul 2026 11:07:20 +0100
Message-ID: <20260703100756.238233-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23393

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

[ Upstream commit dd4e17c309445eeecb8e0252ef9a519505035c27 ]

Replace direct references to `&pdev->dev` with the local `dev` pointer
in rzg2l_irqc_common_init() to avoid redundant dereferencing.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/all/20250212182034.366167-2-fabrizio.castro.jz@renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index d83dfc10ff49..53272237d9cb 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -542,40 +542,40 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
-		dev_err(&pdev->dev, "cannot find parent domain\n");
+		dev_err(dev, "cannot find parent domain\n");
 		return -ENODEV;
 	}
 
-	rzg2l_irqc_data = devm_kzalloc(&pdev->dev, sizeof(*rzg2l_irqc_data), GFP_KERNEL);
+	rzg2l_irqc_data = devm_kzalloc(dev, sizeof(*rzg2l_irqc_data), GFP_KERNEL);
 	if (!rzg2l_irqc_data)
 		return -ENOMEM;
 
 	rzg2l_irqc_data->irqchip = irq_chip;
 
-	rzg2l_irqc_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
+	rzg2l_irqc_data->base = devm_of_iomap(dev, dev->of_node, 0, NULL);
 	if (IS_ERR(rzg2l_irqc_data->base))
 		return PTR_ERR(rzg2l_irqc_data->base);
 
 	ret = rzg2l_irqc_parse_interrupts(rzg2l_irqc_data, node);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
+		dev_err(dev, "cannot parse interrupts: %d\n", ret);
 		return ret;
 	}
 
-	resetn = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	resetn = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(resetn))
 		return PTR_ERR(resetn);
 
 	ret = reset_control_deassert(resetn);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
+		dev_err(dev, "failed to deassert resetn pin, %d\n", ret);
 		return ret;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	pm_runtime_enable(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		dev_err(dev, "pm_runtime_resume_and_get failed: %d\n", ret);
 		goto pm_disable;
 	}
 
@@ -585,7 +585,7 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 					      node, &rzg2l_irqc_domain_ops,
 					      rzg2l_irqc_data);
 	if (!irq_domain) {
-		dev_err(&pdev->dev, "failed to add irq domain\n");
+		dev_err(dev, "failed to add irq domain\n");
 		ret = -ENOMEM;
 		goto pm_put;
 	}
@@ -606,9 +606,9 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	return 0;
 
 pm_put:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put(dev);
 pm_disable:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 	reset_control_assert(resetn);
 	return ret;
 }
-- 
2.43.0


