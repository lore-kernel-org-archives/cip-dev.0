From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Mar 2019 12:13:00 +0000
Subject: [cip-dev] [PATCH 4.19.y 0/9] Add i2c/msiof support
Message-ID: <1553688789-43441-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add i2c/msiof support for RZ/G2E SoC.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series is depend on the below patch series
https://patchwork.kernel.org/patch/10865489/

Fabrizio Castro (7):
  dt-bindings: i2c: sh_mobile: Add r8a774c0 support
  i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)
  dt-bindings: i2c: rcar: Add r8a774c0 support
  arm64: dts: renesas: r8a774c0: Add I2C and IIC-DVFS support
  spi: sh-msiof: Add r8a774a1 support
  spi: sh-msiof: Add r8a774c0 support
  arm64: dts: renesas: r8a774c0: Add MSIOF nodes

Simon Horman (2):
  i2c: sh_mobile: document support for r8a77990 (R-Car E3)
  i2c: sh_mobile: add support for r8a77990 (R-Car E3)

 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   1 +
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |  10 +-
 Documentation/devicetree/bindings/spi/sh-msiof.txt |   4 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 205 +++++++++++++++++++++
 drivers/i2c/busses/i2c-sh_mobile.c                 |   2 +
 5 files changed, 220 insertions(+), 2 deletions(-)

-- 
2.7.4
