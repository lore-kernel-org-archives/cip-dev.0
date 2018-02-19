From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 19 Feb 2018 18:45:48 +0000
Subject: [cip-dev] [PATCH 0/3] Add RTC support to iwg20d
Message-ID: <1519065951-9897-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series aims at adding RTC support to the iwg20d
board from iWave.
The commits from this series backport board specific DT
support and defconfig support.

Biju Das (3):
  ARM: dts: iwg20d-q7: Add RTC support
  ARM: shmobile: Enable BQ32000 rtc in shmobile_defconfig
  ARM: multi_v7_defconfig: Enable BQ32000 RTC driver

 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 18 ++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig     |  1 +
 arch/arm/configs/shmobile_defconfig     |  1 +
 3 files changed, 20 insertions(+)

-- 
2.7.4
