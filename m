Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE9C105D285
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:08 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18255.1773227041913820840
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=COaKWdTS;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso25306745e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227040; x=1773831840; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OaeA09fH2q1EVghjlGaXv6GmG0EYrdD4F1d9Up1rRU=;
        b=COaKWdTS1fOTjDItqTqYshUmDPG82UqRC+J5szt/6/UcXLVZmibk3Xdso9H/N9wE42
         bckiRBYpug5cm0U4+HcRoga7CTIQHicT16Hl+mpdw0ND+79jx/3TlUMYwTB2TopJ6n5f
         31vXAECYMGxmB1WWI3BXZyX1SuAf7XRIosGa9m0hXEKQk1lOkw+Y/DnrEZidL6shPCEu
         er22kuaAKxTMcjLZmxCRH4juSP4XV73QHhmq/PVdx9qbemeH4fqdRh208Kkv6jAKNexH
         wya4qLRHXU9Os9sn0QuHXWG0C7yFqB4dGacTSVJU/FQWbztCiRoFfKCaquv7o8UyL40S
         1G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227040; x=1773831840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OaeA09fH2q1EVghjlGaXv6GmG0EYrdD4F1d9Up1rRU=;
        b=b/JerLuYm19o1jSLvm/LwXsyRnGWonqAvgvMy4v6kVzRfsEEISKg0opZWZwkXSeMlh
         bgyH+QSPvT3YWoTWFdJkjprVmhYtN5bcAv+/q7OrfCAr+Gzv3OwdSudGvOBqUG6drlR4
         UeJBb/sLXCHJoBih3mnpc3YVARNwbM2qnPBCZbM8sd1hBJYHcHcN77Sz5KNQBK9TJtED
         lmx1Tl19AjhhbZsoQlaly/1bXW9YdmOcEra/V02zB266mqeW2hj8M1wMvDGuj4OeBxu+
         LpNQqz2CzZkyyw5AqgahpnHHPBPax8tx01O31snySw45l/6iigPe1hDptzyQevUjl6cr
         /fSA==
X-Gm-Message-State: AOJu0YxBhCPhroBES9KJ31T8ePqJtnDnEimvcr6gUC/490DnsV9g3psi
	nuosMvGUd8Hg1FcGBNhyFYg2upLbMBndwimDYiqggb5k2GPjC453x6m2FEvgzh86K6Y=
X-Gm-Gg: ATEYQzz1vyXIHJM4koqxSAo8ZmuaXIodTkwFv+QFQAMXH1pKdhNtKN8VlknuNfH9q4V
	70b369IeHp8hcVXQTguSUE9/3VF64B7UBUaCX9hyUGXIkPmZ01zxYYK9ER2k/3NJ08n7SqPdz/8
	n8AORadHTzx9SlApKZyNe5fYmH7guVyULQ4NGIWWoF2Aqd+K926NePf20VCd57AJl4DTaOJn0Om
	SXl8/ritB2YXhAlahk1rDjg7opKycM+s62yyqwd8uvsNcHwFDVaNf/u2TPYaHQpGlKYOyJ2yS5A
	0tM7cgHoHEYscXq1tlojtsFvU8RqtQ09A/FTkK0oJSvS9AXiZ9VUAm8n+/BGF0jtOMzn1PuITQ4
	ARuL1ms1e7fqkJpMpJeaNdMF+x5soyTrKlc0L8wyEph1nIm/UaskhP7xAIMzt6cwhuBm6tW8HG8
	CWThLyZ+E9mi5KYsXiRmS3vrgHEUUlctJyNQMEzjrTICob41pb6g5i
X-Received: by 2002:a05:600c:8a0c:20b0:485:4552:8fbb with SMTP id 5b1f17b1804b1-4854b107fefmr25514595e9.22.1773227040189;
        Wed, 11 Mar 2026 04:04:00 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:03:58 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 00/28] Add RZ/G3S PCIe support
Date: Wed, 11 Mar 2026 13:03:29 +0200
Message-ID: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22279

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds PCIe support for the Renesas RZ/G3S SoC.
Please have a look.

Thank you,
Claudiu

Amjad Ouled-Ameur (1):
  reset: make shared pulsed reset controls re-triggerable

Claudiu Beznea (16):
  soc: renesas: Add SYSC driver for Renesas RZ family
  soc: renesas: rz-sysc: Move RZ/G3S SoC detection to the SYSC driver
  soc: renesas: rz-sysc: Populate readable_reg/writeable_reg in regmap
    config
  clk: renesas: r9a08g045: Add PCIe clocks and resets
  of/irq: Update the out_irq->np before returning success
  dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller binding
  PCI: Add Renesas RZ/G3S host controller driver
  PCI: rzg3s-host: Initialize MSI status bitmap before use
  PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
  PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and
    RZG3S_PCI_PINTRCVIS
  arm64: dts: renesas: r9a08g045: Enable SYS node
  arm64: dts: renesas: r9a08g045: Use syscon compatible for the system
    controller
  arm64: dts: renesas: r9a08g045: Add PCIe node
  arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
  arm64: dts: renesas: rzg3s-smarc: Enable PCIe
  arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC

Felix Gu (1):
  PCI: rzg3s-host: Fix device node reference leak in
    rzg3s_pcie_host_parse_port()

John Madieu (1):
  soc: renesas: rz-sysc: Add syscon/regmap support

Jonathan Cameron (1):
  of: Add cleanup.h based auto release via __free(device_node) markings

Kevin Xie (1):
  PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value

Marc Zyngier (1):
  of/irq: Allow matching of an interrupt-map local to an interrupt
    controller

Marek Vasut (1):
  genirq/msi: Silence 'set affinity failed' warning

Niklas Cassel (2):
  PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to
    PCIE_RESET_CONFIG_WAIT_MS
  PCI: Move link up wait time and max retries macros to pci.h

Peter Griffin (1):
  mfd: syscon: Add of_syscon_register_regmap() API

Philipp Zabel (1):
  reset: Add reset_control_bulk API

Syed Nayyar Waris (1):
  lib/bitmap: add bitmap_{read,write}()

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  249 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   68 +-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    5 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   19 +
 drivers/mfd/syscon.c                          |   48 +
 drivers/of/irq.c                              |   37 +-
 drivers/pci/controller/Kconfig                |    9 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 1782 +++++++++++++++++
 drivers/pci/pci.h                             |   19 +
 drivers/reset/core.c                          |  288 +++
 drivers/soc/renesas/Kconfig                   |    9 +
 drivers/soc/renesas/Makefile                  |    2 +
 drivers/soc/renesas/r9a08g045-sysc.c          |   93 +
 drivers/soc/renesas/renesas-soc.c             |    3 -
 drivers/soc/renesas/rz-sysc.c                 |  157 ++
 drivers/soc/renesas/rz-sysc.h                 |   45 +
 include/linux/bitmap.h                        |   77 +
 include/linux/mfd/syscon.h                    |    9 +
 include/linux/msi.h                           |    2 +
 include/linux/of.h                            |    2 +
 include/linux/reset.h                         |  335 ++++
 kernel/irq/msi.c                              |    2 +-
 26 files changed, 3267 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c
 create mode 100644 drivers/soc/renesas/r9a08g045-sysc.c
 create mode 100644 drivers/soc/renesas/rz-sysc.c
 create mode 100644 drivers/soc/renesas/rz-sysc.h

-- 
2.43.0


