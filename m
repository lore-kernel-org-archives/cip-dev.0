Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16033.1794916164572640941
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:49:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 171F244E94;
	Tue, 17 Nov 2026 11:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC871F000C4;
	Tue, 17 Nov 2026 11:49:22 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 00/34] i3c: Backport I3C support for Renesas RZ/G3S
Date: Tue, 17 Nov 2026 13:48:46 +0200
Message-ID: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:49:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24911
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the I3C support for the Renesas RZ/G3S.

Please provide your feedback.

Thank you,
Claudiu

Adrian Hunter (1):
  i3c: master: Add i3c_master_do_daa_ext() for post-hibernation address
    recovery

Biju Das (2):
  pinctrl: renesas: rzg2l: Make QSPI register handling conditional
  arm64: dts: renesas: r9a08g045: Move max-frequency to SoC dtsi

Claudiu Beznea (24):
  i3c: renesas: Check that the transfer is valid before accessing it
  i3c: renesas: Restore STDBR and EXTBR registers on resume
  i3c: renesas: Follow the reset deassert order used in probe
  i3c: renesas: Reconfigure the DATBAS register on re-attach
  i3c: renesas: Reset the controller on resume
  i3c: renesas: Perform Dynamic Address Assignment on resume
  i3c: renesas: Clean DATBAS register on detach
  i3c: renesas: Fix out-of-bounds access for newdevs mask
  i3c: renesas: Use reset_control_bulk_{assert, deassert}()
  i3c: renesas: Return immediately if there is no transfer
  i3c: renesas: Follow a unified pattern for transfer and command
    initialization
  i3c: renesas: Drop the explicit memset() call
  i3c: renesas: Update HW registers after SW computations are done
  i3c: renesas: Organize structures to avoid unnecessary padding
  i3c: renesas: Use the "dev_name:irq_name" format for the interrupt
    name
  i3c: renesas: Drop unnecessary tab
  i3c: renesas: Add runtime PM support
  i3c: renesas: Drop unused structure member 'resuming'
  pinctrl: renesas: rzg2l: Keep member documentation aligned
  pinctrl: renesas: rzg2l: Generalize power source code
  pinctrl: renesas: rzg2l: Drop defines present in struct rzg2l_hwcfg
  pinctrl: renesas: rzg2l: Unify power source handling
  pinctrl: renesas: rzg2l: Add RZ/G3S support for selecting I3C power
    source
  arm64: dts: renesas: rzg3s-smarc-som: Enable I3C

Felix Gu (1):
  i3c: master: renesas: Use __free(kfree) for xfer cleanup in
    renesas_i3c_send_ccc_cmd()

Geert Uytterhoeven (2):
  pinctrl: renesas: rzg2l: Fix type in .pin_config_group_get() callback
  arm64: dts: renesas: r9a08g045: Add missing hypervisor virtual timer
    IRQ

Kuninori Morimoto (1):
  arm64: dts: renesas: r9a08g045: Move interrupt-parent to root node

Quynh Nguyen (1):
  arm64: dts: renesas: r9a08g045: Add I3C node

Tommaso Merciai (1):
  i3c: renesas: Don't register devices when ENTDAA times out

Wolfram Sang (1):
  clk: renesas: r9a08g045: Add I3C clocks and resets

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  52 ++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  21 +-
 .../boot/dts/renesas/rzg3s-smarc-switches.h   |   4 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   1 -
 drivers/clk/renesas/r9a08g045-cpg.c           |   7 +
 drivers/i3c/master.c                          |  44 ++
 drivers/i3c/master/renesas-i3c.c              | 429 ++++++++++++------
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 285 ++++++++----
 include/linux/i3c/master.h                    |   1 +
 9 files changed, 623 insertions(+), 221 deletions(-)

--=20
2.43.0

