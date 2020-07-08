Return-Path: <SRS0=Soxr=AT=lists.cip-project.org=bounce+64572+4907+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A41C433E1
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:49 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BFB207DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MH20tQEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BFB207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4907+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mkIIYY4521723xyYifWXuVVB; Wed, 08 Jul 2020 08:46:47 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13612.1594223184726015876
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:25 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id BE512608FC; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 22/23] PM / OPP: Remove useless check
Date: Wed,  8 Jul 2020 23:45:53 +0800
Message-Id: <20200708154554.26450-23-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QYdS88do2rzXapWW9gHxW3q6x4520388AA=
Content-Type: multipart/mixed; boundary="momUEAru02DWoGJKNfME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223207;
 bh=B0el0livnC/+zz6M3xbpf4JxR5sXx7aq0ayNSVaYy5g=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MH20tQEVU8A9mPJdRfdxtqLBrNf05XHD5+N/KDPgMXu75Sz6HBv1lZdjfFHJzB2MXR3
 Us1+OS5/pFkT+Ofo+1VWYVyckXjj02ySxAZE+Ce1kZ8Eq0TwTXvzJhtQOm1avizeoZs8z
 27cIsMI6Hq+PZMST5p1SyerVlBwS542yyiI=

--momUEAru02DWoGJKNfME
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 21f8a99ce61b2d4b74bd425a5bf7e9efbe162788 upstream.

Regulators are optional for devices using OPPs and the OPP core
shouldn't be printing any errors for such missing regulators.

It was fine before the commit 0c717d0f9cb4, but that failed to update
this part of the code to remove an 'always true' check and an extra
unwanted print message.

Fix that now.

Fixes: 0c717d0f9cb4 (PM / OPP: Initialize regulator pointer to an error v=
alue)
Reported-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 7fc3848df17f5..c91eacf8d2ed3 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -259,9 +259,6 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct =
device *dev)
 	reg =3D opp_table->regulator;
 	if (IS_ERR(reg)) {
 		/* Regulator may not be required for device */
-		if (reg)
-			dev_err(dev, "%s: Invalid regulator (%ld)\n", __func__,
-				PTR_ERR(reg));
 		rcu_read_unlock();
 		return 0;
 	}
--=20
2.27.0


--momUEAru02DWoGJKNfME
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4907): https://lists.cip-project.org/g/cip-dev/message=
/4907
Mute This Topic: https://lists.cip-project.org/mt/75379099/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--momUEAru02DWoGJKNfME--
