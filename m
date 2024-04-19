Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E21C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:38:50 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.18427.1713526727467498011
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:38:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fAMLAlLM;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.170, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d8b4778f5fso18412971fa.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526725; x=1714131525; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKq5jYxMghkZhHACOzff7PDcrJIZiZpYbDubj2zEYwE=;
        b=fAMLAlLMmGwSC2D3hOW6J3vz7WftjwbcK8AyfOpxzyp8d/HAxuIP0E6OBVK4GZbdEx
         ypHU8YtWKCBUr7EWnrYTUB8VklK3BqkkReq3Yq1LgSujbUKhrjC3hnff+aRUfzxW2cxi
         ewkPEETdOU7StDfvympfak6hmEKO+z3ragPxUfCtrIRUUVMxTUywolIaVwaDFU7Q0Pcz
         dkz3BbmScBX/VHdtoKCrBGI33RMTLl3WGF0isAo2PJP4Wa8LhIZkplKnJ5Xz6jGnJLXF
         5lAzTww+MkdvRNUwzgg9+RB9MrRqbBXo39EcZgHwHqhnwds6oIDSeiYlKrg0OXVpDoeE
         Lt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526725; x=1714131525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKq5jYxMghkZhHACOzff7PDcrJIZiZpYbDubj2zEYwE=;
        b=SRR1WI7wK68hGYMJzwI5llba9MeXhgIalGSkLUdP32kbC9D6cmt+UxUuUJnmkFNgkF
         Ox3HKxfjBwjFCk0hrL9bHU54Sy9mXyPyyvrrMh1EnHC5twUdhW2cwhiyrVcD2kz3wgdH
         gJBXfwuGANeSOabROTj+8Q9Xh+QMTRhTq9l4e7tx/COOcV2lKSpYKSQVt6xOplKHMfDX
         WAt7B+ws37i6gE/VfPF6B97Ci2BXK17IZmopm0rZcaCb4fBwRgWX4nIx1z/8JkR1FErB
         kac5TF45O9nhB3rD1CXwJVgM6zW50q1zhl1oz3rI+vhVGFE+vVBUbxjXfzlFOckB7PbV
         I4bQ==
X-Gm-Message-State: AOJu0YxicjSxKSybcs85dVBb1Tyki5kYWlRZbwg0LxSMRbUVVxnB08tM
	4yfW988arlOQH6LqWa0zXZ+4S/3aek6g1OGAd9Emn7bTra1IYHdXstVFW3ZqVmY=
X-Google-Smtp-Source: AGHT+IGq4KuABaUfKEUgioFiqXnr/eADvnK4LMcsSILbT+7xyT9P6Npin5JF5WQ4BoS5qqir9qC2WA==
X-Received: by 2002:a2e:a554:0:b0:2d7:1805:1079 with SMTP id e20-20020a2ea554000000b002d718051079mr1376621ljn.7.1713526725129;
        Fri, 19 Apr 2024 04:38:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 00/44] Add initial support for the Renesas RZ/G3S SoC
Date: Fri, 19 Apr 2024 14:37:58 +0300
Message-Id: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:38:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15651

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

Christophe JAILLET (1):
  clk: renesas: rzg2l: Simplify .determine_rate()

Claudiu Beznea (38):
  dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3S SoC
  dt-bindings: soc: renesas: Document Renesas RZ/G3S SoC variants
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
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a07g043-cpg.c           |  19 +-
 drivers/clk/renesas/r9a07g044-cpg.c           |  19 +-
 drivers/clk/renesas/r9a08g045-cpg.c           | 248 ++++++
 drivers/clk/renesas/rzg2l-cpg.c               | 498 +++++++++---
 drivers/clk/renesas/rzg2l-cpg.h               |  43 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 714 ++++++++++++++----
 drivers/soc/renesas/Kconfig                   |   6 +
 drivers/soc/renesas/renesas-soc.c             |  21 +-
 include/dt-bindings/clock/r9a08g045-cpg.h     | 242 ++++++
 24 files changed, 2082 insertions(+), 269 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
 create mode 100644 drivers/clk/renesas/r9a08g045-cpg.c
 create mode 100644 include/dt-bindings/clock/r9a08g045-cpg.h

-- 
2.39.2


