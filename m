From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 29 Jun 2018 14:58:59 +0100
Subject: [cip-dev] [PATCH  0/3] Document CMT and VIN
Message-ID: <1530280742-6540-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

This patch series aim to Document the CMT and
VIN deviced present in r8a774[35] SoC.

regards,
Biju


Fabrizio Castro (3):
  dt-bindings: timer: renesas, cmt: Document r8a774[35] CMT support
  media: dt-bindings: media: rcar_vin: Reverse SoC part number list
  media: dt-bindings: media: rcar_vin: add device tree support for
    r8a774[35]

 Documentation/devicetree/bindings/media/rcar_vin.txt    | 12 +++++++-----
 Documentation/devicetree/bindings/timer/renesas,cmt.txt |  4 ++++
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.7.4
