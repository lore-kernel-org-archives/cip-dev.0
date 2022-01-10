Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBDDC433FE
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 11:53:54 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.30453.1641815633947825296
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 03:53:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106009826"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 20:53:50 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4A075429BEAD;
	Mon, 10 Jan 2022 20:53:49 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 00/15] Add ADC/CANFD/IIC support for RZ/G2L
Date: Mon, 10 Jan 2022 11:53:33 +0000
Message-Id: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 11:53:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7349

Hi All,

This patch series adds Sound and ADC support for Renesas RZ/G2L SoC
and enables RIIC/SOUND/CANFD/ADC on Renesas SMARC EVK.

I have also included the missing driver patch for riic and kernel configs.

All the patches have been cherry picked from v5.16-rc7.

I have created a MR [0] for cip-kernel-config to support build testing and
can be merged once this patch series is accepted.

Note: I have kept the clock related patches for audio as this will avoid
conflicts with the later patches.

[0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/55

Changes for v2:
* Dropped sound support

v1:
https://patchwork.kernel.org/project/cip-dev/cover/
20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Biju Das (5):
  i2c: riic: Add RZ/G2L support
  arm64: defconfig: Enable RIIC
  clk: renesas: r9a07g044: Add SSIF-2 clock and reset entries
  arm64: dts: renesas: rzg2l-smarc: Enable I2C{0,1,3} support
  clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical

Colin Ian King (1):
  iio: adc: rzg2l_adc: Fix -EBUSY timeout error return

Lad Prabhakar (8):
  dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L
    A/D converter
  iio: adc: Add driver for Renesas RZ/G2L A/D converter
  clk: renesas: r9a07g044: Add clock and reset entries for ADC
  arm64: dts: renesas: r9a07g044: Add ADC node
  arm64: defconfig: Enable RZG2L_ADC
  arm64: dts: renesas: rzg2l-smarc-som: Move extal and memory nodes to
    SOM DTSI
  arm64: dts: renesas: rzg2l-smarc-som: Enable ADC on SMARC platform
  arm64: dts: renesas: rzg2l-smarc: Enable CANFD

Yang Yingliang (1):
  iio: adc: rzg2l_adc: add missing clk_disable_unprepare() in
    rzg2l_adc_pm_runtime_resume()

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 134 ++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  42 ++
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |   7 +-
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  35 ++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  83 ++-
 arch/arm64/configs/defconfig                  |   2 +
 drivers/clk/renesas/r9a07g044-cpg.c           |  28 +
 drivers/i2c/busses/i2c-riic.c                 |  23 +-
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rzg2l_adc.c                   | 591 ++++++++++++++++++
 12 files changed, 953 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
 create mode 100644 drivers/iio/adc/rzg2l_adc.c

-- 
2.17.1


