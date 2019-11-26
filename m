From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 26 Nov 2019 16:20:21 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 00/10] Add SDHI/eMMC/USB2.0 support
Message-ID: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add SDHI/eMMC/USB2.0 support for iWave iwg20d
platform based on RZ/G1N.

This patch series is based on linux-4.4.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

Biju Das (10):
  dt-bindings: mmc: renesas_sdhi: Add r8a7744 support
  mmc: renesas_sdhi: Add r8a7744 support
  ARM: dts: r8a7744: Add SDHI nodes
  dt-bindings: mmc: sh_mmcif: Document r8a7744 DT bindings
  ARM: dts: r8a7744: Add MMC node
  ARM: dts: r8a7744-iwg20m: Add eMMC support
  ARM: dts: r8a7744-iwg20m: Enable SDHI0 controller
  dt-bindings: PCI: rcar: Add device tree support for r8a7744
  ARM: dts: r8a7744: USB 2.0 host support
  ARM: dts: r8a7744: Add USB-DMAC and HSUSB device nodes

 .../devicetree/bindings/mmc/renesas,mmcif.txt      |   1 +
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   1 +
 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |   1 +
 arch/arm/boot/dts/r8a7744-iwg20m.dtsi              |  33 +++++
 arch/arm/boot/dts/r8a7744.dtsi                     | 162 ++++++++++++++++++++-
 drivers/mmc/host/sh_mobile_sdhi.c                  |   1 +
 6 files changed, 191 insertions(+), 8 deletions(-)

-- 
2.7.4
