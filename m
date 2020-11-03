Return-Path: <SRS0=ERG8=EJ=lists.cip-project.org=bounce+64572+5716+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B385AC388F9
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEB822226
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="eIaLR4qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEB822226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5716+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZmA0YY4521723xN8fbOlhDFe; Tue, 03 Nov 2020 09:33:43 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.810.1604424820973392125
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 09:33:42 -0800
X-IronPort-AV: E=Sophos;i="5.77,448,1596466800"; 
   d="scan'208";a="61561025"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2020 02:33:42 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5B4924009F88;
	Wed,  4 Nov 2020 02:33:41 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 03/17] arm64: dts: renesas: r8a774e1: Add FDP1 device nodes
Date: Tue,  3 Nov 2020 17:33:22 +0000
Message-Id: <20201103173336.2829-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KFkN2jnkv5gyCEJYrk4zhiEAx4520388AA=
Content-Type: multipart/mixed; boundary="K0ayZSvjaxHo1cUystPY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604424823;
 bh=B+yGG3J0LXaHOr5grobKFZ7JXZf69d+B7XQKfC8L16o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=eIaLR4qz3b2UIMeTbPMwdEd42LRXgc115zYMYewBEfg65aIFnI1m4OjyFsUvFpa2t4P
 qaazNpLtdi11FoSyhNm1i9X97Ei/RM/ZGF8k72+by6/g7kxZIYR7Ym6ZNtY5nXVRa5BhQ
 T24J/2XHhQuRrjAxQCgO0Md/MbO6W1n9rFM=

--K0ayZSvjaxHo1cUystPY

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit ff9e786f0ee0cc33aedabaa56678cb45d3c1ca0b upstream.

Add FDP1 device nodes to R8A774E1 (RZ/G2H) SoC dtsi.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20200827145315.26261-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 453efa21e9d5..76a4d53db888 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -1686,6 +1686,26 @@
 			renesas,fcp = <&fcpvi1>;
 		};
 
+		fdp1@fe940000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe940000 0 0x2400>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 119>;
+			power-domains = <&sysc R8A774E1_PD_A3VP>;
+			resets = <&cpg 119>;
+			renesas,fcp = <&fcpf0>;
+		};
+
+		fdp1@fe944000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe944000 0 0x2400>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 118>;
+			power-domains = <&sysc R8A774E1_PD_A3VP>;
+			resets = <&cpg 118>;
+			renesas,fcp = <&fcpf1>;
+		};
+
 		fcpf0: fcp@fe950000 {
 			compatible = "renesas,fcpf";
 			reg = <0 0xfe950000 0 0x200>;
-- 
2.17.1


--K0ayZSvjaxHo1cUystPY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5716): https://lists.cip-project.org/g/cip-dev/message=
/5716
Mute This Topic: https://lists.cip-project.org/mt/78011692/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--K0ayZSvjaxHo1cUystPY--
