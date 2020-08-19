Return-Path: <SRS0=mqAv=B5=lists.cip-project.org=bounce+64572+5153+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D0FC433F4
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD65D208B3
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YkyMP7Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD65D208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5153+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7VqzYY4521723xeb0BDQgdJo; Wed, 19 Aug 2020 09:45:13 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.91601.1597855005191174500
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 09:36:45 -0700
X-IronPort-AV: E=Sophos;i="5.76,332,1592838000"; 
   d="scan'208";a="54769726"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Aug 2020 01:36:44 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F0A2F400967A;
	Thu, 20 Aug 2020 01:36:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 04/12] arm64: dts: renesas: Add HiHope RZ/G2M[N] Rev.3.0/4.0 specific into common file
Date: Wed, 19 Aug 2020 17:36:26 +0100
Message-Id: <20200819163634.5430-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RtMUokxfPLk8rjfClBvdUcVEx4520388AA=
Content-Type: multipart/mixed; boundary="sJqUnfc57xAYnNfusTce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597855513;
 bh=nkP7blpQ3aOcTMk7mn6B8nbOIC3L8WRtVy5h0PgqGAE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=YkyMP7RpcVb3/D/vjFJZ728CXmdbeoOcfp1NrEa2rdDzdkaTB8Mttf73vAW3RrMbdsa
 IapSAtZh41VFBao3jqhOT094IkwY19puZyeooqzhmN5d+53cREoKUuX/PAt5CkrP2F0ZR
 NAD9YiMjMCBL5EbniswDdVbbM0oeCxRNy50=

--sJqUnfc57xAYnNfusTce

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit faf1ce7f1ef65af81bd85fe9c70950571cd70b19 upstream.

Rev.3.0 and Rev.4.0 are identical and can be identified by using GP5_19
and GP5_21.

	Rev		GP5_19	GP5_21
	==============================
	Rev.3.0		0	0
	Rev.4.0		0	1

This patch creates hihope-rev4.dtsi file with
Rev.3.0/4.0 specific changes for HopeRun HiHope RZ/G2M[N] boards.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1593004330-5039-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/hihope-rev4.dtsi | 124 +++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/hihope-rev4.dtsi

diff --git a/arch/arm64/boot/dts/renesas/hihope-rev4.dtsi b/arch/arm64/boot/dts/renesas/hihope-rev4.dtsi
new file mode 100644
index 000000000000..9f869187aea6
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/hihope-rev4.dtsi
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2[MN] Rev.3.0/4.0 main board
+ * common parts
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include "hihope-common.dtsi"
+
+/ {
+	audio_clkout: audio-clkout {
+		/*
+		 * This is same as <&rcar_sound 0>
+		 * but needed to avoid cs2000/rcar_sound probe dead-lock
+		 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+
+	wlan_en_reg: regulator-wlan_en {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		startup-delay-us = <70000>;
+
+		gpio = <&gpio4 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	x1801_clk: x1801-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+};
+
+&hscif0 {
+	bluetooth {
+		compatible = "ti,wl1837-st";
+		enable-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	cs2000: clk_multiplier@4f {
+		#clock-cells = <0>;
+		compatible = "cirrus,cs2000-cp";
+		reg = <0x4f>;
+		clocks = <&audio_clkout>, <&x1801_clk>;
+		clock-names = "clk_in", "ref_clk";
+
+		assigned-clocks = <&cs2000>;
+		assigned-clock-rates = <24576000>; /* 1/1 divide */
+	};
+};
+
+&pfc {
+	i2c2_pins: i2c2 {
+		groups = "i2c2_a";
+		function = "i2c2";
+	};
+
+	sound_clk_pins: sound_clk {
+		groups = "audio_clk_a_a", "audio_clk_b_a", "audio_clkout_a";
+		function = "audio_clk";
+	};
+
+	sound_pins: sound {
+		groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data_a";
+		function = "ssi";
+	};
+};
+
+&rcar_sound {
+	pinctrl-0 = <&sound_pins &sound_clk_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+
+	/* audio_clkout0/1/2/3 */
+	#clock-cells = <1>;
+	clock-frequency = <12288000 11289600>;
+
+	/* update <audio_clk_b> to <cs2000> */
+	clocks = <&cpg CPG_MOD 1005>,
+		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
+		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
+		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
+		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
+		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+		 <&audio_clk_a>, <&cs2000>,
+		 <&audio_clk_c>,
+		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
+
+	rsnd_port: port {
+		rsnd_endpoint: endpoint {
+			remote-endpoint = <&dw_hdmi0_snd_in>;
+
+			dai-format = "i2s";
+			bitclock-master = <&rsnd_endpoint>;
+			frame-master = <&rsnd_endpoint>;
+
+			playback = <&ssi2>;
+		};
+	};
+};
-- 
2.17.1


--sJqUnfc57xAYnNfusTce
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5153): https://lists.cip-project.org/g/cip-dev/message=
/5153
Mute This Topic: https://lists.cip-project.org/mt/76290783/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--sJqUnfc57xAYnNfusTce--
