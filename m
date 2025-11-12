Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB09BCCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 08:08:44 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com (CH4PR04CU002.outbound.protection.outlook.com [40.107.201.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8487.1762934917484352157
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Nov 2025 00:08:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=selector1 header.b=QBdGcOSn;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.107.201.54, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwoFiDagQ5j1jdMTCoTH5wWUraJWQcNy3gbecL9EgZXaO5weG3JA/AJOgbV2ltDFXqjOrh4//UYJv+zQpm7MaxABHebpjESoFqNmRZITEt5tCWLuNH4BEKNDyJkw9xix02IFvWWpZKyOgAHb+D0Sg8G23ihndB3xARh/gq/qsJ0eNvzMkY/nf3lSZsFDT0GqN2azswVbt0ebaiMqDiRgT+1djA2VwBvif2a5UC9btGUUt+BIeeHqnPtXLSAG7Bih00TQzi9zd1R7DDs3qp8Vy5TPPkIY29LLimiENse4rWnYqbq7z2nmHW912iU1kE0BxuiiS8N5u4CTYoptTOgP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M51RdLWMesmvgVWWzda2vlvSGYxnf8xS5eVVcdQLXiw=;
 b=To5FAZBvqMycjE90ZpkHSyIiOfckM1RsUgyb4qsoT06njv0XepyyXOioB2Auo7/sPYnMS2E02i7qW/cGVWooL6tNvIqK1iRIv8pLmIc4LSvZ1/yZwUAopFqf4tJjBQxKy1oU6++UOBonk29U2YU63VB3XwlHwmw6G60hVu7WCHzQnaPTJGSy/q1uYYqAIUwhvu8xHHnp+VvJiug3c6/vG8Iftc2iHStRfLVzZjyrcvEzRR0IZ/5/rgnSjqC0e/xGYpvSY0gVrOTlhrHOQQ9ZYOz4vUU8CV313d0zIs/HpgxJjRKCBeto84C5qvSiuYHMEZEMfLK4Okoq7f3DGjGYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.cip-project.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M51RdLWMesmvgVWWzda2vlvSGYxnf8xS5eVVcdQLXiw=;
 b=QBdGcOSnwfY3nGnfl0opaO+gAoAtFISBfKuqjfU7mUd81+TCBnWewOJgYm0EJsAtPM9/uXaS5Z1zkBbOLQNrLK7sJsIroWgWLHi+w0YQBZ2twJkLbLLbxsDSmB8r3oJxO4fuT5eUUudSSNvE8+3H1LysTQYVho/9Nd43zQpj1kk=
Received: from BL1PR13CA0176.namprd13.prod.outlook.com (2603:10b6:208:2bd::31)
 by IA1PR10MB6733.namprd10.prod.outlook.com (2603:10b6:208:42f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 08:08:34 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::c7) by BL1PR13CA0176.outlook.office365.com
 (2603:10b6:208:2bd::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 08:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 08:08:32 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 02:08:20 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 02:08:20 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 02:08:20 -0600
Received: from [172.24.233.117] (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC88Ij92360570;
	Wed, 12 Nov 2025 02:08:19 -0600
Message-ID: <3c42b107-faea-4b18-90b0-53d45286d6a6@ti.com>
Date: Wed, 12 Nov 2025 13:38:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 1/5] Add support for TI AM62Px
 SK platform
To: Jan Kiszka <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
	<vigneshr@ti.com>
References: <20251111164508.1707234-1-s-adivi@ti.com>
 <20251111164508.1707234-2-s-adivi@ti.com>
 <0e889535-0845-4f2d-910e-7da838d26577@siemens.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <0e889535-0845-4f2d-910e-7da838d26577@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA1PR10MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e365180-cfec-4ad2-ce51-08de21c2ac39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VHZYUWNwdUgrV0hEYUNFcGJtbzVkU3k0c3JWTkFLbGhwYkVpWlhucmJsNDhX?=
 =?utf-8?B?emhHUWljVklBTGh3QVl2ZndWemlpclZpTXBXVmlNZkdkVm00dXNiaWN5am14?=
 =?utf-8?B?SFBtdHZaYmNIbHg4ZTBvV3l5d3Z0N0dDWlN6QkNxd3FvdnRheXFPWE91aExO?=
 =?utf-8?B?MHVKd0x2ZlpQU3A2OUdmYmkvQWJVM2NseHB3NjZYSks5dW5MYWZoNnRpOXJr?=
 =?utf-8?B?eVdJMjhHRnMvYVphTTg5NjFGYVlxZElrQVFZR0dLUC9wMXByeGppSEdsM3o3?=
 =?utf-8?B?UU10akd4R2hjeFkvUU4yYzNXTU9GaFFrWVMyNEQ1WlZ2VUVpdkZPTGk4Ti83?=
 =?utf-8?B?NjVzTC9IWmo5YWNpdVJTRTFwM0wyZkRxRGJSNWxhWmpVOHBrTGIvOGZLQ2Rj?=
 =?utf-8?B?SVAxYlJaUWsyVkgrUWw2Y0FYQmtZSnZ4LzNvMXhKSnJBWEZSdDhoWTZmWXpt?=
 =?utf-8?B?SXpOZjRTSWh0akRMY254NHArVFdVVExBdUlNdEhBMVFwdG1oRkl1NllPVFd3?=
 =?utf-8?B?TE5FbDlsTEE4eU0yRE5VQVZodzF6NFN6elRHK0owNWZaWFVzSHNKNkRWRUxE?=
 =?utf-8?B?NERxajc1eU1ZVjc1K01sZHQxcDNIbi8rRExYOUdadW5NMWdXVTFnZ3RFMk4w?=
 =?utf-8?B?UVk2eDBBTzF0Q2dPeTczdmZLTEhFNWxxc3NFWnpmQlVsWmxXa1BmVVFaNlFF?=
 =?utf-8?B?WUx2Q3BkM3pXQ2UzWmVRbDZScnF2TXBUNk1xbDZkYmpCNmdsR2RBck9JbTlC?=
 =?utf-8?B?MC9nRUJ4WGdRYldsSGNkbWFmczZ3UjFFRzd1YzFJamxMU1M3N2E4QWp5MVIy?=
 =?utf-8?B?OGJrY3FZbjQwcDJtYzZ5TWg3UlJ0d0ZPMTg3VStzdFI3S3piNWJkQzJnS2lC?=
 =?utf-8?B?Ulh3OVYvWTY4RTE4bW5JNXZwNFMyZU42Nm1kTDREWHZsWUlxQVNJMVFQcys4?=
 =?utf-8?B?N2p4eEJodEg4azUvZUd2L2NXTHZGZXZ2dG9sRXZqU1Jhc0lqbndBeW1TaHls?=
 =?utf-8?B?b2RHYUpLZFRMTm50eXZQYlhoaElRdGo5NjBxb3FSalh4QWpSVkt1Nzc1b0hQ?=
 =?utf-8?B?Z0l6QmtxTmhKdGRpc3R1dWRIaWRjYU5IenlwaHlMMmZCT0w1djNBaFhkcUlE?=
 =?utf-8?B?VEpQR0s0VkU4UVVpdS93K3lLY1h2U09vL2tPczkwZ2Vld28rK0hSVHJ5amhv?=
 =?utf-8?B?aDU4RjVCS3FMTFhwVnJtT2ZNSFRUZVhUZTIxQ1g4VXR3RWFlRndoYmNUT1Jx?=
 =?utf-8?B?S0U1UzdMMlUrR1VQZ29tVW9hQTlmZEdGMjJBdWwraHdhSlA5MHZuUjFhS3My?=
 =?utf-8?B?MlB3NHlZVEVjeHlpdVlUTFJzNjZXNmFiSW5nd1Vhc1N1RmxtOVc3dllWTVdB?=
 =?utf-8?B?SlVLamJiaEJQTS9BdjE1ZStPWXNNbkVUTE1IT21xVkhuRXdzdUpuZHIzcTE1?=
 =?utf-8?B?cTA2bTBHMGFWeVlLZU9mYStjeTdYaXNTc1B5Rnh0VVhRZ3FGQld4QTZ1UFJU?=
 =?utf-8?B?VFd1c3JObmFZbmtxeENJVFpxRjBLOUNxdG5oRDBHUzQvS3B3b2hJb0hUV041?=
 =?utf-8?B?dGlDVzM1cUtDQit5blRUK29qeWNIcnVUYVlFR05qbzlpSktrU29Uelo4WnJv?=
 =?utf-8?B?T2dGZm1OUFlvbStjVzhJbHdpb2o3OUdCZlY0dGtKN0MxS2xPdE03YnNTVXN1?=
 =?utf-8?B?RzVVYk1kN3BNeXdJK1liVkl2YXZVcHJVR1NBbEYxTjlGSVFBMjFRSGdYYTFt?=
 =?utf-8?B?VmQrZU10akVNU01KOGZIMUFCc0lqdzN5WmtxOW1hdGE3N1lDd05kci80RFhB?=
 =?utf-8?B?NEJFNzhYRHNYU1poaUdVUHQrL292SUI0amt4blVzL0JvVWFaczg4eEIwc3hh?=
 =?utf-8?B?ei9WRkFrYkFvZEtuY2d4ZXhBUGprNGs3UGFZbWo5MXhzK3VjMjViYXV1RzUy?=
 =?utf-8?B?SzdoWjNCWjFKSUJXR0RxU0tQelY2QmtTM1IyY3YxTHA3cURqczVuRmdLd0Iv?=
 =?utf-8?B?WjRVZmlYOFlCdVlKbmxMNStLMVBZU3FpQkM1ZTQ5MmF1Nlhhb3UxN3VXcXR0?=
 =?utf-8?Q?TPMVAi?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 08:08:32.8868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e365180-cfec-4ad2-ce51-08de21c2ac39
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6733
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 08:08:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20513



On 11/12/25 12:51, Jan Kiszka wrote:
> On 11.11.25 17:45, Sai Sree Kartheek Adivi wrote:
>> - Add machine conf and and kas yml files for TI AM62Px SK
>> - Add u-boot 2025.07 recipe
>> - Add patch 0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch to
>>    enable KASLR support. This is already upstreamed to u-boot at [1].
>> - Add new recipes for trusted-firmware-a, optee-os
>> - Update SRCREV for cip-kernel-config to fetch ti_defconfig
>> - Add wks file for supporting image builds
>> - Update Kconfig to enable build support
>>
>> [1]: https://github.com/u-boot/u-boot/commit/7d4136397715d2c08161a32a873c052dd1bb8b6c
>>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   Kconfig                                       | 11 ++-
>>   conf/machine/ti-am62px-sk.conf                | 32 +++++++++
>>   kas/board/ti-am62px-sk.yml                    | 13 ++++
>>   recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 11 +++
>>   recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc | 30 ++++++++
>>   .../trusted-firmware-a-ti-k3_2.13.bb          | 22 ++++++
>>   ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 ++++++++++
>>   recipes-bsp/u-boot/files/rules-ti.tmpl        | 33 +++++++++
>>   .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     | 69 +++++++++++++++++++
>>   wic/ti-am62px-sk.wks                          | 15 ++++
>>   10 files changed, 272 insertions(+), 2 deletions(-)
>>   create mode 100644 conf/machine/ti-am62px-sk.conf
>>   create mode 100644 kas/board/ti-am62px-sk.yml
>>   create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>>   create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>>   create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>>   create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>>   create mode 100644 recipes-bsp/u-boot/files/rules-ti.tmpl
>>   create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>>   create mode 100644 wic/ti-am62px-sk.wks
>>
>> diff --git a/Kconfig b/Kconfig
>> index 68773bc..0930f7f 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -86,6 +86,10 @@ config TARGET_QEMU_RISCV64
>>   	select ARCH_RISCV64
>>   	select HAS_SWUPDATE if KERNEL_6_1 || KERNEL_6_12
>>   
>> +config TARGET_TI_AM62PX_SK
>> +	bool "Texas Instruments AM62Px SK"
>> +	select ARCH_ARM64
>> +
>>   endchoice
>>   
>>   config KAS_INCLUDE_BOARD
>> @@ -98,6 +102,7 @@ config KAS_INCLUDE_BOARD
>>   	default "kas/board/bbb.yml" if TARGET_BBB
>>   	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>>   	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
>> +	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
>>   
>>   comment "Kernel options"
>>   
>> @@ -107,17 +112,19 @@ choice
>>   
>>   config KERNEL_4_4
>>   	bool "Kernel 4.4.x-cip"
>> -	depends on !ARCH_ARM64 && !ARCH_RISCV64
>> +	depends on !ARCH_ARM64 && !ARCH_RISCV64 && !TARGET_TI_AM62PX_SK
> 
> Let's put the target dependencies into a separate "depends on" line.
> 
>>   
>>   config KERNEL_4_19
>>   	bool "Kernel 4.19.x-cip"
>> -	depends on !ARCH_RISCV64
>> +	depends on !ARCH_RISCV64 && !TARGET_TI_AM62PX_SK
>>   
>>   config KERNEL_5_10
>>   	bool "Kernel 5.10.x-cip"
>> +	depends on !TARGET_TI_AM62PX_SK
>>   
>>   config KERNEL_6_1
>>   	bool "Kernel 6.1.x-cip"
>> +	depends on !TARGET_TI_AM62PX_SK
>>   
>>   config KERNEL_6_12
>>   	bool "Kernel 6.12.x-cip"
>> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.conf
>> new file mode 100644
>> index 0000000..6e59250
>> --- /dev/null
>> +++ b/conf/machine/ti-am62px-sk.conf
>> @@ -0,0 +1,32 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +DISTRO_ARCH = "arm64"
>> +DTB_FILES = "k3-am62p5-sk.dtb"
>> +
>> +IMAGE_FSTYPES ?= "wic"
>> +WKS_FILE ?= "ti-am62px-sk.wks"
> 
> We already set WKS_FILE to ${MACHINE}.wks, so this is redundant.
> 
>> +
>> +IMAGER_INSTALL:wic += "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-ti-am62px-sk"
>> +IMAGER_BUILD_DEPS += "u-boot-ti-am62px-sk"
>> +
>> +IMAGE_INSTALL += "u-boot-script"
> 
> Not needed, you are doing UEFI booting.
> 
>> +IMAGE_PREINSTALL += "firmware-ti-connectivity"
>> +
>> +IMAGE_BOOT_FILES = " \
>> +    /usr/lib/u-boot/${MACHINE}/u-boot.img;u-boot.img \
>> +    /usr/lib/u-boot/${MACHINE}/tispl.bin;tispl.bin \
>> +    /usr/lib/u-boot/${MACHINE}/tiboot3-am62px-hs-fs-evm.bin;tiboot3.bin"
>> +
>> +USE_CIP_KERNEL_CONFIG = "1"
>> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/ti_defconfig"
>> +
>> +WDOG_TIMEOUT = "0"
>> +
>> +PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-ti-am62px-sk"
> 
> Please set COMPATIBLE_MACHINE in the u-boot recipe instead, see
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/4ba393e85e5a832e4248b6842badec41207846cd
> 
>> diff --git a/kas/board/ti-am62px-sk.yml b/kas/board/ti-am62px-sk.yml
>> new file mode 100644
>> index 0000000..5127218
>> --- /dev/null
>> +++ b/kas/board/ti-am62px-sk.yml
>> @@ -0,0 +1,13 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +header:
>> +  version: 14
>> +
>> +machine: ti-am62px-sk
>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>> new file mode 100644
>> index 0000000..f8cd973
>> --- /dev/null
>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>> @@ -0,0 +1,11 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require recipes-bsp/optee-os/optee-os-custom.inc
>> +require optee-os-ti-k3_${PV}.inc
>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>> new file mode 100644
>> index 0000000..444f6b3
>> --- /dev/null
>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>> @@ -0,0 +1,30 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +SRC_URI += " \
>> +    https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee-os-${PV}.tar.gz \
>> +    "
>> +
>> +SRC_URI[sha256sum] = "5222cd553f5edb69ae4ec7cb99b2bfec2c47a47c0be1865b49744701918e8b4d"
>> +
>> +S = "${WORKDIR}/optee_os-${PV}"
>> +
>> +OPTEE_NAME = "ti-k3"
>> +OPTEE_PLATFORM = "k3-am62px"
>> +OPTEE_EXTRA_BUILDARGS += " \
>> +	CFG_ARM64_core=y \
>> +	CFG_USER_TA_TARGETS=ta_arm64 \
>> +	TEE_IMPL_VERSION=${PV} \
>> +	CFG_TEE_CORE_LOG_LEVEL=1 \
>> +	"
>> +
>> +DEBIAN_BUILD_DEPENDS += ", device-tree-compiler, python3-cryptography:native"
>> +
>> +OPTEE_ENABLE_APPS ?= "1"
>> +OVERRIDES .= "${@':optee-with-apps' if bb.utils.to_boolean(d.getVar("OPTEE_ENABLE_APPS")) else ''}"
>> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>> new file mode 100644
>> index 0000000..5b572bf
>> --- /dev/null
>> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>> @@ -0,0 +1,22 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
>> +
>> +SRC_URI += "https://github.com/ARM-software/arm-trusted-firmware/archive/v${PV}.tar.gz;downloadfilename=arm-trusted-firmware-${PV}.tar.gz"
>> +SRC_URI[sha256sum] = "68333c8be57830e7430d7dd39064826729923d86d6bb7af38d713d4e9d15dcf9"
>> +
>> +S = "${WORKDIR}/arm-trusted-firmware-${PV}"
>> +
>> +TF_A_NAME = "ti-k3"
>> +TF_A_PLATFORM = "k3"
>> +TF_A_EXTRA_BUILDARGS = "CFG_ARM64=y TARGET_BOARD=lite SPD=opteed K3_PM_SYSTEM_SUSPEND=1"
>> +TF_A_BINARIES = "lite/release/bl31.bin"
>> +
>> +COMPATIBLE_MACHINE = "ti-am62px-sk"
>> diff --git a/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>> new file mode 100644
>> index 0000000..d831b21
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>> @@ -0,0 +1,38 @@
>> +From 7d4136397715d2c08161a32a873c052dd1bb8b6c Mon Sep 17 00:00:00 2001
>> +From: Gokul Praveen <g-praveen@ti.com>
>> +Date: Thu, 10 Jul 2025 15:29:22 +0530
>                ^^^^^^^^^^^
> 
> Still not upstream?? Please make sure that it's going to be included in
> 2.14.

This patch is already upstream but after v2025.07. Hence carrying the 
patch (upstream commit provided in the commit msg). Can remove this 
patch when we are ready to migrate to v2025.10 or once the v2026.01 is 
tagged.

> 
>> +Subject: [PATCH] configs: KASLR OPTEE RNG support for K3 devices
>> +
>> +KASLR, or Kernel Address Space Layout Randomization, is a security
>> +feature in the Linux kernel that randomizes the memory location
>> +where the kernel is loaded during boot.
>> +
>> +OP-TEE RNG is a Random Number Generator (RNG) component within the
>> +Open Portable Trusted Execution Environment (OP-TEE) which provides
>> +a random number to U-BOOT and U-BOOT provides this random number
>> +as seed value to the LINUX kernel for KASLR.
>> +
>> +Add KASLR OPTEE RNG support across K3 devices by enabling the required
>> +configs.
>> +
>> +Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>> +Reviewed-by: Bryan Brattlof <bb@ti.com>
>> +Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
>> +---
>> + arch/arm/Kconfig | 3 +++
>> + 1 file changed, 3 insertions(+)
>> +
>> +diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> +index 5872455a0fe5..4e7593616d8a 100644
>> +--- a/arch/arm/Kconfig
>> ++++ b/arch/arm/Kconfig
>> +@@ -835,6 +835,9 @@ config ARCH_K3
>> + 	select FIT_SIGNATURE if ARM64
>> + 	select LTO
>> + 	imply TI_SECURE_DEVICE
>> ++	imply DM_RNG if ARM64
>> ++	imply TEE if ARM64
>> ++	imply OPTEE if ARM64
>> +
>> + config ARCH_OMAP2PLUS
>> + 	bool "TI OMAP2+"
>> diff --git a/recipes-bsp/u-boot/files/rules-ti.tmpl b/recipes-bsp/u-boot/files/rules-ti.tmpl
>> new file mode 100644
>> index 0000000..58e954f
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/files/rules-ti.tmpl
>> @@ -0,0 +1,33 @@
>> +#!/usr/bin/make -f
>> +#
>> +# Debian rules for custom U-Boot build for ti-am62p-sk
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
>> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
>> +SET_CROSS_BUILD_TOOLS=CROSS_BUILD_TOOLS=y
>> +endif
>> +
>> +override_dh_auto_build:
>> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm ${U_BOOT_R5_CONFIG}
>> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- BINMAN_INDIRS=${BINMAN_INDIRS}
>> +
>> +	$(MAKE) $(PARALLEL_MAKE) ${U_BOOT_A53_CONFIG}
>> +	$(MAKE) $(PARALLEL_MAKE) BL31=/usr/lib/trusted-firmware-a/ti-k3/bl31.bin \
>> +		TEE=/usr/lib/optee-os/ti-k3/tee-raw.bin BINMAN_INDIRS=${BINMAN_INDIRS}
>> +	$(MAKE) $(PARALLEL_MAKE) u-boot-initial-env
>> +	$(MAKE) $(PARALLEL_MAKE) $(SET_CROSS_BUILD_TOOLS) NO_SDL=1 tools-only envtools
>> +
>> +override_dh_auto_install:
>> +	mv tools/env/lib.a tools/env/libubootenv.a
>> +
>> +override_dh_auto_test:
>> +
>> +override_dh_strip:
>> +	dh_strip -X libubootenv.a
>> +
>> +%:
>> +	dh $@ --parallel
>> diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>> new file mode 100644
>> index 0000000..bac1413
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>> @@ -0,0 +1,69 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require u-boot-common-${PV}.inc
>> +
>> +TI_FIRMWARE_PV = "11.01.16"
>> +
>> +SRC_URI += " \
>> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-fs-cert.bin;downloadfilename=ti-fs-firmware-am62px-hs-fs-cert.bin;name=am62p-sysfw-cert-hs-fs \
>> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-fs-enc.bin;downloadfilename=ti-fs-firmware-am62px-hs-fs-enc.bin;name=am62p-sysfw-enc-hs-fs \
>> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin;downloadfilename=ti-fs-stub-firmware-am62px-hs-cert.bin;name=am62p-sysfw-stub-cert \
>> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin;downloadfilename=ti-fs-stub-firmware-am62px-hs-enc.bin;name=am62p-sysfw-stub-enc \
>> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-cert.bin;downloadfilename=ti-fs-firmware-am62px-hs-cert.bin;name=am62p-sysfw-cert-hs \
>> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin;downloadfilename=ti-fs-firmware-am62px-hs-enc.bin;name=am62p-sysfw-enc-hs \
>> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f;downloadfilename=ipc_echo_testb_mcu1_0_release_strip.xer5f;name=am62p-dm \
>> +	file://rules-ti.tmpl \
>> +	file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
>> +	"
>> +
>> +SRC_URI[am62p-dm.sha256sum] = "7251394068d287ec81cb0f005a734de3bb7bb695d9dbcc3903ea83dda2182efc"
>> +SRC_URI[am62p-sysfw-cert-hs-fs.sha256sum] = "fe36da7923ac6fa52eea5e601fb4321299df5e639d9dd66b41b6825bc1d9d539"
>> +SRC_URI[am62p-sysfw-enc-hs-fs.sha256sum] = "4db6ed096fd5077023f292841a64aedb3a4ff8408d1160fb10a7aa0355d06e56"
>> +SRC_URI[am62p-sysfw-stub-cert.sha256sum] = "22b58a07429da5ae0b0cd126d4ec0f429ee687429251f4fcfe9a2f5bb3e74b5d"
>> +SRC_URI[am62p-sysfw-stub-enc.sha256sum] = "2cb73e5c9acf985325f40f16152906c9a2057f41ffb7903a981a34f7b2aaf524"
>> +SRC_URI[am62p-sysfw-cert-hs.sha256sum] = "dfb1c90110155328bc19d9ecdbfacc5a899d4cce8378f8eb8f27877c9fda1fdc"
>> +SRC_URI[am62p-sysfw-enc-hs.sha256sum] = "4d5216f8187441ef8af00ae7e79113d36964221a3a19a026aeec09e20a290931"
>> +
>> +S = "${WORKDIR}/u-boot-${PV}"
>> +TI_LINUX_FIRMWARE = "${S}/ti-linux-firmware"
>> +BINMAN_INDIRS = "./ti-linux-firmware"
>> +
>> +COMPATIBLE_MACHINE = "ti-am62px-sk"
>> +
>> +U_BOOT_R5_CONFIG = "am62px_evm_r5_defconfig"
>> +U_BOOT_A53_CONFIG = "am62px_evm_a53_defconfig"
>> +U_BOOT_CONFIG = "${U_BOOT_A53_CONFIG}"
>> +
>> +U_BOOT_BIN_INSTALL = "tiboot3-am62px-hs-fs-evm.bin tispl.bin u-boot.img"
>> +
>> +DEPENDS += "trusted-firmware-a-ti-k3 optee-os-ti-k3"
>> +DEBIAN_BUILD_DEPENDS =. "gcc-arm-linux-gnueabihf, \
>> +    libssl-dev:native, libssl-dev, grub-common, \
>> +    swig, python3-dev:native, python3-setuptools, python3-pyelftools, \
>> +    python3-jsonschema:native, yamllint:native, \
>> +    trusted-firmware-a-ti-k3, optee-os-ti-k3,"
>> +
>> +do_prepare_build:append() {
>> +    mkdir -p ${TI_LINUX_FIRMWARE}/ti-sysfw
>> +    cp ${WORKDIR}/ti-fs-*firmware-am62px-hs*.bin ${TI_LINUX_FIRMWARE}/ti-sysfw
>> +    mkdir -p ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
>> +    cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
>> +}
>> +
>> +TEMPLATE_VARS += "BINMAN_INDIRS U_BOOT_R5_CONFIG U_BOOT_A53_CONFIG"
>> +
>> +python do_transform_template:prepend() {
>> +    import shutil
>> +    import os
>> +
>> +    src = os.path.join(d.getVar('WORKDIR'), 'rules-ti.tmpl')
>> +    dst = os.path.join(d.getVar('WORKDIR'), 'debian/rules.tmpl')
>> +    shutil.copyfile(src, dst)
>> +}
> 
> This can be a simple "cp" of the transformed files in do_prepare_build.
> 
>> diff --git a/wic/ti-am62px-sk.wks b/wic/ti-am62px-sk.wks
>> new file mode 100644
>> index 0000000..40214a8
>> --- /dev/null
>> +++ b/wic/ti-am62px-sk.wks
>> @@ -0,0 +1,15 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
>> +part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot" --label efi --part-type EF00 --align 1024 --use-uuid
>> +
>> +part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid --exclude-path boot/
>> +
>> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw"
> 
> Jan
> 

Kartheek


