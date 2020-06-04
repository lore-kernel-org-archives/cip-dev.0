Return-Path: <SRS0=hleO=7R=lists.cip-project.org=bounce+64572+4705+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A57C433DF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A870720738
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ZhVYtAMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A870720738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4705+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mAmTYY4521723xs8Wo1HfF8o; Thu, 04 Jun 2020 04:55:34 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web10.6604.1591240766361827726
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 20:19:26 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 155C860020; Thu,  4 Jun 2020 11:19:20 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [cip-dev] [4.4.y-cip 09/15] PM / OPP: Fix parsing of opp-microvolt and opp-microamp properties
Date: Thu,  4 Jun 2020 11:18:23 +0800
Message-Id: <20200604031829.3254-10-wens@csie.org>
In-Reply-To: <20200604031829.3254-1-wens@csie.org>
References: <20200604031829.3254-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hxejgU508Xx0Zll5mBzV9Qpxx4520388AA=
Content-Type: multipart/mixed; boundary="ATPkSmVCjT3wqWGq0ID8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591271734;
 bh=1lnjicHdfglqj5/pS43/CEt4bvz4WjhBfVtIjOV3spg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZhVYtAMRk+SaRWPzrVwluR2l9QDbwEm9K93SmoWYCU/qCLaEK8P0MRlZJRX97fakWyv
 8bDpzt+5KBz811Kq/p1izRLh4+BpZ1FlknG3nMQf8S6b0nE49qhKNLRsWMS8YiZvzMEB6
 /l3eAJVKLpSeF+rR3RPU5H+Tu8oYBn/gI8c=

--ATPkSmVCjT3wqWGq0ID8
Content-Transfer-Encoding: quoted-printable

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

commit fd8d8e63467c922be9ae4452cca2980d473477d9 upstream.

Commit 01fb4d3c39d3 ("PM / OPP: Parse 'opp-<prop>-<name>'
bindings") broke support for parsing standard opp-microvolt and
opp-microamp properties.  Fix it by setting 'name' string to
proper value for !prop cases.

Fixes: 01fb4d3c39d3 ("PM / OPP: Parse 'opp-<prop>-<name> 'bindings")
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 408fee4cb72df..504a6d4e46723 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -814,7 +814,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp,=
 struct device *dev,
=20
 	if (!prop) {
 		/* Search for "opp-microvolt" */
-		name[13] =3D '\0';
+		sprintf(name, "opp-microvolt");
 		prop =3D of_find_property(opp->np, name, NULL);
=20
 		/* Missing property isn't a problem, but an invalid entry is */
@@ -861,7 +861,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp,=
 struct device *dev,
=20
 	if (!prop) {
 		/* Search for "opp-microamp" */
-		name[12] =3D '\0';
+		sprintf(name, "opp-microamp");
 		prop =3D of_find_property(opp->np, name, NULL);
 	}
=20
--=20
2.27.0.rc0


--ATPkSmVCjT3wqWGq0ID8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4705): https://lists.cip-project.org/g/cip-dev/message=
/4705
Mute This Topic: https://lists.cip-project.org/mt/74669303/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ATPkSmVCjT3wqWGq0ID8--
