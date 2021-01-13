Return-Path: <SRS0=TeU8=GQ=lists.cip-project.org=bounce+64572+6079+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62617C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8F123406
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8F123406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6079+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xcgoYY4521723xKenaZlAGQa; Wed, 13 Jan 2021 08:01:15 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web08.10261.1610553672734300249
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 08:01:15 -0800
X-IronPort-AV: E=Sophos;i="5.79,344,1602514800"; 
   d="scan'208";a="68678595"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jan 2021 01:01:14 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C1C4F40108FC;
	Thu, 14 Jan 2021 01:01:13 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 8/9] ARM: dts: r8a7742: Add PWM SoC support
Date: Wed, 13 Jan 2021 16:01:01 +0000
Message-Id: <20210113160102.16310-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mgEH8Sr1EtMrPkYwmKVveX2Rx4520388AA=
Content-Type: multipart/mixed; boundary="ScwkXQI3UmHUvXxe9bVr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610553675;
 bh=EUq3B16fXfhJgt1hi9akc2D/zhrcSyZXIaR3OmCx044=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BoV5IxfywH6gKWaWvkDYYSbvicJBevyTeJWAOojbXJtKxOdBYI2LMNAHgltbkF8qKFF
 8NzV66lliRATpVRe6slmiqQgYPQzU9pqVOCZ7qQl1r4CxqDnyEjgISUyLDOBp+84ZQt6w
 NN/7/jlnev/8yr8/a43YUjN+na4ZzDMl6bs=

--ScwkXQI3UmHUvXxe9bVr

commit b4a43810f596b55cb29b37ce4212ac7319661fb7 upstream.

Add the definitions for pwm[0123456] to the SoC .dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/20200806183152.11809-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL:changed clocks and power-domain properties, removed resets property]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 755136f88b01..ba2ddff1eff6 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -1371,6 +1371,69 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm@e6e30000 {
+			compatible = "renesas,pwm-r8a7742", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 0x8>;
+			clocks = <&mstp5_clks R8A7742_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@e6e31000 {
+			compatible = "renesas,pwm-r8a7742", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 0x8>;
+			clocks = <&mstp5_clks R8A7742_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@e6e32000 {
+			compatible = "renesas,pwm-r8a7742", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 0x8>;
+			clocks = <&mstp5_clks R8A7742_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@e6e33000 {
+			compatible = "renesas,pwm-r8a7742", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 0x8>;
+			clocks = <&mstp5_clks R8A7742_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@e6e34000 {
+			compatible = "renesas,pwm-r8a7742", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 0x8>;
+			clocks = <&mstp5_clks R8A7742_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@e6e35000 {
+			compatible = "renesas,pwm-r8a7742", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 0x8>;
+			clocks = <&mstp5_clks R8A7742_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@e6e36000 {
+			compatible = "renesas,pwm-r8a7742", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 0x8>;
+			clocks = <&mstp5_clks R8A7742_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		rcar_sound: sound@ec500000 {
 			/*
 			 * #sound-dai-cells is required
-- 
2.17.1


--ScwkXQI3UmHUvXxe9bVr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6079): https://lists.cip-project.org/g/cip-dev/message=
/6079
Mute This Topic: https://lists.cip-project.org/mt/79654006/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ScwkXQI3UmHUvXxe9bVr--
