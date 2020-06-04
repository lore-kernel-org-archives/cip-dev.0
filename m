Return-Path: <SRS0=S2Xq=7R=lists.cip-project.org=bounce+64572+4714+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E202C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4F82075B
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oTuBTz6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4F82075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4714+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FUDzYY4521723xfSHUYDEXKV; Thu, 04 Jun 2020 04:55:36 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.6395.1591240766610050925
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 20:19:26 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 30BB360092; Thu,  4 Jun 2020 11:19:20 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: Punit Agrawal <punit.agrawal@arm.com>,
	cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	Rob Herring <robh@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [cip-dev] [4.4.y-cip 12/15] devicetree: bindings: Add optional dynamic-power-coefficient property
Date: Thu,  4 Jun 2020 11:18:26 +0800
Message-Id: <20200604031829.3254-13-wens@csie.org>
In-Reply-To: <20200604031829.3254-1-wens@csie.org>
References: <20200604031829.3254-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XTDx2y8TRtELLbx1ynDBaWgYx4520388AA=
Content-Type: multipart/mixed; boundary="aOYp4zWwOZKBRYQMupa9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591271736;
 bh=/AwOmJaV4tgFkGfDn0WKz1sstyu7cc697YGPtaFK1LQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=oTuBTz6gk4n5WeE7Ng+/nAXA25iTmaM/YsY3I981T7dDADBanP5ksrueIUYDXRZ1RAm
 +K0IfijSVVquAlOce2k0YBuhgSrrZXlZ+QYvFXCb4dvhcqtCNX6E9IOLtUbgcgwH2DMQ9
 S7MzWfhdxPpg59Cpkr/Uu5GsmLREyj9/WGE=

--aOYp4zWwOZKBRYQMupa9
Content-Transfer-Encoding: quoted-printable

From: Punit Agrawal <punit.agrawal@arm.com>

commit 3be3f8f36e7349006f19c8c8f0d686e98462a993 upstream.

The dynamic power consumption of a device is proportional to the
square of voltage (V) and the clock frequency (f). It can be expressed as

Pdyn =3D dynamic-power-coefficient * V^2 * f.

The coefficient represents the running time dynamic power consumption in
units of mw/MHz/uVolt^2 and can be used in the above formula to
calculate the dynamic power in mW.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentati=
on/devicetree/bindings/arm/cpus.txt
index 9ef9a2089a5e7..6b1d8ebb94b7b 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -243,6 +243,23 @@ nodes to be present and contain the properties descr=
ibed below.
 		Definition: Specifies the syscon node controlling the cpu core
 			    power domains.
=20
+	- dynamic-power-coefficient
+		Usage: optional
+		Value type: <prop-encoded-array>
+		Definition: A u32 value that represents the running time dynamic
+			    power coefficient in units of mW/MHz/uVolt^2. The
+			    coefficient can either be calculated from power
+			    measurements or derived by analysis.
+
+			    The dynamic power consumption of the CPU  is
+			    proportional to the square of the Voltage (V) and
+			    the clock frequency (f). The coefficient is used to
+			    calculate the dynamic power as below -
+
+			    Pdyn =3D dynamic-power-coefficient * V^2 * f
+
+			    where voltage is in uV, frequency is in MHz.
+
 Example 1 (dual-cluster big.LITTLE system 32-bit):
=20
 	cpus {
--=20
2.27.0.rc0


--aOYp4zWwOZKBRYQMupa9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4714): https://lists.cip-project.org/g/cip-dev/message=
/4714
Mute This Topic: https://lists.cip-project.org/mt/74669310/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--aOYp4zWwOZKBRYQMupa9--
