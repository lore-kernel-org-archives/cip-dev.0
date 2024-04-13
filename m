Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E0CC04FF0
	for <webhook@archiver.kernel.org>; Sat, 13 Apr 2024 09:51:17 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.89])
 by mx.groups.io with SMTP id smtpd.web11.7667.1713001875243003535
 for <cip-dev@lists.cip-project.org>;
 Sat, 13 Apr 2024 02:51:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z8WXFnbZ;
 spf=pass (domain: siemens.com, ip: 40.107.13.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW9dhV9o2FcmsGhKS3rPqlCTKLEzYlYedSoJWlBtH/hNA3N/Zk3zAAySbuMUJG36AGrO7NqnT7ewoesk1Op5FXFrQBAFPwBbivS/g6WpE3FVhilWlguJgFaCR8q97wHAyXxNrDo25ROYndjsKjGjEW+Sfy2Qd9qrH1bLp5qQ3FPhFhDCEZyoXDPvB+PiQ3Fq8Ch4nlZUcMegpFYLy1UsdzOWX9QONJw8DoLZAVsRGbIEBhOOrgvw/xWZDDt3DVa22PxUUCjIwqfN/2NBgmt7SYE5zDfpLpMP6WP0D05nmfAK1/griKqDsfSBwMClgURQDupw8+JGzCzGQc3Kdwtmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COXMwR+zYEL1pnKTTw6hPDaa8TYryQMMhgIA7tQrCqs=;
 b=Ia476gRU2AbeUxQyfAlBOpA6ke5MM0AzpCAHpr2pc0PiSGU6r6Q1B+w3KBZJbaLTHv39wzSqvnnmNfFW3zdEAe3DOvY6RgLbjafB8+DbF8kO+UtjQeFMGQBY8gN10b79GXQlD9PBljU9w3tsdY2n6n3YjZwUO2iPzWPlnOjKz13sJJFJxnwXOJ4Pu/M05nfJh4iFdSydCdJFgC9Bto9rdJyAQ8WLhSqx1dPsRI1wfkjKLDUwr7q1HqV+6flw0Fk/f+Wf5U6Vw73nSB4w/yBedM+0ou0SO+DCC5iNdT8iH4aHaPP1a2/0Q+lrZQVSoEzQllDwi6AuIwHtlaC/nVYMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COXMwR+zYEL1pnKTTw6hPDaa8TYryQMMhgIA7tQrCqs=;
 b=z8WXFnbZ8Vw3gqlkfyH5YseGBqL1yoc9bx4A5BEZItWBuXtKlTh5+DmUch+8T6En7Tt6QrjDc+WBB5TtYzxQM3Z9AU5OAWNOZM9LiPl44GaLw6w1Q49VQHgUWGDY0a+PiF15+ITVbiEUwWN/51FtvsuNrQ5RsUALd9CkEeSIQ2NGueIi/8pGpqBUoV35UfTwNHSBUEGiWppqQ/L0B90F5N6E5YYGh4j/DN48x9eSNUexF1Dp6waa/s8UozlaMMsF7LX2Kva389AVbO/3biFvskwBZPx1UJApRgFWtfVzXn4Z8l+o2ES/e3sK1x07cQTYeu92VtBAxAkc+rhJACoMRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3971.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:144::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 09:51:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Sat, 13 Apr 2024
 09:51:12 +0000
Message-ID: <b7e8bf56-4bed-422a-8b69-ed782c726732@siemens.com>
Date: Sat, 13 Apr 2024 11:51:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] recipes-devtools: use DPKG_ARCH=all for arch-independent
 packages
