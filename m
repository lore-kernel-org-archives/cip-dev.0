Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD91FC4829E
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 18:07:40 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.45])
 by mx.groups.io with SMTP id smtpd.web11.13679.1707761259459611737
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Feb 2024 10:07:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kHOwRj2D;
 spf=pass (domain: siemens.com, ip: 40.107.241.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPnkQCoxYwb09e0Tkr1oLB0mZGxkI3AJ9ZsN8h9/svVDRIHK7HZIbn6QAF1r2RwCQVsGpZhA6uZ7Ag0pZwoAy8o+rDgXhAqjPUNvaWabvyVZtWNxM7LjNM8oJzM/pomho50rGgzoR5spTtPwvgSCA9dPI8Gvyaakv/ey3ll8+YE4+VqVt9rtJ6Ty5LctUVzydGpv/8ap9LMh8XJRrhif49OX/u+SDRgQx+UXOGcStE6UTqSavFz3PXne+0NjFXYV72rWJ/XICHz6wlzYQAYEuZG+JYahI4Dt+jsjCCldSHMZ0WRpQUrKmPkmlsaSingx3Z8NvRhMlz3WYaOq1v9bnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTHavY78bKXIU+MW8msS2CJz9sRp98p7GEZGvktvcOs=;
 b=Oh1ze2fsh9LEVLNGF513hvY+lSEHmlIMgHT0nAk/lHRhTYx3yKnQgKGLhzLeSQBxil1cqrfqab8Ozv/U8EmhXlRsu3kGOCftbumoVSuINbexDjf2EIKFGp2CLJtecBEjYCmCudr4x8gNgsE7qiu4OZii9NQvNsEe+kpBY8QDPS6BYTnpOkTO7ARTjR3tne6kse41GweFhlmHhlFD5jHN8rxhjlD7iejh2dIYigyNmuolv3UyMyH40EG1z24Fs0mAD2a85+qnX2uHCAoJN//WhFNe07/Uy6YdTEp49osYI5j1m2STWiYUrksoo8HLqrgDmAVX2BGix9+HoGgCBG3gQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTHavY78bKXIU+MW8msS2CJz9sRp98p7GEZGvktvcOs=;
 b=kHOwRj2DRsILlRFw5t/rqrGcXnL7t6k5j/Mq849/G6a0+021Wtewt1cpB/T+vA3u/LvTP80d54EUJS8WFyT10QspYawYxI8P6qq3wiUSi6IGJgaJmKJZdClI7q2YNZw/27MwNE73UkYsj2N+LL1tnjhL9kJOaiowgVm6O0eIDrDcuQ++arlYQYI+lc+Nf3BDwyZBOyAedSFK96EmvBec5khXqSzIVgCgnnJsH4QnHCc79O9QNUj6FjIBD+tgrzXOczieXqqHKqdf3J/h7Ix/hBBP76GJYrkrpkHjN2ZkgZZrkoWxhA9NlHNusXvadNWbSVYbwdhMTYYmOOo+yqsU8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:37a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 18:07:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Mon, 12 Feb 2024
 18:07:35 +0000
Message-ID: <5a9081b0-aafa-406d-b79f-7fd5b3547882@siemens.com>
Date: Mon, 12 Feb 2024 19:07:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] refactor: use change-dir to split
 rootfs parts
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240129115918.107645-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240129115918.107645-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:610:5b::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 853ba00f-ade3-4dd0-5c80-08dc2bf57d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EIzNcgtQxTGuPHM4tfh9ADuXSOmekb8qa6fVfegBs5RwkIaBDOXb8gscZl8IqKDoMI1746tbzZnMH2bDV8pQCXqSOzeCY7b84tEZOGR9GYHoDDjlqWLwRNDclL/tamaoWEfgF7VLkdzN8oNn1exc5Or5kE8rI2vsME4fVsjW2J3ChBQ0YNza99lx44BfV1n4S2O/z898YC47x2/RSyCC2Ctns2irGdFAiGzfOCn1r8u6pwGGOg5J5kKmabjG2RmpakRDyeynmorYOSBbGaRi/igf7YTXPrrJtAxfewNiT8BHOkdLWEs8nIIa+IcD9+LF2r+SZjd+/G1zld+CJOkh1kBwTTwXlNZHJsKDOVRmKFuZOYnVd2VcNxSqrXif5cYAhyLx7dEdVNUxLQ77NLq5Ui4PDvnlOiQlAJCKtcyaIgOy/oCINCKYKfwBRcdM5ABuQt/N39NxQMWJxHqqMSkFHhDD9lzowr6a6f3IHrYNE/SiLwn9MUPpRipwInHFKghgD/9AV+KXJqC9rqufK4i0kRUBsV+H/Xj9/wogX2tGTJyS16aVQTzVXH7f15LViri7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82960400001)(31696002)(86362001)(66946007)(66556008)(66476007)(6506007)(6486002)(6666004)(478600001)(2906002)(5660300002)(4326008)(8936002)(8676002)(44832011)(38100700002)(26005)(2616005)(107886003)(53546011)(6512007)(83380400001)(316002)(66899024)(36756003)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aDUrQmNUeVZCNTZVSTVsemNXeWY0Uk1VbmNLZGZKT1ZaYUltMjNtejBuSUty?=
 =?utf-8?B?RG1DWU9sVXRPNTNESVZlNHBIZWczKzRvZXpjb3lpYnRPUnVMYlRleWJmWnM1?=
 =?utf-8?B?YlZmdEp0MzNFeVpQSmFSSlFqRlZReDhuNGdKZWhNOERUTzVBY1dmQmJkVTg4?=
 =?utf-8?B?Y0xLNDE4ZUhuRXZ6eFlweW5TUHpOTlY0K05RRUphNlBhdkxYQlppa2thS0dE?=
 =?utf-8?B?YXo4d1pwUFNGSForWXZvOEFpZWNVL2VNbWQzR3lwL2MvSUx0anh1dk5hbUV2?=
 =?utf-8?B?STRvZGRlTFRRTTJCZzZidXphK1RTUzBxNm9YNDRQYWxkSmFTeGJmZzk4SXpH?=
 =?utf-8?B?cmRYUksyVUNYZHB5Wkt3NTdBZ3kxcmRiT3BOcHZySkg4OUZOUThLem1SQVVG?=
 =?utf-8?B?ZUI0Q0J0SFZ2UjRBZnFCbnMwRU40alU1TUc3R3cvaWRLSURYZFpMYUUvVkVW?=
 =?utf-8?B?ZWUwSjlCazhNcjJMNFJqZjcxdlIzOE94M3pMcEwwNE1OcFRUWjNDeUJONVhh?=
 =?utf-8?B?N0tuTjdaaXNLOGZHUW5tNFRhOTZ2d2NQQ0FGWVl2YmNNUkRoNTBrUVlIS3NM?=
 =?utf-8?B?NXBPbExzLy9DZkEyeFBLdnBFK0gvdWpnb1VqVllxVVV2bmRMMzNQVVlhTWJs?=
 =?utf-8?B?SU9mSjE3YmpadjdaelpjUEdCeG9Oa0UwTmwvQjd6R3dxUTdySlVmYngrOUJx?=
 =?utf-8?B?QnN5bVRndlNjY0RvNVphaWpLNEYyQmdreGVHbTBORkFVWm93dXZMM2hzUU9B?=
 =?utf-8?B?dE1FdVBxVmZVd2JjaHh5c0p6MG5abEh6dDhVOHhmdEhtRXN0UGxjYVA2WWhP?=
 =?utf-8?B?ZnpCS09obmJHMWRIN1F2aW1jTm0ralpTd0NWcWMwN0Z4QWM4VGVDYlhHU1VV?=
 =?utf-8?B?dkZzRldSdFZhZzk5WU1ONzBCckovWGFRY0E4VzR5Nk16b0d6ckhlYWZiYVJk?=
 =?utf-8?B?RzU0UjhVMWN2MVpOR1FxMDhFY3JZblhaQzNWLzM3dEhKaFhUanErOEZkTHgw?=
 =?utf-8?B?MW5HVE9aODBxaUYyelk4QnRLRXNORUx4ZzB5dUl0WS9nTE1ycnlJdWtNZ0dr?=
 =?utf-8?B?SjNsQTJmRzk5TUFaVzVSRVNkcis5NHV5cEh5bzZaYUhHYWY5STVmUzQ0aG5E?=
 =?utf-8?B?dlZYaXR3WjdJRFUyMXVqdmErT2MvbEM0VHZkc0ZGMVFtUTJpQXVIUHRVMmhQ?=
 =?utf-8?B?bEpvZDRFdCsxa2ZBWEtSczkzZDUrZmUxUCtjS2doN0dRZFFLaVV4SysxT2xU?=
 =?utf-8?B?aFF6b1VSTmRFSGExQjZsQi8wNkQ4ZUJicTRuWjJjSlBRN2xmTnRnNzJwcGtS?=
 =?utf-8?B?bXJxUml2Y1dLR0lPMnhyQ1NaNjd0cHRURmp2b0trcnhvNU5HeHJhZjhlNUIy?=
 =?utf-8?B?eVh0VXMwQ2Rlc2VKaVdGbjhFcjY3MWhpeU1GY0o1R2h6YlJUR241UkVUYlNI?=
 =?utf-8?B?enFuWjA0dG9RMnYyby9FZzZrUHZQRHJXY01qNkcwdC9sK3JjOFg2YXFTc25z?=
 =?utf-8?B?TU9uNldHYTNPdlU3VWhoSy9VUFJxemdocHdSSGV2MmowVmJXVThRcENZaEtx?=
 =?utf-8?B?Vk92ZHpJTDJPRUhCbm9sWVhQQ3htcDhSeFRBZWZKWm9scm1mamN2MzBsYVNN?=
 =?utf-8?B?RWJMYUdtb01GQkZTa05NKzJlakhKZ0RQNkhHWkJsbGpMbCtZWjhTVDJ6eGk5?=
 =?utf-8?B?NW9JeWxRM0c1ZWVTVThMQ2lrSzZpM1I3bTJHcWxDQzVrdk12bDB4SWx2WDNP?=
 =?utf-8?B?N01TQ2tGd2tnWkJzd0ZhZ2JLSXFxODlxbGgraEpacHJ5VHRzdjVqSFV4UkFk?=
 =?utf-8?B?cmRVM3hWQzYrYjNvMmp2YzRiUGp5QllQOUZmNzBuNHpXNHd2OTlCUHhHSCtR?=
 =?utf-8?B?dkwrZzlnWjd1QUoyTDRMcGc4TE0vcU1tZnorYktGMW51UVhWdkl5ZFNaK3gv?=
 =?utf-8?B?UjZkbEpmTnZzSDZNaHBNaFlCOUFsTmk5cUplREliVi94TzdlUTd0OUhZWU5W?=
 =?utf-8?B?T3JCTDBrRE9mdlg1RUxSK3lJWTM4Unp6NkFCdHZVK0xQNVNtVktxRzZtalFx?=
 =?utf-8?B?SmxtSjA5c0Zxb3RWV2hheVhWZHJwMGNZeGU2azJWUVlrQkdXM3Fsc3pQU1E4?=
 =?utf-8?B?eG5SWlZDS05jWVRjM2g0VGYyT2JjRmlOSEpvTndZNmM3eHhkMnZ2Ylh2N2ti?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853ba00f-ade3-4dd0-5c80-08dc2bf57d85
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:07:35.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2dfYl4/QSv/O4lxzDBcb8tnPar+sEgozR4im8xEZxTvAWEHPy0q8QLKswsZ3m0U2Y3gEMBHetZOJLyJhsSESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6046
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Feb 2024 18:07:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14923

