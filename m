Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA4C36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:07:41 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.19])
 by mx.groups.io with SMTP id smtpd.web10.49412.1743419256339749159
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YavgADnj;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.19, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3FgXO/ctOJ2nHNih5zMTMN5l/mwOsAjJJTywjxHc4aAecqxLoAUj1BrlsjgMePZjRrw+X+5eg60MifIhaq0ooqiVXM6yongpIr/BeXI0d8abZpIZCX4/778+BVLVDb2GufXSvcXi1ysH3cLZNYLSjTOFXHBgsionUhAx5NnFZKOGe8Ns6g6T9quzRrFO5UH7RRx2TgzPVEOBiS4yOkf4wYWSQEHiR3DVho02keHCe5T1Qu8oHO+iWaNUteCgMG87P9k1ssVeXVl16izW7mDjGwdAJEw1ktfUsB4pcuuWHMZTYE7rie7rKeBKbveyqrVObXbBT1/ND1HzM4XrGijfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKmQa1Z2uKNmUeu4dqImb7wJY3JyobIBME03OPommA8=;
 b=Z28Zp5Iy7NKW7Npo6/iRVov41aoZlueTGohaZUqWDLYaQiNN6bRlcrAIbbIrD4Zguwbfz/Uc1A7CQep1fR2LAAH8b6tXgFdZfqZYbgVEoSLi7pmm78iTEPb/VKInFiAAf2Dy7Pb/OJ10M8jiITXycIJRGenXyilr1xjqVXgDQD+S8/Gv24S+OlNnaOcbou/1sdEaisw/FGp6KZ0V31mPsVUmZGSUYtrlF9VKkjDKDhhZ+Jv+y3GdDEOM7CEoOuuKkUsIOS9uRDMHARvoDqCcvj49NFLWget6St7ZPEeWWWHT5Gwd+jcHchxvYV91Ne1ibmWgJ8xZTkqQkoOWFo7DWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKmQa1Z2uKNmUeu4dqImb7wJY3JyobIBME03OPommA8=;
 b=YavgADnjzpf2JvszXVWpdC+t7HwyGOSSwDPeSA/xpC4KwZgJ9cLAmIA8KibJGpbr6iJXXvT14Q6kpi+3/jafoyyw5bfoMv3ZBpzmxfcWRNBLYO1rJnLm5WewH6pfabtahZcPjdZhpRDaCDTLUBchzM8dswoDjAarMU0ziTblOOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:34 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:34 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 05/13] pinctrl: renesas: rzg2l: Move RZG2L_SINGLE_PIN definition to top of the file
