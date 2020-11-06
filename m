Return-Path: <SRS0=3Nwe=EM=lists.cip-project.org=bounce+64572+5763+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14777C5517A
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:52:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A63E2087E
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VlQNELBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A63E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5763+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id STrxYY4521723xnA2GE2xZzG; Fri, 06 Nov 2020 01:52:04 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web08.9517.1604656315663802830
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2020 01:52:04 -0800
X-IronPort-AV: E=Sophos;i="5.77,456,1596466800"; 
   d="scan'208";a="61866369"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2020 18:52:04 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 146FE4266632;
	Fri,  6 Nov 2020 18:52:02 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 8/8] ARM: dts: r8a7742: Add VSP support
Date: Fri,  6 Nov 2020 09:51:51 +0000
Message-Id: <20201106095151.25880-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6LJ9GsswSphiqMIqzEKhVe0px4520388AA=
Content-Type: multipart/mixed; boundary="AZd0v3TDZ0H3nq4zcImI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604656324;
 bh=oehBZAy/9B6kozRLZjCM+wPYjvJI176PyrwaDUTPXfE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VlQNELBxaezM1lipL9S+9Y9FW8+Olzyvk5APtOC0ZQqGz0r5Kuxm4FPCbxpyNduOf41
 hcDkJJcU9+ahu4jsOEul3LGvbRNoxTDzbHY/lNUm12NS0KQkqgze9mnSOmgUuxqvRw5To
 YD9v7idH/bq3AzOO5x2Dl6w59WG49EkYn2w=

--AZd0v3TDZ0H3nq4zcImI

commit a937909702e00d98eac5b91b31a7f2ae112f47bf upstream.

Add VSP support to R8A7742 (RZ/G1H) SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200911080929.15058-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: dropped resets property. changed clocks and power-domains properties.
added vsp device configuration]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index ae7c8cbf9f79..eff54f7ed812 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -1617,6 +1617,61 @@
 			status = "disabled";
 		};
 
+		vsp@fe920000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe920000 0 0x8000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7742_CLK_VSP1_R>;
+			power-domains = <&cpg_clocks>;
+
+			renesas,has-sru;
+			renesas,#rpf = <5>;
+			renesas,#uds = <1>;
+			renesas,#wpf = <4>;
+		};
+
+		vsp@fe928000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe928000 0 0x8000>;
+			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7742_CLK_VSP1_S>;
+			power-domains = <&cpg_clocks>;
+
+			renesas,has-lut;
+			renesas,has-sru;
+			renesas,#rpf = <5>;
+			renesas,#uds = <3>;
+			renesas,#wpf = <4>;
+		};
+
+		vsp@fe930000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe930000 0 0x8000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7742_CLK_VSP1_DU0>;
+			power-domains = <&cpg_clocks>;
+
+			renesas,has-lif;
+			renesas,has-lut;
+			renesas,#rpf = <4>;
+			renesas,#uds = <1>;
+			renesas,#wpf = <4>;
+		};
+
+		vsp@fe938000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe938000 0 0x8000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7742_CLK_VSP1_DU1>;
+			power-domains = <&cpg_clocks>;
+
+			renesas,has-lif;
+			renesas,has-lut;
+			renesas,#rpf = <4>;
+			renesas,#uds = <1>;
+			renesas,#wpf = <4>;
+		};
+
 		cmt0: timer@ffca0000 {
 			compatible = "renesas,cmt-48-r8a7742",
 				     "renesas,cmt-48-gen2";
-- 
2.17.1


--AZd0v3TDZ0H3nq4zcImI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5763): https://lists.cip-project.org/g/cip-dev/message=
/5763
Mute This Topic: https://lists.cip-project.org/mt/78070988/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AZd0v3TDZ0H3nq4zcImI--
