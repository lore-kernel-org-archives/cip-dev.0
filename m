Return-Path: <SRS0=A1bT=EM=lists.cip-project.org=bounce+64572+5762+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF7C2D0A3
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:52:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A4F2087E
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="uvjyJXOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A4F2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5762+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LG2NYY4521723x2IjfLdZr6C; Fri, 06 Nov 2020 01:52:03 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.9756.1604656323253544205
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2020 01:52:03 -0800
X-IronPort-AV: E=Sophos;i="5.77,456,1596466800"; 
   d="scan'208";a="61650207"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Nov 2020 18:52:02 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BDF474266632;
	Fri,  6 Nov 2020 18:52:01 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 7/8] ARM: dts: r8a7742: Add SATA nodes
Date: Fri,  6 Nov 2020 09:51:50 +0000
Message-Id: <20201106095151.25880-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: szLJnHXm5g1MTnC4b9VyXXk1x4520388AA=
Content-Type: multipart/mixed; boundary="f3lCxZTHXD71D0V9ehg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604656323;
 bh=Cx00J0tMY3x8o+QwfI4zbfPOilejp+QkOXloQgvc5tw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=uvjyJXOKEKdeHQSg/oifrC+oN0atNbtQOP3vaK4I1Qr07uQxt08V0ZKEfyTP+OTK4PX
 S4kxdqDAmREk9/fp74TMwn6hcrLA6kI2q6m0a9n8jZwGf4/ckQF7OoWrkZ3+2ggUtk929
 nFvJliokKBASblv1kczP/5f4LVuMbu+EhFA=

--f3lCxZTHXD71D0V9ehg3

commit b9884a16398161bea177f48ddc05884741a8b944 upstream.

Add the SATA device nodes to the R8A7742 device tree.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/1589555337-5498-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: changed clocks and power-domain properties, removed resets property]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 0268c46d8f59..ae7c8cbf9f79 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -1557,6 +1557,26 @@
 			status = "disabled";
 		};
 
+		sata0: sata@ee300000 {
+			compatible = "renesas,sata-r8a7742",
+				     "renesas,rcar-gen2-sata";
+			reg = <0 0xee300000 0 0x200000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7742_CLK_SATA0>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		sata1: sata@ee500000 {
+			compatible = "renesas,sata-r8a7742",
+				     "renesas,rcar-gen2-sata";
+			reg = <0 0xee500000 0 0x200000>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7742_CLK_SATA1>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@f1001000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.17.1


--f3lCxZTHXD71D0V9ehg3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5762): https://lists.cip-project.org/g/cip-dev/message=
/5762
Mute This Topic: https://lists.cip-project.org/mt/78070987/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--f3lCxZTHXD71D0V9ehg3--
