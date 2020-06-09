Return-Path: <SRS0=LsFf=7W=lists.cip-project.org=bounce+64572+4786+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2603C433E8
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 04:10:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8234F206D5
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 04:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="R5oae0LL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8234F206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4786+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Wks1YY4521723xJeWAonhGKO; Mon, 08 Jun 2020 21:10:08 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.105.1591675802831782309
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 21:10:03 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 47C1E6002C; Tue,  9 Jun 2020 12:09:59 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip v3 10/14] PM / OPP: Use snprintf() instead of sprintf()
Date: Tue,  9 Jun 2020 12:09:22 +0800
Message-Id: <20200609040926.8910-11-wens@csie.org>
In-Reply-To: <20200609040926.8910-1-wens@csie.org>
References: <20200609040926.8910-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: z4dEHhrHUbAfPhmLxPYZZh1mx4520388AA=
Content-Type: multipart/mixed; boundary="p6asGHrz2B1I4d7WYdjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591675808;
 bh=DjV4wskIPFHXYE/f8bX4pY4C3PR6B2yLRS5AWSvCJHk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=R5oae0LL6ZYqQ0pncrHPEQZYoCwTDVWdciqYbtVWmpltWj+jUhqyTvjxUcQ2057V3lt
 m3JVnifVuxKIBklpHPLyyX6QiITposVMPSD2EJrwqMyJMPnh7TgyHMwbxOJL4tgIORh3e
 4sSV6OCKX8gohgxrXWx+e85EFyDNQRtQxAI=

--p6asGHrz2B1I4d7WYdjZ
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 5ff24d601092b222340b28466e263b1c4559407e upstream.

sprintf() can access memory outside of the range of the character array,
and is risky in some situations. The driver specified prop_name string
can be longer than NAME_MAX here (only an attacker will do that though)
and so blindly copying it into the character array of size NAME_MAX
isn't safe. Instead we must use snprintf() here.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 504a6d4e46723..1e0a2ddf73323 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -808,7 +808,8 @@ static int opp_parse_supplies(struct dev_pm_opp *opp,=
 struct device *dev,
=20
 	/* Search for "opp-microvolt-<name>" */
 	if (dev_opp->prop_name) {
-		sprintf(name, "opp-microvolt-%s", dev_opp->prop_name);
+		snprintf(name, sizeof(name), "opp-microvolt-%s",
+			 dev_opp->prop_name);
 		prop =3D of_find_property(opp->np, name, NULL);
 	}
=20
@@ -855,7 +856,8 @@ static int opp_parse_supplies(struct dev_pm_opp *opp,=
 struct device *dev,
 	/* Search for "opp-microamp-<name>" */
 	prop =3D NULL;
 	if (dev_opp->prop_name) {
-		sprintf(name, "opp-microamp-%s", dev_opp->prop_name);
+		snprintf(name, sizeof(name), "opp-microamp-%s",
+			 dev_opp->prop_name);
 		prop =3D of_find_property(opp->np, name, NULL);
 	}
=20
--=20
2.27.0.rc0


--p6asGHrz2B1I4d7WYdjZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4786): https://lists.cip-project.org/g/cip-dev/message=
/4786
Mute This Topic: https://lists.cip-project.org/mt/74768073/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--p6asGHrz2B1I4d7WYdjZ--
