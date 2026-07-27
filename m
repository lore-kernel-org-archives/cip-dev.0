Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838FCC531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 06:11:21 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24830.1785132675806585160
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Jul 2026 23:11:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=el83EHDQ;
 spf=pass (domain: siemens.com, ip: 52.101.84.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiKCGGRW0KtSmWkKIMFCM8SJA8lLwvq3YV+Ztd2lE7bVgTin3ploiXkmUPKmunpzGSqyx4YSaV/+naIJp9O8Q3j1+9ynScc+MP0JlK7pEQK0D6rBgccF0YMQI3Ek8fXVBfnoUCUfQJ4Lpfbx93MScdtTDxZNHl884qLeJoTCVAgciOxAKbcdWt8sa05g4XCJ7X2re96+GlRJk/wAeat9ziybjkrUJK3BR6wV1N2BWoI0RcB7/RzhNHDQ+RcSLneaPw77+k6su9lQa/FthYJ2fPOHYwfmW8egvO7/kA0G4kWZhfXOF7c5u3oMCYbRt75XENz82/uywGBjjRfBr/Qo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj0xrbI5DbM/kasTqyS7aGsyB8Q20OT8yg2modGKoYs=;
 b=e8hxlYHa1y3TfTixMkFQoODjW60LJCFGdp82Y0OiKr52eSkp+4syjKsGTx8Yqo1Q5V9TqmfnYdM49V2TeEZhqE4aS/UAXOLhetFpkhWiSnuEjEo218idTFcCFz5ADjlizBsgwGmdRM6A8hS7jAzIkoV7pdRhlURMmaMWgC9XgGutmmTtMgQF5YG8NUl1PXueI0Ygbu2GQYq+lIwMWGXvEjdmK5Czr7Iq+xq2nDgJpyG86x+PQiCxjVVFp3A+iHrrVGHam4xxPtMH66yNHnwc414bX+aQhEy2d5xLzwtP6tQhs6tnwoENIiMelq5KJt4wWRImXRKB0uTVhV8mCRS7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj0xrbI5DbM/kasTqyS7aGsyB8Q20OT8yg2modGKoYs=;
 b=el83EHDQXA0ih/k/mbFodMseMxMVnZuyrPxPHxoMOWngBOV+JIrtKxLyGyfTh3SuJuiFB7oSehbJzDx67FaNQ9bia/mJONCm7SXfxX9v5IVEGN5P7cF9Vlmqq92Tnt0JzeFY6YY50Q/DwXNpa9Y+BuE2XmUb12G7TMTutnw/eWNZiW45FhER5qg9XWlvIDWQNXuGH/FcJWYXNYNU8Y8fIzHEHEbMg5fQHeSKxx00NqyQU/EzjScycZ3w7IiATLVxACoHCv8CcfZaN8EHa0gIES1uLRMQz/sCQg5UKkaHtp/69UdG4AM3ZmzSDMbFpmt337ZVzAEA6tk0vVd7jPiYiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3554.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:11:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:11:11 +0000
Message-ID: <5084bce8-426a-48d7-bbfb-66535442e68e@siemens.com>
Date: Mon, 27 Jul 2026 08:11:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 4/4] switch to isar-rootless
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
 <20260724105116.3575045-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724105116.3575045-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3554:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ccaba9-20b2-4fe6-beef-08deeba5db5e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	laZGjx519iRCdJ7M9a1xJYysD+RpLtFzVT2hYNgbIxg1P/ktWXhNvs1Os2p7SyevBkrVOFlRmAAquZp4g29IncsmbgRyqKbLKwjDcrLElg83rXUklpAQSrQ19CXbaod36Mm03PUt9yoLJYHjO+PFoqwwj7b0sTajxzDK5pNfjjfaJ98FGAdu6BNt5MSg9DWd02OtAirSFuIBa13jgZvu95pbnEdA8Q9P+Ox+4exdpyHy0fHMt0CiVGoCMbOTN2ZtEs9GeNTuHr93NSQ/IgPv5TdZPTWxnxEhvWgEc1YM78hm8vm1zTFaSYe1PYqmtcyN7t8GSnV8eqeOkhdc19Y1bBEgxog3ho2lG3/P5q10YI/53tGrjRk9tarntX10p3InDBVBLbX1mFqLwXW/fCfQXqEMQEb52uCsPgq5TcrOGf3J+hs4n9J24M/UBSxjD39baSQU9Q0xGh4ukXEhlWxMgP6O9FlWON+MuSfrCXh92AqJYWbMV+om1bDxViZ62Rm6cIDR7PIx1ouffo6Er5jIsyal/zoRr7AFxc8ZPym4YkByZuEAczLZ/TAbigNkuO7vIK+Sf1f9AJdAXY8xKZc001JY+xxN0LOYNeyJETCY4fcF4oi2NEQRr4NfngHSZzeS6ThrjKUZXWgG8U4OoCu9Zsd4Szoa9Ep7HLDKY0RUxgU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?clBNbW9BalhqSnVKNWZaT0tvRnluMkZFbEt1cVN6SnI2SzNTSzk4NnJHYmY3?=
 =?utf-8?B?UUV3ak13RWlVV21wYUdqMktzbjl6YXhlckFwVzVsVDRoeXpLYjkvdDFJRUo3?=
 =?utf-8?B?U3g1T1NXSWppb0xQdGJTSjdiQmRobjNpRUlpcFhrMTBCbDB5STZsRmh0aU94?=
 =?utf-8?B?UDF5ZmRyd1FyQno1V0pTd2pTdVU4L0dpd1BNcytacmVycjlrVFNESFdkdUtO?=
 =?utf-8?B?MjJleE1sMTFHR01iSnFvdHNrU1kxNGFGMlZxek9Vb044NmFuSmpYNVZBQVZP?=
 =?utf-8?B?RDF4NDZGbDk0cnk2VHdway80bEZSOFRWdG9BZ1J0L0JKb2VOMGswaStZcDVm?=
 =?utf-8?B?bE1jRHZPU2RLM255ZFVXK2kxalpDK2tsWENpZUpDVHMwZ2xadFdOVWFaenFU?=
 =?utf-8?B?R3FuMnE2d1A4SVBOY2dwdnBoVlRLVmlOMk9NdWlmeEk3T1dqaldDMGNINEYx?=
 =?utf-8?B?UkpmQnEwNGJHY0dMZWhUZDVNQVVTbHFHMWR5TEJpelNVa25MVEFEQkFvUDVE?=
 =?utf-8?B?ZlN0Y3U5ZDlyKzl5K0ttV0tOZmI3VzNhbVBXRlRuZkhKTUJrT2ZScjUzT0JY?=
 =?utf-8?B?YUluNno4Q1dyZ1l2MnR1UUF3U2M3a1lHMXVyeE5KN1FRc0EzVzB1cnJwVW9H?=
 =?utf-8?B?M1hUQkdpUmx5ZE9ycUNCbWVDQytxT2txdVR1V3FnYmlJMmNyNHpmeDJiejA3?=
 =?utf-8?B?VXRSaktZS011L3NHU09UdEtpc2x6ZGkzRlBkRzBBZ0RoNldacVAzemoxU3ky?=
 =?utf-8?B?T203Sk11eENtVW90UjFlR0hHeG9IVy9xMnB3N3gyN0xXUXhLcnl5WUlyd0ZO?=
 =?utf-8?B?TkFra1ZBRTlBdDkvSU5DaDAvU29HaWZvZ1RWQW1DVlVMV2JpUlY4YmNIZE81?=
 =?utf-8?B?QTlqVlVUcEp4NGVWZ01VVERiOUlPL1dKMzZrUXh5VXAwMEhncVhYN2paZjV5?=
 =?utf-8?B?a0Y1SzdKbWVCRHRLWG1HU2tINC9HTzE3dTlYdTRDbW9wRFMwdXkxd3pKUGhY?=
 =?utf-8?B?M1VYWFBPUFI4MzRCQWVhZ0F1NTMwbVo2MmM3ZzhjYkljOWtkZmRwWWs0MXh3?=
 =?utf-8?B?M3YxbkdJUHFSVDJOcW51L3NzdU1tUElpazVUazBNeTJRSXdLa1FONFJON0lW?=
 =?utf-8?B?MzJla3ZnaFNqOENHcDdTTjJtajVSL0FQL0oycnhVL0EzcXFYdVdJYS9SamE4?=
 =?utf-8?B?SEFmRXhFOXB3ZW5SSUZIU3lIa1NCUW41d0ViVHlBSzc1MDZQeUpENjMyM3kx?=
 =?utf-8?B?dm00dU9LdWJENnNPRHhMdTJqaVJsdU5nNlVJY0p3eEFGNmJZczIzZm50dHQr?=
 =?utf-8?B?ZjFjM0NHZEROQ0laTnVWV29lSE5SQmsrK0xTakRRZU42N2NmeEFROU1Ob1Z3?=
 =?utf-8?B?SFlaWDFLZDRHNzMyUFBOMC9JS0ZBY1VDTTNkQUVPcko0TjZCQno2UWw2RXlD?=
 =?utf-8?B?OUFkNDJWY3hUSjZMTHRZMjVhcFZqWnhtYlRwcjc3YjZIUFFON1ozUzF4Vk9C?=
 =?utf-8?B?akxOeG80dEMyTHBNK0NDVVZUaTVHaElmVE5YV2c3WTYyRzhTdTB2V3hXdmdX?=
 =?utf-8?B?SmM5K096aHkzajNWMUxkemxzekNFb0Y1R3ZRbE1UVFNObmYxd2g0N2h1U21y?=
 =?utf-8?B?K2RSWFlXU3pZZkhtWGJhS1hNaVRQRXRtYWQvYWI5UTVTQVE5UlduWmVaRzZ0?=
 =?utf-8?B?MnVXd2ZpZ3ZibzZVRzhTOUJtVENaWC9MQ1R2azRqOW9JbXI1RnhSeVRTQTB1?=
 =?utf-8?B?elAvSEpiLy9GNGc3SkhJU250alFNUmdtZEV6dlFNQXlUQ3hyRVUvOEtlTldK?=
 =?utf-8?B?ZjVtZjkvMzF1NTA0RWRQWFVyeGJCdkgycXJvSmFoT3NOZ2grUm9pRlBBTUhO?=
 =?utf-8?B?dkJROEJjejlZSkQwVUhMdFJQd0lMYVpzNk9pSjI0bHdwU0hqek5ZbmJwSUNt?=
 =?utf-8?B?bnhoNzJyWEl3eWxuY2d1WGE0Yks0K2VoU3MrWTlFWm04VTJGZEZxenV1N3pj?=
 =?utf-8?B?TVpPY1pzZnl3TlRxYVd1NkxvNC82eDJnclVCcERJNDBNZksva2d3ckNLZmtB?=
 =?utf-8?B?SXdKVDU0bEhzSDJyVE5mTlpmTGJ0U09ORE5pdDR5ajlmMXFha2Z3bE92b0hD?=
 =?utf-8?B?cmFKYzJMTlVQVE5rbE1JSEFaVUVXYktuWWNKZS94L1ZTYnVSMHE3dURSRnN5?=
 =?utf-8?B?ZHgwaHFBOUdJdDNGT05WM2h2ZDkzWnpBSVBOTVNIdTREZjFkSGt0NVhYazJQ?=
 =?utf-8?B?Z2gwSDUrR3d1Q3dvTFl6eVpvaTNOQnJMY0pmOGtYRXE2TjBhSk9ERDU4dGJK?=
 =?utf-8?B?ZUxBUFBkTG5pN2kvL0JURFhZaFRCSzlMdWZPWFJyMjNGdVBHd1lUZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ccaba9-20b2-4fe6-beef-08deeba5db5e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:11:11.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOoIXkkkwkpA1sxwZi05dIIWULB1G14Bah12hTsJEZC/w0kFEvPT/lVtqhFG9PMNE6apQKkRCQxuHIvDH7mpdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3554
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 06:11:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23751

On 24.07.26 12:51, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  Kconfig     | 2 +-
>  kas-cip.yml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 438234c..abf9aaf 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -17,7 +17,7 @@ config KAS_INCLUDE_MAIN
>  
>  config KAS_BUILD_SYSTEM
>  	string
> -	default "isar"
> +	default "isar-rootless"
>  
>  config ARCH_AMD64
>  	bool
> diff --git a/kas-cip.yml b/kas-cip.yml
> index cbccf63..eb26716 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -15,7 +15,7 @@ header:
>  distro: cip-core-trixie
>  target: cip-core-image
>  
> -build_system: isar-privileged
> +build_system: isar-rootless
>  
>  repos:
>    cip-core:

Please update the README.md accordingly as well.

And then there is .reproducible-check-ci.yml:

    # clean
    - sudo rm -rf build/tmp
    - sudo rm -rf build/sstate-cache

I suppose this also needs updating.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

