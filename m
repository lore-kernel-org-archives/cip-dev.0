Return-Path: <SRS0=yBEs=7R=lists.cip-project.org=bounce+64572+4707+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F66C433E1
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:35 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7600B20738
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hLk1AWJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7600B20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4707+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ohcvYY4521723xc0h9ZJWprf; Thu, 04 Jun 2020 04:55:35 -0700
X-Received: from wens.tw (wens.tw [140.112.30.76])
 by mx.groups.io with SMTP id smtpd.web12.6394.1591240766006506977
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 20:19:26 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 261DE6010D; Thu,  4 Jun 2020 11:19:20 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@codeaurora.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [cip-dev] [4.4.y-cip 11/15] PM / OPP: Use snprintf() instead of sprintf()
Date: Thu,  4 Jun 2020 11:18:25 +0800
Message-Id: <20200604031829.3254-12-wens@csie.org>
In-Reply-To: <20200604031829.3254-1-wens@csie.org>
References: <20200604031829.3254-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QIqZ4nLfl4ogbnb1RW4vm0WGx4520388AA=
Content-Type: multipart/mixed; boundary="NuuRxodksAZfFLBpfSk4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591271735;
 bh=w7TmqkU/37HAhWPmgPYsFaSh8mK+QkdeSUGfEzulHdE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=hLk1AWJKdHQARlX/7vQlas18IZYLVpwfqzrUY5xHE+cTjoHvoZAnaOP+YXFyQBANbL5
 LeZBeYDI3lZxlQ/NHvrJVM2KGCJeKNWbsI/BkKRSOUbRbyxekbs6W7wUwKwkktBHb6/+d
 syfv+ZFC32FelnOMotBI7puDXahEtMhzKUg=

--NuuRxodksAZfFLBpfSk4
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


--NuuRxodksAZfFLBpfSk4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4707): https://lists.cip-project.org/g/cip-dev/message=
/4707
Mute This Topic: https://lists.cip-project.org/mt/74669305/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--NuuRxodksAZfFLBpfSk4--
