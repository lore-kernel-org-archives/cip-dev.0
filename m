Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21991C7EE30
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:29:39 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.56])
 by mx.groups.io with SMTP id smtpd.web10.16495.1750674572018760158
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:29:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Y2qCXXYc;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.56, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUE0hTJcW5QF6ecnoxU5umv6ochsHA3IEB/h9ui4aQpgfpwScMfqF/p9szrZzRukxbM8ExL4ACrf2aVWrpwZU+cTmzArVX/sQPlMxTLRNiOb3YiwZZwbrTEfdlHGDG7nKme8nKDDYWNyWSMfa/ANxNZmypvbB5ox14VJAc3zeFAn31Ck9n4UYwYln1lPXv8FtWhX9JQ3OiQ53G7KiKZniKJGnttYbhc9bzoAi61UkeGCh2mbEs2bRQ28J3neeUPgJwxrO96xIjhapcLCin7T5kHLLRo/qyYxEZfYKp6vnF3MBz8O5TWzIFlhTE68HtZkuuMSFZB+YLr14Wr1XM8Uew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeDtqrFK9LCb3qdq2/QmJ83t6xJY+HMSLqJO64Jr1/4=;
 b=UIxnqlugNYJbD3rei8JVTM7Cc7aNMKzEN+IKF2E3pQyiB0aWIYLGdf7ejrKD+EGCN9+wCunpd+3YmX8ExaxDNZpop0oC+jBflbypK4iUWQz383vOZ35cFIQXUrqBFUJNn1uljKsVIZvjVOsVGLrJYMUCo6S8yXfHqV2UCaRHUhTnMHPCUYhKv0mKp2QbU/Y1LemXoE+3qhHj4Brwsn+Wq/23M5r2aZHHsGjcclu+0rpi3clv9xeIpMFQkCZHLeUHB3b6sYG++hy8Y11qt0y68RJdZdiJSIiLHSGuPg5buKiMEaxIpcI9exeITgOhNL9I00pmsorAu1q5+gJznsTmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeDtqrFK9LCb3qdq2/QmJ83t6xJY+HMSLqJO64Jr1/4=;
 b=Y2qCXXYcKGIBsgx5UzLPVCXqyLf5lyI8E1uJFAW9J7TURflQFIefU17DwFZDwTiyrx8ggJ/uXsEGO/6pOz/ocscErbBN8kHjU3u5sm7jHkbA2U/9iUh1+gHxRyUFTrnKwxVKqK2Uc43/2nqIRDTuQqmaSE7xa4V9RMVYMTybKnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15129.jpnprd01.prod.outlook.com (2603:1096:604:36e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 10:29:26 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:29:26 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 4/7] watchdog: Enable RZV2HWDT driver depend on ARCH_RENESAS
