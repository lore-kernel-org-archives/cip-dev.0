Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C6DC7115B
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:30 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.7103.1749809788177812312
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JnwbHGf6;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso3378210a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809786; x=1750414586; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlpVlFWigpOlRBPXH4FIbUh78+BhscTIQod7+kqRYfo=;
        b=JnwbHGf6//8FYSxdJWUG7ZJZsFZ/rRhBL5o5BBLkw2Kll3iavIu9tIxlYAEszftgvt
         237ytpcbQ6Y0BMmUs5o1bD4k+S4AbFV1PSf5L/IPMlXGlOFdQlJm9ZSKnvoREfPkO8H4
         2FP8JoqiPvnqzRdg8jgJgsClGdeKG7d3eVShqT6CFs40gasDxXikQbtcX30UVgfqIuSt
         /kN8f87kuL8l6QMNzyOfivBgWRaZDmqJdbkFMQn5hxZoNzydgXW+80jQVG8OlXeVEXdm
         F38myJmAxqT+C+o3I1esaDSrFiNPWpakyGUlERerauIBt0cUiOCIPCe5tRAl8Z6agZ2U
         8Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809786; x=1750414586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlpVlFWigpOlRBPXH4FIbUh78+BhscTIQod7+kqRYfo=;
        b=F+LmbMBc8bBetujvkfnt4aPLPLyY0bS822zEL7B2I5Ri8DoDN7RFTl7b0s8JQWknu5
         rFawUZNcmAR/PdNKmLToayWo9mZEcREHK/w0ImypT0nYQWjkcK15nxlc5RwK6jEeTyCQ
         b9yfM+8OyYRYRGY8Ra17X2vXZCdTzO1r+90FambKx+BlpaC0NK8EXzIQGFCrdIVpoFw3
         1DcTa3y8ZBzA3Ab4jtkaZ0PtjSD6qjghr5tOOgcogarsZkTTdf0v3gFVwdeKYXGvq41x
         jYr/r2xQdseD//zPo91aKV+kAhavNa3k3h9L/aHhGyWJyCX/TRxX4yl/w6sl5Ekxejfo
         TSvA==
X-Forwarded-Encrypted: i=1; AJvYcCULANgNuyQI+nqNkwvUkrGfyE6a8NobkWFXKBAULE1bIC/JO1fOuT1QaCpgAfTeBAnsVVwmOJx1@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz8cUOOop48IUOTEe9D4BOHXd3iMD2xzleAi+5we1ynSh4KpAE0
	KGsf28nKRQpKRoOK0MdjessvxMRNYrPIppQxVYfJ6DSFSQFEcxp/uoY2z7SvOcXRp34K1XIoSZu
	aZcCZ
X-Gm-Gg: ASbGncvHanL/QjOQ/3B9kvkXjWftHrrIa+c2OGnmHfrmxQm6x/20aB0SYzRcxE9+e1z
	ykJ7rctU7Qnl9ckA+C7E8cdGIzeDs8x0vd7L7RcAE2+YJIIY4aR/v5q6ANWgvoZ2g+BgY+9X68u
	bOpo/zZwXBfyVQuEidWV1Wtw2U+iJFrbopZ9lWGiLYfKU6eRtB1Y8venjOaEs2kbZ1RtultF7TD
	KsgqkkCAjkDu4/QVSoVE6Wy07OMCqTGr/UeSsQpIyOPccJMtRC/wjCY/63kbIdRP3HlH3rfsbKd
	JEeuN2o6iDQRz3yHmXy164oHYfXT7k2WFE52rdc84WXn4XpwSB1bAnqvqmIoFmLgJmq2Z/iVqRQ
	gzpYrW1AnnLtXqv8G
X-Google-Smtp-Source: AGHT+IH+DX+F1CGZsrk20aq6MXoDmSNcGXkbDyXT4FFWs5mgSo7CVSwk6RH46eMnj77g1h5UiaitSA==
X-Received: by 2002:a17:906:c113:b0:adb:43d0:aedb with SMTP id a640c23a62f3a-adec5db92c2mr226984366b.61.1749809786534;
        Fri, 13 Jun 2025 03:16:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 10/14] iio: adc: rzg2l_adc: Add suspend/resume support
Date: Fri, 13 Jun 2025 13:16:09 +0300
Message-ID: <20250613101613.296649-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19079

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 0199aa724b7f..41e59310117b 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -88,6 +88,7 @@ struct rzg2l_adc {
 	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
+	bool was_rpm_active;
 };
 
 /**
@@ -556,8 +557,77 @@ static int rzg2l_adc_pm_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int rzg2l_adc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzg2l_adc *adc = iio_priv(indio_dev);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = adc->presetn },
+		{ .rstc = adc->adrstn },
+	};
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
+	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+	if (ret)
+		goto rpm_restore;
+
+	return 0;
+
+rpm_restore:
+	if (adc->was_rpm_active)
+		pm_runtime_force_resume(dev);
+
+	return ret;
+}
+
+static int rzg2l_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzg2l_adc *adc = iio_priv(indio_dev);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = adc->adrstn },
+		{ .rstc = adc->presetn },
+	};
+	int ret;
+
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(resets), resets);
+	if (ret)
+		return ret;
+
+	if (adc->was_rpm_active) {
+		ret = pm_runtime_force_resume(dev);
+		if (ret)
+			goto resets_restore;
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
+resets_restore:
+	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+	return ret;
+}
+
 static const struct dev_pm_ops rzg2l_adc_pm_ops = {
 	RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend, rzg2l_adc_pm_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(rzg2l_adc_suspend, rzg2l_adc_resume)
 };
 
 static struct platform_driver rzg2l_adc_driver = {
-- 
2.43.0


