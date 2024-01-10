Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264E4C4707C
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 16:26:40 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.70])
 by mx.groups.io with SMTP id smtpd.web10.16079.1704903995100212841
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jan 2024 08:26:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BcyXxRI/;
 spf=pass (domain: siemens.com, ip: 40.107.21.70, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6OQguRvklr7D7cO76ofNDIlh9DhyTx5KXCwessABf8rmLT6YzvMZiaHEEpdlaEv2gUNOVuP9iR5THVfWb7NtmDoh4qhcxkznS6IoCPRlHqgqy7Pcnczo9esH0NGpiejBD0YDd5QQv6PDZjd13O6fgfZC/byC2kG+wxB2WeTey8oj5nf8iH17UXDQfN+aH5F2ztJVszlAKqOxE34Tg/LbOmzvTCxwKZ/5z2L0CQsSogPKyLFc7dZnuX6U5+7rSHVXUp1/g4SVLVLBqSypbImHQPDgD3yJfGJazcziWvGW+FQOv86qXDZKvAF0zNk1ddf6+HYhhBsqTz2+tFZMy1wdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYCxnYUR4nsPsV8MPRYnmsQ3fD9Nh45HU3F/I8wI4ZM=;
 b=LnnJdq9FtWuBJGlbGWhr+jjg43RVvRH8Y0rscTQPMpTShaoBfUBun342wVey2T/D/Yop3b+93UOc3RpzHPH+3KcJ4q4G3At9oJqDQ/3ySWonjwtGaj+UyTrhY5kFK5kEL7S5d3yHsMrRg9Q9pHWFDLWU5xYGgjJAsx55uz8Ib/Y4IKaA3G3DYDlG4ZWDC7urF2B/yy/uPPWg7ZkgB5n915m5GUKJqhtF6eJ7KKKUP2agmNkVkdOPUicqYnAIlSA68XPznWPoXQ6q6iz9gWLE0DgMyEGPH3fFYfuhhIV9/4pMyiqo2hJNJzqys9pr8aCr7lE9Qm/cUErE0JV9mZgZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYCxnYUR4nsPsV8MPRYnmsQ3fD9Nh45HU3F/I8wI4ZM=;
 b=BcyXxRI/7ZUEjwGXoyDxOGfzIr2aCRNm47TcYSrSplKLBVh25zm1w9wUzczN1gkJwi+QbWX/zYPc3yUBrN3Dl6abyMKpDlSwfKg0DAqAGeou/2OTytoRQREZikvwr32jifmRnMxeAHA5BSG6ycgDgK6AJxM5d+kYGA40iu2YSXJshPUJSBe2NBu5EkKSLowel0Ut9gWLL1PEKZD0iHFPC96Hub59me5Xt0QEHgSsWu/VXg+2MeaSLMqmAHpftQs1ijyekpTLAy/QHRU23DKf99bDPAmYGlbLO7T0iug8MP5P3ahVmsLX19kfKd5mWTqnm6VqQIU7sxqUNYXpTxvIVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB4PR10MB6991.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 16:26:30 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 16:26:30 +0000
Message-ID: <2d27dee9-fd70-44a6-a8ad-bd31c0f2f735@siemens.com>
Date: Wed, 10 Jan 2024 17:26:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] initramfs-crypt-hook: Add required
 kernel modules for upstream kernel
