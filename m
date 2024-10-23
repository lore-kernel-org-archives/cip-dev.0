Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD43D2E01A
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 06:18:38 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web10.2575.1729664311817146138
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Oct 2024 23:18:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=e38lPIT4;
 spf=pass (domain: siemens.com, ip: 40.107.21.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0AgVBTaTlx7K79CL8vnsk9iDIGpkmGO7G+UNEBc8famojsvgxuuvbNPd3prkg3M8nS0lhBc+n6OsE6cwJy6LpODCFKj3/rU1j2HVrt5SpEli87nU20W6pNYop/vbLPNDUXx8jKz5238u44x3xeGubeuVWt4TIOkcz1/li1fulx58hjipnp6A0JsEJYvKAHptx6k80Adis88hQMz50MB5GjUTKazFQAkkR9ihBYhS1w3QKSnKC6freQJftaRey98shc1IR0Nry29fKu6ZCjj4R2lTBTWjQoKFg4pK3SiyATMgHNCVlPQY8/jnuq3hho9lyCKOiwHP4IDZkYsLbZiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+nsYRfK/bVYoBaDJXMfs7W6UIlYf0mytH44F2olQYs=;
 b=bPRvwYnbgL0VLAYsLLGbn0AZvR0nNqvpcMzLSfLQI5JWq4Vh5Na7NfSqqne6m4pe9/J9LgGKOm76cDbbfDfJyN4uK8aY2Ywwi5kprgRF5y1SxaFqEYKtybcCtVBitPlF7+abr3q/NdDhtteiTqxEZ/7yHFlUYWvTdK4r1LSDAcTURLGtsGjq/kl6PbaJdtZysQukgWeCavD6lUhrOEnAKrhgILn1ZJWT85p+DUGvChR7vim5qro1kfrbakPQczYhLYxUHL6crIlcd3UMXNiLK/M8KzQJx6SCcr4lKg0fLfZw34zrChmOXMzHU0SnHQNIMjpcnH0yCTSka8eRTOEk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+nsYRfK/bVYoBaDJXMfs7W6UIlYf0mytH44F2olQYs=;
 b=e38lPIT4eQuyF+fdZBXMCuN4G0xw18nAmlIoAfd4qIrpRNu1DxkC7uJ9Ypce4PjXzjtVVMgink88FBT9yQeYpYxGkgHbrKU51tQiD/Co9+BRNKUzTZ8EmW6SZKFVZaOI3ytChRrGY6/vGG5h6s9ftEY3LrWj1P/PSVKQVgECPd8ARdhB8PoqK51C2gqSfAMEnXZSp7AdhIcqD9+tEWALk6h0aISL0mHTW7n3B+FpIiOEdHDPcBgiGTPpKXiq3nRj0fkGHWHUsgIi8CqqpjvoDwHu4IB/bBS1QPbLFslkxzpCNfYhChZ5yfIsIGEETMVTPEL0t19DD6mQ36MsnGO8Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6798.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 06:18:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 06:18:28 +0000
Message-ID: <b274adfb-c698-4c98-a68b-bb92f710a598@siemens.com>
Date: Wed, 23 Oct 2024 08:18:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] v6.1.111-cip29-rt16 (rt42)
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com,
 Cedric Hombourger <Cedric_Hombourger@mentor.com>
