From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:39:14 +0000
Subject: [cip-dev] [PATCH 10/10] ARM: dts: iwg20d-q7: Enable USB PHY
In-Reply-To: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520249954-29357-11-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 51be0086e6d2ebb3f0ddbeedab8d7c4232c1c5f6)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index ecd7bd8..fbb5215 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -147,3 +147,7 @@
 	wp-gpios = <&gpio6 15 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
+
+&usbphy {
+	status = "okay";
+};
-- 
2.7.4
