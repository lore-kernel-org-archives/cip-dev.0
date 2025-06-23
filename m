Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14752C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:29:39 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.57])
 by mx.groups.io with SMTP id smtpd.web11.16583.1750674577406799873
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:29:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aJ5XrhLE;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOi0IYvCw74HDRssCN38Vfuv5GKU/Xq2NgDSwZ6ojdG1zbVnS1BTyHQEZYNmqLkfTWW2Jan/eUwa/uAdgNYkbpBDyc07XH3hHFbOQW4dOwlebpb9NukqWP996pHetOlmq/kNJm58OFl15iBU01vwRO+VEqsKTpThrvmAy85ikUrNwbDNg8w8i0Bt5PqEKvneorba7qV4kzmmb3mgCwt9jiyCqdcAsFtYPazu/baxPoM36BZsl+NOj14AL0wjBRSvhQMnU+aDij7xoraZGeP4SacSrP31YtlGCfi8Poe/NW20eLomMSWFsRvN44RFBFQvbdwIpSq3k6FgFSEQdC+yKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVVdIXjp/89rPIvwcHF/zv/VrBP5l+jr4Gy4m7lFbxE=;
 b=QqrOwrfHIZyvKpcI2NQ578z/C+A/M1nXJ6xRrV0LWrwt/Y5rS+q0aRxtiQd5WRS47pm/KQzEnpjRLkBdiLPjiChw/6alOYJJ1H/IGVTnCJWaiuBlc8uKR6KuPEQmx4yQ9GvXyWNjtFIkih6BLpm8Nra6fNtFheRo+Onv4XJXO1K3qAXrxcmEccmQROG8jN4gRq2f1JKmeg10BlbwFNJDwx6IqmImjXE31RmNemFeJ3uVsC+rV6er4SxXE94PFZSD/BpHLBzSR43adqadlha2q7X+BvKJY8A5cUHQOhqLjQl2Ho/cm77vwxeLi4gfb9RO2x1ZFW3zbYTC/jSQwPjnfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVVdIXjp/89rPIvwcHF/zv/VrBP5l+jr4Gy4m7lFbxE=;
 b=aJ5XrhLEji4NfaDvMmoEFHdpCSHivktU2HC6iPJ2Dsi98wz2lE8tkK6eOcxUWJFEaFx5fgFSpw/7RyM2Mg4EPSnH1cSxDylQ/UDve/7WCFS/d8nFLsuIH4frMa5QadASX92qFUulw8qnqgqDy8s8lhAewv2C0Fw3d7rsywr38rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15129.jpnprd01.prod.outlook.com (2603:1096:604:36e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 10:29:35 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:29:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 7/7] arm64: defconfig: Enable Renesas RZ/V2H(P) Watchdog driver
