Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77106C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 09:13:24 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.146207.1783329201540207500
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 02:13:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bQDD8GQV;
 spf=pass (domain: siemens.com, ip: 40.107.130.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxOrRwej65M7EpP6LVadGS6YhxHblPWpIjCn9LgzechPF0JWsylLCYNWtOsAEzeghRBxYtAN4OmZTv5zmwNAaoPHjZ/OFrg3Zo02Z4Yw1efccmN/bgd4hzPOs3MfEMAGZPCf26LM9tfbDV1coQTH1KCbhdLE/klULDMr6bg1Ps+lzeGfRVrh5k8R3UOXP7piJ++/pxJMuJq4Z60iy8vq/rqVt0m9jA38HT/Zj/IaXv/S44mtJKiOE28rXsB8gMicnekjJtye2By3odBG8FfdWzDuvuXIEPZBEi0FyY8i+5vZh/vyOKRb6V6ueAMUV/lKbz2t6LXAWkJubFMxPET3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meW+MCU2F6hA+AasRK+I18E/tcUMSLB4CidiFX9gR4Q=;
 b=u7RwS9nYzdJ7YwSeAgu0d27t1RFdTyX98RHO5G5pPXq22IAvZjneXu+FEKAlU2YhAXzhdz+9157g1MCsWScxuUt2agITgVANAjABtzKQQuzdocorqnEHpxRTiku8P5KLQ8QC3DpMLprDvc1PaJLvv8c0H5u+EDicmmfOyOGgiTmwvSJTZNmWMwQHrIU/NJkkcZHz+IR2jioYmF3yZIErQZC9Fdbq71DSP+iTlMo655L5jPlOfasS8IlF5mWr2tJ3lz7PP8ip3tKcVy1Dkw20rf7fjEhN3+EHfQZkRIOfUD+LCWZvh0q8ht+Pxai0EEIPPMNe1KSUT74Cm6oWSUHYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meW+MCU2F6hA+AasRK+I18E/tcUMSLB4CidiFX9gR4Q=;
 b=bQDD8GQV6eHk3RY7iw8SobIoJpN56YO07iPCHAlE0AWhE0GXxPj6yhPgagH2Cth3YK3aXTOznEqEPCbd6KxIevQE8zV9yeEiF+FwVYkzPoBu1JB/hfgtqGpp/4OrEfot/3WghGDLpxY1B2COHqILNG2p1f9yHG/Kh7ox0IkaUXMNgBPSVw0lXrnpGd04q0YTZbnd4nNHZ9WtCKIKmdLNFS+KxQ1lDNofV6WGOkiT41NEjrDLyS/UMRN4rkdwaNBz3wLOK28GKAqluHTul+ChxTS9nzeRk1NVwh324QxYkUFv2hAujsRjvOKlYnfp1m0j8MCt+07VOPXv/mR/JzuDbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:325::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 09:13:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 09:13:17 +0000
Message-ID: <61336493-b07c-4330-b395-0ceb67216490@siemens.com>
Date: Mon, 6 Jul 2026 11:13:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Add support for Renesas rzt2h-evk platform
To: Hung Tran <hung.tran.jy@renesas.com>, cip-dev@lists.cip-project.org
References: <20260630085743.2655-1-hung.tran.jy@renesas.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260630085743.2655-1-hung.tran.jy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e77b3b3-6440-4e61-40b5-08dedb3ed0b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	VkYIiJAN1WfQgUdT1ofaZpo2L88uukglgUw3j1YTUupctMxeYlK0i/UTGszrKVCphU2QLVmWfmTK8u6fOW1KhI4/P6e4YgV4p44l8JNCQ8nDZwtu0qsfLQgyizW9SxJLWWk/SDYG03lH1MSKoTSyuk5UQ304m61b5NHB7PbRTC48/0TB5SroBkwyaIBXVhsrP3dYTkMh+AG8E3hE0OXl8ixZLPK9UE2MELTc/xp9645UgAmtnqLtwijuPpFgj7n7o+Ust6yDopr/rFLHwKcC3j0cLMASQ9cb8fO/Y95G16lrFJtF/LLoQCmEaYhjcJ0FOHbBE06CE9ICHi9Rp24thYgXRth8gnvR2pq51KiOQ1EQg+0oZZRckSf1syNQTedp6JSAchx9HvxbmTDBUDlvXngc8vIhcNx6tKn6XEnL8yGhSM2NEN0LcAK6+JEM0u/tfvVjcA4OapoZD2/7y+BUevLMqsOyb4biTw5M1X8Q9ubDV6dnkFNs7pVIm7qq7HEi5kWWW1SZfJLMRYEUaaOJT7ZNqHTcjIAbTcehx+CUyfCkl1DR6CR24bGR+IZ9cyeJxhoK5QfWHPxbUxKVR/aqSVlsCWsTKMOcdnRwNwhN0StBy8Kw5IduYd8wW8KotbIqfM+KaLrilHcvYj1FH2pX9XRgUkoGLcqiIRO2re/UZpM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0JVS0wzTWNuSXJKOS9UbFExQ1hlQ2lEbkZUTGtiR2dvSHVNV0hVZ01sVGto?=
 =?utf-8?B?T2NQT3Q2dThlRWR4VkVhdXhlMVV6bWdmb3llTUx0UzlYWll2cEJPK25Sb0dp?=
 =?utf-8?B?MkJkU2Q0NXZpSFFjMU5ZN0Z3Q0o1cGlLU0MyNXNMRk5xWDJZaWFGZE5XT2Rp?=
 =?utf-8?B?ZXp4NzdlY2tiL3REV0VieFJ0Qmw4bXNrVjc0NGlVbklRNm1IMFhEbTRtWFlr?=
 =?utf-8?B?T25EWTRSS3dBRmE0YVA1bnhyMzRXVUVhbjdvMFhZSTVzMGUzZkQyWmxTOHQ3?=
 =?utf-8?B?S1N4dzNreWhQQ3RXWWJBRng5VnNqTFNaR0cvMm9VK1BxanpQQXN6VXNlNStO?=
 =?utf-8?B?ekJEekcrTVlGZCtTNGdEaE5NTXVHZUhvbG5FUTVQVUJjUUhQcElhenJKcGFM?=
 =?utf-8?B?NStvS2lGSkNDWFN6R3NvZjAzZXFiTEJxTFFMRzZNK2RrU2R2RWZEdWpkMHk5?=
 =?utf-8?B?U2NLUGxPR1dtMDNZemhUM3MvcEUxc2tvOXo4cS8vbGY0a1IwZWpJMHdITE42?=
 =?utf-8?B?bjBBVGRJRjZtN1dhdFAyUElleHZYbXRRVG82QkxWOWtPZUFKQmhxcVZjZlBB?=
 =?utf-8?B?M1RXV056UVhjMFJnYmVOWlVlS0tnRy9raHR3ZUlZcFJhK3F2ZGFmWFc2VHly?=
 =?utf-8?B?VDZhQk1BY3FoRi9mOUtwN1lOV2UzYllna1M1TUFtY1RRWUkyWTBIdU1YKytq?=
 =?utf-8?B?Q1pmRFpCY1k4VTNhZXBqZ0JNQVVJU3ljZXJRL0lGUU9QUjUybUgwcGVoNFM0?=
 =?utf-8?B?MHZPT0dOTlBDMjNJN3JRNUp4VnRZWEh2T3RocjZmdjZ6ZmNGWjNVSHJxVU5o?=
 =?utf-8?B?YlAyV25kQ0dKOUhkZS9FYVhDdTZ1T3JCdkNCQXdqUTdZR3pGRVI3T3pKbHkv?=
 =?utf-8?B?WWx1Zlo2TjU2U1dYQVVIam5vNUZFck5uaFRSYnF3RGNGSXlNMWFheWU2SkJW?=
 =?utf-8?B?TVVmeVVlbENBVW4yZUIrTmtPemYrOXF5UG0xOWx5UkNUbGMrOHNZanM0SHUw?=
 =?utf-8?B?T1orNFBlRWlxa3JiR0g1eloyd3lHa0Zrb2pmdUF4MHBrQWZxQmpWWjZyUkFh?=
 =?utf-8?B?RTdHcG1kb1BiUjJiSTFHcEpKOXJHaWxXSnB6YXdMZVR2V3YyRTNubWdiMVpP?=
 =?utf-8?B?RVg5NzZvdG9wRGpRK3NxVVFzdHJzOUQ1NDc2bENDeXNvQjluc1V4TS9tWjFF?=
 =?utf-8?B?YTZSMjU5VjBneUgxRE5URW51Z2ZUQnpOMWFjUUdhVTFzWitEa28xdFVlZy9T?=
 =?utf-8?B?K2YvMVBUd0EreGJualRiMWF1eVR3SlpYUkdYSE9NZkc1UXhGd2RYekNOVUVj?=
 =?utf-8?B?aWdHOU9MdjZ4eHlsRWpyanVQLzE0cGZ5MFNwYnA5aUduK29mYWpvRnpuWkR0?=
 =?utf-8?B?ZEdrOHk1RW5nUlFkZkF2ZjlEN09uR1RCN2lrMFNXYllRWDNvQ0lZOFJaNndX?=
 =?utf-8?B?eVpRbHgvUTY1SGl4U0FkMU9COGJHenlzeUxvTG1PK1VTeFJWLzVQNjNOK0Ji?=
 =?utf-8?B?TXJkN3YyVjBHem5aL05zWkJYVWRWckJKWjNwSTJmZ1hJU3F2THN3TTBaYitW?=
 =?utf-8?B?K0x4Ry84U2F5d05lU2xWT2srUnZ6RXFadmdxK29wbHI1Q0t6c2dtemxQL2o4?=
 =?utf-8?B?VTlQTlZGOFE0d01DSUgraWVFektYZXFpTWtZQzA3Wjk5azA4TDY0TXNxSkps?=
 =?utf-8?B?bnFsMmgrOXU3UU1QSmJySlp1RTR5VWl2NmJsdndUcEZCTlIrek1DVDRhZHhL?=
 =?utf-8?B?Vk00TXhDeUdFZllUOUNVdDNHSURGK0VKbHBMVzcrRG1MT1dHRnloRTZrbjk2?=
 =?utf-8?B?em1UeUZLL1VEeTJjVldMWVJHNWFwVzZuWEVOcnFMelVjU1dDa1lZMDNyNmNi?=
 =?utf-8?B?UjdpWXN0VXhreFdlMHpvN0VvTE95emZQUmxIQlRLSE9YQXBGcDNMQVRkZWNv?=
 =?utf-8?B?N1VZektwZHdUNzJPamRoWE9TREZVMkQ3dkxlMDNYUk1EV1U5djk4R2laYVpp?=
 =?utf-8?B?dVhRMnJ2SlFNa0c4ckhHWnpzZkpkUFNrc1RKWW1OYXFSalN3aFNZSS84Wmpj?=
 =?utf-8?B?Y2ZuM0pkVG1XZEIrMHViOFVXRDd2aklJaTFjaTdaZENjWkpibllKanhDSWs5?=
 =?utf-8?B?QkhtRlZtbjNiQnJxbkVudmYzZDJabWFYaWcwa3FBUFdRUTN6T0w4Rm1CWmhC?=
 =?utf-8?B?Q3ZOYTZpdDZiUExxbC9BcU12YUd2cUxodGxyZ3NFVU9DbU5YdXBUU3J2dmt4?=
 =?utf-8?B?ay80WjRHeTZ6ZTl5SFFaOHZKMU1zL3dycWZNcS9qRGI4SWp4Y3JSNDlYenk4?=
 =?utf-8?B?WVlrN1FSa3ZEemZJclN3ZVcwWVJ6R3VGdVJZVmFGbjVyMjRwMXVOaHV3Tld6?=
 =?utf-8?Q?Nbdgcbr2vYcAHpSw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e77b3b3-6440-4e61-40b5-08dedb3ed0b0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 09:13:17.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f694lIS2/gXpQrUqXQ4YZxdYmbQzBB9JEvqQGyzfE44gxBiR63NRO5ByRXCOh2W2xGhZA45fggLuG2XrQgDFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5209
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 09:13:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23456

On 30.06.26 10:57, Hung Tran wrote:
> rzt2h-evk is the new reference platform for CIP project.
> It uses Renesas RZ/T2H SoC, based on armv8.2 architecture.
> This platform is only supported from CIP Linux 6.12.
> 
> Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
> ---
>  Kconfig                           | 14 ++++++++++----
>  conf/machine/rzt2h-evk.conf       | 18 ++++++++++++++++++
>  kas/board/rzt2h-evk.yml           | 15 +++++++++++++++
>  wic/rzt2h-evk-efibootguard.wks.in | 14 ++++++++++++++
>  wic/rzt2h-evk.wks                 | 17 +++++++++++++++++
>  5 files changed, 74 insertions(+), 4 deletions(-)
>  create mode 100644 conf/machine/rzt2h-evk.conf
>  create mode 100644 kas/board/rzt2h-evk.yml
>  create mode 100644 wic/rzt2h-evk-efibootguard.wks.in
>  create mode 100644 wic/rzt2h-evk.wks
> 
> diff --git a/Kconfig b/Kconfig
> index 44f2337..879a31d 100644
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
> @@ -144,21 +150,21 @@ choice
>  config KERNEL_4_4
>  	bool "Kernel 4.4.x-cip"
>  	depends on !ARCH_ARM64 && !ARCH_RISCV64
> -	depends on !TARGET_TI_AM62PX_SK
> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_RZT2H

Hmm, both target exclusions should actually be redundant to !ARCH_ARM64
- missed that before.

>  	depends on !DEBIAN_TRIXIE
>  
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

Thanks for adding this. I think we also want CI coverage for this.

Are there plans to enable secure boot & Co., like we have for the am62px?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

