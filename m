Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0181FCD8C9D
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 15:58:42 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.58094.1780934317642378807
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2026 08:58:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mR1vwAd/;
 spf=pass (domain: siemens.com, ip: 52.101.83.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqodglmnkjLAaVg63zj6OU3nBV6BONuswp2KkSLAyFeraGJaC/ZtgKNsT555/H6Y1LQ6UZU6v83Tan4wmQIxMxzjLuUApht1gxTX2HBm+Uhlc/xSVVAmZNeCGRh+KKFRYlupu4ZwkqJsAoRpo09Mrxplesp4vlujckOzf0EBQarUPNB/A25jdWcd9SAWXDdM9WPfDSeZ/SnpcbHiz+72L2sc5WKi2vhZ1xceRXm4GPL5nOAX6G+WynPWqAVYxxid/CT9I3EWwrRWgh/EO2lHD71fXwmu2J5Tp7k2xxA1SFYgtstrF1HwmiqaVnCW8+Pr0hOv7b/JoBBJ/zbjSpr5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI1TvV9hoW44yRZDUm1PedEH/o3GVWHr4iFzZW6Y0r8=;
 b=CJ8CMjkCYl+Yh84JD/9ae4Md9hyTeXgq2zjTDncZHweL1a+dyWt+qL7KoUpSA+GPZS7O2MsdchNZnYTBn9+NJrHTlu4Pp03KgvORYdZWZ1J2t+zRCTK3mkKwqNeD9n1JnTFP9py1S16FgQj5iW1xBEIKBOACHxgF2eMeYVV1VLkS8gFPQheOQS4a6iCuz+2v42qY3biKrlD33F+qpElzJo2fWfjwcYGE22WoWX30UKC0skyTQ4Lpy49wrMLyi8QIk8Rj2hKZjrX41lQs4z5HFWUAGJFCLg4KJUdTIZ+gMOZo5IGMZnIlx8JMPqCcxITUDCBgxOf5kKqNY7X9yfuMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI1TvV9hoW44yRZDUm1PedEH/o3GVWHr4iFzZW6Y0r8=;
 b=mR1vwAd/KMOpAw1/1c1aX9TDTpBMNhjqnFapQGMtQP2lBgf+UndWthrVH/DDzuQRZWktZY7s2WohDBj9l62yMM6OCqvTctuFeiA5/mGo046HNL2dGGwpJ+8D+NYeaqpppf+KTuy5BMZS+TLDaKsZD4HPoEB6fG2ZTWzc4Q9+NIg/q4LLnfFHqPnMxusiuFA+AD0HuVNJRhNcOeoyJnOOVD/hvi9zwfXENNJJ966SSqKjaQhIvuOvsj6FWCJV1Qt8WXUZ6WW5Kd9FfMF3liE4RwarWoXHEbWnHrzvS2XOl8PCS6pSQwuEcajbtoP072li3ZKw6aVkhoLtYpZXHDYB6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB9915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:601::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 15:58:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 15:58:33 +0000
Message-ID: <261d45cc-3be0-4a92-8468-f6c0d5390414@siemens.com>
Date: Mon, 8 Jun 2026 17:58:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] add descriptions for dpkg-raw and
 initramfs-hook recipes
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260603145143.75868-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260603145143.75868-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0191.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d20c0a-79c2-4944-42ba-08dec576cb08
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	x0XOuhmQsIsOyVIWuKKntwt8uJjofXARjCWkeT93ygt2VW3X6QDtPYCCDWkOzqA6/PBfhHIot7OZsfV2fQ9UVLqJASzg2itzZYCtw8i89FIhK9ZRw55aI46wEx14LN+UCurRsNgONLSOJdkv7+aImYmUskhwRLF/qO1QSHaHsMq5BNxsQu57Z2vEdvWU1mN1ULZ2DVpirpBIVrxNGCKWM8pfrBtAbsZI57V3q5FcVVlQVaC8ouRmu8ql2507Y8Cp1savNFFhuz5eXLgRefrtrBORUPofsKXK6ilDsDOWUjl8ahrlaFMrXY0mXVXt4EEjEFJKdemI7nSZisoVpIjdpajjuZNfnWzN5gMP/lMeZjHSYGU94j8+MOdEv7kNZAxgF3nxR0gWuZhikby1Lb90uw5rp184j+Lvd5qIQMS7OyB0KD1x4bK6zoVOEN1ej2VWB1VtjcFhiqHJTKHPvvGSamboczH+zxM0gN3kIfU9TmKAPMgVg+4KOJbKelpdm9gPs5JiQB+3vvnfA0Ig5sFO2F/0cHROYphbxlsLKXqKKkKV2ZjW4ZILMkQb7NDdK1INEPdw6ournBnKjVZ6T4Zi7OguhZyva0rLxYqoQKxiDakctNyDjYtIsiBB5vGLzzJ6SC/NlYpELoidWI40Pg8Ob/3syJ2iw6IusTkPe9teukLz8jCbA3PxvoNKtu0jLO9n
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MVVqQ0NmTXk5Q2lSd3ZBTGtjdXBJSXpsR0QvVUNYNmtNV1g4ZVRzaXRxTXlh?=
 =?utf-8?B?N2RPdUtUTDVxdTZrbmdPOVhqaEttRUVuWjRIZXp0Tk0vaUpnUFVJcmtSenMw?=
 =?utf-8?B?YXZkMTdZMGhnT2l2T094K0NHQmw2VEY0ZG43c1ljeURsRWFIMzNIQUxhbmFn?=
 =?utf-8?B?VVhPaGdWeURGMkVDRldDQVFlcStQbkFBdmN4ak95U1ZLNWh2Z2V2U3RtNkJ3?=
 =?utf-8?B?SnhHVUs3cFZYSjlIa09XODJoK3BXSDFUMW0wdEFEWHZjdGQycE5Gakt4K0xz?=
 =?utf-8?B?T3J3M0VkeTYvRUprYnQ0VkxyTjVGNUZrcnhmVS80TC9wb2FpUWFzQUxXMnRK?=
 =?utf-8?B?MEhxM3VQaE1CQ0lBRkh1ekl6b3FWL29DVXhSdnMwRVAzekgvUm00SW1iMHJz?=
 =?utf-8?B?QVdXbmpyMDhpQ21lZkRvSk5rOXJxM3FvMVJabmFkUWhSc0hLSXM5WTNJQTZ6?=
 =?utf-8?B?cnI5d280TXR1dDJ3UkkwTjhUaUl2YnBlQ29OWTFIVUJVTEZCQnJwMThMaUNJ?=
 =?utf-8?B?cFJidEwwUmdVemoxdks5UXM3ZDl1dGhIdDR3amhreExJUEpXclA1bGtJTjBj?=
 =?utf-8?B?ZmxoR3JMckwxMUFNOSsxUDBVT3FIdERRc1VlRElJejRmTXdYemdYd242KzdM?=
 =?utf-8?B?MHNSQ0IxZTdtczdHSW0yWmJNU3Jmc0F0OXd1bXRkQUV4dTZQUHBxemtseE8y?=
 =?utf-8?B?bzZZMlB3Q0Y1SHF6SWV1enlCaFNYem11aE4vNXR5RnRGQ01zb1VodmdXM0RU?=
 =?utf-8?B?SUI5cHU0M2dmYVJJMTRxMTJwT3gyY0lMZ2RmRnlPeU1CNkFaWkZqa0Jwczhy?=
 =?utf-8?B?VlpEdWxWeTVxUG9MOFpOM3lPZFdhbGQ2TjZTVGtPalM2WFpiTVF0ZGRnWVkz?=
 =?utf-8?B?bHYvWm9TN3hLSkdlejRpbk1IdVBSTFRIVkp5RFJaVk9vanZhMy90N3BUWlRw?=
 =?utf-8?B?Y1BSdmJiQXgyMVNaeEJoUENtd3VWS0RsbjhwMzNXQm9icCt6L09RR1E0MlU1?=
 =?utf-8?B?RGJFd0JZa3lpcFViSktNY0Zpc3ZPa0hpdTBkLzJTUnZOSVN4dHQvUjNDd3FI?=
 =?utf-8?B?RUpCYk92dTFYeUo3QXJBanpKa2gzTlVyQStvUkE5Q1FCdTVUSWRhWVBBMjYz?=
 =?utf-8?B?aHVBTXVFMCswNDJEY3pmL3dLU0JQUGdKSkJ4V0IrZXA5WG1LT0VidzZpUDdD?=
 =?utf-8?B?UVdBM1RsWTl6SWhCaVJLOHVNV253Slk0clJ6Q2hxTFFGUlZldUg2V1ljRXJT?=
 =?utf-8?B?cHZPM2wrRE1PZDNHeGdUcWorRUNYVWt0Z2Q2QUUvd2pZRzJFTE1VQk9vSWFh?=
 =?utf-8?B?cGQ4T3RlSkhLOEpadFAwTTlLeUJBaDk0RThmMmVhN3FyRU5wTnBxZ1JoNFBG?=
 =?utf-8?B?VlN6M1QwOTdwZ2RSbVMxWEdydUVyNUYvdWttY2w3QjNOTVg5dEpMRjhMd0Vh?=
 =?utf-8?B?bUwwU3FNMDVpbWE4T1NsTWwrcXB0eHZyRkg5SktSS08wTnVpa1BEdFRIdGpa?=
 =?utf-8?B?blZVZzRJbWpTb0FoUEhHYXNVS3ZpenVWNWxpMGJJQ3l2TXlwNHVTUkladDVq?=
 =?utf-8?B?ZnVrZmVHNVoycWRja0hqZ01iSzdySTlRU1lZbkp0M3JwbzJ3QmdBUEQ1TndC?=
 =?utf-8?B?RmJKWUNJTVh5L3NCTmc2NmNrK085Q25BTEFkT1psWndFQy9aUGFhOHN3anRE?=
 =?utf-8?B?ckVIWkd5NlRsdXhqTlQwN1VuQzFRY0RyWWRXSkVIdURLU29VNjU4cWZZUTRO?=
 =?utf-8?B?OWpXeTNEeFJ6alplK2ZLSFcrdXhUa1MzTWd5ZzdzZlRiczlLdTNibWptZ08z?=
 =?utf-8?B?dGtYclZLL2FXa0ZWMEdTcE1raGs0NE11T29GdlNHS0VJNWhjZDdvckI2SSt6?=
 =?utf-8?B?d1p3RGt1NmJpNldJQVoyUVdwWG8rYkZlM1pjVkpEM0hyYSt6R2RFcWIrRkM0?=
 =?utf-8?B?dmUzZjQvL09TYVhEbTd4Q3I5Q0U2cExHWWx5cGNNanJaVHZORkhMZFo3b2lx?=
 =?utf-8?B?UEVEYkNpOGM1WDBiVmVyOWg3Mm1BRWZFVndTbGNZZ28xV3RIRU5BanFBSkU2?=
 =?utf-8?B?dkhqVWpmK1RGeEN0QW93WStDUG5iZnorTHJKcEwrck9vVDBjdCtSbnhaT2xX?=
 =?utf-8?B?TDQ3Ui9jN2ovSFBtZnFGdHZOenhuTTZsczlBQWV2Q2NqTFJTcHpaczMwT3lu?=
 =?utf-8?B?UU4xajhOeUorQnljQk14QjkxVnJSUUZFRTh0cm9Cd0FLTEp6T3JkcmtZd29T?=
 =?utf-8?B?YXQ0am1MdUFzVGRCWjJROEV6MWk1byt3OThlNTVOTTh6anRVM3pvTS93bzQ5?=
 =?utf-8?B?akZCcUlrNGhQNEg2MUZ6azVJRG1mVDRkUlIza05YcEJHaDU4N2dUalJsUENL?=
 =?utf-8?Q?5a/yxMM6OLicNzTs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d20c0a-79c2-4944-42ba-08dec576cb08
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 15:58:33.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd75vUcuemwBvOSFCu5znseUZSmDBB7YmInVq5FvDbx7xn1UeTlpNxd5i+GPCu8z/uAcueYWyvD9Cw+5yw+C2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB9915
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jun 2026 15:58:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23051

