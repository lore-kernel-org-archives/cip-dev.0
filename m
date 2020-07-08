Return-Path: <SRS0=oF3y=AT=lists.cip-project.org=bounce+64572+4893+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75425C433E1
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4832720720
	for <cip-dev@archiver.kernel.org>; Wed,  8 Jul 2020 15:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CUp8Z9Kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4832720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4893+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OmZRYY4521723xMxAv84TxWu; Wed, 08 Jul 2020 08:46:30 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web12.13602.1594223182734197272
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 08:46:23 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 3A41F5FD88; Wed,  8 Jul 2020 23:46:17 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com
Subject: [cip-dev] [PATCH 4.4.y-cip 06/23] PM / OPP: Manage device clk
Date: Wed,  8 Jul 2020 23:45:37 +0800
Message-Id: <20200708154554.26450-7-wens@csie.org>
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: yC9GdeHseHD2rrIb7fR4e9b8x4520388AA=
Content-Type: multipart/mixed; boundary="VkWSVrBOcKywqELRgSv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594223190;
 bh=x6cOQwmhkSHwTC0qclVel02K6xZh7KMeKcfrsq0oh0A=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=CUp8Z9KzbIpRcgsZgM0xOzBu+B4f5BI3PYrxm7FAgF/uHo39yhH9TQD7zu47zn9+U+T
 hB3e+o6Ek/Yph3Bcxxjcd0PULEuJqES5kPSIKXgKcd+Rq8Ci6DvVbweQNCAlrONa5nomz
 1VMWbwqPNS7SuwIpZBRmBnMLQz0+ZEF0mm4=

--VkWSVrBOcKywqELRgSv1
Content-Transfer-Encoding: quoted-printable

From: Viresh Kumar <viresh.kumar@linaro.org>

commit d54974c2513f487e9e70fbdc79c5da51c53e23da upstream.

OPP core has got almost everything now to manage device's OPP
transitions, the only thing left is device's clk. Get that as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 drivers/base/power/opp/core.c | 15 +++++++++++++++
 drivers/base/power/opp/opp.h  |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.=
c
index e1f214fc75555..4fd3a59060e30 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -13,6 +13,7 @@
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -583,6 +584,7 @@ static struct device_opp *_add_device_opp(struct devi=
ce *dev)
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
 	struct device_node *np;
+	int ret;
=20
 	/* Check for existing list for 'dev' first */
 	dev_opp =3D _find_device_opp(dev);
@@ -620,6 +622,15 @@ static struct device_opp *_add_device_opp(struct dev=
ice *dev)
 		of_node_put(np);
 	}
=20
+	/* Find clk for the device */
+	dev_opp->clk =3D clk_get(dev, NULL);
+	if (IS_ERR(dev_opp->clk)) {
+		ret =3D PTR_ERR(dev_opp->clk);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__,
+				ret);
+	}
+
 	srcu_init_notifier_head(&dev_opp->srcu_head);
 	INIT_LIST_HEAD(&dev_opp->opp_list);
=20
@@ -661,6 +672,10 @@ static void _remove_device_opp(struct device_opp *de=
v_opp)
 	if (!IS_ERR_OR_NULL(dev_opp->regulator))
 		return;
=20
+	/* Release clk */
+	if (!IS_ERR(dev_opp->clk))
+		clk_put(dev_opp->clk);
+
 	list_dev =3D list_first_entry(&dev_opp->dev_list, struct device_list_op=
p,
 				    node);
=20
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index fe44beb404ba2..4f1bdfc7da03b 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -22,6 +22,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
=20
+struct clk;
 struct regulator;
=20
 /* Lock to allow exclusive modification to the device and opp lists */
@@ -134,6 +135,7 @@ struct device_list_opp {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing th=
em.
+ * @clk: Device's clock handle
  * @regulator: Supply regulator
  * @dentry:	debugfs dentry pointer of the real device directory (not lin=
ks).
  * @dentry_name: Name of the real dentry.
@@ -168,6 +170,7 @@ struct device_opp {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
+	struct clk *clk;
 	struct regulator *regulator;
=20
 #ifdef CONFIG_DEBUG_FS
--=20
2.27.0


--VkWSVrBOcKywqELRgSv1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4893): https://lists.cip-project.org/g/cip-dev/message=
/4893
Mute This Topic: https://lists.cip-project.org/mt/75379085/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--VkWSVrBOcKywqELRgSv1--
