Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2D7CF65C7
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:43:45 +0000 (UTC)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16752.1769420618071028456
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 01:43:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Ul8mjK+3;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.67, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so42344745e9.3
        for <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 01:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769420616; x=1770025416; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jmx+6QD9eYj2CHEXILgLYL9xXljtZFkukHRqyBjYTc8=;
        b=Ul8mjK+3E7ExZZvbSy+I+AzsH3+BgGdFJffyzG4PLpT+JB++gf1I3dxM7D7wnP57Pk
         S+OZ619dxbI9XS6DFp1n9Mb35GXQSIoKjOEpXyBQdLXnAXzcktiuC0+OE/TW1AcWbr2g
         IzVSSNqaUy1lP6od9hslxXZUEEaPMsFdmbdtEs2HuNzV27wi9Hki6bhGc3tJE0aMyqu7
         x9XQUYmJPiv1nK73jUyw9T2vFoLNFN7cGtDgHjMs0x9xtzZcMJ6Bja9Dsj3rCAf54GyC
         2A4jXHC9H1Eu0z0dbZHXyvdMAWIViJEWuTXeoV5RdZ8OPlVwDfKDtprN4EavOGKYpOih
         kFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420616; x=1770025416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jmx+6QD9eYj2CHEXILgLYL9xXljtZFkukHRqyBjYTc8=;
        b=bQAJL5DM7mD3RvS2v9FvbBvMEiR3CPPB6CJsZJpYVtMgK5GluuPxJJrapS4hJZmflY
         ERIvgP7Zy/Gipcwd2KtTaL7JqFqy5EmKy1VwsfWMqfw1alXTYp76COG4s1R9bh8xgRVb
         sdiA86rNentzAYv56FjeZVO1+L3F0sEfQDxi95/rY9ywJ/S3FRRhq/Vi2PMfRJHxm7z/
         Gk3y8f4SsL8jfIKZkqkYbhq9Z7+F2Avx5gBLabxrb8cn1oLPtbaULwf59KQTFz4XF91h
         tPFSUQ3eE8BDys0HmEkmuKoQ9+oKGteKJXd9O6LmgBWqi4/BP/yDkAh0HfqTVbQnRiit
         Likg==
X-Gm-Message-State: AOJu0Yw3r7pDjZ/1Uye1h1qnUi5IdtzXQ+Utwo96OEtXoN51035b8cW5
	H9CsZbvN9oIqGqRTI3oXI9tYjY2iNspWqRS1HlS808rBXU0q90GV0Dogf7QLQEwROebiQqhu5Dj
	0iA2dKLM=
X-Gm-Gg: AZuq6aJZ9lGDsTMadADpJ9azCpWQQJlwVa6Ferogn/Tr4TWwO0p5G5SR8VeF1GWhPLV
	Cwo55XM2sI1pxjCmIL6nsKe5G4VNF7Q5Deg9DKjRCOPuvcCYhjlOBxBGSHVussVM1fqnEsFUSZ5
	2uLu6bai6ZTJ/s89EHzt/MFISNKlJ8tgar4/3M1KsjgfGgOixx0BbPGqtuy2zVC9JGk5qyVv20B
	vTCmaUS3hxjX5ohz0DNbBqLlG3VnAQxoWHsRp9jp0IfL9TNr3H2Ff8r6WCKF1pRZmdTjkLwO7Dy
	IqpF8wYd/E/jL5RD0JVn+EDIxv8pSe4BfokIt+nC8GSKYFo114tF3kktUXC6SQqNv/qp08eTfEr
	m4SOC5rd6wRhMz4mCgVpN9sV3bGd/tDnM4AMqVqd5WNwO/E6PEK726ZeD73c4q1RdebJ5FoJMwS
	B4s95FvSuM4OftIKZtHeerooQJm7Z9tTaJWtL5KZI=
X-Received: by 2002:a05:600c:4ec6:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-4805cf5f167mr64464975e9.22.1769420616390;
        Mon, 26 Jan 2026 01:43:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804daf23f4sm103692495e9.1.2026.01.26.01.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:43:35 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 1/3] mmc: renesas_sdhi: Deassert the reset signal on probe
Date: Mon, 26 Jan 2026 11:43:31 +0200
Message-ID: <20260126094333.2528974-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126094333.2528974-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126094333.2528974-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 09:43:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21713

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 15213383a3d9195db582729ab3feb923605b6f63 upstream.

Deassert the reset signal of the SDHI controller during probe to avoid
relying on the previous bootloaders. Without deasserting the reset signal,
the SDHI controller will not function.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea: used reset_control_deassert() and added devm action to
 restore its action, as reset control API from the original commit is not
 present in v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 4b84dbb5f262..501598821748 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1018,6 +1018,11 @@ static const struct regulator_desc renesas_sdhi_vqmmc_regulator = {
 	.n_voltages = ARRAY_SIZE(renesas_sdhi_vqmmc_voltages),
 };
 
+static void sdhi_renesas_reset_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops,
 		       const struct renesas_sdhi_of_data *of_data,
@@ -1075,6 +1080,15 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->rstc))
 		return PTR_ERR(priv->rstc);
 
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, sdhi_renesas_reset_assert,
+				       priv->rstc);
+	if (ret)
+		return ret;
+
 	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (!IS_ERR(priv->pinctrl)) {
 		priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
-- 
2.43.0


