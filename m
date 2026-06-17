Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DFBCD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:35:36 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10985.1781685333191238265
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:35:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=iMhAc3El;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.27, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vML/DTcCTCYnPV3jafHylrq5WRHZ+c+9ySOCdWfOEkc3ZB2sapcEeprw0vNvMKACFxEDi0ERLOARkGrTGGR3N50fVvFEfsg8u8LljcLvyc9Aq3IOGs8OlZUSyHZSAL7qnNiTK9bypyH1MX1MZ0/51SY5DwihBCvW/6QOyxTHRtAdbgQedSUp5Ba+mVR2e8biz3PS3pJsniAd+RPlOm74oeKjjkHopewQHsPJDJ+11ya+aR2hpFPYkLmkSmmLqqbOFvmtmo6S2Gw7DLiAq7aDtsjr6xtOvnyP8Y2QGPnyzuhpbsQCadlJiSLDDSuEB1Q8kUiXCs1vfgZOAKWraH3slg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2syHazeo5+pN2lIsxHoiquOl+Rj1OdEBkHfvHDeCapI=;
 b=CZum+ScPJanAjfo/baMeCS+qb9FDgGdfsSBnaKm9WvcOHqNTSj2h1CJ3aDiU8eLwKdDFAlPYozl4X2D1XnfGijXFiaTRpdZfiGK1nyGAcYyuN60/DpfO30QcqUeozRlY40EkuAzbt+TvA8AxmJXK43KHBKr9YJGgH5pxG7+o9VrQIAN/crQQg6NADnrLxG1rM+QWOS7ITaa3i36meb3tTR65nN7BFv56zHcwvLDmZXTcvj4S3TDmWyFgjRcmpOzRovHVl1Y8old66k2yDO05sFzEyEXVK4BDBYAM+GJnSHDKv+zsU88C7Ov00shpPmfKYO+ILimfkRfW+Ovq3Ptu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2syHazeo5+pN2lIsxHoiquOl+Rj1OdEBkHfvHDeCapI=;
 b=iMhAc3El2cbzxXS4cmLd3l3/YVpqQh4nYd11BcA4PNJncxULy+THbtF6tB+6gE71z+SYJGDAHUfu2luTRmYIIQF/F8nvvaQQbN2S/VZ4EIAgbjCAmJ0aPZPkkX6OBH8N8hYb8dC+Ju2EZMzlbc4+T4yz4AhrqXA142eRJiii/GM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:29 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:29 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 02/24] driver core: Add device probe log helper dev_warn_probe()
