Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD5C71151
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:20 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.7050.1749809710338843387
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CiXT38sK;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad883afdf0cso382834366b.0
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809709; x=1750414509; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWWHAN0cKPvZmjCKiQDtk/HaFKAYrR1VP+9K7yswaqo=;
        b=CiXT38sKl1GZFesEVT5IN2IG22RUypO0wZgQ1XRn0fcUulXQ6SUmhYXEIdE3NAPAu6
         WUOqYBkeuAkwIqEZzIddA+ifYFxeYY4Mi22ALlUnkFAfFWyZScFXBJYvKcJ1KOdE+QOk
         3QCAH6yd6MZxllKcPpeSuoQxriIU7ub9mzanzWsATINe+FctG5BzfRuN6pCiZaT9ZBsd
         wDQ/O3tE/lqhXu7H8KaSk7sMZu0N74CFn9bszmSndRjImF5HAaFJr6sJhadHjqgijAtY
         aiG4Bo6GI76NSXq1fU8O5Gl+KY0JVqu23JwNL4k0qRnf6D7WOuJOvnVpi2JlFcgs5gmz
         8Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809709; x=1750414509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWWHAN0cKPvZmjCKiQDtk/HaFKAYrR1VP+9K7yswaqo=;
        b=XdSSkhOibZzn26/A3aNpwT9NTqsyLhvJXIeV5EeItn3oX9uUdFrwuRKvMHkZkP4kIY
         TQc5RfnLm6h6UkuKVQVRQgmM8S+2wtMCP8QkXJ7JFTei3NfzsPdYcV8ScDn9BzGCVndn
         eu1uetlMv44Jq+UnPja4V8Jy0whGNmb7Vr7zRVHYwDzw1yUFtOlmSgYBepYSV11MbwUe
         uT/noC2HN0JOiQJJKFZzgqcKnMivnBxu5pt/ktmoIiaL3z8WdW/gSRWz9Uhxa2Pc66pH
         RqsTmr9TGIo0AIkwGR+D5Z1HPGTTLgyPBme1d9Aqwcgkuh5EJR6bspValpkRWO3EN/YL
         nmtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV34v69EAXWAPUFnTpDf8xbfYpQ4dSW072zTLsZ0i5tT52POVE+CEuCex7QP4RQCypnSFPRuih9@lists.cip-project.org
X-Gm-Message-State: AOJu0YzlZXuOnCRDdKdLsrgt+HSdXRcWkplK02PXYXsZumNRg19fUnw9
	SFWnUt/6Lnkdj54/r/SeBsfpdvdzTym8S46EBQqa9Pryyt6tnED2UGdqk4rFmk95cf0=
X-Gm-Gg: ASbGnctq5SkJ9+9s7ssZQ8TMHz0uOAWZEuT84RgYq0vbkCucmySiSeVC7sqkW5XVUEM
	DfGHv9Jtoe/msy1fhmgIP4REBGjxxyiCJ4iH+ydvrjYZLs18yWI1sST66eLwh/wYk3rZ5Mqd/rY
	fmLImzeJWdaY9sGVF7DIBoQ8vVMMI3E1htN3ig43rI4JhdguILTm78qtHLMEN3Zh0Qm9bnl0LmJ
	3znBWQ3tnDQ7TPmgYDBcXBAmLtvthMLAl4ADZtr8WiDn6r38NM+LKPUa+Chq1zvnGNenp976J0E
	QPuZszrD8AkinRu7qdgZk4C0ZObvUxvOGRDLVywSTVXb2qAWmPy8cf7PU0j8Ym7ByIf/6jqI9bQ
	KSFUfrrBy6QR2lmeL
X-Google-Smtp-Source: AGHT+IHZT3ke8oOH+A/WViLfUlQC4IkRMcrgE/oB3MhXoMsg1IzfVwntQXAQB/M/nrMyEPXsS9mV5g==
X-Received: by 2002:a17:907:d22:b0:ad4:fd7f:a4 with SMTP id a640c23a62f3a-adec5d21b77mr231660066b.47.1749809708651;
        Fri, 13 Jun 2025 03:15:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:07 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 05/12] iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
Date: Fri, 13 Jun 2025 13:14:54 +0300
Message-ID: <20250613101501.262091-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19046

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d7c3e3463492f50644168cbb4e443034052d1c22 upstream.

Enable runtime PM autosuspend support for the rzg2l_adc driver. With this
change, consecutive conversion requests will no longer cause the device to
be runtime-enabled/disabled after each request. Instead, the device will
transition based on the delay configured by the user.

This approach reduces the frequency of hardware register access during
runtime PM suspend/resume cycles, thereby saving CPU cycles.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-9-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 48021edd622e..4f798e9c0905 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -206,7 +206,8 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
 	rzg2l_adc_start_stop(adc, false);
 
 rpm_put:
-	pm_runtime_put_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -368,7 +369,8 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
-	pm_runtime_put_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -433,6 +435,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register presetn assert devm action\n");
 
+	pm_runtime_set_autosuspend_delay(dev, 300);
+	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
-- 
2.43.0


