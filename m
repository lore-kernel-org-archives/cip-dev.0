Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BDEC46CCD
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 23:08:04 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.34666.1703113663252296316
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Dec 2023 15:07:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,292,1695654000"; 
   d="scan'208";a="191072774"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Dec 2023 08:07:59 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.50])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4BC3040BF9EC;
	Thu, 21 Dec 2023 08:07:57 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 30/30] riscv: dts: renesas: rzfive-smarc: Enable the blocks which were explicitly disabled
Date: Wed, 20 Dec 2023 23:06:46 +0000
Message-Id: <20231220230646.219816-31-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Dec 2023 23:08:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14166

commit bfef0760d247550318a4a4a71ae472875caf711c upstream.

Now that noncoherent dma support for the RZ/Five SoC has been added, enable
the IP blocks which were disabled on the RZ/Five SMARC.  This adds
support for the below peripherals:
  * Ethernet
  * DMAC
  * SDHI
  * USB
  * RSPI
  * SSI

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929000704.53217-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 23 --------
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 56 -------------------
 2 files changed, 79 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index c62debc7ca7e..433ab5c6a626 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -7,25 +7,8 @@
 
 #include <arm64/renesas/rzg2ul-smarc-som.dtsi>
 
-/ {
-	aliases {
-		/delete-property/ ethernet0;
-		/delete-property/ ethernet1;
-	};
-
-	chosen {
-		bootargs = "ignore_loglevel";
-	};
-};
-
-&dmac {
-	status = "disabled";
-};
-
 #if (!SW_ET0_EN_N)
 &eth0 {
-	status = "disabled";
-
 	phy0: ethernet-phy@7 {
 		/delete-property/ interrupt-parent;
 		/delete-property/ interrupts;
@@ -34,14 +17,8 @@ phy0: ethernet-phy@7 {
 #endif
 
 &eth1 {
-	status = "disabled";
-
 	phy1: ethernet-phy@7 {
 		/delete-property/ interrupt-parent;
 		/delete-property/ interrupts;
 	};
 };
-
-&sdhi0 {
-	status = "disabled";
-};
diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
index c07a487c4e5a..a8573fdfd8b1 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
@@ -6,59 +6,3 @@
  */
 
 #include <arm64/renesas/rzg2ul-smarc.dtsi>
-
-&ehci0 {
-	status = "disabled";
-};
-
-&ehci1 {
-	status = "disabled";
-};
-
-&hsusb {
-	status = "disabled";
-};
-
-&ohci0 {
-	status = "disabled";
-};
-
-&ohci1 {
-	status = "disabled";
-};
-
-&phyrst {
-	status = "disabled";
-};
-
-&sdhi1 {
-	status = "disabled";
-};
-
-&snd_rzg2l {
-	status = "disabled";
-};
-
-&spi1 {
-	status = "disabled";
-};
-
-&ssi1 {
-	status = "disabled";
-};
-
-&usb0_vbus_otg {
-	status = "disabled";
-};
-
-&usb2_phy0 {
-	status = "disabled";
-};
-
-&usb2_phy1 {
-	status = "disabled";
-};
-
-&vccq_sdhi1 {
-	status = "disabled";
-};
-- 
2.34.1