On 03.06.26 16:51, Felix Moessbauer wrote:
> The description must not be empty (isar requirement), and it ends
> up in the SBOM. For that, we add meaningfull descriptions to the
> packages we generate.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> Note, that the missing descriptions where discovered on an MTDA image build.
> 
>  recipes-core/home-fs/home-fs_0.1.bb                              | 1 +
>  recipes-core/journald-config/journald-config_0.1.bb              | 1 +
>  recipes-core/move-homedir-var/move-homedir-var_0.1.bb            | 1 +
>  recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb      | 1 +
>  recipes-core/swupdate-config/swupdate-config_0.2.bb              | 1 +
>  .../swupdate-handler-roundrobin_0.1.bb                           | 1 +
>  recipes-core/tmp-fs/tmp-fs_0.2.bb                                | 1 +
>  recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb      | 1 +
>  recipes-devtools/swupdate-signer/swupdate-signer-empty.bb        | 1 +
>  .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb       | 1 +
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb            | 1 +
>  .../initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb             | 1 +
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb         | 1 +
>  .../initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb       | 1 +
>  .../initramfs-verity-hook/initramfs-verity-hook_0.3.bb           | 1 +
>  15 files changed, 15 insertions(+)
> 
> diff --git a/recipes-core/home-fs/home-fs_0.1.bb b/recipes-core/home-fs/home-fs_0.1.bb
> index fd88f21..c99c32a 100644
> --- a/recipes-core/home-fs/home-fs_0.1.bb
> +++ b/recipes-core/home-fs/home-fs_0.1.bb
> @@ -11,6 +11,7 @@
>  inherit dpkg-raw
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Systemd unit to mount a dedicated /home filesystem"
>  
>  SRC_URI = "file://postinst \
>             file://home.mount"
> diff --git a/recipes-core/journald-config/journald-config_0.1.bb b/recipes-core/journald-config/journald-config_0.1.bb
> index 62fc0c7..62b569c 100644
> --- a/recipes-core/journald-config/journald-config_0.1.bb
> +++ b/recipes-core/journald-config/journald-config_0.1.bb
> @@ -11,6 +11,7 @@
>  inherit dpkg-raw
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Systemd journald drop-in configuration for persistent journal storage"
>  
>  SRC_URI = "file://persistent-journal.conf"
>  
> diff --git a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
> index 54e807a..a8d1318 100644
> --- a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
> +++ b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
> @@ -11,6 +11,7 @@
>  inherit dpkg-raw
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Relocate home directory data to /var"
>  
>  DEBIAN_CONFLICTS = "home-fs"
>  SRC_URI = "file://${BPN}.tmpfiles.tmpl"
> diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb
> index 70a2eb6..16abd5d 100644
> --- a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb
> +++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.2.bb
> @@ -12,6 +12,7 @@
>  inherit dpkg-raw
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "SWUpdate Suricatta WFX client configuration"
>  
>  PROVIDES := "${PN}"
>  DEBIAN_PROVIDES := "${PN}"
> diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> index cdfd8b9..b48e3d1 100644
> --- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
> +++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> @@ -12,6 +12,7 @@
>  inherit dpkg-raw
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "SWUpdate base configuration"
>  
>  PROVIDES := "${PN}"
>  DEBIAN_PROVIDES := "${PN}"
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index 2ba192c..d4d0f8d 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -11,6 +11,7 @@
>  inherit dpkg-raw
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Lua round-robin SWUpdate handler"
>  
>  PROVIDES = "swupdate-handlers"
>  
> diff --git a/recipes-core/tmp-fs/tmp-fs_0.2.bb b/recipes-core/tmp-fs/tmp-fs_0.2.bb
> index f2b7976..a361005 100644
> --- a/recipes-core/tmp-fs/tmp-fs_0.2.bb
> +++ b/recipes-core/tmp-fs/tmp-fs_0.2.bb
> @@ -11,6 +11,7 @@
>  inherit dpkg-raw
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "systemd unit to mount /tmp as tmpfs"
>  
>  SRC_URI = "file://postinst"
>  
> diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> index ee8d172..845bb9a 100644
> --- a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> +++ b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> @@ -11,6 +11,7 @@
>  inherit dpkg-raw
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "SWUpdate signer script to sign with deployed signing certificates"
>  
>  PROVIDES = "swupdate-signer"
>  DEBIAN_PROVIDES = "swupdate-signer"
> diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> index af9de76..c6f624e 100644
> --- a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> +++ b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> @@ -11,6 +11,7 @@
>  inherit dpkg-raw
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Placeholder SWUpdate signer that creates a dummy signature"
>  
>  PROVIDES = "swupdate-signer"
>  DEBIAN_PROVIDES = "swupdate-signer"
> diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
> index 48f6458..95331ba 100644
> --- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
> @@ -12,6 +12,7 @@
>  inherit initramfs-hook
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Initramfs hook for selecting and mounting the active A/B root filesystem"
>  
>  RDEPENDS += "initramfs-cip-functions"
>  DEBIAN_DEPENDS .= ", util-linux, initramfs-cip-functions"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> index 3cb0520..87d455d 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> @@ -12,6 +12,7 @@
>  inherit initramfs-hook
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Initramfs hook for TPM-backed encrypted partition setup and unlock"
>  
>  RDEPENDS += "initramfs-cip-functions"
>  
> diff --git a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
> index 2015503..6a3af29 100644
> --- a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
> @@ -12,5 +12,6 @@
>  inherit initramfs-hook
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Initramfs hook that adds EROFS filesystem support during early boot"
>  
>  HOOK_ADD_MODULES = "erofs"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> index 57b26ec..e201277 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> @@ -13,6 +13,7 @@
>  inherit initramfs-hook
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Initramfs hook for mounting writable overlays on top of immutable paths"
>  
>  INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
>  
> diff --git a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
> index 9ff4cbf..fccba26 100644
> --- a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
> @@ -12,5 +12,6 @@
>  inherit initramfs-hook
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Initramfs hook that adds SquashFS filesystem support during early boot"
>  
>  HOOK_ADD_MODULES = "squashfs"
> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
> index b2fb704..e67ae7c 100644
> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
> @@ -12,6 +12,7 @@
>  inherit initramfs-hook
>  
>  MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Initramfs hook for mounting dm-verity protected root filesystems"
>  
>  SRC_URI += " \
>      file://hook \

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