Date: Wed, 17 Jun 2026 10:34:40 +0200
Message-ID: <20260617083502.1074160-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB13245:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f4455b-6bbe-465f-426a-08decc4b6309
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|3023799007|6133799003|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	IhZfdwF+zndwNWl4x9b/zLUd3hRlISl7ANQD+meGOUaunRuMCumRrFzHQbvu6HFyBIo6RCMUSFZ7OXYv+fCGJkCJvBfM8FmyQkaDLMANyx/jsHfYvksdRTD9vpnnkwBYP36oWpi237s0VWRFNSoCIDyHoUk6s1ZjQ4+o7V/8/4QI6iE6x/58jvVd9vzcvGIv6ao/l66uS1RdB5PuMBRs3HB/pfjJbn2SLyCyWp1ot4HbGUQvjXi3VXlSYyaka1302wxIBQjd5g6tOpaaXxof6BQ9vmPKxSlY+bD7BFYFnRyCTpIHFX6TrNOVbLW3iBu5JiiF6xmER4A+gr+CmMDytSiXemcVN4vJBM/dhNlU8aiQYxrQ6CcZCL3eHcj+BAsOnXTQYm1j/OenivE5rU5gewqK9SQfNlZiz1MP3GcinHYnEkjBZg5p7kdUk4/toiKmCpyuiTMBmMh+pCJUDC3atRLAvTJD7Zt9Hnf46KdP1ubi84LGd/Uweo4dEtQptGAAIXhAi130cjQEzC9tz7jU+BHHqiFxUXvIRUR7RpPQ8NS8jZ+5nRtyRUxXPNX9GZvtSSIJl7khgiMs36C8ZnxRnERk7J00GBgUjJQrdtwLBBwhgT6TiZVWaKzlyDdhZRF3W5W0ALs40BOSUnvkEgCZskwCfhkzUhkdgCrLJNrYuOArpTq0/MfZ5AU2ncd+SjPfVWM/Xu3fW1sOlIRBSZ+qCQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XtyE2AgfH0z1Q8MAqqPE+r4WM/uOR1wHbDyxzFBwytx8UlVEJGZOtF4UUIJa?=
 =?us-ascii?Q?8BCtX9PDuAgaogTCIat8T13hkHtaxmxPvf1Zn66sZIRqcvsXMHFG2OveN994?=
 =?us-ascii?Q?6sjmWFTntIVv4KDaRuOpD7Gv5SPHwMPXl2iSFlxzqgP94ddqT6YSyfvbxiaI?=
 =?us-ascii?Q?trIhUShqgGKC8xCmVuQYiyFaLU5lzrrw1BttMeHTFvSwBc/KzrE8voCNSnmv?=
 =?us-ascii?Q?TkwnkHLcWMUor9UjMr1pHLJh5h1xAgLgal/73w47oiLPWmLmFZ51RNrkevo5?=
 =?us-ascii?Q?4IQLKlDMfL3iFBeE25Bl38OAzDsy/lO7TyUtY1A7zDoOdjoM9IYcbPDvlhn0?=
 =?us-ascii?Q?V5efZuyT3sAsy5QyEqXKc0dyz9uU4rBGLjHL3BvQWWeFhGUHidH+GcnF3ddm?=
 =?us-ascii?Q?Bfpg93cHhbG6t0DG1JRx9jVT8CJmhEoS9HrQqxAi1C5E7r2LIOmqN6gjSnOd?=
 =?us-ascii?Q?EZCERVtAc4R492HoyhVbjTYQxI9tsaA8hVCR06VaLJNHyuk/lViyLx6jPMHw?=
 =?us-ascii?Q?Xj1149Bg/UDOrYS+p8IVGL7My4CrUs9a03IJUh25gIXhhaAgfqfmOParT7jh?=
 =?us-ascii?Q?KFXxlsVnpKz5KjKXsxhQOBf/oT81IJFgbfBeVHeUmtzpiwhQeNVWk5wYveqR?=
 =?us-ascii?Q?EQbUiXEoa6LWpNjylG51oFcUQrhdxkEI40k+QJ1jlQp84NzQThSwZynUoJC8?=
 =?us-ascii?Q?XZfOOPh8GgUEzxFYQWxtqMasFyo0JQbvZ11N2s7F9ze4yLsNNLhuw9X+LyEC?=
 =?us-ascii?Q?cukFF1LzLYsTrmdMPJCNLWE6gFB6gZ//NB3QZ4UvTVFK3zWqBVJ5A8aa0P+y?=
 =?us-ascii?Q?9xjm/WeGWX2Qvc73OFF0/mYacwq0zP2hyppHuSSEseR8tY/DWicpmc4jn/F2?=
 =?us-ascii?Q?R0R5EcxiphvMimDCdSNY8a5ZUJbk4ifJeeUGDIkfGYN6jo5B4hDBDha8WVkD?=
 =?us-ascii?Q?1wGiXz8aS0wq7l2Gnf/mxLBmxV//DkwvDgnSeHtC7mhEabaVUA/0vdhkHVZm?=
 =?us-ascii?Q?Gy/Yl+01RK5mi8XdYA/YdJRjtM4S2hdS7l00/77d38uAS7q/RayAF2VuQcZA?=
 =?us-ascii?Q?wrXhp5E/RB/ZXkUjbFQo4S4S88EB34GREHAwAN58TWAxMEuuNtSC9u9/IH4x?=
 =?us-ascii?Q?y2m26LmYGYPRBjFAWmu6z+z1d7mX0D9f5zLZ4Hf2TQGAnqal8f9THdugFVeE?=
 =?us-ascii?Q?Cihm2jv5fs8xyPbS2p+eoI654Bbt+vrrFqlHujXcj269N7FYVs74hWZr9Na9?=
 =?us-ascii?Q?RFQERGndWu/w4rtmvjkXgxVYx8andjwlgLYQxyvry8uuhykMA3fmJOVCEHnr?=
 =?us-ascii?Q?q0zoOC4JjhtxmVm0RVUswp7HxOJ4KFqoap/ImwkQIziZJ7Vkz+M8gzUrcQBc?=
 =?us-ascii?Q?+hpGLk2aSZ0Cjw7oq9pDjL3QW+rF5V1OTTUdGpLnaDukVe8yLNCiznkR+hoT?=
 =?us-ascii?Q?u6/mlWtm2a2KnQFJOhl+TDODcvPGOCprZZHGEPMCJEBLL7vAX/8PmdTitvhK?=
 =?us-ascii?Q?VUYLjpgOkNpxcqgr5uAOZrhstlSePGALzk9j3WS8akyQyhxG/UyW7YF0mbq/?=
 =?us-ascii?Q?P/iJItpu/pOzoM+MPda4z7f+Rce1t+MfKUK9nNsmn3oBYFeoe+KO5rtR0N+i?=
 =?us-ascii?Q?vSeqTzt2BarHCDOc8b9b22JF59snlXVxxvKjE0td9ytMWfq8PC/rz42C0ppA?=
 =?us-ascii?Q?njWQzJ8X6xdVa6BexAch+JxfNWn3btkwaiFD4Z70dUOz3JWVNgl+CQ1kj0v0?=
 =?us-ascii?Q?zhVSBX3EbDaMaZUfeuanuPyT/LDul1CKFBcPQqaxE6lyTQm0uTUR?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f4455b-6bbe-465f-426a-08decc4b6309
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:29.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjsO1UGP7+Ud4V2Im5w3/T92ykTy/WrLeugHoG0P2qSVO+KeiaBWxeabmGPNs0xyZvMnylD3xWo6zkA7PzDsuJwgcSL0XmvwRZxcwsZomygAvI9w3hFY5pBSqwHIyxGu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:35:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23194

