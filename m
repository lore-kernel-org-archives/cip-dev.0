Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F315C3DA7F
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 14:24:47 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.51])
 by mx.groups.io with SMTP id smtpd.web11.9241.1722867879952340851
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 07:24:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YnXLbKpq;
 spf=pass (domain: siemens.com, ip: 40.107.22.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgjPTPWz64aR97CBaFWDZDCGi3iOFIaK/DuKgY/HI+tM6hNtXDR+SZIGGnomu+6kMZ5f3QuBmkH9fJ0WhwAp6w3lijGuZHupJFUXDbiAQ+qz/SCMWc1ua3GHncy34cPC+vcGPT6mIfigLt2A6UR2JdvfGo9Rmo3D6TBcCy5GyoWLaIWDRrT+w+xZJ2rV6IbVEJUTEPzLelrzk2DslOHPuAIMU2Yv8pCvrK56kBpilCv3RhPFLbUDjR315+bmBPiG7nnt66Ts63vUPXtP+Dy3HktalbeUm8HRc6x9eImusI//7xpY+SWZbP/W+Zst1SBzENFMZ7YxpAFxCzPFpxzAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24Mnu9tsYfz8RxIILYc6YzCcn952Vh+dWuV1jx40MTY=;
 b=NHq9g6s11aZU0nwosaydtZ87S8dLSvO+xNPvX9a1Jv+Hek8ayD5htW9IbtNnDauTNEVhZdVEcN6fMYMjZXgYgfeM/qSpg2uch8mMIpsnd0VRxDbupPtmFnFI6TNlbt+lKINH5Du3lhpK6NeG3oUr/feC5qvuEVZs1TOMum20SmOVgY+4OjXJEzUQVWJMZg40v9ctC05UASLS5fts4mtKJ5lZTenjowztwuRFrC5WnA1faJMmrb2JKHlj7z4NAMMnIWkJ4AlXnyPc9S4ncHNBt23PDQggu1ZckCGcP0BQNlC7zl5kRB6JkC2oXt/rVO5UJIKZu6PEtx3aRPMWtu6bTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24Mnu9tsYfz8RxIILYc6YzCcn952Vh+dWuV1jx40MTY=;
 b=YnXLbKpqH8WqWORCQSicBZj56aY9T36LxIYyed0BSvCpeh/Q2xRESx52NmbuZqz+9f4koiR8hx/93NdzPjfqyXMer9WBdTuGoI7asmISAPAq9YCfjOfWDfRgwfMBKIq1+DmvsBoWlwEdfqDKKJC+yw7m+Goad+Em+e8YV0YLTyaYj1BT5eou0MLaDQFtexzJfwCitu6b+uJwd2QYe5Scdm47TVfOVE5wNQIdF5iBUdRUqg3Awz406PHZIK5gIfrdAOY9h7ux0CkxT4Emimqa1nXR9DTJaMoOQeTg8vVG9CDngpXUmUmoUxoHDs8/jhY9R7jwWughriEAvt5+gERrgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Mon, 5 Aug
 2024 14:24:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 14:24:35 +0000
Message-ID: <55a5a063-2e29-4549-933e-88e9f6e27b7a@siemens.com>
Date: Mon, 5 Aug 2024 16:24:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v6] initramfs-overlay-hook: Check
 file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240805091905.1818691-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240805091905.1818691-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecfc3fd-8e59-4e62-3e5f-08dcb55a547e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SlNyclN2MzBmaEhpK2prNlo5ZmJzOEhUODB0Q09VZEdUU090cTl5MWlaNEFB?=
 =?utf-8?B?OVRNSVpXWkFOZWUxcHFHVzE3c1dBUTVyV01FZngzUWV6cjYyYXVUUXVIbmY0?=
 =?utf-8?B?a3BQSk82b01TenVKdGp2YnZQQXQ4cnJKcDlGZERJYVRJREFKMHZDY2JWMVEy?=
 =?utf-8?B?b2RXMDFRcEhXTVFqaVNjN3UxUjJjNmJYWnNVcTcvN1ZnZ1VHbGlOTmFneGE0?=
 =?utf-8?B?WXZJWlBZZklmNEIyNWxCOXJSQmsxME1GdnhLYWg0aCtJUU9JeE1jWE4rVXhC?=
 =?utf-8?B?a3Q4NzRGZktYUWJEYmlCVFFhWDlSbGlSc2tOZWJHellwMTlYWHB3azJ6NTRk?=
 =?utf-8?B?V054TkdRVXhZcnV6OGtKOGRYeFJFV1ZIcUhjbWJJTUxhNHlQVmNTVnJhYjVm?=
 =?utf-8?B?SkVURnBJMGd5Qjh0eDFjQXZKcmhNT1NRMkNwVU9yekhvMDZBMGtEa2NsKzMv?=
 =?utf-8?B?TFFuL0pEZGVRZDRwb0Q0Y3VITXp2dnhycFFPZE4zQUdXckxQcUp1MExCTit6?=
 =?utf-8?B?MExhaVNGMU1mRDlFVG9hejRmNjQ3c3QzbUhpR3VBL0NIbHM3eTlFTXk3Q054?=
 =?utf-8?B?ZmRrTGFoaUF0ME5EbzVLL2VZNkowVkRHZjhuSG0rbWlKa3AwZzdGUDdxTldM?=
 =?utf-8?B?UGlwTHM5WG45dGVuRC9CTUNhTnhTK1luT21EY3pvSVpSYzUzRUNFWXAwQ1hM?=
 =?utf-8?B?VmxsMGZLVWVMSFFQNWQ1UjVteFFpVFZTbVdtREFMQm9jSVM5bStPYkxZb29s?=
 =?utf-8?B?bnZSYkFvNTIwUTYyUjdHRmhVRWZEVFNJMnZwZU0wemxDK2R2eUZPNzZWYnVK?=
 =?utf-8?B?eXI2V3ZGbnVlTjZuUHA5dEU4bGdZdldEVThpeW1UYkVVeWtNUU4zemlxRlZl?=
 =?utf-8?B?SU1TR21YUSs3d24wYTBNVHNYTGFRaVd4WDhqalFPbitURGJxS2s0dnFWYXNz?=
 =?utf-8?B?dXhQUVg2bndGQTBhMXhrMXZhSUxyelgwQUtEb21zNU9PR2V2eU9CREJGOHNJ?=
 =?utf-8?B?aThNUmIrNXlmMFRkSjlVRWNJOGo5K0t1NHppbWxob3d2M0NSQzhyNXB2eFI0?=
 =?utf-8?B?MWpUVmd4L3ZBOU5SYkIrWGhwb0MyU1g5MzZMRjQ1RStaK0NQdUxWR3hxeThj?=
 =?utf-8?B?UGNPQ1ptNWpWTERzVytRU1FoUVg4N1dtSm82ZHZYSmVIb29CUUhiTnkwbGJm?=
 =?utf-8?B?VEJKTGU0TUYzTE81UVowVGtYQy9wUG9kMEpzbldudnF1bXdSdXBSTm12akw1?=
 =?utf-8?B?cVlwN2FqNmxRRWFQOUQ4STNLdkc0R2JOdWFrVll2cHkyVkYxYnFBaVlySWtZ?=
 =?utf-8?B?M29IL3dCOVNhazN2UWI1L1o5Vms1NlJDc09ZbFNocE85QlZxeGhid3ROZXdx?=
 =?utf-8?B?OFBneDRPbjRXSWFROFpOalZvT21OY2IzUkkrdGdFTTBHblFnbkUrZmx3MUQ5?=
 =?utf-8?B?bDZWY0hJUWJvVm1hTFUvZFppeWVKTWxqcTY0Qnl2Z3JWQ2todm92cCtmMVBR?=
 =?utf-8?B?dDJBV2U2K0U4ZDdNTEllNmJ2ZHZjek1mN0wxUTNVWmw1KzNGejdyTm1oNjVa?=
 =?utf-8?B?Z2dwR0NQTjFFZ09ZOVFYWitKNFROdlVadFF5aVBEV25FaUNCbGJQajZFUmt5?=
 =?utf-8?B?TFpyTjdrSS9YZUhWeUJlcWlmUWtyZGNYVU02aWVndkNiY3krU2ZuQ0NHSFdt?=
 =?utf-8?B?NWtDdThheGVadTYxZ0tXUGlZME82R2dQY0lyZXhKY1k3TVA1QVVQRXZjY3FX?=
 =?utf-8?B?ZnBVSytwWVpaY285SGJnY1dKUmY5WWxUWVM5c0tmOEF4TUY4RHJSL1lsdkV1?=
 =?utf-8?B?bjk5QzNGcFI4aEwvQkFSZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUVNcFl0MWk3RU5xNGZJNkhxRm5lWENMWGtxVTNKSU5ZbWdJYnd6bnAxeFNM?=
 =?utf-8?B?ZDF3T0lLMVpkOTRXbkRyRjkrK21KWkFUbERtSkRWN3NCSlVQamgyTCt2SitG?=
 =?utf-8?B?cERnN01XTGdOR1FqVjFRQ0ZXdzB5ODZmMjZrM0RvZ2hPWVlhZW5URzNGekJn?=
 =?utf-8?B?Q1hsSG9pNFlHQzRLQUxRSUxiNU9sT29acWxudXpzUGJlV1RUNWZzRjdQelJF?=
 =?utf-8?B?eDVSUWFlWU1JLy9vQ3RRdnYyRzQzdWsyWmJaN3pOMktwbUlOMzJHUTZVdFFJ?=
 =?utf-8?B?dDcwUDFZYlhMejZJTmVDamswN2ZRUVNGRjg1MHFtekp2WDRUaWFHOWtnZHRr?=
 =?utf-8?B?KzFka2NraEtqbE10Y0pMR09JTlc3WjE3dzkxZG5CS2YzK2w4UGFIVVk3RjMr?=
 =?utf-8?B?dWtVcXRSSUFZN0hGRDZoM2hES2hjSE1EV2hXUUNrRSsyQW15Y2J3MmRRYUlD?=
 =?utf-8?B?SzNVdDNlYXlVMkQ1NlVDZW9NRTZmazE2WHg2L1crRkw2Y3AwbThtV2ZpbHFZ?=
 =?utf-8?B?cGFUakc1ZVJoNUhDQVlSR0hLbi9RcTZwdTlZWEI4MzVvSVV1dXhyUENZMlRD?=
 =?utf-8?B?VmtndUZlK0psTC9uaG5GM1h4SjA4dUlvUHVwc0k2YTZOcVF2dENaUmpoQ0U0?=
 =?utf-8?B?a2xlYnJ6RHpzbUQzc2QyV1RFMnVUOEp0R0hTNWtqQWdMdUxDZyt4VG1pSTA4?=
 =?utf-8?B?S2d2ejFPSTB1aUNIck5JSmNNb1lRYmNRMlBHMy9nZHNUSUVtRWJSLzFsZUdR?=
 =?utf-8?B?a3RHdmdQYVF1ZnRqVS9SOEhpZTE4VzRBM1A3ZGQvUlpMSHNkcGJYNGFQQ0lH?=
 =?utf-8?B?cDB6OGszR29FdG9wc2lCaTVSaWNaTm93NExUMXhTZEZWRkc5N3VidklYUG1N?=
 =?utf-8?B?dnJyakdZOUI1SGFpSWt4Ti9QTStZdUI5NTB0aDFBaVZ2SitTTGRtNDRJQVBn?=
 =?utf-8?B?UkY5VndBTzFYU0pVLzdCWlZsWnRJQzFIdkRJWk1DcFVJNWF0eWNEZ1RrS3BE?=
 =?utf-8?B?VlBlNjdJOEt1d1IrdGRhdWg4K2UwdGRKOEdoMkd2SElDUFFWTXAwMVVpb2l1?=
 =?utf-8?B?UzlPS1R1bFRFTkJyMy9EZnYxUWJVQ3A1OVdMWWMwYkhSd3J6K1M2MXgwNVgw?=
 =?utf-8?B?bkdjbGtyM0NVV09UMjk5dVBINTJpc1ZYYlRpZzJSa0Z0RGxUemNubldpaWo0?=
 =?utf-8?B?cFdCK3g4akkwbG0vbGlBZEczYmw3dmRObzhKUlNWb3RaclIxbkdTVCt6V1dN?=
 =?utf-8?B?czR1STIvcFFVTkI1V1pkbXNLOG9lUmZIYnBhUGQyQnlnODdFT2MvWXBYQ2Jv?=
 =?utf-8?B?SnZaWEVaQktaL2xiSG11QndVMnpsaUxidFovUW56UitQa2pCdnQ2U2NsRUJB?=
 =?utf-8?B?aVhWR0ZLYVhEMzJKQ2M0Z2ttbEhQeGVOK0hwUmxyQlRFdjhqR1o0NGltVlNr?=
 =?utf-8?B?NnBSNkMvc2FPQVhGd0ZHcStHbEdLYVZyK2lwa0hKSjVQemVQMVd5aTQyME95?=
 =?utf-8?B?Q1VvcnhCNDlmOGJxZDhoVVluYW5rYWREREZlU3FFd1VHbEFxeEV1c1BvZG9v?=
 =?utf-8?B?akp5U1dScmc3NnBOVWtQVS9ra3p4RHpYWm1BZEp3OHBsbVZRbWppcXpXYXpW?=
 =?utf-8?B?Mit0bWdLYk4yQkFoaXV0K3dncTBsWW0ycnM0ZlgrV1czZ2taR3U1bVJyUits?=
 =?utf-8?B?ZmxoVFJuYmFSUUJoUEVCblpXTFR6L3JtTGkvVzFkaGRWNjdpQzFjb2ErdlJr?=
 =?utf-8?B?MUhUVTAyamQrTm9GS0VTSHNwMThqNjJ3aDVtNmlnWTUwTXUrN2xadzEyaS9Q?=
 =?utf-8?B?UUR4SGE4ZHJCcWtlVU9WVWZyL1RKeUdHVFdGdzB1MC9qdmY5L2RNQndNUXZH?=
 =?utf-8?B?S0U5RFRURFdITEV2aXhEcjZoRFpYV3A5bTdvczh6eStBejZIanlOMTUwb0VC?=
 =?utf-8?B?MWlxdUpVeGF2SFZWZ0wzSS9FUlc4SlN3WTJYMnVDRXFCZEtEazRQWU5PL3Qz?=
 =?utf-8?B?STJxYlFBdm5vWDhsMCtieDFiTFYvNER6OGllaG1ObXRZNm55bTdDOHR1WlVK?=
 =?utf-8?B?dWxNOVJLNjdHT3lONXRpcUkzNDNxL2xoanQ5YXpCUTJtcUdzZzZjSWNPcGFx?=
 =?utf-8?B?WUtKYmJFOUlSMThCSlZ5RzBrN2tzTnRnOE5uWGx5OUVNZ1lDWEVpM0QzZVRX?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecfc3fd-8e59-4e62-3e5f-08dcb55a547e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 14:24:34.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPmHYkPFhuD0gRcomi/OPemE/rOfNML9KujxuuS5Pby0hrMVGIMTBNagF4ayVjP4fSlvIAhPJdnaiYjcmV/Jng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8025
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 14:24:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16718

