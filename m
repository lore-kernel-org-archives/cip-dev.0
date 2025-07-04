Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC50C83F05
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:07:56 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.39])
 by mx.groups.io with SMTP id smtpd.web11.8480.1751620072993928161
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:07:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EE4qzdOm;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cz/VWxwKAK/sSH2UKdxSUXLypRH+VvJTFOxXSSTi3sDFRNfo1OAhfNvEgX8znzsQLAWvrQJnmENUxeCcWi8iYIG1zBFymrI5zRyLKCZCZfYH0hg9eBaOK3wzNre5zZiwzo0Jd7CO/E0QTK8BSApV7SnupQPYp3p/ezXT1QOzAI8AJvtZISJTLCMSyPG7n5eqU+jngz7E0fyRe1bqU9/DeEKpCqKy6Z/0tdmk/HPk61onbBQYMwU/ksHGVvGh5UZk7U0rQE4iz/bc0otSyRmNhlpIgbRi/a5CXVPCcx542DEg4Iw1HvnvrPHLMqxMqwbCbc9ObBR5P4mFYWBAvqd3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ir59VH+FzxkhbAJ6NLAt/3WBPTYkXYDSS1K4bsQouw=;
 b=Fsdh/9jIZs/b+bbz48fNzE83SyihVcrQ9XNsXVaJNN0fx4Iq1LT1KT8RL+ueUdt5kcPYj3dEwRNxLmVQzPFXPKwFF/3pk2Bv6XYvtUPwngcGB79ptJVM/bmOM3fQjBV+V4TphMiD55XoKcXxhBMeM16HwyvlKCttBC/RO/i5g7hWkmPiq4M6NGxX2MLx662gpg/Naj/8C0qhC+pGDvXsqb4aU4S364AG7/RSJHNvEtuOSskJsquSrRw6fhqUbiSdm9sdlZuzBpNdJds2/b9haGv/XVpqnL2cN43cfKGMfUOrum6JzyRFWvFz0iTLKsFBiL+zuJbdGRLudmh6zYrX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ir59VH+FzxkhbAJ6NLAt/3WBPTYkXYDSS1K4bsQouw=;
 b=EE4qzdOmB9t363lA9ZGZRF7h2Xr+Z+Nl4LdZWgp84EvGBp4qwMHpKL7+ZNKdnTXwqtR35s2yu33i8jYeGfNeLOkAcoqYDR0Vs1yVlBLoX3siqRCeYkNltQHHC0k1JNKejAZ9dbtQdCB3Qwpuc/d3Xrmkp3feeWB/Ja+k69eZqjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:07:52 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:07:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 02/18] reset: Add devres helpers to request pre-deasserted reset controls
