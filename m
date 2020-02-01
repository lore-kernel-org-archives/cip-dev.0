From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Sat,  1 Feb 2020 12:26:48 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 00/14] Renesas RZ/G2 extend peripheral
	support
Message-ID: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch series adds support for for following peripherals supported
by RZ/G2N:
1] I2C and IIC-DVFS
2] OPP's table for CPU nodes
3] Thermal zones
4] CMT and TMU

This patch series is based on linux-4.19.y-cip and all the patches in 
this series are cherry-picked from upstream.

Biju Das (12):
  dt-bindings: i2c: rcar: Add r8a774b1 support
  dt-bindings: i2c: sh_mobile: Add r8a774b1 support
  arm64: dts: renesas: r8a774b1: Add I2C and IIC-DVFS support
  arm64: dts: renesas: r8a774b1: Add OPPs table for cpu devices
  dt-bindings: thermal: rcar-gen3-thermal: Add r8a774b1 support
  thermal: rcar_gen3_thermal: Add r8a774b1 support
  arm64: dts: renesas: r8a774b1: Add RZ/G2N thermal support
  dt-bindings: timer: renesas, cmt: Document r8a774b1 CMT support
  arm64: dts: renesas: r8a774b1: Add CMT device nodes
  dt-bindings: timer: renesas: tmu: Document r8a774b1 bindings
  clk: renesas: r8a774b1: Add TMU clock
  arm64: dts: renesas: r8a774b1: Add TMU device nodes

Simon Horman (2):
  dt-bindings: i2c: rcar: Rename bindings documentation file
  dt-bindings: i2c: sh_mobile: Rename bindings documentation file

 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |  60 ----
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |  67 ----
 .../devicetree/bindings/i2c/renesas,i2c.txt        |  61 ++++
 .../devicetree/bindings/i2c/renesas,iic.txt        |  68 ++++
 .../bindings/thermal/rcar-gen3-thermal.txt         |   1 +
 .../devicetree/bindings/timer/renesas,cmt.txt      |   2 +
 .../devicetree/bindings/timer/renesas,tmu.txt      |   1 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          | 359 ++++++++++++++++++++-
 drivers/clk/renesas/r8a774b1-cpg-mssr.c            |   5 +
 drivers/thermal/rcar_gen3_thermal.c                |   4 +
 10 files changed, 500 insertions(+), 128 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-rcar.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/renesas,i2c.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/renesas,iic.txt

-- 
2.7.4
