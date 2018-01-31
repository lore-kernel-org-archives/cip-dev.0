From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 31 Jan 2018 11:15:45 +0000
Subject: [cip-dev] [PATCH  00/10] Add SMP support for r8a7743
Message-ID: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series aims to add SMP support for r8a7743 SoC.

It is tested against linux-v4.4.112-cip18

Biju Das (4):
  ARM: shmobile: Add pm support for r8a7743
  dt-bindings: apmu: Document r8a7743 support
  ARM: dts: r8a7743: Add APMU node and second CPU core
  ARM: dts: r8a7743: Add OPP table for frequency scaling

Geert Uytterhoeven (4):
  ARM: shmobile: apmu: Move #ifdef CONFIG_SMP to cover more functions
  ARM: shmobile: apmu: Add debug resource reset for secondary CPU boot
  ARM: shmobile: apmu: Allow booting secondary CPU cores in debug mode
  ARM: dts: r8a7743: Add missing clock for secondary CA15 CPU core

Magnus Damm (2):
  ARM: shmobile: apmu: Add APMU DT support via Enable method
  devicetree: bindings: Renesas APMU and SMP Enable method

 Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
 .../devicetree/bindings/power/renesas,apmu.txt     | 29 +++++++
 arch/arm/boot/dts/r8a7743.dtsi                     | 25 ++++++
 arch/arm/mach-shmobile/platsmp-apmu.c              | 94 +++++++++++++++++++++-
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |  3 +
 5 files changed, 150 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,apmu.txt

-- 
2.7.4
