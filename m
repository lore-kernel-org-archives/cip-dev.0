From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 14:23:58 +0000
Subject: [cip-dev] [PATCH 00/18] Add RZ/G2[ME] SoC Identification/SYSC/RST
	support
Message-ID: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series aims to add SoC identification/SYSC/RST support for
RZ/G2[ME] SoCs.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.


Biju Das (8):
  dt-bindings: arm: Document RZ/G2M SoC DT bindings
  soc: renesas: Identify RZ/G2M
  arm64: Add Renesas R8A774A1 support
  arm64: defconfig: enable R8A774A1 SoC
  dt-bindings: power: Add r8a774a1 SYSC power domain definitions
  soc: renesas: rcar-sysc: Add r8a774a1 support
  soc: renesas: r8a774c0-sysc: Fix initialization order of 3DG-{A,B}
  soc: renesas: rcar-rst: Add support for RZ/G2M

Fabrizio Castro (10):
  dt-bindings: arm: Document RZ/G2E SoC DT bindings
  dt-bindings: arm: Fix RZ/G2E part number
  soc: renesas: Identify RZ/G2E
  arm64: Add Renesas R8A774C0 support
  arm64: defconfig: enable R8A774C0 SoC
  dt-bindings: power: Add r8a774c0 SYSC power domain definitions
  dt-bindings: power: rcar-sysc: Document r8a774c0 sysc
  soc: renesas: rcar-sysc: Add r8a774c0 support
  dt-bindings: reset: rcar-rst: Document r8a774c0 rst
  soc: renesas: rcar-rst: Add support for RZ/G2E

 Documentation/devicetree/bindings/arm/shmobile.txt |  4 ++
 .../bindings/power/renesas,rcar-sysc.txt           |  2 +
 .../devicetree/bindings/reset/renesas,rst.txt      |  2 +
 arch/arm64/Kconfig.platforms                       | 12 +++++
 arch/arm64/configs/defconfig                       |  2 +
 drivers/soc/renesas/Kconfig                        | 16 +++++--
 drivers/soc/renesas/Makefile                       |  2 +
 drivers/soc/renesas/r8a774a1-sysc.c                | 45 ++++++++++++++++++
 drivers/soc/renesas/r8a774c0-sysc.c                | 53 ++++++++++++++++++++++
 drivers/soc/renesas/rcar-rst.c                     |  5 +-
 drivers/soc/renesas/rcar-sysc.c                    |  6 +++
 drivers/soc/renesas/rcar-sysc.h                    |  2 +
 drivers/soc/renesas/renesas-soc.c                  | 35 +++++++++++---
 include/dt-bindings/power/r8a774a1-sysc.h          | 31 +++++++++++++
 include/dt-bindings/power/r8a774c0-sysc.h          | 25 ++++++++++
 15 files changed, 231 insertions(+), 11 deletions(-)
 create mode 100644 drivers/soc/renesas/r8a774a1-sysc.c
 create mode 100644 drivers/soc/renesas/r8a774c0-sysc.c
 create mode 100644 include/dt-bindings/power/r8a774a1-sysc.h
 create mode 100644 include/dt-bindings/power/r8a774c0-sysc.h

-- 
2.7.4
