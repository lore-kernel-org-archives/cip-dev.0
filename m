Return-Path: <SRS0=zY9d=7W=lists.cip-project.org=bounce+64572+4785+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D3C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 04:10:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386A7206D5
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 04:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Qs7bT95t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386A7206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4785+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YFwvYY4521723xejlcz6ZqaB; Mon, 08 Jun 2020 21:10:08 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web11.94.1591675802792298557
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 21:10:03 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 4DE9060089; Tue,  9 Jun 2020 12:09:59 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v3 11/14] devicetree: bindings: Add optional dynamic-power-coefficient property
Date: Tue,  9 Jun 2020 12:09:23 +0800
Message-Id: <20200609040926.8910-12-wens@csie.org>
In-Reply-To: <20200609040926.8910-1-wens@csie.org>
References: <20200609040926.8910-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: weF68kuCWOnq2c77knqIKwNkx4520388AA=
Content-Type: multipart/mixed; boundary="DfaRf5KCOUsotrllAmrk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591675808;
 bh=diFA8CCciGO2thaSedf4yBX1CU5lQZIvxhovj+0Bq68=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Qs7bT95tXpkevaMvSCn8oqXu+hzUnA778v8C+jpTEZf1JRmVkPxDx2ipapvqNs12y/9
 MgiEgYLuh8Rtrg0NTfAqgrbc+Q2OYEFcRdhJm2Phzh630v9n6/NPwTprMfRotn6AnPuyb
 iq5867Q3GM50Gv/vQRiFo7pzbBwegd6OvIg=

--DfaRf5KCOUsotrllAmrk
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


--DfaRf5KCOUsotrllAmrk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4785): https://lists.cip-project.org/g/cip-dev/message=
/4785
Mute This Topic: https://lists.cip-project.org/mt/74768072/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--DfaRf5KCOUsotrllAmrk--
