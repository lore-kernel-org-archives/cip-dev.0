Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE93C3ABAC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:57 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.20309.1745934470099814550
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EY3tmC/O;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1019207566b.3
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934468; x=1746539268; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNsAMCj+63n4IAfXV792XsiTyCQxv2avWWLuq4rD9jo=;
        b=EY3tmC/OxCE8PHKaaj3OAAeTJCRLLThk0L2ZrE0EguFeNKiJChut/YdMyeCWrGL/Wj
         9MeS2AmeZ5sdMGFKujY2Db4n8JALh7OcGCrHF5EZDskDaC9YG45QmPCb2hd9VZkVK6MY
         m4lD7qDa3+n/JAC6jM4RNiwez6SN7IBA953zKTBsnQQmLAnYI4ieW8AlhHSaqb1qpEe6
         xRfLK1c4c1ySJgvPYaURswudh3rBcUQj6iJ52oQtbWlJfWOI3qwFNqX6HARbbhw0ZvS9
         nVWAZu9Jdo6kSF0UWsRe74XHl+7xMcoCV8o/k5BJh4KrRmoCWi1u18CxSbkaEMR8Cc/s
         kK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934468; x=1746539268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNsAMCj+63n4IAfXV792XsiTyCQxv2avWWLuq4rD9jo=;
        b=HUt0fWfONFhoeBuWejxP8Dg4zRE7TBzlDrh6XFAbFA1iA5oWpBJMZlhHCqqTeW+X8g
         rgo8nSJauESWUoBnhhxhe+bPMZTmrSvnJj/+cKJ3KNInrmq/xtKvHlEUuko+uDXwVXem
         jRPEsW7cp1KSa0+0gu/yUSMjB7QYSySlnBavN7JVc9Zh+Bh6TmuCMKQEDLnJmC0oAvDB
         Pj8t0IoyX49pBVPoZVGipf6qQlwcpI/AvMBL/mmI/ODyMY0ePJI8Dz+IW6FBR4lS+N4k
         UdNj6ggap1Ng7vyD6YHbJ3m0LMbsTC8b/yYLcWmskqUhCkTUb6/8kAWB3e0EJh6Iwd6g
         RuhA==
X-Forwarded-Encrypted: i=1; AJvYcCV+v/sQlrwOihaJ/gsN0UsEg2SH+UNAwrYUkTcBh3fYOCfkyVWwCbQbgeFX2rZiGA5s1lp1qB57@lists.cip-project.org
X-Gm-Message-State: AOJu0YwJPQRn6UcAnIxu3yQyn2lU+OTpSMh2D5YCQPge1A/TieWs2pys
	PKcYPeK6c2hnQWz++JuSEr7EnaJu4cQlK65g9nVzv6Iu//R0UCkBkbNbQOvsvfY=
X-Gm-Gg: ASbGnct7z2umHLdqQta5WFIGLwxjv1KQXJpboGA8ZESRAFWvw+dN5ffd/ttM28TZ13Q
	4H3Ai4vOV9itlNXyMGtWGdUSSVe8NPWGEj/FoCRRXhWV5iwtBQ4mBIpiT/11UraXhJEO+hA0vUg
	eGM5soaQ0SWVpJ29EfAuUUn1wjdB76poa69BCA3wPHinhNBSGEtEM53DnOrPfyNCmf8ntWG0qzC
	x0dbUCh35bOueL4pLQm8X59R98MOuqfLgDB1q2xr1ynKyLQdUgiozByQqgD7wB1D4bEj7wNmP39
	IOISvgm3B6VbWb6BSXjGcdE+BW4EmPB5DEVwJe3vbIQk83GvzqHVl/9UdBHFOSd91UnvI54=
X-Google-Smtp-Source: AGHT+IGlp28V1BtTkXCgJKhdDb0F1JDJfWEDaVXhng0HpnjRTQWxS4zBc/yJ8WxGnJSS0r/ppxjesg==
X-Received: by 2002:a17:906:3447:b0:ace:6703:3cd5 with SMTP id a640c23a62f3a-acec6973b77mr257514366b.19.1745934468510;
        Tue, 29 Apr 2025 06:47:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 11/21] i2c: riic: Add suspend/resume support
Date: Tue, 29 Apr 2025 16:47:17 +0300
Message-ID: <20250429134727.2429662-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18724

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 53326135d0e041ebe7d08bf22f82529ae69a096e upstream.

