Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5781BC83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:16 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.13])
 by mx.groups.io with SMTP id smtpd.web11.8489.1751620092326607122
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=m+LoUibo;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.13, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cISfutbc72oxecBLMYK3A5nGVg73eR4T4XHEkQetZ16cNkqyLyLO7+pEPRbU8bApDoWOQUGowxxRmI951sbOwojVVVZO5H6o/c4PX8xX+bnlTA1ulysLiohg9mamNHryeZSHqyR2/6i661Fn1AvU352a2Up6mEKk7GTWmfCqNWaowRBSxZ3QxZN81d3wH/7EApJgsa9Vq4DWL80sJRpi0pzOe/FoaScKFQXpUP256/CQH2qw8l3TZQhHEYY7H3a5+8b9n6baN0Chu0Mrg4F7C/n3zSGGi3ThL5dnmjZGZjQoiUcXSreO08jVRj0876ZgpT21df0coT8NUdOJqRUemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ+Jy82IteU1z1jZpudy4Hgt4w9V/oJ7+Y4Bcf5z5uQ=;
 b=A+zOwVF4KThsrlD+DXuhGAEag6vTkob8oofKjODUnziD961vfu9548ZzGrW+GFxphYMRLmXVGDcTSEMVTgHjhyJNlpjaa/10onHtvEAVdjxnBqUHlzy99FYIFMXUfKPHTHAtV3EH9bWVE3MU5uhmHYnpUK2aBgq6HWJO3YSk8l7ggGTHSKmTbbDWiWOYZJTDvBZn06EBH3c/vzlYIiHAj6+2bBHHCWs03qWEwJyF9PdI2vAUCFVuvgmRwzwXT+dikvuvMI8nmjypo6yPwZYPtHDHK0tEQvqAhvLEnwpe5SPpcvRDzgcFIEqvVxuEV3yIFF9/wwtuLCjaK7XWxvd5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ+Jy82IteU1z1jZpudy4Hgt4w9V/oJ7+Y4Bcf5z5uQ=;
 b=m+LoUiboVjc81FoiZkE5GI5/kXu7q3ba07/3+zZ4ay80VNUCdgHeWsTowmb/VHIcDeu34Eakbtqht4HHs2ZkYrSLVBPVZ4KSNVcUTXAiWZ7zqDmTFvh+PzncXlaUzLfCX2FCADQlvgHhqLmSd/bxEHJGWV6LhPNgefcfXunXy1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:08:10 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:10 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 08/18] irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
