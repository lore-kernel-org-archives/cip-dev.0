Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5B2D59F50
	for <webhook@archiver.kernel.org>; Wed,  6 Nov 2024 16:03:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.49431.1730909001804501798
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Nov 2024 08:03:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,263,1725289200"; 
   d="scan'208";a="224054132"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Nov 2024 01:03:26 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.72])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 36DF7401524E;
	Thu,  7 Nov 2024 01:03:15 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 4/5] arm64: dts: renesas: rzg2ul-smarc: Enable CRU, CSI support
Date: Wed,  6 Nov 2024 16:03:06 +0000
Message-ID: <20241106160307.10263-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106160307.10263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241106160307.10263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Nov 2024 16:03:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17186

From: Biju Das <biju.das.jz@bp.renesas.com>

commit f66d8501c94b547552cd389fb19dab2f1e63d243 upstream.

Enable CRU and CSI on RZ/G2UL SMARC EVK and tie the CSI to the OV5645
sensor using a Device Tree overlay.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240213141300.159847-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: dropped overlay support and instead directly enabled in board dtsi]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index 876eb9d60f76f..e146075b707b1 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -9,6 +9,9 @@
 #include "rzg2ul-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
+#define OV5645_PARENT_I2C i2c0
+#include "rz-smarc-cru-csi-ov5645.dtsi"
+
 #if (!SW_ET0_EN_N)
 &canfd {
 	/delete-property/ pinctrl-0;
@@ -123,6 +126,11 @@ &spi1 {
 };
 #endif
 
+&ov5645 {
+	enable-gpios = <&pinctrl RZG2L_GPIO(4, 4) GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pinctrl RZG2L_GPIO(0, 1) GPIO_ACTIVE_LOW>;
+};
+
 #if (SW_ET0_EN_N && PMOD_SCI0_EN)
 &pinctrl {
 	can0-stb-hog {
-- 
2.43.0


