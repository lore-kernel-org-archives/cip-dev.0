Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCE2C4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:34:43 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.48])
 by mx.groups.io with SMTP id smtpd.web11.12037.1672839273462645639
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:34:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dp7ayEyo;
 spf=pass (domain: siemens.com, ip: 40.107.6.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz0A7fRpmniNtSnvHMhu5G/TIiV19tt467RpwGlXEYOYcUHqEgPEEyNTzLOGl46YnjS9AMdunWdk0TNqz1vma4gWUfzL/jB/7ruNxg2X9kvVpJVOiwIhkiA9RTUQl3PXIhpWJZSZ51EX6gjkoQSQqfBDFK+QLg67776NKkNp6tIGmYBZT5pDYulkEs7C7YS9j2FUZpCQlEHya9My0QB36w+mlUmJXykjKobnPh0sIvY+Q7mm52KJpXYqUrwZvzdja9Ibx01cAXtJZ/ZI6+LryDKhjbLPsj6G6Knnflr05AxjFkmal/ArXvbr5zOhaTTJ28+B+5W6fGr29Na5Nlz24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9IVkBB6+tBwwzg7ySfdiv6SRAxGrr8NxKtHHbisWAA=;
 b=OUi6ymjm0guV3GV1ilI0Bg2OYDCyKDZCm/sT5KUUQBssEsiSvwi6uYuyUQRJZE3ZiX2DYhPEaSOy6GUZWTa4mCBvBfSIloCtVj1ip5CPvkS/1RpRxJFsHJwYcz7MwWcp1vuvag5whaArrOYNpLFUq4ZSSPo50xBfJmnUCqZDG7dj51qY+KNXofrgRk8KTdiGf14+MIEkUnqlAn06Ozaps/LYMmiQLGgHDulpv2HTcZlxb/w50cQZ0aFEwVAcYXBZo1QVbQBltJ6k2OOQzz9u7PzqoZczBuQiS8xNg/ziaE6Lq1ppNcZHtNJIs7LHPBloCkTkS4it5wZggUyRui0nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9IVkBB6+tBwwzg7ySfdiv6SRAxGrr8NxKtHHbisWAA=;
 b=dp7ayEyo9N5qAFfp7rnuAdb03pKbQkbznivxHjRhAsowx6Yrv+yd5nFw5V7eNdzKpiXUnGCtIM0XVbMN9Fmp9dPpxM5bsuD6feonP+u3Lh9+tCekoS5FvrNSQ9xQlQRZsPBLpPb4hBt4x1EBsmNpeI8BkTstuwk4SEDk5zh4oREEwuF/XhGAs/wL1O8XGyCxTcdVTbj6SlN2hK8eCDKOt8gwbEbG3DqooMAqRSjSZK45aH8k22BNop7bDVK96aMMiURrABPmq5to76/E32sA+wiHbyvm91hDaGsZzg1lrIEfXrXKjOQvFgOhCtTS0cokd098GG/uh6jMFQVMjZFBRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6892.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:34:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:34:30 +0000
Message-ID: <1f649ba7-d8bd-d429-5088-896e31a268e2@siemens.com>
Date: Wed, 4 Jan 2023 14:34:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH 1/1] Use global variables for abrootfs
 partition uuids
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, tengfei.wu@siemens.com,
 daniel.bovensiepen@siemens.com
