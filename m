Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AA4C87FD1
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 09:07:54 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.3])
 by mx.groups.io with SMTP id smtpd.web11.17334.1754384867406033088
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 02:07:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UPSSgsJF;
 spf=pass (domain: siemens.com, ip: 52.101.83.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siPM2QOtqhr4s+37mzIG12FIguPwKVysg/Fb0ykFHeQdBdR6dEEA9Msb2Wfh+9fL7W2+Y82oJrMs+w9klrRt3UnKYOIfg4uRav4dYZ2pp0e67zgzSk2eyxx/thgiceS1PiUYIy8vqNLkwNwC8DZYNJQL1v+GytaqkzOg7alJd4UT63cZka45kTwDzSse1qLvrD0vRsYbRGDLTkwTIk8kQfRgSUU6YB6dynwlURdNhQQbKzm38GwNKIh+Yp5FG6wWhoO0mLUzecQxi83nFq6Wgj+qm+BwfWmy60kPxtIkZ1TwlfO+5seXYCFtx1JKblt/JKSKWYWs5rOTtqT+3B8lDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPwOprk36KYXVAXy4BlYMEohRIsPAVcTFTdR/Pktmig=;
 b=mH+qNQNcJduu3YMRq1IQbj47mp9Ig/Hom2DAEwLCiLcCnX349fU6kjOd/iiQPEF4zKzO/U173It7/fWfMm+g6fxppRLEkj0hwEc6IX2n7V8IGFKomb4h9r1quLjsYOh9Ydpv6Yoxi/CeGx2a/EHIw/6xebm6n26aYMCvQ+1sbENLF/Yh90Sq09mzba8EpaBPFHWutnib/Q3baROrQKLJ/562hUpWz/0sja7ggvikB6xjsy1DDRqpZqnuhrAZ57J+wAKBOO/WoS6hDbntyWh8h1wZd4q2UN7a+j7sM+I/zd3vFpketexdWct739Mcfv/sO67OfuRpN3ZG9mpmjCoNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPwOprk36KYXVAXy4BlYMEohRIsPAVcTFTdR/Pktmig=;
 b=UPSSgsJFhgEbZdRhLxwM/1N5KThD6+lU87lW25eLtSsO5WGbA1cKH6YlRMXwRaKvJBuGYFMp4dfOEmIfeBL7fqDzlvtKRXm2LoxM2pJY9IzsGRZRw1EIfmJ2ieQrzjC+a6tsXpsBOcJcWYDNL902crXVpZcosryKOkhZCIK1caYu1lHqDeKVNE1gmezqCmU/7+awsNjzFEsTMHBJ+o1CV7HBMkBi5HUaRvKNOUWBHUuUBNcVsATCRBeMajbBS83OTZI3+FmiJXXTcds4OpdHJjTX4by6iu0JauhB4tuaF5nc0UzrMYgxc6oC4rt4AE9Ld2xuhKOa0Zd0396OkD7gpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 09:07:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 09:07:42 +0000
Message-ID: <f4e24a42-aa49-498e-94b5-b6a5193f42c0@siemens.com>
Date: Tue, 5 Aug 2025 11:07:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Kconfig: Add config NO_KERNEL for kernel selection
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1753432849-18257-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <1753432849-18257-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1753432849-18257-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:610:b2::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3588:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b574833-3b64-411f-08ac-08ddd3ff88d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WFBCSDNpOERSdnBBbWpwMENWSHRpYnNYL1lTL1JKL3J0OGVPYnZMVEU1a2FS?=
 =?utf-8?B?K0VmNWFqeE45OGc3bHFqY2VmajFqUXdJd3NWZ1NhcktvQUtkTVhLblFYMGZY?=
 =?utf-8?B?OVNrOW1FejArMnN2eXRubDFlamVlTGdSMFF6dHVIRStkWGdXNVBGMGFjRnlp?=
 =?utf-8?B?d1RoZXdyWDdjMjl6OUNTRkhKeHlxLy9NVmVHcHBTQnhMb0xmQ004Wk1USnUz?=
 =?utf-8?B?UWN0L3ErZ0NJYUdrMFNkQWxaRzB3eGl0UG8wWm9hVTh5cjdPV29zV0ZoN0pn?=
 =?utf-8?B?WWV4SWZoU1Jtd01Lbmw4TjZNVFU0QWU3MkM0d3p6R0J1eUhmVmI3WEwvQWZh?=
 =?utf-8?B?ZEJVSVdacjFENDFXMFBrMitKOUJhS3lweDEvQ2p1bVAzTnRFOEZSYW9Id3ZJ?=
 =?utf-8?B?Z3VXaWNaTDRRdzFCRlZHbjZtd0V3NGdsN3pvUnJYb3U3MVJPaWJhYXk2VFhF?=
 =?utf-8?B?alpsMUlvRFRzL2ZiWk9ib1RiQnVrRTRpTjB2ZE9SSXRXSXc3Wm8wSWZIeGd2?=
 =?utf-8?B?M2xpYkNYQXl0aTZPdjM2eklIYkc5Q2FndG0zTUo1REJPWkVBTDFBTFdaWWtI?=
 =?utf-8?B?ZmZUZWlyMjRxUGJIRTRxR01wNGw3TlBpM3BCbk1jM09sUE1CU01yM3R6eHFN?=
 =?utf-8?B?a2NEdTZuVnlWWHZYLzJ1bUtuOFFxdFJab3M2Y3FSSHpuTlo4cU40Z0NkMUFy?=
 =?utf-8?B?UTM0MElGSitCc0o0NGhQeXRZUHpwZVpiUGVnd0E2dlFJTmdKZDQ3MTVJanI1?=
 =?utf-8?B?QkV3aEwvU0Y1eExUZ2swdFMyM0JHSy9rMWRMVjY5ZnNERHdrK1J1SXV5cXNX?=
 =?utf-8?B?dldlRDUwankrSjZQclNQQkZ2aVp5Yi9OcXUrUkJGa2dPZ215SXhkeXhlMVFB?=
 =?utf-8?B?ZmNxRFFZbWpGd3YxaVNQUjJWWEN6WlNHODIrcmN3c3gxdGlMakp3QUFMYVBl?=
 =?utf-8?B?R0F6Nk9VOTUrVHRjU2FUNjIrT1I0R1U2eFhvMFR0aTA3QW1oVFd3R1Z1YU9l?=
 =?utf-8?B?T3RiTDBVZSs0TVEyOEp2c3RIOFRoc3lvRkZvbndsZUJ6bHkzTWFGSjhoaWpx?=
 =?utf-8?B?UEZrcmpiSGdpQnhsRlhKVVpFUUpTakpMeGtXK0l0UWZtZjFRRFdUaHJWWXI2?=
 =?utf-8?B?VXdrRXlwVlREVHplazhiWWNYaUw1UkFtdFgrdTNiRlZuZEZRcGI5UkI4bFJI?=
 =?utf-8?B?UFR1aWJGY3BqTTVXRzB0NzQ2YlU0bTRRY2pLUFhBbVBxakRxbUxhTkEycVlO?=
 =?utf-8?B?cWxhRjMrMmFXRUphRVJpMWxwc1VQRHI3R2sza0s0K09LQkJVMXpkckhiVVFE?=
 =?utf-8?B?UHJJZ2Y0M1R4U044N3ZJTEhOVDhWYVM5MzdnczFaK0lEcVEwOWZFOUFBT2xM?=
 =?utf-8?B?amxPcUxhM09UMkFBVC8ycVlvc0hDWDZRZ3BLZE02aXJqMnN1T2Q4alpPb1lU?=
 =?utf-8?B?UWhlOW5pTDkvd1VJL1hUREt4OWFYQ1FQZVgxV0xvMjJJVDVhV3dQd3dnUnFi?=
 =?utf-8?B?bVowSmVNd0VKaU5ITHJ6VDlxTVJyeVpUMXgvR0RDam1DZUxBY05nYzFydVBt?=
 =?utf-8?B?ME9tOWZid01hTE9KeGRyK3pDRHAwOHpNcHVWZVo2TFRmbFFBUmpYaG9rcEcx?=
 =?utf-8?B?SXkxN3ZSelhnU2thY2ltZThVL0FmeGhkeEZhQ1VwQkxxQUEyMVNGSVQ1dWJO?=
 =?utf-8?B?b3NjNytwWGs3M1YvS2MxdGlVRG45dzdEcGk3c01Ba0Y1MGxxZm4zbzRpUHlj?=
 =?utf-8?B?RDZPSCtTYVVqVnNKa25PZDZIS29UVThLM0xIOGMybnJHcEZ3S1NCNEI2NVZv?=
 =?utf-8?B?bERMbkE1dFByU3QrM2FqYWZ0THYvWEdpcFhaMTh5eCtQUkNNZFBQTEQzbDhZ?=
 =?utf-8?B?M2R1d0N4aVRqMWxKcWMwSGJ0UmtuREU1L0JOUjlHTXpSZ1lheUlWSVcwSE13?=
 =?utf-8?Q?UMLs78Bwf20=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ak00WDRUeHpKNkVHOUdBWG9JeWFDSlFEeEJ1UDZKcmRDcEZMZHlPbGpEMVMv?=
 =?utf-8?B?ZHFaN1kzSWdtSnR2SGpNZDJ1eEhxeDVBWmVnSHVLejNmOVFlZHVvWmhwdkRM?=
 =?utf-8?B?NVBuWVhxaVROemEzWmRlZjRoV01jN3MvaWNCUjBBVjR5b0RkdlBYWDJWMHpv?=
 =?utf-8?B?aVZSS2JVVGgrOGlFelpBQTRwdFd6YnB6cW5pSnRuSzNaeDlYK282bk84WjB3?=
 =?utf-8?B?QjB1YUc4c3ZheUw4TW5rTzUzeEw0bVIwdzZMMWZOZ3ozSWZQUGtsdGRGSFNu?=
 =?utf-8?B?Tm9vTTJwVmxUV1NhTVJtNVI3eHpBZlhVejRjOWN3bTFWSFUvOHBmTVkxbFZJ?=
 =?utf-8?B?T0RpaVU0eDFvWjdibUNSRWdCMlV2ZWdUSHoxeitXUTJPU2dIZ0JQYXY4a3RU?=
 =?utf-8?B?OXFDb3NJZTlEQUFBdlFNTXFDOWFncWtaRytSVWRHU1lQNEFzWnVENGhvQzNl?=
 =?utf-8?B?dHBlbDV4U0dwS0NlbzBEL2lYQ0NHdzk2eFhMQkFDQm50WFN2NVVjZEJjK2Fn?=
 =?utf-8?B?N1BSelBaSHloYzNDOWhwcFpBUzE1eW5WeDd1RmQ4NkdHM3J3QU9zbTFBc0c4?=
 =?utf-8?B?UmxUby8rWVlSU2lQWnRQdVltUnFMNFBEUWY1eEhJb0tLZGNFa051bCsrVWdp?=
 =?utf-8?B?dXVTdi9rME53MDNNRHBaTGYxRFhzT3EvbG5MU0VML2dSbUhtaHliU3NPU2Qw?=
 =?utf-8?B?T3lBU3psUlFvYnlRcVA5VlREcStHc2R2aEtpN2oyUEhkblA1YktEYWswV0pK?=
 =?utf-8?B?NEVDNUtkT2lPbFE0QkttdTVSODRvWlU1dXk3RW1tNzlWYnRhaGN6Q3A5Z1hF?=
 =?utf-8?B?S2JwR1oxbzkzR2pYV0NsR1JZQ3k5d0s0MkVlZXJoYzhoVkxSU1E0Mzloa2NB?=
 =?utf-8?B?b1hhK2h5MjlXN2tmV25JZjZITFVSS0prOU1mZ29kZWVLcXJaUWh0RGFLeFk3?=
 =?utf-8?B?d21pYzkySlMvR094dFgxVkFZb2xPY2FNQWhkRmlHa2s1SHFoZld2VnRNSFEr?=
 =?utf-8?B?SGhZOWJnT3QxMVM4K2ViR1QxeUZ2VGxmUXJ6ZVIrQkxEUGVCbnN0VS9LYVNm?=
 =?utf-8?B?VnZsRlFxS1FSeW5CS3JUZG5IV21OMUtGSGh0TFdLNHF3RE9id25BTFMyZmU0?=
 =?utf-8?B?TlpCUk56YjVzZCtsQ1pidVVTZzdOZkF1bmNadWZkVEduNHAyNkpSaEIwUkJU?=
 =?utf-8?B?aFRGS0ZRLzF1VGN4MDQ0bDlMVXl2V1E2Nm5sL2Y0T0YyMm5SU3IvZlRDd3FJ?=
 =?utf-8?B?SUliZHhEaXgyVndmZkZoR3EzMVZXZmtUQzR6R3g1bHRCbHQ3bmJ6NEFBbHdM?=
 =?utf-8?B?Q1duNXhQYWVSSkFqN3pVemtXb3BZQVNoaDlOem5ROTlEbWNwVVhway9IYit6?=
 =?utf-8?B?c2ZSMTZ4WTE5djk4eGVpL3BHcFEwci9aVllHdXo4cUxuaysyOWVSY2FnN01M?=
 =?utf-8?B?QnpKSG1sbmZhN05LR3JKSCtlMVA4QTZnWklPQ2duSXIyUHM5eW45MzNIaGtJ?=
 =?utf-8?B?UU9QM3FFSWI1YTdUZUY4T1dmb2o4UGhJSVlvNmhLd2R4d1BiTFk0TmhwS0xY?=
 =?utf-8?B?c1FzcjJ3dWtIRVRHRmVTdVN2azNUUTk3L0tiN05pZ3FXOURKVDBreHRDTUY4?=
 =?utf-8?B?QUpacERkb1JCZnhlYzZOenBMYUtkcU5WQmVzZzg5NXA3ais4NlFTRGM1Qzlq?=
 =?utf-8?B?Ly9SZDhLZktQTitnbWxSUVgxWUFVSnc4aEViUFRJRTFlMUNteHZDbzJBTUFh?=
 =?utf-8?B?WlAwTUdUUWxmRTE3YVJaS0VxYVVnL0g5aTZKSi9HMFlDZWMrYnpnRkdzbVl4?=
 =?utf-8?B?dUtmd3IvVmt3d3JVMVBObUI0VGM5ZkVIT2hPZkdlSXFhRGhMTm4ycFB5YmZO?=
 =?utf-8?B?bVN6WllVNTNqd0tmd3NieFZLYUJxN09JQWI5V1hIZHN1NmVuVTVxMUczbTlS?=
 =?utf-8?B?Zm9IVGl3YjdmRVNhV3pkdkpYcjA2SnNtcW40S0JIOUljNGhQVk92R3NvWngx?=
 =?utf-8?B?dHR1bVhrZ1pQQ2lSMXFUbVJ1NTFEaExhWjY1QkV4YVdTRzZMa2NuM3dEbkV1?=
 =?utf-8?B?R0ZhZkF1S1Mvc2hBQ3Z3cjR0MGhqeW1vY01seVJMU3NWeXlHbCtXNUNlNXJP?=
 =?utf-8?B?SWpUVDNqQVp5SDlhZ2V6VDRsL2Y1VEFTcHJaemxlT0d6cUNBbXFtaWU5RjhG?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b574833-3b64-411f-08ac-08ddd3ff88d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:07:42.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXg6BfVcEfvHSi5NMAfG7eaLOdTB6xaVsqY40RoFpmniY6Sy86ZTSI6gV3HyfPNoo6WB/L/B0jEkyVFzo1nWZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3588
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 09:07:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19667

On 25.07.25 10:40, Nobuhiro Iwamatsu wrote:
> This adds config NO_KERNEL not to install the kernel select.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> 
> ---
> v3:
>   - Add description for help.
> 
>  Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index e078892..6ad0d67 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -114,6 +114,12 @@ config KERNEL_6_12
>  	bool "Kernel 6.12.x-cip"
>  	depends on !TARGET_IWG20D
>  
> +config NO_KERNEL
> +	bool "Do not install kernel to image"
> +	help
> +          This does not build the kernel or install it on rootfs.
> +          This can be used when creating images for kernel testing.

"...for testing kernels that are built separately, e.g. via KernleCI".

Jan

> +
>  endchoice
>  
>  config KAS_INCLUDE_KERNEL
> @@ -123,6 +129,7 @@ config KAS_INCLUDE_KERNEL
>  	default "kas/opt/5.10.yml" if KERNEL_5_10
>  	default "kas/opt/6.1.yml" if KERNEL_6_1
>  	default "kas/opt/6.12.yml" if KERNEL_6_12
> +	default "kas/opt/no_kernel.yml" if NO_KERNEL
>  
>  config KERNEL_HEAD
>  	bool "Head of selected CIP kernel branch"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

