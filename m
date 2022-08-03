Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC605C19F2C
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:54:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.147.1659545643833978961
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:54:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,214,1654527600";
   d="scan'208";a="130216120"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Aug 2022 01:54:02 +0900
Received: from localhost.localdomain (unknown [10.226.93.45])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 164B340B100C;
	Thu,  4 Aug 2022 01:53:59 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/13] Add more support to RZ/G2LC
Date: Wed,  3 Aug 2022 17:53:45 +0100
Message-Id: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:54:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9070

This patch series aims to add CANFD, WDT, USB2.0, AUDIO, Serial NOR Flash,
OSTM and RSPI on SMARC EVK based on RZ/G2LC SoC.

All these patches are cherry-picked from the mainline.

Biju Das (12):
  arm64: dts: renesas: rzg2lc-smarc: Enable CANFD channel 1
  arm64: dts: renesas: rzg2lc-smarc: Use SW_SD0_DEV_SEL macro for
    eMMC/SDHI device selection
  arm64: dts: renesas: rzg2lc-smarc-som: Enable watchdog
  arm64: dts: renesas: r9a07g044c2-smarc: Enable usb2.0
  arm64: dts: renesas: rzg2lc-smarc-pinfunction: Sort the nodes
  arm64: dts: renesas: rzg2l-smarc: Move out i2c3 and Audio codec from
    common dtsi
  arm64: dts: renesas: rzg2lc-smarc: Enable i2c{0,1,2}
  arm64: dts: renesas: rzg2lc-smarc: Enable Audio
  arm64: dts: renesas: rzg2lc-smarc-som: Enable serial NOR flash
  arm64: dts: renesas: rzg2lc-smarc-som: Enable OSTM
  arm64: dts: renesas: rzg2lc-smarc: Enable RSPI1 on carrier board
  arm64: dts: renesas: rzg2l-smarc: Move gpios property of vccq_sdhi1
    from common dtsi

Geert Uytterhoeven (1):
  arm64: dts: renesas: Align GPIO hog names with dtschema

 .../boot/dts/renesas/beacon-renesom-som.dtsi  |  2 +-
 .../arm64/boot/dts/renesas/hihope-common.dtsi |  2 +-
 .../boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi |  2 +-
 .../dts/renesas/r8a774c0-ek874-idk-2121wr.dts |  2 +-
 .../boot/dts/renesas/r9a07g044c2-smarc.dts    | 82 -------------------
 .../boot/dts/renesas/r9a07g054l2-smarc.dts    |  4 +-
 .../boot/dts/renesas/rz-smarc-common.dtsi     | 16 ----
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  |  4 +-
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 19 +++++
 .../dts/renesas/rzg2lc-smarc-pinfunction.dtsi | 63 ++++++++++++++
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    | 76 ++++++++++++++---
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 42 ++++++++++
 12 files changed, 196 insertions(+), 118 deletions(-)

-- 
2.25.1


