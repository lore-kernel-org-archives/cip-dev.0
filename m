Return-Path: <SRS0=9qFP=7R=lists.cip-project.org=bounce+64572+4704+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B53C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6343220738
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wrFOhDK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6343220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4704+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZEUIYY4521723xUreHCDiqiS; Thu, 04 Jun 2020 04:55:34 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web11.6513.1591240765999523660
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 20:19:26 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id D36B75FD2B; Thu,  4 Jun 2020 11:19:19 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	Stephen Boyd <sboyd@codeaurora.org>,
	Rob Herring <robh@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [cip-dev] [4.4.y-cip 05/15] PM / OPP: Rename OPP nodes as opp@<opp-hz>
Date: Thu,  4 Jun 2020 11:18:19 +0800
Message-Id: <20200604031829.3254-6-wens@csie.org>
In-Reply-To: <20200604031829.3254-1-wens@csie.org>
References: <20200604031829.3254-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fuHpCtfrfl0vLblee4g3ECrxx4520388AA=
Content-Type: multipart/mixed; boundary="CWWiXZvOu2od9Ah8Pb9v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591271734;
 bh=g5m8swDLuCB6jpbMEbK+ocoi1m54Ecfo4ZMXGBWUWlw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wrFOhDK/GocDL2mDnGkvp+dMHfOyCOlVnjafweS1s+I4+XkMz+GXj47HTbrLI3gduit
 692eI6NMM1SO7vMJUxjYWsQo0/M/KWUmPYULU9Hbp80yFWWteECCuF5a6FKnRHzPTx4XG
 42fLMvduD10JkVG2Qa6jQrS1+WAJxbpRjgI=

--CWWiXZvOu2od9Ah8Pb9v
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


--CWWiXZvOu2od9Ah8Pb9v
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4704): https://lists.cip-project.org/g/cip-dev/message=
/4704
Mute This Topic: https://lists.cip-project.org/mt/74669302/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--CWWiXZvOu2od9Ah8Pb9v--
