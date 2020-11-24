Return-Path: <SRS0=+ms4=E6=lists.cip-project.org=bounce+64572+5844+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A7CC63777
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3784F2086A
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CjUavLfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3784F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5844+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0W3WYY4521723xVG0a6bzUKJ; Tue, 24 Nov 2020 09:11:32 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.20.1606237777285940741
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:09:42 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63738825"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Nov 2020 02:09:42 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.254])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AD3D340ABFEE;
	Wed, 25 Nov 2020 02:09:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 4/9] ARM: dts: r8a7742: Add USB-DMAC and HSUSB device nodes
Date: Tue, 24 Nov 2020 17:09:27 +0000
Message-Id: <20201124170932.13588-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
References: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wDoF7XJJGYsIoPnf889k28X5x4520388AA=
Content-Type: multipart/mixed; boundary="YFHCa2wTplGC0JBSmkYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606237892;
 bh=5F8YDx+gHyL8Ofd+KP8jHrqWBIcjk4Y4yXY96pGUaFU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=CjUavLfX8SQqPkOrP74BwopGhJn9BaSV1mOaCBf+n/lYMZxRVYE/hiPj3UsYBsXCPrT
 q711P8EYZlmSXZUYhu+CeKvxl4ZsQj/qAlV451upgqFR4n+xeJ+Y3kXYJ5+CaBMftEziR
 bDyS69F+w1+4TJe3Op40xZmMA4+eX1eD+gs=

--YFHCa2wTplGC0JBSmkYa

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b8618745829de50563470cd1e58c7ea10d6481b6 upstream.

Add USB DMAC and HSUSB device nodes on RZ/G1H SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1590356277-19993-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: changed clocks and power-domain properties, removed resets property]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index b25b719fbd2b..5c516e17ca54 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -964,6 +964,22 @@
 			status = "disabled";
 		};
 
+		hsusb: usb@e6590000 {
+			compatible = "renesas,usbhs-r8a7742",
+				     "renesas,rcar-gen2-usbhs";
+			reg = <0 0xe6590000 0 0x100>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7742_CLK_HSUSB>;
+			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+			       <&usb_dmac1 0>, <&usb_dmac1 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
+			power-domains = <&cpg_clocks>;
+			renesas,buswait = <4>;
+			phys = <&usb0 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		usbphy: usb-phy@e6590100 {
 			compatible = "renesas,usb-phy-r8a7742",
 				     "renesas,rcar-gen2-usb-phy";
@@ -985,6 +1001,32 @@
 			};
 		};
 
+		usb_dmac0: dma-controller@e65a0000 {
+			compatible = "renesas,r8a7742-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&mstp3_clks R8A7742_CLK_USBDMAC0>;
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac1: dma-controller@e65b0000 {
+			compatible = "renesas,r8a7742-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&mstp3_clks R8A7742_CLK_USBDMAC1>;
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
 		dmac0: dma-controller@e6700000 {
 			compatible = "renesas,dmac-r8a7742",
 				     "renesas,rcar-dmac";
-- 
2.17.1


--YFHCa2wTplGC0JBSmkYa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5844): https://lists.cip-project.org/g/cip-dev/message=
/5844
Mute This Topic: https://lists.cip-project.org/mt/78481726/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YFHCa2wTplGC0JBSmkYa--
