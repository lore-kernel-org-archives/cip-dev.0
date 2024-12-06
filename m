Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0276E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:12:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.33214.1733476339182225697
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:12:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: ryz8P0/sQd2E3PvipGfpzQ==
X-CSE-MsgGUID: EI7dE3PnQ+CpKDnyafeaPA==
X-IronPort-AV: E=Sophos;i="6.12,213,1728918000"; 
   d="scan'208";a="231085785"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Dec 2024 18:12:18 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1B14941F6ADC;
	Fri,  6 Dec 2024 18:11:53 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 16/16] arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition table for spi-nor flash
Date: Fri,  6 Dec 2024 09:11:22 +0000
Message-ID: <20241206091122.67133-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:12:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17359

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 91dcdfbc5b770d4501b1a30d087affc9ed4fa6e5 upstream.

Update partition table for spi-nor flash, so that we can flash bootloaders
in Linux by executing the below commands:
flash_erase /dev/mtd0  0 0
flash_erase /dev/mtd1  0 0
mtd_debug write /dev/mtd0 0 ${BL2_FILE_SIZE} ${BL2_IMAGE}
mtd_debug write /dev/mtd1 512 ${FIP_FILE_SIZE} ${FIP_IMAGE}

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241004173235.74307-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi  | 15 +++++++++++----
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi | 15 +++++++++++----
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index 547859c388ce..46673bf41e9b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -318,11 +318,18 @@ partitions {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			boot@0 {
-				reg = <0x00000000 0x2000000>;
-				read-only;
+			partition@0 {
+				label = "bl2";
+				reg = <0x00000000 0x0001d000>;
 			};
-			user@2000000 {
+
+			partition@1d000 { /* fip is at offset 0x200 */
+				label = "fip";
+				reg = <0x0001d000 0x1fe3000>;
+			};
+
+			partition@2000000 {
+				label = "user";
 				reg = <0x2000000 0x2000000>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
index 5e4209d6fb42..8f733a5e911b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -248,11 +248,18 @@ partitions {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			boot@0 {
-				reg = <0x00000000 0x2000000>;
-				read-only;
+			partition@0 {
+				label = "bl2";
+				reg = <0x00000000 0x0001d000>;
 			};
-			user@2000000 {
+
+			partition@1d000 { /* fip is at offset 0x200 */
+				label = "fip";
+				reg = <0x0001d000 0x1fe3000>;
+			};
+
+			partition@2000000 {
+				label = "user";
 				reg = <0x2000000 0x2000000>;
 			};
 		};
-- 
2.43.0


