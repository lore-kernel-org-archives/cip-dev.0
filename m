Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBD2C61DB2
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:40 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.7128.1749809790375165381
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qfhmpydS;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so3031721a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809789; x=1750414589; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74SEsl7w0MxKp2l+FL3lPjAKUx079z1T69l0QIGtZL0=;
        b=qfhmpydSeSJuEDhNqq8MZfsYh0Cs5ytCy6I2lmzqS0CQNC36uFgEeSNDfJOEU+TnI+
         GcozDVCVD3mFtMXsiOQQagQLMTtWQgA00CNS/Rq8Vt9ugeJ+1pa0WNKviFBt6yZ591Kl
         p0oqX7FY/e6e1Cg5pv6SMG4xP7rShOccvLsSCA7PiBe/o/oJMxGAoPN1gHklKtcMrf1w
         rE7gzQXHVCxOmcmNsIwQP2zSuilwhbusWlJYdoKEL3SgifgMt6lg4Yhpa6C4e+53hVep
         OwSL1/eOY9L+IwpSv0r3CsVi7Jq75mg87pGrKfWahE+cPn4Hx8ki09HQBXENmGIvwoo7
         pGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809789; x=1750414589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74SEsl7w0MxKp2l+FL3lPjAKUx079z1T69l0QIGtZL0=;
        b=q/4y1kgDStNh57K1rwie7jofd6Jh0NXLyzSTEhIME4oHY0/SYRUofvqlowXhyzfJTX
         4ofInQORfTuS0m8+cwa/Nybj9p8NA0qYSJeJmO2H70/HExL3aW0OlCzjTssBK5Z0A5fy
         5oyMB5D3bfhywy/cvwkCp5ZD3EacHof0xuDMKMXBrMfVh10ODxSuGkCAYlZQZTNOytv/
         8Facg1PVyVd6G30F9PM5C3SwVd0OQw4/i7o1a//VpR3S9DMLAwJIAPbYDzeHUZJHctBC
         VNS23o1HJqVghExKSt0L1AkYC5sx6OY7+truhFfn3TupiO5qyaaGs5RQJwWT/Yqhohq8
         MCjg==
X-Forwarded-Encrypted: i=1; AJvYcCX/hwCYa2g+tUm6ui9Hm7StRvuvsh/785bMcRYJ6U2yEYvrqm5AjYUVN9I+mL8Uu5VgFGvx7uQE@lists.cip-project.org
X-Gm-Message-State: AOJu0YyEZyX5eEpJGR26fc/B4gORZCAYVt0MhlNurtc3kGl5cROsFIeY
	wKj8xmwk98ZgYTe37cUWNy3uUBAk0in0bs1p2VlzHIItwbNzWTRs395bUJiLVNg9UOY=
X-Gm-Gg: ASbGncuYo48vi7aXqTagY6SkXpcCFvKZgIdWfUy5r6v9ngEU8u3kt4+ZiVlbQVuru3D
	Rt/jreDw8OYi4YEbLzkPFWF0j74VnM0ratnVouuYJDdlHnHawVP4lyx+4OO4YfBaZT+NNkWedCx
	pRS76PVyKmef0JRArIsWTCOriEX30rQP63ycILdnmI0ExLJ2w3yAAU0raXrEBxlW1xA6m6Rp8oJ
	0WtEv2TyuHF+UPhPyRubE4iq5rVH325JxprYfhHjH1Fk8aNRlKRjLpUzy4j/0HCRzvxh0uBanMB
	rlk9qaXenVMZrl8H3grx3rE1e4CfpnF+LeMq3JWxNlt0BilrJo5fTAUorYhwvoiPLSGJwm46RKh
	VYVIwOcxDJOmmmxSe
X-Google-Smtp-Source: AGHT+IEt77qd3xkw/PEQbe1vaN0aWZfKu2dndCu1mhfrvePMkNMEZxTFAJqLMvEpJ0TrmePZbXEWIg==
X-Received: by 2002:a17:906:9fd1:b0:adb:469d:221f with SMTP id a640c23a62f3a-adec5bb5e01mr249833866b.31.1749809788764;
        Fri, 13 Jun 2025 03:16:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 12/14] iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
Date: Fri, 13 Jun 2025 13:16:11 +0300
Message-ID: <20250613101613.296649-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19081

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 645fb7c22fd8d27c223b0e4abff442632bd9a75a upstream.

Add ADC support for the Renesas RZ/G3S SoC. The key features of this IP
include:
- 9 channels, with one dedicated to reading the temperature reported by the
  Thermal Sensor Unit (TSU)
- A different default ADCMP value, which is written to the ADM3 register.
- Different default sampling rates
- ADM3.ADSMP field is 8 bits wide
- ADINT.INTEN field is 11 bits wide

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-14-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 41e59310117b..6dc97fac0e7f 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -531,7 +531,16 @@ static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
 	.adivc = true
 };
 
+static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
+	.num_channels = 9,
+	.default_adcmp = 0x1d,
+	.default_adsmp = { 0x7f, 0xff },
+	.adsmp_mask = GENMASK(7, 0),
+	.adint_inten_mask = GENMASK(11, 0),
+};
+
 static const struct of_device_id rzg2l_adc_match[] = {
+	{ .compatible = "renesas,r9a08g045-adc", .data = &rzg3s_hw_params },
 	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
 	{ /* sentinel */ }
 };
-- 
2.43.0


