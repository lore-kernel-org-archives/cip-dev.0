Return-Path: <SRS0=xUtL=AT=lists.cip-project.org=bounce+64572+4899+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A0C433E0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E3A206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EpeYNzyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E3A206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4899+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id D5CsYY4521723xl31hMYg2iD; Wed, 08 Jul 2020 08:46:39 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13605.1594223183098830194
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:23 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 7291760206; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 14/23] cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
Date: Wed,  8 Jul 2020 23:45:45 +0800
Message-Id: <20200708154554.26450-15-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mcesLHoqk9aV6riMK34DeJHjx4520388AA=
Content-Type: multipart/mixed; boundary="A9dAx2l0f3249z5dfomQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223199;
 bh=1+Lp3gQsv3Jf4r5KXyXo/aqZy5wsqrIFlfwKBf5VptA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EpeYNzyU8G6zL+OtQq4NVmXyzg59Iy5GNl14N3tFG0j/TlZIImEct0qPZ/O+U+A46Jn
 xOc7vmLbUGALD3u0XFBtO66dNskA6MU5E5mSTPdbwq4ekJnjs7Z1Ji3hP6eq3kgLuyJxD
 CUOrPs6AyGdVff+Ph7NL9QzuTXGKxfmT1ug=

--A9dAx2l0f3249z5dfomQ
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 78c3ba5df96c875b1668e1cd3ee0a69e62454f32 upstream.

OPP core supports frequency/voltage changes based on the target
frequency now, use that instead of open coding the same in cpufreq-dt
driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 73 +-----------------------------------
 1 file changed, 2 insertions(+), 71 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 6f80ce56b4eca..150a172c7d0a7 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -45,79 +45,10 @@ static struct freq_attr *cpufreq_dt_attr[] =3D {
=20
 static int set_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	struct dev_pm_opp *opp;
-	struct cpufreq_frequency_table *freq_table =3D policy->freq_table;
-	struct clk *cpu_clk =3D policy->clk;
 	struct private_data *priv =3D policy->driver_data;
-	struct device *cpu_dev =3D priv->cpu_dev;
-	struct regulator *cpu_reg =3D priv->cpu_reg;
-	unsigned long volt =3D 0, tol =3D 0;
-	int volt_old =3D 0;
-	unsigned int old_freq, new_freq;
-	long freq_Hz, freq_exact;
-	int ret;
-
-	freq_Hz =3D clk_round_rate(cpu_clk, freq_table[index].frequency * 1000)=
;
-	if (freq_Hz <=3D 0)
-		freq_Hz =3D freq_table[index].frequency * 1000;
-
-	freq_exact =3D freq_Hz;
-	new_freq =3D freq_Hz / 1000;
-	old_freq =3D clk_get_rate(cpu_clk) / 1000;
-
-	if (!IS_ERR(cpu_reg)) {
-		unsigned long opp_freq;
-
-		rcu_read_lock();
-		opp =3D dev_pm_opp_find_freq_ceil(cpu_dev, &freq_Hz);
-		if (IS_ERR(opp)) {
-			rcu_read_unlock();
-			dev_err(cpu_dev, "failed to find OPP for %ld\n",
-				freq_Hz);
-			return PTR_ERR(opp);
-		}
-		volt =3D dev_pm_opp_get_voltage(opp);
-		opp_freq =3D dev_pm_opp_get_freq(opp);
-		rcu_read_unlock();
-		tol =3D volt * priv->voltage_tolerance / 100;
-		volt_old =3D regulator_get_voltage(cpu_reg);
-		dev_dbg(cpu_dev, "Found OPP: %ld kHz, %ld uV\n",
-			opp_freq / 1000, volt);
-	}
-
-	dev_dbg(cpu_dev, "%u MHz, %d mV --> %u MHz, %ld mV\n",
-		old_freq / 1000, (volt_old > 0) ? volt_old / 1000 : -1,
-		new_freq / 1000, volt ? volt / 1000 : -1);
-
-	/* scaling up?  scale voltage before frequency */
-	if (!IS_ERR(cpu_reg) && new_freq > old_freq) {
-		ret =3D regulator_set_voltage_tol(cpu_reg, volt, tol);
-		if (ret) {
-			dev_err(cpu_dev, "failed to scale voltage up: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	ret =3D clk_set_rate(cpu_clk, freq_exact);
-	if (ret) {
-		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
-		if (!IS_ERR(cpu_reg) && volt_old > 0)
-			regulator_set_voltage_tol(cpu_reg, volt_old, tol);
-		return ret;
-	}
=20
-	/* scaling down?  scale voltage after frequency */
-	if (!IS_ERR(cpu_reg) && new_freq < old_freq) {
-		ret =3D regulator_set_voltage_tol(cpu_reg, volt, tol);
-		if (ret) {
-			dev_err(cpu_dev, "failed to scale voltage down: %d\n",
-				ret);
-			clk_set_rate(cpu_clk, old_freq * 1000);
-		}
-	}
-
-	return ret;
+	return dev_pm_opp_set_rate(priv->cpu_dev,
+				   policy->freq_table[index].frequency * 1000);
 }
=20
 /*
--=20
2.27.0


--A9dAx2l0f3249z5dfomQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4899): https://lists.cip-project.org/g/cip-dev/message=
/4899
Mute This Topic: https://lists.cip-project.org/mt/75379091/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--A9dAx2l0f3249z5dfomQ--
