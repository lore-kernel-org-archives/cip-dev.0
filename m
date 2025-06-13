Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF3BC71159
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:20 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.7074.1749809714184110490
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lOYhGd/e;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad8a6c202ffso355420466b.3
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809712; x=1750414512; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENO5VprJIDZl6ijK9/zcJK0O9UXMHU2a8JUuMcJCqek=;
        b=lOYhGd/eKRsb/FOVk6X/nqjg4Ts4p/7qAk9s54Up+izfiuoSgh/Sdzn5JBKGY/c2Js
         zNnEvokiNKXDFEEksdxgQQij1BOT3wM6DGvynOSWA35sj3bygeYicbtGrjot0uYnzp/Z
         Syzy9HQEp6B3YTTQGPm8hbPN2ypWIaaZhoODKn5i0+ngAIQrgBpDUTHZ9JtdYwOlAU6k
         xjlfDCi0blFKdblxMS/TKj9cHdOU3FJcL8MW+GBMvXOi0yzK5QZDJn/YmnIqsI3favmD
         WPKnTOYzF5xdT53/mlZoSeK1nhYcjssebhg82FSnTSkkIIui4h9P82g/U2jF8JqJz5zg
         pNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809712; x=1750414512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENO5VprJIDZl6ijK9/zcJK0O9UXMHU2a8JUuMcJCqek=;
        b=Byu9K7iavoFmZtbFvsYHg7pw5ydhcuOoCTyRBMy8/B7Ajv+q8wp/O6qVFzT0gc8qle
         pEkfFVsYA+z+v1TTd3aHcIWrbIDoS/apxBIlB4IytsMWfvH38uI4wPDidgYvk2IvVp/L
         xvgslYhCy4OpnjzGsHeV51CrTcEIYm+3m84TnPIsQ3L0+ztO1R4YyI9NvAe7D5gllbku
         4prvIpZhF8UPl7qkUC29P3kG3h+cFCfQeBDQMEXK+GSxlYhVmi5K/28LjMK/r82wPvrv
         inFmku36iuGG33KdW9gULC6NVrBTxTIut+NkRfaEreufJZJPhtcNEv5oQEw8GLksXcFP
         a8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU/LrXo7mCD/OBhN3Ae02s9GbUEmYYIE9z/eQ/9BvP3bvPovLtAu2k8YCvcVM2Nn4YPuvoqNIir@lists.cip-project.org
X-Gm-Message-State: AOJu0YwAYZvxir8NK5o2L0WEohtu+gIr41oTIMYo4LD58FFU9C3lr/Pj
	T8NSIEp8FimAsg+eI9tmYSeYetRVT1dNa7Y/PHfkmMDIp+lqjmmJZjW0ye9z88r060U=
X-Gm-Gg: ASbGncvFdNIRFBGCzd5eQjO4Wkc+FEeerOOTl/ik0eoleqSI6znKymw6mu2nGsXj9nz
	aPEleU7XIjnw/t3sWBSod+pXCYiw3cgs040OdUjZ/oYniFAceV2h6C8mRjDjCS0gDPuY+mJoL2f
	kq/pE3KlJ+a41fC2C0dbqJX/jbaD4Qu6k9ViOe/rbBv9I/ZXGWqFORRvwpyTFUqvEMLt9DMbiMG
	a343DLpXoPoYQLL7nca341ajJvpWwc9a6di03ViY7WDxWDLPW3w7f71FBkL5tG1pnXfhLgkS9IB
	3JglqvaskShMrH9XDBNn63MOQR592LQE1ekN9/UDqRTUMphaRlMWtLr5hL3ctNPJCWJQPOxd7Cz
	sKwpckZYicP2fekmS
X-Google-Smtp-Source: AGHT+IFzNdVzcCAuB4tPQ/xz78v4a1j9wkp9Q2v2V3lgwV9uhqSzFFpSkBT3gQauBTUNbobKqyCIpg==
X-Received: by 2002:a17:907:3c8c:b0:ad8:8f44:134 with SMTP id a640c23a62f3a-adec5c15f97mr235486366b.46.1749809712500;
        Fri, 13 Jun 2025 03:15:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 08/12] iio: adc: rzg2l_adc: Add suspend/resume support
Date: Fri, 13 Jun 2025 13:14:57 +0300
Message-ID: <20250613101501.262091-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19049

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 563cf94f932946521ce885a089399a2c813c71ab upstream.

The Renesas RZ/G3S SoC features a power-saving mode where power to most of
the SoC components is turned off, including the ADC IP.

Suspend/resume support has been added to the rzg2l_adc driver to restore
functionality after resuming from this power-saving mode. During suspend,
the ADC resets are asserted, and the ADC is powered down. On resume, the
ADC resets are de-asserted, the hardware is re-initialized, and the ADC
power is restored using the runtime PM APIs.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-12-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[claudiu.beznea:
 - used SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS()
   as macros are available in v5.10 CIP
 - added __maybe_unused on suspend/resume function
 - dropped the usage of pm_ptr()
 - dropped the usage of reset_control_bulk_data as it is not present in
   v5.10 CIP and adjust the code to use reset_control_deassert()/
   reset_control_assert() for individual resets]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 74 +++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 1af5f4c0a2d2..2e94d163ddd4 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -86,6 +86,7 @@ struct rzg2l_adc {
 	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
+	bool was_rpm_active;
 };
 
 /**
@@ -551,10 +552,83 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused rzg2l_adc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzg2l_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	if (pm_runtime_suspended(dev)) {
+		adc->was_rpm_active = false;
+	} else {
+		ret = pm_runtime_force_suspend(dev);
+		if (ret)
+			return ret;
+		adc->was_rpm_active = true;
+	}
+
+	ret = reset_control_assert(adc->presetn);
+	if (ret)
+		goto rpm_restore;
+
+	ret = reset_control_assert(adc->adrstn);
+	if (ret)
+		goto presetn_restore;
+
+	return 0;
+
+presetn_restore:
+	reset_control_deassert(adc->presetn);
+rpm_restore:
+	if (adc->was_rpm_active)
+		pm_runtime_force_resume(dev);
+
+	return ret;
+}
+
+static int __maybe_unused rzg2l_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzg2l_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ret = reset_control_deassert(adc->adrstn);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(adc->presetn);
+	if (ret)
+		goto adrstn_restore;
+
+	if (adc->was_rpm_active) {
+		ret = pm_runtime_force_resume(dev);
+		if (ret)
+			goto presetn_restore;
+	}
+
+	ret = rzg2l_adc_hw_init(dev, adc);
+	if (ret)
+		goto rpm_restore;
+
+	return 0;
+
+rpm_restore:
+	if (adc->was_rpm_active) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+presetn_restore:
+	reset_control_assert(adc->presetn);
+adrstn_restore:
+	reset_control_assert(adc->adrstn);
+	return ret;
+}
+
 static const struct dev_pm_ops rzg2l_adc_pm_ops = {
 	SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
 			   rzg2l_adc_pm_runtime_resume,
 			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(rzg2l_adc_suspend, rzg2l_adc_resume)
 };
 
 static struct platform_driver rzg2l_adc_driver = {
-- 
2.43.0