Date: Mon, 23 Jun 2025 12:28:56 +0200
Message-ID: <20250623102857.1493371-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: ce00077a-4b05-42a6-c94b-08ddb240d97d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qTi+ouSgyMILmdyLabtHpbkOIzbMe3KWQm9vcbjDkXRkzsCkPg4xKQgj/+g2?=
 =?us-ascii?Q?jmglcTP6MOfkIi72OrV0+40xns+M0Z4BkfRCC4DmSQeCrkJrAujvrGvGM+Bk?=
 =?us-ascii?Q?tkhU+ffRXGOhgu5lsZrG99ffI2mofjEKskMJSYAzYhgKfvekOzZL35W3QDW1?=
 =?us-ascii?Q?dZc8dBcudz4Nwv3lu+7z/4wDR3lrAQCxodh8IuYzXiXHXh75aMFKXlEuOF8w?=
 =?us-ascii?Q?HlYwrkwAi4pJDnuyNtJNVXRz+iVQxpVYqxKyh0kKnjEZuj75roPH3nV0AMOY?=
 =?us-ascii?Q?QkKJv8Q9KJcLet4+Npu9VJo2f6AuvX+sZtTUwZ7lm7an8/vqOsvEgVBO6w6K?=
 =?us-ascii?Q?ki+Ja0LoqUUmul2Xqdiq1XT1cPruYYi/TP/LJaRcii35HQLD+XQAJFMKHK4C?=
 =?us-ascii?Q?cUF2g3EBRQZtlukgWaJzb7nrpyuAccmIxUHRp1JnO1h+bswakSXuad98hHF2?=
 =?us-ascii?Q?taG3AZMXTWD2AEksNf7HSvQe2OTr2f3zG0kJFToyJZ1oIu1CVKjEX2htnzAC?=
 =?us-ascii?Q?eF+oWoHZ3IzKLnYqfwQ/Kz2EdOPzpSIpPzgL4EDRnoe14E9uz7SNP+59Dt2R?=
 =?us-ascii?Q?UVgClE0nDyOT6SD+EgoKCUxYTdMn8EoadSXNfgJS9ObWRyaWE3pg5iAYh/TP?=
 =?us-ascii?Q?aG/QEelJMlfJIlZh4Wjp13Tlzgg+XJvzKm7ANYL5pKGgID6xYHFYsUwUT9wF?=
 =?us-ascii?Q?SrC7H4yTZ1IaZoyAUQT5+Z5wjN0DoGMpoB9mllhkJkSB6SLr9g8GHEsvaSD0?=
 =?us-ascii?Q?sung7jIm9AM7jugIExKIdTYox93OloRD71YYZuFjPG9SJneh2HtGLs+RqUYg?=
 =?us-ascii?Q?ceGNaI3851B1eTUuNcEv6LqoDwHuTwVTNJtBXKrc5aR+HMts7m9gJNeCX5HQ?=
 =?us-ascii?Q?ieaHI8UODgyc58KnZFHtfdEsJH7GPq6JhoJWQHYShHFKQh4s0KWLHj6pfgfc?=
 =?us-ascii?Q?zR+8aMzAleD5O8O6mnJerIhi6bnDm4gv5jd/zb4Yvad2qLBeyxKIWIw7q4CI?=
 =?us-ascii?Q?IhMYULvVAe7eEq1aWc6/SYhZDIjY02Aj8D4kfdq1XXlycSd7aSIgWQMrtRAT?=
 =?us-ascii?Q?lPp9PXX/tZgKRTU/U3UOPKl3Os/tpLMKW0k3ct9o1ViuOgRfLGyR7e0OYsti?=
 =?us-ascii?Q?TR906G7I84SwXEXVd57P87U8wZhaiECJ2qv86hNAIuGXzkGP+7vVPUHn1dCb?=
 =?us-ascii?Q?RjI59GG+7NL0By4IPartijJmgLI/jP4cdV6OfmDjxBlhqA4Oz7TD0H0fnoTZ?=
 =?us-ascii?Q?BiybPlYmaJpAj+ncjZgMTVAgyQbyXbid0ACu6Hx5ysuXi6IFsex9k8/OvGAs?=
 =?us-ascii?Q?686EcWttIJWUZFbO7atUGzEHFypToWJSW+sF7mZs9ohYKICmgTCrqg8foy2k?=
 =?us-ascii?Q?futtDVmteFnbRFcWcpp+2bpj2zXBxJjibk2XXtBrdH/a0NAIFcWT5OWX1qcF?=
 =?us-ascii?Q?qW/cuW04+E+3O6Q4tOuUpWFxJvhfnxyM8AKZT7gZPEXXRcQpx68D7AOONxj1?=
 =?us-ascii?Q?2/0b0+yKg9jTc+Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uyry/GcDgmxIwfx7EXXgcqlp0Lu5AyXz+AwD1mz/DaEahXG6TbVhbkQp+Cqd?=
 =?us-ascii?Q?eJPjymE6SIHGcZZrD9K5H6db6mmr5k0bVoEjBoEU6budivqU4XrhZBEo2HjX?=
 =?us-ascii?Q?YHu9JbMXA2EfBVjOsvPyED8SNOWCOPTEWGoWKihrW291fLBK2OmRYqKl4pYm?=
 =?us-ascii?Q?3Nid+TRFzdfITR4bf4gaqaEAgDO4zZv7IIcdtb3zZgCls9oMNyXOqJok9kXd?=
 =?us-ascii?Q?lRUem8E2gyyFojsWW5KfWCy5URfbb+TGBWGP0HlvUjk0xNu82l70lxf9DrhO?=
 =?us-ascii?Q?OK6L0IerggeUGrL8aaBQJSvvtN1Q+UApHCavlRJ/TDMTDRVF9bJNB58SGdJ1?=
 =?us-ascii?Q?xTYeZvPy4pRtYIFpNTtpLRiBuuYCdkpbMV4T6lQ1ZkEL03u3jdngWJgZp28Y?=
 =?us-ascii?Q?zSxwgIoxgd2wfjDBoMjRmfDVdjAvaQPzGTtQI8OhxxKuJeBhtfDPH8jNK/c/?=
 =?us-ascii?Q?5T63N+J0L2C2F8SDLTgzp11dypM1Yu32EPwmnvtDGUfuyfpR5+JbqFj47F+p?=
 =?us-ascii?Q?6+JAAPCAz22Xtmf2nHnNcVeDrcAcFn77TKE3oLrwHpj/VBnzfAshK4NADFYp?=
 =?us-ascii?Q?MjEReE9SDqIOqzQWPovxbvGpCOBLDTqcyr+6cXq73PcWGEhtGJAd3KF1jhZV?=
 =?us-ascii?Q?H4xEk47y9FZyY6BGrMM6GPcmNyiHxAIe05f6D2FrOy2yPciKKgMqONEuqRUf?=
 =?us-ascii?Q?PqU2ZGAQw9sFtkUTV2/pp4X/g4Qp/MRc4SSKYKu6zatIwyzmItYn5jbBWShz?=
 =?us-ascii?Q?V939teLCAuRg4hQl5YIo4696I6FAMSHN+s48pt4SMqaS3T502qd7U1SuqiJ1?=
 =?us-ascii?Q?VfSk9V7n5ZVzI2Wi1/SaSm4/BUTb57Llcvz5tprPUxXIgUsh8YY7kHASvu+J?=
 =?us-ascii?Q?tfqt5eKtIBhNHO7nFgmoCS+q4P9mjr033f/INzqSp6gokKEsLaA88rX4QxdB?=
 =?us-ascii?Q?j9M6tLeXaxn6TfCuTkeklVgJLOiCDImAD4pqxQmfuUzSJj0Ym99pXpvpEHsD?=
 =?us-ascii?Q?9GCBz1/sJ7jkUX2FovOTS3ewhKnrhWrtfqN4ypnhiJt8JlFS8LUpRPMlD6fV?=
 =?us-ascii?Q?eFrLt+IatMmYuhwBy0N+UFpfFPRZh+GpfDlvkqOPY4Yi/gkWCr5b80QSpieW?=
 =?us-ascii?Q?JG+Wu69gaqIapa9Cl3MKmr9fP9P9eUPJkqTzK/U9eTpuF3T9QWr1mi0/rV4W?=
 =?us-ascii?Q?Z6wPTj/Oa9qUQlX7/Ym1ez2waA+Nlf/kmAE8GYhVQ3c/JYg0Y7PX53iq6tt9?=
 =?us-ascii?Q?KaVS8XYQxyDypDRn7lIpRIr1UeDMU8H58TtyyKB5YWDt1uFYF3pjX8QHdUcH?=
 =?us-ascii?Q?EY8FZSmgBezhSn244434WUTa4oOBl/M+Hhpl/6VHRoUShudQ6uRMHqcMTnbq?=
 =?us-ascii?Q?40vkdx6HoXsxUKMyhMAEntsFLc8QL+bf3GjRDGwHLkUAJpO00lxTlnJBYRmu?=
 =?us-ascii?Q?6l/uOBp2gIUJFmHjL1/bK3QIxejlZQ4m/XCDLaJ09b/rRVLgtpfXlnzAapTT?=
 =?us-ascii?Q?6ewcOk98Ch+Vl/DDauIzbluArrNxkFnnfB4hwtT7ChODjV/yaiqhqHynqCJS?=
 =?us-ascii?Q?jRjLR1OQCjMVwvSuMVaISEIcYUw/G/hFwDRQp8HzNsSlyynEFo9oAchgyIPW?=
 =?us-ascii?Q?ZJmnrOFhnJ7U4FgVHVQdeMI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce00077a-4b05-42a6-c94b-08ddb240d97d
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:29:35.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AccRBZ0T+X2POhIhj/xq+jyJGiNc5OchVdc8rF8bDqMWCZr+rV40KytUtvXZHqgbzl1tTfSLudrz5cAy1MAngTRCa7fNbE1ztwKwdVA/LCzOYfoOy9TgEyVfeXsqbII
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:29:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19181

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5ad0a0c7917dc434ee28da765186dabc81172e3c upstream.

Enable the watchdog driver for the Renesas RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241112093412.20093-1-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4eddb85c1211..5f3d7acedad4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -736,6 +736,7 @@ CONFIG_MESON_WATCHDOG=3Dm
 CONFIG_ARM_SMC_WATCHDOG=3Dy
 CONFIG_RENESAS_WDT=3Dy
 CONFIG_RENESAS_RZG2LWDT=3Dy
+CONFIG_RENESAS_RZV2HWDT=3Dy
 CONFIG_UNIPHIER_WATCHDOG=3Dy
 CONFIG_PM8916_WATCHDOG=3Dm
 CONFIG_BCM2835_WDT=3Dy
--=20
2.43.0


