Return-Path: <SRS0=BDSe=7V=lists.cip-project.org=bounce+64572+4769+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7C2C433ED
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45402078C
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PsHnQKfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45402078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4769+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3oIEYY4521723xVwJ67q1xcc; Mon, 08 Jun 2020 05:01:39 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web10.26111.1591607689004076582
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 02:14:49 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id AF2015FD21; Mon,  8 Jun 2020 17:14:43 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v2 02/15] PM / OPP: Add "opp-supported-hw" binding
Date: Mon,  8 Jun 2020 17:14:19 +0800
Message-Id: <20200608091432.15366-3-wens@csie.org>
In-Reply-To: <20200608091432.15366-1-wens@csie.org>
References: <20200608091432.15366-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dQtoppZ2QQeazFwHYzM9DeBcx4520388AA=
Content-Type: multipart/mixed; boundary="6AwlKUmrYa7CqQouQfjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591617699;
 bh=4iR9vTkzog/R1oQWUlm0yJHU4OxUgpEI0ejjJ9CPslQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PsHnQKfU6aDKVnf5O9zDxhYKxNb6oRdm4l0jxB+lRHjHZ2BxAuKfnz3fZytBwsQsDOU
 /5bV5pqH2tkkNV3nFbRexqjvrL1qikS54Hs+QAQvIvk899jPPTXTQ98n3U/+XDFMdI3EC
 20i+d+qTgx4MEbiIud3vhNaQ0RLfKFG5Zwc=

--6AwlKUmrYa7CqQouQfjZ
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 1c4d12de2719dfdf27c6dab31e7a5641ee293c94 upstream.

We may want to enable only a subset of OPPs, from the bigger list of
OPPs, based on what version of the hardware we are running on. This
would enable us to not duplicate OPP tables for every version of the
hardware we support.

To enable that, this patch defines a new property 'opp-supported-hw'. It
can support any number of hierarchy levels of the versions the hardware
follows. And based on the selected hardware versions, we can pick only
the relevant OPPs at runtime.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentatio=
n/devicetree/bindings/opp/opp.txt
index 0cb44dc21f97c..d072fa0ffbd44 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -123,6 +123,26 @@ Optional properties:
 - opp-suspend: Marks the OPP to be used during device suspend. Only one =
OPP in
   the table should have this.
=20
+- opp-supported-hw: This enables us to select only a subset of OPPs from=
 the
+  larger OPP table, based on what version of the hardware we are running=
 on. We
+  still can't have multiple nodes with the same opp-hz value in OPP tabl=
e.
+
+  It's an user defined array containing a hierarchy of hardware version =
numbers,
+  supported by the OPP. For example: a platform with hierarchy of three =
levels
+  of versions (A, B and C), this field should be like <X Y Z>, where X
+  corresponds to Version hierarchy A, Y corresponds to version hierarchy=
 B and Z
+  corresponds to version hierarchy C.
+
+  Each level of hierarchy is represented by a 32 bit value, and so there=
 can be
+  only 32 different supported version per hierarchy. i.e. 1 bit per vers=
ion. A
+  value of 0xFFFFFFFF will enable the OPP for all versions for that hier=
archy
+  level. And a value of 0x00000000 will disable the OPP completely, and =
so we
+  never want that to happen.
+
+  If 32 values aren't sufficient for a version hierarchy, than that vers=
ion
+  hierarchy can be contained in multiple 32 bit values. i.e. <X Y Z1 Z2>=
 in the
+  above example, Z1 & Z2 refer to the version hierarchy Z.
+
 - status: Marks the node enabled/disabled.
=20
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states to=
gether.
@@ -463,3 +483,48 @@ Example 5: Multiple OPP tables
 		};
 	};
 };
+
+Example 6: opp-supported-hw
+(example: three level hierarchy of versions: cuts, substrate and process=
)
+
+/ {
+	cpus {
+		cpu@0 {
+			compatible =3D "arm,cortex-a7";
+			...
+
+			cpu-supply =3D <&cpu_supply>
+			operating-points-v2 =3D <&cpu0_opp_table_slow>;
+		};
+	};
+
+	opp_table {
+		compatible =3D "operating-points-v2";
+		status =3D "okay";
+		opp-shared;
+
+		opp00 {
+			/*
+			 * Supports all substrate and process versions for 0xF
+			 * cuts, i.e. only first four cuts.
+			 */
+			opp-supported-hw =3D <0xF 0xFFFFFFFF 0xFFFFFFFF>
+			opp-hz =3D /bits/ 64 <600000000>;
+			opp-microvolt =3D <900000 915000 925000>;
+			...
+		};
+
+		opp01 {
+			/*
+			 * Supports:
+			 * - cuts: only one, 6th cut (represented by 6th bit).
+			 * - substrate: supports 16 different substrate versions
+			 * - process: supports 9 different process versions
+			 */
+			opp-supported-hw =3D <0x20 0xff0000ff 0x0000f4f0>
+			opp-hz =3D /bits/ 64 <800000000>;
+			opp-microvolt =3D <900000 915000 925000>;
+			...
+		};
+	};
+};
--=20
2.27.0.rc0


--6AwlKUmrYa7CqQouQfjZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4769): https://lists.cip-project.org/g/cip-dev/message=
/4769
Mute This Topic: https://lists.cip-project.org/mt/74750034/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--6AwlKUmrYa7CqQouQfjZ--
