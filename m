Return-Path: <SRS0=IKsv=7V=lists.cip-project.org=bounce+64572+4747+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A91C433F1
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 09:30:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5934B206A4
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 09:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vh79C5ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5934B206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4747+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jUuQYY4521723xhlGZPDFMpX; Mon, 08 Jun 2020 02:30:56 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web10.26300.1591608654547438210
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 02:30:54 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 7D4416016E; Mon,  8 Jun 2020 17:30:50 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v2 15/15] cpufreq: cpufreq-dt: avoid uninitialized variable warnings:
Date: Mon,  8 Jun 2020 17:30:28 +0800
Message-Id: <20200608093028.21612-16-wens@csie.org>
In-Reply-To: <20200608093028.21612-1-wens@csie.org>
References: <20200608093028.21612-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qEPRuGlUnQvIKi6xjWs4vVWzx4520388AA=
Content-Type: multipart/mixed; boundary="Cx8vqBYDpV9FEyoNqHQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591608656;
 bh=3vdX190hCLZc/u5bhDri7zb+JzCs66kXBfQrBt2sJ14=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vh79C5eitO6WDU9hLMnuxBwFmYCv1e6ACVoHjzBNcQKThTRzEeSVwMDrjlnnLYPQK3b
 0oggLoomKvNZIPTUQwaoSRRFOhyv5pflz0hW8F6f87lnighm33MtzkoaYrziqB7iGYKqU
 q4oNIIuvUo8Mv8hQOWwl00mYJBqWKvq8gVU=

--Cx8vqBYDpV9FEyoNqHQr
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


--Cx8vqBYDpV9FEyoNqHQr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4747): https://lists.cip-project.org/g/cip-dev/message=
/4747
Mute This Topic: https://lists.cip-project.org/mt/74748508/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Cx8vqBYDpV9FEyoNqHQr--
