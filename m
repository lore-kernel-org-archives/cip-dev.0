From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 27 Jul 2018 17:27:13 +0100
Subject: [cip-dev] [PATCH 0/3] RZ/G1 and R-Car VSP related changes
Message-ID: <1532708836-25349-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

this series backports VSP support for r8a7745 and fixes wrong
definitions in r8a7743 and r8a7791 related device trees.

There is a dependency with series:
https://lists.cip-project.org/pipermail/cip-dev/2018-July/001423.html

This work is based on top of linux-4.4.y-cip, commit
4d769b2b8749e89dfc7ea179a44f652dcfbedb37 ("PM / OPP: Move error
message to debug level").

Thanks,
Fab

Biju Das (1):
  ARM: dts: r8a7745: Add VSP support

Fabrizio Castro (2):
  ARM: dts: r8a7743: Fix vsp1 properties
  ARM: dts: r8a7791: Fix vsp1 properties

 arch/arm/boot/dts/r8a7743.dtsi |  6 +++---
 arch/arm/boot/dts/r8a7745.dtsi | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi |  6 +++---
 3 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.7.4
