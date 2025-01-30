Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B32C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 05:23:57 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.67])
 by mx.groups.io with SMTP id smtpd.web11.9542.1738214629575586221
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 21:23:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rcOZW05d;
 spf=pass (domain: siemens.com, ip: 40.107.159.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwleKf/8xUpqQgngoMM+QGdQ1I5/vnWho3g/EHCBIH0kvNRl9birEvCsSNtG9oZyNo0P2T4nWzmgQot8ctmB/ja4Jlmketght3T7JLmSje+WIco7L7RF3A+n+LAUAAzr9MuIaq8XfupNJ5UWDa2qgL3M8oAnZQWjuxeZg4I69+6pyMDgAEFL17mfXOg6dWYRz1wT5FVGBpilvrSEoCLf0jsPdybJ2YnqUSWkTF+TKoWxDvNhFR8g/zFi+SfyBOqwjWfFSIQOVkmHO7EMb0ycf+9FvV7iRN6pokb2AB4MUu4fnLtCIQus3kSvylh48rhBKmxrxTETW12x5pNOiq+EGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omCgNNLcCdlPjdhKh7D1NAX+xvgfinIpubtgyI0VwY4=;
 b=qHI/Cxzxttl/IE7K0nxv5OJ/bD8s84mB/Hw73oa8hBAAm0uVTxUcT4Tq2ZJg4+1aPnoBcDdz0BFYvQ9/tJkoSwj9suWyE4L5mybvUB0lCsZh4lfS1zbP2Vo79FwzWXG+5iW9eaz69AA+guyYYLNF2ykuXxL32RxSC1MOqo8Sw+OPY+YdF+/wp8p4Jje2fGCE7TFM55EvireFxHldL9l20x72wTOPcWleE7ccv9sLAkyaelpPbZlgQbeGCREeDfuYA0VZjENMOURwCdKfKYQI5qL5CCDGG0AvQzghuA9td1ZBG5ilJinmVJsl2JEgzJY/AcDRxQ/IEFY+ckC8bw6fuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omCgNNLcCdlPjdhKh7D1NAX+xvgfinIpubtgyI0VwY4=;
 b=rcOZW05dF5NkAvu/XCNjOdyernn1ppH8MdoBsg+kDZPU8V1E1mr0VM7uuj8J70XvkIYD+MdbzFgQ6xs1dVroN41kz8uokMN48kggk5Ppa1JgaeemtL3d5hkqCSEnldG4JJx7R2hesskaYSkUR2Yi95ZOctVPjeYQXnREStqzIiqW0wlhjk6a8PsVFeKKayy0wdFL7RsC7dT3kIbTnRF7JfoS4cHLZhhq0aT+szYzURXvDnxakDEiSCr2mQSwBQMJiR+kf2sDIedJ+cyn3JIUhdoPJxnfcwK9DYzCNh3tZBb2yQRebgWmIr4iY3D+PTVdpmdrzGRTN4qE7gSP9yUjmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5307.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:337::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 05:23:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 05:23:45 +0000
Message-ID: <823dfe07-e0d8-464b-a864-c0cf30d7ea26@siemens.com>
Date: Thu, 30 Jan 2025 06:23:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] efibootguard: update to 0.19
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: cedric.hombourger@siemens.com
References: <20250129102528.272043-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250129102528.272043-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 22be2015-24ba-40c1-9f76-08dd40ee444d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RmdRWTR3eUdEZUU5clh6QVNWOEZLRXNHcUtScDRkQlQ4d2VqV1Y2YVdGc2V6?=
 =?utf-8?B?aFBTM1FsZVFnVlJNVFp5ZitHZHpxRWpzczYxUjBQSk5JN3ZRTExSZmdpREZk?=
 =?utf-8?B?ZU0vVENWMTdKblpiaUlPbStVL1hpWGNycWlZSTRkemI5SUFBVEJDSzRQbGNo?=
 =?utf-8?B?MDM5VnEzWDFDbUZ4b2p2VlJtSFg0aUNZSmhRRXhlb3VlUzFGZGtyTGQxVkd5?=
 =?utf-8?B?RHRxWjVtWThsZUhhamhYM0tyWFNuSlZNME5FSGIzS2svZnVmZlpRcVdqS24x?=
 =?utf-8?B?czV3RzRNUjdzSnU2RTUwaHorQmtjVFFKUHdLWVJTNzVXVU4xV2NOb1dMSi9t?=
 =?utf-8?B?SnVjRzI3QkdFbDAxelZPSVM1Z25MV29JcEtUeHRBaXc1b0J2ZW1HUGRJQkVK?=
 =?utf-8?B?UUFYQjhrK2V3ZUtWWDg4M2N0bkhDbG9wZCtqeUZOVzFVWmNWRzh6WGZEYmtx?=
 =?utf-8?B?c3JZWWRDcVREcU13bXlZaUEvYXpSeEczOFNmM0orWnBENXc1cUhKcVlxTStC?=
 =?utf-8?B?NjhITWR3cFJPazBwQWJEOE02LzlMOUJJZUtwMVkrL3NEWEZiZjROaTN4QS9y?=
 =?utf-8?B?dEhpWDdIR2RLVmdBKzhOdDNEQy9IZXczK201SXk5UVRVOGR1V3BsQ29URVVq?=
 =?utf-8?B?YzJlNnpCUXh0OFlsNXRldDk5dGliUmZPZEJqcitmQ0dPZmw3MzJnbjBCbW5B?=
 =?utf-8?B?WFhySXUvMDlCb3h5K1FWWWdFdXZ4YWxDNEQyK0FnVjgwcUpzM2hDc3duVE5B?=
 =?utf-8?B?L0s4TFMwZUpXWEdKRXdrY1FCT0hTOSs2NGxRSkQzQWlKSityMUJyQWowU2J0?=
 =?utf-8?B?bm9iMVVUVEVkQXRTZzBQN2htUFVuSnF4elo1YlVBUnBlTE9jR25WSjVEQ3lt?=
 =?utf-8?B?NmNrT2lvRDI4RHQ0bzVyUDRqVUNOMmNyLzZCak92UG41bjErR3dvK040WXRJ?=
 =?utf-8?B?UTBzWWpIUytDWExoT3ljaFlGTER0WTIvVzB3YUw0ZTZmclgzQnFFcjhPMGxo?=
 =?utf-8?B?N25XaFY5OUUxZEF0UktXSk9XRjZvRlQ3YWhoWWErOEhNVGtkVWVkV0xaQ2R4?=
 =?utf-8?B?UEd1VE5xVDVWak1OakRhMFkza0J6eCt1bXJlVzF1ODltM0xINWM2b1F6N3Br?=
 =?utf-8?B?ZzVFaDJidjFpdDBqNUVobndRZThhektJdWRoUjBCZmJQdUtQRXpieXFUaHkr?=
 =?utf-8?B?Y3BQWlA1L1Fjb1JITC9OblU4Z2VKTXZBVVhQeFJ0cnM2RDF1UHJJSkNQdXNB?=
 =?utf-8?B?dHBIWmF6WVdOK3BzMElneFFLUFdQUEdUUUE2SEtraGNpTzZBZFpoeWQrOE5M?=
 =?utf-8?B?RVg2ZWZFVUNSRUdDT3dDeHlCUVlTdWZ6UU5YK0Yxc3prMFloazM2TkhqRFhj?=
 =?utf-8?B?YkVsM3NxdkJ4R1RCRGRkZTgzc1FLTkNBOWpBdXhNUXppMjJPditUMS8xcm1D?=
 =?utf-8?B?Z2tSbDJkMjl5eFpjMmFWNlUrQUxxTTZ4UGhRTHdIc3ZxcGwxZTJaK0RSYjZL?=
 =?utf-8?B?ZDkxcE5GM3ozMUdOOWQ4ejdZcGpSSUJUVmRkcDJ3K3BQOVBBZURhQnZIV0s0?=
 =?utf-8?B?dEEvcmZCL0tzT2JHS0pROWk2anZyT242bDRuVGZENHlXMTArM1dMaGJYVlMv?=
 =?utf-8?B?b3c0dCtTSHJCN1lSVjY2bzJUc1oxcDhsZGZ4ckJIWDdHcy9IWXVUNW5FaEsz?=
 =?utf-8?B?dHFXM3JQQmNIQXpaN1R5RWNYdzZ1cW1TMXR1NzhMMUVxVmdxcWE1K01MQ2t3?=
 =?utf-8?B?YndwQnNXMXBsdUJ1UG1WVzA4V3VpV3l4amQ1SFRvaUpOeC8wZWFiYm8wUlow?=
 =?utf-8?B?ajNSakZKNW41ODAyNGs5Z1hKUjYrZEcxYy8vTkpDOFJld29wYll4elJxY1Bw?=
 =?utf-8?Q?43aGf1x5rCbPL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dit6M2hVUkNIL1haZlVvRzU2T292eEdKeXozd0hOeUltcUpIRGZ0Z2JqUXRR?=
 =?utf-8?B?Zml6NUJKY1VWRFErdGVkM085T2IyOGxHRHVQUXFOWlcwcktSNSsrWWpuMmZs?=
 =?utf-8?B?ekQwMUZvOUszYi8yNXRSZ2lqTTNDU3J0OFR3TjlseDlNZUpnZkx3aTZUbTlo?=
 =?utf-8?B?ZUhQMzYyWktzMVNSM3JNYkhrMnZEMGRhNjBNd1F0Sm5Pc2Z2NGxWWjdlUGRx?=
 =?utf-8?B?REI0QTVPVjZrcGlrWUI2NDEwaVZxbVVYa1BhQlFwbjJiY0ZXUFRFaE1uWDBj?=
 =?utf-8?B?Sno0eFRnZXY4azJBcXBnZDYrODV3RFlVWkV1cGhoalVBenEyVzVQbFA2b1hI?=
 =?utf-8?B?c0lvZGZMck9vUlZnVk92d3V3N0JaNStYTnV2MUJiNjcxNjN3b042M3VDWUYr?=
 =?utf-8?B?ODJXMnY2SHo4MzJJUkVEdHp5cFgvaVNLQjNhOWhnVVhXV2VGZmFWZ3NjMEo2?=
 =?utf-8?B?cmN0RXVtMUZWYm91NGpGQVFuMFZpYlBBTmxUQ2RXR2tKSXA1OFRQY2EwY25y?=
 =?utf-8?B?eU5WTjFMOXgrQzQvR3pSYlBrMDgraWVDU0MzNnVxRDc1MEl3dFFHbEk4b3Rt?=
 =?utf-8?B?eXk4aW0vV0Q3eWtRVkZEODhNdXZxRFdLZWRZWTdwc1Ercm8wZEZ2WFpRcGlO?=
 =?utf-8?B?U2tIVjU2Q05LV3dtQ1c2anJUbFc2QXllU0N3dHhVUkVqVnRLOVJ6SWtUSTlB?=
 =?utf-8?B?Vkl2V2lpY2dxa09oTVg4NnBYY01DbE0yZnNDaDErYUExSDhOd0dyMWQxU0E3?=
 =?utf-8?B?ZENZMnRvR2cySHp3SkFtRlVKR2k1V05acHFlL1lkL0lDU3pGK2M5d3NqbVpX?=
 =?utf-8?B?bW9aTW9Uc05OVnRmT0pBSWZRTlFDTkx1bFNBZks5RUVKM1d6c0FSUVdWNWNa?=
 =?utf-8?B?RTViRlhVSVNrRTZBWEM2REgza2xjWGNZU2RJSnVzNTgzdFB1ck1YNjJVNUVt?=
 =?utf-8?B?VTVDQ2daU2hlU1NpTmt2bzlhMHIvbEptL0tVSWNaSWJEWjhRSkNDVTIwOXp1?=
 =?utf-8?B?alhhTFM1alNwTXVWNW5ad1QxTjBMVGZBQ3VRczlIUzluWGsvemZlZS92ckFW?=
 =?utf-8?B?TngyWTZMTkNkeW5rK2tJQ0FoTGNGdW5JRytmaEMzL3BZMGx0U1YyWXI0KzA0?=
 =?utf-8?B?TzlrLzlOVm1Lc1hNd3lGQVU4dlJsY0FzMTM2MWFabXJBTi85RUgwOUtEUHE5?=
 =?utf-8?B?N0dtY0VuMlNhcFpoc08yTjhsNnlJM0EwL3V4dXpsZExrTmFjSmk2Ym05dTEz?=
 =?utf-8?B?R2dWOUI1RGlLeTYzTmNFNGNqYkgxWjA3cFJ0eWFkMUFLRm4xK1l4Tnp6eFBC?=
 =?utf-8?B?aHFjVFdSYUpXNmlEaVZCcW05cVFSWGxyNFZTQ0dXTUNWdHV3TERLd0VySjls?=
 =?utf-8?B?aWlKdjN0LzAvQk84SGUvM0M4dk9tb1lDVU05WnRjWnFnOXdObjhYZmY4VVNv?=
 =?utf-8?B?WXdSODd4WEJXSXhwSzE2WStFOUpsSitUVWFvNFFkTjhQSTh0SWZOYUc5Vlpq?=
 =?utf-8?B?QzRrbHdLU25udTFMeStBbjArTUlhYVJ1clIvVmZjUGRkMU5EeTZkdHY1aUl2?=
 =?utf-8?B?MkJ3eU5IU1RGcTRjQzM3Nm9HaE1tTDBJTmtSTExhUXBPUlAwNDRrdEY0bytD?=
 =?utf-8?B?MDNIVFl4cjhEejE5QmxBOXozVWRUdWJrYXNPSTBjaVk4VEdDc2ZuQ3psYzVz?=
 =?utf-8?B?QlM5SG1jR2UyNHdqdmRMQldyZVhCWTVucEdvZXhySE95elBlTlZwaW8zV3NO?=
 =?utf-8?B?V1VRcUN4RCtwcjlSUUJLT2NtVWRlZVhLZll3OThUODdoY0toNElWNzl4cjdh?=
 =?utf-8?B?bnlLTFl6V2cxeGV2eXBsZ2pCazBYSDdWblpUbktEK1pUalk1ZVpBMFl2QkxM?=
 =?utf-8?B?RlZMRUlvOWxBWTB5UEIvREg5VGN2RytZQTZIbW15WEJSMjVKVjVidnkvYXU1?=
 =?utf-8?B?a0c2SmU5UWxJQ1BiMm1oVElSVGw3S3UxVXIwbDFIdU5MdmhFOE9YekIwYTcy?=
 =?utf-8?B?WURVZXp1UU5GMEsxbW1xT21uVlUxVzQ0NW8zays4dFBCd2RPZEw0aGpsMk5D?=
 =?utf-8?B?R1RKWHN6L3c2YUhkbGQ5ZkZIQjF3OGk3WHE0S3IvYXdGTndKU0FLc3k0aGlP?=
 =?utf-8?Q?Zap50N4Td8/z9fOy0BR9PTDRd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22be2015-24ba-40c1-9f76-08dd40ee444d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 05:23:45.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3H0Nz/hvH7RqQZWto3voPm1pajwK7ncMOmeBqQ3HwAWFc2gUkxkonwklMzi3qW2k4AfvenZrsb0jMv6U7/yOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5307
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 05:23:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17680

