From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 24 May 2019 11:43:32 +0100
Subject: [cip-dev] [PATCH 4.4.y 0/2] Add SMP support to the RZ/G1C
Message-ID: <1558694614-14062-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

this series adds SMP support to the RZ/G1C SoC (a.k.a r8a77470)
specific dtsi.

Thanks,
Fab

Fabrizio Castro (2):
  dt-bindings: apmu: Document r8a77470 support
  ARM: dts: r8a77470: Add SMP support

 Documentation/devicetree/bindings/power/renesas,apmu.txt |  1 +
 arch/arm/boot/dts/r8a77470.dtsi                          | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.7.4
