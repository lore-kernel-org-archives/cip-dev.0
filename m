Return-Path: <SRS0=nhuW=AT=lists.cip-project.org=bounce+64572+4903+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D21C433E0
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF32720720
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WNP8aiqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF32720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4903+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ngDAYY4521723x6vBCPGvoSH; Wed, 08 Jul 2020 08:46:41 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13609.1594223184594459711
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:24 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id A0BC160823; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 18/23] PM / OPP: Initialize regulator pointer to an error value
Date: Wed,  8 Jul 2020 23:45:49 +0800
Message-Id: <20200708154554.26450-19-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: X7ICcuwE3gMmJfRuq9BfylC0x4520388AA=
Content-Type: multipart/mixed; boundary="QPeibYm6SItRlt3zDrw9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223201;
 bh=U7e21uc5wl0ykhCcoZL+56z+Ca196pGsJvZ7PkvttrA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WNP8aiqwrDzfLQJw9ERNG1oFfA4JrcEjMVthg5igrOydZn9icl32plffyyeJP0KbK2R
 OBUsJBrdfsCwpzGJQkYl1Qz5B050dQNxtXOIgc6nng/ZyAbq1dFyqCQtiVfBX3jFZZfTB
 SabAqKjpSSj4AzYzx8r1pl9N8fkUCzDRkLM=

--QPeibYm6SItRlt3zDrw9
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 0c717d0f9cb46259dce5272705adce64a2d646d9 upstream.

We are currently required to do two checks for regulator pointer:
IS_ERR() and IS_NULL().

And multiple instances are reported, about both of these not being used
consistently and so resulting in crashes.

Fix that by initializing regulator pointer with an error value and
checking it only against an error.

This makes code more consistent and more efficient.

Fixes: 7d34d56ef334 (PM / OPP: Disable OPPs that aren't supported by the =
regulator)
Reported-and-tested-by: Jon Hunter <jonathanh@nvidia.com>
Reported-and-tested-by: Tony Lindgren <tony@atomide.com>
Reported-and-tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
[ rjw: Initialize to -ENXIO ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 067379f931662..72df25fae3864 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -257,7 +257,7 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct =
device *dev)
 	}
=20
 	reg =3D dev_opp->regulator;
-	if (IS_ERR_OR_NULL(reg)) {
+	if (IS_ERR(reg)) {
 		/* Regulator may not be required for device */
 		if (reg)
 			dev_err(dev, "%s: Invalid regulator (%ld)\n", __func__,
@@ -798,6 +798,9 @@ static struct device_opp *_add_device_opp(struct devi=
ce *dev)
 		of_node_put(np);
 	}
=20
+	/* Set regulator to a non-NULL error value */
+	dev_opp->regulator =3D ERR_PTR(-ENXIO);
+
 	/* Find clk for the device */
 	dev_opp->clk =3D clk_get(dev, NULL);
 	if (IS_ERR(dev_opp->clk)) {
@@ -845,7 +848,7 @@ static void _remove_device_opp(struct device_opp *dev=
_opp)
 	if (dev_opp->prop_name)
 		return;
=20
-	if (!IS_ERR_OR_NULL(dev_opp->regulator))
+	if (!IS_ERR(dev_opp->regulator))
 		return;
=20
 	/* Release clk */
@@ -975,7 +978,7 @@ static bool _opp_supported_by_regulators(struct dev_p=
m_opp *opp,
 {
 	struct regulator *reg =3D dev_opp->regulator;
=20
-	if (!IS_ERR_OR_NULL(reg) &&
+	if (!IS_ERR(reg) &&
 	    !regulator_is_supported_voltage(reg, opp->u_volt_min,
 					    opp->u_volt_max)) {
 		pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator\n",
@@ -1441,7 +1444,7 @@ int dev_pm_opp_set_regulator(struct device *dev, co=
nst char *name)
 	}
=20
 	/* Already have a regulator set */
-	if (WARN_ON(!IS_ERR_OR_NULL(dev_opp->regulator))) {
+	if (WARN_ON(!IS_ERR(dev_opp->regulator))) {
 		ret =3D -EBUSY;
 		goto err;
 	}
@@ -1492,7 +1495,7 @@ void dev_pm_opp_put_regulator(struct device *dev)
 		goto unlock;
 	}
=20
-	if (IS_ERR_OR_NULL(dev_opp->regulator)) {
+	if (IS_ERR(dev_opp->regulator)) {
 		dev_err(dev, "%s: Doesn't have regulator set\n", __func__);
 		goto unlock;
 	}
@@ -1501,7 +1504,7 @@ void dev_pm_opp_put_regulator(struct device *dev)
 	WARN_ON(!list_empty(&dev_opp->opp_list));
=20
 	regulator_put(dev_opp->regulator);
-	dev_opp->regulator =3D ERR_PTR(-EINVAL);
+	dev_opp->regulator =3D ERR_PTR(-ENXIO);
=20
 	/* Try freeing device_opp if this was the last blocking resource */
 	_remove_device_opp(dev_opp);
--=20
2.27.0


--QPeibYm6SItRlt3zDrw9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4903): https://lists.cip-project.org/g/cip-dev/message=
/4903
Mute This Topic: https://lists.cip-project.org/mt/75379095/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--QPeibYm6SItRlt3zDrw9--
