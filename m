Return-Path: <SRS0=SGCD=EJ=lists.cip-project.org=bounce+64572+5719+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB56C2D0A3
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804BE22264
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vPF2GXoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804BE22264
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5719+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Xx2VYY4521723xMXN4IEOj9B; Tue, 03 Nov 2020 09:33:47 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.810.1604424820973392125
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 09:33:46 -0800
X-IronPort-AV: E=Sophos;i="5.77,448,1596466800"; 
   d="scan'208";a="61561036"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2020 02:33:46 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4F46E40061A2;
	Wed,  4 Nov 2020 02:33:45 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 06/17] arm64: dts: renesas: r8a774e1: Populate DU device node
Date: Tue,  3 Nov 2020 17:33:25 +0000
Message-Id: <20201103173336.2829-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Wq6kHE5XcTcv5HQPHIDVMjwEx4520388AA=
Content-Type: multipart/mixed; boundary="ofiHkUDYiuNDqQLKh4DY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604424827;
 bh=2MaWidJRBQKRpBWDb47zOL1nnWg4NbM1JyqIduqm4EU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vPF2GXoFYhhlJERKG9mKU2jQ3JKpMEjTMIiBYV9UN151E6nRBIGGzFVo84seHrabDfB
 8IjM9Fs7H3P308tBgYVr+yNVkxPnqYIS0VV3PltAWEDUy2yCNsTXM2kKzUL40HfZ3rn3a
 G+LYgeZbMK+mcUlpcdJabjrlXfgaodnRCL8=

--ofiHkUDYiuNDqQLKh4DY

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit f22d0550b83570b10e8f4a474d9629fd4ad76db7 upstream.

Populate the DU device node properties in R8A774E1 SoC dtsi.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20200812140217.24251-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Renamed renesas,vsps property to vsps]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 76a4d53db888..3a19ac715f04 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -1793,22 +1793,39 @@
 		};
 
 		du: display@feb00000 {
+			compatible = "renesas,du-r8a774e1";
 			reg = <0 0xfeb00000 0 0x80000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 724>,
+				 <&cpg CPG_MOD 723>,
+				 <&cpg CPG_MOD 721>;
+			clock-names = "du.0", "du.1", "du.3";
+			resets = <&cpg 724>, <&cpg 722>;
+			reset-names = "du.0", "du.3";
 			status = "disabled";
 
-			/* placeholder */
+			vsps = <&vspd0 0>, <&vspd1 0>, <&vspd0 1>;
+
 			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port@0 {
 					reg = <0>;
+					du_out_rgb: endpoint {
+					};
 				};
 				port@1 {
 					reg = <1>;
+					du_out_hdmi0: endpoint {
+					};
 				};
 				port@2 {
 					reg = <2>;
+					du_out_lvds0: endpoint {
+					};
 				};
 			};
 		};
-- 
2.17.1


--ofiHkUDYiuNDqQLKh4DY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5719): https://lists.cip-project.org/g/cip-dev/message=
/5719
Mute This Topic: https://lists.cip-project.org/mt/78011697/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ofiHkUDYiuNDqQLKh4DY--
