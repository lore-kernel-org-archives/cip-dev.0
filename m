From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:47:59 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 0/4] Add CAN support
Message-ID: <1563198483-8589-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add CAN support to CAT875 sub board.
Also it fixes cpu node style.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series is depend on the below patch series
https://patchwork.kernel.org/project/cip-dev/list/?series=145919

Biju Das (1):
  arm64: dts: renesas: r8a774c0: Add CAN nodes

Fabrizio Castro (3):
  arm64: dts: renesas: r8a774c0: Fix cpu nodes style
  arm64: dts: renesas: r8a774c0: Add clkp2 clock to CAN nodes
  arm64: dts: renesas: cat875: Add CAN support

 arch/arm64/boot/dts/renesas/cat875.dtsi   | 22 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 32 +++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.7.4