On 05.08.24 11:19, Clara Kowalsky wrote:
> In case of ext*, this detects and fixes file system errors in the
> partition device before doing the partition mount.
> If the partition turns out to be broken, the factory state is recovered.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  .../initramfs-overlay-hook/files/overlay.hook      | 11 +++++++++--
>  .../files/overlay.script.tmpl                      | 11 ++++++++++-
>  .../files/overlay_recovery_action.script           | 14 ++++++++++++++
>  .../initramfs-overlay-hook_0.1.bb                  |  8 +++++++-
>  4 files changed, 40 insertions(+), 4 deletions(-)
>  create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> index 8b00ecf..6f634c5 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> @@ -22,6 +22,13 @@ esac
>  
>  . /usr/share/initramfs-tools/hook-functions
>  
> +hook_error() {
> +    echo "(ERROR): $1" >&2
> +    exit 1
> +}
> +
>  manual_add_modules overlay
> -copy_exec /usr/bin/mountpoint
> -copy_exec /usr/bin/awk
> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index 42eb59c..c655a4f 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -31,12 +31,21 @@ ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>  ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>  ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>  ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
> +ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
>  
>  root_mount_storage=${rootmnt}${ovl_storage_path}
>  storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
> +partition_fstype=$(get_fstype "${ovl_partition_device}")
>  
>  if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
> -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
> +	case $partition_fstype in
> +	ext*)
> +		if ! e2fsck -p -f "$ovl_partition_device" && [ -x "$ovl_recovery_script" ]; then
> +			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
> +		fi
> +		;;
> +	esac
> +	if ! mount -t ${partition_fstype} \
>  		 -o ${ovl_mount_option} \
>  		 ${ovl_partition_device} \
>  		 ${rootmnt}${storage_mount_point}; then
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> new file mode 100644
> index 0000000..d13111d
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +
> +partition_fstype="$1"
> +ovl_partition_device="$2"
> +
> +mke2fs -t "$partition_fstype" "$ovl_partition_device"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> index 955748f..7097130 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> @@ -12,9 +12,12 @@
>  
>  inherit dpkg-raw
>  
> +INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
> +
>  SRC_URI += " \
>      file://overlay.hook \
>      file://overlay.script.tmpl \
> +    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
>      "
>  
>  # The variable INITRAMFS_OVERLAY_PATHS contains the directories which are
> @@ -35,7 +38,8 @@ TEMPLATE_FILES = "overlay.script.tmpl"
>  TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>      INITRAMFS_OVERLAY_PATHS \
>      INITRAMFS_OVERLAY_STORAGE_DEVICE \
> -    INITRAMFS_OVERLAY_MOUNT_OPTION"
> +    INITRAMFS_OVERLAY_MOUNT_OPTION \
> +    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>  
>  DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
>  
> @@ -48,4 +52,6 @@ do_install() {
>          "${D}/usr/share/initramfs-tools/hooks/overlay"
>      install -m 0755 "${WORKDIR}/overlay.script" \
>          "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
> +    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
> +        "${D}/usr/share/initramfs-tools/scripts"
>  }

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


