Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B58C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:11 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.0])
 by mx.groups.io with SMTP id smtpd.web11.48832.1743418023523524754
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FLt25yZk;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.0, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWKCQsGQ3CjnRG09Q9FksIelf1l9mFzXYPNU8e1BwqAPn1lPQE715XZt/DIWD7DyJAt2TBzktengCilTLu8yEjoV08ubEGXqKSRJqOnJBJL+qYF4U31IXUN6HWGNr0Oh6xNRAfMKNbt9kLZg4CPK42VgAtXY23rQ2zkCy//viZcxhq94HFVrfpFlfw8YrJ3OEXFKtne5BWo0A4QYB9FTQs3oZ3jGS5ZhixkzpLZwAkQ2csaDJlXtZ2sXmrCSgClchAPJBwHtPTYHPIXP1oxK8E8q3sb6+aWra3V1T5hmfARZ1AOEjHKCxg+SnMM2pJWLJ5ZciE1pKcE3vz0P2qzsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tETmjSuyRQunNEMenBN67o5F5/qPVzSF5C1tCNpiSRM=;
 b=HK1jTD0+ypbgd4WOwGs383iWKc4b3N+B70wkIlBQpX1RQHQvmR+QhrK5dxTG6Wu6DjVrhJ2rcvVhS10NNywmv6Jmz1Dbp4osMMFnveFXUHI8Z9cqNbru6MfVWTjKLfRxHu/jnHzEbYSnZ01n2SUrHrf2bymre02Vjpp8g07Sc1TL4QCxSjuMcx0EBNKzy0aM8prnozkOom5SFPbKo0hFyw6iIi+K1CNBQEEP2s4r8ltbpJnwcQgZhdJeCWyafp3ZJ4j+cii9+/lw33qGM5zQho+WeUQosLQgTTrKSIaX46WbVrC6a78WqM/yPpBLxf+3SWZVyN0DSzSyC1ilRAu13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tETmjSuyRQunNEMenBN67o5F5/qPVzSF5C1tCNpiSRM=;
 b=FLt25yZkN8OjuUzRGhfw1NWjo3OegGa5Ret7vscOgXOnfmv6Qa5gRqsRP1cV/ygtrsgSadnnY1Felyiy7OH344iS6fmg57otinCh8gXJOOAqmAUSgUNQ39qTTA0AYSkK0wBsVPxiWb8bzsxElBIDJ7ZgBoxNli/Qk+53WwKd88Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:47:01 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:01 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 30/43] pinctrl: renesas: Switch to use kmemdup_array()
