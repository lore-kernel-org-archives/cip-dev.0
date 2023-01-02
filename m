Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC42BC46467
	for <webhook@archiver.kernel.org>; Mon,  2 Jan 2023 11:44:23 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.62])
 by mx.groups.io with SMTP id smtpd.web10.33983.1672659861182088809
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Jan 2023 03:44:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cPtMer1I;
 spf=pass (domain: siemens.com, ip: 40.107.6.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U14TZpQIPVP4xVqT9/oAmCNEnGGgpX+p1tnd7V1XOWq5XQufuxqMBFOkkKW3xF1SCOgldIYkre3MMd0ZmTvWnG52l4CDX9Na5INPz0akqBAGzbprmS+UKLzpOFqxV8VI3D7XcZorkKQ1bk51qhQ1YX4OGY5dxWX5qo0IMS+ljwJ1AJEkGRkOjbkrFiGEtizQL5V56nYW/tqauzrG/hWyAZt/LLxq46bSS2Af9BlrpJ3MXXStubnTEQNu4N7x5TfAQXXCr6hLEZs4m8ZUcTr8uTDpkgIUuQOk2E11KdUjlFzwmLKs9oNr5moHWZF2YMK+0DMpul0egVOLvZZvZbqAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH8kxUl7miLHn5h9MKcSVL4l5VwR4sjU3rjlq6VLIuY=;
 b=FRKlrYzCXdYZ1+3spEGC61HtOM5diVhLZO+tb7U3vsFUCZzR8WEVQYPI35FPAYFXrhBpA72K2dfKuvEImrz7K2PQ99oqK8V2ciULcWmhH7cFlES8wXss+mO+hLP52YTzUgnuomB+6j7PFlM+9FY7jBGC+JpRvzf4HwXOZ4TmgghId2fK7nWDVlXB1shshEvndLux9H2JeaqOvJ5wKjaGf6kRofLsMxdgPxXbI1mz9mCa9v/W2QrXYoMaoU4mWxSg2kcVQXxDlUPWCQ8zNxtsJJx1M2ImttZhCpicEmtTuFnjAtkSDtVdfeOPBabcL0FbtbnTCqbJZgAKU0cTyHScOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH8kxUl7miLHn5h9MKcSVL4l5VwR4sjU3rjlq6VLIuY=;
 b=cPtMer1I/ZuJ07NTakUY9LmTTxOkZ2QBGNTJ+6vaxCQV1MHtC/vWvdHwqHZH3IPtzGfPoVBimihKD12ek0UcFqLe+WSMFlvRn8MNmKys2+aM3P/OiO7zuda9gWVBeMt8pUEwKMRg7SnkuMVibGwaRDjWS63vdLF0gD4g0LCje8WMXx9IW9b8sn3EbIy/GHmmd7GFSWGnBXZ8YR4pGcJ9VqTrFlqFKg6WaNAmzSwkmPXdN9U+LJwBtynQClIdopcKuI/k0m7U3fMwYINyx0g+Tzr/HxFjGYhSrownjK4ntXOZO7oTk8qNZw7YBWl+HThl1mJy+Jsi9/d6jvQNiR0P9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6416.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 11:44:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 11:44:18 +0000
Message-ID: <32437820-77a9-2b43-3e31-98de4a4951ae@siemens.com>
Date: Mon, 2 Jan 2023 12:44:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][RFC] Create a generic initramfs overlay
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20221219132118.325050-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221219132118.325050-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: b031389d-6827-430a-38a4-08daecb6ae91
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bmn3lPtfVmV9dqX8XQF1Bp35Bb/D0CkRpOF971WJV5JD+s89p9PqNXCFO5M4gqNTUUqhq/3lybbJmeptBEsXk7lYwxcGkDSsdqUHi09FmUkYSNZOl27PaZicRdFGnLMU2mBylSW9j5UjfGtHmj7z89ik59O8k3gA25To1NMRq659fyxPShviySQVkBsGPhpf8BZkYp7PLCk7QprwIYPFxQVboQGoc+MUSVeNUmibGs83A3loAODkJ3pRaXzsktAOP2qcFaj6rVTEktaQVS9leaQ3KzUT/JnzpuLq8PA7U9bFyF3lgGuIbUqA7T8/Q4ltQdg/js4H3I25Z94oAGqwFmfXztQPWoWWyn8jzzZGR8ASkC/4vtAADdgnqU8TcfUScFYZPVODzFU10WHWnUYeV9LmzbhRDmUlYAhoz/wz4RDBMkAHd1TEmdfWF4aETsivelj89n3R3BzsJKSLuF9b+yzAidIzev4ffRw1Hp2TQi+g2oy7xwdWYNcyuwmpZyVO3hK7IafBlAFHTFJwqWRg/BJc9dpX6ofHs+9EUNLTvGr+yxA7rASZSE24ExZ0aL/b9s3NhWar5m6UiWMxYnqQowyUUs5+bg0KIWVOE+mKczzYTQ7eZCVc2wH3ZszVYS4K28mbgikWD0goHYrKRLO3eckMebSLrL3DM5LGJ0T1Whbx/tpKEPSc2Bm6w8+1i3E3PNZTEDKxm9KXLt5UIvBxIKngulet2NV2eDBR4FP6laK2QyWyKZJrqBIetH9uGhB23447D5gphc8kmPL7Zfj2Qe9B+foAKe19TQKyJA7uCK1+YuE2T9rh7OEQZRXccxMR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199015)(44832011)(31686004)(5660300002)(316002)(41300700001)(2906002)(6636002)(8676002)(66476007)(66946007)(8936002)(66556008)(6486002)(478600001)(36756003)(53546011)(6666004)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(966005)(82960400001)(31696002)(86362001)(38100700002)(22166006)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U3hNTlQ4UXhOa3lvbk80b0tjNkhEZklac2RTd1YzaXREaDdGNi8zV0VmM3Az?=
 =?utf-8?B?cHd3cllsZGp5QzJlOUdHSWVqeXAyK1F3aUhMZkRqdlY1enFWcDd6RXBqU2xH?=
 =?utf-8?B?azRaUmFDSkthT2FMdWRWa1p2UktaSjdPWTJMWnZJRElyTlRqNG15RVY2UnZQ?=
 =?utf-8?B?a0hNZTlMM2dNREhRbjY5bGxnZGVxYTQ2ejk5SzYyelNmbHJvVmR1WXZQQ0tC?=
 =?utf-8?B?NWxWNGJjYWtQM01SZXg1aDA0MVAxT2s5OFdsb3J6Q0RxUzVWdWM5anZYYUZE?=
 =?utf-8?B?VHRSSUlZWGR3NnA2d3A0Vy9pT3l1QnBKeWgwZ3dRVDByd0FyWjcwNUtwbjlC?=
 =?utf-8?B?WkUzNGNQN2VaQjM4bVpnb0puL0xDTGNvOXFkOS8wS3BkMTZ5REJxSDh5L2g2?=
 =?utf-8?B?V1hLWlZOYkcxNVJtK2MwZ01IaFp2dkJrNTZ0aDVkOGxSL0h3T3ROWDJHVzgx?=
 =?utf-8?B?VVE5NFF3TTlSQkZXb2J6ZUhiTnBBMUFsazlhYXNVL0VuaStPRmZFTW9NdlBn?=
 =?utf-8?B?Umx5b2RCOVZ4Ymx0TGdPQTcvQjQ5TFN1QXVHSk1lbnlJZzN3ZFFiakhrUkhO?=
 =?utf-8?B?WVJscFFxd1RHVG9rcG1BUjlYSkVld2RPNVpzVjNia1d0RG80WUhVNGNxTUlH?=
 =?utf-8?B?VkFhSlcxalJKcUNQdnpsc25CYXJCemtxWW9nclhldTNZd1YwQ2VpdXRhRWFy?=
 =?utf-8?B?MU45b2JHL1lVM28ybzFTcVRWTFhpQVRFYTNjSHc2STAzbFRINWJCeURlaDVp?=
 =?utf-8?B?dWg5NldsZnZON3VFQTVqb1ByWDE2WS9MT1liSm1CeTMvVnJITVJwN1pFWHhF?=
 =?utf-8?B?SHpoUldyR0cyTmFVK0lsUE41NVRIakdWcDBVSG5BUFdoeW1LMFpvTVg4ckxQ?=
 =?utf-8?B?SVVudkV2UkhMQUozd0RMSWRtRGdqUXJPOVVSZkhZMUtHajI1YWxVdDZmUjhM?=
 =?utf-8?B?WVJhZ0llNmhDbXpSM1VvLzBNVHYzNDkxeHQ2aTRMekFwenF3bjZ2UXRNUU81?=
 =?utf-8?B?cTJ2ckhadi96VDM4eTZ2Snl2U0QzNUNiNjl5ay9WLzBUcHZrV1dkUnJLdWpG?=
 =?utf-8?B?eXZFaWRRdEt6VlZURWNMVnNPK3NpNlFTd3FLWnN1U0pUZmlCNHBRMUV1eXVp?=
 =?utf-8?B?TEphdW9saGVGaFNSRmFvblpQdGFMZWlhcXY2M3hlRnVlVWRTOVo4MTdGSERM?=
 =?utf-8?B?amh4dnkyMmVCb2lxd1RZc0o4aXFMMHozRnFNb1BEMHB4NWxNZDV2R1lsRGZz?=
 =?utf-8?B?RkJzT3BxOEZYRUg2QkliZDlKZUF6OEZ6TFQzQkptZmNjbVZ5UTk1WkJQUlgy?=
 =?utf-8?B?L2wvN2wwRWt6K2FlOUFja1FWdUZ6R1BNMU1vMjR3clZTWUF1NXJ2cUFwUExY?=
 =?utf-8?B?OFpiUmhhZnJSVFVSNkwweUVicmpyREZDNDIxQ2pQR3Z0clhzKzllT2wwRGZx?=
 =?utf-8?B?MjFjMlgyNGFJb21weXhXYVZod1k3YThVdlBKREczUCs1ajdIaEVPV0NNYVJJ?=
 =?utf-8?B?OEJnbXFQcGdqdk9OVmIyV1dudmJXSE1sT2VxNzF0aHl3NHpXZi80ajVKbnFN?=
 =?utf-8?B?eFVuMWplQlQ3VlRkK3JYZjJsV0VoalRnRityTFczSVhSZjlNaG91d214TlR1?=
 =?utf-8?B?cSs1dHh3OStqU210QVFpeUs5dUExMVhhbGY1dUd6Skw4c3BiQTZFQnZMaWUz?=
 =?utf-8?B?NVBwTklvOXk0bmhJSUpKODdKaFlOVlZWTGxPM0gwcVdDRFI3ZndQSFczM1Er?=
 =?utf-8?B?RUpXbUc4blVKSUNzQy9RZjFnRUlTdzVQM242cFJVU0x3SDhuTCsvdkhzZ2d3?=
 =?utf-8?B?MEkreDNua2ZHbGVuS2NyZDVoSzQzWWNtUFJ5eUd2REM2VkdKekxaRHlhazZT?=
 =?utf-8?B?UGgrdlNoaVFseHpzR2IrdHBJRURPKzBXTU80S0RNQlF4aytxYkNYMW1lVjVm?=
 =?utf-8?B?SHZ5NWljRGF4UVJBMVFSRHNuZU1KUHNpTXVwQWRsUjdGWlJJWmJldXVtUDhx?=
 =?utf-8?B?eVFMT2R6UVE2NVdHTSsxOHFsZXVndU5zS093M2xMcWFBNmEzajhuUWV1Qkxw?=
 =?utf-8?B?TFNuUVBoWkdpU0FHVENsRU50eGhHNjNZRXB2TlV5RVlzSzJiaFhBUnZTVkpB?=
 =?utf-8?B?MmFKQ0pINmRUNnpqOWFZUThnNWtEVTNyazRBcEM3cXVtUEtJVHlCKzRZVXVz?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b031389d-6827-430a-38a4-08daecb6ae91
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 11:44:18.4255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFYhaPd60HdXj/N5fZMIGnSJuaSMhDPpLd66tX++/WmDvXiSNq3GEsCDJOdsw7Y566jXb6yQNBu5dJxtO2tEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6416
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Jan 2023 11:44:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10275

