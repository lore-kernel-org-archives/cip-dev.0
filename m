From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Mar 2019 08:32:33 +0000
Subject: [cip-dev] [PATCH 4.19.y 0/4] Add PCIe support to EK874
Message-ID: <1553848357-30592-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

This series adds PCIe support to the EK874 board.

Thanks,
Fab

Biju Das (2):
  arm64: dts: renesas: r8a774c0-cat874: Add pciec0 support
  arm64: dts: renesas: cat875: Enable PCIe support

Fabrizio Castro (2):
  dt-bindings: PCI: rcar: Add device tree support for r8a774c0
  arm64: dts: renesas: r8a774c0: Add PCIe device node

 Documentation/devicetree/bindings/pci/rcar-pci.txt |  4 +++-
 arch/arm64/boot/dts/renesas/cat875.dtsi            |  4 ++++
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    |  9 ++++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 27 ++++++++++++++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.7.4
