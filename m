Return-Path: <SRS0=R4x+=AT=lists.cip-project.org=bounce+64572+4897+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB65C433E0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0917206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pYQ2XPPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0917206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4897+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pj3mYY4521723xZdJXm6rm02; Wed, 08 Jul 2020 08:46:36 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13603.1594223182999272745
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:23 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 6D7E5602ED; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 13/23] cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency()
Date: Wed,  8 Jul 2020 23:45:44 +0800
Message-Id: <20200708154554.26450-14-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kvgV2OuVX5f4Yhkcq6rVxN0vx4520388AA=
Content-Type: multipart/mixed; boundary="XUAbCjhUlyHfiTSP0te0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223196;
 bh=05S5wMvZ0dwa8MdJnCiparNSs1MP/+siolPpi78C7MA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pYQ2XPPWnGHHX/BAS7AwQTPVXJo5zuDVRFkN/5kOgu4TSxJaBF0H5mwJ2XSSMZ2TTaW
 +FzmsAkPHbsVLrCOh70H+zUei6nBcI5EhKBc8jnZHiWXF1FJlslW4JVI40gX1ZnIC1cDP
 AL7ggZ64HRKyXR7mPJ/2WrpYYSDJDLj7LE8=

--XUAbCjhUlyHfiTSP0te0
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 755b888ff098c9f762717a9fbda7e05b16619069 upstream.

OPP layer has all the information now to calculate transition latency
(clock_latency + voltage_latency). Lets reuse the OPP layer helper
dev_pm_opp_get_max_transition_latency() instead of open coding the same
in cpufreq-dt driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 48 +++---------------------------------
 1 file changed, 4 insertions(+), 44 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c3fe89461ff45..6f80ce56b4eca 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -222,7 +222,6 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
 	struct dev_pm_opp *suspend_opp;
-	unsigned long min_uV =3D ~0, max_uV =3D 0;
 	unsigned int transition_latency;
 	bool opp_v1 =3D false;
 	const char *name;
@@ -316,49 +315,6 @@ static int cpufreq_init(struct cpufreq_policy *polic=
y)
 	priv->reg_name =3D name;
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance)=
;
=20
-	transition_latency =3D dev_pm_opp_get_max_clock_latency(cpu_dev);
-	if (!transition_latency)
-		transition_latency =3D CPUFREQ_ETERNAL;
-
-	if (!IS_ERR(cpu_reg)) {
-		unsigned long opp_freq =3D 0;
-
-		/*
-		 * Disable any OPPs where the connected regulator isn't able to
-		 * provide the specified voltage and record minimum and maximum
-		 * voltage levels.
-		 */
-		while (1) {
-			struct dev_pm_opp *opp;
-			unsigned long opp_uV, tol_uV;
-
-			rcu_read_lock();
-			opp =3D dev_pm_opp_find_freq_ceil(cpu_dev, &opp_freq);
-			if (IS_ERR(opp)) {
-				rcu_read_unlock();
-				break;
-			}
-			opp_uV =3D dev_pm_opp_get_voltage(opp);
-			rcu_read_unlock();
-
-			tol_uV =3D opp_uV * priv->voltage_tolerance / 100;
-			if (regulator_is_supported_voltage(cpu_reg,
-							   opp_uV - tol_uV,
-							   opp_uV + tol_uV)) {
-				if (opp_uV < min_uV)
-					min_uV =3D opp_uV;
-				if (opp_uV > max_uV)
-					max_uV =3D opp_uV;
-			}
-
-			opp_freq++;
-		}
-
-		ret =3D regulator_set_voltage_time(cpu_reg, min_uV, max_uV);
-		if (ret > 0)
-			transition_latency +=3D ret * 1000;
-	}
-
 	ret =3D dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
@@ -393,6 +349,10 @@ static int cpufreq_init(struct cpufreq_policy *polic=
y)
 		cpufreq_dt_attr[1] =3D &cpufreq_freq_attr_scaling_boost_freqs;
 	}
=20
+	transition_latency =3D dev_pm_opp_get_max_transition_latency(cpu_dev);
+	if (!transition_latency)
+		transition_latency =3D CPUFREQ_ETERNAL;
+
 	policy->cpuinfo.transition_latency =3D transition_latency;
=20
 	of_node_put(np);
--=20
2.27.0


--XUAbCjhUlyHfiTSP0te0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4897): https://lists.cip-project.org/g/cip-dev/message=
/4897
Mute This Topic: https://lists.cip-project.org/mt/75379089/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--XUAbCjhUlyHfiTSP0te0--