From: Dragan Simic <dsimic@manjaro.org>

commit 36e69b160705b65bf136c2fb6a1194447eeb8478 upstream.

Some drivers can still provide their functionality to a certain extent
even when some of their resource acquisitions eventually fail.  In such
cases, emitting errors isn't the desired action, but warnings should be
emitted instead.

To solve this, introduce dev_warn_probe() as a new device probe log helper,
which behaves identically as the already existing dev_err_probe(), while it
produces warnings instead of errors.  The intended use is with the resource=
s
that are actually optional for a particular driver.

While there, copyedit the kerneldoc for dev_err_probe() a bit, to simplify
its wording a bit, and reuse it as the kerneldoc for dev_warn_probe(), with
the necessary wording adjustments, of course.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
Tested-by: H=C3=A9l=C3=A8ne Vulquin <oss@helene.moe>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.172=
7601608.git.dsimic@manjaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/base/core.c        | 129 +++++++++++++++++++++++++++++--------
 include/linux/dev_printk.h |   1 +
 2 files changed, 102 insertions(+), 28 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d233a245e19b..486c73061cab 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5049,6 +5049,49 @@ define_dev_printk_level(_dev_info, KERN_INFO);
=20
 #endif
=20
+static void __dev_probe_failed(const struct device *dev, int err, bool fat=
al,
+			       const char *fmt, va_list vargsp)
+{
+	struct va_format vaf;
+	va_list vargs;
+
+	/*
+	 * On x86_64 and possibly on other architectures, va_list is actually a
+	 * size-1 array containing a structure.  As a result, function parameter
+	 * vargsp decays from T[1] to T*, and &vargsp has type T** rather than
+	 * T(*)[1], which is expected by its assignment to vaf.va below.
+	 *
+	 * One standard way to solve this mess is by creating a copy in a local
+	 * variable of type va_list and then using a pointer to that local copy
+	 * instead, which is the approach employed here.
+	 */
+	va_copy(vargs, vargsp);
+
+	vaf.fmt =3D fmt;
+	vaf.va =3D &vargs;
+
+	switch (err) {
+	case -EPROBE_DEFER:
+		device_set_deferred_probe_reason(dev, &vaf);
+		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
+
+	case -ENOMEM:
+		/* Don't print anything on -ENOMEM, there's already enough output */
+		break;
+
+	default:
+		/* Log fatal final failures as errors, otherwise produce warnings */
+		if (fatal)
+			dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		else
+			dev_warn(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
+	}
+
+	va_end(vargs);
+}
+
 /**
  * dev_err_probe - probe error check and log helper
  * @dev: the pointer to the struct device
@@ -5061,7 +5104,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  * -EPROBE_DEFER and propagate error upwards.
  * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
  * checked later by reading devices_deferred debugfs attribute.
- * It replaces code sequence::
+ * It replaces the following code sequence::
  *
  * 	if (err !=3D -EPROBE_DEFER)
  * 		dev_err(dev, ...);
@@ -5073,47 +5116,77 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  *
  * 	return dev_err_probe(dev, err, ...);
  *
- * Using this helper in your probe function is totally fine even if @err i=
s
- * known to never be -EPROBE_DEFER.
+ * Using this helper in your probe function is totally fine even if @err
+ * is known to never be -EPROBE_DEFER.
  * The benefit compared to a normal dev_err() is the standardized format
- * of the error code, it being emitted symbolically (i.e. you get "EAGAIN"
- * instead of "-35") and the fact that the error code is returned which al=
lows
- * more compact error paths.
+ * of the error code, which is emitted symbolically (i.e. you get "EAGAIN"
+ * instead of "-35"), and having the error code returned allows more
+ * compact error paths.
  *
  * Returns @err.
  */
 int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 {
-	struct va_format vaf;
-	va_list args;
+	va_list vargs;
=20
-	va_start(args, fmt);
-	vaf.fmt =3D fmt;
-	vaf.va =3D &args;
+	va_start(vargs, fmt);
=20
-	switch (err) {
-	case -EPROBE_DEFER:
-		device_set_deferred_probe_reason(dev, &vaf);
-		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
-		break;
+	/* Use dev_err() for logging when err doesn't equal -EPROBE_DEFER */
+	__dev_probe_failed(dev, err, true, fmt, vargs);
=20
-	case -ENOMEM:
-		/*
-		 * We don't print anything on -ENOMEM, there is already enough
-		 * output.
-		 */
-		break;
+	va_end(vargs);
=20
-	default:
-		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
-		break;
-	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(dev_err_probe);
=20
-	va_end(args);
+/**
+ * dev_warn_probe - probe error check and log helper
+ * @dev: the pointer to the struct device
+ * @err: error value to test
+ * @fmt: printf-style format string
+ * @...: arguments as specified in the format string
+ *
+ * This helper implements common pattern present in probe functions for er=
ror
+ * checking: print debug or warning message depending if the error value i=
s
+ * -EPROBE_DEFER and propagate error upwards.
+ * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
+ * checked later by reading devices_deferred debugfs attribute.
+ * It replaces the following code sequence::
+ *
+ * 	if (err !=3D -EPROBE_DEFER)
+ * 		dev_warn(dev, ...);
+ * 	else
+ * 		dev_dbg(dev, ...);
+ * 	return err;
+ *
+ * with::
+ *
+ * 	return dev_warn_probe(dev, err, ...);
+ *
+ * Using this helper in your probe function is totally fine even if @err
+ * is known to never be -EPROBE_DEFER.
+ * The benefit compared to a normal dev_warn() is the standardized format
+ * of the error code, which is emitted symbolically (i.e. you get "EAGAIN"
+ * instead of "-35"), and having the error code returned allows more
+ * compact error paths.
+ *
+ * Returns @err.
+ */
+int dev_warn_probe(const struct device *dev, int err, const char *fmt, ...=
)
+{
+	va_list vargs;
+
+	va_start(vargs, fmt);
+
+	/* Use dev_warn() for logging when err doesn't equal -EPROBE_DEFER */
+	__dev_probe_failed(dev, err, false, fmt, vargs);
+
+	va_end(vargs);
=20
 	return err;
 }
-EXPORT_SYMBOL_GPL(dev_err_probe);
+EXPORT_SYMBOL_GPL(dev_warn_probe);
=20
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index ca32b5bb28eb..eb2094e43050 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -276,6 +276,7 @@ do {									\
 			dev_driver_string(dev), dev_name(dev), ## arg)
=20
 __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const =
char *fmt, ...);
+__printf(3, 4) int dev_warn_probe(const struct device *dev, int err, const=
 char *fmt, ...);
=20
 /* Simple helper for dev_err_probe() when ERR_PTR() is to be returned. */
 #define dev_err_ptr_probe(dev, ___err, fmt, ...) \
--=20
2.54.0