References: <ZwezX12F5AOLW6rU@duo.ucw.cz>
 <42448455-fc7f-4dbf-9bfe-ee741128bf21@siemens.com>
 <ZxiUfpco2aJapBrI@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ZxiUfpco2aJapBrI@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0437.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: bb356a4f-8893-4198-8b0a-08dcf32a8267
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?UVJnN0l6WWZmWEY1b1A4ZmlVcStob2ZEWHRtbTBmNXludkRCRzRwQjFyMWVR?=
 =?utf-8?B?RW42Nlc2WDJuZzRoTWMwUng4TG9MQlhOT2RtSTZQc0EzU3dJWnQvbEZpaXZr?=
 =?utf-8?B?N1BsSGE3cEdNQURuRkljalhNaW5yZFhlOEh3cDU1OUhjMzMvWVp1Mks3dDIr?=
 =?utf-8?B?azhKaFRIYVFSVW9BdVE4NkRUYW9IWHlhRHZDb0d2bGxhZm80U2lRRW5rTEE4?=
 =?utf-8?B?YXhpYjZ4Vk0vNG1ZZkJVeHZtdW1RUWpUUE1uM3FNK2VZNWExalk4eTRPek5H?=
 =?utf-8?B?amJ5c2dOaGw4NGIvZUZvaFdTOVBxdVBMUXJwZTV3NTJUaFBnT1VFdHpsU0FH?=
 =?utf-8?B?T2xRTk54cWpBWkdDdFkwaXcrMnRnc3R3TjZpZnRZa2V6SmJCNXFxb25Belly?=
 =?utf-8?B?Y2J5Wk1KeXRUN0dKazNIWjdaUWY1ZldpVDI5Vkxoa3YwSFBxNnRKanRRSkhT?=
 =?utf-8?B?L0ZPbnJqSS9rY3ZyNjJXSzJWN2QvdVV3Y0FTYVFkS0Z6SU5WcVRrc1NHTWlt?=
 =?utf-8?B?N254OHh5RG1yaDhvYmpnenlseURFa3hTeVRQSjBnMkpKcEJLejNkTEQrL1g0?=
 =?utf-8?B?OEc2YXhQMW9hVmhST2lVRmlYRXNOTVcwR2FsNC9idVQyQkJCZ2t0RUJhWTIw?=
 =?utf-8?B?UUsvMXZJSUpjOFl3M1FHN3owY29sL3U1VGZzcjltZjAxeUF3S3d5MXJtZEw3?=
 =?utf-8?B?Um1SaENyVVlmaVlYOGllK25ZRVdQaWtidXRvSE5PSHlXR0lrNU5CY2thRVFN?=
 =?utf-8?B?Vkt3QVFrc3ZlS1ZqV3d3RmtKdFFBOWk5dkY0M2VtWm1vZEcrV29Vd2FMcE1u?=
 =?utf-8?B?VHRTYWUvQUh1UXk1SzR3clBYek9sRmdwRXgxZzZOTFBJUDlPWnBiRFhHRklS?=
 =?utf-8?B?RU1YbncvVzJKdjNXU3NJYUdMa25OME13NmdaL1VqQnhDZ0tscVFGL3I4UmhW?=
 =?utf-8?B?aHZORGJrelhpZjJQbjFtKzFLMEVETEd6SWZkcXBqejAvUm5pcFRpYnEwOFRy?=
 =?utf-8?B?SE9MM2VPZnpVUVEvaHkzMTQ3ZzBNVEs2dWk2WGJLN1hsamp2K1ZiMG01aGJV?=
 =?utf-8?B?Zm1sazZ5N0RnY05tRUhoQTNkdUxuZjZQdTFDdndiWmtjUks2WjhjRnFCM2xt?=
 =?utf-8?B?UGNONmc2SUhjSTExbjRkaDdIOVFmN25FVVV5MHkzN1N3QkRqNUdCNGVkY3pJ?=
 =?utf-8?B?S0RKVURod1NUaWdlTVFEWiszellyNjJxRTVxUk9oaEhxT3RjWjZObEdqc1J6?=
 =?utf-8?B?MFVROEdlWERYNE5KWks1TnEwZGczOE1NNXRKck1JeTFmYmZVYStQVUthbVhQ?=
 =?utf-8?B?RENJa1N0RlhKOFdDTTlHdjZ1K1RkNkt4eDA4N3NLUjl6QVczUUNkVUVSOWQ5?=
 =?utf-8?B?cW4vajU3QzJaNGtjUGN2T2Nnd3gyQW02U3hIdDNBMXJGNFZhTEwvRmcybXRv?=
 =?utf-8?B?dzRKOTJKeGZicnovU095cTYyRnZoM1RtSjVTaWwyRDE0ZFFndzVRNVE2SklF?=
 =?utf-8?B?THAzeTFGbHJycEdHalltbUs1NG4reDlldUhmK2xnd3gvaHhRZitCMnMyNVBn?=
 =?utf-8?B?dFRMQ3FpK0ZhMWpKTURaMGo3a2JXNTUyU1ZHRmgvVEdqR1hzZW40aCs3QWIx?=
 =?utf-8?B?L0lHMTNUYkxpeTEyNUEwL0ttUW1qbm04dnZVOVV3dXcvSzQ0N0pFRFFMNm55?=
 =?utf-8?B?bEp2c1pNMm9WVTFHYTk5RlFlWGxkZFJ2VHZuQ3lEMTllT0dHVUJleCs5SkFo?=
 =?utf-8?Q?9ap6yLViMIdezryBwSXuwwjL3a7Hw5Db7liAE0W?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?c016VXlnSTcvdWo2WEVzdlJzWHM2NmpKTGRkSzFEczhmYmNQem14REN6ZFNY?=
 =?utf-8?B?eVN2N203cjFWVkhBa29qUXAreTI5My8vRTZqc3loUnlVNEFZZG1qMGR6cW9Y?=
 =?utf-8?B?R21tRDU3Smc0c0RzREFEa3NUNVhWeEI0Wnl1aVlVeUcrbFNYamROVTVUcEpt?=
 =?utf-8?B?d0R0RVp5Y1h4UzJrR2p3WGlJM0RGUkJqeVZDNkJzUWQzQ09HVW5yWGVBM2hx?=
 =?utf-8?B?WFp2K1Z4d1NNc3FPYWpiVm5abmM1ZkJqTXp5MlhMa3krdEdrNHVIYU1xeFNP?=
 =?utf-8?B?N2xZdmNGR2dOLzRmQU5EdmhJejdVKzFJWjdObXB6cHBidGdoL2UvTFdHL3NN?=
 =?utf-8?B?ajhTWGs4UUtmdjlqeVhrcFhZeG9WMjRZT2VRcVVMS0NEd0l3MTNwbFFiNnNK?=
 =?utf-8?B?MEpEMDRuSldjcWhZU0pGTEF5QzZ1NDk4RitwVWNCTStmMHF4QWNPWHlqQWRL?=
 =?utf-8?B?VGk3ZmJGYUFKRmh6aUlBREJQWkxPV1UzNDZWQTdhTk1tVlo2WXV4clhBcFJ2?=
 =?utf-8?B?a0JoYXJHK0IvR0IvQUpzRjFDYVNqYTNYQWRZaXRHMkZRakg1aVlLU083Tm53?=
 =?utf-8?B?dG5mVEdFNWdRWWRNclg2aEhYTnBUb1FpZE1zVXIwRE9HTFZaRWp6UGhxMTVU?=
 =?utf-8?B?L3pWT24wWHJQUFpRVVpVdEd3eWtXYXNIby8vN0lES3MrNjF0aWhTZVRCSUo3?=
 =?utf-8?B?R1d6LzRwMmw2R1FWdVhQRTFKRVRJanE5a21XZHkyNUUvM29Ed0plRCtmS0dm?=
 =?utf-8?B?dkxHRzMwbm9BMnhOTStkelMyRkRab2Q3d2w4ODBhQysxZmtTdm5GWThDdy9z?=
 =?utf-8?B?RE1HcFp2WFFYRVRpTm42UUdqYkhvSjJsRUJha21rTjdXOGFmODgwekxSVFgy?=
 =?utf-8?B?dExoUC9QR0xtaE93c0dvRGtTZE9GQWQyN2ZRcmFVTkRsUUxpaTJOVnplS3lV?=
 =?utf-8?B?aWJsZ1g0eXhjQU50MEJGVENlQjM4LzFieDBZYkE0eVVwbU11MmdwY3p0S0pn?=
 =?utf-8?B?NGc0TE9pN0w3ckdGcmJibzgyUlkyZDFRYWFFOVVyNEExbUxYTXBJTnd1d09q?=
 =?utf-8?B?bFNPbGV4OVZFNWd5OWR0TEFISkNaRVRrd2dkQ29TcFFraVQ1Q3RUOXVqSVl0?=
 =?utf-8?B?WGJISWQwMFVacjk1ZXEwSjQxQzZSaXNEbW5HNzFzZDdzUTVxSG1QMU4vUTRC?=
 =?utf-8?B?a21vRFBHWnByU3REVDlOTk5MWlBJRE1zMUlWbDVxaVFXY2JKK1loV0lXOFdS?=
 =?utf-8?B?WFZodFNMeXZEYjRwQUlnNC8vOVN2RFA1UzVxWFBmc2EwVm9jRWkyM3l1TG5j?=
 =?utf-8?B?eUcrZGVzMFlVeDljTm96L1BNTjFrTTZpN2hVMFNJVkJjMjZmL0tpT3dWS0l4?=
 =?utf-8?B?SHNjSGNocHhtZExUaUVXKzNCYmUvWXY5Q2ZQLy80OGNTcDhXalN3c2ZrUDRE?=
 =?utf-8?B?MlQ0ZjQwbU9TZnphTmFBQzNSOEU3ZDBMOHhSTy8xMXAyaHdJSm90dXh6cis5?=
 =?utf-8?B?Z0VxeWc4SHBQUUtETzdXWGRBcUZKc0Q4RlhMbnBLL0xuazVaR2libVNiYkE0?=
 =?utf-8?B?Y2xSN1d1UkxOZXpmalFIK2s2bmRLSmphVDFRdHRQRUNjYVFnSENYSndzUXZw?=
 =?utf-8?B?UnN4K1JlV2NkQi85dXNXTGF3TEp6djN3Qnp3dVJaR0VIT1hRWXdxd25jYnRU?=
 =?utf-8?B?NEFWb1p2Sk96UE40ZjdhOC9vYmp1WGgwd2huYkE3Z0FrNW5tT1F0bVg3M0JK?=
 =?utf-8?B?MVJmU0FSdm1hWnVySGtkaHh0UWhpTE43L0Q2T1IyQmNIZGhuT0VEUEJEUHlN?=
 =?utf-8?B?ZVFLQWY0SFJaaVVaRkZiTGVWQ1E4Skh0ZWxZc1NLRUxIKzkzbjZJM2U0akhL?=
 =?utf-8?B?U1U4NkhMQ1VpT0VtazlaeHVPc1RlaDY2NVAvQ1YzMHpLbVQySEVENTBUb1Zn?=
 =?utf-8?B?bHZnN0w3a0JZRi9NQnBJazBXOGR5QW10bU9wM3Q3aWcydW51Mlc2d1YvN0ph?=
 =?utf-8?B?aXlWY0JaQlVJQk55ejkrT0ZUZlc4VHlLLzRnM1dQSVpORE82RDlrdCtzSDhh?=
 =?utf-8?B?UWF1djlrNHV4eEdKaE41dTRCcjZnd3Y5Q3JMMWxBNHdNTFNEU2FpQm5BWHlX?=
 =?utf-8?B?QlBOWmJxbkZVZ255N0FqVXlLL2R1aWFwM3hTQjlJYXlLcEZYdURacUNwYitQ?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb356a4f-8893-4198-8b0a-08dcf32a8267
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 06:18:28.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xd9r7f3uOfXtS4CRyonW2XJpgaimnsSNTOeL8ePhyYXXA7fsrLVc/jfi4sZhKahGpAC0YJtPJUAhZ0CWyGfgmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6798
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Oct 2024 06:18:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17072

On 23.10.24 08:15, Pavel Machek wrote:
> Hi!
> 
>>> New realtime trees should be available at kernel.org.
>>>
>>> Trees are available at
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt
>>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt-rebase
>>>
>>> And their content should be identical. There are also tar archives, at:
>>>
>>> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>>>
>>
>> Cedric pointed out that localversion-cip-rt of this release was not
>> updated. Is that not happening via some release script? Can we do that
>> in future to avoid such glitches?
> 
> Sorry about that. Yes, I'm slowly scripting it, but it is hard due to
> different releases being different (-cip vs. -cip-rt and 4.4 vs. rest)
> and due to way that part is local, part is web-based, and part is
> email-based.
> 
> What do we do here? Just live with the glitch?
> 

I would say so, will get corrected with the next release.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

