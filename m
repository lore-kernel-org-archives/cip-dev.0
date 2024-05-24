Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8465DC25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 20:26:11 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.50])
 by mx.groups.io with SMTP id smtpd.web11.4947.1716582363745315142
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 May 2024 13:26:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xgyysw5k;
 spf=pass (domain: siemens.com, ip: 40.107.8.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb5kVv6y7flEv2Xpkn2UDOJjC7kltpRA6bA6v6zMBIbMkaCcsCL0zL8ybvSeswMiLhhn9VGtisTtiXjLwzoZnRczshtRsKpCXFnu3AmvUb5uSLQl0dGQTcVmGG2ZRzSZNi5yC0mF2YkBm9uAOXGo96TbP4AhlpwOebjHgEELZykoiOlgXnhBo3fk0wUjSODGpntmCL9DCM/7vS7cK+sa5qflU86mv5e4X8ykEiss7PQZt9lryNWU0B2G5v1L05ff6E6BhSGMl/TETjNkmpmKQcYqQqT8ac7AtPOSZHkzdn+4Kah+mjLcL3nwqP84OQi4W9An1FbqPRjIHuYJ+dbT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE9znrpzgeXXaaJkgwAt1bkItvjv6XWPbrLXmKXJXuA=;
 b=KIivUUFxTVDZJI6UfSR6/3oR5/yhot4JSQiWEPLUqh2mbpOsIzyUqN+uZVh4uIpVGRbEXmG5/hhvZtKxJPDUGJ7GYoqqBELugQPn/OA2Cg0WaBFNCTE+uGyknU7hYUKV7QbenC9ybZgg9T4Gsz8tX3BO1KebQO6F1tR50gSLUG8YlGu1bamK2eYr0RdQ9ye75AO/xKAKA/fKJcJsoOoixFM0OCvkHBkeTljNEFeptbS5QTzcZ0jWhJOa+0FjEvw88nF0gWC80KYGbEPTUEWrpz6orz4UXmYLChIDom3CcH/Gq/fqhh1fUHcVL9ZA3kDcaNMz/E8sJ4AIggLLvuO0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE9znrpzgeXXaaJkgwAt1bkItvjv6XWPbrLXmKXJXuA=;
 b=xgyysw5kemBRmoqNxJw+xjNkDlR7L2tMmWQH42rildZP6BvG9+WA4UgoCYYy+5I00OY752U8camDaS9VZkWZ9QR6IAgrm7DDI7QHpKe+nvDXj0C4v7cr933gICf1kV4K9c/vVMwtlVQpAUtB4Zgi2xdtGYmlvKjYpwBK24nQheKDbVZb08LgOaqPid0eDFb8/vVBKiMeSyAN2JVVH8UkXzAM0NE+0ePl/tL33c+4XZ+cb8/Lrm6o4pwezy+mFDY8fHeEDEIji4N45FedWj/Ha9LOit8VNu/lPmt5ZhVAlt6asMs/dXNQO4ErwLRwmRwMetJkJ7yVybnwJkhCPON7lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7499.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 24 May
 2024 20:25:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 20:25:58 +0000
Message-ID: <fb9a3c40-cf83-478a-aa5c-6c53ea5c8ec4@siemens.com>
Date: Fri, 24 May 2024 22:25:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/2] linux-cip: Switch x86 targets to new
 cip_merged_defconfig
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <be7c406d-ee6c-4270-b9d7-52b6f24078c2@siemens.com>
Content-Language: en-US
In-Reply-To: <be7c406d-ee6c-4270-b9d7-52b6f24078c2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbc2820-dd86-465e-9cca-08dc7c2fb8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q0x3cG50SVB0eVVPR3BhTHM0aVM5YVV5U3EyS3lzem9MbFpma0c1disrSWRO?=
 =?utf-8?B?N0NqVzI3V0lUbTczQlNKcGVHbGdObmRSMzR6RG5CdEEwL2Q2Z1lHbGZzMlY4?=
 =?utf-8?B?OXEwTk11UkloVEtxMi93WnZobTZTQWsxSTB3SzRkWkkzL1R0aWxSZ09rTGkx?=
 =?utf-8?B?Q0YvRGExOHIzT2V0cTJSV3VpTXlvZGNVdVB3QjJRZTdWalBsdHZPbWVKTndQ?=
 =?utf-8?B?RWR4eVFGNTNKMDNXSjBOR0s1VWdYem5kYVh6RUhsYk8vc0Vuem5ITzJERW5m?=
 =?utf-8?B?TzV5OC9qQXJJbE9uN0c2M0kyakpNZzFhQkpwQ2MxdS9pQngxMU80Rmg2UHdF?=
 =?utf-8?B?SW9jKytFRjNBWG04blZaRUpGTEVDQUZkeHI5SjgxSHMzbkd2NWIyYlhQVjhq?=
 =?utf-8?B?czdULzJnb3dVUUxBRDl0dUI5cDA5UDhrdWJqc2FJSkF0L1BJWVQ5eFNSM2ZO?=
 =?utf-8?B?MndvVE05cEYzRzVVanRHR2FwT01MMzZ3L1g2dVFhcnp1TWc0UFhycnc5a0Mx?=
 =?utf-8?B?Z0xVcllzOStieG92bDNqTS91YllmUWtSSGNyaWRRV1NvSzhkMXplSVFLRFlZ?=
 =?utf-8?B?TDA2VE9SL1RYa0U5MDR6cmRFS3I5eEpiZVNwQjRqMFpMSEgzbnU5M2k0UnhC?=
 =?utf-8?B?aUZqVTRGdytDa3lpcWlmV2h0NW1YMGVHU3BRUkg5anR2dHdEOUZvdU8vV3c4?=
 =?utf-8?B?K1V4cEFDMEhGM1Ridk5sUGJNWWNGbDhtaU4wcks3RlZwQXNKS0tRck84ak43?=
 =?utf-8?B?Mi9xelVJVS9JRTh2VThWQnFPREZza0JHUGxwMUtlMTkxZ3Z0ZG5qWUpLSW9o?=
 =?utf-8?B?N2xUMDFVdXRxNWwrUFhmV3RJenA2M0xxS1h2c3Vxc2FNWENqYXdqdGp5MWdh?=
 =?utf-8?B?VmRUSFdvOVhoZXN4VTA2K3hGem5hT2NJczdTMEVFRG5Mc0toa25kR0FvYmV6?=
 =?utf-8?B?NE9WUVVhQThqQXpkUUZkQ0FVUmFYMEM5cEtXbzA5aXB0bXRyR0djZ1QyWktU?=
 =?utf-8?B?elZ6amdhbkF5ak9Xb25CMXQxQXhhZXRKVWkyS2lVZEdRRVV4eGw5VEU2SkxF?=
 =?utf-8?B?Skk5allTcGRGdllQQjQ3T01zZktxemR3UVJuS2RPWm9ZTkpCcFIrbHY5Mks3?=
 =?utf-8?B?VVpTRXp3SEkzalQ1aldoVUk4MzZNRVRhZ2hhUHlPL2h3a1B6RmtYK2p0Rk5K?=
 =?utf-8?B?RUg1NXJZL1IzWEQzclJWUUQyZkFPMjQzQmUzRXUrZDNpNVYxcXZXZ2YyTEYw?=
 =?utf-8?B?QnZkQm1BL2hNS2FzQnIzSGxNc0VGa1JNYjhIWkJuSHJmUUlNczBXNkxNNElR?=
 =?utf-8?B?WVlBWVZMRGcyaFJmUkRyQnpwYWxaaWtKWnFFZFNjVjZDT3F5a1FCY3RUNXMx?=
 =?utf-8?B?Q2NuSmo1d0NUME1LbCt0c2hkdWNRQS9JZFJUaGxzdlZMdzlaRlRUUEQ3WEM3?=
 =?utf-8?B?KzVHdGc5bjVzZC81MVBLQ3JZWkluTjUrUk9aaDhuVW4rSkRXWHZrNHF5ZWxI?=
 =?utf-8?B?UWpQMXdxMU1kbkw2Vk5KcnBaUnpsdVlKREFqb3VzWXB5bWhKL0hMdUVsN3pn?=
 =?utf-8?B?S0d0b281UkVVaUtGK0ExQ3JjUktGdEYyYmt1R1NRME5Fb1J0R29TS0JKQTJi?=
 =?utf-8?B?cEdRTEdmZHMvN25sSzMzdFdtNlpZZWZDeEpLdXNIcHl2eUtmYlZ2c0s1YmJu?=
 =?utf-8?B?d25yVThpNkIxUmNENkhNK3VIdS81VXZ3TjV1UjhBUmZUTThrQU5UcTJnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEVhblJxSHcyamNqazBDWmdtZ2swNnptR1BLRFVabVFwRDRvMTFydUhWTmRq?=
 =?utf-8?B?TlpBLzBnMmNLY3JiT29ZMDZmTVpyUGV3QmRpeXpvN05jOExKcHlzWjczMzlZ?=
 =?utf-8?B?K2hrMW52NXJXSnBCakdiVVV1YUt2VVVGN29vK3BRQ3dGa1NlbXNSdC83clp4?=
 =?utf-8?B?ZUxUUkszRE1BWUFTdmIwN0NwR2hFM2NoWVlqWGh2Zml4Vk00bjkxeFl2bFQ3?=
 =?utf-8?B?UVpkbGJEMmFPSExPbWo2dzMrdjdiUVFicFVRQVFzM0N6elMyQ3hudGtnaHlw?=
 =?utf-8?B?SDljSGxCM2llUk5QYU5rcVBCaHpVRjdSbHVrUFdMOHd2MWJSQldWWGFkcXhB?=
 =?utf-8?B?VWpqVk00SHp5T2o2c2VNYzMvay9WdjRrejBRdjhHZGROZkNiaUNCTDhFanlw?=
 =?utf-8?B?Uk1vNFMzUHcvK1AzYW8zRlg2VVg3QTU1SVpobVVtL0wvcmNKZHU5YnczZi9Z?=
 =?utf-8?B?bjY4S0xyRFV4c0grM2IyRTNuNjgxSmo3bGRlUG16RTRKMVhvRUdndEw1M0tp?=
 =?utf-8?B?di9UYW9MNDRLV0RieDJvNlB3dDNGK0ZKenIySU1NY0NyZVB0bStXbWp1dEQ4?=
 =?utf-8?B?NGc2SkV0YVBvdGxFWFhUTG8vdFVFZ2tVNDk2MkdOY3pCYlpqcFAzY2RrYkR1?=
 =?utf-8?B?clB4N3VpNFgxYVg1ZGYxb0syUldJcG5Cam9NaHB4RHg2a2RlYjJ4MmFicUtm?=
 =?utf-8?B?WGZLaEE0eVFVTzRUMTNISStNbVpUeE9ya093Nk1Hcnc4Wng0MHB2bTlEMFJp?=
 =?utf-8?B?TnVKNmtmSlk1b3UvVmlpMUV2eWdSR21rbG1PRy9YMStwdVUra1liSVo1WkZU?=
 =?utf-8?B?QkFuYWc3aVlyQkVPUFJEU3pFWTd5a0lHNXoyNEQrSGVzY25rb1M2aEQxVW1Q?=
 =?utf-8?B?UlN3NDZLcG14L2ZVTXhwM3lKbzNPMEtIWWpkdmFvQlBFdFBtMHNVZHl1Wjh5?=
 =?utf-8?B?RkVaaXVoTUFkUGIzemhRVjlBbTlZWTE2SWhUTnBMV0l5N25kOFVjK0ppeHVw?=
 =?utf-8?B?TVRQV1pjWXNiVFFRblJrR2tIZjREVHU0TXQ0dUdCcWJWaHJIR29ueHlvMHFY?=
 =?utf-8?B?amZIQjJCKy8vSXcvUXJ1OE5Bei9CdlFVd1daSmRzeE5RWTJFWnBFeVpqQ0Yv?=
 =?utf-8?B?dGN6WXdYUkhIWSsvajd1aWpVRmJZNzdSdFJlRHl3Z1VQZ0xRYU1FSDNySVVG?=
 =?utf-8?B?WFQ5NlV2MG9aNXpaY3RCODMvSlJsR0Z5V05YUHJvYnlTb09zcVVwa1BuRkN5?=
 =?utf-8?B?OE5uMVhCOEJ4TlY2dUxRd1VnRldpRlErTit0RFc5VVJvTmdPUXYxVmRoZjBn?=
 =?utf-8?B?WHIrNFUyRGFkaTJCZnMwUkFQSTNuMjdYK1BuVUZ6MlRXOWZJV0VhT3FGUkdt?=
 =?utf-8?B?eHpXVkJzRjhVMmF5ZjdCY25PeUJyWGt3ejR5ZzVMWVhxU211S2JUV00wU2xL?=
 =?utf-8?B?T053dDZ2N1Q2WGFrYlh2OTZ4VHVVaisyayt4UklVRGtHd0pSblhJakFtSTZO?=
 =?utf-8?B?UURjc1MvSGdqY0dScC9rRTlyV0dZOGVGMktYUFFDV3Jaa1dFRGVRaXRjU21q?=
 =?utf-8?B?NUhuTDNBc2FtWkVGcTlQQXArU3BzY3JTOURpYzN6WnprdDk1OHRzbjAxR2F0?=
 =?utf-8?B?ck1VeDQzczBFZ1J5OG15RlhuSWppeGlLR0tmK2d1VnF2WWw4SFJRc0M4cm04?=
 =?utf-8?B?TmY2eW5aNWVjQ0lZb2xyTVBCUVlIWjhKSEF5M3ZldXJ2eFk5QUd4ZUtpMnFq?=
 =?utf-8?B?QmJHT01WWE9NTDlYVUFIYXpBWDgwcU9vWVBseTFUWFE2dDBVckxaVDF4cnpS?=
 =?utf-8?B?UTBmdDI5NXFoOXZScUt4bVV2b05KOEhKNHVJWFh2dk5XWVBXS29zclBVWko3?=
 =?utf-8?B?b3hveXZTenBFcEJVWmtSU0FESGdhczVqVC9DSlB4NWp5cmFlbjNzdG9KQXNs?=
 =?utf-8?B?SDZFaC9XR2R6bXQrcnVSbC85KytLUGs0NFZoVmRPUXc1cWRhanBYSlNYN3Iz?=
 =?utf-8?B?RzJuQjBxdDUrU0FHeDdsVDZoQm80eEVibkVpdFpVYnRhbXNaNnNhL0JpZ3l4?=
 =?utf-8?B?cTRwdzFDVDhZaVRCVW5YNTc0RXJZSk8rQ25MZjBGN09VNUVkc0VIV09XWE1y?=
 =?utf-8?Q?FrWfV0MoM7tSi+wj7CLHWf5v+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbc2820-dd86-465e-9cca-08dc7c2fb8d2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 20:25:58.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OicRFrJLX+dIYAtdLlLYbkVMxWGxhuOzC1HrXqUHgsGM3JVjifpY1r2Z+VK8+qeLiFKy76zM8apaAMhUhXwVvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7499
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 May 2024 20:26:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15949

