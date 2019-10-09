From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  9 Oct 2019 17:19:42 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 0/2] Backport CAN-FD support for RZ/G2E
Message-ID: <1570637984-22632-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

this series backports what's required for supporting CAN-FD on the RZ/G2E.

Thanks,
Fab

Fabrizio Castro (2):
  dt-bindings: can: rcar_canfd: document r8a774c0 support
  arm64: dts: renesas: r8a774c0: Add CANFD support

 .../devicetree/bindings/net/can/rcar_canfd.txt     | 15 +++++++------
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 25 ++++++++++++++++++++++
 2 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.7.4
