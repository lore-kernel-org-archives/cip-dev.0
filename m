Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17641.1794921278364196678
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 05:14:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oVPQKVXh;
 spf=pass (domain: siemens.com, ip: 40.107.159.32, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJVuYmZmWS+FOI1A6KkFzu7NhferlX/O2Fojo1QVwQqWWq95/v/6xEtEhl2EVXvylmlDTu1P1wMe9r00soTpAjhmEdL+9l+K3vmXSk/BidkN4fvGorRFLfVctZvAIBLfyI3qZXdxc+eGSHwt2P5y3V46gKtZ3Awc8RAsyKIbnil9OvlY3odqa7Zz5LxVewY04SkwSyyCc0CmLhJzzBPiOGOdX1QmGrCm2xlFlr1scc+b7WvAUCGItx7O5M75ldOtRl8zkhznne+YhHzA9E48QRKCI9SMFl5tCPYDrDLylqzh2W7OISPknIIIm6am+GjPA8gken5hGE4VOHVS0oWXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MSf++5GxnXwzRVOHEAKw5K1hVinsCspYj3OysN1ceQ=;
 b=sqN7GP8gli1WXuVgPIHAEacz1eQBhrrcXZIMW3CY6xPO20BB7qpUUnMJlvD2vG7lK/sobNlM7EQ9n7D1WmDUWAvJISEgn+G4XT0FTCN8dHqlhmCTendvPzIcII2ftuEjkazwqD3m7pHUuHs4MM0ry0Onu13m5q1S3HIEAtgWtmRWLC73DvIa/blSGBY5YbwS8wGtgv6Ts6m0p53CyP8Ifbc6GEJ/vM1/tEQb/ZaUYjAM28n1mrPpG8wMo4J5R7XI0T100WG/f6YwoZSHnZBVNB6tBmgHH+HgatVuV9oNMs7preGJsuHhmUScNFOkg4vlOZ6zzaP3jiWWzEZnsOcqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MSf++5GxnXwzRVOHEAKw5K1hVinsCspYj3OysN1ceQ=;
 b=oVPQKVXhZGzRLyGNJVnPVdmOrfnyWQJ93xGetp02PI1nR8A7Qv/q3iteJ8ML97BxXdyiUaJMVTgMS7RhZz2ZdigqP86K2u63UyBhwdhkJGwDWG+AarolpNhG/hBdmlJ4Tu3pkZs1SfT9r6yjO3RsUwPeV5MG+rNS4mSSUyUflHJ026X/74DeagVyD/NH5pp+SnPlLnTGs7U0PmppTpx5sDCt/6K4Mey28Omz7dojXWhBM4hjManS49g9c1vlngv6WphYry7ei9T93m+NnKL4dVkDndBoWdRTde/1iw/1oclVlttoOMZ89YMPGlOJtR5XwoDNquTYArrw+PuBv8rNMQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS1PR10MB7957.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:481::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 13:14:33 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 13:14:33 +0000
Message-ID: <d6bfcc9d-bb1f-4203-92b3-a4bc37835238@siemens.com>
Date: Tue, 17 Nov 2026 14:14:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to
 4.19.325-cip137[-rt51], 5.10.272-cip79[-rt35], 6.1.190-cip62, 6.12.117-cip35
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20261117123846.177888-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261117123846.177888-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS1PR10MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b84f7f-e419-4abf-11eb-08df44acb88f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|6133799003|261009223027099003|55112099003|11063799006|56012099006|10067099003|261021123027099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: VQs5zWoBvZbZbwxyhi6BGvKkrkvjysfs9mF2hc6mHzAaiknplGTsqxnFaKA1UxRnpCLrkOqErfnCIm25C3sio+H4bJowiIQ65Scb6mvwBGaIozJXXOUkwYkUBfVCw3ltv3lDM7VhEHEqjDeQLpv4KBjVJ3V/n++QgW5+vrEy/dH6XekMrmyKir56agHbcYstaNqXVFVUnYskKVpZJypDdrSVgXGBXRGLKXCGTg1SxXJcZ/6JJvRvsoYbwnMV5XAdz+gWWCE/0tCuXquP86lEkoXLmHHDZ28F3eUwri1FPyzAVY6V6tv5kcdYx7MUxsxKl9bs3USJCIbDjzbj/n+6zuYH7GT9PExSzAHBPz9wxWwEhZylP2RA1v27uv8gsUqXX5aiBAxcGp7Ryrnk8rRhzxEqqOQhAJcKo5HNpvO8I9PY2xkjmR0tLzeoJhOggG4+XmsM32SGtaIfgL6vgvjxSOlbnCMeU3jueOgcitfcaYuuooVQOpMCgOsYS52FvZvL4F857rgkwTBT4w5/BGeUaqyJyUGcpjtIIlYZaaStLqYdHEQI7eu6uAL4Lv+h2M3O3qmVsbbupDqxWTMbNDa0eQUZP7tVdq1M3uxCREJm9KboH/besy0O2Ka/gh7uTpAaXFPvye3/p84o8OsbkpBqZcg7NB0bqStrFrFPwP87RhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(55112099003)(11063799006)(56012099006)(10067099003)(261021123027099003)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDh3MU1mdC91V1VVS1lMVVdXTG5XWXpWRy9TNEUyQlpXWkk5MjFaclRwNlZj?=
 =?utf-8?B?OW11YlRHRXFBemxOY3JZeERKaTBES0NwYWx6SnlpZCtiOUY2akJhYVBjRC8w?=
 =?utf-8?B?UkNKanU5ZkJtNmhqc0pqcjhUUzNpaklWcnQ3Sm5yL2lOcVYyeUIwTlRreW8v?=
 =?utf-8?B?TGZZUnY2aDJoOGJKVWRYMmdjazJnVkNIRHRiMjR2enJLTzBxbkJGeVIwSjdy?=
 =?utf-8?B?T093b1RSSlBnVlFnQkNObW1ZNDkwSm1heE5yTDdLY2F5SFh2WG8wellKRURQ?=
 =?utf-8?B?dTVRelFMSWFob1M0Mm5ldi9iNmhMdFlxVllCSnFNTUp0UXFJbURoRE1uaUt2?=
 =?utf-8?B?djRTMnBYckgxcGhlN1R1TTd1ODZ0eTBhLzJNWXdvRXBMcUt1TXZmbXVEeTVx?=
 =?utf-8?B?ejFVNXBselFoWTZ4VmJXSGdHU1AwZkhhbks0TzFwcStDcXU5YmdzUTJZOVAw?=
 =?utf-8?B?bllJN25pZnVTeHpsUHJ4NzZmd3I3Z2VHODkreW5qVDRnRllNM3pqekZvOEMy?=
 =?utf-8?B?ZkptRkZIMFJYdUJ4K0s2R1gyeEZjKzByN0FQejNPdjFxQWtSNE9CVmZKZDVt?=
 =?utf-8?B?SElxcDRET0JvM1ZnRWk5WldwTzk3NC9qb3N4UkE2djhQV0FrcEU5eUMxREc3?=
 =?utf-8?B?Nk1SWmdFdXRsUVRxZkkycHMzY0NhNU5sTTZRMHI1dTFUeFUrUlBTKzI4U00r?=
 =?utf-8?B?ei8zdUlSOFB1ZjZnS1M4SklLYVBYTzR5WTFQVmZuK0RVY0gzVHFIcVJuWFdr?=
 =?utf-8?B?dk8ybkFyYjNWQm4zWS9xdmZJd2RHWlJuYThVQ2tJVEZVeS9lMkhBWnA5dVY1?=
 =?utf-8?B?bUhTYjMzNC9SZTNaVlVEYUJ4T3pSTWNuSUFrMUgrazUwc3JJQms0eDdCMFU2?=
 =?utf-8?B?WXJSVlN2RU1yTGsxR3k3M0VoU1JiNGdUZlRMRFUzbTZIQi9VNXoyc2JpTWFC?=
 =?utf-8?B?bEZ1Yk56YkxoK0dqQjNldzhreTdOY1M2ajhzMjFOOGVFR25QK250eCt2NFpN?=
 =?utf-8?B?d1hQQXVreENMV1RDSDBLcmRQbGhEWEp6YkF4ZVRUcVZva1dGU1Q4Z2t4aWlT?=
 =?utf-8?B?R3F0aGFnYkQwckFTeVBYTlhtVmVZbmhIYmRnWFhjdEJBV3BqTU5HMEsxMFhN?=
 =?utf-8?B?dFFONlV5NFRGRytBS3R5TTZMY2pQU0hEVmZPZFR5Rlhab1pLWWtGaGt3RW5B?=
 =?utf-8?B?V2kvKzlnYU1RdnVkTzV4SmluT3F2bk9VN2tBckMydnVWMjczNXVmMEhSanIv?=
 =?utf-8?B?UVpPUGMwWi9ZT1J1ODJEcHBzakR1RDhDamh3VFZDcmV1S0FoWG9yVGVrRmZ2?=
 =?utf-8?B?TzVFYUN0bjdpYkxrTG12YzM3NlJLalV3K3VUVnlmWnlTUCtkR0VLc3BDUndV?=
 =?utf-8?B?ZWszbHNrelduTElaeTEzaks1aW9sNUtDdzNIMHFSa2MxQWQ5VFhxZ0VEK3Rk?=
 =?utf-8?B?YUZIN1dLQXRFd2xMMGx1aGJ6eDBKOFYvdVJkY2pHand2RGprQzU2OC9BeTF1?=
 =?utf-8?B?MnlJKzYvYjl4QzZ5UGd5enhUQWVUQ2V6Zk1yeEdRYUxjM0ZEMCt4bEtKNnhX?=
 =?utf-8?B?b1RKRFY3OFJNZkhOMXZXUm80LzhhaUoxVUtrUms3UG0xZzZUL0ZBaXpwNkdU?=
 =?utf-8?B?WnlCRWdud2w5YTVJMk9adTFJRVlUV1pCZWd1cUg4NnI4Q0lWbjF4U0w4Nkhy?=
 =?utf-8?B?YkFYQ0tna05qMUkrdGx3d2kzV2lXYm1Qc1VhaEExTjU1Q2tSQUJ0UXJqcWZG?=
 =?utf-8?B?TkY3ZkRGRXF4d2NsVERUeHpPMVNTd2czdUZmRTZpelFXTXV2RjdZRWVOelRH?=
 =?utf-8?B?QmNndDRiNmRPVWVjeTEzazdlZjFHMmlpTjVTUzVpL09ja05SUlJua1lwVmtF?=
 =?utf-8?B?b3BhaWh1TkJ1aTd0eU1UdkFmNE5VcHlkRWpCUzZaUmwyK0VYbUZlVGFTZ2d2?=
 =?utf-8?B?RjlETXhGR3RLck8vWmNtbmJTU3RpQVo3bEZDdUZkNjAvdksrdTg3bWVvZW1o?=
 =?utf-8?B?d0RWWTB0T0ozR2ZMRHRiYmtWY0U4UzhoNmdmTjZReEdXSmMwQktRaExmYkdx?=
 =?utf-8?B?eWg4bWxUbHJGY01CNUVlZjNteWl4eUNMckhxZGNDY01acnlvbTZ5bXU4azM3?=
 =?utf-8?B?eS91ZlYvTU8yY1JQRzc3U0NFT1lmT1Q0VjNoNkluUGN4Nkt1Smt5WVpqV3NI?=
 =?utf-8?B?bkkyeGlESmV0RWd3TUkxK3lwcDFWR0tFSzd4NE55d0FZQnJwSDBmS3FDY1VO?=
 =?utf-8?B?Vzl4YWIvd3U2bHpTMEVFenZOdW9GT2VHczdLaG0wUEtQcWxQNlFZbzR5bXlG?=
 =?utf-8?B?bFVRNGRuZ1FHS3lkaDFWUjhvR2Nld3IyZUM1UGJ2Y3IvS3dMSUVGUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b84f7f-e419-4abf-11eb-08df44acb88f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:14:33.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uroJ4xZqUH/6M12AS004Ln8q/iSCib2ETSfpBkSCx+kvTTx+4CL1r99n/zCbeUkcBW003Wk/1t5fUjSdKhJEHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 13:14:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24942

On 17.11.26 13:38, Badrikesh Prusty wrote:
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  ....325-cip136-rt50.bb => linux-cip-rt_4.19.325-cip137-rt51.bb} | 2 +-
>  ...10.268-cip77-rt34.bb => linux-cip-rt_5.10.272-cip79-rt35.bb} | 2 +-
>  recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb             | 1 -
>  recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb             | 1 +
>  ...inux-cip_4.19.325-cip136.bb => linux-cip_4.19.325-cip137.bb} | 2 +-
>  ...{linux-cip_5.10.271-cip78.bb => linux-cip_5.10.272-cip79.bb} | 2 +-
>  .../{linux-cip_6.1.189-cip61.bb => linux-cip_6.1.190-cip62.bb}  | 2 +-
>  ...{linux-cip_6.12.114-cip34.bb => linux-cip_6.12.117-cip35.bb} | 2 +-
>  8 files changed, 7 insertions(+), 7 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip136-rt50.bb => linux-cip-rt_4.19.325-cip137-rt51.bb} (68%)
>  rename recipes-kernel/linux/{linux-cip-rt_5.10.268-cip77-rt34.bb => linux-cip-rt_5.10.272-cip79-rt35.bb} (68%)
>  delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
>  rename recipes-kernel/linux/{linux-cip_4.19.325-cip136.bb => linux-cip_4.19.325-cip137.bb} (68%)
>  rename recipes-kernel/linux/{linux-cip_5.10.271-cip78.bb => linux-cip_5.10.272-cip79.bb} (68%)
>  rename recipes-kernel/linux/{linux-cip_6.1.189-cip61.bb => linux-cip_6.1.190-cip62.bb} (59%)
>  rename recipes-kernel/linux/{linux-cip_6.12.114-cip34.bb => linux-cip_6.12.117-cip35.bb} (59%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip137-rt51.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb
> rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip137-rt51.bb
> index 6b54d1d..19b48fe 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip137-rt51.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "424e3e7f2f6e1282021ddf61ceed8cd71332e33fbaf42868784fe22a780fd82b"
> +SRC_URI[sha256sum] = "aac5292feb94163f9c97a2886fdb0e58e84f1be87ea787b9fc858e0b17c9529b"
> diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.268-cip77-rt34.bb b/recipes-kernel/linux/linux-cip-rt_5.10.272-cip79-rt35.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip-rt_5.10.268-cip77-rt34.bb
> rename to recipes-kernel/linux/linux-cip-rt_5.10.272-cip79-rt35.bb
> index 9f3cb2b..f211866 100644
> --- a/recipes-kernel/linux/linux-cip-rt_5.10.268-cip77-rt34.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_5.10.272-cip79-rt35.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "735246b660eae9314f9a312eedca69773996d3604399810271c0b544c30400b8"
> +SRC_URI[sha256sum] = "bddf7a247276da228aad949208dd769b441e9b67f2c06bd30e1f5bb8d43d4161"
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb b/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
> deleted file mode 120000
> index 91a3ca2..0000000
> --- a/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
> +++ /dev/null
> @@ -1 +0,0 @@
> -linux-cip_6.12.114-cip34.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb b/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
> new file mode 120000
> index 0000000..8023eb0
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
> @@ -0,0 +1 @@
> +linux-cip_6.12.117-cip35.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip136.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip137.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip_4.19.325-cip136.bb
> rename to recipes-kernel/linux/linux-cip_4.19.325-cip137.bb
> index 9fb5905..dee0731 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.325-cip136.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.325-cip137.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "9e753afd86e574a8e67cdadbb8cc43ee8337521cd5afaef931c4c217fb2bbeb2"
> +SRC_URI[sha256sum] = "0788097dc70bea3fb512e6f6d6401d21bd54f4d3779c0d0190c62aeb599564d6"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.271-cip78.bb b/recipes-kernel/linux/linux-cip_5.10.272-cip79.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip_5.10.271-cip78.bb
> rename to recipes-kernel/linux/linux-cip_5.10.272-cip79.bb
> index c6fccfb..dad120e 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.271-cip78.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.272-cip79.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "a972b3e41472bcbd28f41ef48bec9354ac7a050b8d0e0c880de207c70f929201"
> +SRC_URI[sha256sum] = "d3a621032b579b47692c9127b3e2c643d508e394c5e25f6a6a2606a6571892ca"
> diff --git a/recipes-kernel/linux/linux-cip_6.1.189-cip61.bb b/recipes-kernel/linux/linux-cip_6.1.190-cip62.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.1.189-cip61.bb
> rename to recipes-kernel/linux/linux-cip_6.1.190-cip62.bb
> index 4b6c7d5..831fbc0 100644
> --- a/recipes-kernel/linux/linux-cip_6.1.189-cip61.bb
> +++ b/recipes-kernel/linux/linux-cip_6.1.190-cip62.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "7003af449cbaf2af04c671dd3d06193bc8a7d8a10e94a9d286b5a3c36690c923"
> +SRC_URI[sha256sum] = "404a492ac47b321f2657e1345821e9aac16bb07f8d8703ca1774f59016fa6c3c"
> diff --git a/recipes-kernel/linux/linux-cip_6.12.114-cip34.bb b/recipes-kernel/linux/linux-cip_6.12.117-cip35.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.12.114-cip34.bb
> rename to recipes-kernel/linux/linux-cip_6.12.117-cip35.bb
> index 95cd7b2..3927cef 100644
> --- a/recipes-kernel/linux/linux-cip_6.12.114-cip34.bb
> +++ b/recipes-kernel/linux/linux-cip_6.12.117-cip35.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "801ba01e82a8e25738d4f30d2640e537cc06bb13f9dbf0f6fce5095f3fb1f168"
> +SRC_URI[sha256sum] = "7c3d5c0938f6030ca3dd6673a11776dd433a80d9544ab3909f073962da40f840"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
