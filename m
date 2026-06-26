Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CADC43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 15:33:38 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37928.1782488010291504515
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jun 2026 08:33:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=j9Frp0g/;
 spf=pass (domain: siemens.com, ip: 52.101.70.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLBo2HfxtOBuV9i3wZbx8M0N6gwi90AESHeQPyg2vp4v358x/q5mux9Uvg97kCovB5MImSq89CVjTpd+BgdXNzGoFhvwL9l3SLlzx1i2qF/VeoDxNMgX8bVwst7wEuPkgmoiN806CzpB+kf9kpYP9Rcc4OzOTvBSZpIhkcr+eu6joZa6SjeZ/kUfH8Xir0duehYF93wDzseqcv7u3Qa8GJiPJfO/kd+M9URhgry2fmV1t/73EsSRZeNNJ1//R7pO88caDgXCSXX5l2auenIJD1Olgo1omiRQhggLOBkjtDiTUCrCqH9prUO+BtJCSRcFN7hVPGXHmqAsY96rzhgvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nx6x7LXicTr8PT7eO0jMfYnIW3l4gDsFT+3n2h0mTwA=;
 b=HZRwwFXjnlTgyGLGZPO7XNzUgi2fvI2u6gp3SPyaoHbXCOY5sP8L70eOhMVlzVdYVIoWWcXfUIMo8+3ix13/xJyHQg3qys+TU+8Lo2r5HgfX9aTYPSNGAHKVXnxk64HxWnzoh9ESYP1MaMi6W3vdLfD/XrHbG2s5DPrb386Lq1Pm5iWfWw/OVc4E6liFpHwfG0WkIvY7+0JuUr6JoTu21lQwa79zGnjU57OgLYacLflGXUa/ClxdK5ao0Im6GHzPuFXF+BCFI3GsqVjahnXWXfJRMybxdwUSUVQvy4BwVtXnEqNjW35wBKcAAhnptmdmIChvaR/Wb0WvuyHyKt+cbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx6x7LXicTr8PT7eO0jMfYnIW3l4gDsFT+3n2h0mTwA=;
 b=j9Frp0g/appeDp/pHLRbD05Mzsi5sv0BcRkXvfnOK8uqGf5w6GVB59NJcJ4HVzvdedJGCHPhhMDtCAITWieTZPH7UDkRLY/fmfoCjXW/LbaLC9TBV3n+TzEL4k4SZ0b2AuboO21gGTn4Xi19tZ+p+iEe8SsmI5TIFgfhhKCobjoPkwuTPsL40q0z5gOJsmjydqwmC3eshFLd4gZckWpLMQcD5HjKac0xcyaq0TmOWICqlnBEWgIb40NTtbsnVy6EqbYkMU6WBQ6FuJPppFW5VObLFTV5WJ7g+hVeFhezibilruXP5eJHGx+u7gNbhSLW6dDdXUNrx1nkQibcTRkWcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 15:33:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 15:33:26 +0000
Message-ID: <2c422df4-0d07-41bc-a630-beaf89da79fe@siemens.com>
Date: Fri, 26 Jun 2026 17:33:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-config: Set DPKG_ARCH to
 any
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, cedric.hombourger@siemens.com
References: <20260626152038.103044-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260626152038.103044-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0097.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5c3113-bf08-44fd-56e9-08ded39843ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	8V0zyPPUbdYUk1E3dfOUBnQPBzE0eUbOoqKQnJfO9xW9cVqg7+bXqoEMvdXOEgBaAS/aMgXG/rqgVauUcLTlXrF7AN7CBsmQWZlDELeupZZpo/zCRo8uMDPUg06doOayTqi5IS7joGEnIc6eCZEetdrYQvNRnxe/7x/VGg/HQXJD/c1/uabppQJezuVIHqAeHp2h6y2GoA8mUJ/XVKS8WIgRUcZncddMDCtt3mPzbAJiDrXg0V6jCll5ZcojPBZKn4cXmSUWDWi3n3b32R+1IvJ9h1BDo+JwLPo68iYOjnTekC/uGixQbznfjNW3VusIhU6UsmeesVkigzYxicVGNEWEG9IsfzxyTjsiKXaxZGATi7Vn/L3qFPjYtBKDxtmDtx8nlRvsMitklXYKEMoboPhznIeiYK+VmaW9WWSJ7nR7VS0s3M27usP13cm6hpgKauz3D/SQd6lGgFxH9ThoXw9voEqgk2ToQKAEQ7oeX2V2tLyIO68myqbbeyel8HNKUoIV0myxuUW7KjX//BnEgc8TeeUd2Szcysuakq1BtPh38g2x7wkX9bUxnUHLrkTmYmxknISiX0Wv+0ddzR4gGdQ4tk2013rGcwbucJ6wzkNQrQKscMFxzPtQ5cP4Q6UrnBA/aW2N0D3+nZ4Kj7zQDylSJBIaYmbds8Hz2mRjtvo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aERRdU1TTkRSVVRjNVZtNDBDRlVhTlBGNUNuZ2VxYUdLOFA1UFhxUWNlV2Rp?=
 =?utf-8?B?L2VmakFyS2Q5U3drcjJtMkVPS3RlVVErbmd5OE5BWHNhWTFOZ1F6U2VPS0cz?=
 =?utf-8?B?SXBVUEJEZHI1dG1rdGM3N0p5bVlrbjZwN3dXZC9WZzA0aDR2UURUYmpRYVVR?=
 =?utf-8?B?TzFXb1BVN0h0RUt5WVIxc3JYZ216dGhJdC9sNWwra0xEQmNxUUhYTTV1MXho?=
 =?utf-8?B?VnNGT2NmZjdxbmNrZEtkWGxPZ04zaHFHbEEvYlF4eGRtUE04cnBJY2R4Q2hJ?=
 =?utf-8?B?L3ZFTG8rOTRXYVJ4Ui9vMU1PdVA1WXdEVWJ5dTFTRVFBVldJeVh2V1haMGNE?=
 =?utf-8?B?NWN1dFYyTjdOMlJ0Mk1zeS9YVlR0dmp4Z0NHSWx2VUhibnJBczB5SVB5WGJo?=
 =?utf-8?B?WS9maEJZbWx2R1lvV1c4Y05RU2NFUm5BNnR0em1FakJZV2xyZFRsdTNJQ0tt?=
 =?utf-8?B?RVoxSGJhVTdLNktjUmFBTnljZ2gyeU5pQ0lXdEl5UUd2RUluTVVtNHRXK2l0?=
 =?utf-8?B?emtwM2M2Ylh1SDg2elNNbDJ3cEJmY1NsL0Ivb244RGJZVWRPZ1NaWm9yaDdu?=
 =?utf-8?B?S1JvQXorUmJtSEpGQ204VkZPOFJSY1Q3ZnZ2NjRLSXhzdTNYR1ZPQjVLMlRw?=
 =?utf-8?B?WDcwUWJ3MTlrcTVGRDFsVTM3bjZDdzdXU3plSW1wZGI0U1lQWldKUEF4ejB3?=
 =?utf-8?B?VTZiR3M1YjF4eDRmcmFTNUkvWU1GVk1POFU5NkE3c2IrVnVlY3F3QWROTTA5?=
 =?utf-8?B?NytxcWJCUXliTm5OckI5KzVBRWpOSmJoNHRJZEMyZE5NaktrUm1oYkhPMC9W?=
 =?utf-8?B?RTE3dVQzYzY0N2FzbHAxVE03TkpLVldTbGRVMzd2dUp1b3BiSFNSRGl1YWE1?=
 =?utf-8?B?c0kvczJsUnAwUVc3SGRybGxRSDBXZ0pFdzcyRS9IZnZyeGZRK1hkbVN5NFox?=
 =?utf-8?B?WkdUZ1B3S0VFZkVWNFIxY1RvdllZSTRHbTQxTWN1VUF5Kzhzb3NGS0psczd0?=
 =?utf-8?B?Skt1eksydVdwYm1pT09LN2tJWHFacytWak11bnZLaU40RjB6Qjl1REY5VjNa?=
 =?utf-8?B?VjhPazBLeWhkb0dZSTdYbkJrdHpHc2N5UGRBdHY5NitiUFFtYlZrak1HRE9M?=
 =?utf-8?B?UzNwS2JtTkFIQ1RxOEpiVllRWjYrNjRxSlQzWDF1Tks3QmJYUE5ueEtQYTVy?=
 =?utf-8?B?eE5qYm9nRmlqRW1CdFFYN2hudE5aZGQ5ZmloWTF4OGlhNzN6WjBmM3J0TlM2?=
 =?utf-8?B?dUdWZGFvZWtNc2sxRG9INEVFempzOGJ2d2NJaU5ibjFCT0xSRFJ4MSsxWS96?=
 =?utf-8?B?TjA2Wnd5b2I3NVk0TUg1S1ZhYldIb3hpQmxGdTJSWFA2cVozdWwxZ1F3K2tS?=
 =?utf-8?B?cCtYMS90SGlXSHdGQ0hHMm1QLzgzeloxQ3pabWFoOG0wMm5HS1lEMzZuSW41?=
 =?utf-8?B?eUdmUEwvNjkxYjFIR1EySmhPaTBSbDh2UWc3eWpia2VHT251VnpQaEo5U2Ni?=
 =?utf-8?B?WU9YRlJYdGE0N2ZZK083RW01L2gxRFF6Y0hDcENRSlRCdERLN0JyK0xDK0FI?=
 =?utf-8?B?ejh1LzVSbHZVYmVlay9SV1Y1SHF5Q1J3MFZiYlF5T0NYWWUyS2Rla3U1aU5D?=
 =?utf-8?B?NTlEaWdLWlZqNTRyczRXbXBnY3N6SEhNSk5ReVREbUsxR2JnTWFDUmhFT0J0?=
 =?utf-8?B?UVVIQTB4RHlLNXhXNnpkQkRJNjRabzE5SHBoNE5MWi9uaXdnZCtaSUlpdkhL?=
 =?utf-8?B?YTFNWktPdU12K1VhZSs1Wjk2L2F6Tzk5cXV5bjNCNUtGZ3o2SXpOQ0dDazk1?=
 =?utf-8?B?eXRMWDBNQlBxdzRrMHBEeUdSS1B1cVF6c2lwVzVEeGh4ZkFyNjJheWRkeFBX?=
 =?utf-8?B?d2Q3bW9GYnp3OWhER3BVVitRNHdIaHVJanVlK3hpWVJZY1Q5bzJkQitRM0lr?=
 =?utf-8?B?TGVLT1JyZ1JPZmFEeXVkeDFzUmw4aGhGTS9NcElaclhuWnlqTWN6bE1wSUlz?=
 =?utf-8?B?ejU0S1l2UGNhV0JSYnNxbk1wRWhHTmVURzdGc0xtbFJENlZDeTZRUm9uQmNo?=
 =?utf-8?B?c1ZzTEd0ZU1QdVRYRzhEejNoOUZrZ3F1d2ZQOGg2NlpTZkFaQ2tpU2djSFpv?=
 =?utf-8?B?WTZQSVAvZmN4V0hlcldYaW14R2ZyWGpEMFk1MFJLZ2xjSzBpNVIyaEgybE9G?=
 =?utf-8?B?Z1BSVFpwV3V3NExMUnMrQnZoUEpFSWRCTkttWnFqakJwWit6ejZuQWpuM0Vo?=
 =?utf-8?B?U21GU3g5Yit0N294bnhDVDE2RGRhd0kzUjJvdVJaNEM3R2VjMzZoSE5ra2N3?=
 =?utf-8?B?dFhEeEx4V2RscUNNMEwrQi8vZW1vZGE1d1ZnWXVUZHZrS3BHa1A0UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5c3113-bf08-44fd-56e9-08ded39843ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 15:33:26.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FK5soHMPBxLAkAtOK3G1dMd8X769AYxdvQ60bgdUCWALwTVMP5l/X4e0A0awc4JXILS0SDdbbn+OMSRiz6aEuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8237
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jun 2026 15:33:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23285

On 26.06.26 17:19, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This avoids the following error.
> 
> | Building dependency tree...
> | Reading state information...
> | Package swupdate-config is a virtual package provided by:
> |   swupdate-config-qemu-riscv64 0.2
> |   swupdate-config-qemu-arm64 0.2
> |
> | E: Package 'swupdate-config' has no installation candidate
> 
> This solution works in this case, but to confirm with the Debian
> standard we would need to add a conflict to all other versions of
> this packages.

...or add the machine name to the package name. How about that?

I assume you ran into that due to a rebuild over the same build folder,
first arm, then riscv or so, right? Please describe that as well.

Jan

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../{swupdate-config_0.2.bb => swupdate-config_0.3.bb}         | 3 +++
>  1 file changed, 3 insertions(+)
>  rename recipes-core/swupdate-config/{swupdate-config_0.2.bb => swupdate-config_0.3.bb} (90%)
> 
> diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.3.bb
> similarity index 90%
> rename from recipes-core/swupdate-config/swupdate-config_0.2.bb
> rename to recipes-core/swupdate-config/swupdate-config_0.3.bb
> index b48e3d1..013b957 100644
> --- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
> +++ b/recipes-core/swupdate-config/swupdate-config_0.3.bb
> @@ -19,6 +19,9 @@ DEBIAN_PROVIDES := "${PN}"
>  
>  PN .= "-${MACHINE}"
>  
> +# architecture specific package as it depends on the machine
> +DPKG_ARCH = "any"
> +
>  SRC_URI = "file://swupdate.cfg \
>             file://hwrevision.tmpl"
>  

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

