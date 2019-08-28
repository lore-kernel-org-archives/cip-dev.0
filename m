From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:27 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 00/41] Fast forward sh-pfc
Message-ID: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

they have made good progress upstream with the development of sh-pfc,
and although the functionality of the drivers hasn't changed much,
the code looks fairly different. This means that backporting patches
to SoC specific driver files will be increasingly hard and error
prone, unless we fast-forward the code base for 4.19.y-cip, hence
this series.
What do you gus think? Comments welcome!

Thanks,
Fab


Fabrizio Castro (2):
  pinctrl: sh-pfc: r8a7796: Move CANFD pin groups and functions
  pinctrl: sh-pfc: r8a77990: Move CANFD pin groups and functions

Geert Uytterhoeven (26):
  pinctrl: sh-pfc: Print actual field width for variable-width fields
  pinctrl: sh-pfc: Validate pinmux tables at runtime when debugging
  pinctrl: sh-pfc: Validate pins/marks in pin groups at build time
  pinctrl: sh-pfc: Make pinmux_cfg_reg.var_field_width[] variable-length
  pinctrl: sh-pfc: Validate fixed-size field widths at build time
  pinctrl: sh-pfc: Absorb enum IDs in PINMUX_CFG_REG() macro
  pinctrl: sh-pfc: Absorb enum IDs in PINMUX_CFG_REG_VAR() macro
  pinctrl: sh-pfc: Absorb enum IDs in PINMUX_DATA_REG() macro
  pinctrl: sh-pfc: Validate enum IDs for regs with fixed-width fields
  pinctrl: sh-pfc: Validate enum IDs for regs with variable-width fields
  pinctrl: sh-pfc: Improve PINMUX_IPSR_PHYS() documentation
  pinctrl: sh-pfc: Rename 2-parameter CPU_ALL_PORT() variant
  pinctrl: sh-pfc: Add SH_PFC_PIN_CFG_PULL_UP_DOWN shorthand
  pinctrl: sh-pfc: Add new non-GPIO helper macros
  pinctrl: sh-pfc: Correct printk level of group reference warning
  pinctrl: sh-pfc: Mark run-time debug code __init
  pinctrl: sh-pfc: Add check for empty pinmux groups/functions
  pinctrl: sh-pfc: Validate pin tables at runtime
  pinctrl: sh-pfc: r8a7796: Deduplicate VIN5 pin definitions
  pinctrl: sh-pfc: r8a77990: Rename IOCTRLx registers
  pinctrl: sh-pfc: Add missing #include <linux/errno.h>
  pinctrl: sh-pfc: Add PORT_GP_27 helper macro
  pinctrl: sh-pfc: Move PIN_NONE to shared header file
  pinctrl: sh-pfc: r8a77990: Use new macros for non-GPIO pins
  pinctrl: sh-pfc: r8a7796: Add TPU pins, groups and functions
  pinctrl: sh-pfc: r8a7796: Use new macros for non-GPIO pins

Jacopo Mondi (1):
  pinctrl: sh-pfc: r8a7796: Fix VIN versioned groups

Marek Vasut (1):
  pinctrl: sh-pfc: rcar-gen3: Retain TDSELCTRL register across
    suspend/resume

Takeshi Kihara (9):
  pinctrl: sh-pfc: r8a7796: Add I2C{0,3,5} pins, groups and functions
  pinctrl: sh-pfc: rcar-gen3: Remove HDMI CEC pins, groups, and
    functions
  pinctrl: sh-pfc: rcar-gen3: Remove CC5_OSCOUT pin
  pinctrl: sh-pfc: rcar-gen3: Rename SEL_ADG_{A,B,C} to SEL_ADG{A,B,C}
  pinctrl: sh-pfc: r8a77990: Fix MOD_SEL0 bit16 when using NFALE and
    NFRB_N
  pinctrl: sh-pfc: r8a77990: Fix MOD_SEL1 bit31 when using SIM0_D
  pinctrl: sh-pfc: r8a77990: Fix MOD_SEL1 bit30 when using SSI_SCK2 and
    SSI_WS2
  pinctrl: sh-pfc: rcar-gen3: Rename RTS{0,1,3,4}# pin function
    definitions
  pinctrl: sh-pfc: rcar-gen3: Rename SEL_NDFC to SEL_NDF

Ulrich Hecht (2):
  pinctrl: sh-pfc: Add physical pin multiplexing helper macros
  pinctrl: sh-pfc: r8a7796: Remove placeholder I2C pin data

 drivers/pinctrl/sh-pfc/core.c            | 172 ++++++-
 drivers/pinctrl/sh-pfc/pfc-emev2.c       |  67 +--
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c     |  66 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c     |  58 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c    | 138 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c     | 179 ++++---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c     | 119 +++--
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c     | 134 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c     | 158 +++---
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c     | 136 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c     | 129 +++--
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 239 ++++-----
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 266 +++++-----
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 837 ++++++++++++++++---------------
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    | 254 +++++-----
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    |  73 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    |  81 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    | 395 +++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    | 100 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7203.c      | 152 +++---
 drivers/pinctrl/sh-pfc/pfc-sh7264.c      | 232 ++++-----
 drivers/pinctrl/sh-pfc/pfc-sh7269.c      | 252 +++++-----
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c      |  54 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c      | 144 +++---
 drivers/pinctrl/sh-pfc/pfc-sh7722.c      | 220 ++++----
 drivers/pinctrl/sh-pfc/pfc-sh7723.c      | 200 ++++----
 drivers/pinctrl/sh-pfc/pfc-sh7724.c      | 204 ++++----
 drivers/pinctrl/sh-pfc/pfc-sh7734.c      | 142 +++---
 drivers/pinctrl/sh-pfc/pfc-sh7757.c      | 244 ++++-----
 drivers/pinctrl/sh-pfc/pfc-sh7785.c      | 136 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7786.c      |  80 +--
 drivers/pinctrl/sh-pfc/pfc-shx3.c        |  32 +-
 drivers/pinctrl/sh-pfc/pinctrl.c         |   3 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h          | 163 ++++--
 34 files changed, 3135 insertions(+), 2724 deletions(-)

-- 
2.7.4
