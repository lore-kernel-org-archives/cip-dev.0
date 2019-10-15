From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 15 Oct 2019 11:42:35 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 0/2] Add WLAN/BT
Message-ID: <1571136157-56249-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add WLAN/BT support for EK874 platform.

This patch series is based on linux-4.19.y-cip and all the patches in this series are cherry-picked from linux rc tree.

Biju Das (2):
  arm64: dts: renesas: cat874: Add WLAN support
  arm64: dts: renesas: cat874: Add BT support

 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 57 +++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

-- 
2.7.4
