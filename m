Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CA6C43458
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:26 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19063.1782820103198742276
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DahipruK;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so3377965e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820101; x=1783424901; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUDyGouHXJXuWJOnv2P9zFkBMEp8dyO46vBE06sCgEY=;
        b=DahipruKvVkJHHENpySQBY1H5lGrh0eM2Yc83YRj35QXekcR4QZVdV3oXMRkmmDDn/
         pN/c2ZhREPwTwynpIOk+ioYetwjwNMroxNZq5T9HbPwwPtLhi6Y6vthKTPAiGqj1aaA5
         Y3p3x69yF7kkAEFJb8Fc93RIQE/JlMTd1KHDmTVHikdpamaSPIJ8I+LFf8vUXPOXJEzT
         J2SS1zWhpLvnT4io4hhLCa1HLZFzoJE2XRsTVsfYeLw/S0aH0SyqbQO+K7nCsdjr4Q5T
         +dLALXTjOI7is62nCJFWs547erAqZ1oZm2GjhtZiiUFvydcxlo4StSMjBPgLOdGMRkhl
         czSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820101; x=1783424901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUDyGouHXJXuWJOnv2P9zFkBMEp8dyO46vBE06sCgEY=;
        b=coOLn0qmNDcsXnlLUtO8hT4qe7NVYXFL/S7+aTdCziHU1yU5RFL/lmWdJi4tDieclK
         yeMCKzxRf712JlTFnencPf9lK36blqeKRHDDsDKHxV25pffCzNZ7DRg+viCW3Il2k/cB
         QTMoAP7Wq67eOrcI+N8eQcgeGCIBHL0nmWvAkyyHcfR17FK7MfJlUyuwXRANq9kwnPy7
         8JWti1IeAfWNLA8ZYUYLdbmcotJPOqvsiLH3nJ2e+WqyTzgJx+XOCSNKLnZ938BzwGdw
         I3VEy1mGmaGgZpubPfaVBpMqUNwDI1tHXmCPC34JqzezBUtuXbXoT96TL4TsQ6cfL3kd
         4Scg==
X-Gm-Message-State: AOJu0YyNz1CNEQkfhbk4zhRzVHsGAPdr9NoYAtCH7gyENRyI1js4iYVH
	9itrnrfTq/3hTZpYDUPSQZgMndOyPh6K2vm1V+ncTqeyHEVGB4uai0Btctk7txHa
X-Gm-Gg: AfdE7cka4TjOwep7RgEWVFc0jHrW5VGkybokVnNGfBO/d4v3LLquv3lTijFQn8bcTsc
	b6ZK5VqxlkZE9+4VkGZL7QYkdobaDAv51oamPejR7Z6uPT1gNJKcVnrvqeH383x+96vTQSInIXp
	j5eKPplzqAjmENK3YL1MlYS6YmBFqHpvuT2bDeh927slVkdtvWTcTXklJgG1/A97MS3GxfK/+Jy
	c/iIm8+cvmfic99d6F5FGEcdgcfg2sTz2N19JkCpGoe5hgjfLlpf138eEi2gpjH7gefyWek50VP
	y6+0ULmzoOFu9d0GNxgA4l9vNgOpn+gdoVB6Ej3GoiGk+pdxvataot9f/lNRp7Hiq/TkyLbF41r
	YuSgkqRgeRy5DSkJ6Se/HAsHBRwNuOyPk9f9G3iD3IQMk0+bB/rpRR3I3xLOhv2oa5DTggDrNXb
	TDPfa/j9X/6jaMcr5q5Ruyt4fxd3wTuvZfVLm/nw==
X-Received: by 2002:a05:600c:a216:b0:492:582b:f21a with SMTP id 5b1f17b1804b1-493bc209353mr15347935e9.4.1782820101038;
        Tue, 30 Jun 2026 04:48:21 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:17 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/39] Add RZ/G3L SMARC EVK support 
Date: Tue, 30 Jun 2026 12:47:19 +0100
Message-ID: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23324

From: Biju Das <biju.das.jz@bp.renesas.com>

This patch series add minimal boot support for RZ/G3L SMARC EVK. All patches
in this series are cherry-picked from mainline.

