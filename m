Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D73FC4707B
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 13:11:09 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.57])
 by mx.groups.io with SMTP id smtpd.web11.11069.1704892265045082469
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jan 2024 05:11:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZMFOOktv;
 spf=pass (domain: siemens.com, ip: 40.107.6.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioe+84m+iZ7FQwXMgCRxL8dZU0hphx4L8I1MgifIPdJ2mKaK4/U59bDWBuNLJBk/WZqdke9n90vTaJFwRJZU4E65M5poD0JXi/6G4GaMPWnMV6mbhbK5cknD8dC5Vh06+LY3EeQL1vMHd4AwAmNNElZerAnpn4zR8TKuekDDDbT+7lGdDWuq2NULmYQo5flEGt8xhRdmvfnqsnV/tNjMI/wKbTI0fEPtNwiRIjb54CITEsNXoZS2rdF3sU6RCKPiDBpAO6bQeLqhzUp6BKjRP7OeajSp9GJR9oBLOtH8e0EJDFgQ/GHESxgasunm49poj9W99oav1ekUwwJHklKkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaAei0xdQkJooYEnQW0mAkWxi+t7pDtwGgxyL12KDNw=;
 b=IDfxZRX2IpXl0vsRQ1KXLqbpTV8HEZsh3KEfD12T1RILx1sWXuoNBWMEQ2GY2PFjYJvQZRWv+15stQiaf2JMN4FqWZBODb6xjlGtWOdwexaMR7t7WmDiuJToVdn7suhijHFcOXzzXUrw9zlcjDdiNVr7865OCq4P4skPgJdpV6iW3dSEuIXgHGiQDuKgqUPpjWi4BE9KvehSEiizMFl3oxdp0f7WnioaCM1Kz+zDUaNApYs8JHvZEhCGvRXNnkWff50qGJ8BOg6DcOfg6KdvUXFmJdlLuuFVmTjAOi2Sj9AGsEMACAAREO1iUu9OMROQF/Y/JTsnlwwcXN4XhJRHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaAei0xdQkJooYEnQW0mAkWxi+t7pDtwGgxyL12KDNw=;
 b=ZMFOOktvCqhWIHli04SHUprkyK7QUNYGXkL2h9nxDgctmTo+JhVFT3PIoys6lBT2MsN4pglMuQ2UDBwLAMLZaZPVilSgCCjOWinvUNqUscz3vvDOIilS7fB4WTFD695CtuAEgme1iBLlpacsJaSN93rGYFk9YYIGWyIFWBHEFP+Tq6v9u30Q2HhKT1XXznuinFoxc3DXSn+i/YdKjK/fstghJwkAhl3P/YvyY+Komat2MX7K7BZ+kWsrAaNjCtIq73U3+sU7JqNdvWnP+EmW+PkY30KnjWRKfs56FjgSiEUfMQRWD4VGjNi/MKHTmW26mA5vKDqLaV0YsTr7eCKn5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by VE1PR10MB3855.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 13:11:01 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c463:2929:b52e:f171]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c463:2929:b52e:f171%4]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 13:11:01 +0000
Message-ID: <77123253-7763-41d8-92c3-bcff89e43692@siemens.com>
Date: Wed, 10 Jan 2024 14:10:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] initramfs-crypt-hook: Add required
 kernel modules for upstream kernel
