Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5627CA5FF0
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 07:09:47 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39798.1791270578906957707
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Oct 2026 00:09:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=osMmbidG;
 spf=pass (domain: siemens.com, ip: 40.107.159.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oq7cH107HZJYBV3p1+aIRhpkPCfgccnbjpALfeUgit8SO0oUlZ0SaBLN5/cLkedLbQ2SLcd5rGU4yam3/01yIgDt5NQ2fV695QOMIFD7zsLVgLquCY4mE6Rp2YQ9JGgkqUFWNxYaN6HG+Ae8npV5HIQfLj35mfihOKjzd+JpHu/pFkVsaTrGqyR3RV0mKlGaL6jhyGuhsrHtkgqlh3osTdRGL2++uQ7kvK0uFXiuiOMqO/gGfmPRLJCkWRmxwJd/E4sm9IOJeEBYvZIPsrioT4JMyTSnFP3c98+VIun1PLOvsx3sVzSsWGP3iKSjFkthu8SbSZKBK25SomUNhqse3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqCZD2p9PqAYQQU+aa857oBR391luMB3BhU3E+JMCAE=;
 b=uHVdPH2LD6+yBEG/+Kr4fMLkhgJpX8/lySuW0DsHRRtOB8fjLwDF+Er8DCB3+ITqu7Bp1aE1V38vMGQLgNhMBKbLx7Rs+nGI/DhMEkLCLXx0RwXaq0b+92lFCnn1Ui91KCH87jCvCz6NB64FM0BmYc07dKciu+PYlL5mQaSqxcTXfLJdODfmH9QxiHcAs44Bq+EGjvxwrKlsKA1eFdpXxik4ZttoWFfK5YgVrxmBGJQReztuV1k2VGRHeM4VwehpFRjvHRI8gARFl7VkMv5c8CCGMP2MftmDr84S4Q3j/xj446W8TToli5lEdxtdH0yx7EcuWs3pbMl3g99v613M9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqCZD2p9PqAYQQU+aa857oBR391luMB3BhU3E+JMCAE=;
 b=osMmbidGqkU0sMTjFGN/191SlefFv/gzJYZhg7k1dOsTQQ5A3FOZrJSt5MXS7CbYRrNoLw6EwVlA7F+Ag7zrTb3MocBDL57iGP1dQnDLRt0FRPm88pzJlzerrtM+EkymGcuQwZNRP7NgvJhd196UtJWVEoMrX4HKaRcHoL5p5Sz+g6Of7WSyrnf7z6Wf60qotTocc/N+jNo2Gwu4L1oDaPmKmmHFZvTiXkqtb/8acFrfLrAXek/6KbLyBGwUd2BOxO+pKMjbgAwKuTiR0vbt1uxYtx4+AR7CoNFI1iCrJ5rzVGqgPtQwoMY8/aQFDRd5uS/DW2blotXlJLLfKujVxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DUZPR10MB8150.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4d8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Tue, 6 Oct
 2026 07:09:32 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 07:09:32 +0000
Message-ID: <4853f7c5-df38-431f-a7cb-7b80e2a781ee@siemens.com>
Date: Tue, 6 Oct 2026 09:09:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swupdate-handler-roundrobin: Fix Lua version for bookworm
 and bullseye
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: Shivanand.Kunijadar@toshiba-tsip.com
References: <20261006033242.301666-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261006033242.301666-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DUZPR10MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: a514d7c4-5bd0-4364-3a7d-08df2378c51a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|55112099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	PiWcvSqpLbEUTiRKjircZfJyfH74uxdBQXEv1IIGEJGKi2bguCXWTo2zwCwozEejvaLYKoisDAQfSujkJdFKw3mIJJ0/wushBdhOIA2BY4OmmYmJaaTwll07FWmGlXSqGf8SR5joMLKgahBwiMB1zGvh8q4paF8lahqoyKgg/RvsT+6+tIAzMCeCGHT0MOb8Va7XYTH2Nnl5Ik/lRuZ8ps1xM7yo2+e+8VEhpsYva8QOLKaqQfEqmkVtx5xEqxxamy+5cyCmW/d9OH5HOsSuRKHOcNCDEmnPXfnyRrylBQU9iVb+Qr2/iAOJjAMNELJhnYwAjpB6IeQRmzyqfPX/0kyf7J35ip6qmChZFPKlGpt99WCYRi9fYbnq9tx3S6Y7H+5QxP4OGPVNrWiFK5alZ10kVJ5XzWmRRyC//hTDrE8UxXfQIc8+YFgpqISs4Z5SfN74JNG+4XV+Pi6XbPwiIIvALyV626Xru14Dt0EmB6Gww/UiCA+Z0lTqz2T1pRSSOeCdc4zpx9CnCG+6dxaMtCETbMpY3OJG8LD0BiWsPpqmE0cmyTtkuMJIwV1xTEu6T5CunbsvUJdUPVfIpg5SsunTVZXpf8YNrHfvyR8CnwcacPMfniH0tO8o/wH8duXWTT0xiDPUTbs0i4p6VF0fJO+4BVmmHsiS0E8yt1RXaSY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(55112099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VytncW0xeUNzTWU5YmFKaktidUdJNm5oMkp0bm05eXoxQ3A4dlk2M01ISFNh?=
 =?utf-8?B?cElnUXF6Zyt2aFl5Y0JwWXUzeDJjOVh0UFgyc3k2Vkp2NDBZdWFHNlZoMGdn?=
 =?utf-8?B?VmsybXcrNkgvRzEwWGNvMG5IYTNob2MzUHhYSlQxeEJCTkFyc2JCV1NXaUlY?=
 =?utf-8?B?ZzA0aGxpTFR1MWpGbUZIVDhCQTNtWnlJQnl5bHVYNy9XTkc0azBWTG9NeGRD?=
 =?utf-8?B?cjZHSEwwdkNwazBPK0t3aWJGNlFSVHNlQnVTYjA5dG1EWTlONW8zekU4ZlZG?=
 =?utf-8?B?ZHl1NmtrV1NVMXIxVTY1ZWhVNXJ6NVZ5cy9tTjlYUkhWNkZXT28zVEl4amtq?=
 =?utf-8?B?cWxpTG1aMzAzd2pLNkI2MG0valZVVXpMYzJKRlRiMVh5RHV4NklGZDR6c2Nu?=
 =?utf-8?B?VCtYNU1qYTVxb0NIUkZ5OVhES0JtUmFxSHhKdEtOZjRuMENjWXhISnZSclkz?=
 =?utf-8?B?ekFuWk9VenZod21VQ3JMSFdBUTJKTUxqNjREbTdzZFdKLzZMN241RUg2LzFa?=
 =?utf-8?B?TWRlQmdJOUZpSkFRZFdmcmhMcVRWQkplS3ErUldpR2poYm54ZlREZjBMM25C?=
 =?utf-8?B?cTVxWXQ2UEh6cC9YVy83dkpFWDZRY0ttV0I0NHRnQjFFa3FwOXgyUGNyZTVo?=
 =?utf-8?B?Rm5SanNOUnR4NWtMK3hzY2tYQVZKVE93dVJyQkVEQ20zSHZNaVNYWUhoL2lh?=
 =?utf-8?B?TDVVaklRNXRkMWdpUHpnZ3RGcStoZzhsalh3TFJIVXVZYXlNMDdmcWNncHJ1?=
 =?utf-8?B?d2M3aGh0UDgraHNKZHIwMVh3bjFrMmhxRUdVb1prYVJlS2cwN3A4WmtPeWdz?=
 =?utf-8?B?d0dvY1RKTWhFR2JkbjRReGx4WXdwWmEvVXh3cFdQRWNGVFdCbVV2TnhnNW0v?=
 =?utf-8?B?NkZkUHFvdnFpbExFR2NGeTlxT2pmeWdoTEVmWm9POENHZElJSngyb2VQK0lh?=
 =?utf-8?B?N2FiNDMwbUFMN2lkTWQ5MEozYzBKaWduVDQ0UDM0ZTdzeTFZUmhMdmYxSUNp?=
 =?utf-8?B?UkZFa0t3RzJ3eC9WN1ZtMkJqYkJOd0MwcHVtd0tBd09PK2RoZ24wZzFqR2hK?=
 =?utf-8?B?Zmw4anB2WlAyK1M5NXpEcDVDYnJ4aFE0MDRRc3BPU2t4NmF3Y1NJaFB5NER4?=
 =?utf-8?B?dVR1Vk5nd0l2TnVvU1phaWg1WVJkSThHT0VUV1NvdmNGUW9hVDZBM25tSFJH?=
 =?utf-8?B?STc0TURkSENkS3c4czhwMjAxUWxYZUN0VmxuSzd3aDhPakl2UjB6aFA3TTlC?=
 =?utf-8?B?eDlGZEJhVys2d3RvWXEwdkRQOWROTVU0SjNTcThkY2VkM0lOL3JySDdPTERw?=
 =?utf-8?B?VmVuczd0YzgwSkV6NFp6bUJ0ZUxhdlVzN3lORFhubVU4QzFzdWZIazN1b0wx?=
 =?utf-8?B?Z2NWT2pKRTJJYmc5bTNqd3VBNE1qT0dNRzRIMklKODRqdnVpR2tZSGpGNGll?=
 =?utf-8?B?QUNqMVhXQU5OWXIrS3BSYkJ5NkFkbnRXMDZ1KzFNbDdhd2gvaWtzTWhUOU5K?=
 =?utf-8?B?dnFjWFZ1NS9kK0dVT25kR3pNTThGU0lPUExWRkZRaFQ1ejFIWEJtMHhkNWdV?=
 =?utf-8?B?RmpJdGRMcmsxbUpVRW1BL00yYTJMcWx0U1BFWUQ0UjhqNFlmMTVrK1BSV3ZG?=
 =?utf-8?B?cDJ0Y0R2bFZiemFPYjFSQTV5SE9OZmJSYXl1c3dKU2U3VjBaeU1EK3JQaWto?=
 =?utf-8?B?Z01lNVRXbDVsbllOK3lndlhldTJ4RnpUeE15WXdrbzdGWDZYMmVNRkJSM3hr?=
 =?utf-8?B?azVZLzVrL1R2ZHRiSXNVWWIzZ1l3Tmhzc0lFNHN3RmpKU09Vbm9XR1QyNzRH?=
 =?utf-8?B?Q2xHSXhiQjQ2cEpsbmQ4Z1ZNQlZkYzIvVnRPSkFtT2VXbHJFUXYrMHJWMWRV?=
 =?utf-8?B?dFZON09DandkRTkwWmRvNUNFR0t2NnlmK2RzYUEvdElwcnI5K3RXVlFNekRl?=
 =?utf-8?B?MERFaURoWWI4bFEvY05CcFJOcUpudXpCTVJBcWRsQzExOUpmajNIRDRpQ2R4?=
 =?utf-8?B?NkxQQ1pXa29BTlVpRmpzbUNGdmEvTlkrSDgwaWFqbnBkb3V6M3VyN1N2WTVL?=
 =?utf-8?B?WXc0czZJZUJmeVUyelZXYzFEVTZ0eUYzMFBJaFhTZkV4MkVXaE5EM3JZR3Jq?=
 =?utf-8?B?WDlWNDg0TVJCRUhweVJkeUdzVnliSjFFWlJVSXRIRVVYR1dROGJVUlBnWVlm?=
 =?utf-8?B?R1NjYXM2SUErckFLWGNGUXlPTGRTVTQwdC9sMVVZejY5WE5aZFNUblFJRG9T?=
 =?utf-8?B?UXBER0U3VVNoNkNOOEk2VkRmcW1oQlNTMlhQVFJWQWppNFNwYVl5cUNCeHdN?=
 =?utf-8?B?ZE5FN1hsZ25iYlBhVVpFOGlBTFNWRkNYWEpJV1J6WEtmUlFVY1lKZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a514d7c4-5bd0-4364-3a7d-08df2378c51a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:09:32.0477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhPQspfUzUzIHgJZuRNA9vowE+uqynUYXHZMrn6wYFAZ08r1d9mh0NXSJS6x3EaxLEE/tH72Bi1AS/SfPRe//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8150
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Oct 2026 07:09:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24431

On 06.10.26 05:32, Badrikesh Prusty wrote:
> SWUpdate 2023.12 on bookworm and bullseye requires liblua5.4-dev, but
> the roundrobin handler was being installed to the Lua 5.3 directory,
> causing the handler to not be found at runtime.
> 
> Update SWUPDATE_LUA_VERSION to 5.4 for both bookworm and bullseye to
> match the Lua version used by SWUpdate 2023.12 on these distributions.
> 
> This fixes the error:
>   feature 'roundrobin' required for image in sw-description is absent!
> 
> Fixes: 902ad326 ("swupdate-handler-roundrobin: Keep default lua version as 5.5")
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  .../swupdate-handler-roundrobin_0.1.bb                        | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index 6e923e4..965e0f5 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -28,8 +28,8 @@ SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if
>  
>  SWUPDATE_LUA_VERSION = "5.5"
>  SWUPDATE_LUA_VERSION:trixie = "5.4"
> -SWUPDATE_LUA_VERSION:bookworm = "5.3"
> -SWUPDATE_LUA_VERSION:bullseye = "5.3"
> +SWUPDATE_LUA_VERSION:bookworm = "5.4"
> +SWUPDATE_LUA_VERSION:bullseye = "5.4"
>  SWUPDATE_LUA_VERSION:buster = "5.3"
>  
>  do_install[cleandirs] = "${D}/etc \

Thanks for identifying this. Did you also check if buster is still fine?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

