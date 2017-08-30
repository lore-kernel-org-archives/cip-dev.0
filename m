From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 20:52:27 +0200
Subject: [cip-dev] [PATCH 0/8] Basic support for IOT2000 devices
Message-ID: <cover.1504119155.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This is the first of 3 chunks to enable the CIP kernel for the IOT2000
devices. It has the side effect of improving also the support of the
by now discontinued Galileo Gen 2 board.

Features added:
 - Ethernet MACs on IOT2000
 - TI ADC108S102 on IOT2000 and Galileo
 - I2C frequency tuning on IOT2000
 - GPIO support for pca9685 PWMs on IOT2000 and Galileo
 - interrupt support for PCAL9535 on IOT2000 and Galileo

Jan

Alison Schofield (1):
  iio: core: implement iio_device_{claim|release}_direct_mode()

Jan Kiszka (4):
  stmmac: Add support for SIMATIC IOT2000 platform
  iio: adc: Add support for TI ADC108S102 and ADC128S102
  mfd: intel_quark_i2c_gpio: Use dmi_system_id table for retrieving
    frequency
  mfd: intel_quark_i2c_gpio: Add support for SIMATIC IOT2000 platform

Mika Westerberg (1):
  pwm: pca9685: Allow any of the 16 PWMs to be used as a GPIO

Sven Van Asbroeck (1):
  pwm: pca9685: Fix GPIO-only operation

Yong Li (1):
  gpio: pca953x: add PCAL9535 interrupt support for Galileo Gen2

 .../devicetree/bindings/iio/adc/ti-adc108s102.txt  |  18 ++
 drivers/gpio/gpio-pca953x.c                        |  42 ++-
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-adc108s102.c                    | 348 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |  39 +++
 drivers/mfd/intel_quark_i2c_gpio.c                 |  49 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |  26 +-
 drivers/pwm/pwm-pca9685.c                          | 248 +++++++++++++--
 include/linux/iio/iio.h                            |   2 +
 10 files changed, 743 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
 create mode 100644 drivers/iio/adc/ti-adc108s102.c

-- 
2.12.3
