From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  1 Feb 2018 13:46:22 +0000
Subject: [cip-dev] [PATCH  0/7] Add i2c/iic support for r8a7743
Message-ID: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series aims to add i2c/iic support for r8a7743 SoC.

Backported dt-bindings patch
Backported per-Generation fallbacks

It is tested against linux-v4.4.112-cip18

This patch depends on the below patch series
https://lists.cip-project.org/pipermail/cip-dev/2018-January/000820.html

Biju Das (4):
  dt-bindings: i2c: Document r8a7743/5 support
  ARM: dts: r8a7743: Add I2C DT support
  dt-bindings: i2c: sh_mobile: Document r8a7743/5 support
  ARM: dts: r8a7743: Add IIC cores to dtsi

Geert Uytterhoeven (1):
  dt-bindings: i2c: Spelling s/propoerty/property/

Simon Horman (2):
  i2c: rcar: Add per-Generation fallback bindings
  i2c: sh_mobile: Add per-Generation fallback bindings

 Documentation/devicetree/bindings/i2c/i2c-imx.txt  |   2 +-
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |  35 ++++--
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |  20 ++-
 Documentation/devicetree/bindings/i2c/i2c-sirf.txt |   2 +-
 arch/arm/boot/dts/r8a7743.dtsi                     | 137 +++++++++++++++++++++
 drivers/i2c/busses/i2c-rcar.c                      |   5 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |   4 +-
 7 files changed, 186 insertions(+), 19 deletions(-)

-- 
2.7.4
