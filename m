Return-Path: <SRS0=x3Hd=CL=lists.cip-project.org=bounce+64572+5377+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF52C43461
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E64215A4
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="udPbpe8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E64215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5377+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fZiHYY4521723xLWWF2I3me2; Wed, 02 Sep 2020 09:06:42 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.11290.1599062730775497221
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 09:05:34 -0700
X-IronPort-AV: E=Sophos;i="5.76,383,1592838000"; 
   d="scan'208";a="56196975"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2020 01:05:34 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9CB9A40065AE;
	Thu,  3 Sep 2020 01:05:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 5/9] ARM: dts: r8a7742: Add thermal device to DT
Date: Wed,  2 Sep 2020 17:05:12 +0100
Message-Id: <20200902160517.5181-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
References: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5GyCkDRFnQpB9p891SlkJkRnx4520388AA=
Content-Type: multipart/mixed; boundary="0e7wI9FpNz9CitfqwoPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599062802;
 bh=x8LtxivRqLzp/lg7K5BdI4BXI+qAakEJdOhzzAFtmUc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=udPbpe8PcXxA1z3ksOe086TtE+JDsV85dqcF74hFfzo/QFWpBal9QUgBxSPh0hK3clF
 ZQQWEyX6l3Qm+z4gqCEqKAeJAqOC3mLoWmTCg7wUEjxrfq0eCCek6SVMwvrUZY54WCDV8
 TZu9PvrDFDqXXiQpMBMrKh8JK8qDwRXputU=

--0e7wI9FpNz9CitfqwoPo

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 937c9ebddc09284dc947afaae52c76d05ee1dcfd upstream.

This patch instantiates the thermal sensor module with thermal-zone
support.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1590614320-30160-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: changed clocks and power-domain properties, removed resets property]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 50f70b358bce..97bedc13f702 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -736,6 +736,16 @@
 			power-domains = <&cpg_clocks>;
 		};
 
+		thermal: thermal@e61f0000 {
+			compatible = "renesas,thermal-r8a7742",
+				     "renesas,rcar-gen2-thermal";
+			reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp5_clks R8A7742_CLK_THERMAL>;
+			power-domains = <&cpg_clocks>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		icram0: sram@e63a0000 {
 			compatible = "mmio-sram";
 			reg = <0 0xe63a0000 0 0x12000>;
@@ -1065,6 +1075,25 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&thermal>;
+
+			trips {
+				cpu-crit {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.17.1


--0e7wI9FpNz9CitfqwoPo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5377): https://lists.cip-project.org/g/cip-dev/message=
/5377
Mute This Topic: https://lists.cip-project.org/mt/76585844/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0e7wI9FpNz9CitfqwoPo--