Content-Language: en-US, de-DE
To: "Cetin, Gokhan (ADV D EU TR C&E)" <gokhan.cetin@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <PRAPR10MB542260589618B60AAA1B6B1E80692@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <PRAPR10MB542260589618B60AAA1B6B1E80692@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0413.namprd03.prod.outlook.com
 (2603:10b6:610:11b::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB4PR10MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bbd9e9d-d65a-4f4f-c909-08dc11f8e6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	csyWL4SBB2nmg9HEBwMJaFD5jtb/Jj0yWpqgdzbRorcgbFbtNjU7WsGBsg9euk0guZnjLtn6mq3KvD4Q1yrlcTcdBPRt2PmFfHXw4hQ8hdV211AUJoKYqV7CvfQ9a93ceAc0meCqMhKFggpx1IP3fDyQ259pgYkHxSMgm9QufbDcyaG2ZsUJz1d1bjmyd8cMoYZ9CJlEXrqkFhqpR6zR36l5dMbhPkNllyfSewLXQtUd78VYTlh3AV2rKJ3Me45yM4GPePwZ8gogVu/ol8ry+ZDbm8OLIoZm2vAbb1MXsZGd1V4uJrh8d88P4djCilr/VqOsx8RKGGIgT1RFbHDyk7Z+10offOWYMI0TqgyzQbdVZdOAGATecpqvhp4aBAbfkI1QSGq9rBYJ8x3MzV7SOwEPX/7Zaq/fB2p7s361B4N9tfbQWeDRsDbrIQfkJEocYFmUMFx16rwy4tF6HvbPoYOcbO+0LEdPlG8jx3kmaHXT4xiFvhpEdzJKeQmVyXaM29MAjQkWk8GFlsryaOQBwUNInTBKSuA3buX+O3ibOvZHma19a+C5N4qGiuavtIRVvbTmSFB8Fozn5YSSp4wMHezmJ+EVDjWDKktF9oKlIzS0a94nMnJA3Wi4iNHvqytffBd2Ugzp67h8VqWfzDkvQg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(83380400001)(66946007)(41300700001)(86362001)(36756003)(82960400001)(31696002)(38100700002)(107886003)(26005)(4326008)(2616005)(6506007)(6512007)(316002)(53546011)(2906002)(6486002)(478600001)(110136005)(66556008)(66476007)(6666004)(8676002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVF0T1JBQnVjQ1hBeXE1d0lZQmg1M2dtOGxvc2tJajJpNU9RSUQ5NVMxbXY4?=
 =?utf-8?B?UnQrK0VWZ1pmaTBHY25UT1FtQ2FENzFTNzViM0NEUXBYYkI0TnI3UW4xM3JG?=
 =?utf-8?B?bmhqVUFWQitWYm1ld1d0M1lMdTkySHJqMkUvbS9CY2k1cDJ4WURIUW54NXJa?=
 =?utf-8?B?WUtMbHQ4NDdYY0ZubzBNczNaSjFwaWw2Z2pLaVFZVjFSNFpzdTdESXVtQWlM?=
 =?utf-8?B?ODI4cWlZVU1ndUhjNER2WVlXVjhuaHEyS0pHQ05PSXMyaUZCMExPaWNpMlJH?=
 =?utf-8?B?NTVFelg2aFg2V2d3RnVRVmg4ZkRtVllkUDNXYTV6ME5FRHUyNDk4amZhaS9W?=
 =?utf-8?B?QkdFakJJUU5aTnBwR0VGcUhGUjVBTkhhMU1KbnVHcmszVjFtWmE1bmVldzBy?=
 =?utf-8?B?UHBnL3pZYW85NG9MWWFaQ1lIV1M3T0NaQ3doZ2R2U2p1dTVNY1VSYmlNWkQ3?=
 =?utf-8?B?RlNPK3FocEFYS0tFRmJnVlhPNUNFYXhWMWtQNmE5VVp3QkJxMGpyaG05S21X?=
 =?utf-8?B?dVZVRDc5WUN0ZjZaUHMvTnQ2WUx6NlIyMVNkZnZ0MXRHc3pFYkVSQ3pUUHYz?=
 =?utf-8?B?VXBsbDBKSVZOZFF0aEoxb3lnR1VIYUNMK3BmQ1FYS3VHODZUVVcxcXNqREww?=
 =?utf-8?B?VXZrVDBMT0NhVGhqeGVTN0gzSHZTMUFRRnhiZnBoUUlBaEl2WldMWjJVc1BE?=
 =?utf-8?B?M3BER0dzc1BCN01vNjByTVZPK214YjEzZGlNVTJtb3o3UXo5RDlqTzZ5OWw3?=
 =?utf-8?B?eU41aWQ5aXIxem82OXJxWEdoWk5wT0ZMK3FrUnM2cTFwbERmNk1HeEI3aTBX?=
 =?utf-8?B?RjdKM0tKbDgrYi8yeFc0UHJMUzR4SWRRYlhpcDFraW4waHBPOUtsenZpMkJ0?=
 =?utf-8?B?UG9CeGtvVG1SaXFzWkNXOEM3MDZpZ3ZUUUVROHJhbVlpWFhueW40WThYay9U?=
 =?utf-8?B?UEs5Unc4N2xPOUZpSjBzMnEyM0pTdC9qS1hwaVZud0xHNlNMaUtwUGxLZTdX?=
 =?utf-8?B?RCszYm1PTjV3QW9vWmtuS3p1ZVROcHdMa09hRWcvTUFsZ0pJa3J0YlJPWjhU?=
 =?utf-8?B?YXJ2TTRBRnM3cHFyOURDUXhWUTRKMWJmNnVVKzkrWDY1V0M4cytzekxjN0Va?=
 =?utf-8?B?U3dTN2JCckp1aThIUkpXS0RpMktVS3RWT25TYUtYd3UxS3I4OXF1WFlMQ3Rn?=
 =?utf-8?B?SWpNQUNJZHN5dTBLQzZBMDEyUm95NlYycVZZejhNdXphVHVQL0JOZTFJSUo5?=
 =?utf-8?B?R3ord2gxNWtRVUtGT2o3dHJLRFlHMTRrbEhVQndGL3JuN0xvd3ZHaTRXalVq?=
 =?utf-8?B?eVZEV0lva2dkcFBBTHV5c3VNMkh6Ri8zLzlDOUlsWVRGeDdhdjAycU1hbXBK?=
 =?utf-8?B?bktzdXlWZklNQlZqN0hPenFhVXVzSlBQNWNON2xzaE5NNDdVQnZoYlJvdnM5?=
 =?utf-8?B?Yk5odkR2ZmhOVXZwRHVHRXMvYVEwYUpFY1I1cHJwRlNOVGpqajU2WkpTeVdr?=
 =?utf-8?B?SmNjTklwWG1yb0hxSmRtS01PNjgrZEM2dXVPdGx5UE5tUWdkb05YYmM5aWdy?=
 =?utf-8?B?NCtpRW4wVFM5dERNNEpsd3FxN1hmckwxcGhxZmtMZ0lXek5lSVRHU2VlRXQr?=
 =?utf-8?B?akdQOUxXVFppaDNKcStvVTZBaDd4cTZjUjVyL2xZNytZTHF1RVJweE5VaGYr?=
 =?utf-8?B?T2lWbVZrMEQzdWhvV0Rjbmd6L1B2VWJzV2NJbC85K0N3ZVdXM0dIR1UzQ3BZ?=
 =?utf-8?B?NjFSdzZVeHY2ZFZHaVBaemtwMjlvR3MzeUwvcDlZZHZQNkJzaTFNNUtNU3J5?=
 =?utf-8?B?enNuSlhLNWU4UUN4R3JPelFuRHphd2xncXZ5RzhrM3c3bG5zWXVCbDRSK09n?=
 =?utf-8?B?SmVBdGE0S3QwcWFWNXA1R3BoekhJUjFCcklWZUgwUUMvN2d0bjZFSk5UY3Bk?=
 =?utf-8?B?V0hQR3dnbmMzZXZtN0k1UVlOV0V6NUlLS2JCRThvR2tHU3I3Zzh5N2VSRTlL?=
 =?utf-8?B?YklVcVdQcW9vb25GWnptTWlUaVlMaHYwcVBldHk0SzltbGoyOStmT0orRWlL?=
 =?utf-8?B?Yy8zTk5VNWd2bHFPYUtHVTRnSGhpaSszU1JXeEx2ZXpiZ0hCZENmOFg1RzNs?=
 =?utf-8?B?bkp5ODhhVmpCY3JhSG9seTh5VmhRMUlCUmtoajdLL3didnhiNlZaTWRvanZk?=
 =?utf-8?Q?euwS8UCmGg5IAKhJRc5i2BQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbd9e9d-d65a-4f4f-c909-08dc11f8e6dc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 16:26:30.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPTXuoiVx/Y2uvNcaepblah55DBcZDrrwUbo6wl/hXm4pMrFoettw0+MYe715WmN4UpbkzpSFGgk1BD5QCsbdkMQWmVSkoYNVkoLICmniUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6991
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jan 2024 16:26:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14325



On 1/10/24 16:13, Cetin, Gokhan (ADV D EU TR C&E) wrote:
> 
> This adds necessary crypt modules and loop device in case they are
> not loaded at early boot as default.
> 
> Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
> ---
>   .../files/encrypt_partition.clevis.hook                    | 5 +++--
>   .../files/encrypt_partition.clevis.script                  | 7 +++++++
>   .../files/encrypt_partition.systemd.hook                   | 7 +++++--
>   .../files/encrypt_partition.systemd.script                 | 7 +++++++
>   4 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> index 37b373c..bcfe885 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> @@ -34,8 +34,9 @@ manual_add_modules tpm_crb
>   manual_add_modules dm_mod
>   manual_add_modules dm_crypt
>   
> -# add crypto modules for debian upstream kernel
> -manual_add_modules aesni-intel

On which Hardware did you test? If i remember correctly asni-intel was 
necessary for the ipc227e.

Reqards
Quirin
> +manual_add_modules ecb
> +manual_add_modules aes_generic
> +manual_add_modules xts
>   
>   copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
>   copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index 6d8f209..0318966 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -36,6 +36,13 @@ esac
>   modprobe tpm_tis
>   modprobe tpm_crb
>   
> +modprobe ecb
> +modprobe aes_generic
> +modprobe xts
> +
> +# this needs to be probed particularly for re-encryption
> +modprobe loop
> +
>   # fixed tpm device or do we need to find it
>   tpm_device=/dev/tpmrm0
>   partition_sets="$PARTITIONS"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index 0a39da6..c3b31d6 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -31,8 +31,11 @@ manual_add_modules tpm_crb
>   manual_add_modules dm_mod
>   manual_add_modules dm_crypt
>   
> -# add crypto modules for debian upstream kernel
> -manual_add_modules aesni-intel
> +# add required crypto modules in case
> +# the kernel does not have them as default
> +manual_add_modules ecb
> +manual_add_modules aes_generic
> +manual_add_modules xts
>   
>   copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
>   copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index 2ac8d30..eeeb55a 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -36,6 +36,13 @@ esac
>   modprobe tpm_tis
>   modprobe tpm_crb
>   
> +modprobe ecb
> +modprobe aes_generic
> +modprobe xts
> +
> +# this needs to be probed particularly for re-encryption
> +modprobe loop
> +
>   # fixed tpm device or do we need to find it
>   tpm_device=/dev/tpmrm0
>   partition_sets="$PARTITIONS"

