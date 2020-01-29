From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 29 Jan 2020 14:30:05 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 12/12] arm64: dts: renesas:
	r8a774b1-hihope-rzg2n: Enable HS400 mode
In-Reply-To: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1580308205-20435-13-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 048b39fae795c713c465b6e1d55089334535d862 upstream.

This patch enables HS400 mode on HiHope RZ/G2N board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1569837778-55874-1-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts
index 094b5ef..c9e2119 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts
@@ -24,3 +24,7 @@
 		reg = <0x4 0x80000000 0x0 0x80000000>;
 	};
 };
+
+&sdhi3 {
+	mmc-hs400-1_8v;
+};
-- 
2.7.4
