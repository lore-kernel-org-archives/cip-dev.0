Return-Path: <SRS0=lkIg=AT=lists.cip-project.org=bounce+64572+4898+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CD5C433DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9DD20720
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TSRaHnWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9DD20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4898+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NdYEYY4521723xW7B9x7BJp8; Wed, 08 Jul 2020 08:46:34 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13604.1594223183007296956
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:23 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 5620A60180; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 09/23] cpufreq: dt: Rename 'need_update' to 'opp_v1'
Date: Wed,  8 Jul 2020 23:45:40 +0800
Message-Id: <20200708154554.26450-10-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xCzAarxmCj1p2Mxuy2oY03Onx4520388AA=
Content-Type: multipart/mixed; boundary="3Fml2DkU8kIJ548Enhn3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223194;
 bh=KAttjiG0N0i5V7rG8vkJv2FuLPQD+WwiLWWJdDRU2DA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=TSRaHnWMGU0Z3QeansmLZQL6Bwa660SQFaSpjNQyFMxVVnqF2/HTpHGIkMpnS5Mo07a
 Qc/Ce6PXH7FPEiEbL2nLK3oZyKaos+dKojHbQoUg0gY36swChO7tPS6hYYi9z3U8a2YxH
 5gevzJEIG7dG/tci51LQipNFm7dgZ0PZ5No=

--3Fml2DkU8kIJ548Enhn3
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 457e99e60a8f5a40b7da204c0bfc8a86ad2161b9 upstream.

That's the real purpose of this field, i.e. to take special care of old
OPP V1 bindings. Lets name it accordingly, so that it can be used
elsewhere.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index ace0168274d4b..0047d20803db7 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -199,7 +199,7 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 	struct dev_pm_opp *suspend_opp;
 	unsigned long min_uV =3D ~0, max_uV =3D 0;
 	unsigned int transition_latency;
-	bool need_update =3D false;
+	bool opp_v1 =3D false;
 	int ret;
=20
 	ret =3D allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
@@ -223,7 +223,7 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 		 * finding shared-OPPs for backward compatibility.
 		 */
 		if (ret =3D=3D -ENOENT)
-			need_update =3D true;
+			opp_v1 =3D true;
 		else
 			goto out_node_put;
 	}
@@ -251,7 +251,7 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 		goto out_free_opp;
 	}
=20
-	if (need_update) {
+	if (opp_v1) {
 		struct cpufreq_dt_platform_data *pd =3D cpufreq_get_driver_data();
=20
 		if (!pd || !pd->independent_clocks)
--=20
2.27.0


--3Fml2DkU8kIJ548Enhn3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4898): https://lists.cip-project.org/g/cip-dev/message=
/4898
Mute This Topic: https://lists.cip-project.org/mt/75379090/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--3Fml2DkU8kIJ548Enhn3--