Date: Mon, 31 Mar 2025 13:06:51 +0200
Message-ID: <20250331110659.252237-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15065:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb3e05e-329d-4ec2-e992-08dd70443d44
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?phO+AiX7Cx2BGT41ftAxIaVAAV1y7jCi6lxamqs8bWPwGkAZnZiNU2U5zq3/?=
 =?us-ascii?Q?KqDPd60MffDSJmxmn8FTFwdKqKQb+uQaClVq45tfacpwMMkpzdodDzGzzHWU?=
 =?us-ascii?Q?UsX6uyP16PWzR+wZJkzPM+eypxrPD5Xm8AaH4wOFy59rqR6/PaNp5F/M47dS?=
 =?us-ascii?Q?uhS6+Pz6aGEuebeBFsqePAN4/CwXguYHUrd2M5VPug+r2+6j7VyCdNgNoWTd?=
 =?us-ascii?Q?Wd0X9KqISerjRW6U9aZiGUQdxtoYXJvORpL/KyGORheLTgjScLuoZeYHtmDw?=
 =?us-ascii?Q?U1fFror81ZnylI7PmFwZzNcqepM8+/iCYsksjebc+PT4URt580QrDH8lA2Xe?=
 =?us-ascii?Q?U1wY+OPHnN3hZ+NMODPqDxaMv6vw0Wk0OkgljVBQaE5O7JjqjE6nVOtLW1nY?=
 =?us-ascii?Q?5XSyHIbHyea6khhsCfl60zfM5wJtvLG/sJfx/dPvuCi85mH+oiEXs6jn8lNK?=
 =?us-ascii?Q?IOWHXY2yJOL7/uIcckcpy0RmptNOPPYfc3zj0WkVCa5Y4efF9YsVMo5RKWca?=
 =?us-ascii?Q?gYLz6RFzCMDtY/RlXKvCSX10Vso+QH72xi3AuyLRWNqfB1MDMl8z6xxhz3Fh?=
 =?us-ascii?Q?KuVZfi9AROQdB9hB916Oiig05xhpfi576D/Mw2qWMI5Q5pDwIda3O7a3vALO?=
 =?us-ascii?Q?TigXHCXg3Nmw2RdzR/RSpK1VGCa52K6KikYWh29zS99gafuTA+9QNZHW3vKU?=
 =?us-ascii?Q?+7ZfrIwcfvyH8p3YlJPHHpQX9rfJqHHp0k4u1TeuNv2ziMBWdc8AHrBepM4t?=
 =?us-ascii?Q?WjjCF4PrB96lBDVM7fpA6vKbrodiocTuodaeMKo2Se1syW0KBFRfmHFLDPGP?=
 =?us-ascii?Q?8/IfQH7YGoVr+ekoqjPl9+iOVJ/DoiDAzWcMcjVY4CI+x89nPfE4D5seMIfm?=
 =?us-ascii?Q?RgeSYKvTjCt2Webxe3w7YGruxqmt0STB+/HiND1JZwc4t2QbzjaCwg6ozMFo?=
 =?us-ascii?Q?T2oPg9CSpksf16zmORwvgzXfpuiS3qJ3d8n7OJhDc9+wQ7/sJc7BKeK8oTIq?=
 =?us-ascii?Q?F7Ne5avW0DPcQW8RNjh91jBQizCuwfa/hR7kQIQ4/loalYhhkuexvky6PSMC?=
 =?us-ascii?Q?ZFltzzg423M50uPjdXkeCy1HnwIQY3k3uG4yOSPgCFvJp7VM+HLoWHo9S/BI?=
 =?us-ascii?Q?dxm76rEnRDaipBF9mzSEUg7cyYzT8sCDUlk5xfNL/QCRXNyIWOG8LHwpUifv?=
 =?us-ascii?Q?z7wjF9ufsT3JTjTDgvROQzMZicsSmd1s5sXRa8t6Owv+tIzsAdC2UKClPYMu?=
 =?us-ascii?Q?4KijpjJMH9B2n55PFLHwoMKFPToAbEK4zod5yxybwuw3GW+m+6ZFNF65Th2w?=
 =?us-ascii?Q?KEUMmaczJRRiVrviiRyEbDVc2MP9KX8pkYcHHQ+qNYk07bNWLdQP3H9rarkx?=
 =?us-ascii?Q?Plylo5BPh9UQnoetEYlW6D5/E31Zl5X7CezZWu6igsCHHvk753qTuXLHClkT?=
 =?us-ascii?Q?e6fgPkIA8kv7+G7YN12DEdH9vO8C3+3Z?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vBgZ29hHgMxUKL/ylw8oo1BH1WdA2Y6qOmI3kPUL/lsUqsS66CKZZfqF0mLR?=
 =?us-ascii?Q?CN1T5zvTLk9nYgqA9H9EWFrKk1Cf+vP7wWe0Ia8OM9Dj1wUXtIT1ZNvLNld2?=
 =?us-ascii?Q?E+vWBBuvHWzoc3i1aH0JT/wHx0v5/p4teRp+ykVgaOssR2PhpmGWJUBB57j6?=
 =?us-ascii?Q?37OqU2A29V+pzQwI9YbNbpFjZrhZJyLJD23V9uumX2ECgCRK8ECAyaJfwe6z?=
 =?us-ascii?Q?Y3Xbx3C2RT1lq2jJUC+/cehAn+aomPXyHrY2iYAiPDgDWrOgdB7ophFqw1ve?=
 =?us-ascii?Q?y73X7ZcPcVD0ypRWbUkrhTWV/cBtDcD/B808clS1XlpypigjdTSbdHFF5FMm?=
 =?us-ascii?Q?phFBywpY0tsmkbgvxyR1SFs1BRZXCpGcBMBfjyhr4q5VhnBkLQ46ypF3guwn?=
 =?us-ascii?Q?JWQzUi4HceZLPsI2Z7yVzwJj5TvBUeLw+F89OB6qbTFNSrCwWxZAecTcZeyD?=
 =?us-ascii?Q?nXsW2CrYJVKJ2R51c61Au3XpxnTfWBMiWRLJgat3FPbv6q2ehHuMjZ73Igg/?=
 =?us-ascii?Q?RKX8i3JzDXEf/BXaL570I0oEQQi/2szPumxmGeS/nD3/fTeYqltLO6KLo/B8?=
 =?us-ascii?Q?llgkNyT86pjrJJleiDLVSKSV6/hGVgvRZSu1wCm71uDdNCB4GiuwsXq32L5a?=
 =?us-ascii?Q?n0OoJLluFbN0kno1Bm1t362l8MWhtPD7vRyrlJlDsK5oxlDx+gaPAjVpzGlO?=
 =?us-ascii?Q?/ay7fVoPEBHzuuAa+EY7siY2Ji5VI5Z7sv8hsDms0H2rvWIuVHW0m0CuDGOT?=
 =?us-ascii?Q?j26HhktpPc5r4cjufw/Wt7X4b2xd58Zwr+ZsmxgtadZTmsghKyyo6tFkexcQ?=
 =?us-ascii?Q?jKws6zqg7LQ/j0IGG+VthZjvQfuSwFzAckH//aZpz3EEA/qwiHj8xqeyB8/M?=
 =?us-ascii?Q?zFFX7nG+9J+NV2JCzsbEF/q2qIJT9SlmdZ3gyc42CvOrpFOUFIsHbIu/9JlX?=
 =?us-ascii?Q?8i+X9eCTKBAa8RWePTafjUVbNNAnQVkgo8WtwLCEwKRSJ6Ge+dIUe4GfHikn?=
 =?us-ascii?Q?pDoXH8ssrdyNJdSpMQmWgMG3X03cwlsXw49AuneIHoAmCXzbntAtpMFAS1Aa?=
 =?us-ascii?Q?8v+IGZVVkgpqPLImjVnllRUMXuThgKdagqCzaRfEFBLyoq5n7qo0jbJRGupm?=
 =?us-ascii?Q?x3o9NOzkpHjQqPp7S0JqTbfx+p/Hsj044d1dE+dNmgCU/aykn7kgbTwctMSm?=
 =?us-ascii?Q?yLGnna/AgPLBY7UvKImQ0mgZv9UevEHCmjniA1DFrn7pR+sNv4HLTnuq8aSv?=
 =?us-ascii?Q?LmagRzjKDb3nOyUs4Uh/Ug5W6MFqKejiQ14q//qgS5+6WlrKnHzs6IvSAbWk?=
 =?us-ascii?Q?sbHWQv8JChqEYFpi6imrTrZfWLQCO92xe2GSTXoeM9Yyyvti+IVWm+snvzqj?=
 =?us-ascii?Q?DbjYL44wSkWnbUaEvb7q8+6d/b5gbgpki9cD2PaQTW7S8w06fHLn0TZR85nB?=
 =?us-ascii?Q?KjhmwupuidkAhBWcwX0ZHNMbxrIU/mfmSnnui/tqM+OjzQOLDalVyP/RwEoe?=
 =?us-ascii?Q?h9xlRsRBQd7Hd7NUCVA3p0K3vGS9U3VxCLx1pruHEM6PMsrmiOrTqEAOj28k?=
 =?us-ascii?Q?rlZvIi/y8H5XOqeNCDsGVmNfHLttuGr8zMNt6jg3Y7SyV4xYbTVJNUYsV9LX?=
 =?us-ascii?Q?nOhthpj3sOzyCQBqd0WG/NA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb3e05e-329d-4ec2-e992-08dd70443d44
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:34.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojbP0ecsnFoj/4zwCfk2gQGOYI6dkRBdBhaC6k/op1QOLQnNQ1qYec40sXgSCOGUpp+IixZONN3u4KbLcx6uZp1fbavCIei4WtvOLxrINXpeeqOnGIEEfFhZof/Sc4kc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:07:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18437

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 13dcd63dc704b33a8ad94f1d161c0f5dad243a5b upstream.

Define `RZG2L_SINGLE_PIN` at the top of the file to clarify its use for
dedicated pins for improved readability.

While at it update the comment for `RZG2L_SINGLE_PIN_PACK` macro and place
it just above the macro for clarity.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20240618174831.415583-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 5081c7d8064fa..b47f0f1257cff 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -65,6 +65,8 @@
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
 #define RZG2L_VARIABLE_CFG		BIT_ULL(62)	/* Variable cfg for port pins */
=20
+#define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
+
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
 					 PIN_CFG_PUPD | \
--=20
2.43.0