On 24.05.24 12:50, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This also prepares for a generic x86 target.
> 

Found a config regression: qemu-amd64 lost its keyboard input in the
text console. Not a major problem, but it would be good to understand
how it happened.

Jan

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  conf/machine/qemu-amd64.conf               | 4 ++--
>  conf/machine/simatic-ipc227e.conf          | 4 ++--
>  recipes-kernel/linux/cip-kernel-config.inc | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
> index da7e59cc..d7866468 100644
> --- a/conf/machine/qemu-amd64.conf
> +++ b/conf/machine/qemu-amd64.conf
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Siemens AG, 2019-2024
>  #
>  # SPDX-License-Identifier: MIT
>  #
> @@ -10,4 +10,4 @@ DISTRO_ARCH = "amd64"
>  
>  IMAGE_FSTYPES ?= "ext4"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
> diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
> index 95e2c9a9..33f82b16 100644
> --- a/conf/machine/simatic-ipc227e.conf
> +++ b/conf/machine/simatic-ipc227e.conf
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Siemens AG, 2019-2024
>  #
>  # SPDX-License-Identifier: MIT
>  #
> @@ -12,4 +12,4 @@ IMAGE_FSTYPES ?= "wic"
>  WKS_FILE ?= "x86_64-generic.wks"
>  IMAGER_INSTALL:wic += "${GRUB_BOOTLOADER_INSTALL}"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
> diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
> index 40c378bf..6839e1a9 100644
> --- a/recipes-kernel/linux/cip-kernel-config.inc
> +++ b/recipes-kernel/linux/cip-kernel-config.inc
> @@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
>      if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>      }"
>  
> -SRCREV_cip-kernel-config ?= "ee86aca8abbe7a41536bcb53142fbf0f57b1c9b7"
> +SRCREV_cip-kernel-config ?= "5a81b70b8a158d44991da73cf01f310bcd2bff72"

-- 
Siemens AG, Technology
Linux Expert Center


