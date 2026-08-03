Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF31C55175
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 08:57:38 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39113.1785747457194665334
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2026 01:57:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lYZTjBMV;
 spf=pass (domain: siemens.com, ip: 40.107.159.54, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0kAI/HDK9w1ExhW7i0DtuRz7kiC7PWk9y8CuduI1jkJ1FC6tF+JcpKmHfBQ+pfdq/5qaALt8qnb+LUbhSlo3yVi/KZ6cVP9HdrVWYSHHtKYNe835081XYPeogbyup8K/97EH/eKTGPhzPegryl/xhemshAH2iL2QdMzruCJ32f+cNKBgKkHl/8ef21dRd9yILYPR1IZaI83FxrFY78lbwEoaw427AYqGY7nWgiRPrNVuYfLcvR9QkhRclf7oo5PMnz71QtgNZKm/crLeE1BU/Z9GNe2O4u5kjcKHDceintmc1vnYsJVDGBpPakAMV1BtHheOfSO4AXXdbSyQUXAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8568UXtLTdJPWAA596ZkUCPbFjYkxzD/c8DVjoAZ9Z4=;
 b=D9Q4EWJog6U3qDIYfw6+6qnJL4HZFhCWBzCSp1azGb6UGkLfXmr49UncE8OB7zKWgC5ZdMtpi1B5ieaxWcWk0gx6D1BxdkBw0XTd+4c9HuYVmXHvO1qNaYKM7TCQioBfYTS9Z9/u222FG9Iu2ChRHhgm1y1IbRtn6UsWuSleiQLY31cCbhxKWq3WGL3dIDT/mSeiq3nggGKTmdLinZskYzoINZHizPqeNoX+ppHVCx7YTcff4CL7HbccZXj8uVreomWtw19PdX4ufnHi5w0LxYukUweNhJb1DcofpR5DF8edbIE80l+fPsPXJ4ZLAom/2zCxoTeufUV4NEz3dknjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8568UXtLTdJPWAA596ZkUCPbFjYkxzD/c8DVjoAZ9Z4=;
 b=lYZTjBMVL2LdZLfuGjHEYHRd+W3PL17lbaTv5TuMyiCFVss6kY4RdoL4K1dhXHpvSCt6KY+9mBUUbeZNhqIEqSElDj6dy0vIL04077OHQ1v17j3CVgsauZ/jhytGc6pKNTopLW0URbupeVq9mZ8uCI6JNYSA90Fp/qJDQHPJKq3a2TKrKBvTnonlyCfuw59BoEK+dWVuxq1PCsfwyuKVQPkk6CB/zNx7xGPutzRFwH8sImKM28J7+1OfCpyfwtGt2U/G8CK30HpPhgJfPNFj+CWc0brFt2HWV6VMYuVg6QkyOY4CSw39c+160Y1J92tW34L0f3hLr8bC9khh/KDfeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA2PR10MB8772.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 08:57:32 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 08:57:32 +0000
Message-ID: <5c17fbfb-85f0-4622-941b-74325dcf15a8@siemens.com>
Date: Mon, 3 Aug 2026 10:57:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 3/3] linux-cip: Switch to
 out-of-tree PREEMPT-RT config fragment