On 29.01.24 12:59, Felix Moessbauer wrote:
> This patch refactors the WKS script w.r.t. how the rootfs is distributed
> across multiple partitions. Previously we used rootfs-dir with a full
> rootfs path plus the sub directory. However, this is not ideal, as the
> relation to the rootfs folder is lost and also the new rootfs dir is
> technically not a rootfs. While this aparently did not create any issues
> in CIP, we still believe it is semantically incorrect.
> 
> This patch switches that over to the WIC option --change-directory that
> is provided exactly for this use-case and only deploys a subdirectory
> without loosing the rootfs relation with the permissions pseudo dir.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  wic/bbb-efibootguard.wks.in                   | 4 ++--
>  wic/hihope-rzg2m-efibootguard.wks.in          | 4 ++--
>  wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
>  wic/qemu-riscv64-efibootguard.wks.in          | 4 ++--
>  wic/x86-efibootguard.wks.in                   | 4 ++--
>  7 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
> index 48789c7..6c62846 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -15,7 +15,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
> index 2ac8850..a9742cc 100644
> --- a/wic/hihope-rzg2m-efibootguard.wks.in
> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # home and var are extra partitions
>  
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index 2e5cb39..f6d3243 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part /var  --source rootfs --change-directory=var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 2fc389c..9baaa47 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part /var  --source rootfs --change-directory=var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt --append="panic=5"
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 1f50ba3..e96853e 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt
> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
> index 9158aa4..24e9acd 100644
> --- a/wic/qemu-riscv64-efibootguard.wks.in
> +++ b/wic/qemu-riscv64-efibootguard.wks.in
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index 98e8da5..60897be 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # home and var are extra partitions
>  
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "

Sorry, this no longer applies. Could you rebase?

Strange that Yocto/OE-core themselves do not use this, but maybe they
just don't have the right use-cases in-tree.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


