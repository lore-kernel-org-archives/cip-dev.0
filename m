From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  8 Mar 2018 17:28:05 +0000
Subject: [cip-dev] [PATCH 0/4] Add MSIOF support to r8a7743
Message-ID: <1520530089-4988-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

this series backports all that is required to add MSIOF support
to r8a7743.

Thanks,

Fabrizio Castro (3):
  spi: sh-msiof: Add compatible strings for r8a774[35]
  spi: sh-msiof: Add r8a774[35] to the compatible list
  ARM: dts: r8a7743: Add MSIOF[012] support

Simon Horman (1):
  spi: sh-msiof: Add R-Car Gen 2 and 3 fallback bindings

 Documentation/devicetree/bindings/spi/sh-msiof.txt | 18 +++++---
 arch/arm/boot/dts/r8a7743.dtsi                     | 48 ++++++++++++++++++++++
 drivers/spi/spi-sh-msiof.c                         |  5 ++-
 3 files changed, 65 insertions(+), 6 deletions(-)

-- 
2.7.4
