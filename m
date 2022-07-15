Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ACFCCA47C
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:22:54 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.3817.1657869769409444413
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:22:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="126267380"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jul 2022 16:22:47 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A837C40178D1;
	Fri, 15 Jul 2022 16:22:45 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/24] RZ/G2L Fixes from mainline
Date: Fri, 15 Jul 2022 08:22:20 +0100
Message-Id: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:22:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8786

This patch series are backported from Mainline for supporting
future SoCs as well as various bugs and improvements related to
RZ/g2L SMARC EVK Platform.

All these patches are cherry-picked from mainline.

Biju Das (6):
  dt-bindings: power: renesas,rzg2l-sysc: Document RZ/V2L SoC
  soc: renesas: Identify RZ/V2L SoC
  soc: renesas: Add support for reading product revision for RZ/G2L
    family
  ASoC: sh: Make SND_SOC_RZ depend on ARCH_RZG2L
  dt-bindings: dma: rz-dmac: Document RZ/V2L SoC
  arm64: dts: renesas: rzg2l-smarc: Move pinctrl definitions

Geert Uytterhoeven (2):
  soc: renesas: Consolidate product register handling
  arm64: dts: renesas: Fix pin controller node names

Heiner Kallweit (2):
  reset: renesas: Fix Runtime PM usage
  reset: renesas: Check return value of reset_control_deassert()

Jialin Zhang (1):
  iio: adc: rzg2l_adc: add missing fwnode_handle_put() in
    rzg2l_adc_parse_properties()

Lad Prabhakar (12):
  soc: renesas: Kconfig: Explicitly select PM and PM_GENERIC_DOMAINS
    configs
  soc: renesas: Kconfig: Introduce ARCH_RZG2L config option
  iio: adc: Kconfig: Make RZG2L_ADC depend on ARCH_RZG2L
  dmaengine: sh: Kconfig: Add ARCH_R9A07G054 dependency for RZ_DMAC
    config option
  dmaengine: sh: Kconfig: Make RZ_DMAC depend on ARCH_RZG2L
  reset: Kconfig: Make RESET_RZG2L_USBPHY_CTRL depend on ARCH_RZG2L
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Add description for
    power-source property
  ASoC: sh: rz-ssi: Drop SSIFSR_TDC and SSIFSR_RDC macros
  ASoC: sh: rz-ssi: Propagate error codes returned from
    platform_get_irq_byname()
  ASoC: sh: rz-ssi: Release the DMA channels in rz_ssi_probe() error
    path
  iio: adc: rzg2l_adc: Fix typo
  i2c: riic: Simplify reset handling

Xu Wang (1):
  iio: adc: rzg2l_adc: Remove unnecessary print function dev_err()

 .../bindings/dma/renesas,rz-dmac.yaml         |   3 +-
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |   1 +
 .../bindings/power/renesas,rzg2l-sysc.yaml    |   7 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |   2 +-
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |   1 +
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  | 137 ++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 127 -------------
 drivers/dma/sh/Kconfig                        |   6 +-
 drivers/i2c/busses/i2c-riic.c                 |  34 ++--
 drivers/iio/adc/Kconfig                       |   2 +-
 drivers/iio/adc/rzg2l_adc.c                   |  16 +-
 drivers/reset/Kconfig                         |   2 +-
 drivers/reset/reset-rzg2l-usbphy-ctrl.c       |  11 +-
 drivers/soc/renesas/Kconfig                   |  12 ++
 drivers/soc/renesas/renesas-soc.c             | 173 ++++++++++--------
 sound/soc/sh/Kconfig                          |   2 +-
 sound/soc/sh/rz-ssi.c                         |  24 +--
 17 files changed, 309 insertions(+), 251 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi

-- 
2.25.1


