From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:07:49 +0100
Subject: [cip-dev] [PATCH  00/62] Add CAN, PCIe, VIN, Audio, PWM,
	TPU and thermal support
Message-ID: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This series aims to add support for CAN,PCIE,VIN,Audio,PWM,TPU
and thermal drivers on r8a7743 SoC.The patches in this series are 
cherry-picked from the upstream kernel.

Some of the patches in this series are bug fixes/improvements
(For eg:-SGTL5000 audio codec related patches)

This series has been tested against linux-cip tag v4.4.126-cip22.

Biju Das (17):
  dt-bindings: PCI: rcar: Add device tree support for r8a7743
  ARM: dts: r8a7743: Add default PCIe bus clock
  ARM: dts: r8a7743: Add PCIe Controller device node
  ARM: dts: iwg20d-q7: Enable PCIe Controller
  ASoC: rsnd: Add device tree support for r8a774[35]
  ARM: shmobile: defconfig: Enable SGTL5000 audio codec
  ARM: dts: r8a7743: Add audio clocks
  ARM: dts: r8a7743: Add audio DMAC support
  ARM: dts: r8a7743: Add sound support
  ARM: dts: iwg20d-q7-common: Enable SGTL5000 audio codec
  ARM: dts: iwg20d-q7-common: Sound PIO support
  ARM: dts: iwg20d-q7-common: Sound DMA support on DTS
  ARM: dts: iwg20d-q7-common: Sound DMA support via BUSIF on DTS
  ARM: dts: iwg20d-q7-common: Sound DMA support via SRC on DTS
  ARM: dts: iwg20d-q7-common: Sound DMA support via DVC on DTS
  dt-bindings: thermal: rcar: Add device tree support for r8a7743
  ARM: dts: r8a7743: Add thermal device to DT

Boris BREZILLON (1):
  pwm: rcar: Make use of pwm_is_enabled()

Clemens Gruber (1):
  ASoC: sgtl5000: Remove misleading comment

Dirk Behme (1):
  thermal: rcar_thermal: Fix priv->zone error handling

Eric Nelson (5):
  ASoC: sgtl5000: Fix regulator support
  ASoC: sgtl5000: Write all default registers
  ASoC: sgtl5000: Initialize CHIP_ANA_POWER to power-on defaults
  ASoC: sgtl5000: Disable internal PLL early
  ASoC: sgtl5000: Do not disable regulators in SND_SOC_BIAS_OFF

Fabrizio Castro (13):
  pinctrl: sh-pfc: r8a7791: Add can_clk function
  dt-bindings: can: rcar_can: document r8a774[35] can support
  ARM: dts: r8a7743: Add CAN[01] SoC support
  ARM: dts: iwg20d-q7-common: Add can0 support to carrier board
  ARM: dts: iwg20d-q7-dbcm-ca: Add can1 support to camera DB
  ARM: dts: r8a7743: add VIN dt support
  pinctrl: sh-pfc: r8a7791: Add tpu groups and function
  dt-bindings: pwm: renesas-tpu: Document r8a774[35] support
  ARM: dts: r8a7743: Add TPU support
  ARM: multi_v7_defconfig: Select PWM_RCAR as module
  ARM: shmobile: defconfig: Enable PWM
  dt-bindings: pwm: rcar: Document r8a774[35] PWM bindings
  ARM: dts: r8a7743: Add PWM SoC support

Geert Uytterhoeven (1):
  ARM: shmobile: defconfig: Enable missing support based on DTSes

Hien Dang (1):
  pwm: rcar: Use PM Runtime to control module clock

Kalle Kankare (1):
  sgtl5000: add Lineout volume control

Kuninori Morimoto (9):
  ASoC: rsnd: audio_clkout0/1/2/3 are optional properties
  ASoC: rsnd: add missing DT example for Simple Card
  ASoC: rsnd: add missing DT example for Simple Card with TDM
  thermal: rcar: move rcar_thermal_dt_ids to upside
  thermal: rcar: check every rcar_thermal_update_temp() return value
  thermal: rcar: check irq possibility in rcar_thermal_irq_xxx()
  thermal: rcar: rcar_thermal_get_temp() return error if strange temp
  thermal: rcar: enable to use thermal-zone on DT
  thermal: rcar-thermal: enable hwmon when
    thermal_zone_of_sensor_register is used

Phil Edworthy (4):
  PCI: rcar: Convert to DT resource parsing API
  PCI: rcar: Remove unused pci_sys_data struct from pcie-rcar
  PCI: rcar: Add runtime PM support to pcie-rcar
  PCI: rcar: Add Gen2 PHY setup to pcie-rcar

Ryo Kodama (1):
  pwm: rcar: Improve accuracy of frequency division setting

Sergei Shtylyov (1):
  DT: dmaengine: rcar-dmac: document R8A7743/5 support

Simon Horman (3):
  can: rcar: add gen[12] fallback compatibility strings
  PCI: rcar: Add gen2 fallback compatibility string for pcie-rcar
  dmaengine: rcar-dmac: Document SoC specific bindings

Wolfram Sang (2):
  PCI: rcar: Use proper name for the R-Car SoC
  thermal: rcar_thermal: don't open code of_device_get_match_data()

Yoshihiro Kaneko (1):
  soc_camera: rcar_vin: add R-Car Gen 2 and 3 fallback compatibility
    strings

 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |  17 +-
 .../devicetree/bindings/media/rcar_vin.txt         |  10 +-
 .../devicetree/bindings/net/can/rcar_can.txt       |  13 +-
 Documentation/devicetree/bindings/pci/rcar-pci.txt |  17 +-
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |   2 +
 .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    |   4 +-
 .../devicetree/bindings/sound/renesas,rsnd.txt     |  65 ++-
 .../devicetree/bindings/thermal/rcar-thermal.txt   |  38 +-
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            | 122 +++++-
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi           |  12 +
 arch/arm/boot/dts/r8a7743.dtsi                     | 466 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/shmobile_defconfig                |   4 +
 drivers/media/platform/soc_camera/rcar_vin.c       |   1 +
 drivers/net/can/rcar_can.c                         |   2 +
 drivers/pci/host/pcie-rcar.c                       | 199 ++++++---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               |  62 ++-
 drivers/pwm/pwm-rcar.c                             |  12 +-
 drivers/thermal/rcar_thermal.c                     | 114 +++--
 sound/soc/codecs/sgtl5000.c                        | 431 +++++--------------
 sound/soc/codecs/sgtl5000.h                        |   2 +
 21 files changed, 1149 insertions(+), 445 deletions(-)

-- 
2.7.4
