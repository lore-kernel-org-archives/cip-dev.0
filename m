Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FB1C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:17:47 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.15279.1713514665944757366
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:17:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=M0+6UiDS;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a55323f2ef9so207378266b.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514664; x=1714119464; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NtFdkqfuYH6ujim9NggAzCjTjpanPmcP2Th9qU6MoA=;
        b=M0+6UiDSSPuVd/W2GlSj8AxXcv1sXQ4wcS/VrJNJKlDrpIITdzvTEiD5Lh7BAaJ4bP
         xNuYSr8q7DDTrPAd2/L0PpzTeZN5yVAFMT+dsVSUyahGMxDwD5tSHeWm7CNK5Jqo+vvD
         2qOlNp5oZhkTdIiKvZ9PNllSRDQw7v3w3OOqJ8/GNYOZrIYz5gWYk8sw3Jcq1NiOuHrh
         nfR4s3QWJNCsXAx8rFttG/Gd9SSvXc/0tzeVzO4WJrhVLhXMlw3HkbeOssx3m/J5LIPp
         jVIg021E0SwpP7eoaqUdolZzKa0MQz4Or6/qQRfOqm3kcADN15bLyW2RvJPGfnz342y8
         KHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514664; x=1714119464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NtFdkqfuYH6ujim9NggAzCjTjpanPmcP2Th9qU6MoA=;
        b=cprI4DrVz2BVKMKNVVwJ7u9dwceqIfagnFANEi/GJyZBNhbgEKOuibQ7I527+5G9AQ
         c5mNlG6DkrqSlNst+ygeYydrYiDADCdrfCf7LAEYxUE8vhjgazb0Gip+XFCNdmwHZ/f2
         Itkspmt3iX1eBIty19bBejDeI0xmZv+ZcLwy3VKBMZ3zeRgxNWG9UrxIhGe3adiGzAtz
         mNfiUjGvuei018rB/PJy8Irjm/ammklidcVW2Dbdwl4OaSPaNi3hLwu6/jcrgMSLAOxh
         4Ur7DS/nDPXQqluHvrVhDCfwX7yR7pQ1a8WN95JSinZWsaCCWdUgtDhsMvQ2+kqb5kN2
         nuwg==
X-Gm-Message-State: AOJu0Yw5aQ2WodMH1QRp3S25nG+T9iEie10WTLskn33SqCA9ER3yQovN
	ncVNY03o6HWOu1fwTp0TregQKxmKb77spLdM9Ht9tml5TVzB9un1C0uAW/xhz8M=
X-Google-Smtp-Source: AGHT+IHHJtuZYnylaykQB7ypNEw76TJ+A+pF/GdzT5qB9GyIDIrJtebDS7XODtwONLG+i7684L1VMQ==
X-Received: by 2002:a17:906:8c1:b0:a52:6941:e32c with SMTP id o1-20020a17090608c100b00a526941e32cmr784181eje.57.1713514664052;
        Fri, 19 Apr 2024 01:17:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:17:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 00/53] Add initial support for the Renesas RZ/G3S SoC
Date: Fri, 19 Apr 2024 11:16:49 +0300
Message-Id: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:17:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15587

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This patch series adds initial support for The Renesas RZ/G3S (R9A08G045{S33})
SoC. The RZ/G3S device is a general-purpose microprocessor with a
single-core Arm® Cortex®-A55 (1.1GHz) and a dual-core Arm® Cortex®-M33 (250MHz),
perfect for an IOT gateway controller.

This patch series includes:
- SoC identification;
- clocks (core clocks, pin controller clock, serial interface, SDHI
  clocks) and corresponding resets;
- pinctrl support necessary for SDHIs and serial console
- minimal device tree for SoM and carrier boards.

With this series Linux can boot from eMMC or SD card. The eMMC and uSD
interface are multiplexed on the SoM; selection is made using a hardware
switch.

Thank you,
Claudiu Beznea

Biju Das (1):
  pinctrl: renesas: rzg2l: Make reverse order of enable() for disable()

Christophe JAILLET (1):
  clk: renesas: rzg2l: Simplify .determine_rate()

