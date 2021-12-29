Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F90FC433F5
	for <webhook@archiver.kernel.org>; Wed, 29 Dec 2021 10:15:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.49296.1640772936778058884
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Dec 2021 02:15:37 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,244,1635174000";
   d="scan'208";a="105602423"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Dec 2021 19:15:32 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BB496423CEBB;
	Wed, 29 Dec 2021 19:15:31 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/31] Add sound/adc support for RZ/G2L
Date: Wed, 29 Dec 2021 10:14:59 +0000
Message-Id: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Dec 2021 10:15:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7279

Hi All,

This patch series adds Sound and ADC support for Renesas RZ/G2L SoC
and enables RIIC/SOUND/CANFD/ADC on Renesas SMARC EVK.

I have also included the missing driver patch for riic and kernel configs.

All the patches have been cherry picked from v5.16-rc7.

I have created a MR [0] for cip-kernel-config to support build testing and
can be merged once this patch series is accepted.

[0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/55

Cheers,
Prabhakar

Biju Das (21):
  ASoC: dt-bindings: Document RZ/G2L bindings
  ASoC: dt-bindings: sound: renesas,rz-ssi: Document DMA support
  ASoC: sh: Add RZ/G2L SSIF-2 driver
  ASoC: dt-bindings: renesas,rz-ssi: Update slave dma channel
    configuration parameter
  ASoC: sh: rz-ssi: Add SSI DMAC support
  ASoC: sh: rz-ssi: Fix dereference of noderef expression warning
  ASoC: sh: rz-ssi: Fix wrong operator used issue
  ASoC: sh: rz-ssi: Improve error handling in rz_ssi_dma_request
    function
  clk: renesas: r9a07g044: Add SSIF-2 clock and reset entries
  arm64: dts: renesas: r9a07g044: Add external audio clock nodes
  arm64: dts: renesas: r9a07g044: Add SSI support
  arm64: dts: renesas: r9a07g044: Add DMA support to SSI
  arm64: dts: renesas: rzg2l-smarc: Enable I2C{0,1,3} support
  arm64: dts: renesas: rzg2l-smarc: Add WM8978 sound codec
  arm64: dts: renesas: rzg2l-smarc: Enable audio
  arm64: dts: renesas: rzg2l-smarc: Add Mic routing
  arm64: defconfig: Enable SOUND_SOC_RZ
  arm64: defconfig: Enable SND_SOC_WM8978
  clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
  i2c: riic: Add RZ/G2L support
  arm64: defconfig: Enable RIIC

Colin Ian King (1):
  iio: adc: rzg2l_adc: Fix -EBUSY timeout error return

Lad Prabhakar (8):
  dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L
    A/D converter
  iio: adc: Add driver for Renesas RZ/G2L A/D converter
  clk: renesas: r9a07g044: Add clock and reset entries for ADC
  arm64: dts: renesas: r9a07g044: Add ADC node
  arm64: dts: renesas: rzg2l-smarc-som: Move extal and memory nodes to
    SOM DTSI
  arm64: dts: renesas: rzg2l-smarc-som: Enable ADC on SMARC platform
  arm64: dts: renesas: rzg2l-smarc: Enable CANFD
  arm64: defconfig: Enable RZG2L_ADC

Yang Yingliang (1):
  iio: adc: rzg2l_adc: add missing clk_disable_unprepare() in
    rzg2l_adc_pm_runtime_resume()

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  134 ++
 .../bindings/sound/renesas,rz-ssi.yaml        |  118 ++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  140 +++
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |    7 +-
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |   35 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  162 ++-
 arch/arm64/configs/defconfig                  |    4 +
 drivers/clk/renesas/r9a07g044-cpg.c           |   28 +
 drivers/i2c/busses/i2c-riic.c                 |   23 +-
 drivers/iio/adc/Kconfig                       |   10 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/rzg2l_adc.c                   |  591 +++++++++
 sound/soc/sh/Kconfig                          |    6 +
 sound/soc/sh/Makefile                         |    4 +
 sound/soc/sh/rz-ssi.c                         | 1074 +++++++++++++++++
 16 files changed, 2334 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
 create mode 100644 drivers/iio/adc/rzg2l_adc.c
 create mode 100644 sound/soc/sh/rz-ssi.c

-- 
2.17.1


