From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Fri, 24 Jan 2020 22:58:24 +0000
Subject: [cip-dev] [ANNOUNCE] Release v4.19.98-cip19
Message-ID: <OSAPR01MB3667581C3EC9ECC618FF022F920E0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

CIP kernel team has released Linux kernel v4.19.98-cip19.
The linux-4.19.y-cip tree has been updated base version from v4.19.94 to v4.19.98, and rcar_can and r8a774c0 fixes have been backported.

You can get this release via the git tree at:

  v4.19.98-cip19:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      d09ea3a7c812da413d827ff96dfe69ea42a5d144
    added commits:
      CIP: Bump version suffix to -cip19 after merge from stable
      arm64: dts: renesas: r8a774c0: cat874: Sort nodes
      arm64: dts: renesas: Use ip=on for bootargs
      arm64: dts: renesas: r8a774c0: cat874: Add definition for 12V regulator
      arm64: dts: renesas: Update 'vsps' properties for readability
      arm64: dts: renesas: r8a774c0: Fix register range of display node
      arm64: dts: renesas: r8a774c0: Add missing assigned-clocks for CAN[01]
      arm64: dts: renesas: r8a774c0: Clean up CPU compatibles
      arm64: dts: renesas: r8a774c0: Add dynamic power coefficient
      arm64: dts: renesas: r8a774c0: Create thermal zone to support IPA
      thermal: rcar_thermal: update calculation formula for R-Car Gen3 SoCs
      dt-bindings: can: rcar_can: Complete documentation for RZ/G2[EM]
      dt-bindings: can: rcar_can: document r8a77965 support

Best regards,
   Nobuhiro
