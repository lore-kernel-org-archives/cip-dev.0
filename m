Return-Path: <SRS0=jHmE=AT=lists.cip-project.org=bounce+64572+4889+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A80C433E1
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE5C206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Gqdwqb7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE5C206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4889+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gIuEYY4521723xRMMkuJNbMr; Wed, 08 Jul 2020 08:46:27 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13600.1594223180608382939
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:21 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 19B545FD0E; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 02/23] PM / OPP: Disable OPPs that aren't supported by the regulator
Date: Wed,  8 Jul 2020 23:45:33 +0800
Message-Id: <20200708154554.26450-3-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zvvUpg8HZ6JCbWPiPjPDNP8yx4520388AA=
Content-Type: multipart/mixed; boundary="gE22KVBvzdNSnVbdGnZe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223187;
 bh=oZeN7J0EB+r8SxBzjk1vJSJirU/lmB0P6i/lzehgr0A=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Gqdwqb7ScIC8J/pgAIhQNEZjP2QVAWLGRZOXgjMv8uQJqQRlhTPdA1oZWIp4utM59oG
 P8K/nzr0DiOH1IOVzf34gFVKtf+YawFIOPTZkXYudNqc7l/ylWo4p1+UTYAurGWZ/qBK/
 F9EXzX5g3IZIo3wJ2UrgBpdApOL4bIANX7o=

--gE22KVBvzdNSnVbdGnZe
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 7d34d56ef3349cd5f29cf7aab6650f3414fa81b9 upstream.

Disable any OPPs where the connected regulator isn't able to provide the
specified voltage.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index efdfcee48cac7..48ec88befffc9 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -687,6 +687,22 @@ static struct dev_pm_opp *_allocate_opp(struct devic=
e *dev,
 	return opp;
 }
=20
+static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
+					 struct device_opp *dev_opp)
+{
+	struct regulator *reg =3D dev_opp->regulator;
+
+	if (!IS_ERR(reg) &&
+	    !regulator_is_supported_voltage(reg, opp->u_volt_min,
+					    opp->u_volt_max)) {
+		pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator\n",
+			__func__, opp->u_volt_min, opp->u_volt_max);
+		return false;
+	}
+
+	return true;
+}
+
 static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 		    struct device_opp *dev_opp)
 {
@@ -728,6 +744,12 @@ static int _opp_add(struct device *dev, struct dev_p=
m_opp *new_opp,
 		dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
 			__func__, ret);
=20
+	if (!_opp_supported_by_regulators(new_opp, dev_opp)) {
+		new_opp->available =3D false;
+		dev_warn(dev, "%s: OPP not supported by regulators (%lu)\n",
+			 __func__, new_opp->rate);
+	}
+
 	return 0;
 }
=20
--=20
2.27.0


--gE22KVBvzdNSnVbdGnZe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4889): https://lists.cip-project.org/g/cip-dev/message=
/4889
Mute This Topic: https://lists.cip-project.org/mt/75379081/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--gE22KVBvzdNSnVbdGnZe--
