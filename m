Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E87C3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:13 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web10.10303.1746783127280283399
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=IF4+H63l;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fbf007ea38so3126918a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783125; x=1747387925; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1W0TUCqzjuzZnsyvT/JqRT2j/g/53uR4oMh6vzFwMs=;
        b=IF4+H63lO92BuOvMxDqim/8o3pmr6ecXCCGt2vgjv0DwdJlCTHRnJh7VkmXjPfDVZ2
         Eqsjnmye4ls+4tJipMi1CNuPV0pejxjhMRZyQd+axq1cKatRT54jwJyRt4CzRLxO51xI
         kcE4B5Myeb4A4IqjqTkjl+VWZI/yt0v3hBMVntosFyJY9PIB3hUPWaBImFG6efC6/2YF
         bY9aTzOzQr6LihPC40TZqZYBzTkA9CWPPsiwpxq6woqYdOHbHvU8M4fMAnL8Wc7KP0+e
         VpWY3avfTA9lu7Q8loWww+Xfd178mG8/Z2hi66KX4gSav3y0FzaZWpC6OARPgt8faU0r
         ToAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783125; x=1747387925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1W0TUCqzjuzZnsyvT/JqRT2j/g/53uR4oMh6vzFwMs=;
        b=w8v5EEMdxJHtO1PHpgZxV8eN7O2CHqbGu+awSm3VRTsG1JrVmp05pGrHfV/wQB6p7z
         PrH3OOg1dQCStANS5RIzHXjXDRRAaGgdQn9ZhUChF1WwhAJLs4Z99SeQR/mNK7OPq9A6
         vTWS2i9NZcF9Mej5dJ+36HvoXDZbgUnJGveCmKmZydjNTIBubn/NWemMaT8jfmjO/r8w
         yk9+HWDPEOvXEn5EJtBreOMXxJjMFsYFEhOWMsm4eq+9i91OKc5im8Uh1HiV+x4/7F09
         2cmZrRSdLyI5YC6Q5nwAlbt+VlfAlZiPcMy2UAQbFNppLMz9O3P8miSnd3zRCFcAvWz9
         4hdA==
X-Forwarded-Encrypted: i=1; AJvYcCUzNtpqlda4LUKzcddWqpLRK+gZd3ay4ZlJMlATjutBvefY2oWHcj25W84rGQL1AFn28S7VSFSq@lists.cip-project.org
X-Gm-Message-State: AOJu0Ywg4y6SmBtHHABFr8eGg1xjmvULPNBF0BaYL9JilT4yxyf5kSc7
	iOjvHhxbLyJZ76dTN/I1zovDFFR2xDwm7mAbAsK91M3h8zvu9h4oHsmaJSvurLM=
X-Gm-Gg: ASbGncsrysZGzHnnWnFw9/fAy+JDA+7L6vgRxIDrgoRPnM+xCKBGG/TYswJOtw4smV2
	iVWxpDu5Jgk1hQLOOUpwpaqC36IzQQA3sQsQl7SwPXK3bzc82XtdJN8n/m9JYMWOAVFwltIWrDV
	30pG5N+jp3xXJSrnOSr4c2c4YgwuU6HRMCptZoV/hJNnx/gUJsf/u7o6g7c3rPx1J2kPY3YV/EZ
	Ev4R5AldQSZgL1+hOFOj6TpAIIyytWAmkRa51P0LLpihh+u8cpnyasNgnq1o5ODKazekEm1aRSx
	T7obmRM0PI5tJXgTRu8d++sV/VVDnk8Hjv4HNoDNVQ1G0eQRQLZVZJB8uMf/cj9UWKADMvwDWs1
	hBbaO
X-Google-Smtp-Source: AGHT+IFg73ksml/7iCKjPU5/UsUGNziNdyI2kfpXE8hNZB9tFOQPb9mq+GerySPtNhxARwkpng+1Vg==
X-Received: by 2002:a05:6402:2355:b0:5fc:8d3f:1e5 with SMTP id 4fb4d7f45d1cf-5fca07eb591mr1759243a12.21.1746783125284;
        Fri, 09 May 2025 02:32:05 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:04 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 00/29] RZ/G3S: Backport audio support
Date: Fri,  9 May 2025 12:31:34 +0300
Message-ID: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18787

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S audio support to v6.12.y CIP.

Thank you,
Claudiu Beznea

Claudiu Beznea (27):
  ASoC: da7213: Return directly the value of regcache_sync()
  ASoC: da7213: Add suspend to RAM support
  clk: renesas: r9a08g045: Add clocks, resets and power domains support
    for SSI
  clk: versaclock3: Prepare for the addition of 5L35023 device
  dt-bindings: clock: versaclock3: Document 5L35023 Versa3 clock
    generator
  clk: versaclock3: Add support for the 5L35023 variant
  ASoC: renesas: rz-ssi: Fix typo on SSI_RATES macro comment
  ASoC: renesas: rz-ssi: Remove pdev member of struct rz_ssi_priv
  ASoC: renesas: rz-ssi: Remove the rz_ssi_get_dai() function
  ASoC: renesas: rz-ssi: Remove the first argument of
    rz_ssi_stream_is_play()
  ASoC: renesas: rz-ssi: Use readl_poll_timeout_atomic()
  ASoC: renesas: rz-ssi: Use temporary variable for struct device
  ASoC: renesas: rz-ssi: Use goto label names that specify their actions
  ASoC: renesas: rz-ssi: Rely on the ASoC subsystem to runtime
    resume/suspend the SSI
  ASoC: renesas: rz-ssi: Enable runtime PM autosuspend support
  ASoC: renesas: rz-ssi: Add runtime PM support
  ASoC: renesas: rz-ssi: Issue software reset in hw_params API
  ASoC: renesas: rz-ssi: Add suspend to RAM support
  ASoC: renesas: rz-ssi: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
  ASoC: dt-bindings: renesas,rz-ssi: Remove DMA description
  ASoC: dt-bindings: renesas,rz-ssi: Document the Renesas RZ/G3S SoC
  pinctrl: renesas: rzg2l: Add audio clock pins on RZ/G3S
  arm64: dts: renesas: r9a08g045: Add SSI nodes
  arm64: dts: renesas: rzg3s-smarc-som: Add versa3 clock generator node
  arm64: dts: renesas: Add da7212 audio codec node
  arm64: dts: renesas: rzg3s-smarc: Enable SSI3
  arm64: dts: renesas: rzg3s-smarc: Add sound card

Hao Bui (2):
  ASoC: da7213: Avoid setting PLL when closing audio stream
  ASoC: da7213: Extend support for the MCK in range [2, 50] MHz

 .../bindings/clock/renesas,5p35023.yaml       |   1 +
 .../bindings/sound/renesas,rz-ssi.yaml        |  19 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  94 ++++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  47 +++-
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  63 +++++
 drivers/clk/clk-versaclock3.c                 |  67 ++++--
 drivers/clk/renesas/r9a08g045-cpg.c           |  24 ++
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |   2 +
 sound/soc/codecs/da7213.c                     |  26 ++-
 sound/soc/codecs/da7213.h                     |   1 +
 sound/soc/sh/rz-ssi.c                         | 215 +++++++++++-------
 11 files changed, 427 insertions(+), 132 deletions(-)

-- 
2.43.0


