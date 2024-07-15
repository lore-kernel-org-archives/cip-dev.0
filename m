Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9440DC3DA5D
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 10:58:47 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.44])
 by mx.groups.io with SMTP id smtpd.web11.35309.1721041119482740952
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jul 2024 03:58:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ILf8EzWP;
 spf=pass (domain: siemens.com, ip: 40.107.104.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dogL8i9fwQADEqhOrkzx7ncNFRnqlRO6KftSxDu5ujB8jGmhEiJfHdBqN0wynK3ccBD+VkuYkJYxkOJRyZVgm7TJon+dOFpcF0uNQ77zt8YM5fvjWEtvfIXvEUzVffK2RAc9p+eRHc7vVXh+4oUIfh7tL5SDxlNY8nell9CiDkJh7/PnQ6xZz/axD1RvnonRvHYQXIlcRxvesbpFZ4ULS+rq+mafqliQLpkUAntTm8KBku3WEccliof9eWxTyssTUUkyxSP7S92bfs1sTWqH0Bns31d2yKBsK7PGz/qP+P0XgpyivYEyBd8YdduwbZcOyYOW9c0yXfcpeTVb5QtdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8TTrUQcVIFM1h54pLVix2rVpGl17KfiF659RiC/NvI=;
 b=lbTMmdw5XOT7B/zdsWmuwoAowaUB25fImlrwLyfjT209tCU5xqF/PCIuBVWllm5YQXAmP+QH1j7baOaJjUk2YkqFlZx38eqWfgEQRjGASATUknrZVnmO5kHC2qkTetBltPAQp+3/TCfzYzcqeU5cuDZ97pMo9V6s2sS0DZ/yBOY3kPJ+bokh7EboeyCxvkCLqmNDYjP/uaf0h5juurSzlXG9jXqlGp6Ivnp3J9BFehyTxcM0s4wDEpdKc/HrDPHK4ci2/weq/gySWyhaenRYysFdolKewrbR0igFlANIdzcLCzfQ/2ePCoLXhUEFw/N5Q1fUNthB/hlePYOGBALpHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8TTrUQcVIFM1h54pLVix2rVpGl17KfiF659RiC/NvI=;
 b=ILf8EzWPv4uwrHR9W1LbLfSf6uTsF+kKPIgy16Nyd3PakHByu5hw3oTqevxqjSLJ47O43e2bP/SNcCg0x3cPnin0bH4N2s/W0GhWyHoXKEvWjzfJMJtQ5HTROFH9rALZv4lSe63QY66bMIq2YxulLm3HA0HHgSW5yFEmpQlq+cZcHr6RxtifXpNq7Fzx9Sw6xjrVrk/8Dyy0xqTWzTo78e0tbeaJ0T8LhAghjrwMbUgmJyhILmW9fcQsFxPzerd677PdBo/cKRgzvnDnLe8oXp9TH0hTAc6qGVRwPvy2TXVS/IMJ8KfelZqQAyS/kMrkuIn6342A8rpFmLY1IlwmGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA1PR10MB8871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 10:58:36 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 10:58:36 +0000
Message-ID: <511b1c06-ec3e-42dd-864a-16c4b496f257@siemens.com>
Date: Mon, 15 Jul 2024 12:58:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2.1 2/4] initramfs-crypt-hook: Provide full losetup
 executable
To: Stefan Koch <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, christian.storm@siemens.com,
 michael.adler@siemens.com, simon.sudler@siemens.com
