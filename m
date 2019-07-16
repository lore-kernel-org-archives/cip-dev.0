From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 07:42:16 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 0/5] Add QSPI support
Message-ID: <1563259341-37180-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add QSPI support for iWave iwg23s sbc based on RZ/G1C.

This patch series is based on linux-4.4.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

Biju Das (4):
  dt-bindings: spi: rspi: Add r8a7744 to the compatible list
  mtd: spi-nor: Add support for is25lp016d
  ARM: dts: r8a77470: Add QSPI support
  ARM: dts: iwg23s-sbc: Add QSPI flash support

Fabrizio Castro (1):
  spi: rspi: Add r8a77470 to the compatible list

 Documentation/devicetree/bindings/spi/spi-rspi.txt |  2 ++
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          | 26 +++++++++++++++++++
 arch/arm/boot/dts/r8a77470.dtsi                    | 30 ++++++++++++++++++++++
 drivers/mtd/spi-nor/spi-nor.c                      |  2 ++
 4 files changed, 60 insertions(+)

-- 
2.7.4
