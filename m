From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 15:30:36 +0000
Subject: [cip-dev] [PATCH 0/7] Add RZ/G2[ME] Clock support
Message-ID: <1553182243-50724-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series aims to add pin control support for RZ/G2[ME] SoCs.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series is depend on the below patch series
https://patchwork.kernel.org/project/cip-dev/list/?series=94923

Biju Das (2):
  dt-bindings: pinctrl: sh-pfc: Document r8a774a1 PFC support
  pinctrl: sh-pfc: r8a7796: Add R8A774A1 PFC support

Fabrizio Castro (2):
  dt-bindings: pinctrl: sh-pfc: Document r8a774c0 PFC support
  pinctrl: sh-pfc: r8a77990: Add R8A774C0 PFC support

Laurent Pinchart (1):
  pinctrl: sh-pfc: r8a77990: Add DU pins, groups and function

Takeshi Kihara (2):
  pinctrl: sh-pfc: r8a77990: Add PWM pins, groups and functions
  pinctrl: sh-pfc: r8a77990: Add MSIOF pins, groups and functions

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |   2 +
 drivers/pinctrl/sh-pfc/Kconfig                     |  10 +
 drivers/pinctrl/sh-pfc/Makefile                    |   2 +
 drivers/pinctrl/sh-pfc/core.c                      |  12 +
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               | 837 ++++++++++---------
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c              | 921 +++++++++++++++++++--
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |   2 +
 7 files changed, 1310 insertions(+), 476 deletions(-)

-- 
2.7.4
