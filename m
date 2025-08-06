Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A501C87FD1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 05:24:50 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.5])
 by mx.groups.io with SMTP id smtpd.web11.18393.1754457883484002397
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 22:24:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eBXMPRMs;
 spf=pass (domain: siemens.com, ip: 40.107.130.5, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+Hmnijn3xxjKYt4VgZsBYRBfyPF5Ri8X1iT2O1U1c4Egl8fuKzeoMw9cnS2N6eHyh4Gci0RtNmYcNdAexUkFfu/9RMi0kD8NExbLsWSXqfLB3PTbOXIoe72ERfCvnH7i6psFR0glALNxC5k/yTepn8Dpey2Om/pJ04EiNKc7bQ4yMTrYeAb7DK1W/g1+1SFZk8e2DlZ+4OBuwt/Hx7oVuV372L54cOen1qZuHSZUvTK27xtqWq7zl+xtZuBW8A9jkG/LwFSLLXurBDSXp+0Jgb2C74C9pPnejMVU25VGGtNO2C841/EenP99uNWc/YkxnE/Y9dbst32BqFjN8xJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FgJhsoJvcaSsMNfPRUAKmitCyRa7Ph5MMd2KgldeVw=;
 b=qU2xuqxUeTmYd8frbwc43Mr9D134Go34OkQF9ji/BH7l+1Nz3pmkCPDbcsJO2SiN++LN+3axEPmTmYHMhIEaP4886BTnY5QUL75JCmi49z+SGdwrx7JV0r4KoAy8AVnqEEEm0DNEZvDe6HX85Srd/RmiSGWXMXum6yy2X7vszaWkzOv76xhHhmNB7rUNeZ+GEvmM0bYGxtvNLrNlOYy9M/E/avvpJ38lrXS+mxfHpbkcGVbsShDPdlymUobrcERFn01iI3966EVbTBw8+StntCqWnSH7u/+pK5EX3Npred2E7gAEM5NYDSY+ajvdh27tsaeT0n5C4x2WwN4SD6IR5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FgJhsoJvcaSsMNfPRUAKmitCyRa7Ph5MMd2KgldeVw=;
 b=eBXMPRMszXS/KOmeqxS4DcEMV/4MoDUikFnCTzQKfLRmpxOTzZ6Y97BrPThafam7JR0tVWQyPs8T7919MCyx/MUlvlNxfNHxeWGbrv9VxBJLCcqLt1Ux9kaRgdW0TMGi0UTXklnHxgIeKC3saTGBsK5osflNsTi6TvDo0TqUsM2rNOeBzzjDbN7LgqrIK7M/JJFm9TdTI54dG+Ro96OCCkPo3UVzWObytm3ymvB87sfGNyZ7XysKXtHOVOb5azA9HOuhI1kSDXW0IP1sav0FfbSnYkHoEXgTRuliteapFDWx0h/yBGpCm2zGjK0UHndmbvw5sXFexwI9DutzjpXe5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8893.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Wed, 6 Aug
 2025 05:24:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 05:24:40 +0000
Message-ID: <5180a08e-8a2a-4a8e-b591-cf3ab81d7e34@siemens.com>
Date: Wed, 6 Aug 2025 07:24:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 2/2] Kconfig: Add config NO_KERNEL for
 kernel selection
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <1754457742-4006-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1754457742-4006-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: ea72023f-9f38-4e61-e414-08ddd4a98ad0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OWFlb1F1eUVkeGF3ZDUxZ3ZkdWpPMUI4bTFySkUySmdiQnRvY2lLUW5HWkN2?=
 =?utf-8?B?TThKYms2b1FQWEFJcEQ4aXoyVE85ZWxoazRNSjJtLzk4ek83U3hRODNJTS9h?=
 =?utf-8?B?UmdSaS9yNy9BUVgyUzZsdERNUzgreTUwS0xJc2hqNU12L01aSDRkUlhTc1pU?=
 =?utf-8?B?VWY2UmpkS3RtSEIzeUxZZWJ5RTVtc1phVm5oc2piRGRTakhab2RXNEIzb1lX?=
 =?utf-8?B?dHUyMHVtMEVYK2MwYUQ1Rk5lbVpaZ0phaWRnb01SNEFhR3o2cVNZV3Y5eHFS?=
 =?utf-8?B?SzBWaUtZK3RzcVBNaXY5M2xkcWFrbzVRcU1wQVdhTzRKY0dBeERVRUc4MmdE?=
 =?utf-8?B?MGNlczFaV2Y5WG1TSE5PbVozbjg4TlJYOGtPY3lNUXk2aTIxK2NxOVFLbWM5?=
 =?utf-8?B?TWdMdUZVK2ZtbWlKc1lVR3FpVzlETWhORTE1N1lSMkRHNnVaUWR0cmRLQnpT?=
 =?utf-8?B?S3NQbVlEQjJ2a1ZpdGgwdG85Zyt6eW5RYmF6NEJ6M0lQVlltQUM2Z3dEYXhQ?=
 =?utf-8?B?cGZZSndiLzdtZ053RDExMUE5eUM4ODFYK3ZRZDJkaC9rNVpVM3B1WHhENHpx?=
 =?utf-8?B?RkpRVXZEZk1ta2xQdi9zam1jeWdTTjJiUmttdzY1Q0R4Vm5LTmJLUm0zb0o3?=
 =?utf-8?B?Nko4bHV6Wk9tKzlQOVN5U245U1pVTjN5RytIMGVieHdXYTFSczNuNk84cEYz?=
 =?utf-8?B?Vmw1VEpMbFo4czVQVHRnRlQ0UGtrenZPbGJQSjB3aHNsRVZLVnIrN0FwOVlL?=
 =?utf-8?B?MEVTa3Rydkl3bjVVbUd6Wi9HMUdKekFHQ0xrL2IrbGlQVkFmZmkwaUZCVk9i?=
 =?utf-8?B?U2VZWVpPTlA1WDkydE5FbHZBTWIvQjZ6ZC93YTVLRjJJR050NXNCVVNvRFNU?=
 =?utf-8?B?RE54U2JhRm96T1JNQ2lQNW5sejZvclZxcHlyN3lrekc3Vkk1TGZGVXhGYXpG?=
 =?utf-8?B?ZWZBeDFRYWRHMk5xMHFpU3VWV0tpSkhSbnZVbzU5RTg2bVY3dnZydmhNSW96?=
 =?utf-8?B?L3ppcDZSdU05VzlSNjhKMS9LRnJ1V21DeGJyMXQzc29DdHFzMDFQSVdmMDIv?=
 =?utf-8?B?eUNsNTlDQytWVFcvSnBTd2ViRklBUnY4TnpwTCtMSnByVXV2a3l0bU9RTzJB?=
 =?utf-8?B?aG9INVR4NFhoWXdUYngwWEROa2M4M2xjSFZZcDc0a245N0xjbUE0L21jdGtP?=
 =?utf-8?B?c2kwaWlnNUxKeVFGa1F0eTRpbmxrbU56R0t6c0xuOUxBYlNWM0liMkFUL3p3?=
 =?utf-8?B?YlRzd25zcWJla2J1dmtTRlJsc1NvNDBWN3Y2RG9GTXk0NjRSQnE3QXFoZEdm?=
 =?utf-8?B?bU56OU4vRTMxYzN2RVJKU2FGaGJxbG0rV3NpV2I0Qms1c0JrcHl0Um16bC9x?=
 =?utf-8?B?ekRwVWx3bm9VRmxpWCs5U2Q5anBuOEhteTRoK0lDVHEzc2RPNjhQSWtkWngr?=
 =?utf-8?B?eGxhdmRoTXdhYWdkbmFMQ2ZKQVZQNWREbmdsaVBINXhUWHh4ZFkwQllJMXF0?=
 =?utf-8?B?cXBnN0poRWdVeFRYaDRyM1psVUNCOU83OXMvS0FhdXMvRTBJZCtmMCtZOEZW?=
 =?utf-8?B?RkhReS9mR1VITDNpTHRjbStla1JDVmpzcm9xb290TnhqVEpMMW01Q3JEUEZ5?=
 =?utf-8?B?SVAvRytDdjNKV0hlUHJPNTVvdVAvRUpSelNsTkU1MmpOOGRGZUhEempweVpk?=
 =?utf-8?B?V1ZrcHNzUXVMWG91K0x3RXV3U2hDLzhCZHIyczlRTGJ0alcvalVtaDN4dWpN?=
 =?utf-8?B?RUNsREZ0STlqb1BUOVpsQ3ZzNEdxVmp2N0M4Zk51MDVDcXlEazhTZHBBYW55?=
 =?utf-8?B?d1R3L3BWUFpHYVlPcHozREx6M0lSa3hsWFdySTJ3TUx3Q3U2M1d2MUR1Z1BU?=
 =?utf-8?B?am1xS1FwdzNpdHV5amFhOW9JNjEzOTE0UUI4YTEzTHFCUFlnK1NzbEhJVzh2?=
 =?utf-8?Q?EMd46txh1v8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b25Fb1o1eWZlL1BMZnFCbm9VUEZrNWVaa3AzN3dVK0dGWVhtZm53Rnlxd0xO?=
 =?utf-8?B?TXlxdHFtcFAxQ2hoVTdTbGVQenlSNldBaUZuRHk0RGN6TkhPNmtUQzc5QlZx?=
 =?utf-8?B?a3BYZTVxb3VxaGYzYm1QN09iYjh6VDg4dHV4UGJzTDlIam42b0pkZkpFL2ln?=
 =?utf-8?B?ajF3M29vN0xDeml4eVZoNHVQSWZFSm8xMVZBTVZtL0F2aUxUWVl3YXhXOFVE?=
 =?utf-8?B?b2FjZVBlSSs5aENxZzVDNlZycGY3N1praWNIWW9ydEJLKzBYOS9XL2pKdUdG?=
 =?utf-8?B?b3NvclZBKzBKSktHbjV0bmxaUnVOUGd0d2t2TVF0L3prNHFJRGh4b2FSaWtN?=
 =?utf-8?B?OG9zbkFzb0dxektmZlFGZ3NXSkhjRzhWQXRBNC94bElDMDlDY01xeldXVHYw?=
 =?utf-8?B?VkZ2RXFUcE5wdkJURS85WndRa2hlVHpnU1pXa1ltYjJkVXFMYjBqMHN6Z1BB?=
 =?utf-8?B?WUhoRldjU083VG8zMHZsVVQrWjdxTitYOUY4Z0o1bngrN3Z2TlVJQWNEM0g2?=
 =?utf-8?B?b2tESUJ6eHVGNXRIeCtlUXhSb2U4ek5ZUUpTcklESE5BVTU0MmkvNzJFUVFi?=
 =?utf-8?B?Q0lWYmFmaG84SnFYYnppb1RBVWsvN1hZSW9XNk4wU0VJMWxWNDJJajlFYzFk?=
 =?utf-8?B?Z09wSFdZM1ZvQWJHRTkzWE9hUGR2aklndlBJcTJNbXVvcXBZREkvTXluYWJx?=
 =?utf-8?B?ZFgyMHBwbDN6VVVvQjFOODNibTV0dTZqbkhlVktTOU1BOStSVjdWMHhhTXNs?=
 =?utf-8?B?QUVxUnVjUm9PeHlaamhNbjdvZUR5RVpoemJ0Ni8wL3R6NXVjb2FLbWIrdWMv?=
 =?utf-8?B?SWlWTitGUDhRc3FVckEzS3R4OU5GZ3c4dlp5K1FlSVJYbzN4MGpZQWlEUW5n?=
 =?utf-8?B?TGRzRk9YNE9rMXVMNFM4SjBLelljVDMxejYyc09kMjZyNE1uRHFKbW1SK3pF?=
 =?utf-8?B?STJRVEZKQmY2T0JoWGR3RFlkbUo3TENVazZjRU45d1JhRWJJaE9aNk5XUXh1?=
 =?utf-8?B?VnFSN3NjQTc1Nkg3bmV1WlVnNENHcUVXVVZ4ODdNRlJyYmk5YW5hQ1VLWmtB?=
 =?utf-8?B?by8wT2dDWURERHh1VkkvdFFCVlhWODRBRTYyL2IwZytvYzNuSEw1MllMemtm?=
 =?utf-8?B?NXdYVHFmVmhqdkJsZ1RVZnFndWZ6MUxYUW1UMEMxOVkyYm96cEZVVTJUdldH?=
 =?utf-8?B?ZFBUbkxGY2tTbDZnV0NNdEVLN1R2aDZYVHovVkxsK3JHL0Z2dWlRWFZvaU40?=
 =?utf-8?B?Rm54TG9UMTBwUFJtUkl0dmI1ZmhOVm1qaDhOenZnL1NmeFIrbmxHRWFRU2pi?=
 =?utf-8?B?T3JtRWxIQnkzRm5SMHBHQjdqTkJtNmVmYmdNY3Arem91QkpmOFlNK2NDaGVR?=
 =?utf-8?B?djFDQUdWQTgzbS9Oa01UK2d4cHhkVHZMeXd0RWF2Rjl5WC8xRGkxYUVncHE5?=
 =?utf-8?B?QjlZYVNZdUQzUmxHVzhoTDNWYlN3ZDIvMVBzb05VYlFkdjNSUjFzNUpNYnhK?=
 =?utf-8?B?bGQyakNjWDM0YVdXZUJhY1BpT3Z6VXhLSmtyUzdPbVhWd042aEl2b0hqWUNi?=
 =?utf-8?B?bEIvVzA5aUl6WkdUaWYxT1hid09neG02eURXMkxQeFNOKy90UlBDWWtoMGFX?=
 =?utf-8?B?alJCMkdTSlczWTFmem84cU9RY2UwVzNlRWdaYnljVStueE9NQ2J5bkxQYmVP?=
 =?utf-8?B?N2UwL3NOOGwyUEp1MnhZNUllSWRXWVZ5MVh3L0YxaGs2SVFSRGZOZkFrNmQ5?=
 =?utf-8?B?ejhEUUhsOHFOM3BuM2lndHFzcmE5RXhtTTNPY0xjNng1MGRCRWVWeFB3WDRq?=
 =?utf-8?B?cGdhSVNXTFNqay8xdU0zeDBwUFc4VVQ1eFlYV2t5TkpjQmM5ci96eU5aKytO?=
 =?utf-8?B?LzlWM2dKcWRoamNZdTA0YzhoVjd5RlFYMjlINTVtNmRTd0dDL1pxZEhlMnNW?=
 =?utf-8?B?TUZVQWhZMm1QQTZTNnBpak5Ud3BFU0RXNXczUFIxcnJvYkxFNEQ1SG5TbnFa?=
 =?utf-8?B?TW5RWnVCYVZWWHY1VGN1TnFEVEdkSUpTbGRxaStUaDhVNGtCUm9VaFhHazRF?=
 =?utf-8?B?TTBiM0JRcUphc1hUVVp6b2x2ZXh4MW5BR1QxdlRwNm1Xa3E4N2ZVSHRCWFBr?=
 =?utf-8?Q?bbt++fiugtISIeffMrOa02m+L?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea72023f-9f38-4e61-e414-08ddd4a98ad0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 05:24:40.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex6j/NaxqqVTvdPSlNSxND9rPBryvyTZNHd4d5/3hmhcxPmNZ4yLUvlKzg6IL4UECis90/cC0vAhOUgwYHv7ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8893
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 05:24:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19681

On 06.08.25 07:22, Nobuhiro Iwamatsu wrote:
> This adds config NO_KERNEL not to install the kernel select.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> 
> ---
> 
> v4:
>   - Update description for help.
> v3:
>   - Add description for help.
> 
>  Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index e078892..3196b91 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -114,6 +114,13 @@ config KERNEL_6_12
>  	bool "Kernel 6.12.x-cip"
>  	depends on !TARGET_IWG20D
>  
> +config NO_KERNEL
> +	bool "Do not install kernel to image"
> +	help
> +	  This does not build the kernel or install it on rootfs.
> +	  This can be used when creating images for testing kernels that are
> +	  built separately, e.g. via KernleCI.
> +
>  endchoice
>  
>  config KAS_INCLUDE_KERNEL
> @@ -123,6 +130,7 @@ config KAS_INCLUDE_KERNEL
>  	default "kas/opt/5.10.yml" if KERNEL_5_10
>  	default "kas/opt/6.1.yml" if KERNEL_6_1
>  	default "kas/opt/6.12.yml" if KERNEL_6_12
> +	default "kas/opt/no_kernel.yml" if NO_KERNEL
>  
>  config KERNEL_HEAD
>  	bool "Head of selected CIP kernel branch"

Thanks, both applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