References: <20230104030214.465039-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230104030214.465039-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 963a3b3f-5461-4a3e-5306-08daee5868a0
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0T4ZzfJv200EfpjHreTMCdE6v2TMLQaodEMopO2kBB5ZTOOgg8MVL14KVhH6HriwM706TvCalaQZfq4zGcND72n5kjTcgMcHaQKacq6BD29xLlwPd/IihncCA2+7oYne4IyrA0jQLTwmmVPgJTvt+igTbA2+Ak3r2Fa6+3kYAKISlM9dYU913Fj4szSaJ8rszZtHzjs557cu7neNg4mkMyDK8jnx6oCghN752lNizkllE1fGqf/Xhcxo2YfGCwxqLs0N5O6lNmZG5noGHFgXh7XMmulvQFGb1FQup1gnTO0HeaC0cyShgnAH119vlQfDKpwkza8dcJvrV2l5ikdSiAW7lsu9zn/IicsuAAMYCsvAf5JcUsgkkBLu0HeYTzMuZL1S+zBSICPIY8h11a4gzntnxHRmgEnptYDjkTJ9j5ut4A1FSqgHP6HHt/3zAq1u9VfqPtg4OAPae5xEiR4/IPDJhpU0XkD+UZfIeBD24mv0Dvn7Wk36rgwqNtwn4AvjM6RFjjUe+VjD5aF3Xr0MJPjpZMbaKLqgLESWl3j69sXKbTB/TckcL8oAW8BlPYDiUBf3HH+gVNrLYCehAapAWwmAEFBP9sHfBhOcJSSzfaFdaWl3CcOTaLKSMP+1THiM6LIoW5+vQVQk1nz/j4Oftl0su9Kso0XHkCwn7vbT6+Szd2VWZNGd++FOirGDWMlqqWOafVorYUcq2xMnxjUwovXAXXjktdSeCD55PglRmUhLvYgk2e9/1xgGPklGvJat4cVlILvOy8Ssj9apqfRHOQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(82960400001)(36756003)(31696002)(86362001)(38100700002)(6506007)(53546011)(66946007)(66476007)(6486002)(2616005)(66556008)(478600001)(6512007)(26005)(186003)(107886003)(31686004)(6666004)(2906002)(316002)(8936002)(8676002)(4326008)(83380400001)(44832011)(41300700001)(5660300002)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RnBrNy9PS0ltOFByVTVNc29DMkw4eGZldzJIOWlzb0VPY294eTArSW9YODZS?=
 =?utf-8?B?RitSY1ZFd1pkaW5pemZtTG05c3BhOERXd0dFZk95UE9kcWJEclMzMGxOQnYv?=
 =?utf-8?B?em5XcFY5bUlXemdzcExsS1BhRjIwb2RWcmhoSTV1dC9EMjRCV05mOU1XcWJN?=
 =?utf-8?B?WUt0SkNaSHlRb1lKNXhMU0pEUW4xT2VzUW9BektDS2d5OEZYdjN6aTdTWldY?=
 =?utf-8?B?OUJYbkFRek5wVnhJYUEzTE01YmZ2V01pTGNMVG1FVGlKZ0w5T3pOVUltZENm?=
 =?utf-8?B?Unc1UFhNSGhMMnFkbW5oTE5FZlFaMTg1Ni9GWkc0SXhQQS9ob1luU0x2WVhZ?=
 =?utf-8?B?eEVDSGJOMXVvWlNwK014VnZGclZ5eExLaTBJZXhneHQ5V3hpQ2R2dWxwbERx?=
 =?utf-8?B?UkZRYWQ5R00xV05jczFhMUYrUFc1ZU9SNG9wUDJZRTNjNWZPdFZTdDJQdHF5?=
 =?utf-8?B?MDhmNFNEalhhL2h0MXAySGRMY0NrRHBqWFlvVXVaUEJhek1vaHhlUG5CalVB?=
 =?utf-8?B?VjNRR0RPa3dpdzVaU0IwNDB6dUtqeXlleExnNEdESEdPTlE0bVVNajNaT0Fr?=
 =?utf-8?B?c2hEVzYrb0pRT1ZsU2tJd25wbkkvMFpybE5ITzNpc2F1MUlaRGNYMTFOTDEr?=
 =?utf-8?B?MWFqRGJnRjQ1SW1aY3EwK1dmMUJXTjl0MUp4aVc4VnltU2RzMnNvL1NmMWkw?=
 =?utf-8?B?Y0NXN3ZFUUI2MGZRbjNxSFJLanI0NWVOT3F1MVYrbDQwVVJFMnRSTS9TSExm?=
 =?utf-8?B?anJaR0JJRWgwbWpKUlBXd1psblBidTVQL2EwVHNoRzRnMU9CR2Z0L2FZWGtm?=
 =?utf-8?B?cWlRWDNqb2hwZ3RGaDRFSDN2YWtVbTY1d0RHZUM5Mit1bmJXNVA1ZU5jNERl?=
 =?utf-8?B?VWJNT3ZrZmJRdXY1Y29XdGtkR2hNOGpuSUExYTBBUVNydHFvRnRvYWlwZmNN?=
 =?utf-8?B?Nk5TV3BLQm9oRkhqWmZ3NUQ4eVlOeTBGeXY5SFhUcXc2WlVwdXFvRml6Qk9S?=
 =?utf-8?B?UmRQalphMnByVlFWUFJobXNBeFFFQ2Q3QWtEQ2pDdFlVckg3cndRN2o5dWND?=
 =?utf-8?B?bFlUeDhOenFTVEU5UzVhci9tNXUxQ1pNZk1vSDdLUkJHSkFZeVBENUNsRlQw?=
 =?utf-8?B?VmowNGduZFlDeUloS1JjanV0RGlsaHpzV2NwMGxzOWNlNzZrSThuNGpGMjZu?=
 =?utf-8?B?VkF3ZTRaYzUwakNOZTlsdHk0VW5hSndDYy9SOVJHZUN5TlN2ZkhtMkRmei9E?=
 =?utf-8?B?Qk1xTHVlSzBsNEtFT2N4S0dMdXI3MTNCeVI0dVE4ZExZOWl2aUExZVRPSXl4?=
 =?utf-8?B?VWhxTk9jd0o2NDNyZnNrZXR6RWNta2trRjdhVjR4dnhLVHlpS2FrdTkvOE82?=
 =?utf-8?B?a0cwV1E2OGtrU3pycGczdUtiRTlGanZjN1pQQzRpMnR0TzV3Mnhlc3B0ZVhB?=
 =?utf-8?B?dGFteS9Lb0dIZzEzZ2tXdi9STjdKdExlVFNNZ3ZSV1RaaVcwUTFNdmt1TWYw?=
 =?utf-8?B?NXhNYjJMUEIwbEtOc2NFVDlGVWcwekpUWTdQSGhLbFZhZFhPS3ZlTkdpdDA3?=
 =?utf-8?B?OWlLaE9wdXVuZVhuYjhva0l2L09aZUVYeEpaeVgxRE5BRGlueUhhdFZiVlVv?=
 =?utf-8?B?alFqTVRGZG9qSDRlWVFxU25TcWloY0kzemdENXk0STdodXMyRStTTUE3dW5J?=
 =?utf-8?B?cXRCdXl0eGpyanpSNkhZQkxvcFhTWjFTMFdmOSs4VWRMWUk2U0VValFLYVp2?=
 =?utf-8?B?V2JFMmdvSlNqdEM1dXpTYU5JY0pCWThpWUdWa2duMDVkVWRmVSs0aXB3bUpG?=
 =?utf-8?B?Zk14T2taS1NRSHp2SDFKdzlNc3VodzBacWR3TzVzMDJYNWZHbTFWYVV4VGRp?=
 =?utf-8?B?dDU4QWFERzQ1VjJYc0VQakNUamozS1hLcTllZUI0Qis5amVQeDlaekVaY3NE?=
 =?utf-8?B?bFFEV08xWU4rb29kdGhnMkxJalJGVXRsU2NtSVZmVVNBdjJ6V1kzdUhoUml0?=
 =?utf-8?B?dW4yNW9iWmJQVVhkSDNqSDhyNXRCdUwvYmY5OTB3ZTMyU3FPVGl2Uzg1MDV5?=
 =?utf-8?B?c2JRWFcwYmNuVlkwZUlycy9DYlpRZi9nV3FHbFI3RWZxWUJYaGcrNzAyeWUr?=
 =?utf-8?B?QU5pNjlwNmVVUE90TDVReGhhQ3ZqREU1bW9lenpOZGZLeUdxSlAzS2pKUGpM?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963a3b3f-5461-4a3e-5306-08daee5868a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:34:30.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xuxDvMxWuZig43eXMgHVWLw/V/cfcCqC+/i0wxvJaBP0RqYk5/nfWR+E+0wUmtYp/mn6x9pYm53/pzcYiEKTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6892
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:34:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10312

