Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1354CEC046F
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:22:37 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14378.1772529754382664367
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:22:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lOTy0LZG;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwbJZgy3+2uE/HSsnmFAUNeKfHAEugS6A+Z1s+O3e58/6gffWxAeg2RbRlHdw/czVdMQAam8J09BpKSyicVI+F+VPNBUEp7X4CbHbVoJUR2uyVNMKxMQzRHHsRew0i6rSCwYw8LNj2ZUGXw6wy2VNU3xh2pIV3S8fX0ExyaQfgJ3v2bZ1jaNDScu+/mK8EUlPaVmWbA618d83hsT/gHwkpPD+t1ifSPproQ8/fdFi8QbEkrz0+HD3PVcOtHY7a/prYJsX1CoT1Eqx7tVAE+1siK5rI1aIjr7QKPa7i4+sp/54z9D3E5w9IirZQce17dUfkzN6IrETNcwE/NjiBAH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMSFALAihNoa1z/23PwpaxoDUgb22RlXNgYnTKtkDGY=;
 b=t6UKrnPwHKftsosICkohK55mctmAHAsHtn/zHz7RPRKm6Lv1ThIduMyP4JrwkwPS0O4e0veuSmwv0TonHM/kvYgpujNemOWAf6K6Q6PzETPNzCUNaSxcJ7WC9GV6egLvKqZb0haggFbUQa9tw6mvMEjzBL/fwxMbu7ChMHTAWMPW4YBFYJmHUxN2ZLK/NICddA9hfypu1k0w1iOs260AiSP0HBRf43X3oi/BqmfpG6fBS65+v33DRGTcrKcJiyle8dS40BI5TZmUg7MLCkitBr3spERvOi3FBq2rrFUdX0wtV/ScTNJSyu7Ky0oK59sV/fvHWMNx0+/0nNnXl/kkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMSFALAihNoa1z/23PwpaxoDUgb22RlXNgYnTKtkDGY=;
 b=lOTy0LZGNkRRp9V9BRAbaerONhZYnPbbfsvuppgccmVuem9p95T9UDBL6cGfZ6ndx0I8/s/YrdUWg8yxYx39umC0dGPGkFEJQBS7z0KRSGnRMcvbHAPBUprvrjwoEntNfoN6OaWhkPrqenUdMfQT46v62sPMWjd1xxGIXkIgXMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:22:21 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:22:21 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 4/9] clk: Provide devm_clk_bulk_get_all_enabled() helper
