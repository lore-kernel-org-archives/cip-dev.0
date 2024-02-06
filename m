Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D0FC4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:29:16 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20190.1707222537615371048
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:29:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="196960743"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Feb 2024 21:29:10 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6C7FC4005E16;
	Tue,  6 Feb 2024 21:29:07 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 44/44] riscv: dts: renesas: rzfive-smarc: Enable the blocks which were explicitly disabled
Date: Tue,  6 Feb 2024 12:27:34 +0000
Message-Id: <20240206122734.13477-45-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:29:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14828

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
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 23 --------
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 56 -------------------
 2 files changed, 79 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index c62debc7ca7e4..433ab5c6a626c 100644
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
index c07a487c4e5ad..a8573fdfd8b12 100644
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


