From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 15:28:04 +0100
Subject: [cip-dev] [PATCH 0/3] Add CMT support to iwg22m
Message-ID: <1532615287-1183-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

this series backports all that is required for CMT to work on the iwg22m
powered by the r8a7745.

This series depends on patch:
https://lists.cip-project.org/pipermail/cip-dev/2018-July/001408.html

and it applies on top of branch linux-4.4.y-cip, commit
4d769b2b8749e89dfc7ea179a44f652dcfbedb37 ("PM / OPP: Move error
message to debug level").

Thanks,
Fab

Benjamin Gaignard (1):
  selftests/timers: make loop consistent with array size

Fabrizio Castro (2):
  ARM: dts: r8a7745: Add CMT SoC specific support
  ARM: dts: iwg22m: Enable cmt0

 arch/arm/boot/dts/r8a7745-iwg22m.dtsi              |  4 +++
 arch/arm/boot/dts/r8a7745.dtsi                     | 32 ++++++++++++++++++++++
 .../testing/selftests/timers/clocksource-switch.c  |  2 +-
 3 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.7.4
