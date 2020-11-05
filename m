Return-Path: <SRS0=fFn6=EL=lists.cip-project.org=bounce+64572+5746+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC57C00A89
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106DC2083B
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TzCET0ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106DC2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5746+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id t0RvYY4521723xPLsjnKFm2N; Thu, 05 Nov 2020 01:50:48 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.5373.1604569843133406010
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 01:50:48 -0800
X-IronPort-AV: E=Sophos;i="5.77,453,1596466800"; 
   d="scan'208";a="61754460"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Nov 2020 18:50:47 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9AF70425F28E;
	Thu,  5 Nov 2020 18:50:46 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 5/6] arm64: dts: renesas: r8a774e1: Add USB3.0 device nodes
Date: Thu,  5 Nov 2020 09:50:38 +0000
Message-Id: <20201105095039.4751-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WEGVksvTlwSXvvdPD05VHR4ix4520388AA=
Content-Type: multipart/mixed; boundary="n0VPw6cBp12PQzMgvNN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604569848;
 bh=Nn7smA53dCzF+OYpXeBRBSUNWzhL2uubx91OOI9WJmQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=TzCET0ceGpz7ti+nZkbCSIbQdN2PnphWIfHGwOaj7+QTLIHLnWFOBNtGfqomedIT6vn
 Cbm91k72PYVYx08RjgSppFnnr2oZ6XWDXb1BM+OOM1dRAfmb+nxgsLre0CGgg9g6Pn8/s
 RTBRle1g42cySpUnSawwqiAwrJYkSpVGhmk=

--n0VPw6cBp12PQzMgvNN0

commit 0faf5f952b4ec26a9b7ed5f537403e7fd32f57d5 upstream.

Add usb3.0 phy, host and function device nodes on RZ/G2H SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1594919915-5225-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 25 +++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 106d64a8112a..015ab4024cb4 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -845,11 +845,16 @@
 		};
 
 		usb3_phy0: usb-phy@e65ee000 {
+			compatible = "renesas,r8a774e1-usb3-phy",
+				     "renesas,rcar-gen3-usb3-phy";
 			reg = <0 0xe65ee000 0 0x90>;
+			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
+				 <&usb_extal_clk>;
+			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
 			#phy-cells = <0>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		dmac0: dma-controller@e6700000 {
@@ -1454,17 +1459,25 @@
 		};
 
 		xhci0: usb@ee000000 {
+			compatible = "renesas,xhci-r8a774e1",
+				     "renesas,rcar-gen3-xhci";
 			reg = <0 0xee000000 0 0xc00>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		usb3_peri0: usb@ee020000 {
+			compatible = "renesas,r8a774e1-usb3-peri",
+				     "renesas,rcar-gen3-usb3-peri";
 			reg = <0 0xee020000 0 0x400>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		ohci0: usb@ee080000 {
-- 
2.17.1


--n0VPw6cBp12PQzMgvNN0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5746): https://lists.cip-project.org/g/cip-dev/message=
/5746
Mute This Topic: https://lists.cip-project.org/mt/78047675/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--n0VPw6cBp12PQzMgvNN0--
