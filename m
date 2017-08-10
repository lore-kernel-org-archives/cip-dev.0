From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Aug 2017 14:14:53 +0100
Subject: [cip-dev] [PATCH  00/11] Add Pinctrl support for r8a7743
Message-ID: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This series aims to add Pinctrl support for r8a7743.
All the patches in this series are cherry-picked from 
upstream kernel

Geert Uytterhoeven (3):
  pinctrl: sh-pfc: Add PINMUX_SINGLE()
  pinctrl: sh-pfc: r8a7791: Use PINMUX_SINGLE() instead of raw
    PINMUX_DATA()
  pinctrl: sh-pfc: r8a7791: Add SCIF_CLK support

Jacopo Mondi (1):
  pinctrl: sh-pfc: r8a7791: Add ADI pinconf support

Sergei Shtylyov (7):
  pinctrl: sh-pfc: r8a7791: add EtherAVB pin groups
  pinctrl: sh-pfc: r8a7791: Add missing HSCIF1 pinmux data
  pinctrl: sh-pfc: r8a7791: Add missing DVC_MUTE signal
  pinctrl: sh-pfc: r8a7791: Fix SCIF2 pinmux data
  pinctrl: sh-pfc: r8a7791: Fix IPSR comment typos
  pinctrl: sh-pfc: r8a7791: Grand I2C rename
  pinctrl: sh-pfc: r8a7791: Add R8A7743 support

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
 drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
 drivers/pinctrl/sh-pfc/Makefile                    |    1 +
 drivers/pinctrl/sh-pfc/core.c                      |    6 +
 drivers/pinctrl/sh-pfc/core.h                      |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               | 1558 ++++++++++++--------
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |    8 +
 7 files changed, 928 insertions(+), 652 deletions(-)

-- 
1.9.1
