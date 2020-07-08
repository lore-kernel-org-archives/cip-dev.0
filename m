Return-Path: <SRS0=GG3j=AT=lists.cip-project.org=bounce+64572+4900+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65013C433DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FC220720
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="E5a2nF07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FC220720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4900+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xpboYY4521723xMCzJg7PeIj; Wed, 08 Jul 2020 08:46:37 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13606.1594223183124074776
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:23 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 4D41E6010D; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 08/23] cpufreq: dt: Convert few pr_debug/err() calls to dev_dbg/err()
Date: Wed,  8 Jul 2020 23:45:39 +0800
Message-Id: <20200708154554.26450-9-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gBoVmhOOQAby0HBKiTIMdyzJx4520388AA=
Content-Type: multipart/mixed; boundary="j2hGg5UPh7vCBgyMJKyd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223197;
 bh=DcuYS846Z9hYKQY5296OnUrfKgrEh+ZPSjJZaa1j6ks=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=E5a2nF07cQc+4IIfN2g2L1AGp9ZzbolP6Bao68TxqmCOOG+m3lCDOg+9oaVGTZtMhiF
 C8nQZh+O9OMspk0NOZsX9WoENZKDytqTNBw+mz34H16fo8p6GujIKxkaYI27eNEAJcJ7T
 lxtYmyJSLGn2B2pgJ0ES4+XoOhkLmYmxewo=

--j2hGg5UPh7vCBgyMJKyd
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 896d6a4c0f41a93809b83f9e58aad73874a89d99 upstream.

We have the device structure available now, lets use it for better print
messages.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 0ca74d0700583..ace0168274d4b 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -246,7 +246,7 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 	 */
 	ret =3D dev_pm_opp_get_opp_count(cpu_dev);
 	if (ret <=3D 0) {
-		pr_debug("OPP table is not ready, deferring probe\n");
+		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
 		ret =3D -EPROBE_DEFER;
 		goto out_free_opp;
 	}
@@ -325,7 +325,7 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
=20
 	ret =3D dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
-		pr_err("failed to init cpufreq table: %d\n", ret);
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
 		goto out_free_priv;
 	}
=20
--=20
2.27.0


--j2hGg5UPh7vCBgyMJKyd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4900): https://lists.cip-project.org/g/cip-dev/message=
/4900
Mute This Topic: https://lists.cip-project.org/mt/75379092/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--j2hGg5UPh7vCBgyMJKyd--
