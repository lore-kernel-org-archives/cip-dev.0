Return-Path: <SRS0=Gl+9=7V=lists.cip-project.org=bounce+64572+4757+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF87C433E1
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E096D2076A
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="V1xYg7ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E096D2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4757+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Ewh2YY4521723xBYvUuqhYhi; Mon, 08 Jun 2020 05:01:36 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web11.26099.1591607691131736590
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 02:14:51 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 099496013A; Mon,  8 Jun 2020 17:14:44 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v2 12/15] devicetree: bindings: Add optional dynamic-power-coefficient property
Date: Mon,  8 Jun 2020 17:14:29 +0800
Message-Id: <20200608091432.15366-13-wens@csie.org>
In-Reply-To: <20200608091432.15366-1-wens@csie.org>
References: <20200608091432.15366-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: g41tvgW5qaU6Mos5XHvtrMd0x4520388AA=
Content-Type: multipart/mixed; boundary="JcNbk44BBNwgMtuZwpog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591617696;
 bh=sI56ue8oIfX87QX6FP6UmH1cGf6WW3xN3e8NWciEaMQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=V1xYg7howJogwezu15sQOZH2fTXR3yhlyRitxC6e1sSpNLK5k56ylegX6Fx4ReCpolr
 Tl1ogwo71mrPfSVM/S7A5MsKLyohPvayLzJTglRFgD/63oHXiJvlayvXrc1k3msoq5sRr
 AuBcb0hE1p2PwmQPNYxEQW6KqUt1aZCs3aY=

--JcNbk44BBNwgMtuZwpog
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


--JcNbk44BBNwgMtuZwpog
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4757): https://lists.cip-project.org/g/cip-dev/message=
/4757
Mute This Topic: https://lists.cip-project.org/mt/74748506/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--JcNbk44BBNwgMtuZwpog--
