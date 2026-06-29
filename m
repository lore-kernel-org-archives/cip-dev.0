Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9CAC43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 10:58:03 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35063.1782730677937860626
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 03:57:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bK4IV7ee;
 spf=pass (domain: siemens.com, ip: 52.101.72.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4i4Ddc8OBYMCXwDAEXzWqIA9vYnsfbToH44hjRpg3vGYQLOlOxmAnszJY2xeYaW/pjBBGBIHmUDI1ivr7/jS4n+S9HuSKbFl/9Z31i6rjngLyJgiZNoo26Fe5ZS6fypwRewYXMMyGyEAwiC0vspymBRdPr2DgzjY08uAfcyGUoNvav7T0QFPglEkpH67O8fB7Zrp8ePDGqpwk2yjq6s6N2ZrhQJDjbN1QnZAhvWswokmkn73XsSm8cHcLN4N43Es1RiHpPpMEk6WwhSiySAT0toYPx5YUXKGOopNCVE6H0rKpiI66pa4XxbR5e1GFkYCY4eWVNT900p3o1k9MgGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+qJK/U2GgERu30M8AYo3Ul8Mi13Q5w6a+tZAINnuW8=;
 b=ez/o80i7RL7e3+DPjVDQOA6BhSP6tAd3hLBSREOQppAchn//NFo62PQym4xClyk5LWe0JspGBaph5fqEGeIVCca5OHQiAcM985lmk+u4lpnFfBLdVE28P/13HSakv3dtrdnigtCfTvrtVQDhg/vv2XAbuvDGqzvcbQgD+BV6URTJma33LZwTKzh2I7QXfq0ujnN1AKQLCJqShSKCbE69/LNfmrQVGelf27e6VFHTpF18cIPBZRanYWjZsZIWJXr+00wi111r4dl/51H5zThf0D06zSKCeLDz9W14KCJzIuoeHCnEg/QDSeqIDpDckJiD9xAiK64poT/I50FI46UEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+qJK/U2GgERu30M8AYo3Ul8Mi13Q5w6a+tZAINnuW8=;
 b=bK4IV7eeW+wFr+cAJz0hxrLXlkI5hOOJ7UUGIM7bA5JLKCY0QbKV66J+EoIxwpCK2X2Fho9nytj+o2bxh8P6F7kS+t+mgcWHrSXDKkL18rQb0VVWSI3L6+uPDB9G/Cspme0dIfGd02PbHm4LiKUh6olPU33VjbSuLAFoHMDYDZWulgiMBEfjtlFuBtOsiDuTi2EK8VMxg2ImB01keqHL+Hxf7IqGl8cng+sQ431YqdywH4fb6A5A15LC5ldmQJhI1NVRYQ2rXjX2iFLojVTAzPS9GHXa+SypSi8eiLSkn5i9c/YKzYwpZZsf5c04xy2Y+Rs33mns+cUub8BLAwoEQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7470.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 10:57:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 10:57:51 +0000
Message-ID: <4c1fd724-0093-4b33-80f7-a4acb7e65506@siemens.com>
Date: Mon, 29 Jun 2026 12:57:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update
 revision to latest master
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260629085730.416650-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260629085730.416650-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 290f1ea1-5895-4e4f-d0f5-08ded5cd4380
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|55112099003|3023799007|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	klESoA8REZACwWj40ewLZpKzLTAERHSbZADfMEjmxLfXctRcjZ7NXfHZ2xQ/V01Od8lv8gJWOA75XTZ6NJC1t7INUxPe49KYGqidFkUjZjp8Qoxfl963I4L6ot82ig60EvwnKTSJ6fE14/ACFYloISxjcahivd5rt8HkzB9bW9GQquogGDl174eQtxprEdwYuvAc/J04kC4JH0CgZWOCN3bfk6iNmAfNwreKMiPD1dG+y0MfSuAC4FppN7Dv9Xbxb6S6k/as6Wryc9ccui4AyQPlTYyULEFuFbg3vhcqBJpssgNSPM2AwTTNGmZZGIvUCd/XfUl6wKVdH4qte0OxwLhidcP1iT2KlZBMOW2xoMOSbFgYQqxri6vsh4cqMz/+kVpznEprUv2NR9FlUM2LFSAoiitF8Ba6Bl0Xw+mEs194b3KA4R/tsDM9CMGpl9XhFcrqX76P7vFHndRl1rj0MXPQ6Ks96eygI+ZoT9DUcDt2f27cJvvp476pl+5F+FwM714FLvsXlpU28qSQx/M2bo+ahilh2C+y6sZTPLlfEaiuVk/yTWOvVM36tC64KcDTmgcOK1Ayy/j1e9/Y2G0uPWzuZRBL0UspAt9UNNno4x6XejptymuxMM+H/m3nqsCC8/u5CyTaXTRJnagznIl8udE3FXkr7Z4HMHKafgPZJAU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(55112099003)(3023799007)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUZaOGMra3AzY2QzdWNtZkdhMGUvZVlSV3A4bUVoVTBlMHNlVkFBRGJoL2ZD?=
 =?utf-8?B?dWhyM25pNWxOYWZiM0tMVFhhSWVaMzRJdHlNeFJ5TTZEeENhdmJQVkU3RElN?=
 =?utf-8?B?RjR3NmFRdXdEaURDaTgwbTc1VHc3SmhINkljQmM5YnJRR1hmN2VxQ05TYlVs?=
 =?utf-8?B?OFhvdGxpaTgvQnR3R0N0RzZzQjlWUktKRWFrV2RzNHNFZUxQQVB1VGNVV2ZK?=
 =?utf-8?B?UVpGTkZTSkZHL3Q0NHVhSlQzK1JBZW1wYWNoSm81YkdINmY4alQ5QmhwcitP?=
 =?utf-8?B?S1AzY2ZydVpHYUpPaDdOTVBQeU4yaW1sNUlyM2gxd2t4V0RPUFJWdzAyaWhZ?=
 =?utf-8?B?SU1hS0V0ajF0aldZREdhM3NQZE1UeUZpcWtJMlFjWTJzYk5PYnlRblMwRzdh?=
 =?utf-8?B?eUNKYXBKVDNvYmxseDdiUTNXK25vNWs1R1ExYU5QbnFMS0lJTlRwZWFYZUNI?=
 =?utf-8?B?OW5sK21EL2cyVk4xVHRaazg4YlBDRm1rcWNPYjJzeHI0WmVhcitqcEo3bDJh?=
 =?utf-8?B?NEFNeHBnYmJFVzRjQkhJQ3lYRTFoMGw4NnZlMXZEN1ozYStmb3VuU25ramNx?=
 =?utf-8?B?VUpPWTVnYXZpWjdxcGlSQzZmcE9tUkhtcHlWL2FYTU5HZXVEQTlrUk9LVWJ4?=
 =?utf-8?B?UHZTZ2Q2alV0a2h3d2t4RkpjMEZqV1ZyM0tvdEltN3UrNExjM0lSUUNUTU8w?=
 =?utf-8?B?ak52VFhaMWc4UGJXWk1lR2RvSzJGc0xpM1hTQUNlOXlDNExIYXJWdzlkbExV?=
 =?utf-8?B?Z1IzUDJtWGFiSEJzUVlXTWgzWEdDUFUwdFFhUHF2cmx6bEVrbjdycUZpZTd0?=
 =?utf-8?B?SWV2L3FjaUZEU0NNbHpVRDVpZ1dZNS94blNsbkI5MU05aS8vMnZJS3dETzV0?=
 =?utf-8?B?T0hUVlhYZVByV2lVM2tUQXhVUS9EdXJSM2QzL25hWDFLUWxvQW50YklKVHNx?=
 =?utf-8?B?SVp1dHBMUWtCMVN1SEVGZm1pYjExS1dCcW9FbW1OR0t5WWc4WXVkMWt1Z2Fa?=
 =?utf-8?B?VElxVUdCWldmalJsSDJMalNDT1dyakoyREk4eDdHRDBJdVBGTStWOXdHVDFH?=
 =?utf-8?B?Mml4eGU1MkMwZExrYnpoTWYxL2kxV0tOcnlEQm1iMzUrdGFLYjA0dEt1VTlN?=
 =?utf-8?B?ZHZEeVdmVElYRncrR3hYU2llYjQ0NUwxaVEweTJoeHd1c2xMbkNUMVB4ZjZF?=
 =?utf-8?B?M1VocTlHcGlFNHFmMTZlbWM1UmRoS0NOTG12R21vRmtsOFlIcGVyaU9Ld2Fr?=
 =?utf-8?B?OEkrTU0yVXIya2l0UEdyK1RGVzdqV2ZTMTJGNFMxU1FhY3VoWkhyMXVGOVNi?=
 =?utf-8?B?R2t3YkpTUVNsUzgxeDdnc21VKzBUbGpITUNKQjdvKzJDYUU2ZG9GT3RuQm0w?=
 =?utf-8?B?NXBONjZ4b3c0UUR2K2dCWURhQkloa1BVdkNrZFR3U0xnZUtHcjRabDlPQlZU?=
 =?utf-8?B?M1JFbUpWQnFDZy8xRE9qcWVTZ2pFci9OVDNtNnp4M2d1Z1c5YlhxODJheTJ2?=
 =?utf-8?B?OS96Qld4dzRiaDduTUUzNkFjSFRrQW8rZEtqMnFtRjJEc01GbWVEVWNIM3lW?=
 =?utf-8?B?azlNUGVyU1pvT3hmNGlaS21RdFJTZUZVeEQ3Nk1sdi9kOWZORWNEcW5RdmNQ?=
 =?utf-8?B?QTF4VnlGWTdHY05ma3c3Y3RLOXh3VnA3Q0pBYlp5OTJmZWt4YnFlL2I2MUMv?=
 =?utf-8?B?amZkRW95dzZQMzVaUVppQnh5dVExeUZUSFZ5WXpQNmF6bFlxeE0waGhTWXla?=
 =?utf-8?B?UHlhVDhueTlCbVBpS3BmMkIvaFlZWlo3N3p1ZEIvSWRxUkpLU1BXdUlzU0Iz?=
 =?utf-8?B?aXJmOGZwRDN1UVF1UXVucWlLMDJyT09EMnp1SEZ5RUMzYkZCVW9aOWQ1aldu?=
 =?utf-8?B?c1N5bGwydUh1cnVVSEdXTnVkTUhHUUVMcUJxZndOUVZBVXZyaSswMVZDYUNY?=
 =?utf-8?B?N3pueFQvOStvWHgrbzFDbDFpaE8zMzA2S2hPVVAwdHJpMEJFTnhQdkpFMzIw?=
 =?utf-8?B?d08yTkxXSi8xUUJUeXJraDkvcGxJNG4xUHBTOXRkeGpDVW1YUXdTTWdIUndj?=
 =?utf-8?B?VHlhNCtxeVg1clRLYkRFRHEyNG1sdU9meU1KMFI3ejd1R0hYbURZMkQ4dnB1?=
 =?utf-8?B?ZDRVM0ZJNEVKb0ZWVk5velQySk50RXBKNVRGQmkwUUxteTBwYWlxbE5jcWJC?=
 =?utf-8?B?R0Mvc1psSlFkdmlrNVY5YldLZWxPYlVWTWh0UytnenJMRlUyNnVjbDRnK1Rj?=
 =?utf-8?B?Z09YMEFZNGQ5WTZFbm1ZOE40eEg3d0RLWDBNOXdVZUZBb3lYTHhyL3Z0S0h5?=
 =?utf-8?B?Mk1SZGNzd0dpMXM0NnFVTXlrRFZzTzJWT3NENDhSaW41dyt6NnV0b3hjV3pw?=
 =?utf-8?Q?JZa/UXZxYa77RqNQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290f1ea1-5895-4e4f-d0f5-08ded5cd4380
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 10:57:51.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uauQjSx5mRF0apTR1z+I/xJEJ7ozsguXrOhSzBLc13BRZq3rNkLnbxNkzAzNXiJJUV//1Lvcwyqt2p/3nLwWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7470
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 10:58:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23303

On 29.06.26 10:57, Shivanand Kunijadar wrote:
> The round robin handler is updated to support Debian sid by making minor
> changes required for Lua 5.5 version.
> 
> Closes #160
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  .../swupdate-handler-roundrobin_0.1.bb                         | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index 2ba192c..9d9f6d7 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -15,8 +15,7 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  PROVIDES = "swupdate-handlers"
>  
>  SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
> -SRCREV_swupdate-handler-roundrobin ?= "5deb75df5469c5a66cdd727eb72af83ce0784054"
> -
> +SRCREV_swupdate-handler-roundrobin ?= "105ba14dca6fbf168292a1182e8c1e18a728bcd4"
>  SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
>  
>  SWUPDATE_BOOTLOADER ??= "efibootguard"

Thanks, I'll merged this after the upcoming release, just to be safe.
Ping me if I should forget about it...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

