Return-Path: <SRS0=bw6L=CS=lists.cip-project.org=bounce+64572+5428+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECECC2D0F6
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739F521D43
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RDJZlnDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739F521D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5428+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HkTuYY4521723xUg3EbLEYxW; Tue, 08 Sep 2020 21:44:47 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web11.6576.1599626683742757130
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:44 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 18CAA601BD; Wed,  9 Sep 2020 12:44:33 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 09/11] cpufreq: dt: Don't use generic platdev driver for ti-cpufreq platforms
Date: Wed,  9 Sep 2020 12:42:31 +0800
Message-Id: <20200909044233.4115-10-wens@csie.org>
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: c95JAb6WlWAJJtS4SIAhN8X9x4520388AA=
Content-Type: multipart/mixed; boundary="kk2tSPbfYEqk7YINRxMS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626687;
 bh=jH5Toe9NBeT6FFvV5wyTEWmEjqNBHi5zj2qBVP6kA7Y=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=RDJZlnDCT3FEBW7LOVTCuqD1xYPewSnf23nf3lSYU3zX2YcBL0usuncjjA15PmGqeuY
 ZU2mwX20Qgo0e+g+uF1dhR4YAj1OlKCF94IIeyooxR5uQvASnlFsyCrPbyyG3jPYBKO6o
 ZR/L66rsXKaTQptfTA8QOx+DI9s/lyppidk=

--kk2tSPbfYEqk7YINRxMS
Content-Transfer-Encoding: quoted-printable

From: Dave Gerlach <d-gerlach@ti.com>

commit 051bd84bb45bc994b7d762467f60b3bd0c7aa6bc upstream.

Some TI platforms, specifically those in the am33xx, am43xx, dra7xx, and
am57xx families of SoCs can make use of the ti-cpufreq driver to
selectively enable OPPs based on the exact configuration in use. The
ti-cpufreq is given the responsibility of creating the cpufreq-dt
platform device when the driver is in use so drop am33xx and dra7xx
from the cpufreq-dt-platdev driver so it is not created twice.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[wens@csie.org: Backport to pre generic platdev driver]
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---

I kept the original patch subject to make it easier for scripts to match
against upstream patches.

---
 arch/arm/mach-omap2/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 3d876bde8c859..88cb34c608ab8 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -281,6 +281,9 @@ static inline void omap_init_cpufreq(void)
=20
 	if (!of_have_populated_dt())
 		devinfo.name =3D "omap-cpufreq";
+	else if (of_machine_is_compatible("ti,am33xx") ||
+		 of_machine_is_compatible("ti,dra7"))
+		return;
 	else
 		devinfo.name =3D "cpufreq-dt";
 	platform_device_register_full(&devinfo);
--=20
2.28.0


--kk2tSPbfYEqk7YINRxMS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5428): https://lists.cip-project.org/g/cip-dev/message=
/5428
Mute This Topic: https://lists.cip-project.org/mt/76726432/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--kk2tSPbfYEqk7YINRxMS--
