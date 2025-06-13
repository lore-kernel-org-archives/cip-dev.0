Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ECCC71156
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:30 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.7095.1749809776656119031
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=WcJdn5DS;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6086502e750so3773005a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809775; x=1750414575; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8VCrg2tVWxPrjOtOKb3GftWC+y65ZslSsYSH9of1g6A=;
        b=WcJdn5DS37uwNxGnRGVNzUIJzpLh5EsN9dBzrSGZkLQRVkqlnjdkWQppu+Pado34We
         3W9AuSQ8x13C7/wIpNpdLrp05H4/zqR2PaohG33QqhGMRBoR2tiAOmO6vLLYA6aP9cpk
         RPmH8Hzti2D/dcAnoXg9ari7tynBtYt+pvYXr0YR67EJYS7YVZsrSOdkrHU1kWdCbjXY
         Np9CFZ70nN7jk3t3WTX9lrcVxNLK4ggQcWINiaN8WUpv/XsT88c5LY6j/vC7tb+d0dkK
         1Tse+7iVzAxSgv3m6T3qOVfLGFjyHoz3YxA4qM5EY031+TH2Mrfr6uaqlVz7AH5U1l9E
         AirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809775; x=1750414575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VCrg2tVWxPrjOtOKb3GftWC+y65ZslSsYSH9of1g6A=;
        b=ipvUWt316sXgBt1iPlfMseB2wgHoo4QwiCkhVjtwRHevesIskKHLVofhtUvIjhjDkq
         Uy6nWTVcSCJddbNf7cGW9pLG0ipusx5wJt+OpEokAH3tNG684wy3yV5ryRxH8t9D2F7s
         +VA3gwJoHFDu6TeGFOpVQVHUyPhRRRYcPzXVKi6VGzZZo43PwsCjqMU8AF8n3PVZkGh2
         LyDj94L7qScwAUzz/W12mSRapZUs3jAb4FtBUtr5pp4ZZW3YweJ2aI6sZ7J5KHsdHsdV
         pmuQN0z5mtZsNmhvLT6tRAMPuUoH2lmy4kSuXa0X2tgyrsMIK1DH/O0Jqu/syAnzAl//
         nlLA==
X-Forwarded-Encrypted: i=1; AJvYcCXap9i3R2swXOnGE03DStS3y9Cyy7fL1/Zce/k3DBXo4nP8ublXboQ5FFTnxVxTK7qJFLMMbp5L@lists.cip-project.org
X-Gm-Message-State: AOJu0YwIaokE9d5Wvp8PZ/n+PjqCZYalfsaghuJNGziIhkS2eBN7eQE6
	AjZnRg/EcYPDim63bahPCt1y6RTw81vqSf7snOlww4FSnK6xRSfvMgcyN/THmrX9+kU=
X-Gm-Gg: ASbGnctQKGLsdTMFsl18G05tg3ufyJxDeIjKLSQNqglyjRVN2f2XehlcHZw/N5myq3B
	VIqWVFOyu4fqGRfM+DzTc3mgpigrLBuQAuPsSobQed0Elnpuv1JdMDKSyf9aeUyVL4gwZ/EBfD0
	xg+ZcSNt8SCqYydKLse+qJl3K9oJwK9WIio59JWxC95+dSK6v8gkcLe+ZJjFHHOKVxfeUAOxtMg
	/ffynMe1R4xZnVJrFxWnimakt2hc3vvmy1eXUAo+V0zIph1AylJEAHFjQ+0MVIyHUEpPFpkgTZH
	sTrmR66+AA4IGZfIA58sgNEIFAWruHcvgrohraQ8VFJ+SaIoy5GK4SpXK9lBfEfLNYa/nUKrgSd
	p97WtHl4fkf+PoRWw
X-Google-Smtp-Source: AGHT+IFQzXBkw52mKa0dCD5ox/Sa2K35LpCgIJGxwLm8tvktTD2xlY9mEWxzcR6Z2qqOdPxiyE047A==
X-Received: by 2002:a17:907:7283:b0:ad5:4a43:5ae8 with SMTP id a640c23a62f3a-adec5596fe7mr262804866b.12.1749809775052;
        Fri, 13 Jun 2025 03:16:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 00/14] RZ/G3S: Backport ADC support
Date: Fri, 13 Jun 2025 13:15:59 +0300
Message-ID: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19069

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S ADC support to v6.12.y CIP.

Thank you,
Claudiu Beznea

Claudiu Beznea (14):
  clk: renesas: r9a08g045: Add clocks, resets and power domain support
    for the ADC IP
  iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
  iio: adc: rzg2l_adc: Simplify the runtime PM code
  iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
  iio: adc: rzg2l_adc: Use read_poll_timeout()
  iio: adc: rzg2l_adc: Simplify the locking scheme in
    rzg2l_adc_read_raw()
  iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
  iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
  iio: adc: rzg2l_adc: Add support for channel 8
  iio: adc: rzg2l_adc: Add suspend/resume support
  dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
  iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
  arm64: dts: renesas: r9a08g045: Add ADC node
  arm64: dts: renesas: rzg3s-smarc-som: Enable ADC

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  37 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  53 +++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   8 +
 drivers/iio/adc/rzg2l_adc.c                   | 426 ++++++++++--------
 5 files changed, 333 insertions(+), 195 deletions(-)

-- 
2.43.0