Biju Das (31):
  dt-bindings: serial: renesas,scif: Document RZ/G3L SoC
  dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC
  dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L
    RMII{tx,rx} clocks
  net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC
  dt-bindings: soc: renesas: Document RZ/G3L SoC variants, SMARC SoM and
    Carrier-II EVK
  dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3L SoC
  soc: renesas: rz-sysc: Add SoC identification for RZ/G3L SoC
  clk: renesas: rzg2l: Deassert reset on assert timeout
  clk: renesas: rzg2l: Add support for critical resets
  clk: renesas: rzg2l: Add helper for mod clock enable/disable
  clk: renesas: rzg2l: Add rzg2l_mod_clock_init_mstop_helper()
  clk: renesas: rzg2l: Re-enable critical module clocks during resume
  dt-bindings: clock: renesas,rzg2l-cpg: Document RZ/G3L SoC
  clk: renesas: Add support for RZ/G3L SoC
  clk: renesas: rzg2l: Drop always-false check in
    rzg3s_cpg_pll_clk_recalc_rate()
  clk: renesas: rzg2l: Add support for enabling PLLs
  clk: renesas: r8a08g046: Add support for PLL6
  clk: renesas: r9a08g046: Add GBETH clocks and resets
  clk: renesas: r9a08g046: Add GPIO clocks/resets
  clk: renesas: r9a08g046: Add CA55 core clocks
  clk: renesas: r9a08g046: Add WDT clocks and reset
  clk: renesas: r9a08g046: Add SCIF{1..5} clocks and resets
  clk: renesas: r9a08g046: Add I2C clocks and resets
  clk: renesas: r9a08g046: Add IA55_PCLK to critical module clocks
  arm64: dts: renesas: Add initial DTSI for RZ/G3L SoC
  arm64: dts: renesas: Add initial support for RZ/G3L SMARC SoM
  arm64: dts: renesas: renesas-smarc2: Move usb3 nodes to board DTS
  arm64: dts: renesas: Add initial device tree for RZ/G3L SMARC EVK
    board
  arm64: dts: renesas: r9a08g046: Add GBETH nodes
  arm64: dts: renesas: rzg3l-smarc-som: Enable eth0 (GBETH0) interface
  arm64: dts: renesas: r9a08g046: Add OPP table

Geert Uytterhoeven (4):
  clk: renesas: rzg2l: Remove unneeded nullify checks
  clk: renesas: rzg2l: Rename mstp_clock to mod_clock
  clk: renesas: rzg2l: Consolidate DEF_MUX() and DEF_MUX_FLAGS()
  clk: renesas: rzg2l: Refactor rzg3l_cpg_pll_clk_endisable()

Inochi Amaoto (2):
  net: stmmac: platform: Group GMAC4 compatible check
  net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string

Tommaso Merciai (2):
  clk: renesas: rzg2l: Simplify rzg2l_cpg_assert() and
    rzg2l_cpg_deassert()
  clk: renesas: rzg2l: Re-assert reset on deassert timeout

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |  40 +-
 .../bindings/net/renesas,rzv2h-gbeth.yaml     |  81 ++-
 .../devicetree/bindings/net/snps,dwmac.yaml   |   6 +
 .../bindings/serial/renesas,scif.yaml         |   1 +
 .../soc/renesas/renesas,rzg2l-sysc.yaml       |   1 +
 .../bindings/soc/renesas/renesas.yaml         |  13 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 497 ++++++++++++++++++
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   |  37 ++
 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi |  13 +
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |   6 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   8 -
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     |  54 ++
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a08g046-cpg.c           | 371 +++++++++++++
 drivers/clk/renesas/rzg2l-cpg.c               | 258 ++++++---
 drivers/clk/renesas/rzg2l-cpg.h               |  19 +-
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      |   1 +
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  17 +-
 drivers/soc/renesas/Kconfig                   |  12 +
 drivers/soc/renesas/Makefile                  |   1 +
 drivers/soc/renesas/r9a08g046-sysc.c          |  91 ++++
 drivers/soc/renesas/rz-sysc.c                 |   3 +
 drivers/soc/renesas/rz-sysc.h                 |   1 +
 .../dt-bindings/clock/renesas,r9a08g046-cpg.h | 342 ++++++++++++
 26 files changed, 1777 insertions(+), 106 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
 create mode 100644 drivers/clk/renesas/r9a08g046-cpg.c
 create mode 100644 drivers/soc/renesas/r9a08g046-sysc.c
 create mode 100644 include/dt-bindings/clock/renesas,r9a08g046-cpg.h

-- 
2.43.0


