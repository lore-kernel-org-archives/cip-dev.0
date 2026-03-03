Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C82EC0476
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:23:37 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14392.1772529814325488562
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:23:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=S7EafKl/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.66, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJhq2+kqiEwrwegQX2rckxugyGMt1ugGLdhV3A0m8lqv7g8KQtDhznfSAu4o8Iw2EVJRXOpSQQJOz2TFcqCEywo60H1+ocAYX/zFbj+DhPEbXzyvytMJXE66yLoRPF3vUBXHIEP2sYo2ikyF3YCzD/uVoB1jG7ABY0+Aeq84AI/jFPO6N2sJ1tqmG8SSg6VGN9yXqj++ahGtNfxkCuwD4Q9vg1RNlvYjL/5U8dESFxeqUIf6P08TtrCed5M8QpbOQmi76fh5ymC5D/tfZnkuxFLtsMlR0zH3AfcP6z5C/Hn4Li4+hmFhaMFBYRuxgv4BA9Vc2ODB5X/ELhpUtmHeaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqjRpLUAXM1Dz64ymHb7CrawDQZf0TM0xltobsaV76E=;
 b=Q3DFDu1Yl75i/EQuoETNv5JbnU77V35LgflzF67K2zhrmF+BlNUEdZqVSrn8wIFq47nmsTE27LbUBd7/w9Qvtkj6Y+2y9Q0rtdpRjdk8886Ie8DVRFJlUAdSZFwZIY8oFxglm0x0T7AHy3PKK9iGrGt8kL1njBXQVhZfPNd0P4tl2wBC2zqTPzofTzeEElGJ9aIzZ9IWA/XRmOeekWVSFSAWR6wGiJriAuTyUqFKH7//2McWWnSA1Z1adSxAQvTE6Niy9Y69UbJs1ZO4y1vJ4hFqKSxHVvI6jhhNosts93GUYMNOUeiqWORNM2QVOMmy3w4uasYRZpCoBAnQCKOVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqjRpLUAXM1Dz64ymHb7CrawDQZf0TM0xltobsaV76E=;
 b=S7EafKl/xhaiAXOKvTvdWsrSGzfeN09udbLfCfaidFXL49e1cxuD6qBhCYBjns7zium2Sv1UVrCKASSPVUQni82be750WuZh9Z1gZa3GNfDv6Mf5ri7ZHIIX461y56ZiTiPBQakERK8Fg14AfcfQG6+5rdIuWfLyltI4vtoQV6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:23:30 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:23:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 2/7] clk: Provide devm_clk_bulk_get_all_enabled() helper
