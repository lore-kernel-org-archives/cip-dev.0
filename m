From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 14:55:37 +0100
Subject: [cip-dev] [PATCH 4.19y 00/10] Pinctrl driver updates for RZ/G2E
Message-ID: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

this series backports the latest commits for the pinctrl driver
for the RZ/G2E (a.k.a. r8a774c0).

This series depends on:
https://patchwork.kernel.org/project/cip-dev/list/?series=95351

Thanks,
Fab

Geert Uytterhoeven (3):
  pinctrl: sh-pfc: r8a77990: Fix IOCTRL reg state after s2ram on R-Car
    E3
  pinctrl: sh-pfc: r8a77990: Fix MOD_SEL0 SEL_I2C1 field width
  pinctrl: sh-pfc: r8a77990: GP6_9 does not have pull-down capability

Takeshi Kihara (7):
  pinctrl: sh-pfc: r8a77990: Add CAN pins, groups and functions
  pinctrl: sh-pfc: r8a77990: Add CAN FD pins, groups and functions
  pinctrl: sh-pfc: r8a77990: Fix MOD_SEL0 bit3 when using TX0
  pinctrl: sh-pfc: r8a77990: Fix MOD_SEL0 bit2 when using RX2, TX2 and
    SCK2
  pinctrl: sh-pfc: r8a77990: Fix MOD_SEL bit numbering
  pinctrl: sh-pfc: r8a77990: Add TMU pins, groups and functions
  pinctrl: sh-pfc: r8a77990: Add DRIF pins, groups and functions

 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 448 ++++++++++++++++++++++++++++++++--
 1 file changed, 422 insertions(+), 26 deletions(-)

-- 
2.7.4