Date: Fri,  4 Jul 2025 11:07:08 +0200
Message-ID: <20250704090724.669848-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB14451:EE_
X-MS-Office365-Filtering-Correlation-Id: 6469cecc-23fe-48f6-2999-08ddbada4184
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hnxt6WLXdnCjmcThJG96VNCmRdyexf/U14nJ4FvnWlNWw9izMwXkgNI75z0c?=
 =?us-ascii?Q?h1qNiJtkkWs3vaSDi40Zayiv35ZDHiQiDiMWcfMG0n15F0bhosLxVEdg1Qgr?=
 =?us-ascii?Q?Jx2/huoBnGiKZGJn4GxSLbnEKX70vXKOIIW0f2DBZ+6dmok6FW5h1ctu7FS5?=
 =?us-ascii?Q?U99M++kSftW+b65q18ZgGLIGBcAiXcWAH/T/O3iXJP3X4wiHXdV031+Dj0QF?=
 =?us-ascii?Q?4N3cFPugf26Vz1iMTC3PazMcUgQf1pIeJZ2DVse9ixzRhqw4XlRQ24Fp8pYT?=
 =?us-ascii?Q?jDpJRrvV7fmpkvRt0KZbsE5iyfCQhVlUX4Ap3sTAdn3IHplcPL7S/Kj90uOI?=
 =?us-ascii?Q?W/OLz9qRFgvx/XXW0s4OC1+jUwexh0rAe+yluSZHUSGlXM3CMM5cvyFybuPN?=
 =?us-ascii?Q?N/MYSXSxcFw0G8lXsyhG2MJCIv+IeASP0Ceg811Az6jl9Q04C9APtmhwkkvR?=
 =?us-ascii?Q?B70orlvOJKGQnwN0Bd2+Ev59UR6AUvRWtAwSZZIOnZ5UOjyWustpuMtfSszr?=
 =?us-ascii?Q?haH5vv5HMWMDcKg8n+/kSGG+2WlEUG8xdIeehL2/KLWqcZIA1MthTdbWPqpN?=
 =?us-ascii?Q?/Dp3evxqnwxI8DFaG7+1d93ccoIXtqqDZJ9q0EYF6g09bsRwcxXWp91yPmzZ?=
 =?us-ascii?Q?rghfVkz030EKdwbU3fm4XUeZI6ked+YoTK8BOLIDv4fIbVC+HleArkLHKNuN?=
 =?us-ascii?Q?ugK93AUqnnTdL3VORFN/zqCXGUFpxp4+mts+hvl/QHjD72G2H2WGE1AyrruK?=
 =?us-ascii?Q?wAHMbFSTzCUJJ36q7g4rMwo2J2Mjc5qGsIUceZgClpybBC+wspSKYjJlBl3T?=
 =?us-ascii?Q?pv3VOwjNVOX8DXAE6J+rJRtU2AKEzblFA7YQ9FhXuHg/dn8wVMwmgW6ubj43?=
 =?us-ascii?Q?parqRu5oKOZ0DLsoZdOodkmJj/fbmrhARHljEhDpAdaq2V7z6+mYSsmyqY2J?=
 =?us-ascii?Q?3pT1E8nqQmtwED+AOvfrqAfPY7O+IYZJvVahoS44CGui496argk/vAH24d59?=
 =?us-ascii?Q?O3MNqGedKl9YYIPcUPrmR8HioQk4cbNbTPHQyJ3rBK1sac2/nu9+vqxjO8/Q?=
 =?us-ascii?Q?EDR66HTMJRBPFvKxcQu36KowUmfCpPjK4qJBS/E8WZbk1euoXbxC1BliqP5Y?=
 =?us-ascii?Q?tiMgqKr++7rZwUYm0I7l8L7KmJ9ZNuvJ1snbUNqzQ6D9AhT7TtcCbtdpwy6h?=
 =?us-ascii?Q?m8kFJF0vitScbWcKdvcnYMF0REFL3BF0IczMW67N8M4AD++50bVfLzAkC0po?=
 =?us-ascii?Q?Cz6/8+xTkr2tXaC9L4zSkOQYBYcDGaP6+LhvN89rMWbZ45sBOr/ICyhKTMHR?=
 =?us-ascii?Q?729Jaf46Whe7TknOGj1s5TaiVa3K7SV7U5KXwboc3u6qVSA2F+QQE8zaA1dE?=
 =?us-ascii?Q?YpDsyaLpLdYzj8vqGRc/alBEyhlfp9TmUXd6kQBf3aHfZ/wM6JusrmiIzcZN?=
 =?us-ascii?Q?ksCkv16F0ucUVxCj64k5uWyyPjviqIIX5WWa5DWvgeclzld6S99UFVDEIqzE?=
 =?us-ascii?Q?jTmYNKuJMeDMsR4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?b/7NqbA4keIiEa3EN5zt1602RBRwGMSnJkDZWB1D2v9lLr3jGm6AB9DbmVlB?=
 =?us-ascii?Q?TRVTtu3qMcY3dp1TD/tauMTy4UZCraUQGcQyHSkBwPINoOMfrvpOoELhlflS?=
 =?us-ascii?Q?i5/MyYojGoEgafDKNvrXILOKJ3ISg0R2a/S2mXIHQ+mWwQCemnJ3EG1stiWs?=
 =?us-ascii?Q?Ophvq9hrzB16EJ9aG2UcdcfOduKbsoL8kR7z2ZZhTyXwB5QOkCevVwk+Tzvv?=
 =?us-ascii?Q?0fCBmrq8dzONQEqKeDQ2HLTj1k+d5aEv772Ar0b0gfakKun2JUIqjrNxfgLN?=
 =?us-ascii?Q?89vBb+ZYz08HnV08fIzqqVo9xi3YUU12N5CVSDD62SaVirZ2I1zVm4EfQrGf?=
 =?us-ascii?Q?HfG2zoJskpAL5uT7JwR3mtMmA4Lqr/cxQMeHrKK3afMzZZxzTGN1p7aISVcs?=
 =?us-ascii?Q?Lrr3uGrY29+ZMv7LP7dODQ0gHPyw7B82/2LC4dKz50slm5dLycwdn0R0lna9?=
 =?us-ascii?Q?4thjtVdxbnFFJVZMdhADr5P9tVghAysdxOOJWe1H1Sd4E4Ns2ZK6sAQ9Bsbl?=
 =?us-ascii?Q?qs0xXxdcOm0hC7SF67nvv7jEyp2DChEgS9WTcraa/FznnNR/wzsexpBuPnqV?=
 =?us-ascii?Q?41liB5uZXcBp35y8309PUKYWRRf7qju0iIPEIKsczCBFhTdcPYhuNAocTuvp?=
 =?us-ascii?Q?IFPGGxo/8KBYJ0une+BiGiFQs5mWZTByWLzK5CK/A+P0PsiL5+IW08y6jYKC?=
 =?us-ascii?Q?JvsFAqGYmL8QOqqQVYZmr3QyUOKSzBsBEoohtz0ebjdYKwnrZAaAYO/Y9pdM?=
 =?us-ascii?Q?jchw9ZNNvTDd84DMaUPq6Lps5hgekmtM7ONSmeHF/Vhzky89dwbWYXLDquqn?=
 =?us-ascii?Q?RcUCnCiKMMI5tWbAjqZbrNgFf5aCrgPooGmAFBUTzK1rldbugozNtNmFkboT?=
 =?us-ascii?Q?yUjLvAn3Ts0UuBzu/Q9qDb727460N/8uNBKeqQ8+pCO3+vE4ERfNr4EEGJDe?=
 =?us-ascii?Q?WrZRN2VDyyqpwxfD13axv+ymOrtGhZO//oZEHN8HSyUkaJ1Pk2Xp//mYP2sp?=
 =?us-ascii?Q?qD3AdMi6dS2ZO1S29Xfx5wwFOXzZjQyBqo/aE5lqvbY4OU+NghdLZnoWYv4b?=
 =?us-ascii?Q?9VmMwvubmNu9c5YTecOFedWP4otT9+KmTV9vNZGwKwopep3d47jn7bsdUQ0u?=
 =?us-ascii?Q?mQAz2Uno1PyrInMISE8ScJXxLurzyeXHvjpUr7frRILEnfm5l3Yj43YOdil3?=
 =?us-ascii?Q?/h4QkmmnDHvHYpJsry7XZnXiZqLeyfJ3oA4ZONefi2egk41Bw7P1Fs2zd2Bt?=
 =?us-ascii?Q?EAQyeRQ/kiN2YmhP6i16l6CWOv+8U3ns/i3JwOju6mmCtcdG9I7O0gS68xTN?=
 =?us-ascii?Q?ksdDOXE9/qdfVvIJHNLdwsoKcCN7XwV2cAfGezwsYfeuhmcn1CHO/VQiBUHq?=
 =?us-ascii?Q?ntS61nuMC7vYIJpD07ah7CJ0NJUwTHp55lSaDGp6ltfkL6kebj6LvqFd4W7A?=
 =?us-ascii?Q?YyJ6vxaklP+jsf8LBvXaJL+atsL7TBB7kIxqFhiNHXx751qwOjoivi6d7p/o?=
 =?us-ascii?Q?helU4MRhiGpDK+vPTuDDXf0dkPtkgHjoQzfNXJSShftfidUupWD6r4Rzemxe?=
 =?us-ascii?Q?I5JY027K3ulWqVk5mpSTUC0UIVysk28tayYOOr8d0eYvCWP1ekaBXZacOG9L?=
 =?us-ascii?Q?NcocLbhHPT4cv6FZQ22tyJs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6469cecc-23fe-48f6-2999-08ddbada4184
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:07:52.2402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scQ2BzhpzBuIe5W8YbzWTEyzVrxEJ+wawQ2I6he24u8zqg0AlrI0y0CihZpl9PUk4qowFiTqZdW8l7gEJZ8cZiQkYx9VyVoG41KwXe3TFIaobTlqtkmzDWLtUMug0fRf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:07:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19346

