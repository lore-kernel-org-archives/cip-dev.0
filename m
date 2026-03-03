Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1C4EDA6A8
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 16:54:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23259.1772556881823800439
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 08:54:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: l6lNFHHsS7y2qmdyk5GveQ==
X-CSE-MsgGUID: hSOEljBATwaVxugSLtD1Mw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Mar 2026 01:54:40 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.13])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 34F1040031DC;
	Wed,  4 Mar 2026 01:54:38 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 00/11] Add ADCs support for RZ/T2H and RZ/N2H
Date: Tue,  3 Mar 2026 18:53:40 +0200
Message-ID: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 16:54:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22060

Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include three
12-Bit successive approximation A/D converters.

RZ/T2H has two ADCs with 4 channels and one with 6.
RZ/N2H has two ADCs with 4 channels and one with 15.

Add support for them.

Patches were cherry-picked from upstream kernel.

Besides the main patches related to the RZ/T2H and RZ/N2H ADC support,
commit f24303631489 ("property: Add functions to iterate named child")
commit f3a8f870fa9c ("iio: adc: add helpers for parsing ADC nodes"),
commit 73c1c0f3c5f5 ("bitfield: Add FIELD_MODIFY() helper")
were also backported.

Cosmin Tanislav (7):
  clk: renesas: r9a09g077: Add ADC module clocks
  dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
  iio: adc: add RZ/T2H / RZ/N2H ADC driver
  arm64: dts: renesas: r9a09g077: Add ADCs support
  arm64: dts: renesas: r9a09g087: Add ADCs support
  arm64: dts: renesas: rzt2h/rzn2h-evk: Enable ADCs
  arm64: defconfig: Enable RZ/T2H / RZ/N2H ADC driver

Lad Prabhakar (1):
  arm64: dts: renesas: rzt2h-rzn2h-evk: Reorder ADC nodes

Luo Jie (1):
  bitfield: Add FIELD_MODIFY() helper

Matti Vaittinen (2):
  property: Add functions to iterate named child
  iio: adc: add helpers for parsing ADC nodes

 .../iio/adc/renesas,r9a09g077-adc.yaml        | 135 ++++++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  66 ++++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  29 ++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  66 ++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  65 ++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  80 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/base/property.c                       |  27 ++
 drivers/clk/renesas/r9a09g077-cpg.c           |   3 +
 drivers/iio/adc/Kconfig                       |  14 +
 drivers/iio/adc/Makefile                      |   3 +
 drivers/iio/adc/industrialio-adc.c            |  82 +++++
 drivers/iio/adc/rzt2h_adc.c                   | 304 ++++++++++++++++++
 include/linux/bitfield.h                      |  21 +-
 include/linux/iio/adc-helpers.h               |  27 ++
 include/linux/property.h                      |  20 ++
 17 files changed, 949 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
 create mode 100644 drivers/iio/adc/industrialio-adc.c
 create mode 100644 drivers/iio/adc/rzt2h_adc.c
 create mode 100644 include/linux/iio/adc-helpers.h

-- 
2.53.0


