Return-Path: <SRS0=TLbP=CS=lists.cip-project.org=bounce+64572+5425+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F2FC2D0E4
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7350821D43
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Dtsn/mpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7350821D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5425+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 13UoYY4521723xHE3x7l8gmd; Tue, 08 Sep 2020 21:44:46 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.6687.1599626683570857026
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:43 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 336AF5FEF3; Wed,  9 Sep 2020 12:44:33 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 11/11] ARM: dts: am33xx: Add updated operating-points-v2 table for cpu
Date: Wed,  9 Sep 2020 12:42:33 +0800
Message-Id: <20200909044233.4115-12-wens@csie.org>
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QFNlvuD3DFfr3vPcfx8cx45nx4520388AA=
Content-Type: multipart/mixed; boundary="n7Mw9DKO5itJb2fygBHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626686;
 bh=14I4tiiG8fvinSEmHtnqVZY473S49OZZmnVrffc4ehM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Dtsn/mpmkVXoQ6fXTIelL3MJ0Kh77TM+i52YQiDhBmXlj+XcUemlx8/5zvry81ZWe9A
 c8xUijkzvixmQLREi9Xnhy4v8rXjEX35EdS2050qzcWvfxgUeHCwvyplvL4mcbKOiYZ8V
 qX1DssGguQ14rqg31BaqqhSnjP8aaGaC6+U=

--n7Mw9DKO5itJb2fygBHv
Content-Transfer-Encoding: quoted-printable

From: Dave Gerlach <d-gerlach@ti.com>

commit 72ac40fcb164a3d8fbd1ff13647abe67df26ced5 upstream.

After the ti-cpufreq driver has been added, we can now drop the
operating-points table present in am33xx.dtsi for the cpu and add an
operating-points-v2 table with all OPPs available for all silicon
revisions. Also add necessary data for use by ti-cpufreq to selectively
enable the appropriate OPPs at runtime as part of the operating-points
table.

Information from AM335x Data Manual, SPRS717i, Revised December 2015,
Table 5-7.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Reviewed-by: Lukasz Majewski <lukma@denx.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 87 +++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dts=
i
index 4b40e6d401a03..c256718d75801 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -45,19 +45,7 @@
 			device_type =3D "cpu";
 			reg =3D <0>;
=20
-			/*
-			 * To consider voltage drop between PMIC and SoC,
-			 * tolerance value is reduced to 2% from 4% and
-			 * voltage value is increased as a precaution.
-			 */
-			operating-points =3D <
-				/* kHz    uV */
-				720000  1285000
-				600000  1225000
-				500000  1125000
-				275000  1125000
-			>;
-			voltage-tolerance =3D <2>; /* 2 percentage */
+			operating-points-v2 =3D <&cpu0_opp_table>;
=20
 			clocks =3D <&dpll_mpu_ck>;
 			clock-names =3D "cpu";
@@ -66,6 +54,79 @@
 		};
 	};
=20
+	cpu0_opp_table: opp-table {
+		compatible =3D "operating-points-v2-ti-cpu";
+		syscon =3D <&scm_conf>;
+
+		/*
+		 * The three following nodes are marked with opp-suspend
+		 * because the can not be enabled simultaneously on a
+		 * single SoC.
+		 */
+		opp50@300000000 {
+			opp-hz =3D /bits/ 64 <300000000>;
+			opp-microvolt =3D <950000 931000 969000>;
+			opp-supported-hw =3D <0x06 0x0010>;
+			opp-suspend;
+		};
+
+		opp100@275000000 {
+			opp-hz =3D /bits/ 64 <275000000>;
+			opp-microvolt =3D <1100000 1078000 1122000>;
+			opp-supported-hw =3D <0x01 0x00FF>;
+			opp-suspend;
+		};
+
+		opp100@300000000 {
+			opp-hz =3D /bits/ 64 <300000000>;
+			opp-microvolt =3D <1100000 1078000 1122000>;
+			opp-supported-hw =3D <0x06 0x0020>;
+			opp-suspend;
+		};
+
+		opp100@500000000 {
+			opp-hz =3D /bits/ 64 <500000000>;
+			opp-microvolt =3D <1100000 1078000 1122000>;
+			opp-supported-hw =3D <0x01 0xFFFF>;
+		};
+
+		opp100@600000000 {
+			opp-hz =3D /bits/ 64 <600000000>;
+			opp-microvolt =3D <1100000 1078000 1122000>;
+			opp-supported-hw =3D <0x06 0x0040>;
+		};
+
+		opp120@600000000 {
+			opp-hz =3D /bits/ 64 <600000000>;
+			opp-microvolt =3D <1200000 1176000 1224000>;
+			opp-supported-hw =3D <0x01 0xFFFF>;
+		};
+
+		opp120@720000000 {
+			opp-hz =3D /bits/ 64 <720000000>;
+			opp-microvolt =3D <1200000 1176000 1224000>;
+			opp-supported-hw =3D <0x06 0x0080>;
+		};
+
+		oppturbo@720000000 {
+			opp-hz =3D /bits/ 64 <720000000>;
+			opp-microvolt =3D <1260000 1234800 1285200>;
+			opp-supported-hw =3D <0x01 0xFFFF>;
+		};
+
+		oppturbo@800000000 {
+			opp-hz =3D /bits/ 64 <800000000>;
+			opp-microvolt =3D <1260000 1234800 1285200>;
+			opp-supported-hw =3D <0x06 0x0100>;
+		};
+
+		oppnitro@1000000000 {
+			opp-hz =3D /bits/ 64 <1000000000>;
+			opp-microvolt =3D <1325000 1298500 1351500>;
+			opp-supported-hw =3D <0x04 0x0200>;
+		};
+	};
+
 	pmu {
 		compatible =3D "arm,cortex-a8-pmu";
 		interrupts =3D <3>;
--=20
2.28.0


--n7Mw9DKO5itJb2fygBHv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5425): https://lists.cip-project.org/g/cip-dev/message=
/5425
Mute This Topic: https://lists.cip-project.org/mt/76726429/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--n7Mw9DKO5itJb2fygBHv--
