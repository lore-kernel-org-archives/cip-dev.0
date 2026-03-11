Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879AA10611ED
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:30 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18304.1773227124268913346
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Q7PxcGsK;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-485392de558so20258415e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227123; x=1773831923; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9Byj65hnd0ozBedjy8LSnHbNYLuS5M+twPJqsBADsw=;
        b=Q7PxcGsKv319LPczRgkxTAw4/CEsgKdD41Few7q9Ve2i9l9dcP4SwjWet0WdEzZQmH
         emK5QPIbqrBg/sitaN5KHtsnYvVw/TEyQb4ujOlzXHlqT6HJkRt4KdNp036bKy20clmT
         DsAatb1/kJZUtDdph44aAQ1+A7BS9rH8ZiUegVF0L0jVnN03x+3KQoFXW7qWJfuGuV3X
         hkrBcZfza3OzGlOcKJ+3PE+CIBdDOwjmnzPck9Ug/bwTfPv/fcOkm9haBeXGNd8zYogi
         Y6CbJqYsymXmgjBfqHUTFYm0kogAomt/ETH+sDTMlxztKzuJpJyxPGw2rAByi8WhgHQP
         Qyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227123; x=1773831923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9Byj65hnd0ozBedjy8LSnHbNYLuS5M+twPJqsBADsw=;
        b=NADDAFeRx6fNlg9m3ypiLG3OiyMF6N3LfiWHgtRogXeCodEN64pffoh2HVxz4sJvve
         dlp4A+7Rf4H7rhwodP8ny3P3R7+Uw3bphUiZrVwgSulFk7cDHqvCs4NG+lUoPE/4f7lp
         Yb5I4BZw131r8JuD0Ov3KA/DlmhgNB4XOfC5WRt2kInAdswnYJU9IXWpDmsmVEL6+SJW
         q7LQHiEbEXmwFSzESZ0HSbjGSGv0oOshGUKM9otQqaQ77d+MbfbbxNmfleCiGU8Izni6
         pyH4dqIBd+V0OjuEbOCdNPZ94GfpJ/G27JSfdIEQHM5ti1tdU5EcVcniLhbX3ERNWl/G
         0mBA==
X-Gm-Message-State: AOJu0YwIXUhN39/Ep13hoC67iw4jo2cOJbtP9aAf3Ghqq82o6nuhR4ml
	//jR0rxSlQ46j8vBcuzNMw/iCmKtJn077D04SPf2MfdHM6bGDalD8GH9CQG+0D5JtbU=
X-Gm-Gg: ATEYQzzhVIG2Kug5YNIFWH+loCrr+K3V7jpK2fSfu3Xsrew+YyS1BoHfBRon7A6tbpO
	DIFVld938FbZkSJdYUv+WhO73ApimOy6S4/1FG+8OP2L1fsGiYFHY+J2taRycX37XgmEHwCNyvh
	iRJEi+/lcYNeywwDRs3T2a2HlTNOKnuN/GW9gAPhVOYY1kvCJ9KeIfWlFWDcyxTOpKdSUA0i53E
	m4l1C8EpP4E2x1k5lDKLEawwqiTfmWgiXO/1HfhTgVqKy9beROpsHY1yg1oRoewSGzol/jT1rMg
	ehPNUP1Q727/aAFHq5375MPamDxAKL8YP6k5dVm23Cs5MzdvZQDSyAjAkTHjBwnnpISGux5V9wG
	V7w1cpRff0Hvg/tJcVzI6pmHWY2M+Nyou97KC0wqXv4X3b/sDv/2wciFwHEvxao6xuzDqpyoG3+
	8CfOaPrF98ltw1hpiOOMYOstix0jkIlKUhHkkeEtkkZjnOyS42dM3T
X-Received: by 2002:a05:600c:1f8e:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-4854b0bc6d4mr35258795e9.9.1773227122598;
        Wed, 11 Mar 2026 04:05:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 00/17] Add RZ/G3S PCIe support
Date: Wed, 11 Mar 2026 13:05:03 +0200
Message-ID: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22308

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds PCIe support for the Renesas RZ/G3S SoC.
Please have a look.

Thank you,
Claudiu

Claudiu Beznea (11):
  clk: renesas: r9a08g045: Add PCIe clocks and resets
  dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller binding
  PCI: Add Renesas RZ/G3S host controller driver
  PCI: rzg3s-host: Initialize MSI status bitmap before use
  PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
  PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and
    RZG3S_PCI_PINTRCVIS
  arm64: dts: renesas: r9a08g045: Use syscon compatible for the system
    controller
  arm64: dts: renesas: r9a08g045: Add PCIe node
  arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
  arm64: dts: renesas: rzg3s-smarc: Enable PCIe
  arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC

Felix Gu (1):
  PCI: rzg3s-host: Fix device node reference leak in
    rzg3s_pcie_host_parse_port()

Kevin Xie (1):
  PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value

Marek Vasut (1):
  genirq/msi: Silence 'set affinity failed' warning

Niklas Cassel (2):
  PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to
    PCIE_RESET_CONFIG_WAIT_MS
  PCI: Move link up wait time and max retries macros to pci.h

Syed Nayyar Waris (1):
  lib/bitmap: add bitmap_{read,write}()

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  249 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   67 +-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    5 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   19 +
 drivers/pci/controller/Kconfig                |    9 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 1764 +++++++++++++++++
 drivers/pci/pci.h                             |   19 +
 include/linux/bitmap.h                        |   77 +
 include/linux/msi.h                           |    2 +
 kernel/irq/msi.c                              |    2 +-
 14 files changed, 2232 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c

-- 
2.43.0


