From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:50 +0100
Subject: [cip-dev] [PATCH 49/86] ARM: dts: iwg22d: Use /dev/ttySC3 as debug
	console
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-50-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The BSP release from iWave uses /dev/ttySC3 as debug console, this patch
renames the alias accordingly for compatibility.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 4c1d14ce4a03af24c2bac21c4a19f17d20b4a763)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index aac84c6..1f761a4 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -16,13 +16,13 @@
 	compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745";
 
 	aliases {
-		serial0 = &scif4;
+		serial3 = &scif4;
 		ethernet0 = &avb;
 	};
 
 	chosen {
 		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = "serial0:115200n8";
+		stdout-path = "serial3:115200n8";
 	};
 };
 
-- 
2.7.4
