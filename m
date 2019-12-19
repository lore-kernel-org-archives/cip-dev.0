From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Thu, 19 Dec 2019 15:05:49 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 0/3] Add DU support
Message-ID: <1576767952-15873-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add DU support for iWave iwg20d platform based on RZ/G1N.

This patch series is based on linux-4.4.y-cip and all the patches in this series are cherry-picked from upstream.

Biju Das (3):
  dt-bindings: display: renesas: du: Document the r8a7744 bindings
  drm: rcar-du: Add R8A7744 support
  ARM: dts: r8a7744: Add DU support

 Documentation/devicetree/bindings/display/renesas,du.txt |  2 ++
 arch/arm/boot/dts/r8a7744.dtsi                           | 10 +++++++++-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c                    |  3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.7.4