References: <20240715093424.632716-1-stefan-koch@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240715093424.632716-1-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA1PR10MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: cac15d52-8092-465d-a960-08dca4bd13a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VVdCbFBlZERoMkR6a2lwVHJ1c1AwU2UveXh5U0VXTlkzU1d3Rk5DeGZncTBa?=
 =?utf-8?B?eVFWeVNSVUpHU2hBQjgyTHJPUjUrdENXZC8vMzY2KzJuTVRUdGpiNjRxaGZF?=
 =?utf-8?B?WmFLNWhWUkRFSHYvUzhjeldVZlFZdXJZelNsZE1iVkVLS29GbzdkNFhyWFFs?=
 =?utf-8?B?VVgzODdnT1l3U0xzU3NVREJDODRUQnpiTnZzaFF6VTdWVUZMOUFwZ0M0TEp5?=
 =?utf-8?B?ZGFydlZKMjVoRDhiYjN5aUMybHZ1YkQ3REJ1ZEJzaTI3S1JPT0tJaVJXTXdL?=
 =?utf-8?B?RmlIaXZYZGJ4OUtQMFlBNHA5eWlMbkhpbHNKVVZMUER5cUFFOWk4M2pRRGVL?=
 =?utf-8?B?Mm10WDNaa3l4VmNUaHFZNE9VYkZGK2Z5NnFKV05jandrN05rNTJ6N01hejFn?=
 =?utf-8?B?a3dnUkZUcXMreHZZY1l1eXRweFdyS0tpekN0SGZGZjF6WEFGQmtJdTh2OS9x?=
 =?utf-8?B?OHZwTmczVHBJQ2ErOFFOWmhqM3ptK3h1OVY2bVFtaWZrODBHVmwwUkJhbzFG?=
 =?utf-8?B?eUV4Z0dLSXFSWWVYZytsZzVpS3BXdzBKaUlOemhHMUhuUGk4N1c1bXhjUzNS?=
 =?utf-8?B?MXFMN3I5QStBSjJwT3RXMlFhWXRaZEdvMFhYUUN0dk1GTEc4c1I5d0pSR3dF?=
 =?utf-8?B?Y0diM2txOEV5cTVObUttUWZmSG54T0FXUDhFRDFSVmtOcjhkL2VqMlRwa0hO?=
 =?utf-8?B?WEk3KzgxdHJOR21DS0pwbDd6emlTYk9xdTg0U1NOYjVZcUVUUVMrTWxUS3hv?=
 =?utf-8?B?d01xZXJSa0hQUHhmcCtXL2R5eW4reVNSNkNUWVU2VWlHd1M4d25KQXhRM25p?=
 =?utf-8?B?dlMvTWRQR08yRnBrNFh4Q3FvWVFKMWJCMXRCa1NQV092dTVMRktCZ05qekha?=
 =?utf-8?B?bTNUK05xYUFJSlIrb0hoVVc4dzJoSVRaSGt4RnlZcnFMWGkyQ2E0Z3pCZ3U1?=
 =?utf-8?B?NjdsRE0zcW9mdE1Ycll1WVprUllHZUNBbHZ4ZGNEeG5kR05tSEFtV3NlclVP?=
 =?utf-8?B?MWpaYmFtWDlUamoxNU9vSDNuMENCMkdmU0ZUbEtCSjFqMnhXNWtxZVN4blFp?=
 =?utf-8?B?NE4wTDJkVzFFSk9CTmpiZzhIR2Y1TG0wUC8yZ2FBakI0YXpobTBoQkJoUU9S?=
 =?utf-8?B?ZWQ0ektNMkdQcEhXckVJVmcyQ2ZIOFVQeWk5eU1CR1YwK1MzaEE2RnBSMTVS?=
 =?utf-8?B?K04yMnhUc3N5WVhVWGNqUG42REJlTXFycGpSV1VVa2IrYmFwdWhjclpNeDBO?=
 =?utf-8?B?SEZVS2tCdlNvNTUzMVhvVkd3cGI0RWNpcDdlbi9IZ1hrS3JGLytoaTI0UENH?=
 =?utf-8?B?OXhZQ3E3ZWcyeXFkem5QVXdjMUtqOGxuUHh2VHU3cGVibHk1ZGhWRWd4MHBV?=
 =?utf-8?B?WjNNYW1XWlRXQ1NUYWZXZkxvRWRjMjFhSGR5SGdON2ZMbUQ3YmJrTDFPV3Bq?=
 =?utf-8?B?QXo0S3RNNHRwdC9vTituTUdyN2R4djcrWG14enJDZUgrMmtraGZmSW5IOVIz?=
 =?utf-8?B?SVRQNXE0ZzIxNTJUS1RxelMrbjhVbXM3UyswZDBlaWlFeTQ0YzFUaStCcURO?=
 =?utf-8?B?ZnpaNEVWeHA5aTJvQTNFZVpSM3grbDZ3SGlpVVlZeE1hSWVDQ3VuQ01NUTIv?=
 =?utf-8?B?eFlycDBhNktmWlg0TnpnbkV3RGM0QnNmQ0syNVNGTmtLRDVlM1Q1a3V3Und5?=
 =?utf-8?B?Qmh3N2JKQkZmZEI4UXY0azdWQktVdjBpK0h0WXd2SDVVUjNMMTVaMWo4Rlg0?=
 =?utf-8?B?T1I5clNhdnlsRkEzZ2IvS3hlZDU4RkdwQ0VSbjlERW1QUS8xRDdYeFhFb3li?=
 =?utf-8?B?ditFS1Z4ZGFTNzV6Mmh2QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VHNuQ0NsRk1ZNWpFS0NGYklHWVg0QkFXaTNmcVR1VC9kMDVYNm9BOG93cXMv?=
 =?utf-8?B?U3c0b3Z6NmtaRjBvVS9NeDZWZ3UvaUFBbXRVR1Foc0loR3BndWhIamFTbzND?=
 =?utf-8?B?RTJaeVBTMjdPS0liU3Z3SXZNa095WUdYYi8xQ0RrRGUwcnpzd2xKdjNZbjV6?=
 =?utf-8?B?bzZQeDhOV0NxNVQ3QWt5VXVjNGxzbCt0bjhta3FjRXhKYzY5TURiT1JDRDBm?=
 =?utf-8?B?OHFBTFU0L042Zlg5N0xDR25iazlTYmJ2aTFFV3hpNEhIanVEVHc2KzI0aHlx?=
 =?utf-8?B?N2ZiYm9EQll1L25WQ1ZpQktubUdpbWkyYmgzb2R5NmlkZ3NZbTlTblBzNVpZ?=
 =?utf-8?B?YllRR0d6cFFkMTN2aytyRmhQVDZvZlhBK0ZZUXB0WVZLS2hHb0QvbjNocnpM?=
 =?utf-8?B?cGxnS1hJaEVoOXo2MGkwcDNFRlNSQU1HTkRHcTN4aXg5enhsL05lVWo0WXhD?=
 =?utf-8?B?YUJYZk1uY1Y0NkYxdWVRaDQ5cXpQT3M4eU45K1QvVDRzdEpmWGdFUFM0UE1I?=
 =?utf-8?B?SFd1Uk5VTm1BZHhGdzcxVjNXYTlmSVpRUDJBUjNZQ0JldDFhZEREVzB0ZTF2?=
 =?utf-8?B?T2M0UC90Vm54aTI4bWJFMGwyZDNkY0E2aVVxWFRJNkpYMjZjOWlpMElyMm5p?=
 =?utf-8?B?OVdwbWFkSU8yQjNSVWJ3TlF6M0xhQTNFbDRONDJ6T1lhYjllNWV2ZVFOVHMw?=
 =?utf-8?B?Z1MzLzUvSDUzRjBoblZPblhFQUxzSUtJRm5VRWxXZ0ltV1RPblFXUGM3YzZV?=
 =?utf-8?B?dzJiTzhGeVMzTm9MYVFHK2xBdDBGMEhsR1UrNnh1RmpTb2VRM0NmM0c0am1B?=
 =?utf-8?B?YzQ2L2VUNGtBa3ZDSlBpRmgveEFDR0lyaUk4b2M4b3RUQzJQRFd4dmtlR0VO?=
 =?utf-8?B?QkJpSFYzandlMUtxMGg1RFZuU2dyb0VVSmp4L0ZvNHhpYzhCbWJiSVlkRWhE?=
 =?utf-8?B?dG9xZUlSMTkyUitGZHYyS2RFU0dqVitXRGJVVWRISW9nS2F5UDgyNVNTLzZW?=
 =?utf-8?B?WDArM3RmNXg1bTlYVHczeFpzYy82NFd6Y2dEQmhYRGxDcmtRZWJEODhSaEpy?=
 =?utf-8?B?L0VzWlJhWVUrQWdMZGhmekxPZDk5ZTJsMXE0cWU5cEY0ZnN2di85K3dvNDZ0?=
 =?utf-8?B?dWpJUkI4Rkp5bGI2ZVlhdVhFSGJINTg4bkZEaWY0ZGJxTDdPTk1KWTFPMW5D?=
 =?utf-8?B?VU1WamVRdlYyMUxaZHFSV2VIMmREaHdkMUgzV2RaZndnRGtuUUw3b2tmaTJp?=
 =?utf-8?B?MWlPWjBjb3Z5Q1pjR2wyZVRObmNyR2hlQUtlOU0zK3lNZ1JMTFlTa2dKNlVo?=
 =?utf-8?B?UEt1d3FNZTZrTGFYQkJqUmIxYlJwajhaYnBJTW5MWjdJR043ZmtIcWxVWnJh?=
 =?utf-8?B?NlZpR1h0TENtU056dEtCeUp2a2FmbXNPaVVCNk95YUFNUWUyN0RweDFzWWpQ?=
 =?utf-8?B?RGozTlRDeVNLeHBybjVZK2tSdjA3akdtcXRaZUhwS1VoSGZKYUZaRHgxeDMy?=
 =?utf-8?B?TDRqeXdNUkhsRG9ITzZtQ00vK0pYU285bGFKeEw5a2tyZXdCM1JQRUlzYjZw?=
 =?utf-8?B?ZStFRTNjbGNmcHd5ZnBYZm1lRVlWQnF4VjI3SjdpazhwRENwQkdZY1pTd0NP?=
 =?utf-8?B?RnE1VExDdmR0b2crQmZaWVlmTHpJSXZ6Q3llZk9mMjNUL0xkdXp5WDVZYWFE?=
 =?utf-8?B?RVJocnBDN1dxUThDeEs0NVB6MnNnV2hGMkFaazhEUUt3WGtTYTBJRXJDUE9n?=
 =?utf-8?B?aTg5OG0wUUJ6em03Uml6UlI5dTlDV2M4M3dvbkR0RG4yN0JhenNPbXR1eDYz?=
 =?utf-8?B?WmJZY3crbUoxVUlOaVQ5WDRrUE4vK0pTUmlLT2hzQlp5S3JKR1EydlFheDlR?=
 =?utf-8?B?S1dIazJYUE9jT2ZNYTl5dWxzeStvNE1Vb21Na2xHMlEvd2VBSTdXTG1ncVRG?=
 =?utf-8?B?bDFMV3RRckZJZERHRmcwNm55UXFybmNlKy96MG1tRXMvOTdWdTlGL2pnS1FY?=
 =?utf-8?B?Yy9mZWY1Rk1TWXJFbURDNmNhM28vK2dqNWVRTEZpbVI1YVUya3RlaStyckNG?=
 =?utf-8?B?eDMvazBXT0g0aEMySnllblZKZVRQRm1wdXZxNXRzWTRiWFhFV2ZkN0UyN2hh?=
 =?utf-8?B?OUxXU0NFSDFkN2ovOC9JRndrOW5sK3E2cmptTmpRZWh4RzYzRmN4eFNDWit0?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac15d52-8092-465d-a960-08dca4bd13a2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 10:58:36.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/xfJp5UzhDnJ4xH1EfQZduSbnTb9pggo9sGg9sHxfYlCpo88hFWAJHw45XsxmacTujOHTl5EFgHouZKNHXn6aT1TAVrJV5ebcVA5zSov+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8871
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 10:58:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16489

