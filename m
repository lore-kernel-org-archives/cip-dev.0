Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0866ECAAD1
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 08:02:01 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.9597.1662019295710136100
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 01:01:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,280,1654527600";
   d="scan'208";a="131322087"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 17:01:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.226])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AC47F400BBF1;
	Thu,  1 Sep 2022 17:01:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/13] Add more document support for RZ/G2UL SoC.
Date: Thu,  1 Sep 2022 09:01:15 +0100
Message-Id: <20220901080128.2147891-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 08:02:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9404

This patch series aims to document various IP's present in RZ/G2UL SoC and
RZ/V2L ADC.

Biju Das (13):
  dt-bindings: timer: renesas: ostm: Document Renesas RZ/G2UL OSTM
  dt-bindings: i2c: renesas,riic: Document RZ/G2UL SoC
  dt-bindings: usb: renesas,usbhs: Document RZ/G2UL bindings
  dt-bindings: can: renesas,rcar-canfd: Document RZ/G2UL support
  dt-bindings: phy: renesas,usb2-phy: Document RZ/G2UL phy bindings
  spi: dt-bindings: renesas,rspi: Document RZ/G2UL SoC
  dt-bindings: memory: renesas,rpc-if: Document RZ/G2UL SoC
  dt-bindings: thermal: rzg2l-thermal: Document RZ/G2UL bindings
  dt-bindings: watchdog: renesas,wdt: Document RZ/G2UL SoC
  ASoC: dt-bindings: renesas,rz-ssi: Document RZ/G2UL SoC
  dt-bindings: iio: adc: Document Renesas RZ/V2L ADC
  dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
  dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G2UL USBPHY
    Control bindings

 .../devicetree/bindings/i2c/renesas,riic.yaml |  2 ++
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 31 ++++++++++++++++---
 .../memory-controllers/renesas,rpc-if.yaml    |  1 +
 .../bindings/net/can/renesas,rcar-canfd.yaml  |  1 +
 .../bindings/phy/renesas,usb2-phy.yaml        |  1 +
 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      |  1 +
 .../bindings/sound/renesas,rz-ssi.yaml        |  3 +-
 .../devicetree/bindings/spi/renesas,rspi.yaml |  2 ++
 .../bindings/thermal/rzg2l-thermal.yaml       |  1 +
 .../bindings/timer/renesas,ostm.yaml          |  2 ++
 .../bindings/usb/renesas,usbhs.yaml           |  4 +++
 .../bindings/watchdog/renesas,wdt.yaml        |  1 +
 12 files changed, 44 insertions(+), 6 deletions(-)

-- 
2.25.1


