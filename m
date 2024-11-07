Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A35D5AE79
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 09:39:53 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.68185.1730972384669747865
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 01:39:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,265,1725289200"; 
   d="scan'208";a="224141006"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Nov 2024 18:39:44 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.71])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 90A5C41D45AC;
	Thu,  7 Nov 2024 18:39:43 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip v2 4/5] arm64: dts: renesas: rzg2ul-smarc: Enable CRU, CSI support
Date: Thu,  7 Nov 2024 09:39:33 +0000
Message-ID: <20241107093934.14574-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107093934.14574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241107093934.14574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 09:39:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17199

From: Biju Das <biju.das.jz@bp.renesas.com>

commit f66d8501c94b547552cd389fb19dab2f1e63d243 upstream.

Enable CRU and CSI on RZ/G2UL SMARC EVK and tie the CSI to the OV5645
sensor using a Device Tree overlay.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240213141300.159847-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: dropped overlay support and instead directly enabled in board dts]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index a748a89c64f91..22f4dbfe15e18 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -38,11 +38,19 @@
 #define ADV7513_PARENT_I2C i2c1
 #include "rz-smarc-du-adv7513.dtsi"
 
+#define OV5645_PARENT_I2C i2c0
+#include "rz-smarc-cru-csi-ov5645.dtsi"
+
 / {
 	model = "Renesas SMARC EVK based on r9a07g043u11";
 	compatible = "renesas,smarc-evk", "renesas,r9a07g043u11", "renesas,r9a07g043";
 };
 
+&ov5645 {
+	enable-gpios = <&pinctrl RZG2L_GPIO(4, 4) GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pinctrl RZG2L_GPIO(0, 1) GPIO_ACTIVE_LOW>;
+};
+
 &pinctrl {
 	du_pins: du {
 		data {
-- 
2.43.0


