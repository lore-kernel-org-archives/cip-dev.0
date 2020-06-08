Return-Path: <SRS0=Cgfh=7V=lists.cip-project.org=bounce+64572+4759+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B208C433E6
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA992078C
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cW46oErJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA992078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4759+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rk0fYY4521723xDsN1sceSPZ; Mon, 08 Jun 2020 05:01:37 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.26179.1591607691081701760
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 02:14:51 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id E1BF160092; Mon,  8 Jun 2020 17:14:43 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v2 09/15] PM / OPP: Fix parsing of opp-microvolt and opp-microamp properties
Date: Mon,  8 Jun 2020 17:14:26 +0800
Message-Id: <20200608091432.15366-10-wens@csie.org>
In-Reply-To: <20200608091432.15366-1-wens@csie.org>
References: <20200608091432.15366-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NmkBcgQriEE1bnqZQkbdwY9Px4520388AA=
Content-Type: multipart/mixed; boundary="wjyNMWABrDLuOC8vYggg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591617697;
 bh=lLsPvnpfyr/7w5HCTIp3ElaV98eKU34V6Tc5Ya9gmtA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cW46oErJ8qWACEmXuUi9QVHmRalYdDOyG2ow4Ki1ZW+BZuQol6x1r7Bz971r1JqpB3D
 HUW9aCOLlJE/ZyvDM0wIx/vmEJjhVamUwomVjrmSTBjY+7IcPmsnjHDTTpoGYPaxwfycp
 Gv9i+HgVdL7QNMgKbhJCdbrji8yvtY0hCl8=

--wjyNMWABrDLuOC8vYggg
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


--wjyNMWABrDLuOC8vYggg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4759): https://lists.cip-project.org/g/cip-dev/message=
/4759
Mute This Topic: https://lists.cip-project.org/mt/74748500/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wjyNMWABrDLuOC8vYggg--