Date: Fri,  4 Jul 2025 11:07:14 +0200
Message-ID: <20250704090724.669848-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB14451:EE_
X-MS-Office365-Filtering-Correlation-Id: 645b722e-5049-4d37-8d29-08ddbada4c03
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rhuuvb4z7VL3M2m8Z73aohMpqXOIgk0/Ad5DmUdy+R0faheY+RSgeHniyUVY?=
 =?us-ascii?Q?Iky/J+kqOQsofYKrAOoq57DNIbxxO4XOhrfSC2WBypH564RCyVNsKrBdRM33?=
 =?us-ascii?Q?br5eF+KSzNByB3shrzGiWMp+kdsKFxQEr/CpM7sVQxTvm9RpR6oOq06AyHJy?=
 =?us-ascii?Q?c/d4Ql1giPkY8ObhBneMg4q7doqRz7dpNjZ5uTrZ7TLq7+MVGsqr+ChDoNHa?=
 =?us-ascii?Q?vPD7M+egs5nSTkFVf62CWov7bFk/Yt/rNMAijrKarMbTT2wrEx4siZs3ra2N?=
 =?us-ascii?Q?ENrzfzmf6jOBJzTfXG7XmgfFyei6oNez7uLJYM63Cim3btLNktl4E9O+1u22?=
 =?us-ascii?Q?YGWCOTB8KmXfJbamNzBh57NoD39GMiT0b/CE7R9dmCUrmaySLJXDFmIpkBoR?=
 =?us-ascii?Q?biIrAmZKZHH7PaEa5O87kAIXgASSutkVXdAsTxiTphCPLCsCVZ3dIbacgtBI?=
 =?us-ascii?Q?cb2nCW3DbuVTfA7pIInnbFhtWRnwGKOpZg1EuhQkkhrWQpMIhKuQWhCT/nmH?=
 =?us-ascii?Q?OfLRqNAZvVJ0hGBllMTENlK3RP0L5BiB2XRbmYmbNbVDtF2ypmfAxcsTZPVg?=
 =?us-ascii?Q?ecsrkhbb4kPBapLm2G+RUa2GG2vylgPXcfSsiOYip2vtg5C0YI3V5RJiQeGy?=
 =?us-ascii?Q?zuIXwpC4QP2qJ1Uu4XgJLtWk9eDAMvMdo5x1N/SeIJBmO0o8249EMX1x9zy7?=
 =?us-ascii?Q?NcV/rwUi4grOxK7woMTgWwYsOt31qnumWmfpVw0UrNTiK/gy9eDijik6nCqi?=
 =?us-ascii?Q?RDzvZzS9u4qye8jO432+9+FcGwMl2WjXrRLUu0ii1d91Lr1ozCJjwi9VcVPp?=
 =?us-ascii?Q?KqrqWJedr0GYtDsXwuG2fOn83Vj2HiQT1P33Of6XxN3mmxfcvavt/Ix4hVAL?=
 =?us-ascii?Q?7ClP3ASzc679MagZWYTQbyU9QYLelbHM26O6aAlNPaOA+/n1V/TeMhfe82O6?=
 =?us-ascii?Q?R8Pc7OJ0kc6kqAoHEWJL2SWdNVn4tBiqzl7KKs22wpBzaepVxPmcYczVQYSJ?=
 =?us-ascii?Q?9LV4iAkLX/5QIbalgrm5pdkfyIDySnYcMd7HdOP1bGIcAc+m7XQ8Wl1Kw5NF?=
 =?us-ascii?Q?GeYvA8YGGSFDKpsb+FfwGhi9Rl59NdLjU+Kuakwu6iSkwtE28vVENmn8Jz69?=
 =?us-ascii?Q?lp/getodaV4VwKsFcXUvEd9xMn81EzEN/m/0XFeQONjvkflpSZi7BAYE3PM1?=
 =?us-ascii?Q?SR1GejVkIOzpOzc67qKnBT9llXc69i8QjnifOq880ZFyQQKEtCLEf2cmHpqR?=
 =?us-ascii?Q?f930O1EaANIRONbRfjyA2SvW0WiH8BWFSITDPPLQuuEguAgbCUQKj1ZE1V3I?=
 =?us-ascii?Q?vvIpSaY2dZfMq7pAYTAtU1S24LQsFNlrOJuWGhImcV8KHdXhJKRlXJu95+U1?=
 =?us-ascii?Q?zLr+Gx98o5cz348ZyWMhAWzZdoEuSf3lQup7OKppnU7TZ3AcphPsTkG4FeV7?=
 =?us-ascii?Q?tcvSJXUA816sIBMZa8kcbZXKXqQ/6ggGQAVJmdhCOZtbtugd+OC9y+dD0p4x?=
 =?us-ascii?Q?aHiKRpJx2QYidx0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GDRqfx3Z7sT7y2qV8OhzhfSuoy4scLgkN3k8GqbmAerd0FnGCEomR4shSzu8?=
 =?us-ascii?Q?XSM2DYiJZmvOYpp9v39iwxh8lVWPWnw+MDQeOXjN+DwiLZP7R/RdNYzmnzoj?=
 =?us-ascii?Q?L2OpOXeaRdegAMTRMMGwxvK8Ut4b+j0qmIxD4cxfpiY6V+M9lxQ9dTcgUynO?=
 =?us-ascii?Q?Pm73wC1ZaBvwLXvodSZpYexjFG599fYRFyovqXrIMpuitq6a3zo31EDYz9b2?=
 =?us-ascii?Q?UI81CaIHOxzK+PEfvfyfb2ONOGTofdS5KLpKuQlCj5+mDD+IGP7YFYtM5Tkc?=
 =?us-ascii?Q?bDZS/sFIpPlij5qHOwGuHt0+FfZYKlz/UKLMPDW11axx2l1o3Pwneh3bPqKT?=
 =?us-ascii?Q?7iQ2eiefmvDdffY01KJdBsjYzCWrMFJkm25f+zkZNqVBXjNoNPNSttV5XGjv?=
 =?us-ascii?Q?yDywwtCNqlryJWRmiKBeF20jAYdKIhNpUWRnCrZ8QNuWasjInT/t7a32GkbO?=
 =?us-ascii?Q?2OzjqO367nILKv2Y8nv1rdTSAmjS1nTsAHhVqa9DjNc9/OMewGqakleQKBzA?=
 =?us-ascii?Q?2XtpPaInnGmEf+Tfsmp4Gvr8t/K7+uSaUhe5/x0viKek7rqU5LHI0vTav5iN?=
 =?us-ascii?Q?SgXJKneW+p7yTtKjpWcfBPDUnxOtbX/tQnLW+0eQNrw0G+l+O3eB9Xvz7eQn?=
 =?us-ascii?Q?6bbigJ5D9ldmUM++p8dnHtYTvYMm60sVFjPHFgbPWSYMyu/+kLCImD1cnbWv?=
 =?us-ascii?Q?32goycCUboTFiJs1cz5pSVGzya86zGfpbQ2++sm52Nf4rYi7pUtQs6HawjWy?=
 =?us-ascii?Q?3SZzUDUt8hyYBuG0nqldU+GnmWV3al/2zjnT4vu8NNqjc3TBn0hxVGWWgWpT?=
 =?us-ascii?Q?Kny2ecGPaMahPIyQCTfefuIWXJJL0ygzQWAvdglGrKLIrvcCww8crkKV3YBx?=
 =?us-ascii?Q?+E1juuLdmPVhujUOY4oV0iSh3XAtTQ5qQMY1Vm0lmEkUhMUUrjFYv3BjmrC+?=
 =?us-ascii?Q?NKUP1ZXenN+sXYK0id0t+/l9oPM/Yj2CsWPKdI3hR7jYKRQYNjcgEhRnlreC?=
 =?us-ascii?Q?8nhNB6NimtWzs9aSdg4zIWmULMZvw7m2bleQQ+X7P3jdypl422dYHDn8avTn?=
 =?us-ascii?Q?j6sVETcJUzKkKHQxzB3R3OhwCQlDQZ+cTqvvFb06TqqpFQJA3+Ux87gkw28b?=
 =?us-ascii?Q?nBGfhDGxSQsh3olx4NUbmrdh1wYdwrnWbu8WlEq4zGIQSnyd/lm1Q36O0JKg?=
 =?us-ascii?Q?0AqxWKyQMQj6qbz3I7RT5b37UNbIPiM067c3ROkOTK1wBJXQGBqFxoKsg+Y4?=
 =?us-ascii?Q?mRlFD1y0W5J7ul3hW6UJ/iKCHdUdpsjVNjnaJBHgauuxG4Wnm83GA8RpuOBW?=
 =?us-ascii?Q?tu/2I4Hgzr0pdFVc/fmZGAxu8FTRnyDsgbFL5t/CV9OaF5q7LQAlbHbFnyVc?=
 =?us-ascii?Q?awj8iES417MtKmbowxfIEUgoxSOVyAoSlJMZfHeK0ybQ0nxcG6o5wLjidgNm?=
 =?us-ascii?Q?Gg0lmUuVu7yjQ8Yb0JrHEE/VycnLQW6bWXsJBda9de3l18z+IGphgACV7p3K?=
 =?us-ascii?Q?81lxEdeOceDH3k50z4rwWXQZHOBKrkhUryrvKiFW+/Oet5d5RzinRKFDoHfM?=
 =?us-ascii?Q?w7dKkbkpeSGYSgUf5b2fMbRblNBLHjzVza85B/vG63Wfpg0vcDcKRJDho56S?=
 =?us-ascii?Q?jKeS3oi06NNlfdplivMhYgU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645b722e-5049-4d37-8d29-08ddbada4c03
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:10.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoaVyMiwYGKNcM92Iwoz4debndPwnNZxTrh78l1VG13HBrRNnud6mPG+S7OtaBXJcGvnkgryEPYR2w1Ea2Yhz6qAVQoo+WOzDzYd2VTwNnuw19Q4ZAQYK3Cjn7x8hcW5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19352

