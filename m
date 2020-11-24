Return-Path: <SRS0=xakn=E6=lists.cip-project.org=bounce+64572+5842+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACEBC2D0E4
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3591620857
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="FDl39wRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3591620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5842+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XyGiYY4521723xXIdqZgQO9v; Tue, 24 Nov 2020 09:11:32 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.20.1606237777285940741
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:09:38 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63738819"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Nov 2020 02:09:38 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.254])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EB0B440ABFEE;
	Wed, 25 Nov 2020 02:09:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 2/9] ARM: dts: r8a7742: Add USB 2.0 host support
Date: Tue, 24 Nov 2020 17:09:25 +0000
Message-Id: <20201124170932.13588-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
References: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VLTQ4eZe3bdDxiIidg8tuyoNx4520388AA=
Content-Type: multipart/mixed; boundary="SUIZxoHq9N0uMsVrYITU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606237892;
 bh=MFFJs+oJbGoRa4dXYw2TAFp5hfnNUU7Bj252kg2iEvo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=FDl39wRbhfABfCu/2eNN+hLdItOkT7Yp8qVXRGb9WfO5Ed6XcudXKoUA3KIc3bfKjLd
 kAelXfLgqw/tZ2GAbBpV9C5wFmu7fJd5y3pUJTluWLP4IIaAUR94HVWcvF0SQZ1OTFm7A
 Old46DSKz5yqWoefCCboMzPYLvOBXNYfKok=

--SUIZxoHq9N0uMsVrYITU

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 4bb19c91d38e36b81e92de3d9b4e61d9b8928b54 upstream.

Describe internal PCI bridge devices, USB phy device and
link PCI USB devices to USB phy.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1590356277-19993-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: changed clocks and power-domain properties, removed resets property]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 111 +++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index d326602bee3f..b25b719fbd2b 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -964,6 +964,27 @@
 			status = "disabled";
 		};
 
+		usbphy: usb-phy@e6590100 {
+			compatible = "renesas,usb-phy-r8a7742",
+				     "renesas,rcar-gen2-usb-phy";
+			reg = <0 0xe6590100 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&mstp7_clks R8A7742_CLK_HSUSB>;
+			clock-names = "usbhs";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+
+			usb0: usb-channel@0 {
+				reg = <0>;
+				#phy-cells = <1>;
+			};
+			usb2: usb-channel@2 {
+				reg = <2>;
+				#phy-cells = <1>;
+			};
+		};
+
 		dmac0: dma-controller@e6700000 {
 			compatible = "renesas,dmac-r8a7742",
 				     "renesas,rcar-dmac";
@@ -1549,6 +1570,96 @@
 			dma-channels = <13>;
 		};
 
+		pci0: pci@ee090000 {
+			compatible = "renesas,pci-r8a7742",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee090000 0 0xc00>,
+			      <0 0xee080000 0 0x1100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7742_CLK_EHCI>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+
+			bus-range = <0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
+			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					<0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb@1,0 {
+				reg = <0x800 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
+
+			usb@2,0 {
+				reg = <0x1000 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
+		};
+
+		pci1: pci@ee0b0000 {
+			compatible = "renesas,pci-r8a7742",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee0b0000 0 0xc00>,
+			      <0 0xee0a0000 0 0x1100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7742_CLK_EHCI>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+
+			bus-range = <1 1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x02000000 0 0xee0a0000 0 0xee0a0000 0 0x00010000>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
+			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0800 0 0 1 &gic GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+					<0x1000 0 0 2 &gic GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pci2: pci@ee0d0000 {
+			compatible = "renesas,pci-r8a7742",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			clocks = <&mstp7_clks R8A7742_CLK_EHCI>;
+			power-domains = <&cpg_clocks>;
+			reg = <0 0xee0d0000 0 0xc00>,
+			      <0 0xee0c0000 0 0x1100>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+
+			bus-range = <2 2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
+			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+					<0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb@1,0 {
+				reg = <0x20800 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
+
+			usb@2,0 {
+				reg = <0x21000 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
+		};
+
 		sdhi0: mmc@ee100000 {
 			compatible = "renesas,sdhi-r8a7742",
 				     "renesas,rcar-gen2-sdhi";
-- 
2.17.1


--SUIZxoHq9N0uMsVrYITU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5842): https://lists.cip-project.org/g/cip-dev/message=
/5842
Mute This Topic: https://lists.cip-project.org/mt/78481724/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SUIZxoHq9N0uMsVrYITU--
