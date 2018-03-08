From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  8 Mar 2018 17:54:36 +0000
Subject: [cip-dev] [PATCH 0/3] Add SPI flash support to r8a7743
Message-ID: <1520531679-9452-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

this patch backports all that is required to add SPI flash
support to the r8a7743.

Thanks,

Fabrizio Castro (3):
  spi: rspi: Add r8a7743/5 to the compatible list
  ARM: dts: r8a7743: Add QSPI support
  ARM: dts: iwg20m: Add SPI NOR support

 Documentation/devicetree/bindings/spi/spi-rspi.txt |  5 ++++-
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              | 26 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7743.dtsi                     | 16 +++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.7.4