From: Biju Das <biju.das.jz@bp.renesas.com>

commit f5de95438834a3bc3ad747f67c9da93cd08e5008 upstream.

Use devm_add_action_or_reset() for calling put_device in error path of
rzv2h_icu_init() to simplify the code by using the recently added devm_*
helpers.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/all/20250224131253.134199-5-biju.das.jz@bp.re=
nesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 37 +++++++++++++++--------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 0573062c89c4..d724f32dde8f 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -419,6 +419,11 @@ static int rzv2h_icu_parse_interrupts(struct rzv2h_icu=
_priv *priv, struct device
 	return 0;
 }
=20
+static void rzv2h_icu_put_device(void *data)
+{
+	put_device(data);
+}
+
 static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
 {
 	struct irq_domain *irq_domain, *parent_domain;
@@ -431,41 +436,39 @@ static int rzv2h_icu_init(struct device_node *node, s=
truct device_node *parent)
 	if (!pdev)
 		return -ENODEV;
=20
+	ret =3D devm_add_action_or_reset(&pdev->dev, rzv2h_icu_put_device,
+				       &pdev->dev);
+	if (ret < 0)
+		return ret;
+
 	parent_domain =3D irq_find_host(parent);
 	if (!parent_domain) {
 		dev_err(&pdev->dev, "cannot find parent domain\n");
-		ret =3D -ENODEV;
-		goto put_dev;
+		return -ENODEV;
 	}
=20
 	rzv2h_icu_data =3D devm_kzalloc(&pdev->dev, sizeof(*rzv2h_icu_data), GFP_=
KERNEL);
-	if (!rzv2h_icu_data) {
-		ret =3D -ENOMEM;
-		goto put_dev;
-	}
+	if (!rzv2h_icu_data)
+		return -ENOMEM;
=20
 	rzv2h_icu_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, =
NULL);
-	if (IS_ERR(rzv2h_icu_data->base)) {
-		ret =3D PTR_ERR(rzv2h_icu_data->base);
-		goto put_dev;
-	}
+	if (IS_ERR(rzv2h_icu_data->base))
+		return PTR_ERR(rzv2h_icu_data->base);
=20
 	ret =3D rzv2h_icu_parse_interrupts(rzv2h_icu_data, node);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
-		goto put_dev;
+		return ret;
 	}
=20
 	resetn =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(resetn)) {
-		ret =3D PTR_ERR(resetn);
-		goto put_dev;
-	}
+	if (IS_ERR(resetn))
+		return PTR_ERR(resetn);
=20
 	ret =3D reset_control_deassert(resetn);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
-		goto put_dev;
+		return ret;
 	}
=20
 	pm_runtime_enable(&pdev->dev);
@@ -496,8 +499,6 @@ static int rzv2h_icu_init(struct device_node *node, str=
uct device_node *parent)
 pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(resetn);
-put_dev:
-	put_device(&pdev->dev);
=20
 	return ret;
 }
--=20
2.43.0


