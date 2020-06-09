Return-Path: <SRS0=Cv4Y=7W=lists.cip-project.org=bounce+64572+4776+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A638C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 04:10:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0287E206D5
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 04:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="c9mcnR5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0287E206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4776+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QClCYY4521723xJvBRebtHtC; Mon, 08 Jun 2020 21:10:01 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.98.1591675800868308840
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 21:10:01 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 027C75FD69; Tue,  9 Jun 2020 12:09:58 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v3 04/14] PM / OPP: Remove 'operating-points-names' binding
Date: Tue,  9 Jun 2020 12:09:16 +0800
Message-Id: <20200609040926.8910-5-wens@csie.org>
In-Reply-To: <20200609040926.8910-1-wens@csie.org>
References: <20200609040926.8910-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Z422ZY6gH6DTWDSLkzQ1mukcx4520388AA=
Content-Type: multipart/mixed; boundary="mzhpJwcrriM68YScg5Xc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591675801;
 bh=OTPSndAalVBLj4neiflbDIz8hYolnymfu46dvM5ZBdU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=c9mcnR5g02zFcmZ+4j2LvcHfyXnBhb9sVATk/t9S4Kcd1KQWYuIi3vJZO64c0oJhhDK
 40hK/HIli5604xTFj5nVT/G9bXU1LMUutfqDowYN6IBUU5kqxur95atINYyHS8HAXFKjL
 vE2l1CO1lHhvI2BGFvMbosOASxu/YIweuog=

--mzhpJwcrriM68YScg5Xc
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit af87a39a5f7cf6ef252b1aec3e2e6508a40e51f1 upstream.

These aren't used until now by any DT files and wouldn't be used now as
we have a better scheme in place now, i.e. opp-property-<name>
properties.

Remove the (useless) binding without breaking ABI.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 62 +------------------
 1 file changed, 2 insertions(+), 60 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentatio=
n/devicetree/bindings/opp/opp.txt
index a3e7f0d5e1fb4..24eac9a977494 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -45,21 +45,10 @@ Devices supporting OPPs must set their "operating-poi=
nts-v2" property with
 phandle to a OPP table in their DT node. The OPP core will use this phan=
dle to
 find the operating points for the device.
=20
-Devices may want to choose OPP tables at runtime and so can provide a li=
st of
-phandles here. But only *one* of them should be chosen at runtime. This =
must be
-accompanied by a corresponding "operating-points-names" property, to uni=
quely
-identify the OPP tables.
-
 If required, this can be extended for SoC vendor specfic bindings. Such =
bindings
 should be documented as Documentation/devicetree/bindings/power/<vendor>=
-opp.txt
 and should have a compatible description like: "operating-points-v2-<ven=
dor>".
=20
-Optional properties:
-- operating-points-names: Names of OPP tables (required if multiple OPP
-  tables are present), to uniquely identify them. The same list must be =
present
-  for all the CPUs which are sharing clock/voltage rails and hence the O=
PP
-  tables.
-
 * OPP Table Node
=20
 This describes the OPPs belonging to a device. This node can have follow=
ing
@@ -448,54 +437,7 @@ Example 4: Handling multiple regulators
 	};
 };
=20
-Example 5: Multiple OPP tables
-
-/ {
-	cpus {
-		cpu@0 {
-			compatible =3D "arm,cortex-a7";
-			...
-
-			cpu-supply =3D <&cpu_supply>
-			operating-points-v2 =3D <&cpu0_opp_table_slow>, <&cpu0_opp_table_fast=
>;
-			operating-points-names =3D "slow", "fast";
-		};
-	};
-
-	cpu0_opp_table_slow: opp_table_slow {
-		compatible =3D "operating-points-v2";
-		status =3D "okay";
-		opp-shared;
-
-		opp00 {
-			opp-hz =3D /bits/ 64 <600000000>;
-			...
-		};
-
-		opp01 {
-			opp-hz =3D /bits/ 64 <800000000>;
-			...
-		};
-	};
-
-	cpu0_opp_table_fast: opp_table_fast {
-		compatible =3D "operating-points-v2";
-		status =3D "okay";
-		opp-shared;
-
-		opp10 {
-			opp-hz =3D /bits/ 64 <1000000000>;
-			...
-		};
-
-		opp11 {
-			opp-hz =3D /bits/ 64 <1100000000>;
-			...
-		};
-	};
-};
-
-Example 6: opp-supported-hw
+Example 5: opp-supported-hw
 (example: three level hierarchy of versions: cuts, substrate and process=
)
=20
 / {
@@ -540,7 +482,7 @@ Example 6: opp-supported-hw
 	};
 };
=20
-Example 7: opp-microvolt-<name>, opp-microamp-<name>:
+Example 6: opp-microvolt-<name>, opp-microamp-<name>:
 (example: device with two possible microvolt ranges: slow and fast)
=20
 / {
--=20
2.27.0.rc0


--mzhpJwcrriM68YScg5Xc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4776): https://lists.cip-project.org/g/cip-dev/message=
/4776
Mute This Topic: https://lists.cip-project.org/mt/74768062/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mzhpJwcrriM68YScg5Xc--
