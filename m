Return-Path: <SRS0=u8ZJ=7W=lists.cip-project.org=bounce+64572+4778+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8872BC433E3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 04:10:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D768206D5
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 04:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PU34Iy9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D768206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4778+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PKJWYY4521723xR4FcpSg5nT; Mon, 08 Jun 2020 21:10:02 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.99.1591675800914998372
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 21:10:01 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 0EC2F5FA80; Tue,  9 Jun 2020 12:09:59 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v3 05/14] PM / OPP: Rename OPP nodes as opp@<opp-hz>
Date: Tue,  9 Jun 2020 12:09:17 +0800
Message-Id: <20200609040926.8910-6-wens@csie.org>
In-Reply-To: <20200609040926.8910-1-wens@csie.org>
References: <20200609040926.8910-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: f6GgqxWjd2gWvQ5hCgMdvGUkx4520388AA=
Content-Type: multipart/mixed; boundary="oTXeaBTw714Hxx7iiZyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591675802;
 bh=ah7OM7mahd9NMFIUBORJfchqPLW0JcBXdQX7tWbt+U4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PU34Iy9LgNXhHNLKj/+9a5pWf9/XImqtAonNYiBQXKfiPYMss6Yu5UD8vNkzFCSnaVI
 1lYPTFxOUu0wUm2B7DitPu9AtjnfsLUpBLG4y45taeXokFpkWpK2xTCRTIGejjRGMAe8G
 6TVxhMbKhaFcH7yhtC14F4ZgO9WUqkk2lEA=

--oTXeaBTw714Hxx7iiZyG
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 754dcf35f34698661801ae1d391efa02affe83a7 upstream.

It would be better to name OPP nodes as opp@<opp-hz> as that will ensure
that multiple DT nodes don't contain the same frequency. Of course we
expect the writer to name the node with its opp-hz frequency and not any
other frequency.

And that will let the compile error out if multiple nodes are using the
same opp-hz frequency.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentatio=
n/devicetree/bindings/opp/opp.txt
index 24eac9a977494..601256fe8c0dd 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -177,20 +177,20 @@ Example 1: Single cluster Dual-core ARM cortex A9, =
switch DVFS states together.
 		compatible =3D "operating-points-v2";
 		opp-shared;