Date: Mon, 31 Mar 2025 12:45:01 +0200
Message-ID: <20250331104514.79090-31-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY7PR01MB13744:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bd4ad4-37f8-42d3-9b0e-08dd70415e4b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gKr+s00F40x1Vl0y4WpJUvVjUljZ7rnTwZY9QFZBY7REPx1wBwu5qn629pk6?=
 =?us-ascii?Q?tE4B3dr7m4T7eF++EiVsyLzv5W703BfY5oEwyLUbEEH3XdtWNpYAQdnsh7cv?=
 =?us-ascii?Q?K0x+VBp3hE3qDwxd5ElBeKmsdOHWvfpcwxUQX/bLS6kZSQfx3UyELoczlEzY?=
 =?us-ascii?Q?WO9/F4Y89a3jbNKKvsgl9T3GmbrcMtjSBa6KWQ0mgfxbPfRrjWHtgJ9bS/T7?=
 =?us-ascii?Q?gp9r1wAgFpP7Zp7C1dXix/UeL5PSiD6kv5Ov+WPg6q4/Vw/4wWs/QnNE0OMD?=
 =?us-ascii?Q?TNYXr8Z5kqPDdxvBcOemp6oQ5w/ZqasDKaR7rrZfDRr4OGfa1P9RhTCAJ8hA?=
 =?us-ascii?Q?i87Hz4NVpPgLPGx1klV5ImMzJpZ6DUmi45aN5SqUmaXSmtcwYus7sj26EcTC?=
 =?us-ascii?Q?TWiNhpFMDHbWRTKnDuyPl336ddcDgn/HvyqRp7/Bm74UwCS3b6ZJXLK3twqt?=
 =?us-ascii?Q?CPLsiUz7FosE3FW6SHaUzZJzrE9IZiKLRugVxyfkIutYgTZ3lUNTFd7U7C+E?=
 =?us-ascii?Q?+6IMlKFSypz3SKOocCpXhCOyJdQ5WciF6QaUGEQF39HCJldSksum7EyBPpTU?=
 =?us-ascii?Q?IjXAcplq+u7SYSJnRbu5nf2z20Pay008E2C2YZk0ZZD1ExYXDO4uuXgceV+c?=
 =?us-ascii?Q?PNBZXjbFQ7C50fYHkRNJKUUsyurNej5FFXfvNcsfBxaxH1RoPfkF+4orGaJo?=
 =?us-ascii?Q?hJbUsf6QEQLwxDREPE83r/Aa2C+oLkH+KMiWwrM/baxELtjtEVJkIKnscmSg?=
 =?us-ascii?Q?ZD98m0i1v3hAKos7RpdhMXFhbLIPEhTY4Hh6ElEnjKv155tnQGpgtcC714bd?=
 =?us-ascii?Q?8XPXvCCDDvHlmzg7+AL2H5YdbuC8B7oiMj00JY9rCTkf5fjaiH8vzEfTnOp4?=
 =?us-ascii?Q?ITfkELxgA9xSS1j38XcL4gISz7EMuUaqtgjoEA1BosIiB+lsPVQyMrBokYdE?=
 =?us-ascii?Q?d9hrYKnNvBcw2J/aYjPP5z4lb7GSeCclHT+JQ5QU0VaefdP46gY8A9nFGVsB?=
 =?us-ascii?Q?8OzuTHK0xOLX27xH70GtbLz9s/6e52y8vhXN7zE5uzNC1BP3QV9kAEvlCtiK?=
 =?us-ascii?Q?+xxQyhHGxW5X0v25qyxSHCRA4icziLlmycPrlX5MG9bF1Su/xHuJX09oavT5?=
 =?us-ascii?Q?W+19ApkrqlPvCzMNleEG0fcsfoyc7DD4o5R0hdYY69/ifFIYTgE+HSgHiIK9?=
 =?us-ascii?Q?RRl0r2CydIVFekPzRWtmh/f/0QFg5DXe1z8t6Jye3A/bhvvcDUt5RM7U4CvN?=
 =?us-ascii?Q?nGwyxIE8Ha0ptnlIIb+J/SZw+4UVb+Nv9vlgGC2S1MlDoRanfHonS7f4r+A8?=
 =?us-ascii?Q?0ZPbgeDjTBasMAlw28LLtHtrK0fKOC0CW1pHs1iAamazxGla5lOPrT0+TkH+?=
 =?us-ascii?Q?c1KgmEx2+n6fDY7XmHD5TZcYC7ja2icxghhp5hUyd12YGFbCVgt8LgLoouHd?=
 =?us-ascii?Q?T+0UKu+cq6Wv4HIcXJKVdc6pIIdM2KDl?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cAAj9TqnUMjet1Q3xO+aJsbUsY7BPHp1LjrJoKRrYQhvyGsOlGjcpIvE8088?=
 =?us-ascii?Q?fwQjQ9ggFwkeecFnE2SIHamjRBIrYNl0YWUYzvDTbp4BZVV8xIG0F589TKH3?=
 =?us-ascii?Q?0BDt7j8xvcBBB23Ce9GegfR3M7692WpA+odDAMEiZWrzYFMJG2/sczdK4vpV?=
 =?us-ascii?Q?56EYCdLGdHgMrBoaesx1fNaBo2UAx8pEYVzuh+ntpeG9FhzV5Ol1HFLJ5T0J?=
 =?us-ascii?Q?92LNGJbO13/BAoYg8+iFzi4hzRRWpno8lW3MU6JH64zFsmPCEPBaHOj7+cE0?=
 =?us-ascii?Q?8XHWJ8o8B60EnrG9UX1SFV0GHfhM+OXRmkDAqt2ecT/sGNqLbymYba+CKJx0?=
 =?us-ascii?Q?vfEWRKErh9UrvNOLSl0Ly8xwwaJlcF04xv2IQtsQavqOjPU5P4tdoHN6QwoK?=
 =?us-ascii?Q?A/gAUeoz7a6AttBV5GuHX0WiEBnD1C11kXuX7n4iHERi93o43a+qZ0SPCH9w?=
 =?us-ascii?Q?+Mhzmr+D0NvW3X6V57IGDQDj8dwMYrudohxEXTlCptwBXAtTjqCXzbaqwozU?=
 =?us-ascii?Q?LvGWLArfFAgTFVDmUpCQRFUfrYxidsc1KveYf4xIf55664fYeuiamH1DxuAf?=
 =?us-ascii?Q?oVrul8MGarFRzxE5rIcG8dI6o00dWUiAyEyf2lKg1qp/q9+GIK+aU6nqeDPM?=
 =?us-ascii?Q?NaCLcXDDwFeIMyeZIKFJHT8UQ462zTlOFVoFcl0/xzgIh61xSO2nCszKK/8c?=
 =?us-ascii?Q?AJxueH53OMPjp+1O49u1+IAh8JRApCLRsCRTH2ITqg2slGpIZGJBUBX7EWig?=
 =?us-ascii?Q?4IQYH8eL9M+XJXrC4J1G4y4Rmz3Mfg5xRrcaGyIk6TYopS/od4mN5kkTFmvF?=
 =?us-ascii?Q?+miuSSg7BUYLq2CvP2KhiQvDlH1fUMpPVO0cI9AHrERNvhr3AyhORBBf0DYU?=
 =?us-ascii?Q?vDf0fzA4SrjhCkMw60Q2nsWzcgPF/LMtdEgPsss0yUEa+b6tyxyQNhuuvH6u?=
 =?us-ascii?Q?NsovbwdDYvvdFtr4zFNj8bqFEGVuvFLNUHuk+5yN26D8A53zTy6K5b9ZhMPk?=
 =?us-ascii?Q?TGY9V1FlltGKvSDBvGGM3pQFdMj4fdePcnr5M5brGU7hkyueytqELuaOeK2d?=
 =?us-ascii?Q?jQszvz7dRLuRcTXnTBW9tyCyO5dg89XcUogeMXJosRQNgh/W2JWs02DB3IaP?=
 =?us-ascii?Q?WteV4x/QvJ8SMWND1LBJ6f22WAghSmkkwPb3DOiArxOpM2T0Wk3xTBTgyPA7?=
 =?us-ascii?Q?LKP5P2nU+ezEO4/WWI2ENqPFOhbV99FZze2Ilpt3O21yQ1lD6OBFzj5yNxJu?=
 =?us-ascii?Q?lvqmUUMzvcJcHihGXRmETrfnJIS5l2z6dX//y/I7DceGG+Hn2W83Cm7aPA4F?=
 =?us-ascii?Q?Tepjlp8XCepVRGYcCg8oDByFPKDUcIZWP1iV23apFOjElOXkw7AHgfPwn9sc?=
 =?us-ascii?Q?whV0z36u51vLpJTlfhkYrz67wFIWSSR3ozKWluzE/61fmLG4RRI/FGg5NFQM?=
 =?us-ascii?Q?xzMtgmgrfO56uxLSDhJW5HZhnSdUAl8mDg4j5YYIfeY8WIyZfTLYMHLWyWWi?=
 =?us-ascii?Q?x2EldjgK8gyBa0M2dQ42UL/5nDgETFnoy2j7N4DMhh549kzsvXXRpmHphLtR?=
 =?us-ascii?Q?hi7sdcbBtVh9VJB4Oq1puC65TwtFTnyT+nY7UEBiaAqbA5eA3HVhiwrZfsgx?=
 =?us-ascii?Q?SZq+cb3o38Gc0PimK01Rkb4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bd4ad4-37f8-42d3-9b0e-08dd70415e4b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:01.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ2C5SBzUH7Lq/G1FKmEhrlD/hXsToNuUav1NEqod8fM8KoKxVjOaPPIZDZa0xXIjzCaqzdiVsSKFUlhWTmb8Cmloomnyftg2VKmZPe3IIxYOdkicQ/HkfomO6E/ufoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18418

