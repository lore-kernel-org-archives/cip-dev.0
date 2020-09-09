Return-Path: <SRS0=/z78=CS=lists.cip-project.org=bounce+64572+5424+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBF0C2D0E3
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18C621D46
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VRnjJZxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18C621D46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5424+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ttV3YY4521723x29NTBlE6fc; Tue, 08 Sep 2020 21:44:46 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.6633.1599626683531375698
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:43 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 0ACC560161; Wed,  9 Sep 2020 12:44:33 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 07/11] cpufreq: ti-cpufreq: add missing of_node_put()
Date: Wed,  9 Sep 2020 12:42:29 +0800
Message-Id: <20200909044233.4115-8-wens@csie.org>
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rknFToWfuBQSK5QYr4tcKEcex4520388AA=
Content-Type: multipart/mixed; boundary="AURPQwxApDkt9yV1mWjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626686;
 bh=QfHKZdUUz06vpW2u4nx/qJ7s8ul0JBDsywVwhLqwcJ4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VRnjJZxwZisfLrKVW5+DAd7nZwttcvc4yQW/vvMlEDS3q6Qc5WxMLQXOucsCCdo5oLl
 x5z8DdekBincFC/fCHiUnNvvfhrvJmtifpgoaLek5hQttGZ5uq2PTp5dx6mJDW+ipmQc0
 ljajZzLd0Uu23H2mJkROfuVIGhiDgFCiMrI=

--AURPQwxApDkt9yV1mWjp
Content-Transfer-Encoding: quoted-printable

From: Zumeng Chen <zumeng.chen@gmail.com>

commit 248aefdcc3a7e0cfbd014946b4dead63e750e71b upstream.

call of_node_put to release the refcount of np.

Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/cpufreq/ti-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 36627b2b256f8..afbe9db29992d 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -205,6 +205,7 @@ static int ti_cpufreq_init(void)
=20
 	np =3D of_find_node_by_path("/");
 	match =3D of_match_node(ti_cpufreq_of_match, np);
+	of_node_put(np);
 	if (!match)
 		return -ENODEV;
=20
--=20
2.28.0


--AURPQwxApDkt9yV1mWjp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5424): https://lists.cip-project.org/g/cip-dev/message=
/5424
Mute This Topic: https://lists.cip-project.org/mt/76726428/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--AURPQwxApDkt9yV1mWjp--
