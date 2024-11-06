Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4EED59F4D
	for <webhook@archiver.kernel.org>; Wed,  6 Nov 2024 16:03:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.49214.1730909007130819666
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Nov 2024 08:03:28 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,263,1725289200"; 
   d="scan'208";a="228042921"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Nov 2024 01:03:26 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.72])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1804C4015A38;
	Thu,  7 Nov 2024 01:03:17 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 5/5] arm64: dts: renesas: rzg2lc-smarc: Enable CRU, CSI support
Date: Wed,  6 Nov 2024 16:03:07 +0000
Message-ID: <20241106160307.10263-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106160307.10263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241106160307.10263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Nov 2024 16:03:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17190

commit 0c63a51990872d3396f144fea41155c89a0f1a93 upstream.

Enable CRU, CSI on RZ/G2LC SMARC EVK and tie the CSI to the OV5645 sensor
using Device Tree overlay.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230413114016.16068-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: dropped overlay support and instead directly enabled in board dtsi]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index 377849cbb462e..47b5013b984e3 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -11,6 +11,9 @@
 #include "rzg2lc-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
+#define OV5645_PARENT_I2C i2c0
+#include "rz-smarc-cru-csi-ov5645.dtsi"
+
 / {
 	aliases {
 		serial1 = &scif1;
@@ -176,6 +179,11 @@ &spi1 {
 };
 #endif
 
+&ov5645 {
+	enable-gpios = <&pinctrl RZG2L_GPIO(0, 1) GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pinctrl RZG2L_GPIO(5, 2) GPIO_ACTIVE_LOW>;
+};
+
 /*
  * To enable SCIF1 (SER0) on PMOD1 (CN7), On connector board
  * SW1 should be at position 2->3 so that SER0_CTS# line is activated
-- 
2.43.0