From: Shen Lichuan <shenlichuan@vivo.com>

commit 5e633f572bbae9397ee50347bbe0529894de4137 upstream.

Let kmemdup_array() take care of multiplication and possible overflow.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240822061438.14617-1-shenlichuan@vivo.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 +--
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 3 +--
 drivers/pinctrl/renesas/pinctrl.c       | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index bc671807bad54..4c111fb27845c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -527,8 +527,7 @@ static int rzg2l_map_add_config(struct pinctrl_map *map=
,
 {
 	unsigned long *cfgs;
=20
-	cfgs =3D kmemdup(configs, num_configs * sizeof(*cfgs),
-		       GFP_KERNEL);
+	cfgs =3D kmemdup_array(configs, num_configs, sizeof(*cfgs), GFP_KERNEL);
 	if (!cfgs)
 		return -ENOMEM;
=20
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/rene=
sas/pinctrl-rzv2m.c
index c2845f6654122..32fa51abc2d3c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -196,8 +196,7 @@ static int rzv2m_map_add_config(struct pinctrl_map *map=
,
 {
 	unsigned long *cfgs;
=20
-	cfgs =3D kmemdup(configs, num_configs * sizeof(*cfgs),
-		       GFP_KERNEL);
+	cfgs =3D kmemdup_array(configs, num_configs, sizeof(*cfgs), GFP_KERNEL);
 	if (!cfgs)
 		return -ENOMEM;
=20
diff --git a/drivers/pinctrl/renesas/pinctrl.c b/drivers/pinctrl/renesas/pi=
nctrl.c
index b741478003199..0cbeb70c1d7ba 100644
--- a/drivers/pinctrl/renesas/pinctrl.c
+++ b/drivers/pinctrl/renesas/pinctrl.c
@@ -87,8 +87,7 @@ static int sh_pfc_map_add_config(struct pinctrl_map *map,
 {
 	unsigned long *cfgs;
=20
-	cfgs =3D kmemdup(configs, num_configs * sizeof(*cfgs),
-		       GFP_KERNEL);
+	cfgs =3D kmemdup_array(configs, num_configs, sizeof(*cfgs), GFP_KERNEL);
 	if (cfgs =3D=3D NULL)
 		return -ENOMEM;
=20
--=20
2.43.0


