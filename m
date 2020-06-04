Return-Path: <SRS0=+fBw=7R=lists.cip-project.org=bounce+64572+4708+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F258FC433E4
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:35 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66EC20738
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QVoUGfbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66EC20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4708+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id R3Q8YY4521723xgLJ2AG40NO; Thu, 04 Jun 2020 04:55:35 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.6396.1591240767787424377
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 20:19:28 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 539BB60193; Thu,  4 Jun 2020 11:19:20 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: Arnd Bergmann <arnd@arndb.de>,
	cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [cip-dev] [4.4.y-cip 15/15] cpufreq: cpufreq-dt: avoid uninitialized variable warnings:
Date: Thu,  4 Jun 2020 11:18:29 +0800
Message-Id: <20200604031829.3254-16-wens@csie.org>
In-Reply-To: <20200604031829.3254-1-wens@csie.org>
References: <20200604031829.3254-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZDTMr53BaHPRNjXexGJsCLrox4520388AA=
Content-Type: multipart/mixed; boundary="8KP0scCWAjmWfSWwVYYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591271735;
 bh=AuoGIxaZXAwI1bHWY/I3FXkvRC0cNu3o3IfmT/MmsX0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QVoUGfbd0wYD7c0+DZxnoFgC38cxeSnjhcdMZE8eYkb6FlaRqvhVlQ/N/vUEqSspP2g
 o7ZC/uDb8wKY4P1iw9fc/5l1bFtOlZoRz2KR8YBkYKQzUdYOJTqZmyAW6G1US5smhZJuB
 CtbrSjM7bIfmKePv5U5Bc2DaaRrghCgJyUg=

--8KP0scCWAjmWfSWwVYYT
Content-Transfer-Encoding: quoted-printable

From: Arnd Bergmann <arnd@arndb.de>

commit b331bc20d9281213f7fb67912638e0fb5baeb324 upstream.

gcc warns quite a bit about values returned from allocate_resources()
in cpufreq-dt.c:

cpufreq-dt.c: In function 'cpufreq_init':
cpufreq-dt.c:327:6: error: 'cpu_dev' may be used uninitialized in this fu=
nction [-Werror=3Dmaybe-uninitialized]
cpufreq-dt.c:197:17: note: 'cpu_dev' was declared here
cpufreq-dt.c:376:2: error: 'cpu_clk' may be used uninitialized in this fu=
nction [-Werror=3Dmaybe-uninitialized]
cpufreq-dt.c:199:14: note: 'cpu_clk' was declared here
cpufreq-dt.c: In function 'dt_cpufreq_probe':
cpufreq-dt.c:461:2: error: 'cpu_clk' may be used uninitialized in this fu=
nction [-Werror=3Dmaybe-uninitialized]
cpufreq-dt.c:447:14: note: 'cpu_clk' was declared here

The problem is that it's slightly hard for gcc to follow return
codes across PTR_ERR() calls.

This patch uses explicit assignments to the "ret" variable to make
it easier for gcc to verify that the code is actually correct,
without the need to add a bogus initialization.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 9bc37c437874a..0ca74d0700583 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -142,15 +142,16 @@ static int allocate_resources(int cpu, struct devic=
e **cdev,
=20
 try_again:
 	cpu_reg =3D regulator_get_optional(cpu_dev, reg);
-	if (IS_ERR(cpu_reg)) {
+	ret =3D PTR_ERR_OR_ZERO(cpu_reg);
+	if (ret) {
 		/*
 		 * If cpu's regulator supply node is present, but regulator is
 		 * not yet registered, we should try defering probe.
 		 */
-		if (PTR_ERR(cpu_reg) =3D=3D -EPROBE_DEFER) {
+		if (ret =3D=3D -EPROBE_DEFER) {
 			dev_dbg(cpu_dev, "cpu%d regulator not ready, retry\n",
 				cpu);
-			return -EPROBE_DEFER;
+			return ret;
 		}
=20
 		/* Try with "cpu-supply" */
@@ -159,18 +160,16 @@ try_again:
 			goto try_again;
 		}
=20
-		dev_dbg(cpu_dev, "no regulator for cpu%d: %ld\n",
-			cpu, PTR_ERR(cpu_reg));
+		dev_dbg(cpu_dev, "no regulator for cpu%d: %d\n", cpu, ret);
 	}
=20
 	cpu_clk =3D clk_get(cpu_dev, NULL);
-	if (IS_ERR(cpu_clk)) {
+	ret =3D PTR_ERR_OR_ZERO(cpu_clk);
+	if (ret) {
 		/* put regulator */
 		if (!IS_ERR(cpu_reg))
 			regulator_put(cpu_reg);
=20
-		ret =3D PTR_ERR(cpu_clk);
-
 		/*
 		 * If cpu's clk node is present, but clock is not yet
 		 * registered, we should try defering probe.
--=20
2.27.0.rc0


--8KP0scCWAjmWfSWwVYYT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4708): https://lists.cip-project.org/g/cip-dev/message=
/4708
Mute This Topic: https://lists.cip-project.org/mt/74669306/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--8KP0scCWAjmWfSWwVYYT--
