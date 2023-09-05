Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84193CA0FF8
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 16:08:33 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.25953.1693930106790715139
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 09:08:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,229,1688396400"; 
   d="scan'208";a="175102610"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Sep 2023 01:08:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.194])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7C297401CC94;
	Wed,  6 Sep 2023 01:08:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 19/20] arm64: dts: renesas: rzg2lc-smarc: Enable DU and link with DSI
Date: Tue,  5 Sep 2023 17:07:36 +0100
Message-Id: <20230905160737.167877-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Sep 2023 16:08:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12961

Enable DU on RZ/G2LC SMARC EVK by linking with DSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index 6818fd49b2be..a56110b6d0d4 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -63,6 +63,7 @@ ports {
 		port@0 {
 			reg = <0>;
 			dsi0_in: endpoint {
+				remote-endpoint = <&du_out_dsi>;
 			};
 		};
 
@@ -76,6 +77,26 @@ dsi0_out: endpoint {
 	};
 };
 
+&du {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			du_out_dsi: endpoint {
+				remote-endpoint = <&dsi0_in>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+		};
+	};
+};
+
 &i2c1 {
 	adv7535: hdmi@3d {
 		compatible = "adi,adv7535";
-- 
2.25.1


