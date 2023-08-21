Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A536EE49AE
	for <webhook@archiver.kernel.org>; Mon, 21 Aug 2023 14:38:21 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.1000.1692628685025774887
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 07:38:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,190,1684767600"; 
   d="scan'208";a="177171125"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2023 23:38:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.38])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 18F1E400754E;
	Mon, 21 Aug 2023 23:38:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/15] arm64: dts: renesas: rzg2l: Drop #address-cells from pinctrl nodes
Date: Mon, 21 Aug 2023 15:37:50 +0100
Message-Id: <20230821143759.227105-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
References: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Aug 2023 14:38:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12800

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit eafbed2a4556f90792338630ab6ddf7b2e492e8d upstream.

This fixes the below dtbs_check warning:

    arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dtb: pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must be fixed:
	[[2]] is not of type 'object'
	From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
    arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dtb: pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must be fixed:
	[[2]] is not of type 'object'
	From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
    arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dtb: pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must be fixed:
	[[2]] is not of type 'object'
	From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml

Drop #address-cells properties from pinctrl nodes as they have no
addressed child nodes.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20221107172953.63218-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Link: https://lore.kernel.org/r/20221107172953.63218-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 1 -
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 2a613b514d02..67677a4bd4c7 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -714,7 +714,6 @@ pinctrl: pinctrl@11030000 {
 			reg = <0 0x11030000 0 0x10000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			#address-cells = <2>;
 			#interrupt-cells = <2>;
 			interrupt-parent = <&irqc>;
 			interrupt-controller;
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 0f485ccf7fa0..60ad8b05948f 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -720,7 +720,6 @@ pinctrl: pinctrl@11030000 {
 			reg = <0 0x11030000 0 0x10000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			#address-cells = <2>;
 			#interrupt-cells = <2>;
 			interrupt-parent = <&irqc>;
 			interrupt-controller;
-- 
2.25.1


