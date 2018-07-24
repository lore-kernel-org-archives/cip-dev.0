From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 24 Jul 2018 12:03:50 +0100
Subject: [cip-dev] [PATCH 0/3] Add CAN support to iwg22d
Message-ID: <1532430233-32277-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

this series backports CAN support for the iwg22d.
This series depends on series "Add PWM and TPU support":
https://lists.cip-project.org/pipermail/cip-dev/2018-July/001400.html

and it applies on top of branch linux-4.4.y-cip, commit
4d769b2b8749e89dfc7ea179a44f652dcfbedb37 ("PM / OPP: Move error
message to debug level").

Thanks,
Fab

Fabrizio Castro (3):
  ARM: dts: r8a7745: Add CAN[01] SoC support
  ARM: dts: iwg22d-sodimm: Add can0 support to carrier board
  ARM: dts: iwg22d-sodimm-dbhd-ca: Add can1 support to HDMI DB

 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts | 12 ++++++++
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts        | 12 ++++++++
 arch/arm/boot/dts/r8a7745.dtsi                     | 34 ++++++++++++++++++++++
 3 files changed, 58 insertions(+)

-- 
2.7.4
