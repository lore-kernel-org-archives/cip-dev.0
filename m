From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 20 Nov 2019 16:47:20 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 6/6] ARM: dts: iwg23s-sbc: Enable cmt0
In-Reply-To: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
References: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574268440-33507-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b5079d767b881b0f516df6627e0c4297137fa5d0 upstream.

This patch enables cmt0 support on the iWave iwg23s sbc.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
index 6cae910..8c9c312d 100644
--- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -44,6 +44,10 @@
 	};
 };
 
+&cmt0 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
-- 
2.7.4
