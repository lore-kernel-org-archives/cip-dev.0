Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D69C46CA0
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:25:48 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.85429.1701959138977940164
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:25:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189546059"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 23:25:42 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2C0024004BC9;
	Thu,  7 Dec 2023 23:25:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 17/25] arm64: dts: renesas: Drop ADV7535 IRQ
Date: Thu,  7 Dec 2023 14:24:54 +0000
Message-Id: <20231207142502.401651-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
References: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:25:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13890

Drop ADV7535 IRQ as the IA55 driver is not yet backported to 5.10

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 2 --
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index 37807f1bda4d..d705501e162b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -64,8 +64,6 @@ adv7535: hdmi@3d {
 		compatible = "adi,adv7535";
 		reg = <0x3d>;
 
-		interrupt-parent = <&pinctrl>;
-		interrupts = <RZG2L_GPIO(2, 1) IRQ_TYPE_EDGE_FALLING>;
 		clocks = <&osc1>;
 		clock-names = "cec";
 		avdd-supply = <&reg_1p8v>;
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index 859bc8745e66..1412df9a5786 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -80,8 +80,6 @@ adv7535: hdmi@3d {
 		compatible = "adi,adv7535";
 		reg = <0x3d>;
 
-		interrupt-parent = <&pinctrl>;
-		interrupts = <RZG2L_GPIO(43, 1) IRQ_TYPE_EDGE_FALLING>;
 		clocks = <&osc1>;
 		clock-names = "cec";
 		avdd-supply = <&reg_1p8v>;
-- 
2.25.1