Date: Mon, 23 Jun 2025 12:28:53 +0200
Message-ID: <20250623102857.1493371-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15129:EE_
X-MS-Office365-Filtering-Correlation-Id: 5257494c-0a48-4256-75f4-08ddb240d458
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wIMzGH/8y71KdU06OpZtzoDNv5cSOy8OVFeAgT6DK0KmTeLAFXogAB7SyuRC?=
 =?us-ascii?Q?0tMe80ewy75Evar7XUYd0I90BEWUVVlutYNhYaH8pfATU+Ly4b46stveSU/h?=
 =?us-ascii?Q?Fs7xmbIEhTqd2ibLNgY5PyuZYl/qK4ABa88hBD07d1kYGhJXHhsPZqFHQGSP?=
 =?us-ascii?Q?uYBWKr+uKfGexqTuMRvEbYk6iMxoCuyt5q5RDMmlPnEpYGnjjAZDiHMa60x6?=
 =?us-ascii?Q?LT9z7/d4ikjfijQPIJOMFa/SXW8GiuDAoUBqJU7SSMDQhnFfK7TAKQfR57qf?=
 =?us-ascii?Q?7N8ozxVtB1w1aUbTaPMf8azPK0+uOZHHi49fqC6E7z17R5GUfnVu7ZD1Yqc4?=
 =?us-ascii?Q?MBMVIxHpgPVu0LSr5GqRkoBsC0pRWY5RVZuQE1bGf+Uz2ftrZB4NQzPcqUas?=
 =?us-ascii?Q?gHTEgHBQysy5LW82XJB+0/1tfBFPBocbvUveq727VPF0dP+3BUXt2tQ41vYq?=
 =?us-ascii?Q?6F+2oL5otOilqOcBhZWGFMs4fARwfBLZWpt5VdxPZE3hmHBPyilV9rpnWWwb?=
 =?us-ascii?Q?U95Ne9gYlqMFtG9ovW3HM/cB3cBdAWsJq3zrcG44yBdS5f04KG8pCFr0yRYC?=
 =?us-ascii?Q?SWNzoKKWBCN3845yxPkJ7ubDyuzrnTrOiizvfAZ8w+xNAV5xjq/hUA/SuOMS?=
 =?us-ascii?Q?2Xl8Rp/j4P6PVtdxMSQnqJ+WyfJ5RrGiLMLU/0X80hu77YfYI42rOkvWIvd9?=
 =?us-ascii?Q?MiNyk7p3c5UFLN/UeKFyLr91109Z4s8ljsozntG9OEtH3W+Jzp6oQwaIsY53?=
 =?us-ascii?Q?te/kelO4lmQmI+SHfvq0U8aTsp3qlBrv9FZe7EiLzN+yML1AgZmh60+43D6A?=
 =?us-ascii?Q?I35O4FHBwhrMSEWvqk0xnVRyaO99tgaf+MvnaGvCMx+5h76QB1dWunVDKpQY?=
 =?us-ascii?Q?7Lq9pixVDz57C5WIxPQ9hTzsUVvFyrgAFPfis5KBUjqMfns/KEH3CiBDpttw?=
 =?us-ascii?Q?0Q5NantdLiqT2bPy5uaZKEzVSiYakjxhbL76HbRY4QK67MRI+iRw8mBqLAB/?=
 =?us-ascii?Q?AtWvmK77U182eo3Gx7izKfY5Yd4MmMeQROCUGjjttiVAfm+60c3iCjiF973x?=
 =?us-ascii?Q?Z0nvQGsWA55/zh2FlX/jChzWt9HdJe4YScu5aP/eFIV65vtMfmWSvhbbs/aq?=
 =?us-ascii?Q?pKryrI7N6+u/bVTd1h5ImmJPzm5Yki3iWFWKmvCyAwJ4sppXpkmLjTKyFYgx?=
 =?us-ascii?Q?lHmPjwSs3U+lJCqq9B59uP+t8dpYX57iiwpq4sOpbnjCJmMrsf/t+wp2HY54?=
 =?us-ascii?Q?XP3DoZRJMEXHKRhKjehGGlSjqZqFX43WDypKL9PKCxUT6tzvqU6YCowJ9TL1?=
 =?us-ascii?Q?amJK/Uo2LN9wCq1KIZep9tnR1FfOe+D5Pqxj9i8+yTWplnJK0g5JUUrmeJzk?=
 =?us-ascii?Q?wZfsihjhOI6gZvpuLE0zW9NoDYsRWlf2j7IxQuptRoy8V11mQA9zs+zWh/wT?=
 =?us-ascii?Q?aL4JwNpOhrT1RXznrvTqaNwKYpj1KffrC8MjUJU2FZG/5gUedHYqjQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?B/iiMMPf2fFxyys7vYbe0YGp06Wudn8e35+oKxNnf7e2nvgH6F734qROnwsc?=
 =?us-ascii?Q?HV0Y+RMVEQzpdzpEWFVCjXvX/9GzyUABIvEPc8lGFwekFe+ElAml/SidWxo6?=
 =?us-ascii?Q?or2upgI8ay9rb/62s4DKjnoP6k9VCfWwh06orHcj+4N8B2qDoNtLPd6CKF8I?=
 =?us-ascii?Q?tv99AHGfmHnRE2s9v9iRy8skTexKJzwCJH203t8eEbT8GF/Jc3LfAHAzzm7O?=
 =?us-ascii?Q?KnFMIt/M+yHiMoKmDJSnpfX9P3I9YuHzsN5wJjOJcvQZr2zkqHmFfytIlAve?=
 =?us-ascii?Q?B7VRfN6LnblVBdTW5ADst7Fby5tpt1ttl/iwiPS6VGEwDghw5N7DKfa9kypW?=
 =?us-ascii?Q?I3ZnryEiPKJvIY1fP1hb97BIOoI6IUkvDtwwN5fDLnGdzgrQOAb4qSyq01Wa?=
 =?us-ascii?Q?c+xfH0Lu7ACsilRlPcAvVMefPMNHewo4Ej0ALJ7GiU+Ty2+tnepXG7Z3R6Nw?=
 =?us-ascii?Q?ddu7WKkHdTb6yUlFX16EECdxOqwHK9P4T6rLgSKsVMne/KIyxmSit3PORuSq?=
 =?us-ascii?Q?hM/U2D+tn7s3oKmkUoxeCRIa5GJgrHcfSqqLFoCNz5RdplJZ7uWXbWezR8sW?=
 =?us-ascii?Q?Rb23syTLRnyWIiCd5xkEgMJ8Dp/npYxQ2bGaZ7hv4Tw+iMPKg7wbVUTjlIxK?=
 =?us-ascii?Q?lY3JTdM/8SvicO9823j6xbtNjjNHy0RuOjpPJJaRytMYvtkMEQAvDgAEMV5l?=
 =?us-ascii?Q?W2II6x9XKVQq9wFoWK0JLeS2LtNaK7/TFofQqSprwAuzjokgz5LgwGqW+pep?=
 =?us-ascii?Q?f4G1+bKrE+OM74sJa8rBxEBoDzgNGkDSlFH8PMWrRgxem8l2pfedgn9unkNN?=
 =?us-ascii?Q?P67Az2gounHf9pI5NQadHPMjYnjjqC2L30TNOmocutgh4qMkikmgKXQMtmqO?=
 =?us-ascii?Q?juvyCcBE/rdH/q0Fy2KUYeg06xKhvIvSi9iWJ2VM+ky4+2sTvBdiemViq8s4?=
 =?us-ascii?Q?u0tG0R7NmjFwMkQS5JkuM0sm2+mKmJoRYKdd2SvHg+ttqxK0oIxfdgdp/MEz?=
 =?us-ascii?Q?kd26HUfcpMmYiQ7ogt3+BrYe8cilXWXvYTun4kWMUNwO0tNdZGCIEMDq0Pig?=
 =?us-ascii?Q?659OKTXACRMAM6CZqE3era6pqJGiHQx4IprkGmMvkTiuU09dB1CHF2f0e4js?=
 =?us-ascii?Q?5G4tfjfdQ4t8tkrjRPwxSyPb+SN5BgWPdYrIAcB9poM5WCaXAMXc4FlAkEO/?=
 =?us-ascii?Q?SHWKnRSWB6D1N8CzMCbU8/Ufe6BuxcpVSFBE28DoT4WzX9sMtmhBK2mDiHPC?=
 =?us-ascii?Q?hbn3nVDA67119aNecra0EFEwhG4I0aNrOoATHvfB+bXHcyJD3fj8ypisylyK?=
 =?us-ascii?Q?vT7WYAoGwrjgnfPuEafTqfl9ig4VGVeUWFthYsTADrQT5+RGPAZ9HBoh4zWt?=
 =?us-ascii?Q?2c6RRLZo6puXLXZxlrZKcPQHIWiM/yrK14uxa7hYHzfYre1ldWeZh5eYgRVP?=
 =?us-ascii?Q?h94qJWKk3RS/k15dvTvAOkSpKKg1DbhIc2n20c4ATyUqhFgK86sLu3ea09p2?=
 =?us-ascii?Q?P0KW3ksWJKMpbvkSNd1+5hJBou7EYV5ZsAgO5Y2NBXM4TUiCOICQ1JNqkXnF?=
 =?us-ascii?Q?t9aUIZGoSxXuOyv3VkNTdPL/QxtNrqvLlw6PROfadebPGcmP52EvyLYJ3tCn?=
 =?us-ascii?Q?onog+PCpTIZF/tISqmZSyhk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5257494c-0a48-4256-75f4-08ddb240d458
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:29:26.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9+NaPeAIS/s8cToSCfPtz3n53kg/MRkagKiG6bl742TdlJtInGv7ezAvdaZmcfKnjVKqwbibQNFjBS/C/7zwXajErzu3/BCCnFL6LATgMCvnkIi6EDtkSQXIFrCTDg/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:29:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19178

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 331c8349605c8fa2f9040c39fe8c40afe3fdc3c3 upstream.

RZ/G3E watchdog timer IP is similar to the one found on RZ/V2H. Both these
SoCs belong to the ARCH_RENESAS family. So, it makes sense to use
ARCH_RENESAS rather than ARCH_R9A09G057 to enable the RZV2HWDT driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20250126132633.31956-3-biju.das.jz@bp.renes=
as.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/watchdog/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 0b59c669c26d..bb36b3a7727e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -955,13 +955,14 @@ config RENESAS_RZG2LWDT
 	  Renesas RZ/G2L SoCs. These watchdogs can be used to reset a system.
=20
 config RENESAS_RZV2HWDT
-	tristate "Renesas RZ/V2H(P) WDT Watchdog"
-	depends on ARCH_R9A09G057 || COMPILE_TEST
+	tristate "Renesas RZ/{G3E,V2H(P)} WDT Watchdog"
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PM || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This driver adds watchdog support for the integrated watchdogs in the
-	  Renesas RZ/V2H(P) SoCs. These watchdogs can be used to reset a system.
+	  Renesas RZ/{G3E,V2H(P)} SoCs. These watchdogs can be used to reset a
+	  system.
=20
 config ASPEED_WATCHDOG
 	tristate "Aspeed BMC watchdog support"
--=20
2.43.0


