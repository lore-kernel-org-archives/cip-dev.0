Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED011C43458
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 05:40:03 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6381.1784180396242024579
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 22:39:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UfmkVkeJ;
 spf=pass (domain: siemens.com, ip: 52.101.72.4, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4dcXwOeyB/andVHnc/geSu41pLegAOaGgG3rOgyNgEyA2sGYs5h8g8MJhaK1BIXtWH6xM/udNOckkAYDnvX6YwPd6u6uKxli4BqFGinHup+DFRbIjnMTmOwizkVwaqo0hd82FlqGAbHGMu845ewHlkB9nUnc6cxWyiw0QDOq//AFO0Tdv42MD/J39ja7M3ZLAA3AqbQrdj3jHW3kzTsYu+0pH9alhtyQECzsrMLpFaBIbL9qsGvakIA4rBG2JNB+D4rGAXpBUTQp5h4MnPXboXEOaIk40fqE8DJL/ZJ9wCH966VCYtZUVPWdT99Zki16h+m8s3E2JnDYbaANvw5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7ZGkpSx2gkU6tarPZKHLF7Vp/RL5Ekx5e1i7YPyNbs=;
 b=V3I8DjcwZp47g8anfihDADLINtl+uBTgZtuZPGg71lRAYZvOoEDMIm10jbqsbu2yurG9Ain2SJQnpm7EP4jy12EQj2Fch2OuAHH9TaJRw8+l8FxZjHFzE6GHyZzNhZzw5IHiXCiaZpPmAO4SKNOo0jbq6uhJaC6ezNrnyKck9XBVc2IvxK72+uXg7Xkm9YkZNesYF2UgdCj+tTDfqGrFYrOsBgea1mPw4C8kNfHjaYOhBrSFKyqJTMEyLO8blbj6QYnYKLkJ3vAqe+QyV3ZvPwQgGy1JGg2D1AJi8dncBT47x0/7r9KnzKq6qs6mpVmXVlqqlTL45TSn075KuB6aag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7ZGkpSx2gkU6tarPZKHLF7Vp/RL5Ekx5e1i7YPyNbs=;
 b=UfmkVkeJQ+s4xPBtywbO53t1ptPyj+WCkPhtvxlt8QqCpO/u01Rt0qM2v4CasDHM8EA9MBIlv26P27NmVEysQDB5Jz2MFl1Jd9SQ2XVmUnNQZcWV25Y0krI2Ia2YwUqbCNW4URg/42qdidYL7qIej2XW1BEm0QwBdzI7ETVDdlWhyL8j8s5Tn/uLXku3ibRPERD+gFocmdPFMLBztAAUukQjI3qoScTiP80Jks5/AAZrbEy4fO2xFPWKs5d1kA7v1neyAEzrGUd/vx4EOB4GnVHf60I6QX8pJRTEQZ3sOA36/aESoZ2YujHCirTPD+SFnKoOEvQNRVYVUdjfH2oWPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 05:39:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 05:39:49 +0000
Message-ID: <33be2298-1de8-4eae-b3c1-92f431a9575d@siemens.com>
Date: Thu, 16 Jul 2026 07:39:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] Add support for Renesas rzt2h-evk
 platform
