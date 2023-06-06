Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884E1C7EE2A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 07:52:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.3523.1686037970188610868
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 00:52:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,219,1681138800"; 
   d="scan'208";a="162379977"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jun 2023 16:52:57 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2D9744187F12;
	Tue,  6 Jun 2023 16:52:54 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 7/8] arm64: dts: renesas: r9a07g044: Add MTU3a node
Date: Tue,  6 Jun 2023 08:52:34 +0100
Message-Id: <20230606075235.183132-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 07:52:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11848

commit 26336d66d0216b7366f80ce9fca5f98d271d43ba upstream.

Add MTU3a node to R9A07G044 (RZ/G2L) SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230417090159.191346-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index e919576dda8f..a386d434e53c 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -168,6 +168,76 @@ soc: soc {
 		#size-cells = <2>;
 		ranges;
 
+		mtu3: timer@10001200 {
+			compatible = "renesas,r9a07g044-mtu3",
+				     "renesas,rz-mtu3";
+			reg = <0 0x10001200 0 0xb00>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 173 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 176 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 180 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 181 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 182 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 183 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 185 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 186 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 191 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 192 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 198 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 201 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 202 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 204 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 206 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 207 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 211 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0",
+					  "tgiv0", "tgie0", "tgif0",
+					  "tgia1", "tgib1", "tgiv1", "tgiu1",
+					  "tgia2", "tgib2", "tgiv2", "tgiu2",
+					  "tgia3", "tgib3", "tgic3", "tgid3",
+					  "tgiv3",
+					  "tgia4", "tgib4", "tgic4", "tgid4",
+					  "tgiv4",
+					  "tgiu5", "tgiv5", "tgiw5",
+					  "tgia6", "tgib6", "tgic6", "tgid6",
+					  "tgiv6",
+					  "tgia7", "tgib7", "tgic7", "tgid7",
+					  "tgiv7",
+					  "tgia8", "tgib8", "tgic8", "tgid8",
+					  "tgiv8", "tgiu8";
+			clocks = <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		ssi0: ssi@10049c00 {
 			compatible = "renesas,r9a07g044-ssi",
 				     "renesas,rz-ssi";
-- 
2.25.1