To: Cedric Hombourger <cedric.hombourger@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240413091508.2429170-1-cedric.hombourger@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240413091508.2429170-1-cedric.hombourger@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3971:EE_
X-MS-Office365-Filtering-Correlation-Id: 191dd031-9c76-418b-6acc-08dc5b9f40e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qHYyP0E/guN7RJ+QtnHGZwhWD8OCG+933IY6H1mzgiPWN1ZwZPVYlRJ+hb5Du7Foe4lFGUOePLePoE0hfrwRfNh7vmGqZKiXouC8U0bYHYbBl5K5t2Mf9E7w2IiwQzE3TT3w5UxiZqicqWOisa4+RqqurFoxVEP1nGDW4CqvqmmsMnT7Lb+rtfoRQyvf96a5y9m0T/zuMb7MFZZ+GwUmJGf2S0jwcpxU3IrvXlqTwB3fdlHcRHIUxYl1u172LALqkc413RV8mmA9Skw0KFtmIYm+CUfFBxZgNQXfPvAVSR60UXNqi/f+YUy56rGdu04qVliAPrBeYlEaRs+b7hXbRuTXmjQoha6MJi0LyVaEGKj8B8Nw2BFqLg/igCWTYhD1OzfYYLCaVji/nJYu29zAm9lRjRxOlSrStzJnr0VVpgXOZjMDYU84FsODx/ndJGpowd/HFGUOTh5iZ7s+a0v/AQdV0Vo7FQLADLlg6bqRAngR3B1GwgxovOcDKo3VLnDH//5AATWxN2H+VI5aDicHgiLFHufqTWn3+HyESIZd8rvGE3iw20Qaq839I/4xQUMISiQ4gkn78Avmpb6xPIeQSgTeP8ZRBUZo39Pc7cbbk++De2PmWK15LfMJ7MdE43bxFZTx/EYQUw3YzcH0jUQZoIgXiGMi6wLSnZNt06Ojnk8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0cxU1BYMC9wZU9KV25tNXJPRFUyWFRFVDRkUkVUQWovaVI2enArOVJoWWlB?=
 =?utf-8?B?Y1dBVU4xLzlTcVlPNnh1QjIxUjUvS2crWGZpVFJyeE9CV0I1TmprMXhjYmwx?=
 =?utf-8?B?QTU1VzlwaVFpVDVmS1UrSS92M0Y3R05ESDVlckJ2VVJaaTA0VWc2dy8xYkts?=
 =?utf-8?B?VlcwSVRjdWRmWDJXL1FmTW03dlVHNkl5OHVWaGRQMW81S0Ntak9OcjBzamdM?=
 =?utf-8?B?RDVQN3JvY2cwUTFoaXhNZTB5Y1QzYWlBRVZIVW1KOGJPYXhOK2xUaVg3UHRO?=
 =?utf-8?B?VzZJckRpTDBRamF0TTRJZVllcFpNRzQzNlZ3VUtyazc5TmhMaUl3VENNT1li?=
 =?utf-8?B?L2FxM2QzN2p4QVFkYmxLQnlBd0NTaHRBVFV1eHNzRjY0S2luSEExaFJtUmdM?=
 =?utf-8?B?YWxzOHBQSnBuOXJQZVZFSFFxWTJnekJpcDdhVzhGVW84UVJERyswbmtkTzdv?=
 =?utf-8?B?RzRKdlZXZHZ3ZERRc1N1REp1SjBHN2NpY2NBNDNkM0VyUDNXdFBEVWtKUmh4?=
 =?utf-8?B?Qk1xUDNCTXlVTHZpOW96N1FvOFNwU0w1YmhDdWVXTkI0cldISzZiNWdJSTJ5?=
 =?utf-8?B?RjRFWkRoOVU0NkphdEx2TTQ3SkU0VVZFRTB2cksxNXlXWTNrTHAxaUZTWWZa?=
 =?utf-8?B?eGY2VVZWN2dDWnJGWnRZb2RPcmhJTEtkR0l2aDQxVCtOUGprRGRzU0pmMXAy?=
 =?utf-8?B?QVN3YjdqR2ZwQ3N0Y0JZYWNVWHc3dDIwUldXUS9oaWwxUksrMmJFZisvRWNU?=
 =?utf-8?B?VEdaQkJWbjA4dkYxKzM0aU9ac0V2WHpPZ0t1MEtTaDJHR2FFNko3UDRUaTVm?=
 =?utf-8?B?cmc0bitTdXpGR3dPYmxxY3FZOXppbkJhY3NXZUtpOXdWQjJmRm5wdlhLL25p?=
 =?utf-8?B?RFhiV29RNjRaMlBNcityMnVRTUtjOEYxZVAzN1Fwb1BZZVdMYUVnaU1HOUhZ?=
 =?utf-8?B?KzV4QkF3NE40Ryt4VzdKaFlkb09tbE5JSUJRNHJyZjBOM29GQmcrRzhpMXNh?=
 =?utf-8?B?TURBc3FTWGFJL0UyZnpIdml3aFVueGhkVnlHMmJITlBJOHJQTjFaSHZJR2Fa?=
 =?utf-8?B?SkR0djhzOHEyRUxCeTZFaUkxaUFOR0xySHF3akZVV1lhS0Zrdm5JWGZXekFw?=
 =?utf-8?B?Q1BKY0k0T3F0TXNVK0tkcG92V284NkhmYlBsUXg2cktCS0FWUWY2QWljM1lI?=
 =?utf-8?B?ZUhONERWanRRNEhhd1o2UDdQcG53MjFJT2IyOVkwRlNiT21Jd2lTNGVVMXdZ?=
 =?utf-8?B?ZG5nOFl3UHhIclRaOVFkSUt2bHZ4RzdPeGljQ1U4aGFra2prdVVvbGtmQ0to?=
 =?utf-8?B?Nm9NbmVtVFJ3M05lTThkbTQ5d0Q5ZVdlZDdnRWR0MXplT04vN2cxVFE4VFBQ?=
 =?utf-8?B?anRabDd6UXVFcnA5TjNxUk9rTlR5akpHK1ZaZmFYblIrbVBqT2J2aEsyaTFY?=
 =?utf-8?B?OEwyR2JDeVpPZUtNbGxMNFg3VzVWR0pBMVZCYUlHaC9KT0FQVVh0bHdiTk1T?=
 =?utf-8?B?bUk4ekVNOE1FOHF6Y3FJVlZidWJGMmJDakZKV1BDVFF5TXdONGtETitPa2R4?=
 =?utf-8?B?L2NsY0RiUDB3N0RyV2NrVWc4KzNDb1ZEeWJ2TytrYjhnZGZnTUJQd2NRQklz?=
 =?utf-8?B?bFZPNGh5SnlGTStTTlRacHByb1VYSGJGbnBEa3N1NVZrU0hmVGt4M0FVWWpP?=
 =?utf-8?B?dFBVWTVPY1REcVJTNTBvZmE4aUptV1BLalZza1M3cjAybzBRaHBja3ZCdXZk?=
 =?utf-8?B?b3JzcUpjbm5vZSthOXgveXRLUE1TVUNUUHQxd041QkVlTjJackxLYlNKcHkw?=
 =?utf-8?B?ZEY0SXI0eWlRaTh2UEI2a3g0NXpQVnBjMVpPVVlaNXZ3elBHbEFmV0h6N216?=
 =?utf-8?B?cVVYVVMxNi9BNURMVWI2WEJXbk01eU9aa2cxanR5QlpJYzJGUm9HYTVVTG5B?=
 =?utf-8?B?ek16cW1vTUxBdjk5MUVRN3h0ZGpRRlNXdjk4S0NHblRSSXAvczdFekprSktU?=
 =?utf-8?B?UW1iWUE0YnFSN2pRZEpOdEpQUzhzTFd5NWpSZTY1Q1R1TWlVcy9Rdk45RnVk?=
 =?utf-8?B?UnA1YXB4R1FSNnRESFBXMzJxRUNJSWRiWVN4aHlUTkhFbGN2a0dWYnA5ZXZK?=
 =?utf-8?Q?ClqxmjitaqA8zKQIlcYeeiGYp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191dd031-9c76-418b-6acc-08dc5b9f40e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 09:51:12.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaBcT6H2DAqvjO094k2kpb1B8/j1RGBzepok3Q0iz7w7K6M2/oGXFRruQysZKuMhhi1zGjDBa+juzT0oNtdnoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3971
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Apr 2024 09:51:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15552

