Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE0FC3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:25:14 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.88])
 by mx.groups.io with SMTP id smtpd.web10.73185.1705307109104545299
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 00:25:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CCCqDFUn;
 spf=pass (domain: siemens.com, ip: 40.107.22.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHbOkOQsIOqrcClmcY8FOZLJ//8LEKMwnDoZIYnOVLt5xkn7gHdBO4Nwv+SGwzpLVI8SEzbyrkoQynCQ1lE0+XdRNU/4+X2IbF38h0Z/vRE6OYYc7A6vgGJOuhaX2ReG8EPdFxrojUwOzUdZc2FMAPTEp+S3Flao6O/Jj6zvO3hTwT1JhWYV3PW/Dy2SaYSuNdnOz30W1o+L0mDOL1kGzI8Oc8WqgLa8mLPmYLCvzPbtIl7CjXUgWqS1MhwJ+EVqS4P16odKenQKfvfPfFWYvGVMVgRvdhEC6OQFRzGZP0mBWxVREa0vsraaScs3Npr6kfX1L3Dt6K6iCQWJwmYP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj7m1zCdRbG7eomv4XJ0lVIsi+V6BHtnHiFyxRslI9Y=;
 b=SKeJy836LkIfZSPH5Hsemjo2q7h01TTJL0na7ypoeVJcNYxjlJExO8s5a4ZHA9Ic20ORLtOkcL677h0x7gcqVlBUK+sBla1eEs2fuCucPMz1I+DBZfy/0hwExii/HQqQPUlYCJfgMwL8gQNXVw5NKXFNqBsC5wUJnAzLiIIYGGrBgZwtVgMDYW4AoPeP626AOzFsryABvf8whmX53TSAphfQxwnYARipUAtnxFiY97cBfXa/AXBKGxL6bcR9h/quhBY5P+boxeV4A2i18C7trM8Ybe6Li0diRAAOQV0FTlSWUgOQyEXdFkXgv637uAoUynwQy+8IUO2+L0h8OI6feA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj7m1zCdRbG7eomv4XJ0lVIsi+V6BHtnHiFyxRslI9Y=;
 b=CCCqDFUn5hCdlU6YWyDoH6TUrg2ZUktWd80K+eXAWUCeTvX2rOLelSLMexk7z8cGOiLS8Wa23Np74qFzTwGaLvTuUYjC60+YJY2J5cmSIviMF6SgRaSD37yvY1lFWgBBQ9L4Yjqp7CikcnZECSsGfIgnkG+coZcWGYJRo4+w82VtlI1AGKb02SRl8UNcT9ly9zueLV4OpK2CcM1L1C2ZjwLD1+qWyBFxyOvfF3FRp1MubRhIUdJCByc+MaSGT0g5iuVx1fdI7Qe0TnfYtr3cG+g+oEEPUPjusztF1/HXKPhHSGf9RelFT6nC9ffHBFONXruVQunb+ulW2hr6Z8mWng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 08:25:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 08:25:05 +0000
Message-ID: <57a62282-856b-4cc6-8c5b-783298a3d112@siemens.com>
Date: Mon, 15 Jan 2024 09:25:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] wic: add part-type to
 squashfs/verity partitions
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240112100046.817093-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240112100046.817093-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e72ce22-39a3-460d-809f-08dc15a37a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zvx3lmhwgb/qBUATyBxTUHABU4h8/qI2og2B1cIotj0sOookihPIycqS8uf+SmGR3qTn7nSCR5G6cOxsnzqXX3aLriOP1tpxPUMe7lh3mSGWgM03mcnM3PH1g/2+ru+cxAVYBOPMPPM6mDOVUQ/K/ksowQAykkXx1lWT6YcoRoaolb/DkcPra1tTjQWakdydbg2+iaC/EKF1zR66AcpAjSHVUoz3gTPyYrhsqr0InzmMMnQrbyeu+4WOVnst/2SyQB3dHnY21C43j4gwivDKObm5dq9+VIHFJpBGDcWXB5TxqB5jNIAss/JWSc7ZClLlKAqRiyv8vS0ExZGOh3siiFzZ/5hHstwdmrVSivoRhhTKn92ZrX0kEYs1d7Id9pfUGiGAgbwR7cGd91o4vBoKyY7OZa/Mhnfj1gn7KqDIOIAFY+j4HAeIeKoeD56C2Vdl5hrqdO0EixHhVKtOG42L0P6yidsj90tbBtEkVoq1ac+JPTn+XyAAousWdlf8I/Wp2xN6Ld5q6W90LV2pwjRkK3P0YC+HmCFx/Vo2kE4a9ZANPFfaBZjVGSZPeJuszVAgG6YvsokXy/INmcJ80HXIvn8Udof3sBB3xz9VkjXAMTfpD5nVOHN2n0Npf0HlP13VPY9a+D+CUjTSeX4XVM69gfsASJQOgEUgTFJHECIaao4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(83380400001)(86362001)(31696002)(31686004)(82960400001)(2616005)(36756003)(26005)(6486002)(966005)(53546011)(6512007)(6506007)(316002)(44832011)(8936002)(8676002)(66946007)(66476007)(66556008)(2906002)(5660300002)(41300700001)(478600001)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjhsYWtwemtzd3ZQenNneTN5RzZDNFFsTmowbUI0ODh4aStxR0ZkUmQ0Yy9F?=
 =?utf-8?B?Wkx2TkxaQ0t5dzVNVGV6MWpMOE51RzZMSjBCZ0ZDMmQ1WFFwU0Q5TS83b1FX?=
 =?utf-8?B?SE5icyt4WnpmOFVUSHpqZ212WXBhV3UyZVR0YWhEWE1TMWxUWWVJNDlDSzVI?=
 =?utf-8?B?SjdkR3dOalFubUVyS2JnZFcwSnovb0toU0E1TUxydzJMNlc1eGxMbDh6WklB?=
 =?utf-8?B?TVNzdmQxN2hnRit1YStoRThKRXdkck01dmJ5RmV0MDd6NEJ3eE1xR2tnOWcv?=
 =?utf-8?B?aG1TOWhNaEU0REVuVVdqa3dKMzlVTit5RnZkSUhkcC9GT2pJajMrQUJmL3J6?=
 =?utf-8?B?RURvMTl1V2JudS9MMG95NUhuZ0FzbUZLYWxXdk5HTzVsbXlIOWMzUmpJSXVt?=
 =?utf-8?B?aGpldDU4MjRtK1Z6cVN6UmJZUnduM09mZlhKNENqRml2dXVnaWVtcVB6bGR0?=
 =?utf-8?B?YmNMbEk4Wm9JL3huaFlQMytRQkEwNDc4TjNIN3Mwck9RU3RRVC9kMDBybEZu?=
 =?utf-8?B?K212a3d1UkhjN0xvalB0b3pSdUJwSDdyT1FmUWRpdWkwTUdkdGR6ZjhOWW9a?=
 =?utf-8?B?cm9NdGYrUGpEVGdCUWlYeFFvbGsyZHQ5dHgrOVVENXBSbUx3emIrS0VaSHND?=
 =?utf-8?B?YndHYkVWc0R0a0duRDBkNW9zOVlVMjdkbk8wS1NocEo1Ym5EWDhiWnNDcWdx?=
 =?utf-8?B?d2Y3dzlhb1RvNTY2aFNrVElzcWNJR25EZUl4Y2JSWDhXVDhIZ01hdHQrYmNI?=
 =?utf-8?B?L2U2dXVZUGlmN0N6bFJBSGprbVh1VnVEUDFKZ3JPQXZ4cjNVazQ2UmVuNzF6?=
 =?utf-8?B?ZzZDbXJqZ0h6MFliM2VJcThMSVlYN1R4UDk3ZjlzQkNoTDYwbmVaQ3c5TlhU?=
 =?utf-8?B?RHhPdUcyL2dzMDZnWmtndi9CMngrLzNsQ244b1JWVGpveGpHRUdFUGJTQURK?=
 =?utf-8?B?ZXVZWlE0OEVTUDI0cVBpREp0TW14dXlZLzZRUTVMYjhWSzVmWXZDOWZFYUZM?=
 =?utf-8?B?bnNoU1RmSGR0MnZQL0N6eTZQTXh1OHY5QXhCeTUyWUptRXRram8xQjExUUxy?=
 =?utf-8?B?clRSdzRkZDlJeEhPMHNySmNPdzkvZnVmMGEzWWw4YzAyd3AwRGVDZE5wM3JB?=
 =?utf-8?B?WlY3a2htUVZaZloydDBTcHJRR1ZxSG9TOUtqeTRuaEZtOWk3M3dWNERRWDRu?=
 =?utf-8?B?ZWJCK1p3UktnV09sNzgvRGJ3VkR4c3FEYVFzNDJXUEkwV3RXVWk3alcrVmha?=
 =?utf-8?B?Y1hTZFd2WTZPcnRWUjlzV3V2bWpOaE9pQ3dXUWlWa2RpdjZyZlIrTGZVN290?=
 =?utf-8?B?YTVtL3N0aDlOSHp5N1VBQ2tXQ3RBbWU1OUk0ZzNtTEV4L2hFSmZMNmJ3UFdG?=
 =?utf-8?B?SVBEdTd5czR1SDRKSm9HbHA1ZkJpQWNHazZObVFWbk1meUFJS0xDUDRGbmRu?=
 =?utf-8?B?aG9YbGNZNDFvQlA0Zy96OEpIUHhKZ0Q2VEQ3bDZ5NmlXQzRONE9TOHJzaC9T?=
 =?utf-8?B?a25UQ1ltcmJHd0JyTzJtK20waU1TV0RtWldOdVRmenhnOHV2blFUZ1g4elI4?=
 =?utf-8?B?RWxyWlpNa05BbTVzTUwvcnpoQ2dBK2hqZlpVaTBVRlVaWTdGTnJDZmEvYUg5?=
 =?utf-8?B?VW10Q1hwS3BKOUJZTjRUaFNFVG9mN21kbDZkQUp1U24wblhPendQLzVSQWhl?=
 =?utf-8?B?YjhaVzZtYXYzVDA1dktQdFREbjhlZE5RK09zaE9VSVY4SnRhSmVaTjlUWmtl?=
 =?utf-8?B?NytNUnNOY3FzWWR1Y3c0WFo2M1RSSUVZWmdGMHFweExKVVIyb21idHFUcjF1?=
 =?utf-8?B?bU4vcDFYaEFwOTZlRUNETHExdmt1NWFTZXllU0FvcENFNTY3c2tGQlhiQnJW?=
 =?utf-8?B?blByQmtuMWVEcXppYzA3dHRuMU1UYTZmQk9SUVM4MU9lTnY4K0F4djJramhU?=
 =?utf-8?B?Y0JlSXRQQzNRcktJcEdUeTM2dUZPM096Y3VYV0dLV2J0V1F4QUZDQzhkWkdz?=
 =?utf-8?B?bGhmR0t6Wjh5NjliWk94MnNTZHYrRmF2UWxuWEhUeDA3Q2hqZllWV216M09N?=
 =?utf-8?B?aGRqeFJML1pLRWVzeW13UTFzYSt5UWpYd3M0bnpqbjBiUGlPRW1xNSszY0xJ?=
 =?utf-8?B?YWZSKzRUeGZkTVEzUHMzVFpnT0daRzV4eWh5NHZyMkY1Wk0zRksxSE9ZZWtP?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e72ce22-39a3-460d-809f-08dc15a37a25
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 08:25:05.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GykPwu2c8ag2zVWWIicWJMFrK/hh9l9ljr8d5bBNYoxPSY2PyEDmR2cexwakb4goYBGrOLoHhJqQK5X0ZfsKKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6386
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 08:25:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14382

On 12.01.24 11:00, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> the fat driver detects the squashfs/verity partition as FAT partitions
> due to the default GUID used by wic. To avoid the following errors set
> the partition GUID to 0FC63DAF-8483-4772-8E79-3D69D8477DE4(Linux
> filesystem data[1]) for all squash/verity partitions:
> 
> ```
> $ bg_printenv
> invalid media value (0x00)
> bogus number of resevered sectors
> ```
> The same error also occurs during a update with SWUpdate.
> 
> [1]: https://en.wikipedia.org/wiki/GUID_Partition_Table#Partition_type_GUIDs
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
> index a8f5dbd..48789c7 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -11,8 +11,8 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
> index 3d17332..2ac8850 100644
> --- a/wic/hihope-rzg2m-efibootguard.wks.in
> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
>  
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index e7412be..2e5cb39 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 2453a75..2fc389c 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index de9ced0..1f50ba3 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
> index 9a65cbe..9158aa4 100644
> --- a/wic/qemu-riscv64-efibootguard.wks.in
> +++ b/wic/qemu-riscv64-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index 3c31a3e..98e8da5 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


