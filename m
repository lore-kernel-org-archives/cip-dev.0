Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15769.1794915958284844443
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:45:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CFB9B63404;
	Tue, 17 Nov 2026 11:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773271F000C4;
	Tue, 17 Nov 2026 11:45:55 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 00/69] i3c: Backport I3C support for Renesas RZ/G3S
Date: Tue, 17 Nov 2026 13:44:44 +0200
Message-ID: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24841

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the I3C support for the Renesas RZ/G3S. Along with it 2 =
client
drivers were backported, tmp108 and lm75, in a similar way it was done fo=
r
v6.1 [1] and v6.12 CIPs [2].

Please provide your feedback.

Thank you,
Claudiu

[1] https://lore.kernel.org/cip-dev/20260717131241.2233788-1-tommaso.merc=
iai.xr@bp.renesas.com/
[2] https://lore.kernel.org/cip-dev/20260717131502.2234020-1-tommaso.merc=
iai.xr@bp.renesas.com/


Abdel Alkuor (2):
  hwmon: (lm75) Add AMS AS6200 temperature sensor
  hwmon: (lm75) Fix tmp112 default config

Adrian Hunter (1):
  i3c: master: Add i3c_master_do_daa_ext() for post-hibernation address
    recovery

Andrew Davis (1):
  hwmon: (lm75) Remove use of i2c_match_id()

Arnd Bergmann (1):
  i3c: fix big-endian FIFO transfers

Biju Das (2):
  pinctrl: renesas: rzg2l: Make QSPI register handling conditional
  arm64: dts: renesas: r9a08g045: Move max-frequency to SoC dtsi

Claudiu Beznea (22):
  i3c: renesas: Check that the transfer is valid before accessing it
  i3c: renesas: Restore STDBR and EXTBR registers on resume
  i3c: renesas: Reconfigure the DATBAS register on re-attach
  i3c: renesas: Reset the controller on resume
  i3c: renesas: Perform Dynamic Address Assignment on resume
  i3c: renesas: Clean DATBAS register on detach
  i3c: renesas: Fix out-of-bounds access for newdevs mask
  i3c: renesas: Use reset_control_bulk_{assert, deassert}()
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
  pinctrl: renesas: rzg2l: Drop defines present in struct rzg2l_hwcfg
  pinctrl: renesas: rzg2l: Generalize power source code
  pinctrl: renesas: rzg2l: Unify power source handling
  pinctrl: renesas: rzg2l: Add RZ/G3S support for selecting I3C power
    source
  arm64: dts: renesas: rzg3s-smarc-som: Enable I3C

Cristian Ciocaltea (1):
  clk: Provide devm_clk_bulk_get_all_enabled() helper

Felix Gu (2):
  i3c: master: renesas: Fix memory leak in renesas_i3c_i3c_xfers()
  i3c: master: renesas: Use __free(kfree) for xfer cleanup in
    renesas_i3c_send_ccc_cmd()

Frank Li (3):
  hwmon: (tmp108) Add NXP p3t1085 support
  hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare
    I3C support
  hwmon: (tmp108) Add support for I3C device

Geert Uytterhoeven (3):
  pinctrl: renesas: rzg2l: Fix type in .pin_config_group_get() callback
  arm64: dts: renesas: r9a08g045: Add missing hypervisor virtual timer
    IRQ
  soc: renesas: rz-sysc: Convert to common field_get() helper

Guenter Roeck (1):
  hwmon: (lm75) Hide register size differences in regmap access
    functions

Jarkko Nikula (2):
  hwmon: (lm75) Fix I3C transfer buffer pointer for incoming data
  hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module

Jonathan Cameron (1):
  hwmon: (tmp108) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()

Jorge Marques (1):
  i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()

Krzysztof Kozlowski (1):
  hwmon: (lm75) fix Wvoid-pointer-to-enum-cast warning

Kuninori Morimoto (1):
  arm64: dts: renesas: r9a08g045: Move interrupt-parent to root node

Luca Ceresoli (1):
  hwmon: (lm75) remove now-unused include

Matti Vaittinen (1):
  regulator: Add devm helpers for get and enable

Naveen Krishna Chatradhi (1):
  i3c: Correct the macro module_i3c_i2c_driver

Quynh Nguyen (1):
  arm64: dts: renesas: r9a08g045: Add I3C node

Shradha Todi (1):
  clk: Provide managed helper to get and enable bulk clocks

Stanislav Jakubek (1):
  hwmon: (tmp108) Add basic regulator support

Tommaso Merciai (5):
  i3c: renesas: Switch to clk_bulk API and store clocks in private data
  i3c: renesas: Store clock rate and reset controls in struct
    renesas_i3c
  i3c: renesas: Factor out hardware initialization to separate function
  i3c: renesas: Add suspend/resume support
  i3c: renesas: Don't register devices when ENTDAA times out

Uwe Kleine-K=C3=B6nig (1):
  i3c: Handle drivers without probe or remove callback

Wolfram Sang (12):
  bitops: add generic parity calculation for u8
  i3c: Standardize defines for specification parameters
  i3c: Add more parameters for controllers to the header
  i3c: master: Add basic driver for the Renesas I3C controller
  i3c: renesas: Simplify return statement in 'renesas_i3c_daa'
  clk: renesas: r9a08g045: Add I3C clocks and resets
  hwmon: (lm75) Add NXP P3T1755 support
  hwmon: (lm75) simplify lm75_write_config()
  hwmon: (lm75) simplify regulator handling
  hwmon: (lm75) Remove superfluous 'client' member from private struct
  hwmon: (lm75) separate probe into common and I2C parts
  hwmon: (lm75) add I3C support for P3T1755

 Documentation/hwmon/lm75.rst                  |   18 +-
 Documentation/hwmon/tmp108.rst                |    8 +
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   52 +-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   21 +-
 .../boot/dts/renesas/rzg3s-smarc-switches.h   |    4 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |    1 -
 drivers/clk/clk-devres.c                      |   41 +
 drivers/clk/renesas/r9a08g045-cpg.c           |    7 +
 drivers/hwmon/Kconfig                         |    5 +-
 drivers/hwmon/lm75.c                          |  399 ++--
 drivers/hwmon/tmp108.c                        |   81 +-
 drivers/i3c/device.c                          |    5 +
 drivers/i3c/internals.h                       |   45 +
 drivers/i3c/master.c                          |   66 +-
 drivers/i3c/master/Kconfig                    |   10 +
 drivers/i3c/master/Makefile                   |    1 +
 drivers/i3c/master/dw-i3c-master.c            |    4 +-
 drivers/i3c/master/renesas-i3c.c              | 1700 +++++++++++++++++
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  287 ++-
 drivers/regulator/devres.c                    |  164 ++
 drivers/soc/renesas/rz-sysc.c                 |    3 +-
 include/linux/bitops.h                        |   31 +
 include/linux/clk.h                           |   33 +
 include/linux/i3c/device.h                    |    3 +-
 include/linux/i3c/master.h                    |   14 +-
 include/linux/regulator/consumer.h            |   27 +
 27 files changed, 2786 insertions(+), 251 deletions(-)
 create mode 100644 drivers/i3c/master/renesas-i3c.c

--=20
2.43.0