Claudiu Beznea (45):
  clk: renesas: rzg2l: Wait for status bit of SD mux before continuing
  clk: renesas: rzg2l: Lock around writes to mux register
  clk: renesas: rzg2l: Trust value returned by hardware
  clk: renesas: rzg2l: Use FIELD_GET() for PLL register fields
  clk: renesas: rzg2l: Fix computation formula
  clk: renesas: rzg2l-cpg: Reuse code in rzg2l_cpg_reset()
  clk: renesas: rzg2l: Check reset monitor registers
  dt-bindings: soc: renesas: Document Renesas RZ/G3S SoC variants
  dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3S SoC
  clk: renesas: rzg2l: Use u32 for flag and mux_flags
  clk: renesas: rzg2l: Use core->name for clock name
  clk: renesas: rzg2l: Simplify the logic in rzg2l_mod_clock_endisable()
  clk: renesas: rzg2l: Remove critical area
  clk: renesas: rzg2l: Add support for RZ/G3S PLL
  clk: renesas: rzg2l: Add struct clk_hw_data
  clk: renesas: rzg2l: Remove CPG_SDHI_DSEL from generic header
  clk: renesas: rzg2l: Refactor SD mux driver
  clk: renesas: rzg2l: Add divider clock for RZ/G3S
  dt-bindings: clock: renesas,rzg2l-cpg: Document RZ/G3S SoC
  clk: renesas: Add minimal boot support for RZ/G3S SoC
  clk: renesas: r9a08g045: Add clock and reset support for SDHI1 and
    SDHI2
  clk: renesas: r9a07g04[34]: Use SEL_SDHI1_STS status configuration for
    SD1 mux
  soc: renesas: Identify RZ/G3S SoC
  pinctrl: renesas: rzg2l: Make struct
    rzg2l_pinctrl_data::dedicated_pins constant
  pinctrl: renesas: rzg2l: Index all registers based on port offset
  pinctrl: renesas: rzg2l: Adapt for different SD/PWPR register offsets
  pinctrl: renesas: rzg2l: Adapt function number for RZ/G3S
  pinctrl: renesas: rzg2l: Move DS and OI to SoC-specific configuration
  pinctrl: renesas: rzg2l: Add support for different DS values on
    different groups
  dt-bindings: pinctrl: renesas: Document RZ/G3S SoC
  pinctrl: renesas: rzg2l: Add RZ/G3S support
  dt-bindings: mmc: renesas,sdhi: Document RZ/G3S support
  dt-bindings: serial: renesas,scif: document r9a08g045 support
  dt-bindings: soc: renesas: Document RZ/G3S SMARC SoM
  dt-bindings: soc: renesas: Document SMARC Carrier-II EVK
  arm64: dts: renesas: Add initial DTSI for RZ/G3S SoC
  arm64: dts: renesas: Add initial support for RZ/G3S SMARC SoM
  arm64: dts: renesas: Add initial device tree for RZ SMARC Carrier-II
    Board
  arm64: dts: renesas: Add initial device tree for RZ/G3S SMARC EVK
    board
  arm64: dts: renesas: r9a08g045: Add nodes for SDHI1 and SDHI2
  arm64: dts: renesas: r9a08g045: Add missing cache-level for L3 cache
  arm64: dts: renesas: rzg3s-smarc-som: Spelling
    s/device-type/device_type/
  arm64: dts: renesas: rzg3s-smarc-som: Enable SDHI2
  arm64: dts: renesas: rzg3s-smarc: Enable SDHI1
  arm64: defconfig: Enable RZ/G3S (R9A08G045) SoC

Geert Uytterhoeven (3):
  clk: renesas: rzg2l: Convert to readl_poll_timeout_atomic()
  soc: renesas: Use "#ifdef" for single-symbol definition checks
  pinctrl: renesas: rzg2l: Rename rzg2l_gpio_configs[]

Lad Prabhakar (2):
  clk: renesas: rzg2l: Don't assume all CPG_MOD clocks support PM
  pinctrl: renesas: rzg2l: Add validation of GPIO pin in
    rzg2l_gpio_request()

Martin Blumenstingl (1):
  clk: divider: Add re-usable determine_rate implementations

 .../devicetree/bindings/arm/renesas.yaml      |  19 +
 .../bindings/clock/renesas,rzg2l-cpg.yaml     |   1 +
 .../devicetree/bindings/mmc/renesas,sdhi.yaml |   2 +
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  20 +
 .../bindings/serial/renesas,scif.yaml         |   1 +
 .../soc/renesas/renesas,rzg2l-sysc.yaml       |   1 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 170 +++++
 .../boot/dts/renesas/r9a08g045s33-smarc.dts   |  18 +
 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi |  14 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 191 +++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  93 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/clk-divider.c                     |  38 +
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a07g043-cpg.c           |  19 +-
 drivers/clk/renesas/r9a07g044-cpg.c           |  19 +-
 drivers/clk/renesas/r9a08g045-cpg.c           | 248 ++++++
 drivers/clk/renesas/rzg2l-cpg.c               | 619 +++++++++++----
 drivers/clk/renesas/rzg2l-cpg.h               |  43 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 715 ++++++++++++++----
 drivers/soc/renesas/Kconfig                   |   6 +
 drivers/soc/renesas/renesas-soc.c             |  21 +-
 include/dt-bindings/clock/r9a08g045-cpg.h     | 242 ++++++
 include/linux/clk-provider.h                  |   6 +
 26 files changed, 2198 insertions(+), 319 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
 create mode 100644 drivers/clk/renesas/r9a08g045-cpg.c
 create mode 100644 include/dt-bindings/clock/r9a08g045-cpg.h

-- 
2.39.2


