From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  9 Mar 2018 09:57:00 +0000
Subject: [cip-dev] [PATCH 0/4] Add XHCI support to r8a7743
Message-ID: <1520589424-15807-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

this series adds XHCI support to r8a7743.
The only patch that hasn't been backported is:
"usb: host: xhci-plat: Add r8a7743 support"

The reason for the new commit is that the backporting of the generic
compatible string for R-Car Gen2 would have brought along a few
unnecessary bits and pieces, a new commit seemed to address the goal
more reliably.

Thanks,

Fabrizio Castro (3):
  usb: host: xhci-plat: Add r8a7743 support
  dt-bindings: usb-xhci: Document r8a7743 support
  ARM: dts: r8a7743: Add xhci support to SoC dtsi

Simon Horman (1):
  ARM: shmobile: enable XHCI_RCAR in defconfig

 Documentation/devicetree/bindings/usb/usb-xhci.txt |  4 ++--
 arch/arm/boot/dts/r8a7743.dtsi                     | 18 ++++++++++++++++++
 arch/arm/configs/shmobile_defconfig                |  2 ++
 drivers/usb/host/xhci-plat.c                       |  7 +++++--
 4 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.7.4
