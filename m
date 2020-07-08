Return-Path: <SRS0=C6NG=AT=lists.cip-project.org=bounce+64572+4894+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D4DC433E0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5352A206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vRD7JcSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5352A206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4894+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SnyLYY4521723xZXGxd2Wavh; Wed, 08 Jul 2020 08:46:32 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.13562.1594223182774084191
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:23 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 6840060265; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 12/23] cpufreq: dt: Unsupported OPPs are already disabled
Date: Wed,  8 Jul 2020 23:45:43 +0800
Message-Id: <20200708154554.26450-13-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jftdkwQr0NPorpfoLrEnnaHhx4520388AA=
Content-Type: multipart/mixed; boundary="vavfg3ALHQ66d0F30R19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223192;
 bh=IEhBXRL98vu8zNiLA4P675oJdqdgsRm+4LXfxf734lM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vRD7JcSwwvJaciJgFbyTTHGKdLR8ntEPqoQZ6Y7BetOVvMIzLYS19pGuAHY+XAlxKf5
 uFUgLsbmzktxID05XkWyCMbLbAfxNnRLyemMl5B1JUhTaVvILW96ubwz7NA4Qo+2iLn2h
 YDHxUOtnKPw5hi2wx5pdL2/5OHN8LUVg5co=

--vavfg3ALHQ66d0F30R19
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 6def6ea75e6dea45f01a16ae3cfb5b5ce48dd5e9 upstream.

The core already have a valid regulator set for the device opp and the
unsupported OPPs are already disabled by the core. There is no need to
repeat that in the user drivers, get rid of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/cpufreq-dt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 2af75f8088bbb..c3fe89461ff45 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -349,8 +349,6 @@ static int cpufreq_init(struct cpufreq_policy *policy=
)
 					min_uV =3D opp_uV;
 				if (opp_uV > max_uV)
 					max_uV =3D opp_uV;
-			} else {
-				dev_pm_opp_disable(cpu_dev, opp_freq);
 			}
=20
 			opp_freq++;
--=20
2.27.0


--vavfg3ALHQ66d0F30R19
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4894): https://lists.cip-project.org/g/cip-dev/message=
/4894
Mute This Topic: https://lists.cip-project.org/mt/75379086/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--vavfg3ALHQ66d0F30R19--