Date: Tue,  3 Mar 2026 10:22:54 +0100
Message-ID: <20260303092259.13301-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba44bb3-947f-4c93-f24a-08de7906888e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	I5J7OTEqlemwpy+LSmBtM9gkm8jspSajX5nyFw5dQc22Y89eMo5WqiOMiJFxtAhrhBwCTKTpZAwPziMTBheJUv1PJiDituxQ6kj4k7N9Bqh9Ia+ny4PDARVFiPI0IEzpMeymJ+TvFk7kA29XcDb/5w98OtvByRkD88dqdB3lVlmQQ+NaEKWe/gFjj37KTgmxV17UsyABsY4c35LdnzEVhlPzJijdYvPnGfsaOddOnWF/kp5ERe/lE31pGZbZuKTy/pN1YD/e8LnmmTNP7o5M+9Ape650qteolPfhdzxdOkCNsicvJTE5e9dSqvIBbAF6ggRzbQvXiQlo9k+LVrhlZOjUCmAC3+yX1rhWXHrfabGIW7v+6ib1yV1cVZo5PKhFOGtzRQ40JLAoTnjpBF+nf6LLe0SLedlkevrNyzKkoNqDC1DWZ9tO5rr4HoCoPkIc10rsEx3XEB0hCDmnszWSjDkKghqbDnD2p47tLIwokIp63kawFbQUly5bnAIYaT2z5Qf8f6mSKSSuWO+Z55qNaQLSjS5/wh6EPN7dtlJN8QUuFniEXx4T785+KzHdpEPM41xl2nAGLxARqV84Adagkp1CwVdwVic1BTJl0F9gLHDRbRIiDiVvg01JG32w/xBCXBY5w9xbQpwhvqA9C1fOZY/ATEP5PcaX6geefLshTmFYi7kES1DoQtTJRhrexzDvQaUxYTDkTU3HRyay9jb+UTPrgzF8yfqZKm50duYDdwJFSGf5SXcXwKzq3ITm2V/1o2bDNM+4QfaDXsFGRfXEzEmgPOawomnTQg+G1GeF4CU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4nZa0a5C/1j+ypLzhXlQcGy53iKPpiBs6PDwikggtKJk2THGOJr8qoYBLPkH?=
 =?us-ascii?Q?2kMPH//tOgzA5J/vwBAX1fMnAjhs/4vejeqYRa7aY1z0GJY48OyDOE4CdnHd?=
 =?us-ascii?Q?FTnH5FLmHk/EzDpPjT+it6+avhzlRw9PP73m44y6+i/amYEQ7EJ4ewMB8PwV?=
 =?us-ascii?Q?xaiIFGrfgrh2sWGVHPrT5wvKHXhcWzdLt6ufWcYG9Gnq6TxdQg9lbE/HAuuM?=
 =?us-ascii?Q?pfNH3jVW2djp+i/jE9I6/ZR/7qLWaA5N61br82kcHW/hHb0yQlkXPokW4Flm?=
 =?us-ascii?Q?mM6lxgaulGRysgINVndlP74S6ATxbGkbqixSkcbrkuzbfql0fe9hNsrraYxM?=
 =?us-ascii?Q?/GuuksumhTuJvEJ4u3i2+OYNFfsOvk2PAu9dPKE6XCqCdhj8fRL+dyXL8yKJ?=
 =?us-ascii?Q?zk0MmjlMNGwFjHv13hB+xmtO+hN8qZeVs4zujjZWkSbMTyRNaAMLOt83CbNe?=
 =?us-ascii?Q?j+hlA6xSX9JP5E+Lgrx0lYEpOK6kgGVQEp+8JMRPmw+EG6F4EFd3aRKGQrl7?=
 =?us-ascii?Q?rP9S2YrJN2BFSkXZsQ6KXuJuT/jmAW5L7ITKQvfA7MMwzHfgMXWR437SmTh8?=
 =?us-ascii?Q?FPnTL7uX+CZckEgT6sZYDnlgAriCJaaIPXzkLdaiXqCBtdJjeMYFdk5EMf+4?=
 =?us-ascii?Q?Kq5MNJLyXXbT4EZvR2UhUpLmsFJTlF+XTSXtKShbXyudMuI7d27Tsx0ziJjL?=
 =?us-ascii?Q?oXSkJ6GtDUYBYcANgRC5SbmMUmIPiY5roOWaflUfTM/3wwijdErPXwSZhiqQ?=
 =?us-ascii?Q?vNqoMx5Pb6A8mI5yi08fXdbtme3GbxXa88Za0FgA9NplcEWIrJhUEsy/dgQI?=
 =?us-ascii?Q?agzlPSEca/xM26UbvCfwqt1Ey0GGT0fwW3Bpr+Mz1iq/FgwMI+Z748AARqnv?=
 =?us-ascii?Q?ICKJ9KWEhpxA4dILmaHHcGW8DUP1cZdpTaDrumJl1JUL9lfTZugEcGVjNen9?=
 =?us-ascii?Q?42lakTTY5UlhLZBMJn+xHh04AL1k0qrWvrFdVAehEyzdMZ0xHRW8ext9YJYi?=
 =?us-ascii?Q?5tpAGwcXF5iAqdHWpGtVBcWnJEvzgo+z+bld5iD2kZBghk9CAmtYaog0jrgO?=
 =?us-ascii?Q?ZeCt+N+ySVS1peoeS+E5ZlYBxPqeFDwOQ5OyRIbhJiS+9XaYUn2SLtdDASYn?=
 =?us-ascii?Q?3VjAWSsbKR29d+oUJid4dkRCz8QqAjSLsJWPnURGukTZhyR0SXRSEQmZaTOf?=
 =?us-ascii?Q?rm+y2QlIoKMFzkuj6VryMJ0UTrTfCIAaS2I9UJGeqOsrNrZrWc7P0puKHM4y?=
 =?us-ascii?Q?Ui8ThMXcSFvLGyIXFS1BR/llu0hrAg1Ie6qLFL5D7rHGli1+GPFTjHflLwBG?=
 =?us-ascii?Q?Y1pNTqJ8gaJ5US2kmQLGGP2b8xQgbO2kAQSPihuomPSeQXjcZtOcw/2SThbl?=
 =?us-ascii?Q?ZKQR1/sK1NZ1hMB1wnSw8XJRGFr1kTTzFUi9ywvGMxbGG+Yf9n4CbxqnWzpu?=
 =?us-ascii?Q?zb2d+GnKHklKPW8tsubKzzuQtF8X7ieOxmualnG0LIixM1SwSJRbGU8hMtUc?=
 =?us-ascii?Q?ceyovYsjfvZIXVvU/zTi6l36luFnsKjNJn5Vt1E2VgKaLmnHvk2sL4LOHuq/?=
 =?us-ascii?Q?Vw2WSwXY/95f2TiD6JsZJSRhCGjCK3pomaeP4Kksa9gcky0PJD2Z88GENNd1?=
 =?us-ascii?Q?b16uzLzxC9J9hcNdqDWZZfa1v/orLrQckXPY7/pJ+FLwaKA9mJj6OsQgxhO5?=
 =?us-ascii?Q?IRx4BldvmqIDDF3mRt3CcZiwCugai/ifFQcWjaqJebzcHcY6Vq17/rohr3Np?=
 =?us-ascii?Q?GYgvw4Yt+ASlwyg3vB0InV0HcNzF4DXmtxfK/LUHEj5lGUwrocLQ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba44bb3-947f-4c93-f24a-08de7906888e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:23:30.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/SgreJGaZuRE+NqSm8DBBHMcYoxk5xSLXn0Rw5ZxlNxgYSP/zZy15Qyl+Gkg7riHvVP9neR3+LZxnQuW492DHqCwHK/CDxvUC8k6fn3U1g4O+7s3OKYb4JR3uaCKCCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22053

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