=20
-		opp00 {
+		opp@1000000000 {
 			opp-hz =3D /bits/ 64 <1000000000>;
 			opp-microvolt =3D <970000 975000 985000>;
 			opp-microamp =3D <70000>;
 			clock-latency-ns =3D <300000>;
 			opp-suspend;
 		};
-		opp01 {
+		opp@1100000000 {
 			opp-hz =3D /bits/ 64 <1100000000>;
 			opp-microvolt =3D <980000 1000000 1010000>;
 			opp-microamp =3D <80000>;
 			clock-latency-ns =3D <310000>;
 		};
-		opp02 {
+		opp@1200000000 {
 			opp-hz =3D /bits/ 64 <1200000000>;
 			opp-microvolt =3D <1025000>;
 			clock-latency-ns =3D <290000>;
@@ -256,20 +256,20 @@ independently.
 		 * independently.
 		 */
=20
-		opp00 {
+		opp@1000000000 {
 			opp-hz =3D /bits/ 64 <1000000000>;
 			opp-microvolt =3D <970000 975000 985000>;
 			opp-microamp =3D <70000>;
 			clock-latency-ns =3D <300000>;
 			opp-suspend;
 		};
-		opp01 {
+		opp@1100000000 {
 			opp-hz =3D /bits/ 64 <1100000000>;
 			opp-microvolt =3D <980000 1000000 1010000>;
 			opp-microamp =3D <80000>;
 			clock-latency-ns =3D <310000>;
 		};
-		opp02 {
+		opp@1200000000 {
 			opp-hz =3D /bits/ 64 <1200000000>;
 			opp-microvolt =3D <1025000>;
 			opp-microamp =3D <90000;
@@ -332,20 +332,20 @@ DVFS state together.
 		compatible =3D "operating-points-v2";
 		opp-shared;
=20
-		opp00 {
+		opp@1000000000 {
 			opp-hz =3D /bits/ 64 <1000000000>;
 			opp-microvolt =3D <970000 975000 985000>;
 			opp-microamp =3D <70000>;
 			clock-latency-ns =3D <300000>;
 			opp-suspend;
 		};
-		opp01 {
+		opp@1100000000 {
 			opp-hz =3D /bits/ 64 <1100000000>;
 			opp-microvolt =3D <980000 1000000 1010000>;
 			opp-microamp =3D <80000>;
 			clock-latency-ns =3D <310000>;
 		};
-		opp02 {
+		opp@1200000000 {
 			opp-hz =3D /bits/ 64 <1200000000>;
 			opp-microvolt =3D <1025000>;
 			opp-microamp =3D <90000>;
@@ -358,20 +358,20 @@ DVFS state together.
 		compatible =3D "operating-points-v2";
 		opp-shared;
=20
-		opp10 {
+		opp@1300000000 {
 			opp-hz =3D /bits/ 64 <1300000000>;
 			opp-microvolt =3D <1045000 1050000 1055000>;
 			opp-microamp =3D <95000>;
 			clock-latency-ns =3D <400000>;
 			opp-suspend;
 		};
-		opp11 {
+		opp@1400000000 {
 			opp-hz =3D /bits/ 64 <1400000000>;
 			opp-microvolt =3D <1075000>;
 			opp-microamp =3D <100000>;
 			clock-latency-ns =3D <400000>;
 		};
-		opp12 {
+		opp@1500000000 {
 			opp-hz =3D /bits/ 64 <1500000000>;
 			opp-microvolt =3D <1010000 1100000 1110000>;
 			opp-microamp =3D <95000>;
@@ -398,7 +398,7 @@ Example 4: Handling multiple regulators
 		compatible =3D "operating-points-v2";
 		opp-shared;
=20
-		opp00 {
+		opp@1000000000 {
 			opp-hz =3D /bits/ 64 <1000000000>;
 			opp-microvolt =3D <970000>, /* Supply 0 */
 					<960000>, /* Supply 1 */
@@ -411,7 +411,7 @@ Example 4: Handling multiple regulators
=20
 		/* OR */
=20
-		opp00 {
+		opp@1000000000 {
 			opp-hz =3D /bits/ 64 <1000000000>;
 			opp-microvolt =3D <970000 975000 985000>, /* Supply 0 */
 					<960000 965000 975000>, /* Supply 1 */
@@ -424,7 +424,7 @@ Example 4: Handling multiple regulators
=20
 		/* OR */
=20
-		opp00 {
+		opp@1000000000 {
 			opp-hz =3D /bits/ 64 <1000000000>;
 			opp-microvolt =3D <970000 975000 985000>, /* Supply 0 */
 					<960000 965000 975000>, /* Supply 1 */
@@ -456,7 +456,7 @@ Example 5: opp-supported-hw
 		status =3D "okay";
 		opp-shared;
=20
-		opp00 {
+		opp@600000000 {
 			/*
 			 * Supports all substrate and process versions for 0xF
 			 * cuts, i.e. only first four cuts.
@@ -467,7 +467,7 @@ Example 5: opp-supported-hw
 			...
 		};
=20
-		opp01 {
+		opp@800000000 {
 			/*
 			 * Supports:
 			 * - cuts: only one, 6th cut (represented by 6th bit).
@@ -499,7 +499,7 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
 		compatible =3D "operating-points-v2";
 		opp-shared;
=20
-		opp00 {
+		opp@1000000000 {
 			opp-hz =3D /bits/ 64 <1000000000>;
 			opp-microvolt-slow =3D <900000 915000 925000>;
 			opp-microvolt-fast =3D <970000 975000 985000>;
@@ -507,7 +507,7 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
 			opp-microamp-fast =3D  <71000>;
 		};
=20
-		opp01 {
+		opp@1200000000 {
 			opp-hz =3D /bits/ 64 <1200000000>;
 			opp-microvolt-slow =3D <900000 915000 925000>, /* Supply vcc0 */
 					      <910000 925000 935000>; /* Supply vcc1 */
--=20
2.27.0.rc0


--oTXeaBTw714Hxx7iiZyG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4778): https://lists.cip-project.org/g/cip-dev/message=
/4778
Mute This Topic: https://lists.cip-project.org/mt/74768064/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--oTXeaBTw714Hxx7iiZyG--
