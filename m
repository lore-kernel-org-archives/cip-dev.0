From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 10:28:44 +0000
Subject: [cip-dev] [PATCH 0/4] Add VIN/HSCIF pin groups
Message-ID: <1553250528-42395-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add VIN/HSCIF pin groups to r8a77990/r8a774c0 PFC
driver.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series is depend on the below patch series
https://patchwork.kernel.org/project/cip-dev/list/?series=95333

Geert Uytterhoeven (1):
  pinctrl: sh-pfc: Reduce kernel size for narrow VIN channels

Jacopo Mondi (2):
  pinctrl: sh-pfc: Add optional arg to VIN_DATA_PIN_GROUP
  pinctrl: sh-pfc: r8a77990: Add VIN[4|5] groups/functions

Takeshi Kihara (1):
  pinctrl: sh-pfc: r8a77990: Add HSCIF pins, groups, and functions

 drivers/pinctrl/sh-pfc/pfc-r8a7792.c  |  16 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 666 +++++++++++++++++++++++++++++++++-
 drivers/pinctrl/sh-pfc/sh_pfc.h       |  32 +-
 4 files changed, 697 insertions(+), 21 deletions(-)

-- 
2.7.4
