Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4F0F417FA
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 15:07:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16929.1773068829836237258
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 08:07:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: FeojpZR+SZGHesOPb/VSvQ==
X-CSE-MsgGUID: ogPWMj9bQRmj6C6jRb1EGA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2026 00:07:08 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.213])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F0BB040071E2;
	Tue, 10 Mar 2026 00:07:06 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip v3 00/17] Add RSPI support for RZ/T2H and RZ/N2H
Date: Mon,  9 Mar 2026 17:06:02 +0200
Message-ID: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 15:07:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22198

This series adds RSPI support for the Renesas RZ/T2H (R9A09G077) and
RZ/N2H (R9A09G087) SoCs.

RZ/T2H and RZ/N2H support is implemented as part of the RZ/V2H RSPI
driver, and, as such, the RZ/V2H RSPI driver had to be backported.

Patches were cherry-picked from upstream kernel.

This series applies on top of my previously submitted series [1] (to
avoid a conflict in drivers/clk/renesas/r9a09g077-cpg.c mainly).

[1]: https://patchwork.kernel.org/project/cip-dev/cover/20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com/

V3:
 * describe changes made to apply on top of CIP

V2:
 * remove internal Reviewed-by tags

Cosmin Tanislav (14):
  clk: renesas: r9a09g077: Add SPI module clocks
  spi: rzv2h-rspi: make resets optional
  spi: rzv2h-rspi: make FIFO size chip-specific
  spi: rzv2h-rspi: make clocks chip-specific
  spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
  spi: rzv2h-rspi: avoid recomputing transfer frequency
  spi: rzv2h-rspi: make transfer clock rate finding chip-specific
  spi: rzv2h-rspi: add support for using PCLK for transfer clock
  spi: rzv2h-rspi: add support for variable transfer clock
  spi: rzv2h-rspi: add support for loopback mode
  spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
  spi: dt-bindings: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
  arm64: dts: renesas: r9a09g077: Add SPI nodes
  arm64: dts: renesas: r9a09g087: Add SPI nodes

Fabrizio Castro (3):
  spi: dt-bindings: Document the RZ/V2H(P) RSPI
  spi: Add driver for the RZ/V2H(P) RSPI IP
  arm64: defconfig: Enable the RZ/V2H(P) RSPI driver

 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 138 ++++
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  72 ++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  72 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a09g077-cpg.c           |  22 +-
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rzv2h-rspi.c                  | 687 ++++++++++++++++++
 8 files changed, 1000 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
 create mode 100644 drivers/spi/spi-rzv2h-rspi.c

-- 
2.53.0


