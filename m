Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9489FC48295
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:43:06 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.61492.1707136962714935870
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:43:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="196827779"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Feb 2024 21:43:02 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2ECA540065B6;
	Mon,  5 Feb 2024 21:43:00 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 41/48] riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
Date: Mon,  5 Feb 2024 12:41:28 +0000
Message-Id: <20240205124135.14779-42-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:43:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14710

commit 40005cb6093e92d24a1bdbc444311c25e4b28878 upstream.

Enable CANFD and I2C on RZ/Five SMARC EVK.

Note, these blocks are enabled in RZ/G2UL SMARC EVK DTSI [0] hence
deleting these disabled nodes from RZ/Five SMARC EVK DTSI enables them
here too as we include [0] in RZ/Five SMARC EVK DTSI.

[0] arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20221115105135.1180490-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 27 -------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
index e64f0e5f8e30..c07a487c4e5a 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
@@ -7,25 +7,6 @@
 
 #include <arm64/renesas/rzg2ul-smarc.dtsi>
 
-/ {
-	aliases {
-		/delete-property/ i2c0;
-		/delete-property/ i2c1;
-	};
-};
-
-&canfd {
-	status = "disabled";
-
-	channel0 {
-		status = "disabled";
-	};
-
-	channel1 {
-		status = "disabled";
-	};
-};
-
 &ehci0 {
 	status = "disabled";
 };
@@ -38,14 +19,6 @@ &hsusb {
 	status = "disabled";
 };
 
-&i2c0 {
-	status = "disabled";
-};
-
-&i2c1 {
-	status = "disabled";
-};
-
 &ohci0 {
 	status = "disabled";
 };
-- 
2.34.1