On 04.01.23 04:02, Felix Moessbauer wrote:
> This patch converts the abrootfs partition uuids to a template and adds
> two global variables to control their values. By that, the partition
> uuids used in the WIC files can be kept in sync with the uuids used in
> the sw-description file. This helps to avoid issues where the part uuids
> are inconsistent and hence the update using swupdate fails.
> 
> To help users migrate, we also add a check for the validity of the UUIDs
> added to ABROOTFS_PART_UUID_(A|B).
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  kas/opt/swupdate.yml                          |  2 ++
>  recipes-core/images/files/sw-description.tmpl |  2 +-
>  recipes-core/images/swupdate.inc              | 19 +++++++++++++++++++
>  wic/bbb-efibootguard.wks.in                   |  4 ++--
>  wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 ++--
>  wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 ++--
>  wic/qemu-arm64-efibootguard.wks.in            |  4 ++--
>  wic/x86-efibootguard.wks.in                   |  4 ++--
>  8 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index f0d3f1b..60a4aec 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -25,3 +25,5 @@ local_conf_header:
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>      INITRAMFS_INSTALL_append = " initramfs-squashfs-hook"
>      WIC_DEPLOY_PARTITIONS = "1"
> +    ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
> +    ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"

It feels like we are piling up too much stuff in the kas option that is
hard to reuse by downstream. Maybe a conf include for distro confs instead?

> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
> index f7105c7..05125e6 100644
> --- a/recipes-core/images/files/sw-description.tmpl
> +++ b/recipes-core/images/files/sw-description.tmpl
> @@ -14,7 +14,7 @@ software =
>      name = "cip software update";
>      images: ({
>              filename = "${ROOTFS_PARTITION_NAME}";
> -            device = "C:BOOT0:linux.efi->fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.efi->fedcba98-7654-3210-cafe-5e0710000002";
> +            device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
>              type = "roundrobin";
>              compressed = "zlib";
>              filesystem = "ext4";
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 0ba3a0e..f98082c 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -16,6 +16,11 @@ inherit read-only-rootfs
>  IMAGE_INSTALL += " swupdate"
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
>  
> +# The uuids correspond to the partition uuids
> +# in the wic script. Set via machine or local config.
> +ABROOTFS_PART_UUID_A ??= ""
> +ABROOTFS_PART_UUID_B ??= ""
> +

Just handle the undefined case for those vars below - or let things
crash on resolving those undefined vars.

>  ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
>  
>  FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
> @@ -29,3 +34,17 @@ addtask do_transform_template before do_swupdate_binary after do_generate_image_
>  TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID"
>  
>  SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
> +
> +python() {
> +    import uuid
> +    def is_valid(value):
> +        try:
> +            uuid.UUID(value)
> +        except ValueError:
> +            return False
> +        return True
> +
> +    for u in ['A', 'B']:
> +        if not is_valid(d.getVar('ABROOTFS_PART_UUID_' + u)):
> +            bb.fatal('ABROOTFS_PART_UUID_' + u + ' is not a valid UUID')
> +}

Quite some boilerplate... We don't have that in place for other inteface
vars that need to have proper values, so I'm unsure if these here are so
much different to justify it. It would be nicer to have a cookbook on
how to consume the swupdate integration in a downstream layer, and that
would then have an entry on these vars.

> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
> index e48cc7f..a714694 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -11,8 +11,8 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index 0e298bc..8305ebd 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 3b8dadd..6b01443 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 9ff03e1..bc684f3 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index c71253d..0604deb 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