Hi,

On 7/15/24 11:34 AM, Stefan Koch wrote:
> - Avoids using a busybox losetup executable that
>    doesn't support the "--sizelimit" parameter
> - The "--sizelimit" parameter is needed for introducing
>    speed-up of disk reencryption with the following commit
> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>   .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl    | 1 +
>   .../files/encrypt_partition.systemd.hook                     | 4 ++++
>   .../initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb         | 5 ++++-
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index bb93361..72033d1 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -5,3 +5,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>   HASH_TYPE="${CRYPT_HASH_TYPE}"
>   KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>   ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
> +LOSETUP_PATH="${CRYPT_LOSETUP_PATH}"
Why do we need a variable at this point?
Please drop that variable and install always the full losetup.

Quirin
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index be8c117..2ace533 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -19,6 +19,9 @@ esac
>   
>   . /usr/share/initramfs-tools/hook-functions
>   
> +# get configuration variables
> +. /usr/share/encrypt_partition/encrypt_partition.env
> +
>   hook_error() {
>       echo "(ERROR): $1" >&2
>       exit 1
> @@ -47,6 +50,7 @@ copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
>   copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>   copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
>   copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
> +copy_exec /usr/sbin/losetup "$LOSETUP_PATH" || hook_error "/usr/sbin/losetup not found" >   copy_exec /usr/bin/systemd-cryptenroll || hook_error 
"/usr/bin/systemd-cryptenroll not found"
>   copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
>   copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> index 72de5b6..1679133 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> @@ -9,7 +9,7 @@
>   # SPDX-License-Identifier: MIT
>   
>   inherit dpkg-raw
> -DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
> +DEBIAN_DEPENDS = "initramfs-tools, mount, cryptsetup, \
>       awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
>       libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
>       e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
> @@ -57,6 +57,8 @@ CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>   # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>   # in a newly formatted LUKS Partition
>   CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
> +# Path to full (non-busybox) losetup binary
> +CRYPT_LOSETUP_PATH ??= "/usr/local/sbin/losetup"
>   # Timeout for creating / re-encrypting partitions on first boot
>   CRYPT_SETUP_TIMEOUT ??= "600"
>   # Watchdog to service during the initial setup of the crypto partitions
> @@ -68,6 +70,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>   
>   TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>       CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
> +    CRYPT_LOSETUP_PATH \
>       CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
>   TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>   