On 19.12.22 14:21, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows the user to generate multible overlays in a given

typo: multiple

> location.
> 
> The configuration used the following variables:
>  - INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL: Label of the partition to store the overlays
>  - INITRAMFS_OVERLAY_PATHS: space separated list of overlay directories (lower overlay directories)

"space-separated"

>  - INITRAMFS_OVERLAY_STORAGE_PATH: path on the storage partition where the upper directory is stored

Why do we need this split-up of label and path? The script actually
considers path optional and falls back to label. Would be more
convenient to just state INITRAMFS_OVERLAY_STORAGE_PATH = "/var/local"
and let the script do the rest.

> 
> e.g.:
> ```
> INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
> INITRAMFS_OVERLAY_PATHS ??= "etc"

Why not "/var" and "/etc"?

> INITRAMFS_OVERLAY_STORAGE_PATH ??= "local"
> ```
> This will create an overlay for `/etc` and store it in `/var/local/etc`.
> 
> Closes: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/52
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../cip-core-initramfs/cip-core-initramfs.bb  |  2 +-
>  .../files/etc-overlay.script                  | 36 --------------
>  .../initramfs-etc-overlay-hook_0.1.bb         | 30 ------------
>  .../files/overlay.hook}                       |  0
>  .../files/overlay.script.tmpl                 | 47 +++++++++++++++++++
>  .../initramfs-overlay-hook_0.1.bb             | 37 +++++++++++++++
>  6 files changed, 85 insertions(+), 67 deletions(-)
>  delete mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
>  delete mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
>  rename recipes-initramfs/{initramfs-etc-overlay-hook/files/etc-overlay.hook => initramfs-overlay-hook/files/overlay.hook} (100%)
>  create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>  create mode 100644 recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> 
> diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> index 9e0ee26..860021d 100644
> --- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> @@ -12,5 +12,5 @@
>  inherit initramfs
>  
>  INITRAMFS_INSTALL += " \
> -    initramfs-etc-overlay-hook \
> +    initramfs-overlay-hook \
>      "
> diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
> deleted file mode 100644
> index 6e5aacd..0000000
> --- a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#!/bin/sh
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2022
> -#
> -# Authors:
> -#  Jan Kiszka <jan.kiszka@siemens.com>
> -#
> -
> -PREREQ=""
> -
> -prereqs()
> -{
> -	echo "$PREREQ"
> -}
> -
> -case $1 in
> -# get pre-requisites
> -prereqs)
> -	prereqs
> -	exit 0
> -	;;
> -esac
> -
> -. /scripts/functions
> -
> -if ! mount -t $(get_fstype /dev/disk/by-label/var) /dev/disk/by-label/var ${rootmnt}/var; then
> -	panic "Can't mount /var partition - overlay will not work!"
> -fi
> -
> -mkdir -p ${rootmnt}/var/local/etc
> -mkdir -p ${rootmnt}/var/local/.atomic
> -if ! mount -t overlay -o lowerdir=${rootmnt}/etc,upperdir=${rootmnt}/var/local/etc,workdir=${rootmnt}/var/local/.atomic overlay ${rootmnt}/etc; then
> -	panic "Can't mount overlay!"
> -fi
> diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
> deleted file mode 100644
> index 37a04ec..0000000
> --- a/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2022
> -#
> -# Authors:
> -#  Jan Kiszka <jan.kiszka@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -inherit dpkg-raw
> -
> -SRC_URI += " \
> -    file://etc-overlay.hook \
> -    file://etc-overlay.script \
> -    "
> -
> -DEBIAN_DEPENDS = "initramfs-tools"
> -
> -do_install[cleandirs] += " \
> -    ${D}/usr/share/initramfs-tools/hooks \
> -    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
> -
> -do_install() {
> -    install -m 0755 "${WORKDIR}/etc-overlay.hook" \
> -        "${D}/usr/share/initramfs-tools/hooks/etc-overlay"
> -    install -m 0755 "${WORKDIR}/etc-overlay.script" \
> -        "${D}/usr/share/initramfs-tools/scripts/local-bottom/etc-overlay"
> -}
> diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> similarity index 100%
> rename from recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook
> rename to recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> new file mode 100644
> index 0000000..7acabbe
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +
> +PREREQ=""
> +
> +prereqs()
> +{
> +	echo "$PREREQ"
> +}
> +
> +case $1 in
> +# get pre-requisites
> +prereqs)
> +	prereqs
> +	exit 0
> +	;;
> +esac
> +
> +. /scripts/functions
> +
> +ovl_upper_dir_partition=${INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL}
> +if [ -n "${INITRAMFS_OVERLAY_STORAGE_PATH}" ]; then
> +    ovl_path=${rootmnt}/${ovl_upper_dir_partition}/${INITRAMFS_OVERLAY_STORAGE_PATH}
> +else
> +    ovl_path=${rootmnt}/${ovl_upper_dir_partition}
> +fi
> +
> +if ! mount -t $(get_fstype /dev/disk/by-label/${ovl_upper_dir_partition}) /dev/disk/by-label/${ovl_upper_dir_partition} ${rootmnt}/${ovl_upper_dir_partition}; then
> +	panic "Can't mount /${ovl_upper_dir_partition} partition - overlay will not work!"
> +fi
> +
> +for ovl_lower_dir in ${INITRAMFS_OVERLAY_PATHS}; do
> +    ovl_atomic_dir=.${ovl_lower_dir}-atomic
> +
> +    mkdir -p ${ovl_path}/${ovl_lower_dir}
> +    mkdir -p ${ovl_path}/${ovl_atomic_dir}
> +    if ! mount -t overlay -o lowerdir=${rootmnt}/${ovl_lower_dir},upperdir=${ovl_path}/${ovl_lower_dir},workdir=${ovl_path}/${ovl_atomic_dir} overlay ${rootmnt}/${ovl_lower_dir}; then
> +	    panic "Can't mount overlay for '$ovl_lower_dir' !"
> +    fi
> +done
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> new file mode 100644
> index 0000000..ee8635a
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> @@ -0,0 +1,37 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +SRC_URI += " \
> +    file://overlay.hook \
> +    file://overlay.script.tmpl \
> +    "
> +
> +INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
> +INITRAMFS_OVERLAY_PATHS ??= "etc"
> +INITRAMFS_OVERLAY_STORAGE_PATH ??= "local"
> +
> +TEMPLATE_FILES = "overlay.script.tmpl"
> +TEMPLATE_VARS += "INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL INITRAMFS_OVERLAY_STORAGE_PATH INITRAMFS_OVERLAY_PATHS"
> +
> +DEBIAN_DEPENDS = "initramfs-tools"
> +
> +do_install[cleandirs] += " \
> +    ${D}/usr/share/initramfs-tools/hooks \
> +    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
> +
> +do_install() {
> +    install -m 0755 "${WORKDIR}/overlay.hook" \
> +        "${D}/usr/share/initramfs-tools/hooks/overlay"
> +    install -m 0755 "${WORKDIR}/overlay.script" \
> +        "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
> +}

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