On 29.01.25 11:25, Badrikesh Prusty wrote:
> The latest efibootguard brings the Watchdog support for SIMATIC IPC BX-21A
> and Advantechs's EC EIOIS200, added support for and usage of the BIT(x) macro.
> 
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  ...fibootguard_0.18-1+cip.bb => efibootguard_0.19-1+cip.bb} | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.18-1+cip.bb => efibootguard_0.19-1+cip.bb} (87%)
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
> similarity index 87%
> rename from recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
> index 6d32833..981aa3d 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020-2024
> +# Copyright (c) Siemens AG, 2020-2025
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -23,8 +23,8 @@ SRC_URI = " \
>      git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
>      file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>      "
> -SRC_URI[tarball.sha256sum] = "023b96548e0779bd7aaf58899883099dba9993b1b4af0c858adc00382523ae52"
> -SRCREV_debian = "7e31b8f9cc204d1210c6c03381f936a96c29b35f"
> +SRC_URI[tarball.sha256sum] = "167a808d508558341b81d9a493f76161ac7fd7119e764435eae1b13e31a69737"
> +SRCREV_debian = "040c116a61ffc99a92b6cbdb793abb7f51ef8d4a"
>  
>  PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>  

Thanks, but we are holding back such an update for a reason: 0.19-1 has
not been uploaded yet, thus is not yet an official Debian version. We
had fun with prematurely adopted versions from salsa before.

Quirin, any news on this?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

