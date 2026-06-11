Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D07CD98D5
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:47:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42646.1781174820462532833
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:47:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C2C9E60209;
	Thu, 11 Jun 2026 10:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CA31F00893;
	Thu, 11 Jun 2026 10:46:58 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
Date: Thu, 11 Jun 2026 13:46:39 +0300
Message-ID: <20260611104656.2533096-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:47:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23111

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Patches backport the Renesas RZ/G3S USB support.

Thank you,
Claudiu


Claudiu Beznea (16):
  reset: rzg2l-usbphy-ctrl: Add support for USB PWRRDY
  dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S support
  reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
  reset: rzg2l-usbphy-ctrl: Propagate the return value of
    regmap_field_update_bits()
  reset: rzg2l-usbphy-ctrl: Add suspend/resume support
  reset: rzg2l-usbphy-ctrl: Check pwrrdy is valid before using it
  usb: host: Do not check priv->clks[clk]
  usb: host: ehci-platform: Call reset assert/deassert on suspend/resume
  usb: host: ohci-platform: Call reset assert/deassert on suspend/resume
  dt-bindings: usb: renesas,usbhs: Document RZ/G3S SoC
  usb: renesas_usbhs: Assert/de-assert reset signals on suspend/resume
  dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
  phy: renesas: rcar-gen3-usb2: Move phy_data->init_bus check
  phy: renesas: rcar-gen3-usb2: Add suspend/resume support
  arm64: dts: renesas: r9a08g045: Add USB support
  arm64: dts: renesas: rzg3s-smarc: Enable USB support

Dan Carpenter (1):
  reset: rzg2l-usbphy-ctrl: Fix a NULL vs IS_ERR() bug in probe

 .../bindings/phy/renesas,usb2-phy.yaml        |   1 +
 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      |  41 ++++-
 .../bindings/usb/renesas,usbhs.yaml           |   1 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 118 ++++++++++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  57 +++++++
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |  66 +++++---
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c       | 151 +++++++++++++++++-
 drivers/usb/host/ehci-platform.c              |  25 ++-
 drivers/usb/host/ohci-platform.c              |  24 ++-
 drivers/usb/renesas_usbhs/common.c            |  35 ++--
 11 files changed, 470 insertions(+), 50 deletions(-)

--=20
2.43.0


