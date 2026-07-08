Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA13C43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:10:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3838.1783498250117453172
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:10:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DBFF407D6;
	Wed,  8 Jul 2026 08:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE151F000E9;
	Wed,  8 Jul 2026 08:10:47 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 00/27] Backport RZ/G3S USB support
Date: Wed,  8 Jul 2026 11:10:19 +0300
Message-ID: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:10:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23478

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Patches backport the Renesas RZ/G3S USB support.

Thank you,
Claudiu

Changes in v2:
- added patch "clk: renesas: rzg2l: Deassert reset on assert timeout"
- adjusted the code from the patches:
-- "usb: host: ehci-platform: Call reset assert/deassert on suspend/resum=
e"
-- "usb: host: ohci-platform: Call reset assert/deassert on suspend/resum=
e"
 to execute only for the Renesas RZ/G3S

Biju Das (1):
  clk: renesas: rzg2l: Deassert reset on assert timeout

Christophe JAILLET (1):
  phy: renesas: rcar-gen3-usb2: Fix an error handling path in
    rcar_gen3_phy_usb2_probe()

Claudiu Beznea (22):
  clk: renesas: r9a08g045: Add clocks, resets and power domains for USB
  pinctrl: renesas: rzg2l: Add suspend/resume support for pull up/down
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
  dt-bindings: phy: renesas,usb2-phy: Document RZ/G3S phy bindings
  dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
  phy: renesas: rcar-gen3-usb2: Add support to initialize the bus
  phy: renesas: rcar-gen3-usb2: Add support for the RZ/G3S SoC
  phy: renesas: rcar-gen3-usb2: Move phy_data->init_bus check
  phy: renesas: rcar-gen3-usb2: Add suspend/resume support
  arm64: dts: renesas: r9a08g045: Add USB support
  arm64: dts: renesas: rzg3s-smarc: Enable USB support
  usb: renesas: Suppress binding attributes

Dan Carpenter (1):
  reset: rzg2l-usbphy-ctrl: Fix a NULL vs IS_ERR() bug in probe

Lad Prabhakar (2):
  pinctrl: renesas: rzg2l: Add support for pull-up/down
  phy: renesas: rcar-gen3-usb2: store drvdata pointer in channel

 .../bindings/phy/renesas,usb2-phy.yaml        |   8 +-
 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      |  41 ++++-
 .../bindings/usb/renesas,usbhs.yaml           |   2 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 118 ++++++++++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  57 +++++++
 drivers/clk/renesas/r9a08g045-cpg.c           |  12 ++
 drivers/clk/renesas/rzg2l-cpg.c               |  12 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      | 117 ++++++++++++--
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  91 ++++++++++-
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c       | 152 +++++++++++++++++-
 drivers/usb/host/ehci-platform.c              |  42 ++++-
 drivers/usb/host/ohci-platform.c              |  41 ++++-
 drivers/usb/renesas_usbhs/common.c            |  35 ++--
 14 files changed, 679 insertions(+), 50 deletions(-)

--=20
2.43.0


