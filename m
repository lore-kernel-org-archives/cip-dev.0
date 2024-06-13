Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51061C27C79
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 10:47:52 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5253.1718275650054850559
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 03:47:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="scan'208";a="211744462"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Jun 2024 19:47:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.168])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A2AC0400B9F8;
	Thu, 13 Jun 2024 19:47:43 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 7/7] arm64: dts: renesas: r9a07g0{43,44,54}: Update RZ/G2L family compatible
Date: Thu, 13 Jun 2024 11:47:26 +0100
Message-Id: <20240613104726.422783-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613104726.422783-1-biju.das.jz@bp.renesas.com>
References: <20240613104726.422783-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 10:47:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16217

commit 3bfe384f6f4f7433103ffcc36e7a7106f7e70c4e upstream.

The number of pipe buffers on RZ/G2L family SoCs is 10, whereas on RZ/A2M
it is 16. Replace 'renesas,rza2m-usbhs->renesas,rzg2l-usbhs' as family SoC
compatible to handle this difference and use the SoC specific compatible
in driver to avoid the ABI breakage with older DTB.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240319105356.87287-7-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 8721f4c9fa0f..766c54b91acc 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -812,7 +812,7 @@ usb2_phy1: usb-phy@11c70200 {
 
 		hsusb: usb@11c60000 {
 			compatible = "renesas,usbhs-r9a07g043",
-				     "renesas,rza2-usbhs";
+				     "renesas,rzg2l-usbhs";
 			reg = <0 0x11c60000 0 0x10000>;
 			interrupts = <SOC_PERIPHERAL_IRQ(100) IRQ_TYPE_EDGE_RISING>,
 				     <SOC_PERIPHERAL_IRQ(101) IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 9115d2ced33a..1ec12470c171 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -1092,7 +1092,7 @@ usb2_phy1: usb-phy@11c70200 {
 
 		hsusb: usb@11c60000 {
 			compatible = "renesas,usbhs-r9a07g044",
-				     "renesas,rza2-usbhs";
+				     "renesas,rzg2l-usbhs";
 			reg = <0 0x11c60000 0 0x10000>;
 			interrupts = <GIC_SPI 100 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 769e87aa6886..ea1aba78335d 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1099,7 +1099,7 @@ usb2_phy1: usb-phy@11c70200 {
 
 		hsusb: usb@11c60000 {
 			compatible = "renesas,usbhs-r9a07g054",
-				     "renesas,rza2-usbhs";
+				     "renesas,rzg2l-usbhs";
 			reg = <0 0x11c60000 0 0x10000>;
 			interrupts = <GIC_SPI 100 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.25.1


