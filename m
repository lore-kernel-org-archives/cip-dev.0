From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Tue, 23 Oct 2018 15:30:33 +0100
Subject: [cip-dev] [PATCH 0/2] Add PMU support to iwg2[02]m
Message-ID: <1540305035-22457-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Backport PMU support for iwg2[02]m to the CIP Kernel from mainline.

Removed [Backported to CIP] from original patches

Geert Uytterhoeven (2):
  ARM: dts: r8a7745: Add PMU device node
  ARM: dts: r8a7743: Add PMU device node

 arch/arm/boot/dts/r8a7743.dtsi | 7 +++++++
 arch/arm/boot/dts/r8a7745.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)

-- 
2.7.4