Add suspend/resume support for the RIIC driver. This is necessary for the
Renesas RZ/G3S SoC which support suspend to deep sleep state where power
to most of the SoC components is turned off. As a result the I2C controller
needs to be reconfigured after suspend/resume. For this, the reset line
was stored in the driver private data structure as well as i2c timings.
The reset line and I2C timings are necessary to re-initialize the
controller after resume.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
[claudiu.beznea: use SET_SYSTEM_SLEEP_PM_OPS() as SYSTEM_SLEEP_PM_OPS()
 is not available in v5.10]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 73 +++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index d3c17891970a..eaa11b3edd2d 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -106,6 +106,8 @@ struct riic_dev {
 	struct completion msg_done;
 	struct i2c_adapter adapter;
 	struct clk *clk;
+	struct reset_control *rstc;
+	struct i2c_timings i2c_t;
 };
 
 struct riic_irq_desc {
@@ -303,11 +305,12 @@ static const struct i2c_algorithm riic_algo = {
 	.functionality	= riic_func,
 };
 
-static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
+static int riic_init_hw(struct riic_dev *riic)
 {
 	int ret;
 	unsigned long rate;
 	int total_ticks, cks, brl, brh;
+	struct i2c_timings *t = &riic->i2c_t;
 	struct device *dev = riic->adapter.dev.parent;
 
 	if (t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) {
@@ -424,8 +427,6 @@ static int riic_i2c_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct riic_dev *riic;
 	struct i2c_adapter *adap;
-	struct i2c_timings i2c_t;
-	struct reset_control *rstc;
 	int i, ret;
 
 	riic = devm_kzalloc(dev, sizeof(*riic), GFP_KERNEL);
@@ -442,16 +443,16 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(riic->clk);
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
-	if (IS_ERR(rstc))
-		return dev_err_probe(dev, PTR_ERR(rstc),
+	riic->rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(riic->rstc))
+		return dev_err_probe(dev, PTR_ERR(riic->rstc),
 				     "Error: missing reset ctrl\n");
 
-	ret = reset_control_deassert(rstc);
+	ret = reset_control_deassert(riic->rstc);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(dev, riic_reset_control_assert, rstc);
+	ret = devm_add_action_or_reset(dev, riic_reset_control_assert, riic->rstc);
 	if (ret)
 		return ret;
 
@@ -480,14 +481,14 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 	init_completion(&riic->msg_done);
 
-	i2c_parse_fw_timings(dev, &i2c_t, true);
+	i2c_parse_fw_timings(dev, &riic->i2c_t, true);
 
 	/* Default 0 to save power. Can be overridden via sysfs for lower latency. */
 	pm_runtime_set_autosuspend_delay(dev, 0);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_enable(dev);
 
-	ret = riic_init_hw(riic, &i2c_t);
+	ret = riic_init_hw(riic);
 	if (ret)
 		goto out;
 
@@ -497,7 +498,7 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, riic);
 
-	dev_info(dev, "registered with %dHz bus speed\n", i2c_t.bus_freq_hz);
+	dev_info(dev, "registered with %dHz bus speed\n", riic->i2c_t.bus_freq_hz);
 	return 0;
 
 out:
@@ -556,6 +557,55 @@ static const struct riic_of_data riic_rz_v2h_info = {
 	},
 };
 
+static int riic_i2c_suspend(struct device *dev)
+{
+	struct riic_dev *riic = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	i2c_mark_adapter_suspended(&riic->adapter);
+
+	/* Disable output on SDA, SCL pins. */
+	riic_clear_set_bit(riic, ICCR1_ICE, 0, RIIC_ICCR1);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_sync(dev);
+
+	return reset_control_assert(riic->rstc);
+}
+
+static int riic_i2c_resume(struct device *dev)
+{
+	struct riic_dev *riic = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(riic->rstc);
+	if (ret)
+		return ret;
+
+	ret = riic_init_hw(riic);
+	if (ret) {
+		/*
+		 * In case this happens there is no way to recover from this
+		 * state. The driver will remain loaded. We want to avoid
+		 * keeping the reset line de-asserted for no reason.
+		 */
+		reset_control_assert(riic->rstc);
+		return ret;
+	}
+
+	i2c_mark_adapter_resumed(&riic->adapter);
+
+	return 0;
+}
+
+static const struct dev_pm_ops riic_i2c_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(riic_i2c_suspend, riic_i2c_resume)
+};
+
 static const struct of_device_id riic_i2c_dt_ids[] = {
 	{ .compatible = "renesas,riic-rz", .data = &riic_rz_a_info },
 	{ .compatible = "renesas,riic-r9a09g057", .data = &riic_rz_v2h_info },
@@ -568,6 +618,7 @@ static struct platform_driver riic_i2c_driver = {
 	.driver		= {
 		.name	= "i2c-riic",
 		.of_match_table = riic_i2c_dt_ids,
+		.pm	= pm_ptr(&riic_i2c_pm_ops),
 	},
 };
 
-- 
2.43.0


