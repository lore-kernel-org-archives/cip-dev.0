Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDB7FF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 14:42:39 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16431.1777905753693450689
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 07:42:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DQFVffGF;
 spf=pass (domain: siemens.com, ip: 40.107.130.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLO6+MvYU4QQlHu8Y/ucul0DE4kvb8hV27DczEtvx/cN+Kk4OyxHdoRFl4UEUhutVhB7UYb3cFTF3RDqpk0pXRNBUJllkdAJBSYZq7HpMOsCfaVk0gNjqgllrPX6J0D1SOv1/frtUNCRi9XO3lkzDh1WzLDSPc5t77e6KIcr9ym77AlyoNESB2DFjJALKRpszTumTl/+oogqHzeKItarPTDcxv3GD8D4m7PU5tdjJKiV1cAMLK06UkSxkzdfuIWiyXjgFYtVveDvJTETkXYjZjipcYqIJ7JzDFP1L33KZrD2+7OUUVPplzDLW4ADZddJW/dKqSJBApuDtj+BYWVtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuRFuE6GHbhn76pFeDNT7CYcK5JIvQ075iP6nUgtcLc=;
 b=d+RSFKWx24+IZ560rNjTEGBTkH1tHu/01s7xbWtYA33gRZg6NVrWHYgS91DP7GV+6YO6dJhhY/NgtOmm7Wu55m1f88razPBQj15sVIvL8laeriyXVM/TUdIN0Cm/Sm8R9FrKWcul/gE1fuiOVeL918af6ZpYP8Mv7N68P3C5l0BGkHdNEyL7sxZ1D1jRXHYkddWpurgr+6wE4XVxybrtiEkfO48pAdIfHYjLdAMXwoRvhbUE5f1TTeAsuNX9ZOdSu4r/ujTq/8x4awvPOIH9q7QXkjZ1R5Zm5h2BI9rWanbZqGv+isknp+Gt2RfESk5Eaocum++VG0Z4Meas2tBJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuRFuE6GHbhn76pFeDNT7CYcK5JIvQ075iP6nUgtcLc=;
 b=DQFVffGFqoLHXVE2jazbO+voMbkVNsceFhu3Bw3k9/b40zW3CgbPxfaIcaqdsyZhl0qBi5rSYQpZIQgb5+UwtgfbVZ/YemohXHzIq7jj5GNU+hkR8AIDy1RaEuU33vwj7dzu2csGQDf3HjCzvmitNRRIRnftZCQLHXCMtnWuw5DEaoK6LpJ7oYSihPx8pWa6WLrfj2GL2L/yK+pD7gybnqKrZRuUzWDxMua2RNcwzssdwdwN4pOGgvNrmhzBFCyyGBVsIGJWB+SUCsAstWexC1NQgVG9t8N7EbvcwdbFsXOtW7A9ce/C2GuWFFf1HPx480cqDnmeT13LlRjCWWDnbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 14:42:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 14:42:28 +0000
Message-ID: <f917b5a6-97c2-4987-9be0-a7bdaa90c688@siemens.com>
Date: Mon, 4 May 2026 16:42:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] linux-cip: Update to 5.10.254-cip72,
 6.1.170-cip55, 6.12.85-cip22
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260504104041.740846-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260504104041.740846-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a97de7-97c0-4198-7d09-08dea9eb5d40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Mo0/U05VH4eHnakGaBK9PY6SdGLIBjRTVkxRMXXpErwiT7JBQyz/g3RRH1/YWK+3vaorOARWZtos7+67p9KzuxK/sZ5Ik33r2vRsDpG1+NYv7udiebQTZV8JTtJWhZ47bVCR9p1RVpLTY3LQbiUAf65ey0GxWnSN6pP9QYhg2r11r4ANIw9obObHE1VlLlGczlgf04TWcnjLBrA/4RruTYqnABRX8WaZQz3iwI89Tym59wqGSGhzMQ6AUR1lUKA+6EowPuhACe9QEZY86fS5sxDWfPmY6mqLJzywyXkbUxvRYrDfyODNpEmgcW3/N2DwkVvI/TKvonu26isRigjNtfi3XZUG6Wo+ZZ4RBt6QDPQBeS3XK/JQUpu92LGJYCYJahhmhHVok4mkSywiwmXyPur7uBTAl3UXMihg1er2WNS1cpmZmrQDOZqNd/bTy4BYQ31VeXhl5lbmbp1ae9MiBI5G3E+1NhITS3zDJ8U84mwJBjj+XLqavERCawwyhxJOohdFiygBs4YH8YK1tsw/YvIML63KsqKSXGOgEY2zFQvHR6vsNgd+ElooR2SNidJ/PJcKEuA0qMc5nr3IxsuyQerII8LS4MsG5Dc25st6QrDZSwsRlnozacgAXS76b4EleS79waHd50OZmipA3+UNe3DFTPuZs0hBuZhYuGVefjhPpbitj3zDMDja74ikr0hy
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RWNnb2ZUWHFMNzRGeWcvczZMSkJBRFB2SVY3UlBYaVEyVHVsSDJuU0hUa2FW?=
 =?utf-8?B?cnJIdjBXVlA1VVROejlXd05DeW0zVE1wdHdRZENKRHBKRGpQRkpiMFlDVW05?=
 =?utf-8?B?RGlrcWwvak54UGF5eWRqZkhKQnBNK1QzTlpjczFEbEZNbWlsU2F3bXFsRUN0?=
 =?utf-8?B?dEppRi9UbXROQU1TZTIrRG5xS1pGM1hENWhpSHhGVHdsVmZUWkgvTVA1WFIz?=
 =?utf-8?B?TjcrV20vdEo1dXF0azdLQXBGbHBZbUY0NDZSN3k1N3dWODg5K1JUSk1nSnZ4?=
 =?utf-8?B?aEdIY3pzYi9IYm9QL3VGUVlmQ1RpSlJ4ZjY0dGtVcTJacm5ZRGRaaE10cVYw?=
 =?utf-8?B?cDJoYUFyMnErWUZIMi9wSUZ0dnhXTmQreWFQb1NCSjBESUJHSXBHVExtZ0NV?=
 =?utf-8?B?bTRnY3A0TElPSnloQkdRRzF4N0tIMGQ2YktNV1Y5bzU4Q2V4eFpWN2pmYU9G?=
 =?utf-8?B?TmZOSldOcFMwWlJHc0VTVmtZN1pIWmtIOWRRYUVEcE05ZEQ3bURtOC9rMlQ5?=
 =?utf-8?B?bHljR2hiWWlsSzRoWXJza2JRY2VQWHlDbjVjMmhXbG5IUDhORWJPZ3BxdFps?=
 =?utf-8?B?OG1seFNWYU5FLytUNDBTMDFob3d1RjNjVFAyYng5S1hTMzZoc2hJaWJBajVz?=
 =?utf-8?B?NmkwWkJKRGRRRjJlZkVKRnM0cWpmbWhjaFpvQlQzQ2tGMDRSZk5oVk5hbkVU?=
 =?utf-8?B?VjhNYm8yY0RGL29lTkkxUlhMTDdaTm9uVCtlVDRvSTZFbnI3a0l6amlLN0dt?=
 =?utf-8?B?Nk1XbjQ1U3ZtTVg5TjVObVRtK0JWaXZWSnkyNDhGa0hnekZvbExKMVpmZlFu?=
 =?utf-8?B?NVQ4SVNnVDR4OEthQWhJdWloRU4xWGZUNWRzWWRKMkxLMk9QeXJPQ2p0Zzll?=
 =?utf-8?B?V2FRUG1lNzRnWE95UURZbVo1emNxQTZaK203ZnNNOUxYelFmWGQ5QzRlVnZT?=
 =?utf-8?B?N0JiRzZYQXVRUktQUERnZDZXM1JvSnQ2WElIRFIrVUx6THFzaXlsM1hvZE5W?=
 =?utf-8?B?cDkvK3pWK1phaFBjZmppUmlyS2ZxanhPdDJ3Ri9tRUNybFBmQldSYTJ1eDk1?=
 =?utf-8?B?Y1krTithcHRvSkJyTE5CVEREY0JlN05yYlpROHY4amRPN3ZBN0JsQkF2aWdG?=
 =?utf-8?B?YlRUSThUa1E2L2lkcWQ0RXlOZVBLSThCRkdyZ25EZG1FTHRrbVFsbGpNR2pl?=
 =?utf-8?B?ZjN6NGZYc0V3OGxyME9lbDk2aXJYNWNjS3JsMVZxQjhyWmc0S2x5dWdsWU4z?=
 =?utf-8?B?ZGpnVWw5V0MzbkZCTFBPa3ZrWU5lMjA2Tk1sbmJCVlQ0OVNwMkdFdWF6Q1BE?=
 =?utf-8?B?eTBXR2tkTi9xc0JDNlFCMEd1Z0gzT3krSi9aOUsvVUtSdWxxQUYwVVArZGVC?=
 =?utf-8?B?dE1mRDNjZVVtV29jaThhdWdMdlFPV2JBYVZCVFIxcGJMS3RDM2w1WHM2LzVE?=
 =?utf-8?B?QjlhQ0Rtc21zOTJXbTRPeDZrYVZDLzVvNEo2YlZuNVIzc0tYMGxUK1FxMFR5?=
 =?utf-8?B?YVNFUzdyOGpmemZpdk83Q1J0bnBsZ0VCWHZEWXNvUStYdVAvWVhGL0VPQklZ?=
 =?utf-8?B?a2pIenQ2dUZNZEVFL2k2UnRzRk1Zc3ZjWVJYbHpvNmsySUxSUkVzd3pqYnpC?=
 =?utf-8?B?NWZIdFZPbk5YNS82a2tGVEtJQUlKV3hITHJ5a1JHRy9UQnBOTzVFbFZHSTV5?=
 =?utf-8?B?ajVGQWtaQkdpNEZZaTNHTHlsb3dZMmoyS3BGK3QxaVF4UkhuZDlRdXlza0xW?=
 =?utf-8?B?NHdLemdxb0k3dlJ4aWVTVUhBV1BheUpUbkplVS8vYlVmcnVZVEpMZkdFTyt4?=
 =?utf-8?B?bnpna2NzdUFiWEJYTlVvM3huaE16RWwrc01xbGRHNnhmZlJRdTdRL1ZMYW82?=
 =?utf-8?B?TC81dk01Qk9wcloxa2dlWFZSN0lPMkZTaVNZSGIvbExVRG1XY1lpMDdBcTBI?=
 =?utf-8?B?UHB3ak8vWWNIeXdiWll2MmtjUDlBSkZIdXgzd20vbjBTVGZPdnF4SzM4dndv?=
 =?utf-8?B?MkJnRnBVQ2ZPalhZNXBzWFZ3VE1hQTJWa0JZR1pFKzhPZ2NzTWUySC9udFZE?=
 =?utf-8?B?T2c5ODRDOTZlZWhUZTcxOEQ1R29zTlI5Qk5vU2xtT200cXZKSkF5WjE3K01H?=
 =?utf-8?B?NVZKb2JzUDFtM0VNTFAybGlwaUJuSms5WGRTMEVCZk5jeU1lWk1RTWk3U0tM?=
 =?utf-8?B?TFFPNGhnNkFMNENTR3lRcHNuNmRkbmhyZGFia1dQKzl5NkF2SGkwVmFuTnNq?=
 =?utf-8?B?Zm9hMDlZd3pNeEU5KzY5d1AzMHFEM1dmVnNWMlFGQ2dqMWJkcUVhbFVkTTlp?=
 =?utf-8?B?ckYzVng0RjNheWRaN1ZtbVNXUENCaWNMd3RVeWxIaWFET1dEM0p0dWNKdTVi?=
 =?utf-8?Q?zsDc93D8H1O0WmCE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a97de7-97c0-4198-7d09-08dea9eb5d40
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 14:42:28.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjLUT8iMesNVc8X/k6Ub5jzQiba9UOXSNq/m5JN2fTwgjS7oPPe4yD+olu2+I+PTO1t7H+jChxKDmJg9tKPwSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6863
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 14:42:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22862

