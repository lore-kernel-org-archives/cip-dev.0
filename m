Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D04C433F5
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 13:31:46 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.5196.1640007103306700648
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 05:31:43 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,220,1635174000";
   d="scan'208";a="104578448"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Dec 2021 22:31:41 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1AC534005E10;
	Mon, 20 Dec 2021 22:31:39 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/22] RZ/G2L: Add support for pinctrl/dmac/iic
Date: Mon, 20 Dec 2021 13:31:17 +0000
Message-Id: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 13:31:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7197

Hi All,

This patch series adds Pinctrl/DMAC/IIC support for Renesas RZ/G2L SoC.

All the patches have been cherry picked from v5.16-rc5.

I have created a MR [0] for cip-kernel-config (for testing purpose), which
can later be merged once this patches have been merged.

[0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/53

Cheers,
Prabhakar

Bartosz Golaszewski (1):
  mm: slab: provide krealloc_array()

Biju Das (11):
  pinctrl: renesas: rzg2l: Fix missing port register 21h
  clk: renesas: r9a07g044: Add I2C clocks/resets
  dt-bindings: i2c: renesas,riic: Document RZ/G2L I2C controller
  arm64: dts: renesas: r9a07g044: Add I2C nodes
  clk: renesas: r9a07g044: Add DMAC clocks/resets
  dt-bindings: dma: Document RZ/G2L bindings
  dmaengine: Extend the dma_slave_width for 128 bytes
  dmaengine: sh: Add DMAC driver for RZ/G2L SoC
  dmaengine: sh: rz-dmac: Add DMA clock handling
  arm64: dts: renesas: r9a07g044: Add DMAC support
  arm64: defconfig: Enable RZ_DMAC

Colin Ian King (2):
  dmaengine: sh: Fix unused initialization of pointer lmdesc
  dmaengine: sh: make array ds_lut static

Dan Carpenter (1):
  dmaengine: sh: fix some NULL dereferences

Geert Uytterhoeven (2):
  dt-bindings: i2c: renesas,riic: Convert to json-schema
  arm64: dts: renesas: r9a07g044: Add I2C interrupt-names

Lad Prabhakar (5):
  clk: renesas: r9a07g044: Add GPIO clock and reset entries
  dt-bindings: pinctrl: renesas: Add DT bindings for RZ/G2L pinctrl
  pinctrl: renesas: Add RZ/G2L pin and gpio controller driver
  arm64: dts: renesas: rzg2l-smarc: Add scif0 pins
  arm64: dts: renesas: r9a07g044: Add pinctrl node

 Documentation/core-api/memory-allocation.rst  |    4 +
 .../bindings/dma/renesas,rz-dmac.yaml         |  130 ++
 .../devicetree/bindings/i2c/renesas,riic.txt  |   32 -
 .../devicetree/bindings/i2c/renesas,riic.yaml |   93 ++
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  155 +++
 MAINTAINERS                                   |    2 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  137 ++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |   10 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/renesas/r9a07g044-cpg.c           |   25 +
 drivers/dma/sh/Kconfig                        |    9 +
 drivers/dma/sh/Makefile                       |    1 +
 drivers/dma/sh/rz-dmac.c                      |  983 ++++++++++++++
 drivers/pinctrl/renesas/Kconfig               |   11 +
 drivers/pinctrl/renesas/Makefile              |    1 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 1175 +++++++++++++++++
 include/dt-bindings/pinctrl/rzg2l-pinctrl.h   |   23 +
 include/linux/dmaengine.h                     |    3 +-
 include/linux/slab.h                          |   18 +
 19 files changed, 2779 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/renesas,riic.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/renesas,riic.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
 create mode 100644 drivers/dma/sh/rz-dmac.c
 create mode 100644 drivers/pinctrl/renesas/pinctrl-rzg2l.c
 create mode 100644 include/dt-bindings/pinctrl/rzg2l-pinctrl.h

-- 
2.17.1


