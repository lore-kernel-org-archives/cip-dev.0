Return-Path: <SRS0=iKS/=CS=lists.cip-project.org=bounce+64572+5419+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B13C433E2
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B7321D43
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="qA9D+6xC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B7321D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5419+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id t9sfYY4521723x6flxWEJ9cz; Tue, 08 Sep 2020 21:44:43 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.6685.1599626681625135068
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:42 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id DBE145FCD0; Wed,  9 Sep 2020 12:44:32 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 03/11] Documentation: dt: add bindings for ti-cpufreq
Date: Wed,  9 Sep 2020 12:42:25 +0800
Message-Id: <20200909044233.4115-4-wens@csie.org>
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KAdMYZs4lf3q6Ap3INfFIdI9x4520388AA=
Content-Type: multipart/mixed; boundary="VgKHdquEyh3dOQRMmB6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626683;
 bh=Di5r0VSnMMVPqIz9fSBMYKfMT9jLSbOoxw+nG94Kd2M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qA9D+6xCPct/dDsA6KBi3c3XK5yAO7qg5ty7FdcWO1v0ritW00tzZmsZXVy8p10yHXn
 kMb3tew4A8zag29nSPtdhVHnwh0X9pvhZyxGDThh9qUARvv3c9GfDipdQ3YpAEIsiDXE6
 sBLBncpipyNmJEQuaxolO2cbnhyCOk8yp+s=

--VgKHdquEyh3dOQRMmB6P
Content-Transfer-Encoding: quoted-printable

From: Dave Gerlach <d-gerlach@ti.com>

commit 953a0f18337406ab041252ce5a62db5d173bee5f upstream.

Add the device tree bindings document for the TI CPUFreq/OPP driver
on AM33xx, AM43xx, DRA7xx, and AM57xx SoCs. The operating-points-v2
binding allows us to provide an opp-supported-hw property for each OPP
to define when it is available. This driver is responsible for reading
and parsing registers to determine which OPPs can be selectively enabled
based on the specific SoC in use by matching against the opp-supported-hw
data.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 .../bindings/cpufreq/ti-cpufreq.txt           | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.=
txt

diff --git a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt b/D=
ocumentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
new file mode 100644
index 0000000000000..ba0e15ad5bd9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
@@ -0,0 +1,128 @@
+TI CPUFreq and OPP bindings
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+
+Certain TI SoCs, like those in the am335x, am437x, am57xx, and dra7xx
+families support different OPPs depending on the silicon variant in use.
+The ti-cpufreq driver can use revision and an efuse value from the SoC t=
o
+provide the OPP framework with supported hardware information. This is
+used to determine which OPPs from the operating-points-v2 table get enab=
led
+when it is parsed by the OPP framework.
+
+Required properties:
+--------------------
+In 'cpus' nodes:
+- operating-points-v2: Phandle to the operating-points-v2 table to use.
+
+In 'operating-points-v2' table:
+- compatible: Should be
+	- 'operating-points-v2-ti-cpu' for am335x, am43xx, and dra7xx/am57xx So=
Cs
+- syscon: A phandle pointing to a syscon node representing the control m=
odule
+	  register space of the SoC.
+
+Optional properties:
+--------------------
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: Two bitfields indicating:
+	1. Which revision of the SoC the OPP is supported by
+	2. Which eFuse bits indicate this OPP is available
+
+	A bitwise AND is performed against these values and if any bit
+	matches, the OPP gets enabled.
+
+Example:
+--------
+
+/* From arch/arm/boot/dts/am33xx.dtsi */
+cpus {
+	#address-cells =3D <1>;
+	#size-cells =3D <0>;
+	cpu@0 {
+		compatible =3D "arm,cortex-a8";
+		device_type =3D "cpu";
+		reg =3D <0>;
+
+		operating-points-v2 =3D <&cpu0_opp_table>;
+
+		clocks =3D <&dpll_mpu_ck>;
+		clock-names =3D "cpu";
+
+		clock-latency =3D <300000>; /* From omap-cpufreq driver */
+	};
+};
+
+/*
+ * cpu0 has different OPPs depending on SoC revision and some on revisio=
ns
+ * 0x2 and 0x4 have eFuse bits that indicate if they are available or no=
t
+ */
+cpu0_opp_table: opp-table {
+	compatible =3D "operating-points-v2-ti-cpu";
+	syscon =3D <&scm_conf>;
+
+	/*
+	 * The three following nodes are marked with opp-suspend
+	 * because they can not be enabled simultaneously on a
+	 * single SoC.
+	 */
+	opp50@300000000 {
+		opp-hz =3D /bits/ 64 <300000000>;
+		opp-microvolt =3D <950000 931000 969000>;
+		opp-supported-hw =3D <0x06 0x0010>;
+		opp-suspend;
+	};
+
+	opp100@275000000 {
+		opp-hz =3D /bits/ 64 <275000000>;
+		opp-microvolt =3D <1100000 1078000 1122000>;
+		opp-supported-hw =3D <0x01 0x00FF>;
+		opp-suspend;
+	};
+
+	opp100@300000000 {
+		opp-hz =3D /bits/ 64 <300000000>;
+		opp-microvolt =3D <1100000 1078000 1122000>;
+		opp-supported-hw =3D <0x06 0x0020>;
+		opp-suspend;
+	};
+
+	opp100@500000000 {
+		opp-hz =3D /bits/ 64 <500000000>;
+		opp-microvolt =3D <1100000 1078000 1122000>;
+		opp-supported-hw =3D <0x01 0xFFFF>;
+	};
+
+	opp100@600000000 {
+		opp-hz =3D /bits/ 64 <600000000>;
+		opp-microvolt =3D <1100000 1078000 1122000>;
+		opp-supported-hw =3D <0x06 0x0040>;
+	};
+
+	opp120@600000000 {
+		opp-hz =3D /bits/ 64 <600000000>;
+		opp-microvolt =3D <1200000 1176000 1224000>;
+		opp-supported-hw =3D <0x01 0xFFFF>;
+	};
+
+	opp120@720000000 {
+		opp-hz =3D /bits/ 64 <720000000>;
+		opp-microvolt =3D <1200000 1176000 1224000>;
+		opp-supported-hw =3D <0x06 0x0080>;
+	};
+
+	oppturbo@720000000 {
+		opp-hz =3D /bits/ 64 <720000000>;
+		opp-microvolt =3D <1260000 1234800 1285200>;
+		opp-supported-hw =3D <0x01 0xFFFF>;
+	};
+
+	oppturbo@800000000 {
+		opp-hz =3D /bits/ 64 <800000000>;
+		opp-microvolt =3D <1260000 1234800 1285200>;
+		opp-supported-hw =3D <0x06 0x0100>;
+	};
+
+	oppnitro@1000000000 {
+		opp-hz =3D /bits/ 64 <1000000000>;
+		opp-microvolt =3D <1325000 1298500 1351500>;
+		opp-supported-hw =3D <0x04 0x0200>;
+	};
+};
--=20
2.28.0


--VgKHdquEyh3dOQRMmB6P
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5419): https://lists.cip-project.org/g/cip-dev/message=
/5419
Mute This Topic: https://lists.cip-project.org/mt/76726423/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--VgKHdquEyh3dOQRMmB6P--
