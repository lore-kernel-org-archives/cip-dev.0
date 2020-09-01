Return-Path: <SRS0=EIS0=CK=lists.cip-project.org=bounce+64572+5356+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9C2C43461
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C387D206FA
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ofZNdgvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C387D206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5356+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AN9LYY4521723x5raFW6Xmxp; Tue, 01 Sep 2020 04:45:11 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.11108.1598960491095779796
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2020 04:41:31 -0700
X-IronPort-AV: E=Sophos;i="5.76,378,1592838000"; 
   d="scan'208";a="55870265"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2020 20:41:30 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.50])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 17AAD400752B;
	Tue,  1 Sep 2020 20:41:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 07/10] ARM: dts: r8a7742: Add Ethernet AVB support
Date: Tue,  1 Sep 2020 12:41:11 +0100
Message-Id: <20200901114114.3465-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
References: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LRk9vdAYiOUHNP35BJnPXHe4x4520388AA=
Content-Type: multipart/mixed; boundary="5GJIs3CNBOdawuEvsGuu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598960711;
 bh=XkomTClhRm3pjBNmy8M+3BV9gn+lVlnMpWCKC/jorHE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ofZNdgvEgKFoi/+QQXmoIQdW39l9VeS86s4nGvE94z+Z+2qt6GgwmR9L93dJRqda8GI
 4phD4rmBiUHTVGl9ATSKfTAk2TQG9LwvfSQ3LWRzCyIe6tIlEOHgxGAfnRogmWCtwEIAK
 5hGplyHAGGK1SS/TF1W9cAv/NK0F6J/OEQw=

--5GJIs3CNBOdawuEvsGuu

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9451f394e9cfb30e5a9b66f1022ef7f91717548b upstream.

Add Ethernet AVB support for R8A7742 SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/1589555337-5498-13-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: changed clocks and power-domains properties, removed resets property]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 6693a54367aa..3f72658ba96d 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -916,6 +916,18 @@
 			dma-channels = <15>;
 		};
 
+		avb: ethernet@e6800000 {
+			compatible = "renesas,etheravb-r8a7742",
+				     "renesas,etheravb-rcar-gen2";
+			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7742_CLK_ETHERAVB>;
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		scifa2: serial@e6c60000 {
 			compatible = "renesas,scifa-r8a7742",
 				     "renesas,rcar-gen2-scifa", "renesas,scifa";
-- 
2.17.1


--5GJIs3CNBOdawuEvsGuu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5356): https://lists.cip-project.org/g/cip-dev/message=
/5356
Mute This Topic: https://lists.cip-project.org/mt/76554012/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5GJIs3CNBOdawuEvsGuu--
