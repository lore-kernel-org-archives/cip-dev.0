Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC4CD32D83
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:34:02 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6938.1764945225571344838
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:52 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: x9WrFG+NS0yDdBexXKACoQ==
X-CSE-MsgGUID: FzyvaaePQNWmporK/4dGFw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:51 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9AD3F4179CE0;
	Fri,  5 Dec 2025 23:33:50 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 29/38] arm64: dts: renesas: r9a09g077: Add pinctrl node
Date: Fri,  5 Dec 2025 14:32:49 +0000
Message-ID: <20251205143258.13748-30-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:34:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20943

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

commit 98340bf91dd9e8f08f25364edd8819ee903c1b84 upstream.

Add pinctrl node to RZ/T2H ("R9A09G077") SoC DTSI.

Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250812200344.3253781-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 42c3b86196d68..107b7e6b71641 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -101,6 +101,19 @@ cpg: clock-controller@80280000 {
 			#power-domain-cells = <0>;
 		};
 
+		pinctrl: pinctrl@802c0000 {
+			compatible = "renesas,r9a09g077-pinctrl";
+			reg = <0 0x802c0000 0 0x10000>,
+			      <0 0x812c0000 0 0x10000>,
+			      <0 0x802b0000 0 0x10000>;
+			reg-names = "nsr", "srs", "srn";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 288>;
+			power-domains = <&cpg>;
+		};
+
 		gic: interrupt-controller@83000000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x83000000 0 0x40000>,
-- 
2.43.0


