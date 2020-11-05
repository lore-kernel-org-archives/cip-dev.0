Return-Path: <SRS0=xoL2=EL=lists.cip-project.org=bounce+64572+5745+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E68C4741F
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A361220936
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sboXs8JF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A361220936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5745+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id n1ycYY4521723xAMptUomlAT; Thu, 05 Nov 2020 01:50:47 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.5243.1604569842298237083
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 01:50:46 -0800
X-IronPort-AV: E=Sophos;i="5.77,453,1596466800"; 
   d="scan'208";a="61538034"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2020 18:50:46 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4B51541572DE;
	Thu,  5 Nov 2020 18:50:45 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 4/6] arm64: dts: renesas: r8a774e1: Add USB2.0 phy and host (EHCI/OHCI) device nodes
Date: Thu,  5 Nov 2020 09:50:37 +0000
Message-Id: <20201105095039.4751-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WZXxh96WoBDB12oPAFO4FtS9x4520388AA=
Content-Type: multipart/mixed; boundary="5I0tRVk6JrXLmVw4ENtx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604569847;
 bh=dKYXEAYbFMZggSzMFEX0MnjlIBw7GAHmcGKryt3qzoI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=sboXs8JFacCB7Pv/Ic9x/r8J2z898S81Z5QF3hPj4jD0tEx5o3keHQQwbnR0f7wuI7k
 hg8Mc9qX3yD9K2Kj5EorOopcPUqoZOg0pDSNUufMrXU4sYnxn6Qce0BGY9iQIJe58kVkz
 EKAitcBFAfiK5XLuBrRUZnTnxvt3rwMpbGk=

--5I0tRVk6JrXLmVw4ENtx

commit 92b2c276e15c7f93f1148329a1f713c51b26f652 upstream.

Add USB2.0 phy and host (EHCI/OHCI) device nodes on RZ/G2H SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1594919915-5225-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 55 ++++++++++++++++++-----
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 271045556aa0..106d64a8112a 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -1468,45 +1468,76 @@
 		};
 
 		ohci0: usb@ee080000 {
+			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			phys = <&usb2_phy0 1>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		ohci1: usb@ee0a0000 {
+			compatible = "generic-ohci";
 			reg = <0 0xee0a0000 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1 1>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		ehci0: usb@ee080100 {
+			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			phys = <&usb2_phy0 2>;
+			phy-names = "usb";
+			companion = <&ohci0>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		ehci1: usb@ee0a0100 {
+			compatible = "generic-ehci";
 			reg = <0 0xee0a0100 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1 2>;
+			phy-names = "usb";
+			companion = <&ohci1>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		usb2_phy0: usb-phy@ee080200 {
+			compatible = "renesas,usb2-phy-r8a774e1",
+				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee080200 0 0x700>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
+			#phy-cells = <1>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		usb2_phy1: usb-phy@ee0a0200 {
+			compatible = "renesas,usb2-phy-r8a774e1",
+				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee0a0200 0 0x700>;
+			clocks = <&cpg CPG_MOD 702>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
+			#phy-cells = <1>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		sdhi0: mmc@ee100000 {
-- 
2.17.1


--5I0tRVk6JrXLmVw4ENtx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5745): https://lists.cip-project.org/g/cip-dev/message=
/5745
Mute This Topic: https://lists.cip-project.org/mt/78047674/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5I0tRVk6JrXLmVw4ENtx--
