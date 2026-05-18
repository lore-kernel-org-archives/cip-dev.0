Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76467CD4F52
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 09:44:07 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4917.1779097441204718688
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2026 02:44:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kKF7Cv3u;
 spf=pass (domain: siemens.com, ip: 52.101.66.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2mOe99YfymZwf1uF5vxj3karYX39J1HxM2UDirNZ/KH+UWPmcmDl3VzyuyLpffQPgj8XRn+RoNPMTqdW2g2FKtk7toPHdyMw+a67jqQATesspNhxcvLkStwhAnLysCjMox6HDasvwEVjPFVB4weBXaxtK8akT7qNTK2Jv1rFILTPqMLerDCdaCBUJn/P+Q5IYpcrRdOhqtqMB9sSIMtPO3/DGuvjYfMQrz4n/uCgNqFdUTT2COCHah1BFdvOttGG4lgVDQxtnhHaVeccJKwLyt8FjIgy81yumwXEYtnQ8VlPvovJspOKHGevaL+n657Y4V6cMiJMrKqAb3y6gLb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j7yW4rGbnSdSOtZ4eDqvwAQ5W6cFvbiwZBrj6S/w/s=;
 b=uTbLc7MzHU1rWeYAx0fZlJ/8yC42J5cgWeqTdGdf0nV04nIMIPm1EY3fqswMKwFesF1+vdrTHDdRPg+onYUg2VHu2RY/cB9JSwNtIY2yic2twm731LM0WNC5m0/F7AhUcTZ1dh5vBORyXw+YyoOelX+GlqJWF3oH5kYxLWcgUYfMpecKsPBxRX8SGxR/+bnj15LmmT+F1ccV77hfuW4vOZOS9pANvE4DanF60CR8b7a/iA3CG2HoZzh0/K5l9CpX/h085KluzHsDd1hQTEyzLtm0KsjXFElrly5CDPREHUq6SwOsLQhrhIp+G+H20c+6mJHIRZUUVSA8xuDm/Ta79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j7yW4rGbnSdSOtZ4eDqvwAQ5W6cFvbiwZBrj6S/w/s=;
 b=kKF7Cv3un/TgfdPELVzGKrqyZlqfAAR2lSjNwxYrUthZsQJb9p4tX6mCPQMGKu2mn/Aowuob5gOpkwdgU7GC3s5Z6fP8t7i5xcPWAr6BhTLKziM6IkfaAYSU709vR14c9OAPtRUhJUxZFCxAWsv0iZZUQ1z3AbuKlfGltxe4BswIjXoLR66T/VJB0Zj9IF2O0pcfCpTyezyeO1xhvMrB7Tdq3KjdBHdR6TfWI7mzuPlayl+u9iaPlcoSvCUAp7hzeyijRxLMrad6jpdCYGxWVT0FB6/cCYa4MSKw29KCHraBJKXtWaGznTCqxkd3ukIz/g4Kj6eN/pSjQV+ayLTjaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7888.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:648::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 09:43:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 09:43:56 +0000
Message-ID: <8415400d-0ab5-44f0-94be-18d7becf9c14@siemens.com>
Date: Mon, 18 May 2026 11:43:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 5.10.256-cip73,
 6.1.173-cip56, 6.12.88-cip23
To: Gourav Singh <gouravsingh@siemens.com>, cip-dev@lists.cip-project.org
References: <20260518093800.1396160-1-gouravsingh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260518093800.1396160-1-gouravsingh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fbaacd-5355-405b-ea77-08deb4c1fa8b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	1PP5MLFdNFPLLt41fK4SPLgyXNaxIp75gVGeGMwmbnfQBPSWr68/qSpPIJN7rG62EvbiqCWijYZ3uaxMSN/C6OPPwc+lW4vvNZZ/HkwyM+W6ZQqYa+u7lOkEDbuVD/BUT5uOZBLaVmzJKflNtl18YxnQ+NMKwxLiN2hle0Va+MoxLZNJGGEkhiEldnQRTROJXkn03GchmDRZ/PFYWp3luXteioUA4sAcV9Yz4X3lHkHreSgDa/Wx4SsId+UQnabAvepTS5w2BOQyR74D6TAlJB/9emC+475e8ur3kEH63WgQgqVJyvZMODHhjBmMy0yeY0UuC+v7nmMQK95YcvIsZL1S2UmsiFkeu2V3zTkTuk+LZaYrvKeoztuMKmVyHyscFez+l9r1CaeFAl0bss/NLPiPtMNyTqwOqKWLMHJnwS5OCdSC/VL14rh/Y49WGFnJpspo5LMwS+Ez2795sYjReoDNmCCb5Gk7hGCOC3vW/7JZdiVQAWz5ST7Ig0yLdIqR1AMtIq44oOHiLfYZhkclR/uKnfwyuZABTGpjCm8FbP733IcnnnuC8IqySodV8mWK4hY6euLgwyyxyqWTy1lwg3mgTN4TzcToeKV/Ocm5sqVMcIPZIbuFdX597MEqOZlyR9x4ouVaHEgPT0xVVgbq7loWuL01xmERI93MAFduPfA5rsw7xQjfdFXZdDvS5tmA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(11063799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmVPWGp5dXhaZ0NxRm9URTd3dS9HaFRqSEZaOVYxakpLZ3B4MjF0d2tHV3dx?=
 =?utf-8?B?WjM0d0dmMGJCWGI1bUtBVjV1YWZRODQrRFNKZjVmR2xNcXh4aVJweW1kcWQ2?=
 =?utf-8?B?Z0x0MjNVZXAzNFdXc0JOL3hMdG12T3F3N1B5YW5BdkF1dThFa3dPTGFnUmpQ?=
 =?utf-8?B?SktzZXhlQkprazZQRnU3NlB2ZTJNMnVYTXhWZWxRRkRSTG1rODRaSkdzU2dE?=
 =?utf-8?B?VWJvd2t2Zm5YeHovRE8vUytBQ3JDcGN3UmNiN21YZzhxRTFZazhGM1RIdkZa?=
 =?utf-8?B?N01BMU5ZMzFlanJObnNMVjkvdUdzUFZSdFZnOHQ5QWZvMXhiUStaSHVvRVhz?=
 =?utf-8?B?VlJOekJMOEdhOFEzSVdDTWdOWDZNSEZqbDNEbytVeGZNNHhscEVXakg5b0xj?=
 =?utf-8?B?YzhQYjVmUElkUGlQdTViN01ENFpvQlBwbDhGMDFhTCtJeVBFQjV4cDI5cTRu?=
 =?utf-8?B?eHh2QXZJbHVtREwyakdzNzJlbnQwVGV2MUVBN2Q1T0hmMitrOXRYYzNxay8x?=
 =?utf-8?B?U3VSNGdXOWVENis0aXpxOHEyRllpMzdZK0hwTlN4OWFCenFiVEJXNDRtVzBK?=
 =?utf-8?B?UU1xTmxsMEFJMDE2R3dBQUErRGN3dE1CYitPVDUrMW92cmJmdVphWWhBeW5U?=
 =?utf-8?B?VlFwSCtVRkVtTGFQaURoeVl6MWVHR2dMT0I0ZnlsZUtsS1E0VTdRanVFalBM?=
 =?utf-8?B?MzB4NGZkK0FoTzh4alhUTFZOaVp2WVlST3M5WDVwclVaVlgxK1lCMkZBdElQ?=
 =?utf-8?B?bWNDbmlkQmJ1VDZCS3UrR1Z0dkdvWFZzMlFMWnhBN2dxM2w2aWpuNjZReXl4?=
 =?utf-8?B?MU1sejZkN2swZUN6eitaRUVzOGhsNHNBR1AzWnE3WE1xMEg2bnpvamN3dENB?=
 =?utf-8?B?c3ErTk00VklOSW5sU1RHd25jRWxCZUpNeGRGdDRDemZmbWhWVytnT1hwTGNJ?=
 =?utf-8?B?UnZ5eGF1V3RyRkN0anJRWVpuTVFpUWo1ZytEMDl1M2dFbDVwRmFBQ3dkSWMy?=
 =?utf-8?B?SzNLWkRTL1VYK1p5UlhHUXJ3cEREaTJLTmo5cEpOcUpMV3NqS2R2MXR4WnhE?=
 =?utf-8?B?SnZKcFdxUkJwb0sydndyQUxHNEUxWFA1SGZMdzVVYUhBZFd6ZjFteDRiQUcw?=
 =?utf-8?B?VjNqbUVvOXRIZVRtTEIwenB0aGIycCs3NWgyOW9OTjNHZmdKMXhzcEdORHNN?=
 =?utf-8?B?cTducVRKOXVnSWo5MFltRVV6ancrREYrVUhtSzcrdlFCZVlDeTcyeVB1THp0?=
 =?utf-8?B?cDJDc0NBUG5KRU9weU9PcnhtTTZETEpaU2FCT1dEUG8zdFE1empPUHZtNVRw?=
 =?utf-8?B?RVAzUnRiRzZNRlZPQTJQNHJDUGY2VUh5WTUvQ1dLRGowdDdic3lnRUkwMlN2?=
 =?utf-8?B?ODd1WVdGZnh0dWNtSUVUeDBYa0RLSlJuaVRhZ2dmMU01L1hRZm54a01qTDdX?=
 =?utf-8?B?ZkN5L3JPeW1uVG44ZUNPcmpweHhQNUlBS2xnYlp5dDgvN2VsdmxqWXM2UElF?=
 =?utf-8?B?RnFZSHBzRUQwa0ozclNLWWZtdEtUN2NwZDU4V1h2RUZzd2M0K25YdGZpNG9m?=
 =?utf-8?B?RjZMVDF3cElvK3kxd2dCUWJzUHBwY2dYMW5ZZWU1Q01taVg2ZHk5ejUvN3hP?=
 =?utf-8?B?eW1LVE9XSkxOU2g4YWp5ZkpGZTE4aEpONXo3WVZlcDlWVVJiU3k4RjhNVGI3?=
 =?utf-8?B?a1YzY08zTStCT1ZJaFVaSmIyVHJGZm5ObzVGVitxVGR3cW44K1RxbnVhNTIv?=
 =?utf-8?B?Ti9LWEdiaWxaOXAzRm5UVHpGbkNJaXlPNngyVWZCcTd2RzVOM3hQZnBvSzBi?=
 =?utf-8?B?dGxqYUF1Z210UHhkMFpRTU5iL0hyeDlycWN0VUJ1UFVheFRVMmtvVWFlVHZQ?=
 =?utf-8?B?OWpSRXUxZUF2N05TUDR2R2VQUS9oeXNIODZ0U0xuNFcyZFhZSkpNRS96Y241?=
 =?utf-8?B?clgybTlSZ3p6ZUtrc2h6RjVnYm1GTElJakp6RDdoZjV5eEM2dTlMdlhabnhM?=
 =?utf-8?B?dHlldk40MnhYWWswb2x2V1loTUY5bk1vSU01aC9HYlhFaFVYMWt6eGhyWFYy?=
 =?utf-8?B?WS9jV1VpOStzUkRnb2ZFVHBMdVhvZUM1NVF1azBKYmxLdGhpTnYrRlV3UmNC?=
 =?utf-8?B?OHdDWjEzU3c2aHVJUm1nZ3F3V2p2NmZJdUZlY0k0K1NlUkRqYWZTQUZGR2pY?=
 =?utf-8?B?QmJvZHBwRTJmZ0hmenp6d2wvb1BSSStzV1o4ODV6czNnU1NCTjZoYzlRV1J5?=
 =?utf-8?B?c2NLM0xNRWllWFh1QUg2K3hTWngrRkRwelFHekZaU1FOTnZMUHdIK2R5N3hh?=
 =?utf-8?B?SGFJS2J5L2pjSURkYXFwRldaVkxyeWpRb0dhb0U4RXNDYjBnNnAyUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fbaacd-5355-405b-ea77-08deb4c1fa8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:43:55.9306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNqFUpb6QHHTZbzIDFOiV89Q3K6gL0ejwg1mC46xVAY/VS683LLnw1wbxzVMcRkKPzMRNqN0Smpur3guf1PtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7888
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 May 2026 09:44:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22973

On 18.05.26 11:38, Gourav Singh wrote:
> Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb            | 1 -
>  recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb            | 1 +
>  ...inux-cip_5.10.254-cip72.bb => linux-cip_5.10.256-cip73.bb} | 4 ++--
>  ...{linux-cip_6.1.170-cip55.bb => linux-cip_6.1.173-cip56.bb} | 2 +-
>  ...{linux-cip_6.12.85-cip22.bb => linux-cip_6.12.88-cip23.bb} | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>  delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
>  rename recipes-kernel/linux/{linux-cip_5.10.254-cip72.bb => linux-cip_5.10.256-cip73.bb} (54%)
>  rename recipes-kernel/linux/{linux-cip_6.1.170-cip55.bb => linux-cip_6.1.173-cip56.bb} (59%)
>  rename recipes-kernel/linux/{linux-cip_6.12.85-cip22.bb => linux-cip_6.12.88-cip23.bb} (59%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
> deleted file mode 120000
> index ed5ab00..0000000
> --- a/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
> +++ /dev/null
> @@ -1 +0,0 @@
> -linux-cip_6.12.85-cip22.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb b/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
> new file mode 120000
> index 0000000..306c2a9
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
> @@ -0,0 +1 @@
> +linux-cip_6.12.88-cip23.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_5.10.254-cip72.bb b/recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
> similarity index 54%
> rename from recipes-kernel/linux/linux-cip_5.10.254-cip72.bb
> rename to recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
> index b4beedc..4d2fec6 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.254-cip72.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021-2023
> +# Copyright (c) Siemens AG, 2026

2021-2026. OTOH, those changes are generated by
scripts/update-linux-cip.sh anyway - or did you actually created them
manually? Probably, because you missed 4.19-cip-rt...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

