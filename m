Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.904.1795020111183111750
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:41:51 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C081962BD8;
	Wed, 18 Nov 2026 16:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916F21F000C4;
	Wed, 18 Nov 2026 16:41:48 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 00/35] i3c: Backport I3C support for Renesas RZ/G3S
Date: Wed, 18 Nov 2026 18:41:11 +0200
Message-ID: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:41:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24963

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
  pinctrl: renesas: rzg2l: Add SD channel POC support for RZ/G3L
  arm64: dts: renesas: r9a08g045: Move max-frequency to SoC dtsi

Claudiu Beznea (26):
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
  pinctrl: renesas: rzg2l: Use tab instead of spaces
  pinctrl: renesas: rzg2l: Use raw_spinlock_irqsave() on power source
    update
  pinctrl: renesas: rzg2l: Generalize power source code
  pinctrl: renesas: rzg2l: Drop defines present in struct rzg2l_hwcfg
  pinctrl: renesas: rzg2l: Unify power source handling
  pinctrl: renesas: rzg2l: Add RZ/G3S support for selecting I3C power
    source
  arm64: dts: renesas: rzg3s-smarc-som: Enable I3C

Felix Gu (1):
  i3c: master: renesas: Use __free(kfree) for xfer cleanup in
    renesas_i3c_send_ccc_cmd()

Geert Uytterhoeven (1):
  pinctrl: renesas: rzg2l: Fix type in .pin_config_group_get() callback

Kuninori Morimoto (1):
  arm64: dts: renesas: r9a08g045: Move interrupt-parent to root node

Quynh Nguyen (1):
  arm64: dts: renesas: r9a08g045: Add I3C node

Tommaso Merciai (1):
  i3c: renesas: Don't register devices when ENTDAA times out

Wolfram Sang (1):
  clk: renesas: r9a08g045: Add I3C clocks and resets

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  51 ++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  21 +-
 .../boot/dts/renesas/rzg3s-smarc-switches.h   |   4 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   1 -
 drivers/clk/renesas/r9a08g045-cpg.c           |   7 +
 drivers/i3c/master.c                          |  42 ++
 drivers/i3c/master/renesas-i3c.c              | 429 ++++++++++++------
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 420 +++++++++++------
 include/linux/i3c/master.h                    |   1 +
 9 files changed, 707 insertions(+), 269 deletions(-)

--=20
2.43.0