On 04.05.26 12:40, Badrikesh Prusty wrote:
> Includes fixes for CVE-2026-31431.
> 
> Reference: https://security-tracker.debian.org/tracker/CVE-2026-31431
> 
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb     |  1 -
>  recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb     |  1 +
>  ...p_5.10.252-cip71.bb => linux-cip_5.10.254-cip72.bb} |  2 +-
>  recipes-kernel/linux/linux-cip_6.1.169-cip54.bb        | 10 ----------
>  recipes-kernel/linux/linux-cip_6.1.170-cip55.bb        | 10 ++++++++++
>  recipes-kernel/linux/linux-cip_6.12.83-cip21.bb        | 10 ----------
>  recipes-kernel/linux/linux-cip_6.12.85-cip22.bb        | 10 ++++++++++
>  7 files changed, 22 insertions(+), 22 deletions(-)
>  delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
>  rename recipes-kernel/linux/{linux-cip_5.10.252-cip71.bb => linux-cip_5.10.254-cip72.bb} (68%)
>  delete mode 100644 recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
>  create mode 100644 recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
>  delete mode 100644 recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
>  create mode 100644 recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb b/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
> deleted file mode 120000
> index 21dd76c..0000000
> --- a/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
> +++ /dev/null
> @@ -1 +0,0 @@
> -linux-cip_6.12.83-cip21.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
> new file mode 120000
> index 0000000..ed5ab00
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
> @@ -0,0 +1 @@
> +linux-cip_6.12.85-cip22.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_5.10.252-cip71.bb b/recipes-kernel/linux/linux-cip_5.10.254-cip72.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip_5.10.252-cip71.bb
> rename to recipes-kernel/linux/linux-cip_5.10.254-cip72.bb
> index 10ce173..b4beedc 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.252-cip71.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.254-cip72.bb
> @@ -11,4 +11,4 @@
> 
>  require linux-cip-release.inc
> 
> -SRC_URI[sha256sum] = "e98481884e1364406b217b320ba8c0bd15f534b71831ede2e505ffa95e1f946b"
> +SRC_URI[sha256sum] = "59e32e7cedd32bfc3a42e673898384f23931219911e4ca6a4215a375393944e6"
> diff --git a/recipes-kernel/linux/linux-cip_6.1.169-cip54.bb b/recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
> deleted file mode 100644
> index 9033bd6..0000000
> --- a/recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2023
> -#
> -# SPDX-License-Identifier: MIT
> -
> -require linux-cip-release.inc
> -
> -SRC_URI[sha256sum] = "795cab37cff6fda51255915b419c83481d98624aac9ebbdf63b60da65f5489fa"
> diff --git a/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb b/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
> new file mode 100644
> index 0000000..a339926
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
> @@ -0,0 +1,10 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require linux-cip-release.inc
> +
> +SRC_URI[sha256sum] = "2b0b200234b03aea3ed77de553935512ad42b25ee260e00745b0729ed892cf63"
> diff --git a/recipes-kernel/linux/linux-cip_6.12.83-cip21.bb b/recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
> deleted file mode 100644
> index 9f1e5a0..0000000
> --- a/recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2025
> -#
> -# SPDX-License-Identifier: MIT
> -
> -require linux-cip-release.inc
> -
> -SRC_URI[sha256sum] = "e72ddfe5db1a6514bc564f54cc41503a1ba16e651c1f535f25b93eecde2d5f19"
> diff --git a/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
> new file mode 100644
> index 0000000..fecdba2
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
> @@ -0,0 +1,10 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require linux-cip-release.inc
> +
> +SRC_URI[sha256sum] = "b99c97c032e3516475e90853a3075274cdc64000699fb5425fcff39c3b998b93"
> --
> 2.39.5
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