To: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>
References: <cover.1777994730.git.jan.kiszka@siemens.com>
 <0ef583915456e356671811c01fa57596015b71b0.1777994730.git.jan.kiszka@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <0ef583915456e356671811c01fa57596015b71b0.1777994730.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA2PR10MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: b00dc527-0f24-4e43-50ee-08def13d414c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4022899009|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	55l8xjGT2/Le21Apd56pY4o15f8eORLqKk9+Q09IrkyEXaM4oGdKUj68g0TvUTxpIHaNfLzXIkRAv/KY6pdviuWS5TIETf5Tiz79SgfMb5gSaJlEfPrnxN4BpDs5km3t6DFezgy4gSCw3XeBt3vi1OqqqCYTZOsheVib0yepEEe9YL3fiUbNpDohSJGFlMsB2RSBcF5ia4olrUmn5e751XpZ+9Dzz9aBxzvPnGWCMFUcphbla5B0/NjwORLL26xW9EAkly79sH6E8RRG/dL75w9oJV+AhfPmKLCo/nWrKiALyv+cC1EXsh8mVXcIspKkHxviBV3sbe6Ws3h7ol8innTQVUrG3a1Xk3vjs0uaMGknJ6PArHCSAVkjNr2eQ+brBwuwCmmkjNQPlhsT4Z+FMQTVNGYHzn+Hh+ItnOG7ggmA91wnQ5VJiDwR2sEPqWWLaBYzj9HapDA4rA2a1lqHAQMc13sZhIAVRZ9kfQVvkD7M+z05OslXYsz0oGijYcXTDTfSKmCqT90ZZA4bpyZccNA8m1rEgNO4vucHVeFNWf2ajQ6xKdSznSTkkSg0SG6Oi9Uqpy+aWgw0HVt4Iipj/iZYxHSTqYQL+8fGIwiqa3GFIbRj/iB7kt9GdAQxaXw3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4022899009)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHNrSXdyZ0p5am5YZ1Btc25uRmEzMFMwQnU1OVdYdXNINWF3QnhZRXlCZlFV?=
 =?utf-8?B?b2xOelFNVkFMWlUxTFhEclE1SENIM1RlN0tQb3FEeWFpZVFrQm1ZTGgxZ09S?=
 =?utf-8?B?SWlFbDFOY1JrRVhNZ3Q2REhwcEs3S01UcWNIV0NKUjlRejJYNTQ2c1ozMVNW?=
 =?utf-8?B?M09qR0dtOVhla1JCUUlNeUlvQ2s4a2ttTzlrL1JIbENnYXI5bGVPalR1SUh0?=
 =?utf-8?B?YUdUWGxsdGN1SkVqcXZvc1Mzem8zUUJ0TnhJMDVwSm1pSWp6NFVJeVBJdXNZ?=
 =?utf-8?B?TVk3dzE5VVpCZ1B6WThKRDBZOFE3cGtWZzB3a1hPaGRZcEt0SEJMZVU3RFJV?=
 =?utf-8?B?TnFEV3ltQUFmS0lYWXI1RS9BUXJBUjFWN2x1Sk5PeTFBcWx6Q0VhVHV5M2lV?=
 =?utf-8?B?YlMrVEpXR1lLclhjVWdWZGFSNW9oSG9PemtnKzJJLzROaHJyUTE5R1hwbm4r?=
 =?utf-8?B?aEdDWm1RdWxyVWFUMjFpWEZLbEphL01qSXhrNlMzWGdLQllyYUhXeWRsWjlJ?=
 =?utf-8?B?cFQrREN0MlZoYjNmK00xN0ZMdlIydXFERTFuQlhDNDdPSXo5K1IwZHFGU0Vz?=
 =?utf-8?B?cnVmQnR2V2pGTzRpa1BNT0VuN2hmRzBOVjNuR0o0MXRmckI2TjNIbkUxOFNv?=
 =?utf-8?B?cGN6VG5FR2xSb3YwRkFmekwvM3pTaWZrVk1hcVNmVFVnblVOTWgvTmNmYmc0?=
 =?utf-8?B?bm1LQmlPT1M2czc2WWM5NWpobFowdVFWRS81bGZWcVNjbEJBcHRzd3ROaGI4?=
 =?utf-8?B?R3kyWWh5SXhabUg2TXYrQ3RETUlDYVZqcE1NS1JEakhHSGljcVc5VkVQR0hX?=
 =?utf-8?B?MVcxdFBTcGlXUkhxcGJkaDZLODFaSUJ0SzNSRk1JWFdLU1A2NEtuR0NDOThV?=
 =?utf-8?B?VUlVbWlSOVpnZjduVExTZzhPT0V3TURaNG1PcE9JeDN2UTNrdlBSWThGQkE5?=
 =?utf-8?B?Sm1XOG5tQnRzYUR4Rjhja2RyTWtDTWFDa2x0Z0pRZ0V2ZFJNYlg2cXdUODYw?=
 =?utf-8?B?MWNJRWFxSGNlcDlMdFFsbFlMUGozUUZUMGsxUCt1bVdaMjg3SXFtL3JjK1A1?=
 =?utf-8?B?R2o1TDk2QnhOQUdsNnJ5Ry9DOWY5Y3ZjUjU1azVFRXZZRjFJbVhiL21CMnNu?=
 =?utf-8?B?VDhRd0FDQ21QMGpaR0VDUDhDdXpiMUJzT20xaWZWUFF2MnpUb2t1cnlxNWhy?=
 =?utf-8?B?K3JiZUY1OGlBWFhxdnl1ZkFmQjZ4eU1YY3dOV2xzSGpQYUtjVXo3cDJleUtT?=
 =?utf-8?B?ZzFFOUpqQnkxUHp5eEt6NGdhY21YWkV5T2dUNG02TG5pSERaclpMYUJvR1Zr?=
 =?utf-8?B?Mkw4WWNHb0RJWmRnWEJlSkdBSGpnaGhYSFNBcGgzbDlPZkJxc2FPUkdGUk5i?=
 =?utf-8?B?Uk9ZNzlIYXoreUJmMDBOMEZHb2c3aDVtcmZmekJxdGpqakVjMjFZK3ZUdm9J?=
 =?utf-8?B?cUJUamFPQlB6ZzF6MnA5dVBuQU1XWmdkS2I3Wm9VVE5DaEttb3Brb0dCb0Nu?=
 =?utf-8?B?b01LZXNhcG1YWVpUVEYwNHliblA3SlVUcWxhWm9rS3k1TEMvN3RaeGptUTBa?=
 =?utf-8?B?ajU4czQvUXI2SDFqMVpzR1d4eHQxMUlyZGc0bWtrbDI2RWtYOW80dU5JenZS?=
 =?utf-8?B?YmdvTDJteFdNK1gzY3o3MDN4UVVwTXlCbDJqT1N6ckNUQlZSK05YNy8xcXI2?=
 =?utf-8?B?aDVZTFFNSXd2aVVYbWs4aUdLc09UL2piK2I4WERQazlBYmxudVBGVlUxWUx6?=
 =?utf-8?B?a1ZpcmY4L05SWUJNMS8yTTFtTys4aE1UckNmUmY2TGIzd0lxMGVScUlBRDdx?=
 =?utf-8?B?MHFqdEQ2SlVCc1FQL3l1dDE5RzNhWHRBT0FDOXFCVFlXekNUb1UvVit6czN4?=
 =?utf-8?B?UTBRNXhvam9VbWZyQnNvOXdmclBYL1JSd2IxRTk1NlpOZWJEQTJobjVlK0VV?=
 =?utf-8?B?Sm1TY3FGWG1wbEV4aURKMnpMMGlaUy9MQlloaTA1UDF2VUsvbktxbS9COW5B?=
 =?utf-8?B?dmhZNUpEbHd6LzBkSGg5UkJucGJlMUlpNWdTV2d6ZENVVlRjSDVraGtONG1p?=
 =?utf-8?B?VUFpTnFlTHNIbWNSZW9rM0thUE1jU3BRd2Jkc1Q2RUlRektpSzVQbEwyTjNF?=
 =?utf-8?B?ZWs2eEZLZTFPRHhpRWNCNGEvUmpKZUpXMm1kT0xTcDFibitqckdmN2FyWEla?=
 =?utf-8?B?VzU1M3RIaEgvTTB0UlVDeWw0OTFHVDQ5VjFmT3lDd1RYVWtuNDFLc0JBb0wy?=
 =?utf-8?B?bHNiU0oyQmp0ajlCT0ZEamQ3SUtaV3Z0MUxjOEljam5BMWxWc3A1NlBYRnNK?=
 =?utf-8?B?d0x1ZFFqMkdLd2dscHg1WitoNVlSV3dlQjBTUHhPYUJ4WGhLYldWV3MzTFVR?=
 =?utf-8?Q?iS3Jv4PG1LCaVldw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00dc527-0f24-4e43-50ee-08def13d414c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 08:57:32.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXcRfd5E2c7eIzP1cI5k7/5pJrWhQBZ7GhKv5apuWvTlk5pgDWB64xkBD6cyu3xZgkWd5SqcaXfAK16nC5cHvWVYOCrcXYDZ3trepIirKxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8772
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 08:57:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23852