Date: Tue,  3 Mar 2026 10:21:35 +0100
Message-ID: <20260303092140.12732-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0d9d7c-ebf7-4f99-3b08-08de79065f20
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	RWb9nfiy51iMu/uam/GY2OagS8OTz1FC5U2XfoPhQtlxfuWvvYpY8b1clrsk7S8OaoQdZs6wSyY8kb8MQxCDNRgyNzsL9QFI3SbuQEcjtTbsQxMy+xSH6C4G7LXaKgd50OuWXVRNS1EpP8cf2eFWvfwRm+FMq57CbTnzGxH6mE7ZrQWtCznkoDzcCGwJ73YPxEtPV8854oCKDO2PI6q1i/4sLhul5NWlPINABTq7Y/IAb06bbNmL5uYd1JFiXyjCyBFl7u69oSuWEdy4FVURZpAzPPJEkDCoQT4/I6/8f8kH+4No5yqaMRZEU52DUK4gFZxzFxB0Ety0jkKC3GTOZI51aGZsusgRc5PgwpgAUVJegx5dcq5Z8Qi1jbDCX+ZNXVdT7ngb17hmezhp1ZFgEE4KFF0AsY+K+BMsh+oKwQMl2RNm1V6gpWvgC6hOxHgutiEcuxK14xXX5Vj6eeNjyCm4YpTGYIMucv7db54k2Ap0ayL7VnZ8r92n9JPi+klhXYGKZzEsrzmZTtvhpC5Ur8JVk8ePefRKKVHVdcqO99izO/rPP9X4vZV8Zuuu5/o5lG8HNd8Uj3mTswIvTmZW621kK4KdAUhZVoBfJRa9iUlHReY0/nmXQ6DrG4WNRjWaJ2dXE+zulqssl8aUwSHZS1nKqZv8eJPFpV+dYqjrk5B/RVMdhzilY69YdC+49TOtB3FoCVnGzJnIW96Rgg2YDcb0iRkqYF14Y+Oi3jJAnOQuj0UZi7Y7FfwRv34RJILYc01frYLj8eUNBquBvsZmb07WxpwnmbRneOOBZ72uKOo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q4pT905mPHnTabrUzeBTVazFcfxBZB+y+QC1BnpXhz3prvoyXe8YIeUcj5Nd?=
 =?us-ascii?Q?KSojkOcPXaA88NbzamjI2Ocm7QdKpNvlj+HihV6TS4f1BaMqsBmCkDNt6OVS?=
 =?us-ascii?Q?qJk9TfiXx+oiqjSamYQt5mGsD3XKja1VnWk+NN9AaONSON8WPuSklfGdKh1p?=
 =?us-ascii?Q?FwlrzI3BmbXNvh/q85JO/UC1KbBShHw8OzlF3gxpIcoRZrrSng8SEiqvH0mU?=
 =?us-ascii?Q?07fabSQ5usL4BDGdw3gFC8eTieOZAQAefLxp/YwwplgZN1f2ecVG0PaMUqEE?=
 =?us-ascii?Q?Zamu6GtOgxs2RAY8M/2lfNTjeeyCHkC8FsIqdoKHgv2DC3CNbcRAdTeF4RyS?=
 =?us-ascii?Q?tirM9WffS1p/5eRwmxWSv0ZBL2gwgPaYEtwfuShvFAQhCCfutuh2+mEMpM3B?=
 =?us-ascii?Q?2GTYj2K/OivaEmW+Iy2HExy8I6suU2243qDZSs3NiqO7RmdB29q7Soj8Pn4p?=
 =?us-ascii?Q?gTgzPmpTyIXwO8eYweKWUT4HKXrXQshcx7BSvy06jFJxn8rXDoQnDXcYNbew?=
 =?us-ascii?Q?9PLyd+zEFGboYLb+1kt1bRFLRBg2CJ4hH2nF8aCznXOKQ68VMGbB9oiECvRY?=
 =?us-ascii?Q?xHzzWJVTfc25IzKz41Z32R+ZDfOeTYEf1wTUTOYAPFpwmI0ST+cK+EzDm6HR?=
 =?us-ascii?Q?0PMn2yJh4xntLh6U6Afpf+xiOyX6qCPbTEvUCBf5U1m5SviLICE+rtHfytY3?=
 =?us-ascii?Q?GyvDYjVygd5LOQc+JDgnbF9LwS83nsAuQEfxFLDqZuzzA/opvFMOs6utMEAH?=
 =?us-ascii?Q?J8ex+Fy5H98kIBquQUCCy7wUaz9LbLCGQp9o4bggYTGbMuGa/WmU9htAsoPT?=
 =?us-ascii?Q?DV2A44QDVB+WqklFvziChB0zhYhHXOGQL8d/OsexUaJ0fFCE20OSWOktSGUh?=
 =?us-ascii?Q?LOU16HnmRDoV2cuC0LMwqiUxr36nJuegDVSBnzUqfM2XlpJnd5hZYOmuJhIF?=
 =?us-ascii?Q?cRuCKTiv4pKpeI+NWl6R7AE++CWRJDkbOEmCaQfBkS3HU1B0A7tXxTFMOBPZ?=
 =?us-ascii?Q?glh+RpJukpMpYj1Xdx3Q0TknMtZkEpHS1cZOYyDVo/pqtlP9JdGrj5VRpcvg?=
 =?us-ascii?Q?0sKXOFe2iLISsOaEeqpMpP4Y7cz5O0Shl7E33mmwsEPtvyn6vHUWqc0TuYay?=
 =?us-ascii?Q?HYqgFU8YgQxdFn9wRUdU+5T1eObKPRVSkUmvWthgjeUoUg7WagON8CgD69PX?=
 =?us-ascii?Q?6un9PTnWudNcNCvOtMkJtcFAQJU4k4NDMsyn6E55aY5ANX+WegcdA+jssB2J?=
 =?us-ascii?Q?qA/rRK8jijXahaAbrkfBuyJ7e0S9X/Lx7nWQ/Kx3MG8Ea+udlkhmD7Ugnz30?=
 =?us-ascii?Q?xop+MRB7iKSF7H9hpoLE5tfMgsfOLAMBtQDj7Q2Bo/qRERFnOp/LOFcFmSI6?=
 =?us-ascii?Q?oMDsU1eHUyDsUGwFFbdKYLQmgUGP/s/nrHa3fdhJW3+2vXxqPzn84+6gwKzC?=
 =?us-ascii?Q?p6k2PsECFb0HQz55xFlKtOg60lwgm/ndHviB3UBuQXs/CDcwho7OMk5yUKOS?=
 =?us-ascii?Q?MHfPVG3VW5+OJfM/2hnOFvOZQnDrOi53X4zHwO7e/nk7KjqJ98mHeeHGxusA?=
 =?us-ascii?Q?1dy8Sv9uLNQPn15wgc5msXkw9/8Ff7r2DTqkbGwM6esNl28VI7qaHtLwoktX?=
 =?us-ascii?Q?tM3/MmiHQJog5RCbus8y2mVuNYEdtVujcschP4tmBQWCBcHuiu7rN7ycw55b?=
 =?us-ascii?Q?b+WiQfVknQnhv9XO3EN26ROPZGzKkjmIQnjFOBG3VziEPwnRyI6eo1GAsUIY?=
 =?us-ascii?Q?z6EAyVN2jTLA1y/ZHdZi1bo9lSPB+sMqVo49q1KVPAyIWsh5bVdo?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0d9d7c-ebf7-4f99-3b08-08de79065f20
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:22:20.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4buDMeB0fM848RHcV2rISm0+bpvJPh4NHaF5FWOj4Jtthpl89uQxfyV812Vg24s2b3jqt+dQWZnOSiexgCrEICXPgUPnavqXtogZrTmAhdqzCFr+Svh76VJhRNSsGeO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:22:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22045

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
index ca0fe17827a5..31bc215c9de8 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -479,11 +479,13 @@ int __must_check devm_clk_bulk_get_all(struct device =
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
@@ -491,8 +493,8 @@ int __must_check devm_clk_bulk_get_all(struct device *d=
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
@@ -1017,7 +1019,7 @@ static inline int __must_check devm_clk_bulk_get_all(=
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
@@ -1119,6 +1121,15 @@ static inline void clk_restore_context(void) {}
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


