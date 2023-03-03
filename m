Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF1EC7EE2F
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 07:13:24 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.55])
 by mx.groups.io with SMTP id smtpd.web11.18074.1677827594421561910
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 23:13:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GQ/UWf8f;
 spf=pass (domain: siemens.com, ip: 40.107.6.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BctKwZBlEKN7RsnEi9Y1TsqkkM8/WDF/TVBjosAOIP4XjUePmo2y8nMfKLtmz+8xv0ub07TannA0z9Zf4yI/ieZFaEhGCUZbAXutO1JuZo0E6HedI5NoNlIhrOWuCZjHXLljAeDv/ZMaEon3c7IqHwMMMehHHXUsMbEoDRlwOROB/e44XP2TyHqqV9c/gbqx0EfpdNTnMie5pEyz3tCB2rjepqIxZSmDKaR1F/uJsQuC2ZAIMyAe8jO96DsyM3tBXKMEmLJ3sM5iuNmoBXryAu1bBX48/u7PAddl5pOHEoVzgtFL9OFFiTq+o2HPxnDwLynPig6MyGcRig7d/6BuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xp20k0JHRayJ0A0dijx0HKMh6tVCzhTtgdk2eK2OUNE=;
 b=IXf0iQEFjRRk4Ud3/OpGJ7xjCCR2SRnP63UJrn40EzsP8KEEUTH6s/PfBCFuQiOuBzwT/6DUtOG/sdfuuDEhsjJteQTin+tZEg0kjmGldnRoAj0XcyqwPnrnRnqMRighn29qwUPdQIMC4YRWdy1BUKryefs+ZGpbEluKMUyQgCSWqAIsYn1lsB3z3nh0K0mo2FLH90jancMTbx6gKRmdraCVY5rHwNyWVEi1G+rHK7N4J3QY41Q/V7EPJkULiWnBj69nTbOUOu0jRFf2LQYRNL2jCO8uwjBZV/scveOEBKYv+8VuPxgmV0VFQ42Z18cC37kSym9SmTaZaaPq0ZfYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xp20k0JHRayJ0A0dijx0HKMh6tVCzhTtgdk2eK2OUNE=;
 b=GQ/UWf8fsLkNumMTQH0yZZ9VsiQa2KyEVE+MOd61QI78gaUFq4S2VDpd7fssMsnTWvY2aHItFYd4qh/OZVVbqcpUzHgyaElOPd/6PEcseR6WhkGRj1jRXYWEsizsWw80R1JLfzxgchX6ywuhTbtlf7IzZlwcJoPYvrDZP4tvEmRt6Vhc7Utz5X8o7+z+eyjzfWD1/KPNfl/irk9FhfEwgicuMe21Ln/cDjJmTkamlvYrF5bVXz9OZulHY99a8QqjElFcSzJZ4agWQSmFiIEHfpVwk3rDeUVA8CtiBASl8FsGSIzsxLXtuXJJjMQMp78sD8tHvDUYL6mag601bhpNbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8145.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.10; Fri, 3 Mar
 2023 07:13:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 07:13:11 +0000
Message-ID: <ee664f4e-64ea-10d5-e53a-87b5773f90d0@siemens.com>
Date: Fri, 3 Mar 2023 08:13:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v3 6/9] enhance qemu-riscv64 machine to be
 testable
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com, quirin.gylstorff@siemens.com
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
 <20230302152659.2096307-7-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230302152659.2096307-7-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: e1958c26-a8d8-4af9-ba8b-08db1bb6bfab
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sHf6Y1LXjECEzo2YCrJiLVNPFoAFeZa7Tiws+wySOFPqWbVlLoJRCoX4/WKSZ55vzYyNjD9cEbHqT/gfTJ4vKcSqsyYB/FXV/C5ZpS6mXKvU2sw3bTcqnkddl1HHeH3kmidRsNWWlNbWnTnWX6EnCnY79McZ6AylUQ0295faFvSEH34O6AnH93CNWy+dG3Dv135mpS0y4PcRTK05QevdTeCEYFkIipKO4lR2B+W5UhBCPMfZ6KKr+JY3L49euxfvIwtAVO8BIfPDjlPpwEsWo4tAG34apSBoJr70d78Kg2bFRyvyCADQMFhACzOioDY4cMPGpEfjf8YT1Sab6EnWYt6XO7KGf4i7mR+REy9c2YVYCSEQDJu8aQviVNk7pD18vEqhYRaxBvoCQJSacXyZzNA2b1hPM1dBr0LMYWNJU2OEYyj01VcW0p7LxbxXC37ha4FnnlrZinv8hJlweyARHh4Vmp9vUocUUoQ+z4KRQs9lIQ/qVM2927FPkiUdbyfvPW+BeTHIkiE5xkxuT+c0cj1HEWQARxJTGyS2HTY5v0luTttC5DQmIw+bPpl8Cmijj0Pd8LCZEBh637vfdqRGnEzAN6jynzzEDPhSpO5KQ0SI28qbH/0XDqUh/AozYb216PDSIND3DV4wdMYhvy6wZbE+CU2oVefTFMzanqGXMogwYkqTDdz2Ul2HK+L/Muz6fb7/+qyiNbPs7mTlw70OehQ3CTdxqqXwl2FzCdySYhc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(83380400001)(31686004)(107886003)(36756003)(38100700002)(8936002)(5660300002)(82960400001)(478600001)(2906002)(86362001)(31696002)(2616005)(186003)(26005)(6512007)(6506007)(53546011)(6486002)(66476007)(66556008)(66946007)(8676002)(44832011)(316002)(4326008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?blkxMlRlU2UzZklpZWNiQnJ0RWJKYzN6cTd5K1hjVzNiOStXZUs1TllsTFpM?=
 =?utf-8?B?TkRhL0RGT2RjSHRzd2xUTVM4Q0syY09UcjRjbkRqR1R2MTEybE5GTTZSbDQv?=
 =?utf-8?B?SGZJVm1PdGdHVHhkMWtPWDhWcXQ3VFJpa2k0Yk1jVEYxTGNhcUoyNDMvSTRG?=
 =?utf-8?B?VVJoRGR0Rk1BZ3g0VmNHNUZ3MnczQWVHVmdxN2hWOVhLaDg0NDlXUDE0KzQ2?=
 =?utf-8?B?My96eGRoNVZ5Z25TaGVTdE1GSnJ0ZjM4a2NDRWduVGVYSDRObEJFZmNPd1Q2?=
 =?utf-8?B?bVhMeHlMUEhYNUlqQkh2ZHFocjVDbENwN0VONXRRcWl2RWRiakw2alJHYU1P?=
 =?utf-8?B?ODBUbFdoRWExVWhZTDN3R2V5STJ1SitacExZaG1PSkdlUEwwblduV2xodTR5?=
 =?utf-8?B?R2ZxcGtQN0s4Tk9pbVZFWjRJdEJUTEwrdHAxUWI2c2RkeEdFVlArYXZsSTNN?=
 =?utf-8?B?cGRkdDg4RW1OM3B1c3ZaMmtYcVEwL1pkV3M1RWIvSnloSWpzbHM1ampIN20y?=
 =?utf-8?B?UEdNUi8rOGltVGlLUXM1QmdMc0h5UHlJZjJJaWk0akF0WU1jTjZvVzJGYVBI?=
 =?utf-8?B?KzFUY01Vd0RFWUpDRndBZUNKTE5YNkU0ZFM3eG1xNmF6cXZrckF1L1FPL1o5?=
 =?utf-8?B?RTFkcHJtcWtkaFpOQVlyeEhCYjRVL09hQktFaDM4V0RpeStCYm03WGE4U2tU?=
 =?utf-8?B?RW8wemgzc1l0K00wVmlvTG41Y0hQcC8zNGZGZGk5TWVjZ0JPOHhrcGhxclJW?=
 =?utf-8?B?QXdkLzdBUHFhNjNtTVBYTXpYeWVweGQzdHpOTWZONHJwa3gwd3hNRldxRmJz?=
 =?utf-8?B?OFdXa3RxR3FaVmVXdGdna1V6eGtNdGVpN2RCVnYxb1c3c0RpWFdtOEFTcDZU?=
 =?utf-8?B?UzZ1UFp2SDVzNlcyMmtWMk0zcmg1NTM2cFRDcHFURmRiL2hkdjI1aFgzU05w?=
 =?utf-8?B?NFdCRzdBZ3dRTHRvWThxZHhYalNaZzZpK1ZRRW5ZYjdGYWRxRWkxem1hUFpC?=
 =?utf-8?B?TkwzZzF5aUkzM0J2aWh2UWZSTGEwczJBSE1vb0l2Sk1vemZRRUdqZS9OWVIv?=
 =?utf-8?B?NXNwcG9BbFlweWZDT1pvTkJ2aERRb0lCbVArbjNVMU1jZ3dRd0VaSHVXd09G?=
 =?utf-8?B?SU5MRm5SQWo2RjhXSnE5cTVqVzlFU2RUL0R5ZlRYcjJjMndVUUYwQ3A4cEIz?=
 =?utf-8?B?RUR0ckQ2UG1seDZ3WmExK01WQS96RE16Y21ZVkNKVk1rRlRKWEQ4Q0RMYVE3?=
 =?utf-8?B?ZXMveCtOMXlhZ0s1K24vT3AvN0svL0FvcWtYY240eHYrVUpFM2IyMmlFVXZy?=
 =?utf-8?B?MllLTjV0dy9DQ1NXWmFJQW9KT2lVd1MyN1NRZ2RoYmx2WHJ2VitOM0VpV2ky?=
 =?utf-8?B?T2tQOUZFTUJCdStnMU5aMTVvNUhaUDNaaTBDM0x6UGFxN3lhQklmL0l4Zlhh?=
 =?utf-8?B?VjUvS1l6dm1JK0NkcW1lS3QvZ1I0Ti8vaEZoSlEyOUNnZXk4ZEwvM05UcDZw?=
 =?utf-8?B?cVUyMUVSbjNCK2t3MXFWVisvcVNhREZpMXpxUXhxVDQvQzlCTE5pVlg4NGJq?=
 =?utf-8?B?Vm14TTViTFRmU3JhMG1PQUxrK3VPZXZ3c1IvOU41S3ZwZTIyYnJIUVVDcnVX?=
 =?utf-8?B?S3dORDV5WjVYUGtuY0svSVhtWjZnS2FuNGV4Wmg2QmZUbUt0cUdQTVNiWFNx?=
 =?utf-8?B?MTVSU1Zvak96MkN5aHpSdXcyTWE4bGsra0RJazNSTFkwUzlzTXV3c1d6c1lR?=
 =?utf-8?B?QW41NnBybHJsVndYL2dVODJkNGJtV20yVEszbTBHUWhmY1lDb3hXUUFuc2pi?=
 =?utf-8?B?NGZXR2ZXSFRZWk9VazRCTnZvdzZGbkRLS2U5NVBjUVFtdGVNWFBBVnROdEFh?=
 =?utf-8?B?RE4wZUZtZEpIMGVXRUw2bjVZeVc2cVJsTnUwRFJMNWdEc1dlQ3Nqd1piR1pj?=
 =?utf-8?B?TDdWK3Myc21HNndQaTZFckx1YjRldm9jYVdyVlN0RU5BWUV2Q0JES3hwd1N1?=
 =?utf-8?B?OFQwaGtKREFsODJDWGN1S0kvWGN2QUp2Z1FuaXAyRTFldWRETGhFdkQvc1pp?=
 =?utf-8?B?YXF4MUh4VUswNjJyWDVVUmpCV09TREVMKzVBY01YL3poaUJzSFRIYW1XTXcy?=
 =?utf-8?B?VVZ0NHllYmhPU0c4N09lNUdMdUh3Z0JsTzdGdGlwc296YmRYdVkraXpwNEha?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1958c26-a8d8-4af9-ba8b-08db1bb6bfab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 07:13:11.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQGUAYLW/y/5PEJ13LDqn+b5ivoZqS11oniFfvnKzQWvMoBMbmCejp+pFOPAbX4JRpbEbk4/TzTiCaozwE+QBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8145
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 07:13:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10892

On 02.03.23 16:26, Felix Moessbauer wrote:
> This patch enhances the qemu-riscv64 machine by adding a reference to
> u-boot. Further, we now use the qemu_riscv64 defconfig from
> cip-kernel-config.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  conf/machine/qemu-riscv64.conf | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
> index f1f3e87..8c1764b 100644
> --- a/conf/machine/qemu-riscv64.conf
> +++ b/conf/machine/qemu-riscv64.conf
> @@ -12,4 +12,11 @@
>  DISTRO_ARCH = "riscv64"
>  
>  IMAGE_FSTYPES ?= "ext4"
> -KERNEL_DEFCONFIG ?= "defconfig"
> +USE_CIP_KERNEL_CONFIG = "1"
> +
> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/qemu_riscv64_defconfig"
> +
> +# for SWUpdate setups: watchdog is configured in U-Boot

Is that true for qemu, or is that just a copy-and-paste statement?

> +WDOG_TIMEOUT = "0"
> +
> +PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-riscv64"

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


