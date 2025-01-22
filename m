Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D44C02182
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:40 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.41709.1737546753707544888
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=edq4deOU;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so67089545e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546752; x=1738151552; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DKsRpEmyIi+KPFGuqExVc7p9tGBAybqp01weX8x94ZQ=;
        b=edq4deOU1besF5TORMn0IFo83cE4yMSigL5vXHW2y7BBye6ewrWyPYNL04e7mW6p+w
         mRlD/HVlIvUPTEFj1yqdQGim6FoVp2EpEQT8s66OAV5xtoPOMbDgFwgJgP8BwcYnofbG
         Is9P20XjGNoCXa0X5z/z8Fi70anYqo7HO9P1XEHdaZ+whz6FnSE4VlQosacaOnW4x0Ou
         8PSMoF85xeoJ/gNaCp9EV0MxJqP9xDui14M6V8mgV2doqKT4jw2QIF9P9sgabYEZ7gGf
         I+DTNHai1Am9OaKBPvRZPy8J10rzQJnr6kTn4ClODdSNJu8EqmNrLy96hpj3MAExXRyF
         9QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546752; x=1738151552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKsRpEmyIi+KPFGuqExVc7p9tGBAybqp01weX8x94ZQ=;
        b=DfZNo5E6Rh7Qf0yL5wn/Uqps59QHCTS/XnmWnEzS9cM1vZOhFeVu3lo4Z12/etkHvd
         P/gfTnaDm/ZT3jLCM2hSiPd/15LiWwBrqKTDgagImNGvFuuViWW73I37K2evFQGQcy+W
         4JWYrRBL3dFYNomS43UpmPUl10VyUCggc69/ra/qSasOheqc3IezhbahLmnps6nnIYu3
         VL7ZdrDiEstINJOt+bLVqSyApsI127tlrKJPtj0GIqsWGO0YwSfA3LPHQPxV6Yy667dE
         sLlV8YULkAMhht0d4J7E4IW28TseqZu9w3tbMxM/8eWpDIHiNbwgCMkv8kfMZCH1qKAO
         8+NA==
X-Forwarded-Encrypted: i=1; AJvYcCUXNmfAG6d4SBauKSNNIh2hJPrVzWTRZiqY6HOhlc9hp/XIZV7aL4Ni8qr0ywAGJHUtLr+wvnz4@lists.cip-project.org
X-Gm-Message-State: AOJu0YxVnZ2LyFYDrFtZ2jcQqlVZqjFUAdUYILFd7N3B11JtE6UIohqS
	oTXHXLKV+wMa8VhrH9tF0VcDy+wD094d3gYyzCxfvPzGKnIgLSQmeNbAcJkUgo0=
X-Gm-Gg: ASbGncuUqnNzVrHzehijY8lRLpq/GhswuRDg9cNUtfOu+EoI4bToC+E2dxbm3oqF0TZ
	yp/8Lnq36VeXIDNced4qUro3vC5MEXjuyQ6u4FRkktJS9+tCZauzUmk1cppXEDrRj9VoSfrGihR
	fg2Uy7A4BLUXzF17iiroIh/ZM8NlKzZTiOx033zkB6Yzr+Y/n9ZPu6X1N3cMP3tXKhKU8XB3jtg
	zaIIloyRENOubdT8MA0gqyPzVGDYwE5gfpDRAhgsDE3wds7297HKOKw3Q0v7t3APkSqkuLfcVIN
	F2BCPJoxSVyxb56pTZwmwsw=
X-Google-Smtp-Source: AGHT+IGBrF9/RaLLtxlP8mPEuKG+yWQpbSVFYwrznNqVtn15JXydBgHAnDMvJRfRTSKx5doXQFhQIw==
X-Received: by 2002:a05:600c:3114:b0:434:a386:6cf with SMTP id 5b1f17b1804b1-438913bff57mr202833175e9.2.1737546752143;
        Wed, 22 Jan 2025 03:52:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:31 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 00/16] renesas: rzg3s: backport the RTC support
Date: Wed, 22 Jan 2025 13:52:14 +0200
Message-ID: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:52:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17578

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the RTC support for the Renesas RZ/G3S SoC.
Along with a clock driver for the clock provided the VBATTB
is included as this is critical for the RTC to work, as it feeds
the RTC counter.

For the VBATTB clock driver the following patches were also
backported:
- clk: gate: Add devm_clk_hw_register_gate()
- clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
- clk: Add Sunplus SP7021 clock driver
- clk: fixed-factor: add fwname-based constructor functions

and adjusted accordingly, if needed.

Thank you,
Claudiu Beznea

Claudiu Beznea (12):
  clk: Add devm_clk_hw_register_gate_parent_hw()
  dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
  clk: renesas: vbattb: Add VBATTB clock driver
  clk: renesas: r9a08g045: Add clock, reset and power domain support for
    the VBATTB IP
  dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RTCA-3 IP
  rtc: renesas-rtca3: Add driver for RTCA-3 available on Renesas RZ/G3S
    SoC
  rtc: renesas-rtca3: Fix compilation error on RISC-V
  arm64: dts: renesas: r9a08g045: Add VBATTB node
  arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
  arm64: dts: renesas: r9a08g045: Add RTC node
  arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
  arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3

Horatiu Vultur (1):
  clk: gate: Add devm_clk_hw_register_gate()

Marijn Suijten (1):
  clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()

Qin Jian (1):
  clk: Add Sunplus SP7021 clock driver

Théo Lebrun (1):
  clk: fixed-factor: add fwname-based constructor functions

 .../clock/renesas,r9a08g045-vbattb.yaml       |  84 ++
 .../bindings/rtc/renesas,rz-rtca3.yaml        |  84 ++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  34 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  16 +
 arch/arm64/configs/defconfig                  |   2 +
 drivers/clk/clk-fixed-factor.c                |  59 +-
 drivers/clk/clk-gate.c                        |  35 +
 drivers/clk/renesas/Kconfig                   |   5 +
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/clk-vbattb.c              | 204 ++++
 drivers/clk/renesas/r9a08g045-cpg.c           |   3 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-renesas-rtca3.c               | 923 ++++++++++++++++++
 .../clock/renesas,r9a08g045-vbattb.h          |  13 +
 include/linux/clk-provider.h                  |  73 ++
 17 files changed, 1541 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
 create mode 100644 drivers/clk/renesas/clk-vbattb.c
 create mode 100644 drivers/rtc/rtc-renesas-rtca3.c
 create mode 100644 include/dt-bindings/clock/renesas,r9a08g045-vbattb.h

-- 
2.43.0


