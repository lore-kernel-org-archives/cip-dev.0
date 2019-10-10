From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Oct 2019 07:45:12 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 0/3] Add WLAN/BT support
Message-ID: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add WLAN/BT support for HiHope RZ/G2M platform.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

Biju Das (3):
  arm64: dts: renesas: hihope-common: Add PCA9654 I/O expander
  arm64: dts: renesas: hihope-common: Add BT support
  arm64: dts: renesas: hihope-common: Add WLAN support

 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 78 ++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

-- 
2.7.4
