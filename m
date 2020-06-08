Return-Path: <SRS0=jjxv=7V=lists.cip-project.org=bounce+64572+4745+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0009AC433DF
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 09:30:55 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC012076A
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 09:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="icnJTkoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC012076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4745+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1nWlYY4521723xRQiAC0a62P; Mon, 08 Jun 2020 02:30:55 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web10.26298.1591608654317142648
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 02:30:54 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 679336013A; Mon,  8 Jun 2020 17:30:50 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v2 13/15] cpufreq-dt: Supply power coefficient when registering cooling devices
Date: Mon,  8 Jun 2020 17:30:26 +0800
Message-Id: <20200608093028.21612-14-wens@csie.org>
In-Reply-To: <20200608093028.21612-1-wens@csie.org>
References: <20200608093028.21612-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: m7xMOEeOfLHJNN5K3oAsO20hx4520388AA=
Content-Type: multipart/mixed; boundary="MEmCSLFggFCx5E4p1n6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591608655;
 bh=9tSXfkEk1oGOBU8iCWWEoj0kUx1uRCWtrqDGcXHR8Gg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=icnJTkoqlEtV2T41P9BEUDFAjklDJb8Ixyrs0SW8qiQ77Qnv1asRQvrb+RbH7DHYUfZ
 uP89kd1/gBi2JHav4+H9KBzD7EAVeXpcDDb8KRqh5ZonHU+n1sOICcnCgwPqoQ4mXKjO9
 saXQxOO6ENOs1i64OJBvvEED2fZAYO+YCD8=

--MEmCSLFggFCx5E4p1n6a
Content-Transfer-Encoding: quoted-printable

From: Punit Agrawal <punit.agrawal@arm.com>

commit f8fa8ae06b8c2c25d81c99766f9226adc5c3e073 upstream.

Support registering cooling devices with dynamic power coefficient
where provided by the device tree. This allows OF registered cooling
devices driver to be used with the power_allocator thermal governor.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 90d64081ddb34..1ceece9d67112 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -407,8 +407,13 @@ static void cpufreq_ready(struct cpufreq_policy *pol=
icy)
 	 * thermal DT code takes care of matching them.
 	 */
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		priv->cdev =3D of_cpufreq_cooling_register(np,
-							 policy->related_cpus);
+		u32 power_coefficient =3D 0;
+
+		of_property_read_u32(np, "dynamic-power-coefficient",
+				     &power_coefficient);
+
+		priv->cdev =3D of_cpufreq_power_cooling_register(np,
+				policy->related_cpus, power_coefficient, NULL);
 		if (IS_ERR(priv->cdev)) {
 			dev_err(priv->cpu_dev,
 				"running cpufreq without cooling device: %ld\n",
--=20
2.27.0.rc0


--MEmCSLFggFCx5E4p1n6a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4745): https://lists.cip-project.org/g/cip-dev/message=
/4745
Mute This Topic: https://lists.cip-project.org/mt/74748505/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--MEmCSLFggFCx5E4p1n6a--
