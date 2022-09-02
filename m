Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C68C54EE9
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:44:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.4673.1662111873032698693
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:44:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="133482003"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Sep 2022 18:44:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0A8EC400CF08;
	Fri,  2 Sep 2022 18:44:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/25] Add more support to RZ/G2UL SMARC EVK
Date: Fri,  2 Sep 2022 10:44:02 +0100
Message-Id: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:44:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9426

This patch series aims to add CANFD, WDT, USB2.0, AUDIO, Serial NOR Flash,
OSTM, ADC and RSPI on SMARC EVK based on RZ/G2UL SoC.

All these patches are cherry-picked from the mainline.

Biju Das (25):
  clk: renesas: r9a07g043: Add clock and reset entries for SPI Multi I/O
    Bus Controller
  clk: renesas: r9a07g043: Add RSPI clock and reset entries
  clk: renesas: r9a07g043: Add TSU clock and reset entry
  clk: renesas: r9a07g043: Add clock and reset entries for ADC
  arm64: dts: renesas: r9a07g043: Add I2C2 node and fillup the
    I2C{0,1,3} stub nodes
  arm64: dts: renesas: r9a07g043: Add SSI{1,2,3} nodes and fillup the
    SSI0 stub node
  arm64: dts: renesas: r9a07g043: Add USB2.0 support
  arm64: dts: renesas: r9a07g043: Fillup the CANFD stub node
  arm64: dts: renesas: r9a07g043: Fillup the OSTM{0,1,2} stub nodes
  arm64: dts: renesas: r9a07g043: Fillup the WDT{0,2} stub nodes
  arm64: dts: renesas: rzg2ul-smarc: Enable i2c{0,1} and wm8978
  arm64: dts: renesas: rzg2ul-smarc: Enable CANFD
  arm64: dts: renesas: rzg2ul-smarc-som: Enable OSTM
  arm64: dts: renesas: rzg2ul-smarc-som: Enable watchdog
  arm64: dts: renesas: rzg2l-smarc: Move ssi0 and cpu sound_dai nodes
    from common dtsi
  arm64: dts: renesas: rzg2ul-smarc: Enable Audio
  arm64: dts: renesas: rzg2ul-smarc: Enable USB2.0 support
  arm64: dts: renesas: r9a07g043: Add RSPI{0,1,2} nodes
  arm64: dts: renesas: r9a07g043: Add OPP table
  arm64: dts: renesas: r9a07g043: Add TSU node
  arm64: dts: renesas: r9a07g043: Create thermal zone to support IPA
  arm64: dts: renesas: r9a07g043: Add SPI Multi I/O Bus controller node
  arm64: dts: renesas: r9a07g043: Add ADC node
  arm64: dts: renesas: rzg2ul-smarc: Enable RSPI1 on carrier board
  arm64: dts: renesas: rzg2ul-smarc-som: Enable ADC on SMARC platform

 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 465 +++++++++++++++++-
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |  82 ---
 .../boot/dts/renesas/rz-smarc-common.dtsi     |   8 -
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  11 +
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  11 +
 .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi |  56 +++
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    |  37 ++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  45 ++
 drivers/clk/renesas/r9a07g043-cpg.c           |  39 ++
 9 files changed, 643 insertions(+), 111 deletions(-)

-- 
2.25.1