On 13.04.24 11:15, Cedric Hombourger wrote:
> Most devtools packages are architecture-independent and should really
> be built with "Package: all" instead of "Package: any". Bump PV for
> all affected packages (to be "apt full-upgrade" friendly).
> 
> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
> ---
>  ...g-secure-boot-signer_0.1.bb => ebg-secure-boot-signer_0.2.bb} | 1 +
>  .../{secure-boot-key_0.1.bb => secure-boot-key_0.2.bb}           | 0
>  recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc     | 1 +
>  .../{secure-boot-snakeoil_0.1.bb => secure-boot-snakeoil_0.2.bb} | 0
>  ...snakeoil_0.1.bb => swupdate-certificates-key-snakeoil_0.2.bb} | 0
>  .../swupdate-certificates/swupdate-certificates-key.inc          | 1 +
>  ...-certificates-key_0.1.bb => swupdate-certificates-key_0.2.bb} | 0
>  recipes-devtools/swupdate-certificates/swupdate-certificates.inc | 1 +
>  ...swupdate-certificates_0.1.bb => swupdate-certificates_0.2.bb} | 0
>  9 files changed, 4 insertions(+)
>  rename recipes-devtools/ebg-secure-boot-signer/{ebg-secure-boot-signer_0.1.bb => ebg-secure-boot-signer_0.2.bb} (96%)
>  rename recipes-devtools/secure-boot-secrets/{secure-boot-key_0.1.bb => secure-boot-key_0.2.bb} (100%)
>  rename recipes-devtools/secure-boot-secrets/{secure-boot-snakeoil_0.1.bb => secure-boot-snakeoil_0.2.bb} (100%)
>  rename recipes-devtools/swupdate-certificates/{swupdate-certificates-key-snakeoil_0.1.bb => swupdate-certificates-key-snakeoil_0.2.bb} (100%)
>  rename recipes-devtools/swupdate-certificates/{swupdate-certificates-key_0.1.bb => swupdate-certificates-key_0.2.bb} (100%)
>  rename recipes-devtools/swupdate-certificates/{swupdate-certificates_0.1.bb => swupdate-certificates_0.2.bb} (100%)
> 
> diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> similarity index 96%
> rename from recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
> rename to recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> index 57ad1be..83289d4 100644
> --- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
> +++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> @@ -16,6 +16,7 @@ DESCRIPTION = "Signing script for EFI Boot Guard setups"
>  
>  DEPENDS = "secure-boot-secrets"
>  DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
> +DPKG_ARCH = "all"
>  
>  SRC_URI = "file://sign_secure_image.sh"
>  
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-key_0.1.bb b/recipes-devtools/secure-boot-secrets/secure-boot-key_0.2.bb
> similarity index 100%
> rename from recipes-devtools/secure-boot-secrets/secure-boot-key_0.1.bb
> rename to recipes-devtools/secure-boot-secrets/secure-boot-key_0.2.bb
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> index 76233b3..859637f 100644
> --- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> @@ -11,6 +11,7 @@
>  
>  inherit dpkg-raw
>  
> +DPKG_ARCH = "all"
>  PROVIDES += "secure-boot-secrets"
>  
>  SB_KEY ??= ""
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb
> similarity index 100%
> rename from recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
> rename to recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.2.bb
> similarity index 100%
> rename from recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
> rename to recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.2.bb
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> index 2c67e89..944c2dc 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -13,6 +13,7 @@ inherit dpkg-raw
>  
>  FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>  
> +DPKG_ARCH = "all"
>  PROVIDES += "swupdate-certificates-key"
>  
>  SWU_SIGN_KEY ??= ""
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.2.bb
> similarity index 100%
> rename from recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
> rename to recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.2.bb
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> index 564dda4..d319d8e 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> @@ -13,6 +13,7 @@ inherit dpkg-raw
>  
>  FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>  
> +DPKG_ARCH = "all"
>  PROVIDES += "swupdate-certificates"
>  
>  SWU_SIGN_CERT ??= ""
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb
> similarity index 100%
> rename from recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
> rename to recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb

I think you missed to also bumb
recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


