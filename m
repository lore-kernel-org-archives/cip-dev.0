Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F267C531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:22:33 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32106.1785162148607785378
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:22:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AC0jOige;
 spf=pass (domain: siemens.com, ip: 40.107.130.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noQF0eKQrBJibBtwjAVdKEldMs9frM48CgArLoRMTdfCvzq2gsW2/F+hf+9RMFI0qACNB4XwFXxsEd1JxM/hJon7sGL8tNYmvR01d+0xkpAh1hQxYIb0VHs1mkfGPYalNbj1y+Cshg6+aIO0QVcl44++Biq/u/7LOQuq6J3iPo0GSksLmkGHraQmDAGscIalWlsUJXD51oskvITQANNhZQq1awGKRGiBedQREcG5UrVhWBrgHhH/Mjb+MwgEjugY9BzE52NZ/yw//oDNjgRE1tjny4fy/OKxJvaHZkKCEPjSWra302nTdalEyd5gcl5wylAtN/eW7VsYU1zeezzAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1zvUorqhitmv0sDazWN0p2iGZKF1JaRhhhjR5zEKN8=;
 b=fakvPN11Sbw8tJdM4+DnICqA47ei5RcHqlTrpVPWFSePbAi1vd2L8ppN+aXd+YfZ/S3l1ZYw5mXfL7sT9+pLE84S7TrQCP4sKvVoeBoj6tKZkTl4X66pNevCxIg+XFRlN3MyOk8XrYDt20VwBe0dXg1E9T7ykNqyvh2kWGKuq8ZmN3dGtpgAQaJDvjVOBiO7uk+Eg7njBE+bcT39qmFz6+PmxD2i24R4N8avoYTLxcR5UDwzfeBP92s+AMjXOIuvE+5d+kJaP9cl2GJErA0yin1Fxqu6EoP/0A2JRwFi6ScJl2CJMBhgaS4CeiIXTsiHiFoJkKqyGXpLmCiwzSd4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1zvUorqhitmv0sDazWN0p2iGZKF1JaRhhhjR5zEKN8=;
 b=AC0jOigeoyPkJRM8eWyxq4SiRgWG8SFlBVQ5SHtn2KhhlL9Y+PTQSgqgkwDn3m2tLMdl0oxymplCCq6d37Vokcbk/mAdSp+EUkGwxu1gnYze8nI/apIyI5fD0XHqYYZ943tqvJjzL5OIuyoaHpfexeQ2xNiBVs6/dgifLkzdpXD/VBTp7po9pPggRo9RcvbFe8rRSpFlNRkUCIDVVAFNGW2LyxeItRz7+4BwblWpSxfHdXzyhIqBqKmkHkFV1gSopYIFd+IyUFHdPhpjECa/TeKDW9BODeMZJEEHLkKge+z1IiBV9hkK6ZvQiyRam8U4+ogRngQFDHm6TNCS8B6Hsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:22:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:22:24 +0000
Message-ID: <78db73e1-8e44-453f-b759-07c20e374b95@siemens.com>
Date: Mon, 27 Jul 2026 16:22:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 07/14] Add kernel hardening to
 cip kernel build
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124038.3633611-8-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724124038.3633611-8-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfc1e24-a38d-4b37-6654-08deebea7a95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|4143699003|11063799006|55112099003|10067099003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 
	qZN36Gj9ML0MW2b51OvaTFmoH9kqnyPPjwfAk8HN3iSmgYr8B61lqkWdWssQLNHWfFAQKi8M+nqqN/dMtTWMHr/fpm3CpMXx8ejQl57QFRaKxjMPQZZyJ14VwlCU2VTHAmlQ2tA7j0cdRCEs0AlhPmvGqa4MvNcTHPS738Nl8tVgQDyLHW5ISBGn3oySDGdrCfnvzkb2Q2/c0GRYMsL2s0IXsdRtXfwmFdee3WaRUg4IBWeshwQ4auOOlddIR5MSoK11//PHqJDj7v2EF5jEDihEG9mIxmxOOdSHEudcL+xCAHi8hTbj3yqT0pVjUNW4EGUH//YdzahTDrl27YTZrweVngj5PjOkew9r2SHgVjNXVntysPanb/1FAxh7TlmmYy/aQE5wY4AxIY8gorfHcMZd3SK4rmJwbwvct4c8RXvJj5ir+yG52+uUHLis8nhsOM9Qim9QfdFU6nTeYF+2t5LHW1kdiXDE1y7INr2iO0uouuBYtdExx+VR652p4BstvZFrp2TLBLKQeCJBug8Mr9Q3WjfGs9qRX5NL8QDuJ5xSJtgiDJjUfBjsjvbXRZnZmVBtMyKeWsww9wj6QTBEwG/hgPjwFJzSf9f3RFpZ4W6rjfN7q8t9uaACVDRQ1/1N8OXHmyze3Knd7G5roRFWO99P4Wo26llFwfttf/LaGXo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(4143699003)(11063799006)(55112099003)(10067099003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RHBhT3E5d240b0NCOVpCMTMyT2lGRUlrSEJFcnozdmZiR1pEaXRVL1FWM0Qw?=
 =?utf-8?B?WDIweDBPNUNFOWdrVlZBSWFHckY0dkVESng0V2ZpRHY3N1R1SUxJZXBFYVpE?=
 =?utf-8?B?bnZDOHl5a2s1Ykh1MDhuc3JTYVdyVnkxZE0vcjVKWmdSdkR2MXRxU3hzY1FB?=
 =?utf-8?B?biszeDJTSndtbVQ4RmZvbndZREJVMlJyaFE5UXpXRlVFNUdJSUgzb2I2UWxI?=
 =?utf-8?B?MUhXeklJR280TVRja3JMNGhsbU1SVEdhdkRyV2JLdWhaK1JsMi9FUU5sckNW?=
 =?utf-8?B?NWJHaWE0STYwSE5BSjFLTzJ3Z0JMV25yU1h4MFNCRkJ5d2doR0FiZUtST2lo?=
 =?utf-8?B?RXdwVi80NVFZZnVlaVdDOXp5a0l4RlZXVVpiT1NEQW51aE4zS2wxUWJhQ0dw?=
 =?utf-8?B?dVh0OCtwV1BIencveWEzclFXWjlKWmpFbUQrRGFnQUphajNJaGpMUkliK2hT?=
 =?utf-8?B?ZFI3V05BM2NNbnBacTZyUmJRQzQvbFQxNlk4eE56SEtBeE5TUm1QTzhscmEw?=
 =?utf-8?B?WDNyT2ZxNnFaNnBTVm1MVTdoMmNPR1FjZ1luMFJ6dFRLVTdkT1NuUmI3YU1R?=
 =?utf-8?B?T0hWcVBtK09BT2Jyakp0NytydGU0MThvRDV1cmZEZzZUWTQ0UU92L0p2ZlFr?=
 =?utf-8?B?MnQ2Vk9MeC9qYUJJc0dEWmhKY2E3bnF6V1pkaHdkV2dwYmFjdGVMVjlaOWlw?=
 =?utf-8?B?K04wb0FFQTFYaCsyakZaSE5pYXZ2TUhMSjZFUXVkczVCVElIQk1IMGJWS1lv?=
 =?utf-8?B?ZnJGdE13bXpLNzlaeVgzSXlBbVl1L1Nwd0pvZDdOU2hBL29TMlZpRDV3TVVo?=
 =?utf-8?B?MTZjeFJFU0xURzFmOTNiWmlzUWRRTXRodC9ORHVnUmJlQy81MGVtRlFRbXBk?=
 =?utf-8?B?RWxrTDlzNjBUb3Rpa2xqeisvc3lTaStPZWpoRGRCb2F0d1lBMWNxb1lLZjRX?=
 =?utf-8?B?bkdjbC8rV2hWZVdmaytQWS9XY0gyRStEZFJ0OUl2YkxZL29KcHFlc0FYOENi?=
 =?utf-8?B?SG1zSDg1L3ZUQmw3TDZxblFOY2lrUzB0dEhzM3lRbTh6VFVLakUzeGxmRTE4?=
 =?utf-8?B?MC9RSFdKWFpMSHB2cGRRWWg2cTR2Y2plNG51ZEkrZUQzYmZXL05mQ09vaWdm?=
 =?utf-8?B?cEhZK3NPcVpzbWNvVzVVanZDeC9oelJNOUMrbDBhVW0vdzQ4VDdEbGFiNlJu?=
 =?utf-8?B?aU8xVUwwekRzNHlFRGVRSlF5STZCQmRjS3VBQUgyVXRBTlZlQ3R3WFg2U3VM?=
 =?utf-8?B?RW5kRWgzRm1FVThldUF4ZHBwZ1FQNzVVaGtvMmdjWmZLUHltMUtpM0k0QmdV?=
 =?utf-8?B?OTN3NGxDRDBtME5UMk1DdEk0UCtuMUhJdzkxSWFHL25Ib0RhU1M1eDE4UVN5?=
 =?utf-8?B?dzRlTzlUL24wcUgvM3dISlhabUIyTGNLVkVMSTJHVVJRSEJwWk92NlFPRnlt?=
 =?utf-8?B?bVBnSGJpTXlROVA3b0cyRkdFbmhwd3ZjQS8rTTF4QmpCbU1OU200L09VUFVH?=
 =?utf-8?B?cVN5a3FWK21JWDZKU3Bjc3ZRL0RQeU8xajNrS2szeXJwRzZ3NEE4VEY4QldZ?=
 =?utf-8?B?eHVjQUU2bFNleE0yTlhrU2xxbkorUVNBUFBCamZQUnl5M2lGYjJVTFNRT3d5?=
 =?utf-8?B?WXA4Zi9vS1krOGoyVS9jd1hOL1p0ZWdFVllzU3pxdGpBM2w0eVJhb1AySWVV?=
 =?utf-8?B?Z1F5dVozbEo3UkxBUFBUN3VPTTUza1Mwd2s0QTVvMmVmTWNpQzNsT0k2RzRw?=
 =?utf-8?B?TXg2dEZ0NkU1cllhZWwwc1VYNEN5L3c0QmZQNzVsOTdQcXZiZHVkNEpXWHdJ?=
 =?utf-8?B?ODVDVE1IV1BjWmN4ZmQ1UmVYV2hrM0tNcUczSzVnQmxVMTV5RTlWUFpFVUxr?=
 =?utf-8?B?dWdZN3ROK1pWb1hubHhSL0hTUXpVMitXOFNVOFF0Nkl4Y0d5blhlS1AvdTM5?=
 =?utf-8?B?bDdPZCtQcEd1cmxmOGRiQSsxQjlvYmk4b1o2Zk9GOS9STXFvOHZxTUNsSW40?=
 =?utf-8?B?UGE3MktuNGUyeFdQZldnZWd2RWFaVXlRM3hHS1d4YkdRMmgvSXA2RmFPSUln?=
 =?utf-8?B?YlNlVEhpMVJ6YVMxRHZPU3BGUzdFUlNXdCs0ajQraGlaelRSNmdkVUhyMHBu?=
 =?utf-8?B?VDVtQmlwby9hclV6NERZa1d2TCt5Tm5WcUtMMU5zTWVjclMvUzJTeEZGZ1pt?=
 =?utf-8?B?N2d3RTV0anhoc1d3TXhTam1qVVo1bjhCbzZXMG5qRjBWOHZ5cHliMUNPMndO?=
 =?utf-8?B?V0VWMXNZWm9QZmtpQUJld3lIMkFsMWpqbThHNGUrc0VJVFp6NGJmc2FOUk9h?=
 =?utf-8?B?S1R2THg5U1RsVVlnemNvSjhrR1c5ellWc3JpKzY4OTZpR2RwS1pmakJtVGFa?=
 =?utf-8?Q?gSiNV0z8VYw3FIKU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfc1e24-a38d-4b37-6654-08deebea7a95
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:22:24.5636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMDj51jJDW4Q2eSea7ZrLmmaeVQDbzk3v3Z9dwh1FKR+hY4E8uR6nwngf7cimrPE/TvymxNKSIKevxzmVMzk5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8146
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:22:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23772

On 24.07.26 14:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This enables the use of the hardening kernel config snippet in the
> linux-cip build.
> 
> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-common.inc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 6533523..2519791 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -16,6 +16,7 @@ inherit linux-kernel
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  
>  require recipes-kernel/linux/cip-kernel-config.inc
> +require recipes-kernel/linux/kernel-hardening.inc
>  
>  KERNEL_CONFIG_FRAGMENTS:append = "${@(' ' + d.getVar('RT_FRAGMENT')) if d.getVar('KERNEL_NAME') == 'cip-rt' else ''}"
>  

This could actually become part of the previous patch already.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

