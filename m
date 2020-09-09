Return-Path: <SRS0=Z/l/=CS=lists.cip-project.org=bounce+64572+5423+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1252C10DAA
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536BC21D43
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="AWeDB8Vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536BC21D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5423+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YffcYY4521723x2rwPf2kaKM; Tue, 08 Sep 2020 21:44:45 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.6683.1599626681623362607
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:42 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id CCD095FD01; Wed,  9 Sep 2020 12:44:32 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 01/11] PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
Date: Wed,  9 Sep 2020 12:42:23 +0800
Message-Id: <20200909044233.4115-2-wens@csie.org>
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fLDVHzoWbUutNgXnN4qqnPYhx4520388AA=
Content-Type: multipart/mixed; boundary="eGsIqeVHlrIUlBv2Tynl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626685;
 bh=wyESVM+01iZJpMCMTloOjt0l1DFXRtjQMkPY6sZO/ao=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=AWeDB8VzuJxGmZs6XMYVwIyb/W9P0XuFp0oGMorravWH/nSpHBD/uwZd0nvb1tc1g/l
 NvS8SnHxgkve0yk/RHcBM8j8cnAzyv4Fc7VTXgOz++Km7QvdvHZ1vo+gBAjW4zKi3J+xw
 j5qFocmk/EIB9byzG7cLAygRYXKwBv1xRSc=

--eGsIqeVHlrIUlBv2Tynl
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

V2 bindings have better support for clock-latency and voltage-tolerance
and doesn't need special care. To use callbacks, like
dev_pm_opp_get_max_{transition|volt}_latency(), irrespective of the
bindings, the core needs to know clock-latency/voltage-tolerance for the
earlier bindings.

This patch reads clock-latency/voltage-tolerance from the device node,
irrespective of the bindings (to keep it simple) and use them only for
V1 bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---

This patch is needed because the OPPv2 table does not include
clock-latency-ns properties, but instead uses the clock-latency
property from OPPv1.

---
 drivers/base/power/opp/core.c | 20 ++++++++++++++++++++
 drivers/base/power/opp/opp.h  |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index 1e0a2ddf73323..f983d5d30fa94 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -505,6 +505,7 @@ static struct device_opp *_add_device_opp(struct devi=
ce *dev)
 {
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
+	struct device_node *np;
=20
 	/* Check for existing list for 'dev' first */
 	dev_opp =3D _find_device_opp(dev);
@@ -527,6 +528,21 @@ static struct device_opp *_add_device_opp(struct dev=
ice *dev)
 		return NULL;
 	}
=20
+	/*
+	 * Only required for backward compatibility with v1 bindings, but isn't
+	 * harmful for other cases. And so we do it unconditionally.
+	 */
+	np =3D of_node_get(dev->of_node);
+	if (np) {
+		u32 val;
+
+		if (!of_property_read_u32(np, "clock-latency", &val))
+			dev_opp->clock_latency_ns_max =3D val;
+		of_property_read_u32(np, "voltage-tolerance",
+				     &dev_opp->voltage_tolerance_v1);
+		of_node_put(np);
+	}
+
 	srcu_init_notifier_head(&dev_opp->srcu_head);
 	INIT_LIST_HEAD(&dev_opp->opp_list);
=20
@@ -759,6 +775,7 @@ static int _opp_add_v1(struct device *dev, unsigned l=
ong freq, long u_volt,
 {
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *new_opp;
+	unsigned long tol;
 	int ret;
=20
 	/* Hold our list modification lock here */
@@ -772,7 +789,10 @@ static int _opp_add_v1(struct device *dev, unsigned =
long freq, long u_volt,
=20
 	/* populate the opp table */
 	new_opp->rate =3D freq;
+	tol =3D u_volt * dev_opp->voltage_tolerance_v1 / 100;
 	new_opp->u_volt =3D u_volt;
+	new_opp->u_volt_min =3D u_volt - tol;
+	new_opp->u_volt_max =3D u_volt + tol;
 	new_opp->available =3D true;
 	new_opp->dynamic =3D dynamic;
=20
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 690638ef36ee5..7f0d7c8bfef00 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -135,6 +135,8 @@ struct device_list_opp {
  * @dentry:	debugfs dentry pointer of the real device directory (not lin=
ks).
  * @dentry_name: Name of the real dentry.
  *
+ * @voltage_tolerance_v1: In percentage, for v1 bindings only.
+ *
  * This is an internal data structure maintaining the link to opps attac=
hed to
  * a device. This structure is not meant to be shared to users as it is
  * meant for book keeping and private to OPP library.
@@ -153,6 +155,10 @@ struct device_opp {
=20
 	struct device_node *np;
 	unsigned long clock_latency_ns_max;
+
+	/* For backward compatibility with v1 bindings */
+	unsigned int voltage_tolerance_v1;
+
 	bool shared_opp;
 	struct dev_pm_opp *suspend_opp;
=20
--=20
2.28.0


--eGsIqeVHlrIUlBv2Tynl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5423): https://lists.cip-project.org/g/cip-dev/message=
/5423
Mute This Topic: https://lists.cip-project.org/mt/76726427/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--eGsIqeVHlrIUlBv2Tynl--
