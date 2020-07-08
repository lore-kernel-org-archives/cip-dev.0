Return-Path: <SRS0=BCdr=AT=lists.cip-project.org=bounce+64572+4891+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DED7C433DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0893C206DF
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nlEWgJ/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0893C206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4891+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id L9lfYY4521723xyiYPqycUvK; Wed, 08 Jul 2020 08:46:29 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web10.13561.1594223182652563261
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:22 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 328DD5FDC0; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 05/23] PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
Date: Wed,  8 Jul 2020 23:45:36 +0800
Message-Id: <20200708154554.26450-6-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bvmqpZl3wkRVgAqY9swEUGO0x4520388AA=
Content-Type: multipart/mixed; boundary="M5jI90aMrSZldOgNnRDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223189;
 bh=7UuQ/1PEtCPUlffV6qo47QkWSv38BIe1EGEVSzhH8VU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nlEWgJ/yINpYqVpvhAOQWhk1DfOV/zNDA1RGw45b00LxTBMdha0M0TDUQwWiX4Y/Lie
 YuUDc7io91ESgwU0Oo/0MXcaIq0DS9MoyAEn43x38FiUMyfB3QEB6LLGHspNf3Kw9EWbZ
 rVZGJ9QdhAJX+2d0sqXYldT8zw65J0CeCwY=

--M5jI90aMrSZldOgNnRDo
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 50f8cfbd5897ca182d43f4caf19937153f17a604 uptream.

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
 drivers/base/power/opp/core.c | 20 ++++++++++++++++++++
 drivers/base/power/opp/opp.h  |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index d51ddcebcca00..e1f214fc75555 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -582,6 +582,7 @@ static struct device_opp *_add_device_opp(struct devi=
ce *dev)
 {
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
+	struct device_node *np;
=20
 	/* Check for existing list for 'dev' first */
 	dev_opp =3D _find_device_opp(dev);
@@ -604,6 +605,21 @@ static struct device_opp *_add_device_opp(struct dev=
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
@@ -861,6 +877,7 @@ static int _opp_add_v1(struct device *dev, unsigned l=
ong freq, long u_volt,
 {
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *new_opp;
+	unsigned long tol;
 	int ret;
=20
 	/* Hold our list modification lock here */
@@ -874,7 +891,10 @@ static int _opp_add_v1(struct device *dev, unsigned =
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
index 416293b7da237..fe44beb404ba2 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -138,6 +138,8 @@ struct device_list_opp {
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
@@ -156,6 +158,10 @@ struct device_opp {
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
2.27.0


--M5jI90aMrSZldOgNnRDo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4891): https://lists.cip-project.org/g/cip-dev/message=
/4891
Mute This Topic: https://lists.cip-project.org/mt/75379083/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--M5jI90aMrSZldOgNnRDo--
