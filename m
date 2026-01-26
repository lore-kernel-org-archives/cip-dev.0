Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF18E63C8D
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:43:15 +0000 (UTC)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16748.1769420589772811866
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 01:43:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LqHHEZMw;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.67, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47ee0291921so36048485e9.3
        for <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 01:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769420588; x=1770025388; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUFMwJ5/m0HP1u7Km4T4BEo8xEqh/d1WXFBq0kzN6e8=;
        b=LqHHEZMw0oX3Wgol/rrc0VZ6bGatcI/NPzH1TkXAr7eT1O+JRASgMY2OijJ5S+ITTR
         oYOvh5rkeRULr1l6xRXIAe8+z+w9LDckuiuSvhqh0KNPWlEIz9AvigMt1UYeWhMx3WnN
         eBfZsII4SAfz3DsqU5X62wlRr6KyCvm1uuZdQjLxY7Mag1eDVB0/9RLGo2GoTkTqRD1v
         qdflX4ERbU+wsyXtkQbqDNhIjwP9Fd6OMNIrHPJDguwa6Ue7AJ6czPlWK9PULaJWYCmw
         R7uYquSQEvMAkvXYQYQCZO2rG2XcAk6wVnV+9qMWXIlVP4YyC9OJiuhQBssrlfpHlDm+
         HpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420588; x=1770025388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUFMwJ5/m0HP1u7Km4T4BEo8xEqh/d1WXFBq0kzN6e8=;
        b=ft24/sRy2pBsPYuhHcxI1pboGFDi1iTaNjOxzSrxW90Seu/9qo1cNXX0M7gqSUecUP
         erj+YLLut4N0/N6ErAITHaSFGicDwU50QZQvevgtkXDMKNJblZZkiXM5nkc6EYG6s84P
         MQdm0GGvBOJcXvYLToJOONLL4352L7aildHyzqvS+JXK4H+TgvMjySlR9M7xeSxw8BUm
         SXMHvgRRJ0gLsFOmNsHOQC1o5+CM1ZUdk+FZYLIyxiQ0z27FkHQzOx38Qil6JFBAPPf2
         Br004o4eX8RXUz0lPW14GGfZs5H9bBV5ruM3JTz8WG1eaJS0ufIJP1VifUPqu+lYELir
         tAXg==
X-Gm-Message-State: AOJu0Yy6jM1LhW9pib4lbvlwGY/zigMrU1AVwNIb0OhVv0RvNjkQDR2h
	ek46qVBvQQzPdk6qRMCFlCJd4qoyh2W2Q0dE6yy6AZH8PPSgWsG8nK037UWgdPOyN21RNIWfDkz
	jXguv85g=
X-Gm-Gg: AZuq6aIoWVSMYJ4CZ0HjuDPT+/Ji/WTRL2CFF2L7t31TfdaEf1g4Z+JPiK3dciiXUis
	UM7g+Dy2uyegTPKePf7AfDc4Lt5u77GEJLejCO3tUMaGjIgGr66LpOgn68XEhZ3E385pDbcW9I8
	JrHf/wqWQKfkIz7UY84PwG7otuFY8ThUz8e4A/y/OX+pcJ32u7ABYi8MrUb9aESajY0OM+jOesO
	jY/pJqH9f4ArxQs5gRlLQt8TkK+7qZ/vUvwvVdCMmmn8Aquiq9jde0zH6v4FpmmCpYEWqdPYFsc
	cO3oQSQuMc3AR3phJlUIeVu6ViM7LgRZRubJcceil4rdup7OBqudhrdf0/ey8mDz+uiA5SCRA5E
	/XERnFZNmOLhJdcQ5xlqsitmliXTsJ2BTck0/wJMsfgu1p9YQFQDZp7a2IxRiB8O01oa7QvlJRE
	t6t/k86daZYwDa5Z8frpRId2HwlifawX0XhVDX9j0=
X-Received: by 2002:a05:600c:45c5:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-48063973966mr14390915e9.4.1769420588124;
        Mon, 26 Jan 2026 01:43:08 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d61f1f8sm101010705e9.5.2026.01.26.01.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:43:07 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 2/2] mmc: renesas_sdhi: Add suspend/resume hooks
Date: Mon, 26 Jan 2026 11:43:04 +0200
Message-ID: <20260126094304.2528903-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126094304.2528903-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126094304.2528903-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 09:43:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21711

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit dcbce328d3a2d87770133834210cf328c083d480 upstream.

Add suspend/resume hooks which assert/deassert the reset signals, along
with forcing runtime suspend/resume. This allows using the driver in
scenarios where the resume is done with the help of bootloader and the
bootloader disables the SDHI clocks, resets, IRQs before passing execution
to Linux.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea: adjusted as follows:
- in renesas_sdhi.h: kept the include section as it was in CIP v5.10, kept
  the renesas_sdhi_probe() and renesas_sdhi_remove() prototype as it was on
  v5.10 CIP
- in renesas_sdhi_core.c: kept the renesas_sdhi_suspend() and
  renesas_sdhi_remove() definitions
- in renesas_sdhi_internal_dmac.c: kept the code from CIP v5.10
- guard new PM function with CONFIG_PM]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  4 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 39 +++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 53eded81a53e..86c92b588d9c 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -80,4 +80,8 @@ struct renesas_sdhi {
 int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops);
 int renesas_sdhi_remove(struct platform_device *pdev);
+#ifdef CONFIG_PM
+int renesas_sdhi_suspend(struct device *dev);
+int renesas_sdhi_resume(struct device *dev);
+#endif
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 7f80190713b5..0192862f5a68 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -32,6 +32,7 @@
 #include <linux/pinctrl/pinctrl-state.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/sh_dma.h>
@@ -1249,4 +1250,42 @@ int renesas_sdhi_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
 
+#ifdef CONFIG_PM
+int renesas_sdhi_suspend(struct device *dev)
+{
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	ret = reset_control_assert(priv->rstc);
+	if (ret)
+		pm_runtime_force_resume(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(renesas_sdhi_suspend);
+
+int renesas_sdhi_resume(struct device *dev)
+{
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	int ret;
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		reset_control_assert(priv->rstc);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(renesas_sdhi_resume);
+#endif
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 17d693ba90b1..3720f6fb01ae 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -422,8 +422,7 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(renesas_sdhi_suspend, renesas_sdhi_resume)
 	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
 			   tmio_mmc_host_runtime_resume,
 			   NULL)
-- 
2.43.0