From: Philipp Zabel <p.zabel@pengutronix.de>

commit d872bed85036f5e60c66b0dd0994346b4ea6470c upstream.

Add devres helpers

 - devm_reset_control_bulk_get_exclusive_deasserted
 - devm_reset_control_bulk_get_optional_exclusive_deasserted
 - devm_reset_control_bulk_get_optional_shared_deasserted
 - devm_reset_control_bulk_get_shared_deasserted
 - devm_reset_control_get_exclusive_deasserted
 - devm_reset_control_get_optional_exclusive_deasserted
 - devm_reset_control_get_optional_shared_deasserted
 - devm_reset_control_get_shared_deasserted

to request and immediately deassert reset controls. During cleanup,
reset_control_assert() will be called automatically on the returned
reset controls.

Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/r/20240925-reset-get-deasserted-v2-2-b3601bbd=
0458@pengutronix.de
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/reset/core.c  |  48 +++++++++++++++++-
 include/linux/reset.h | 113 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 682d61812852..22f67fc77ae5 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1236,23 +1236,46 @@ static void devm_reset_control_release(struct devic=
e *dev, void *res)
 	reset_control_put(*(struct reset_control **)res);
 }
=20
+static void devm_reset_control_release_deasserted(struct device *dev, void=
 *res)
+{
+	struct reset_control *rstc =3D *(struct reset_control **)res;
+
+	reset_control_assert(rstc);
+	reset_control_put(rstc);
+}
+
 struct reset_control *
 __devm_reset_control_get(struct device *dev, const char *id, int index,
 			 enum reset_control_flags flags)
 {
 	struct reset_control **ptr, *rstc;
+	bool deasserted =3D flags & RESET_CONTROL_FLAGS_BIT_DEASSERTED;
=20
-	ptr =3D devres_alloc(devm_reset_control_release, sizeof(*ptr),
+	ptr =3D devres_alloc(deasserted ? devm_reset_control_release_deasserted :
+			   devm_reset_control_release, sizeof(*ptr),
 			   GFP_KERNEL);
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
=20
+	flags &=3D ~RESET_CONTROL_FLAGS_BIT_DEASSERTED;
+
 	rstc =3D __reset_control_get(dev, id, index, flags);
 	if (IS_ERR_OR_NULL(rstc)) {
 		devres_free(ptr);
 		return rstc;
 	}
=20
+	if (deasserted) {
+		int ret;
+
+		ret =3D reset_control_deassert(rstc);
+		if (ret) {
+			reset_control_put(rstc);
+			devres_free(ptr);
+			return ERR_PTR(ret);
+		}
+	}
+
 	*ptr =3D rstc;
 	devres_add(dev, ptr);
=20
@@ -1272,24 +1295,45 @@ static void devm_reset_control_bulk_release(struct =
device *dev, void *res)
 	reset_control_bulk_put(devres->num_rstcs, devres->rstcs);
 }
=20
+static void devm_reset_control_bulk_release_deasserted(struct device *dev,=
 void *res)
+{
+	struct reset_control_bulk_devres *devres =3D res;
+
+	reset_control_bulk_assert(devres->num_rstcs, devres->rstcs);
+	reset_control_bulk_put(devres->num_rstcs, devres->rstcs);
+}
+
 int __devm_reset_control_bulk_get(struct device *dev, int num_rstcs,
 				  struct reset_control_bulk_data *rstcs,
 				  enum reset_control_flags flags)
 {
 	struct reset_control_bulk_devres *ptr;
+	bool deasserted =3D flags & RESET_CONTROL_FLAGS_BIT_DEASSERTED;
 	int ret;
=20
-	ptr =3D devres_alloc(devm_reset_control_bulk_release, sizeof(*ptr),
+	ptr =3D devres_alloc(deasserted ? devm_reset_control_bulk_release_deasser=
ted :
+			   devm_reset_control_bulk_release, sizeof(*ptr),
 			   GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
=20
+	flags &=3D ~RESET_CONTROL_FLAGS_BIT_DEASSERTED;
+
 	ret =3D __reset_control_bulk_get(dev, num_rstcs, rstcs, flags);
 	if (ret < 0) {
 		devres_free(ptr);
 		return ret;
 	}
=20
+	if (deasserted) {
+		ret =3D reset_control_bulk_deassert(num_rstcs, rstcs);
+		if (ret) {
+			reset_control_bulk_put(num_rstcs, rstcs);
+			devres_free(ptr);
+			return ret;
+		}
+	}
+
 	ptr->num_rstcs =3D num_rstcs;
 	ptr->rstcs =3D rstcs;
 	devres_add(dev, ptr);
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 99296af98f81..2986ced69a02 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -28,6 +28,7 @@ struct reset_control_bulk_data {
 #define RESET_CONTROL_FLAGS_BIT_SHARED		BIT(0)	/* not exclusive */
 #define RESET_CONTROL_FLAGS_BIT_OPTIONAL	BIT(1)
 #define RESET_CONTROL_FLAGS_BIT_ACQUIRED	BIT(2)	/* iff exclusive, not rele=
ased */
+#define RESET_CONTROL_FLAGS_BIT_DEASSERTED	BIT(3)
=20
 /**
  * enum reset_control_flags - Flags that can be passed to the reset_contro=
l_get functions
@@ -35,21 +36,35 @@ struct reset_control_bulk_data {
  *                    These values cannot be OR'd.
  *
  * @RESET_CONTROL_EXCLUSIVE:				exclusive, acquired,
+ * @RESET_CONTROL_EXCLUSIVE_DEASSERTED:			exclusive, acquired, deasserted
  * @RESET_CONTROL_EXCLUSIVE_RELEASED:			exclusive, released,
  * @RESET_CONTROL_SHARED:				shared
+ * @RESET_CONTROL_SHARED_DEASSERTED:			shared, deasserted
  * @RESET_CONTROL_OPTIONAL_EXCLUSIVE:			optional, exclusive, acquired
+ * @RESET_CONTROL_OPTIONAL_EXCLUSIVE_DEASSERTED:	optional, exclusive, acqu=
ired, deasserted
  * @RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED:		optional, exclusive, relea=
sed
  * @RESET_CONTROL_OPTIONAL_SHARED:			optional, shared
+ * @RESET_CONTROL_OPTIONAL_SHARED_DEASSERTED:		optional, shared, deasserte=
d
  */
 enum reset_control_flags {
 	RESET_CONTROL_EXCLUSIVE				=3D RESET_CONTROL_FLAGS_BIT_ACQUIRED,
+	RESET_CONTROL_EXCLUSIVE_DEASSERTED		=3D RESET_CONTROL_FLAGS_BIT_ACQUIRED =
|
+							  RESET_CONTROL_FLAGS_BIT_DEASSERTED,
 	RESET_CONTROL_EXCLUSIVE_RELEASED		=3D 0,
 	RESET_CONTROL_SHARED				=3D RESET_CONTROL_FLAGS_BIT_SHARED,
+	RESET_CONTROL_SHARED_DEASSERTED			=3D RESET_CONTROL_FLAGS_BIT_SHARED |
+							  RESET_CONTROL_FLAGS_BIT_DEASSERTED,
 	RESET_CONTROL_OPTIONAL_EXCLUSIVE		=3D RESET_CONTROL_FLAGS_BIT_OPTIONAL |
 							  RESET_CONTROL_FLAGS_BIT_ACQUIRED,
+	RESET_CONTROL_OPTIONAL_EXCLUSIVE_DEASSERTED	=3D RESET_CONTROL_FLAGS_BIT_O=
PTIONAL |
+							  RESET_CONTROL_FLAGS_BIT_ACQUIRED |
+							  RESET_CONTROL_FLAGS_BIT_DEASSERTED,
 	RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED	=3D RESET_CONTROL_FLAGS_BIT_OPT=
IONAL,
 	RESET_CONTROL_OPTIONAL_SHARED			=3D RESET_CONTROL_FLAGS_BIT_OPTIONAL |
 							  RESET_CONTROL_FLAGS_BIT_SHARED,
+	RESET_CONTROL_OPTIONAL_SHARED_DEASSERTED	=3D RESET_CONTROL_FLAGS_BIT_OPTI=
ONAL |
+							  RESET_CONTROL_FLAGS_BIT_SHARED |
+							  RESET_CONTROL_FLAGS_BIT_DEASSERTED,
 };
=20
 #ifdef CONFIG_RESET_CONTROLLER
@@ -596,6 +611,25 @@ __must_check devm_reset_control_get_exclusive(struct d=
evice *dev,
 	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE);
 }
=20
+/**
+ * devm_reset_control_get_exclusive_deasserted - resource managed
+ *                                    reset_control_get_exclusive() +
+ *                                    reset_control_deassert()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_exclusive() + reset_control_deassert(). For r=
eset
+ * controllers returned from this function, reset_control_assert() +
+ * reset_control_put() is called automatically on driver detach.
+ *
+ * See reset_control_get_exclusive() for more information.
+ */
+static inline struct reset_control * __must_check
+devm_reset_control_get_exclusive_deasserted(struct device *dev, const char=
 *id)
+{
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE_DEASS=
ERTED);
+}
+
 /**
  * devm_reset_control_bulk_get_exclusive - resource managed
  *                                         reset_control_bulk_get_exclusiv=
e()
@@ -712,6 +746,25 @@ static inline struct reset_control *devm_reset_control=
_get_shared(
 	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_SHARED);
 }
=20
+/**
+ * devm_reset_control_get_shared_deasserted - resource managed
+ *                                            reset_control_get_shared() +
+ *                                            reset_control_deassert()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_shared() + reset_control_deassert(). For rese=
t
+ * controllers returned from this function, reset_control_assert() +
+ * reset_control_put() is called automatically on driver detach.
+ *
+ * See devm_reset_control_get_shared() for more information.
+ */
+static inline struct reset_control * __must_check
+devm_reset_control_get_shared_deasserted(struct device *dev, const char *i=
d)
+{
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_SHARED_DEASSERT=
ED);
+}
+
 /**
  * devm_reset_control_bulk_get_shared - resource managed
  *                                      reset_control_bulk_get_shared()
@@ -732,6 +785,28 @@ devm_reset_control_bulk_get_shared(struct device *dev,=
 int num_rstcs,
 	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL=
_SHARED);
 }
=20
+/**
+ * devm_reset_control_bulk_get_shared_deasserted - resource managed
+ *                                                 reset_control_bulk_get_=
shared() +
+ *                                                 reset_control_bulk_deas=
sert()
+ * @dev: device to be reset by the controller
+ * @num_rstcs: number of entries in rstcs array
+ * @rstcs: array of struct reset_control_bulk_data with reset line names s=
et
+ *
+ * Managed reset_control_bulk_get_shared() + reset_control_bulk_deassert()=
. For
+ * reset controllers returned from this function, reset_control_bulk_asser=
t() +
+ * reset_control_bulk_put() are called automatically on driver detach.
+ *
+ * See devm_reset_control_bulk_get_shared() for more information.
+ */
+static inline int __must_check
+devm_reset_control_bulk_get_shared_deasserted(struct device *dev, int num_=
rstcs,
+					      struct reset_control_bulk_data *rstcs)
+{
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs,
+					     RESET_CONTROL_SHARED_DEASSERTED);
+}
+
 /**
  * devm_reset_control_get_optional_exclusive - resource managed
  *                                             reset_control_get_optional_=
exclusive()
@@ -750,6 +825,25 @@ static inline struct reset_control *devm_reset_control=
_get_optional_exclusive(
 	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_EXCLUS=
IVE);
 }
=20
+/**
+ * devm_reset_control_get_optional_exclusive_deasserted - resource managed
+ *                                                        reset_control_ge=
t_optional_exclusive() +
+ *                                                        reset_control_de=
assert()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_optional_exclusive() + reset_control_deassert=
().
+ * For reset controllers returned from this function, reset_control_assert=
() +
+ * reset_control_put() is called automatically on driver detach.
+ *
+ * See devm_reset_control_get_optional_exclusive() for more information.
+ */
+static inline struct reset_control *
+devm_reset_control_get_optional_exclusive_deasserted(struct device *dev, c=
onst char *id)
+{
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_EXCLUS=
IVE_DEASSERTED);
+}
+
 /**
  * devm_reset_control_bulk_get_optional_exclusive - resource managed
  *                                                  reset_control_bulk_get=
_optional_exclusive()
@@ -789,6 +883,25 @@ static inline struct reset_control *devm_reset_control=
_get_optional_shared(
 	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_SHARED=
);
 }
=20
+/**
+ * devm_reset_control_get_optional_shared_deasserted - resource managed
+ *                                                     reset_control_get_o=
ptional_shared() +
+ *                                                     reset_control_deass=
ert()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_optional_shared() + reset_control_deassert().=
 For
+ * reset controllers returned from this function, reset_control_assert() +
+ * reset_control_put() is called automatically on driver detach.
+ *
+ * See devm_reset_control_get_optional_shared() for more information.
+ */
+static inline struct reset_control *
+devm_reset_control_get_optional_shared_deasserted(struct device *dev, cons=
t char *id)
+{
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_SHARED=
_DEASSERTED);
+}
+
 /**
  * devm_reset_control_bulk_get_optional_shared - resource managed
  *                                               reset_control_bulk_get_op=
tional_shared()
--=20
2.43.0