On 5/5/26 5:25 PM, Jan Kiszka via lists.cip-project.org wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We are now maintaining the PREEMPT-RT enabling config fragment in
> cip-kernel-config, for reuse kernel KernelCI. Switch to it, just bailing
> out in case the user asks for RT, does not use the CIP configs but also
> does not provide an alternative RT_FRAGMENT.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   recipes-kernel/linux/cip-kernel-config.inc |  2 ++
>   recipes-kernel/linux/files/preempt-rt.cfg  | 30 ----------------------
>   recipes-kernel/linux/linux-cip-common.inc  |  9 +++++--
>   3 files changed, 9 insertions(+), 32 deletions(-)
>   delete mode 100644 recipes-kernel/linux/files/preempt-rt.cfg
> 
> diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
> index 34fb354a..32cad6c4 100644
> --- a/recipes-kernel/linux/cip-kernel-config.inc
> +++ b/recipes-kernel/linux/cip-kernel-config.inc
> @@ -32,3 +32,5 @@ KBUILD_DEPENDS:append = "${@ \
>   SRC_URI:append = " ${@ \
>       'file://no-module-signing.cfg' if bb.utils.to_boolean(d.getVar('NO_MODULE_SIGNING')) else '' \
>       }"
> +
> +RT_FRAGMENT ?= "${@'cip-kernel-config/cfg/preempt-rt.cfg' if bb.utils.to_boolean(d.getVar('USE_CIP_KERNEL_CONFIG')) else ''}"
> diff --git a/recipes-kernel/linux/files/preempt-rt.cfg b/recipes-kernel/linux/files/preempt-rt.cfg
> deleted file mode 100644
> index f5583657..00000000
> --- a/recipes-kernel/linux/files/preempt-rt.cfg
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -# >= 5.10
> -CONFIG_EXPERT=y
> -CONFIG_PREEMPT_RT=y
> -CONFIG_RT_GROUP_SCHED=n
> -CONFIG_CPU_ISOLATION=y
> -# <= 4.19
> -CONFIG_PREEMPT_RT_FULL=y
> -
> -CONFIG_DEBUG_ATOMIC_SLEEP=y
> -CONFIG_DEBUG_LOCK_ALLOC=n
> -CONFIG_PROVE_LOCKING=n
> -CONFIG_LOCKDEP=n
> -
> -CONFIG_CPU_FREQ=n
> -CONFIG_CPU_IDLE=n
> -
> -CONFIG_NO_HZ=n
> -CONFIG_HZ_PERIODIC=y
> -
> -CONFIG_HZ_250=y
> -CONFIG_HZ=250
> -
> -CONFIG_SUSPEND=n
> -CONFIG_HIBERNATION=n
> -CONFIG_PM=n
> -
> -CONFIG_SLUB=y
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 4569b897..65335238 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -1,7 +1,7 @@
>   #
>   # CIP Core, generic profile
>   #
> -# Copyright (c) Siemens AG, 2022-2025
> +# Copyright (c) Siemens AG, 2022-2026
>   #
>   # Authors:
>   #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -17,4 +17,9 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>   
>   require recipes-kernel/linux/cip-kernel-config.inc
>   
> -SRC_URI += "${@'file://preempt-rt.cfg' if d.getVar('KERNEL_NAME') == 'cip-rt' else ''}"
> +KERNEL_CONFIG_FRAGMENTS:append = "${@(' ' + d.getVar('RT_FRAGMENT')) if d.getVar('KERNEL_NAME') == 'cip-rt' else ''}"
> +
> +python() {
> +    if d.getVar('RT_FRAGMENT') == '' and d.getVar('KERNEL_NAME') == 'cip-rt':
> +        bb.fatal("No RT_FRAGMENT provided for cip-rt kernel")
> +}
> 
This will lead if cip-rt is select in the downstream machine config to 
the following error messages:


ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip_6.12-cip-head.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: Parsing halted due to errors, see error messages above
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip-rt_6.1-cip-head.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip_5.10.258-cip74.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip_4.4.302-cip112.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip-rt_6.1.175-cip57-rt30.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip_4.4-cip-head.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip-rt_6.12-cip-head.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip_6.1-cip-head.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip_5.10-cip-head.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip-rt_4.4.302-cip111-rt61.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip_6.12.94-cip26.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip_6.1.175-cip57.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip_4.19.325-cip134.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip-rt_4.19.325-cip132-rt48.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip_4.19-cip-head.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip-rt_5.10.254-cip72-rt32.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip-rt_4.4-cip-head.bb: 
No RT_FRAGMENT provided for cip-rt kernel
ERROR: 
/work/build/../cip-core/recipes-kernel/linux/linux-cip-rt_5.10-cip-head.bb: 
No RT_FRAGMENT provided for cip-rt kernel

Was this intentionally done that way?

You can fix it with a linux-cip-rt_%.bbappend but normally downstream 
wants to use only `linux-cip-rt_6.12.%`.

Quirin

> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#22887): https://lists.cip-project.org/g/cip-dev/message/22887
> Mute This Topic: https://lists.cip-project.org/mt/119163092/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