To: Hung Tran <hung.tran.jy@renesas.com>, cip-dev@lists.cip-project.org
References: <20260715115810.2379-1-hung.tran.jy@renesas.com>
 <20260715115810.2379-2-hung.tran.jy@renesas.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260715115810.2379-2-hung.tran.jy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbe1e72-78bc-4a04-87fe-08dee2fca6ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|55112099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	sGVDPm4AVEwf3FOEe15MhxyDRc9CHwvxKBc+6Fqvs/XrIeqV9dD7ROumuYGZv5KIhPSikMJ6jgDVDA1TH1oFQlHWzyVU4ygWJUwv4DAGUXwBhucqjCtGpjREeJJHYgWM46DJKhcZ/GUNLehcGHkhPjy52zaRG8Rj711s64VeS0rqG/3GhPO4WvCJqg6GBTjYBPEdgdY1PPq5nb084phI6JKUSPw72mZ3IE2MjCAHNWQjzfYOGUaheV0IxM537AYeqfrYXZCHG0P1M2qNnSPjKX1tCzfjfHDZD7qLK7f/lf/gZS3msczb/BRsmIDdwXzbgjpklKgOQR8EAuEBQAARrg3+YAmaoBIQPG6rZLONHiEXMx7Lm+gIC6pYNNilRVQe+QQJxgzLf1h1rYTVGpnsvaJNLLmZgA25DvlfcX6Ehcn5cWRc2HyYwXS2k9sw5B9qgHpM30icw+NHTwuGWBAak9wW7Zl1HginPDxYIiB3f3oni1380wpg6IIC+c1I/fK2a6Jq9yRMgKEKiU9nULEV425z0vYS3b35rj2XjxjUDytNLD0PX8ewEdEIGwpd7p5jeqqRVdr5MiN+QKxKzKwDwCdR8ThkqeXh39vMQBYthp+zsJZanvhuT/FpzTtedjTPo2Hapa+lGgIQ/nNEmhWFeOiMZdj2P1OdMX+81+8GKAU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(55112099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NjBxNGF0ZDE5eGl6bE1sZm9oUGJuQVpBV0hnV3AwYTkvSmJTUS8vLzRTbUQy?=
 =?utf-8?B?bUNaVkxaWnhBWjI3bWFKbG1aNk52alBRUFZsUGFjL0FjQm5rSFJPY2ZmeFFI?=
 =?utf-8?B?ZjlFZlBXd1JSTUhIaUUrSHdVYm1MVmxwU1hwREFhYytia2VWVytEUHY3cW8w?=
 =?utf-8?B?L0NSNmFpbExCaStubnhVcGZLcnNjWDZ3WHNYSGU3UGpJR0NKd2tjN2F1MWps?=
 =?utf-8?B?S0lreGdQTlNnVnFHODlSaWNYWnB0Q3lHTWxWczFwaW1tNmNOcHpxQzFZQU9D?=
 =?utf-8?B?a2pCVXhmdzd5bGpia3EzNHBscXRiZGhrM3liYzNJVDgwNjBQOTZta29pMmM2?=
 =?utf-8?B?dmN3UzFjNWdDY2R4cFJzbm1UazF5Mmw0ekxOUFdaYVdsS2phQWlkQVZLM3U2?=
 =?utf-8?B?OGh5V3ZTdTRGZWJMNFd6VGZWcWdsblo2TUluQW9wTXgyVGlBUS9wQzNhbWxY?=
 =?utf-8?B?SG0zWkx3eGxxL24vcW9XRis5RVRHUDdKSThocEo4b1U5UFdHMFh4VDdOQmZn?=
 =?utf-8?B?RmU2aFdRdU9tVy9GRkxGcHI5TmFWNEU2cnB3K2VPQXdKT0NkZWZwSGsvTG1v?=
 =?utf-8?B?R0htZ0xPbGFEK2VCbkhRaC8wRTAySW1SdVZ6U0VmTjhweFBrWXBWdEp2b1Ux?=
 =?utf-8?B?VktNMjAxODZEcHJXZlVjbGwvQVhWL0htMzlnSjhVSTF0TEhXZTVmd1B6SXJm?=
 =?utf-8?B?Q01lM2F2UkNScVF4L2N1Q2tsY01DMWtQRnJabFJHc1NCZlRISjdmdi9rZzJz?=
 =?utf-8?B?TWVmMWlPN2NvRnNRbmtralh4UnRuYmNPRXN4bjFBcUlCWmU1T0NhM0l5c1pB?=
 =?utf-8?B?elVnZGtWSHpKUXljeUZ1T3UxbjZxRlh6L2NtN053bmlSVGtXSU9OR0lCNmtt?=
 =?utf-8?B?ODFVU3M5NEYwZEJINS8yWmRYOElXdjhtUVlad0ZoY2dHMzh5d3c4UGxpbUR5?=
 =?utf-8?B?NlcwODltWGc5VGJOSXZQSi9pVzhPVWx4VGVaYk5LTlJwdEVycWR6NEdxRzRa?=
 =?utf-8?B?eXUzM0tob2hELzVKcXh4aC85czZZRSsyZUVha2JvbjZWVC9uZjhiSWxtQVFn?=
 =?utf-8?B?THZtVHg0Ulc1NTBiSUF2NzRhOG5ybnNzM1NGcnpPMHQ1SjZmQ2hMakdTRkxF?=
 =?utf-8?B?RVpIZlZDOTFmTUlxcGhhZzlvYUcyS0hUQzZVZUJZeUszYkx6R0txMERBL0RB?=
 =?utf-8?B?bjhBeHhXODlTWm9JVVZXamJ1SlMrOURCVm5RZWJWOUZyemcwcjlwYUZ3aFVS?=
 =?utf-8?B?R3pzbkxveE1WSWZERDYveFdtVy96M0RPbE5vQkE0MU0vVEMyYWkrT0ppSFky?=
 =?utf-8?B?NEsyNTlCSGkrTC9sRXg3RVpxTFhFdHhvdVF1RDgxa1ZxTHVtZjY4T0w0c080?=
 =?utf-8?B?SEhialhITTdJRDRZVXREYnA5ZGw1dWYwRkxqbU1Lak8yRSt1V1puNlBXMTl1?=
 =?utf-8?B?eXhLYlJRSmg5SzhtbDloR2FBUExjakM1ckhWeExRNUZzNnFDT1hTbllLTnJD?=
 =?utf-8?B?bFBNUWFRams5OHltY0FuN0JtMFFTcW9QSG9pZGoyeGsrTEpsT0pYdXg2a29a?=
 =?utf-8?B?bFlsaU13Rzh5ME1aVnZNL2RvMS9CbWJWVnVaektzVEg2dDZnOVV5NUJ5Zytq?=
 =?utf-8?B?Ky9ENS9sa3k4WlFCUHBzTkRWWHE1WDEvSUNHWEhqOTliR0lsRldUQVpOUTdC?=
 =?utf-8?B?RVF2bXhLay9KWFliVTBva2pCT3JUQWM2ZHh3OWVEaHJaTUl2OGdHUWpTUFBr?=
 =?utf-8?B?dVRMVkgxZHZwV3hPWjc1RFRKampCbUtMZU40bWlKQkM1aG40WWhSdk1PVzhT?=
 =?utf-8?B?M1ZhdzJwbUU4SmluT1hON2xzUkdOcnl6WncxQkhZbDZXdTFaY0ZlZnlXYlFu?=
 =?utf-8?B?dkpoUTVRODhNZXJXMHZhSUpYTGlxOVF0S1hZcm52YnVQOEhDTkRTNU5ZRllr?=
 =?utf-8?B?NDVjRzlwQXl4MDhWUE1NVkdCajFIQkZmVWdPbUo4R1hJaTg4Yy9vdmR4R01y?=
 =?utf-8?B?dzJ3WSs5WllKUkIvelgyQUYzRDI4Q0JSS3pFVzNyVzk5SWFLcWFzaytodG1T?=
 =?utf-8?B?K21yQWlNbHd3Y25MZnhWd0FRODA4TDY0RUJvQm9ESHZJdGZ4dVFKS0thZmFw?=
 =?utf-8?B?R2F0RDJEaUJ2dlRzc3p4SGpDd1locGZHZG1pRXdla2dOSllpN3psekhYSFhF?=
 =?utf-8?B?UjhtTEtjVU5ZT1d5aFo2YmlTQ09tdmtRd0VqY3lOVUwrYVhJbVNtemRNRHMv?=
 =?utf-8?B?ZXRqcm5MWStNaHJBUHZnYkxXbitEeXljTXk5VnNUNHQ0ZjdCYXV0UlY2aE5W?=
 =?utf-8?B?YlNkWW01OVRiaytTQzF1cFZBME1FZDNBeFYyaDFFZCtCK3prVGhPdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbe1e72-78bc-4a04-87fe-08dee2fca6ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:39:49.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8bHDo8mEFr0s44tt86B8/QBC/Yo2FaVJ6nT7XSB3X68uhrVVxooEfHS5czf3LUjj9pk02TXeomAUaUQG18H0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5834
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 05:40:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23604

On 15.07.26 13:58, Hung Tran wrote:
> rzt2h-evk is the new reference platform for CIP project.
> It uses Renesas RZ/T2H SoC, based on armv8.2 architecture.
> This platform is only supported from CIP Linux 6.12.
> 
> Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
> ---
>  Kconfig                           | 12 +++++++++---
>  conf/machine/rzt2h-evk.conf       | 18 ++++++++++++++++++
>  kas/board/rzt2h-evk.yml           | 15 +++++++++++++++
>  wic/rzt2h-evk-efibootguard.wks.in | 14 ++++++++++++++
>  wic/rzt2h-evk.wks                 | 17 +++++++++++++++++
>  5 files changed, 73 insertions(+), 3 deletions(-)
>  create mode 100644 conf/machine/rzt2h-evk.conf
>  create mode 100644 kas/board/rzt2h-evk.yml
>  create mode 100644 wic/rzt2h-evk-efibootguard.wks.in
>  create mode 100644 wic/rzt2h-evk.wks
> 
> diff --git a/Kconfig b/Kconfig
> index 44f2337..78a91d0 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -119,6 +119,11 @@ config TARGET_BEAGLEV_FIRE
>  	select ARCH_RISCV64
>  	select HAS_SWUPDATE
>  
> +config TARGET_RZT2H
> +	bool "RZ/T2H EVK"
> +	select ARCH_ARM64
> +	select HAS_SWUPDATE
> +
>  endchoice
>  
>  config KAS_INCLUDE_BOARD
> @@ -134,6 +139,7 @@ config KAS_INCLUDE_BOARD
>  	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>  	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
>  	default "kas/board/beaglev-fire.yml" if TARGET_BEAGLEV_FIRE
> +	default "kas/board/rzt2h-evk.yml" if TARGET_RZT2H
>  
>  comment "Kernel options"
>  
> @@ -150,15 +156,15 @@ config KERNEL_4_4
>  config KERNEL_4_19
>  	bool "Kernel 4.19.x-cip"
>  	depends on !ARCH_RISCV64
> -	depends on !TARGET_TI_AM62PX_SK
> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_RZT2H
>  
>  config KERNEL_5_10
>  	bool "Kernel 5.10.x-cip"
> -	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE && !TARGET_RZT2H
>  
>  config KERNEL_6_1
>  	bool "Kernel 6.1.x-cip"
> -	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE && !TARGET_RZT2H
>  
>  config KERNEL_6_12
>  	bool "Kernel 6.12.x-cip"
> diff --git a/conf/machine/rzt2h-evk.conf b/conf/machine/rzt2h-evk.conf
> new file mode 100644
> index 0000000..5cfbfa5
> --- /dev/null
> +++ b/conf/machine/rzt2h-evk.conf
> @@ -0,0 +1,18 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) 2026 Renesas Electronics Corporation
> +#
> +# Authors:
> +#  Hung Tran <hung.tran.jy@renesas.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "arm64"
> +
> +IMAGE_FSTYPES ?= "wic"
> +
> +USE_CIP_KERNEL_CONFIG = "1"
> +DTB_FILES = "r9a09g077m44-rzt2h-evk.dtb"
> +IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
> diff --git a/kas/board/rzt2h-evk.yml b/kas/board/rzt2h-evk.yml
> new file mode 100644
> index 0000000..90261dc
> --- /dev/null
> +++ b/kas/board/rzt2h-evk.yml
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) 2026 Renesas Electronics Corporation
> +#
> +# Authors:
> +#  Hung Tran <hung.tran.jy@renesas.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +machine: rzt2h-evk
> diff --git a/wic/rzt2h-evk-efibootguard.wks.in b/wic/rzt2h-evk-efibootguard.wks.in
> new file mode 100644
> index 0000000..ca18bec
> --- /dev/null
> +++ b/wic/rzt2h-evk-efibootguard.wks.in
> @@ -0,0 +1,14 @@
> +# Copyright (c) 2026 Renesas Electronics Corporation
> +#
> +# SPDX-License-Identifier: MIT
> +
> +include ebg-sysparts.inc
> +
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
> +
> +# var and optional home are extra partitions
> +${WIC_HOME_PARTITION}
> +${WIC_VAR_PARTITION}
> +
> +bootloader --ptable gpt
> diff --git a/wic/rzt2h-evk.wks b/wic/rzt2h-evk.wks
> new file mode 100644
> index 0000000..4a4af6c
> --- /dev/null
> +++ b/wic/rzt2h-evk.wks
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) 2026 Renesas Electronics Corporation
> +#
> +# Authors:
> +#  Hung Tran <hung.tran.jy@renesas.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba --use-uuid
> +
> +# Rootfs partition
> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --use-uuid
> +
> +bootloader --ptable gpt

Looks good.

Is using the built image on a reference board straightforward, basically
self-explaining, or do we need a docs/boards README for it?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

