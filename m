From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 24 Jul 2018 11:32:31 +0100
Subject: [cip-dev] [PATCH 0/2] Add PWM and TPU support
Message-ID: <1532428353-30716-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

this series backports PWM and TPU support for the r8a7745 SoC,
and it applies on top of branch linux-4.4.y-cip, commit
4d769b2b8749e89dfc7ea179a44f652dcfbedb37 ("PM / OPP: Move error
message to debug level").

Thanks,
Fab

Fabrizio Castro (2):
  ARM: dts: r8a7745: Add PWM SoC support
  ARM: dts: r8a7745: Add TPU support

 arch/arm/boot/dts/r8a7745.dtsi | 72 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

-- 
2.7.4
