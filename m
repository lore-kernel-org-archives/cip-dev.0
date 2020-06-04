Return-Path: <SRS0=NRMr=7R=lists.cip-project.org=bounce+64572+4715+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343F0C433DF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE65420663
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LQYSkz4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE65420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4715+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 39UJYY4521723xnbzf2R1CMH; Thu, 04 Jun 2020 04:55:36 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web11.6511.1591240764006092860
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 20:19:24 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id C7A515FD69; Thu,  4 Jun 2020 11:19:19 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	Stephen Boyd <sboyd@codeaurora.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [cip-dev] [4.4.y-cip 03/15] PM / OPP: Add {opp-microvolt|opp-microamp}-<name> binding
Date: Thu,  4 Jun 2020 11:18:17 +0800
Message-Id: <20200604031829.3254-4-wens@csie.org>
In-Reply-To: <20200604031829.3254-1-wens@csie.org>
References: <20200604031829.3254-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: C3E6RFK4NmHpd6UoDu0HhtFdx4520388AA=
Content-Type: multipart/mixed; boundary="WkZjdEILTm4SfhAcr2hQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591271736;
 bh=LHpVtnNp/ihWTth/UBtCnfWNCoo49rchZME3PoZoWUQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LQYSkz4gS4ufqBkGSwMrkdVKizdXfKn6aJTU+0ldMDgDK8ciZf5K4Ks3daBdQBsEOuo
 YsW9vaHtZ+tDdg3/qkPuMAz0uADys9xfEDnyuM+3xvOOvckfRyaObgrDLdaJaYMm8VhgR
 PljFMcoa5sJh1dJ14yv0Zcm1OusLs9VXkqg=

--WkZjdEILTm4SfhAcr2hQ
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit ffdb8cc7a27c89175e541e68e2a73f1f63ab8c6b upstream.

Depending on the version of hardware or its properties, which are only
known at runtime, various properties of the OPP can change. For example,
an OPP with frequency 1.2 GHz, may have different voltage/current
requirements based on the version of the hardware it is running on.

In order to not replicate the same OPP tables for varying values of all
such fields, this commit introduces the concept of opp-property-<name>.
The <name> can be chosen by the platform at runtime, and OPPs will be
initialized depending on that name string. Currently support is extended
for the following properties:
- opp-microvolt-<name>
- opp-microamp-<name>

If the name string isn't provided by the platform, or if it is provided
but doesn't match the properties present in the OPP node, we will fall
back to the original properties without the -<name> string, if they are
available.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentatio=
n/devicetree/bindings/opp/opp.txt
index d072fa0ffbd44..a3e7f0d5e1fb4 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -100,6 +100,14 @@ Optional properties:
   Entries for multiple regulators must be present in the same order as
   regulators are specified in device's DT node.
=20
+- opp-microvolt-<name>: Named opp-microvolt property. This is exactly si=
milar to
+  the above opp-microvolt property, but allows multiple voltage ranges t=
o be
+  provided for the same OPP. At runtime, the platform can pick a <name> =
and
+  matching opp-microvolt-<name> property will be enabled for all OPPs. I=
f the
+  platform doesn't pick a specific <name> or the <name> doesn't match wi=
th any
+  opp-microvolt-<name> properties, then opp-microvolt property shall be =
used, if
+  present.
+
 - opp-microamp: The maximum current drawn by the device in microamperes
   considering system specific parameters (such as transients, process, a=
ging,
   maximum operating temperature range etc.) as necessary. This may be us=
ed to
@@ -112,6 +120,9 @@ Optional properties:
   for few regulators, then this should be marked as zero for them. If it=
 isn't
   required for any regulator, then this property need not be present.
=20
+- opp-microamp-<name>: Named opp-microamp property. Similar to
+  opp-microvolt-<name> property, but for microamp instead.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (i=
n
   nanoseconds) for switching to this OPP from any other OPP.
=20
@@ -528,3 +539,39 @@ Example 6: opp-supported-hw
 		};
 	};
 };
+
+Example 7: opp-microvolt-<name>, opp-microamp-<name>:
+(example: device with two possible microvolt ranges: slow and fast)
+
+/ {
+	cpus {
+		cpu@0 {
+			compatible =3D "arm,cortex-a7";
+			...
+
+			operating-points-v2 =3D <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible =3D "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz =3D /bits/ 64 <1000000000>;
+			opp-microvolt-slow =3D <900000 915000 925000>;
+			opp-microvolt-fast =3D <970000 975000 985000>;
+			opp-microamp-slow =3D  <70000>;
+			opp-microamp-fast =3D  <71000>;
+		};
+
+		opp01 {
+			opp-hz =3D /bits/ 64 <1200000000>;
+			opp-microvolt-slow =3D <900000 915000 925000>, /* Supply vcc0 */
+					      <910000 925000 935000>; /* Supply vcc1 */
+			opp-microvolt-fast =3D <970000 975000 985000>, /* Supply vcc0 */
+					     <960000 965000 975000>; /* Supply vcc1 */
+			opp-microamp =3D  <70000>; /* Will be used for both slow/fast */
+		};
+	};
+};
--=20
2.27.0.rc0


--WkZjdEILTm4SfhAcr2hQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4715): https://lists.cip-project.org/g/cip-dev/message=
/4715
Mute This Topic: https://lists.cip-project.org/mt/74669311/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--WkZjdEILTm4SfhAcr2hQ--
