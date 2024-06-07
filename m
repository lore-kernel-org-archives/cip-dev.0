Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF4FC27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:01 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.43031.1717769340217034524
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MO/piOrH;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso75778566b.2
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769339; x=1718374139; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBuL5Y0t4elqBQiB0npap5acobXPq4LeZqt4PSowK8U=;
        b=MO/piOrHQSXm800RCoz4hf1Vhydo0iwXYigA/cF7yh5+Ct4X6tEOuhnijlXmIfMXDr
         +rvEP/g83SWZCIOpSyNiC+WW55EIywr8MjCwdLhkoHnjBhEd9A1HD1YLxuTJOPsks5U8
         QMCuTCwkxj6cpPnOF0fB0a+OFmnLTHt50oiTNV6m+tSrXcRlVF2la/T9Lon5SddzbFTH
         OJWD/uT1Aa8ZyiA5r48H3mkaGCA1f3JtTy0S+sdoc/Ef0xzQFCwwo3W9arBD82VWgY1E
         SXA1oQveVE6n1ZhJ9J5FZjMU1+x7cRVXHpsVe2uZIeksP476rHmKnY+2/KG0HIerRo2S
         b/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769339; x=1718374139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBuL5Y0t4elqBQiB0npap5acobXPq4LeZqt4PSowK8U=;
        b=HeOIcRRtvPaU04M7FNvjWe/GA46v0kOJugqj22oSM6ruoPzwf8FhjOFdjA2R7hoew5
         o0juw/5Qnk/rNHZGFwL06bsZpHfP5qBLyP+5e/utBRUW4rdGTto7w0gXAztxiBJnLUk/
         wl+DMiTYLfFvrnR2yEZz7cfNhuY9EVMDA/RQycVdNneuYq+eT++wwgm4iIskr+2tiZTp
         wHKbj16gwOaq4e9SLK3JbRyN6BZ9/619hD3T/MhTJC9KgtayVYjCWNpmXfZED9Wn25ZI
         5OKgiqM0fQ9p5kk/NAxdB0NwdRJZYJTgQgz3d15cH+iI2ag/6Z254mQJNtZhLTODgv/d
         WmoQ==
X-Gm-Message-State: AOJu0Ywx1SNk/qQ0i2HcWXLfucatG7IhpZqzE7dBvt1ponwWLmDv9ti4
	6/+WCk050/CqdhQSUSc0GYNw5E+YQmbfOOkKLGp7gie/J+efRTZbSNvV626VAw0=
X-Google-Smtp-Source: AGHT+IEhuh5q9vJDI4wmQN4sL6Kdwpzy4OW6yzApAmCgnTKxWNTHJ9KYuBApjS9BM0q9/mvpbNZquw==
X-Received: by 2002:a17:906:bcd4:b0:a68:c2dd:8cdf with SMTP id a640c23a62f3a-a6cd560fa33mr191667266b.4.1717769338515;
        Fri, 07 Jun 2024 07:08:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:08:58 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 00/17] Add suspend to RAM support for pin and IA55 IRQ controllers
Date: Fri,  7 Jun 2024 17:08:39 +0300
Message-Id: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16161

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds suspend to RAM support for pin and IA55 IRQ controller.
Support is needed for RZ/G3S SoC.

Along with it pin controller and IA55 interrupt controller drivers
were updated with enhancements.

Series is split as follows:
- patch 01:      add clock and reset support for IA55 IRQ controller on
                 RZ/G3S
- patches 02-08: update the pin controller driver with fixes for spurious
                 interrupts when pin controller interrupt lines are routed
                 to IA55 IRQ controller
- patch 09:      add suspend to RAM support for pinctrl driver
- patch 10:      select proper flags for pinctrl driver
- patch 11:      add suspend to RAM support for IA55 IRQ controler
- patches 12-13: documentation patches
- patches 14-17: update the device tree with IA55, gpio keys, PSCI
                 support

Thank you,
Claudiu Beznea

Biju Das (3):
  pinctrl: renesas: rzg2l: Configure interrupt input mode
  pinctrl: renesas: rzg2l: Simplify rzg2l_gpio_irq_{en,dis}able()
  pinctrl: renesas: rzg2l: Avoid configuring ISEL in
    gpio_irq_{en,dis}able*(

Claudiu Beznea (8):
  clk: renesas: r9a08g045: Add IA55 pclk and its reset
  pinctrl: renesas: rzg2l: Add suspend/resume support
  pinctrl: renesas: rzg2l: Select GPIOLIB_IRQCHIP and
    IRQ_DOMAIN_HIERARCHY
  irqchip/renesas-rzg2l: Add support for suspend to RAM
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S
  arm64: dts: renesas: r9a08g045: Add IA55 interrupt controller node
  arm64: dts: renesas: r9a08g045: Add PSCI support
  arm64: dts: renesas: rzg3s-smarc: Add gpio keys

Johannes Berg (1):
  bitfield: add FIELD_PREP_CONST()

Lad Prabhakar (5):
  pinctrl: renesas: rzg2l: Improve code for readability
  pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK()
    macro
  pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
    RZ/G2UL SoC
  arm64: dts: renesas: r9a08g045: Add missing interrupts to IRQC node

 .../renesas,rzg2l-irqc.yaml                   | 228 ++++--
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  77 ++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  53 ++
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   4 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   3 +
 drivers/irqchip/irq-renesas-rzg2l.c           |  68 +-
 drivers/pinctrl/renesas/Kconfig               |   2 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 770 ++++++++++++++++--
 include/linux/bitfield.h                      |  26 +
 9 files changed, 1093 insertions(+), 138 deletions(-)

-- 
2.39.2


