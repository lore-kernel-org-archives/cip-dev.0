From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:05 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 00/51] Fast forward sh-pfc
Message-ID: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

v1 had build time issues on ARM with shmobile_defconfig, this series
includes the patches to fix those issues (and some cosmetic improvements
while at it).
The troublesome SoC specific pinctrl drivers are not related to the
SoCs looked after by CIP, therefore we would not be testing those
fixes on real HW.
I am not sure this series is worth applying due to the amount of untested
changes, and yet on the other hand it would facilitate future development.
I would like to hear your thoughts about this, Pavel? Chris? Biju? Ben?

v1->v2:
* add "pinctrl: sh-pfc: sh73a0: Use new macros for non-GPIO pins"
* add "pinctrl: sh-pfc: sh73a0: Add missing TO pin to tpu4_to3 group"
* add "pinctrl: sh-pfc: sh73a0: Fix fsic_spdif pin groups"
* add "pinctrl: sh-pfc: r8a7791: Fix scifb2_data_c pin group"
* add "pinctrl: sh-pfc: r8a7791: Fix VIN1 versioned groups"
* add "pinctrl: sh-pfc: r8a7791: Remove bogus marks from vin1_b_data18 group"
* add "pinctrl: sh-pfc: r8a7791: Remove bogus ctrl marks from qspi_data4_b group"
* add "pinctrl: sh-pfc: r8a7740: Add missing LCD0 marks to lcd0_data24_1 group"
* add "pinctrl: sh-pfc: r8a7740: Add missing REF125CK pin to gether_gmii group"
* add "pinctrl: sh-pfc: r8a77995: Remove unused PINMUX_IPSR_{MSEL2,PHYS}()"

Thanks,
Fab

Fabrizio Castro (2):
  pinctrl: sh-pfc: r8a7796: Move CANFD pin groups and functions
  pinctrl: sh-pfc: r8a77990: Move CANFD pin groups and functions

Geert Uytterhoeven (36):
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
  pinctrl: sh-pfc: r8a77995: Remove unused PINMUX_IPSR_{MSEL2,PHYS}()
  pinctrl: sh-pfc: r8a7740: Add missing REF125CK pin to gether_gmii
    group
  pinctrl: sh-pfc: r8a7740: Add missing LCD0 marks to lcd0_data24_1
    group
  pinctrl: sh-pfc: r8a7791: Remove bogus ctrl marks from qspi_data4_b
    group
  pinctrl: sh-pfc: r8a7791: Remove bogus marks from vin1_b_data18 group
  pinctrl: sh-pfc: r8a7791: Fix VIN1 versioned groups
  pinctrl: sh-pfc: r8a7791: Fix scifb2_data_c pin group
  pinctrl: sh-pfc: sh73a0: Fix fsic_spdif pin groups
  pinctrl: sh-pfc: sh73a0: Add missing TO pin to tpu4_to3 group
  pinctrl: sh-pfc: sh73a0: Use new macros for non-GPIO pins

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
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c     |  61 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c    | 138 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c     | 179 ++++---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c     | 119 +++--
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c     | 134 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c     | 234 +++++----
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c     | 136 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c     | 129 +++--
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 239 ++++-----
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 266 +++++-----
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 837 ++++++++++++++++---------------
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    | 254 +++++-----
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    |  73 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    |  81 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    | 395 +++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    | 106 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7203.c      | 152 +++---
 drivers/pinctrl/sh-pfc/pfc-sh7264.c      | 232 ++++-----
 drivers/pinctrl/sh-pfc/pfc-sh7269.c      | 252 +++++-----
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c      |  75 +--
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
 34 files changed, 3187 insertions(+), 2778 deletions(-)

-- 
2.7.4