commit 51e32e897539663957f7a0950f66b48f8896efee upstream.

Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
clocks") added devm_clk_bulk_get_all_enable() function, but missed to
return the number of clocks stored in the clk_bulk_data table referenced
by the clks argument.  Without knowing the number, it's not possible to
iterate these clocks when needed, hence the argument is useless and
could have been simply removed.

Introduce devm_clk_bulk_get_all_enabled() variant, which is consistent
with devm_clk_bulk_get_all() in terms of the returned value:

 > 0 if one or more clocks have been stored
 =3D 0 if there are no clocks
 < 0 if an error occurred

Moreover, the naming is consistent with devm_clk_get_enabled(), i.e. use
the past form of 'enable'.

To reduce code duplication and improve patch readability, make
devm_clk_bulk_get_all_enable() use the new helper, as suggested by
Stephen Boyd.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://lore.kernel.org/r/20241019-clk_bulk_ena_fix-v4-1-57f108f64e70=
@collabora.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/clk-devres.c |  9 +++++----
 include/linux/clk.h      | 21 ++++++++++++++++-----
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 82ae1f26e634..5368d92d9b39 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -218,8 +218,8 @@ static void devm_clk_bulk_release_all_enable(struct dev=
ice *dev, void *res)
 	clk_bulk_put_all(devres->num_clks, devres->clks);
 }
=20
-int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
-					      struct clk_bulk_data **clks)
+int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
+					       struct clk_bulk_data **clks)
 {
 	struct clk_bulk_devres *devres;
 	int ret;
@@ -244,11 +244,12 @@ int __must_check devm_clk_bulk_get_all_enable(struct =
device *dev,
 	} else {
 		clk_bulk_put_all(devres->num_clks, devres->clks);
 		devres_free(devres);
+		return ret;
 	}
=20
-	return ret;
+	return devres->num_clks;
 }
-EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enabled);
=20
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 851a0f2cf42c..1dcee6d701e4 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -496,11 +496,13 @@ int __must_check devm_clk_bulk_get_all(struct device =
*dev,
 				       struct clk_bulk_data **clks);
=20
 /**
- * devm_clk_bulk_get_all_enable - Get and enable all clocks of the consume=
r (managed)
+ * devm_clk_bulk_get_all_enabled - Get and enable all clocks of the consum=
er (managed)
  * @dev: device for clock "consumer"
  * @clks: pointer to the clk_bulk_data table of consumer
  *
- * Returns success (0) or negative errno.
+ * Returns a positive value for the number of clocks obtained while the
+ * clock references are stored in the clk_bulk_data table in @clks field.
+ * Returns 0 if there're none and a negative value if something failed.
  *
  * This helper function allows drivers to get all clocks of the
  * consumer and enables them in one operation with management.
@@ -508,8 +510,8 @@ int __must_check devm_clk_bulk_get_all(struct device *d=
ev,
  * is unbound.
  */
=20
-int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
-					      struct clk_bulk_data **clks);
+int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
+					       struct clk_bulk_data **clks);
=20
 /**
  * devm_clk_get - lookup and obtain a managed reference to a clock produce=
r.
@@ -1034,7 +1036,7 @@ static inline int __must_check devm_clk_bulk_get_all(=
struct device *dev,
 	return 0;
 }
=20
-static inline int __must_check devm_clk_bulk_get_all_enable(struct device =
*dev,
+static inline int __must_check devm_clk_bulk_get_all_enabled(struct device=
 *dev,
 						struct clk_bulk_data **clks)
 {
 	return 0;
@@ -1136,6 +1138,15 @@ static inline void clk_restore_context(void) {}
=20
 #endif
=20
+/* Deprecated. Use devm_clk_bulk_get_all_enabled() */
+static inline int __must_check
+devm_clk_bulk_get_all_enable(struct device *dev, struct clk_bulk_data **cl=
ks)
+{
+	int ret =3D devm_clk_bulk_get_all_enabled(dev, clks);
+
+	return ret > 0 ? 0 : ret;
+}
+
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. =
*/
 static inline int clk_prepare_enable(struct clk *clk)
 {
--=20
2.43.0


