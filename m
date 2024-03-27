Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D3FCD11DF
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.32279.1711527480485030108
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bXoO9gTu;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so3119485e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527479; x=1712132279; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MDYaCY/ir5OkpguFEMYODaauAdyaIajQYhpKqN4t6CQ=;
        b=bXoO9gTuF/eS1fGeYAaooCwzaFNTAIScwLRsWLQbdMKclA4IHPUX1WkcDG8i/Aoq85
         ItNH4+hsRsqpaiQrqqLhPcIWYgyyALo0mACcS38Z7a5OVsbrXjL9SV2gmeMKy4VS9uQW
         9OkhUQZurrAoyWVZtgK8Uxb92tsoOxrfRB2mtptP7i7l6GcnK0mSfCSutXLOWfpArSlP
         t9mWPSe7vpPBjRFOLkGJyy+3oTI7SJzuQdfFbz8petrbN1AFmFBFhHgFF/bxA0XDQ6/n
         U+YiUzjVG419sNLDdX/lpl9RdjLvLgkO1ngPLq/a9B+lWtAQtEep/j7Err764aSKs3KY
         nNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527479; x=1712132279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDYaCY/ir5OkpguFEMYODaauAdyaIajQYhpKqN4t6CQ=;
        b=cphbP/Y67RuT1GODsoO5ADfmTx89bhDgaTlRZMer9BU27QoS4ndyhgIQ49zuZXdzgd
         1nMYWcvn3iyvX8PM35MpOcEVBOkGOg0bFAvkLWV81BbvZJ+cXHsi48BG6EHs/p76eraX
         TmL4ITIxZDm5wQ0N7o8E33fHgaOaew5B3bfiUk8FJCN7N6RCyKdoGPk4jBpnjTeoIeM+
         dQQdDonjw4DiIFVxYTuPK5dD11NMKDrVhk8azow7F7WYgwytnkpic0cobDZi7SYSOuLU
         qjwG6NRYnhuZP8LaC1PbSWWtcDLX0eZJjtmvp5b0o+qmzNCrYnc7SwR8FePhXJTLw8e9
         zysA==
X-Gm-Message-State: AOJu0Yw4hpmlHa8KXHjdvtZ49E0+f6RjN6QGxLJ4biVZPy9VQbVkYJKM
	UXVc28IhYG9QZTv7AQ2PjngvlnibXe+N1kjo3BtUIrNRONc+zYMVbbMMjm9B3/g=
X-Google-Smtp-Source: AGHT+IH4fDHD6u8xJGuKeVNnFBUC5sq4WoFyXFfVEUmTtDJilcBMFYV4vlivcBqdSLGPUym2eenTnA==
X-Received: by 2002:a05:600c:3d90:b0:414:90ea:34ad with SMTP id bi16-20020a05600c3d9000b0041490ea34admr2416998wmb.6.1711527478725;
        Wed, 27 Mar 2024 01:17:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:17:58 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 00/36] Add IA55 interrupt controller support
Date: Wed, 27 Mar 2024 10:17:20 +0200
Message-Id: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15417

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds support for Renesas IA55 interrupt controller. The
controller is available on RZ/{G2L,GLC,V2L} SoCs.

All patches are cherry-picked from mainline, except 10/36 "of: platform:
Skip populating IRQ to device resource table". Patch 10/36 has been
created as a result of discussion at [1].

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/cip-dev/TYCPR01MB64784B67B1AD38E99F08C2ED9F282@TYCPR01MB6478.jpnprd01.prod.outlook.com/

Biju Das (7):
  irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source
  irqchip/renesas-rzg2l: Flush posted write in irq_eoi()
  irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()
  irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()
  irqchip/renesas-rzg2l: Prevent spurious interrupts when setting
    trigger type
  irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same
    time
  arm64: dts: renesas: rzg2lc-smarc-som: Add PHY interrupt support for
    ETH0

Christophe JAILLET (1):
  pinctrl: renesas: rzg2l: Use devm_clk_get_enabled() helper

Claudiu Beznea (7):
  pinctrl: renesas: rzg2l: Select GPIOLIB_IRQCHIP and
    IRQ_DOMAIN_HIERARCHY
  of: platform: Skip populating IRQ to device resource table
  irqchip/renesas-rzg2l: Use tabs instead of spaces
  irqchip/renesas-rzg2l: Align struct member names to tabs
  irqchip/renesas-rzg2l: Document structure members
  irqchip/renesas-rzg2l: Implement restriction when writing ISCR
    register
  irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset
    based on register's index

Geert Uytterhoeven (1):
  irqchip/renesas-rzg2l: Convert to irq_data_get_irq_chip_data()

Lad Prabhakar (18):
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document the properties
    to handle GPIO IRQ
  pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO
    interrupt
  pinctrl: renesas: rzg2l: Fix configuring the GPIO pins as interrupts
  pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks
  pinctrl: renesas: rzg2l: Enhance driver to support interrupt affinity
    setting
  dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt
    Controller
  irqchip: Add RZ/G2L IA55 Interrupt Controller driver
  irqchip/renesas-rzg2l: Enhance driver to support interrupt affinity
    setting
  soc: renesas: Kconfig: Enable IRQC driver for RZ/G2L SoC
  arm64: dts: renesas: r9a07g043u: Add IRQC node
  arm64: dts: renesas: r9a07g044: Add IRQC node
  arm64: dts: renesas: r9a07g054: Add IRQC node
  arm64: dts: renesas: r9a07g043u: Update pinctrl node to handle GPIO
    interrupts
  arm64: dts: renesas: r9a07g044: Update pinctrl node to handle GPIO
    interrupts
  arm64: dts: renesas: r9a07g054: Update pinctrl node to handle GPIO
    interrupts
  dt-bindings: interrupt-controller: Add macros for NMI and IRQ0-7
    interrupts present on RZ/G2L SoC
  arm64: dts: renesas: rzg2l-smarc-som: Add PHY interrupt support for
    ETH{0/1}
  arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for
    ETH{0/1}

Marc Zyngier (1):
  irqdomain: Make of_phandle_args_to_fwspec() generally available

Nick Alcock (1):
  irqchip: remove MODULE_LICENSE in non-modules

 .../renesas,rzg2l-irqc.yaml                   | 133 ++++++
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  15 +
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   2 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  72 +++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  59 +++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  59 +++
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  11 +-
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    |   6 +-
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    |  11 +-
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-renesas-rzg2l.c           | 440 ++++++++++++++++++
 drivers/of/platform.c                         |   5 +-
 drivers/pinctrl/renesas/Kconfig               |   2 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 278 +++++++++--
 drivers/soc/renesas/Kconfig                   |   1 +
 .../interrupt-controller/irqc-rzg2l.h         |  25 +
 include/linux/irqdomain.h                     |   4 +
 kernel/irq/irqdomain.c                        |   6 +-
 19 files changed, 1101 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
 create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c
 create mode 100644 include/dt-bindings/interrupt-controller/irqc-rzg2l.h

-- 
2.39.2


