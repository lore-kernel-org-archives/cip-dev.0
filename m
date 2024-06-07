Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D853C27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:20 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.42679.1717769234884258145
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bE6ZGhjA;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.169, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so24701191fa.1
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769233; x=1718374033; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbET8Sfnv0EkhVIUU/29q/aOILvTnRjDFcGGjWkaLUw=;
        b=bE6ZGhjA+/YoUHnIg9b8SkXo487RkZyozDbBg/jIPeX+pcx75EOtlywV6ocLI+6s9+
         AtNDmARTpO0wWSIq5YqSpdBwhZFfQVNGvDBMpG5ZTCg42l1GlthoNwweCYjJOn8BID8k
         MmFK5/8nvPweyJjGLYI3t5eO+8wQI7Pgq0/gyzKPJ+DfqXf66exYtb/8zzqZLpli0RlC
         YkTRBMUpXgZjeD29eOHnem+fLMh4jVQqxGeYAMEBRISWuOSJ4yvLW1VO/GDGtW63CMD0
         jc7PW3AOPNn/KJ4lIkEiALiBo1fRlRBLnIKm0zgDuMuhpFzsUFtqrGSwQZ9i8Mb5vbl0
         ydAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769233; x=1718374033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbET8Sfnv0EkhVIUU/29q/aOILvTnRjDFcGGjWkaLUw=;
        b=Gn7vLMxN0wMPDpoP+NPdOzsEBQWigmKUX7bmoxO3r+DMj8QsZiNsbokqnB7tWQdGbv
         j21cRRR4EOwb+n4lOgQBIgExPOQR/Vd6nMXjeXkxEmqjWeOTmIfdc4ePNVnbg/HzWR+J
         Fgr/zoiB6BLSh4hmlfGU0z5TzRY1MoYpTCJ+A9Fsfr4vIuvJkpv9dBQGmJUteqKLzjyI
         lpop5Tb+DFdi0YzXbBB5y99J5t6cG2q3Lp8h7GamERHPHKMaMZj0nJc59qPOCqtUMi+M
         P32lSpZtaGeLMrI3IInHqc/kjXUnv2G1qWsoC9NoKsfZ9fqtF06H98wPQCJRzmQ9++7Z
         x3GA==
X-Gm-Message-State: AOJu0YwQo43MRJ+1ZGLLmq5D6CvjFpiN9YQZfzD8SLsU6Hp/rH6js9Pq
	Hcp2lIxBNbcuwP7intZXQxkfcdVrv02Qi2uPrLoZ5OfpgBcQJ2JHjQDlVvi6s7Y=
X-Google-Smtp-Source: AGHT+IFUR6tt9AYN8+6kFjilWkZdEz/3zqtxv51aDCA5rWjRWJn8FNql7sFsBGyhA0dAIz4zM3gqgw==
X-Received: by 2002:a2e:b0d6:0:b0:2ea:e204:afc2 with SMTP id 38308e7fff4ca-2eae204b720mr9396091fa.12.1717769232867;
        Fri, 07 Jun 2024 07:07:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:12 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 00/19] Add suspend to RAM support for pin and IA55 IRQ controllers
Date: Fri,  7 Jun 2024 17:06:52 +0300
Message-Id: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16141

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds suspend to RAM support for PIN and IA55 IRQ controller.
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
- patch 10:      add suspend to RAM support for IA55 IRQ controler
- patches 11-14: documentation patches
- patches 15-19: update the device tree with IA55, gpio keys, PSCI
                 support

Thank you,
Claudiu Beznea

Biju Das (3):
  pinctrl: renesas: rzg2l: Configure interrupt input mode
  pinctrl: renesas: rzg2l: Simplify rzg2l_gpio_irq_{en,dis}able()
  pinctrl: renesas: rzg2l: Avoid configuring ISEL in
    gpio_irq_{en,dis}able*(

Claudiu Beznea (7):
  clk: renesas: r9a08g045: Add IA55 pclk and its reset
  pinctrl: renesas: rzg2l: Add suspend/resume support
  irqchip/renesas-rzg2l: Add support for suspend to RAM
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S
  arm64: dts: renesas: r9a08g045: Add IA55 interrupt controller node
  arm64: dts: renesas: rzg3s-smarc: Add gpio keys
  arm64: dts: renesas: r9a08g045: Add PSCI support

Johannes Berg (1):
  bitfield: add FIELD_PREP_CONST()

Lad Prabhakar (8):
  pinctrl: renesas: rzg2l: Improve code for readability
  pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK()
    macro
  pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/V2L
    SoC
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update
    description for '#interrupt-cells' property
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
    RZ/G2UL SoC
  arm64: dts: renesas: r9a08g045: Add missing interrupts to IRQC node
  arm64: dts: renesas: rzg2l: Add missing interrupts to IRQC nodes

 .../renesas,rzg2l-irqc.yaml                   | 236 ++++--
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  12 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  22 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  22 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  77 ++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  53 ++
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   4 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   3 +
 drivers/irqchip/irq-renesas-rzg2l.c           |  70 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 777 ++++++++++++++++--
 include/linux/bitfield.h                      |  26 +
 11 files changed, 1157 insertions(+), 145 deletions(-)

-- 
2.39.2