Content-Language: en-US
To: "Cetin, Gokhan" <gokhan.cetin@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <PRAPR10MB5422768B34B02D220449FBE680692@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <PRAPR10MB5422768B34B02D220449FBE680692@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|VE1PR10MB3855:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b766e8-0d16-473f-d35f-08dc11dd97c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	A5cagKTxXP33GUkEpe9n+t5EHmTu9vc20IIloB1wMKqYoOe8QXxPET+Ea9/33l6r4wMQsYZX7XMiROliTKw7hb4oZNTaAKZvfrEmUeFFXBUJwF42zIflBG6pHz9sCAtGwzjRT/8J4q/mPeqMU7vpXvWKV1X2eubs8Z1n7lhQ/LfMmVEpEq3R1b4TOVkUU/kaC1tgQJrbHqC5/rE3+T9wnJ+ZXP7DvkPY+2HDnAD0kkDGh1xhbxVVSlg15kXQEDKkYCD+D6/5KPXMKDbalZ3IFRmyvoYylnfSTjjwUIP8qNpD9LqEDA/lkQlUPdOZqXFBtXs3aemH/ydDKubBMgfl+OhidPDh2EsXu1cP08Ada9Am8JDKFBh2ijGP2ENa7gyM+ZndAVbckA9Tzznpltx3s8U/ga2+ARNJz6821mD15dub2eV4KZ2Ues8PB2Zx9pzU9ejHGe6klGWaSgDnGqb7XOo5+jLpYolHLNzn2Zz/JuHe7vZNY7d2HHsIq0aWiczJKy25DqbNWU08LXj64QNnzgtftGF2nRTLgWuHiO56GHKvwAVTRcmXWhQKgsRISqnjG/VwNy3kmLx5lpijdJf238u8gwwEqe7jB7uyLvDHoq8mpv/BQnObmoZhZH+h2IbNuwvJKoMC9B+RaKaafci+Lg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(6486002)(478600001)(83380400001)(4326008)(31686004)(31696002)(66556008)(66476007)(8676002)(8936002)(44832011)(110136005)(316002)(66946007)(36756003)(53546011)(26005)(107886003)(2616005)(6666004)(6506007)(82960400001)(86362001)(6512007)(2906002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d1Axb0tzM2VxZktkV2x6akdJWGVHdkovTTVYNk03Sk1UZ3pRaDE4cWt6bWdw?=
 =?utf-8?B?NzV0Wk1FMThUZVpVNXcwRjBTTzdTWkNWZk9rUVRzMnU2ZzEyNzFwOVEzdmZG?=
 =?utf-8?B?L3k4Zk1yVi80clQwVmxJYlNFelVISytSQTVKZmp5MFVDeFZhbWx0TUFCQjFH?=
 =?utf-8?B?NzZ3V3VBU1N3UFRibmVtUnlvQWlSenp3SHZERmhaZ0xtc1hIVWVVQUxJRzRL?=
 =?utf-8?B?V2YyTzB6SmlUd1FoUjAzeGFmZHFnTktjaWN2ck9IU3VUL2YrVGVJejQvN282?=
 =?utf-8?B?czFyaXBtNGE4aktwSkRQYWQrS2UyQ09PY2NRMW5LNnhGWnZtR2hhOWxGK25J?=
 =?utf-8?B?TTg1SWFyTmFKNnorTS82MWNJazJLck1ibk0yOHJ6RmpGUVpXLy9BSm4zMFpa?=
 =?utf-8?B?MWdmUGtJTlZDUFZ5MHVhYW9LSEFYNnhOeWJHdy9NSHFxRjVwcG8vSmlPQWpU?=
 =?utf-8?B?akFyREx5Ylk0N21jWE1EdFFqSkFFUWxwY3l0Ym1oSE80VHFZc0F0NFhNTXRy?=
 =?utf-8?B?d2xJWHFaL2VKaXppdVdPRVAyMk9sTkFxczRQUy9yeHBaYjFCa3M2TWpCY25S?=
 =?utf-8?B?YUtIK3VySmZ4NlVYZWIwaXV0MFIwQk5BdmJWUy9oWm5mWHNrZUhiblozc2ZG?=
 =?utf-8?B?WUZ6SGU1SlBndU5VbTdzU01oMGhGVlJFUDQ2QXRNVnVjTW9QYlJEUU1yd0pa?=
 =?utf-8?B?S2hIK0c3MGQrWjJkM01ZWkk2c3RhTUJub3NyLzV2MDJ4TDBrSzBhZytYb29I?=
 =?utf-8?B?Nnd2U1pnTFJVVVZZQU1jb0xBOGY1cGxoRHQrb2c0ZUdlU3NEajdrc3NjYktj?=
 =?utf-8?B?QlNxZWd6WVVUQVZ2YWFWajNOdTlJTVlTdytqRkU4UXNHV0sxTmh0TDJSakhW?=
 =?utf-8?B?OHR4TmwyT0NwRlJtY1Bqdk1ZMUxWdTFtQXkwdGFCVVppNkMwTWdMNHYyMHBM?=
 =?utf-8?B?ZG5UMHRSOU1NNFAvcW9vK28zbStFSFNaOWVNcFRpNHpBeWlCYjVjaWo5aDhG?=
 =?utf-8?B?YktCVlB1SG43YkM0NEtTT2FUN0NqcjJHUkwyTXJsWVg4Z09mSFMwUWxyQ2hm?=
 =?utf-8?B?Nkx2bEZxakJzaitEZkxWaDd6SEJYOXU4dG5laDJjYjVMVkJYWktuQlpnUzZQ?=
 =?utf-8?B?WDhyRnpwNy9kamliM3J0VEVxLzVwL25sUUwxeVhaMnVDeUFBQ2VFMWlBdURG?=
 =?utf-8?B?cDg1K29DMjFSc29RbDJLMmpJbGdIV0VOR2EvajF2S0dxYmN0eXdQRlY3WEZG?=
 =?utf-8?B?eVhxeE5uOUt0NlZhVGFva3p6dVljS2drb2piUDh3aUxOUkxSMUtVMFFFZktV?=
 =?utf-8?B?d3ZNK1Y1RWdveVJGN3VHUEYxeHZaWGF1ejBXeWJPcFY5ZjhJcWlwa0sxMm00?=
 =?utf-8?B?WXNLSnJtdkxwNFROblNOZlV2RU8zZHlSSUFyN2plV0N0VGxQTTZsWnNsZDFz?=
 =?utf-8?B?bGpsL3phWUVPdE9sQi95ZDMvZHhoTkhtQWNmQlg2UjNXWERlWmxBOTVaTjFh?=
 =?utf-8?B?UlVZeGhGL3RZT3BPVEpUdkhYNlE5a3ZVWjFOZmhtT3MxZGJSdE8rZE1HRThI?=
 =?utf-8?B?TG9ZV3psTWJ3dXc3eG1qaTNpQnBIbXFNM04xYzZVRm40SHcyTytUZFdsN1BD?=
 =?utf-8?B?NldyaEFpZ0FUZVl5cjFzaDFhRkNDVFEvU2dJbVBZR3BvWnBRZFRJUEtlNnRQ?=
 =?utf-8?B?dm5WdzNTZWwxOWQ2ejk3UVBLT2hEYUJwRVBXVjJ3Q2x1b0hLZjdpMHIxRDBQ?=
 =?utf-8?B?YVpvK3pwYTlVVUxoUHhCV0N3YWI0RzRaWTFoZEdvcGNQY25OQUFyNGx6Yklh?=
 =?utf-8?B?bmpIMEYwbWplOWkrTzRJY1dSMzZkcGRCSXNvY1RFSFR4NHVmUjVUdFVUbHAv?=
 =?utf-8?B?MWRwVytPWkdMVGJOZTdMblU3TE9qZXZhei81clkweUs2WVFBRitDZ1NYQlls?=
 =?utf-8?B?dDZhOThSM25jcDY3aGJjQ2paNlk2RzNtSEcrTmN5cXo5eXhRc05FZWxDWjNQ?=
 =?utf-8?B?WUFmeXIrSi9QZzArd1VKQkx0eTd6azFxNFZiTXlHQXl2aENNV2plL3N2VDBQ?=
 =?utf-8?B?UWVZMXlWQjQyTk9adHpuSkZ2NHBhQ2kwS0EzUkhsVTZDUTNONldHMkE3OENN?=
 =?utf-8?B?amhDZlA2Nk9CcEhjd3d0TFNsY3pSZkxzdUloTFBaTFZRQytkckVHSU5pRTl1?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b766e8-0d16-473f-d35f-08dc11dd97c9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:11:01.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mp4PPDJa6GP7XU7ixl5N6R9SfeWWENBRjYl1Fj6bSbAd5nnoXBMk9nie7wk550dt5sJOsautOOCb+lSc6lWlYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3855
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jan 2024 13:11:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14323

On 10.01.24 13:37, Cetin, Gokhan wrote:
> 
> This adds necessary crypt modules and loop device that are
> not loaded at early boot as default with upstream kernel.
> 
> Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
> ---
>  .../files/encrypt_partition.clevis.hook                   | 4 +++-
>  .../files/encrypt_partition.clevis.script                 | 8 ++++++++
>  .../files/encrypt_partition.systemd.hook                  | 4 +++-
>  .../files/encrypt_partition.systemd.script                | 8 ++++++++
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> index 37b373c..7e69f88 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> @@ -35,7 +35,9 @@ manual_add_modules dm_mod
>  manual_add_modules dm_crypt
>  
>  # add crypto modules for debian upstream kernel
> -manual_add_modules aesni-intel
> +manual_add_modules ecb
> +manual_add_modules aes_generic
> +manual_add_modules xts
>  
>  copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
>  copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index 6d8f209..9be03e9 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -36,6 +36,14 @@ esac
>  modprobe tpm_tis
>  modprobe tpm_crb
>  
> +modprobe ecb
> +modprobe aes_generic
> +modprobe xts
> +
> +# this needs to be probed particularly
> +# for reencryption with upstream kernel
> +modprobe loop
> +
>  # fixed tpm device or do we need to find it
>  tpm_device=/dev/tpmrm0
>  partition_sets="$PARTITIONS"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index 0a39da6..abbe28a 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -32,7 +32,9 @@ manual_add_modules dm_mod
>  manual_add_modules dm_crypt
>  
>  # add crypto modules for debian upstream kernel
> -manual_add_modules aesni-intel
> +manual_add_modules ecb
> +manual_add_modules aes_generic
> +manual_add_modules xts
>  
>  copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
>  copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index 2ac8d30..67d56f1 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -36,6 +36,14 @@ esac
>  modprobe tpm_tis
>  modprobe tpm_crb
>  
> +modprobe ecb
> +modprobe aes_generic
> +modprobe xts
> +
> +# this needs to be probed particularly
> +# for reencryption with upstream kernel

"Upstream" is a bit vague here, and all those probings depend on the
concrete kernel not having the feature built-in (but having it at all).
The reference to re-encryption can be helpful, though.

> +modprobe loop
> +
>  # fixed tpm device or do we need to find it
>  tpm_device=/dev/tpmrm0
>  partition_sets="$PARTITIONS"

Looks good otherwise.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


