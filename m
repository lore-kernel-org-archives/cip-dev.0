Return-Path: <SRS0=3D0w=EC=lists.cip-project.org=bounce+64572+5678+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F8DC5DF9D
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCA720727
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nvurma6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCA720727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5678+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qmVGYY4521723xdx2xEKCvjd; Tue, 27 Oct 2020 09:56:29 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.57.1603817786680344361
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Oct 2020 09:56:27 -0700
X-IronPort-AV: E=Sophos;i="5.77,424,1596466800"; 
   d="scan'208";a="60743172"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2020 01:56:27 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0E1F340A85CA;
	Wed, 28 Oct 2020 01:56:25 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 2/5] arm64: dts: renesas: r8a774c0: Add PCIe EP node
Date: Tue, 27 Oct 2020 16:56:19 +0000
Message-Id: <20201027165622.28777-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CqhUe8tSecDElidXc4FUr8GIx4520388AA=
Content-Type: multipart/mixed; boundary="uImj3Xs3unGer5wf64xP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603817789;
 bh=3Wi9+S7UUdPb3VzYPzvyYLGfG3Viwg+I7GuZfgSwvpQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nvurma6bJ+s3kb5fiuJtpcX+rZAGzZzGj9+HfuMiK+c0ATDei+vSobF5olEOowKtOZO
 /JFheKX0X/D/XuXkNnR2P1GhLUaYyI9awlKI9TaPpfhdoxuZ9x2hQihty8BXFHXhnocrx
 iBqF1NF1u5q/x/X0S9CHe9DCk/KYhXkFlPk=

--uImj3Xs3unGer5wf64xP

commit 0c77ecdcfcd35e97c677e49a8516a0b10c1e8fb7 upstream.

Add PCIe EP node to R8A774C0 (RZ/G2E) SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20200814173037.17822-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 7ba934c32696..44d66fcb412d 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1698,6 +1698,25 @@
 			status = "disabled";
 		};
 
+		pciec0_ep: pcie-ep@fe000000 {
+			compatible = "renesas,r8a774c0-pcie-ep",
+				     "renesas,rcar-gen3-pcie-ep";
+			reg = <0x0 0xfe000000 0 0x80000>,
+			      <0x0 0xfe100000 0 0x100000>,
+			      <0x0 0xfe200000 0 0x200000>,
+			      <0x0 0x30000000 0 0x8000000>,
+			      <0x0 0x38000000 0 0x8000000>;
+			reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 319>;
+			clock-names = "pcie";
+			resets = <&cpg 319>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		vspb0: vsp@fe960000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfe960000 0 0x8000>;
-- 
2.17.1


--uImj3Xs3unGer5wf64xP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5678): https://lists.cip-project.org/g/cip-dev/message=
/5678
Mute This Topic: https://lists.cip-project.org/mt/77842961/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--uImj3Xs3unGer5wf64xP--
