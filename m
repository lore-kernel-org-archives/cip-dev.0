Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D1AD5CCAF
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 13:32:44 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.78])
 by mx.groups.io with SMTP id smtpd.web11.14837.1730295155530508389
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 06:32:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BciE1aiK;
 spf=pass (domain: siemens.com, ip: 40.107.21.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9/VK3UjE9oAHR8ZMdYil6OicMtrtcz7yBftKznGSejsD/8cQV1fI802DL2mAZjgWVibPuEfWCQ1vuUms12D6baI4iBFL2GUWto9+DSgcSelVSitdkfl+WnMHtnLch/U3l7OtCfl5DkHmL84Kpya8isZJkuIWShCvBHlh+RW3dQQHvHMiNg7a2ZsEyZ2rDj/vUuzF0y8RW2bkieAsn8ZPEIIYoLAGt77XD22JKbnUUXiSesyVGHZA5z8oHsc1P9jov4aUh/DB06WmfqfFsDWb/5JIklNDaadpoHGA6yFeGfBp4QH8gtD7MERDfrxIuti/IRtmuptoum+fM+aTgTCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q/12nkKk6pxCPFJKIWtxIl+CjdwuWf44Zc5FDRcdxk=;
 b=I2Glk/PyTVl1RVzbnGs9PqPDUnYulpD2nWmXxrXJV+mG8uIjj+8zl8+0KtecwPX0Y5DH0w/uJmP5+DQAKLIF5QDZMqO47ZeobLOk4rfGilRrwQAuF9Od1VQbINvltfsggcRw+OySrMtHFO5aGHhkYNq+Vhi44aiva3XPVoeJHBBuyKpG4ODoANY4PnbTwbOPBGuaKiotll7WDJI9/PGE7hDj9NNVdvL1XAfDdimTiqyIeRwXcCUzb8JA9Sd9y4yi7ocW6ULmcDrP4DolBju+ksJYcS8kQ3q9QHCvyRJEcLoi8e+lcbJFqWz8HdrPDfWCMoje5ezmIkmupUPTkavKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q/12nkKk6pxCPFJKIWtxIl+CjdwuWf44Zc5FDRcdxk=;
 b=BciE1aiKP/xzgranPKRtWISTPOWJ71lC1pptV0ZThsNr/ujZeABeFXmG0OQYQIdQy8i6nvCf3sOLlzvEvb6dTp2dg+ly50pDtSA40lVdrXWOlLPAFVVszdEMxVFKYktsgVd/tO+eG4NlZ5MXONn+zME5Ll77Fi5IgVY0wk7Chv6rbYU8OiHF2MLrLNOdeilyHR9/OTk49nxF7CqIVJtJBgHFB127snmnbZwVO3Nu2MGEEQCTBJoeDbi+LGfB8uy34yb1Mqy+V+BKmol5UP/w7xqeiRjhSo8DieVfssoZLzByLXOucTvOZEO/R/y0sDft6ps70wo1fNdtjlyUkDDvUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8977.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 13:32:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 13:32:32 +0000
Message-ID: <cd17b322-28c8-46c7-9876-22cd3f32033d@siemens.com>
Date: Wed, 30 Oct 2024 14:32:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] qemu-arm/arm64/riscv64: Switch to
 cip_merged_defconfig
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <fa83e565-8950-4ca7-837b-1c513a119bfa@siemens.com>
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <fa83e565-8950-4ca7-837b-1c513a119bfa@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: aa10e461-b673-4048-ec1d-08dcf8e74ecf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NFlCOUFRRkdJRlMxNEJQTXFxVlZNWUhMR1N1NUIxdGZydHNyKzU1MlRweENJ?=
 =?utf-8?B?T214YS9IUHI5cGZ4NzM0THBTWVJmTUxlOHFvWnhUczE5ZG1HTVlDWUthdXl3?=
 =?utf-8?B?RDVXU0FYUlJEQUhUYWRTT1lrZE45dzEzZjFIVWF0eURvN1BzYTQrNTF6RzBW?=
 =?utf-8?B?OGJJS3oybDUzMGxQOHdnTGc3WE5LZnJpV3I3d2thS3JVWWdZRFRsUjlhajA5?=
 =?utf-8?B?NGZwWlBaajY4OWo2Skw0clVGMDlCNlgvd1Z4ZndFd3Z2QkpBUmd1bDRyVzQ1?=
 =?utf-8?B?b0swOGF5TnJqaGRJVFFaSHo5WUJVeHA5dlZKYld1eEFBdTVLRHY5dFI2WU1v?=
 =?utf-8?B?c01MZS9hT2VSeHZweHcyTkdkaGk0bmdGamVpQVNnUThJSE1JWjhBTksrUjJX?=
 =?utf-8?B?T3RLNzBXTTI5Z2ZQWEZ1c29qYjN1VkFBbXBjTVdOUzFNaVl1aVp4ek90TE1M?=
 =?utf-8?B?ZGFTaHhyd0xXU3I3ZVJvNVVmcHRDNEZhRFMxUFFqNGRHc24zQ0dYV1dwRml3?=
 =?utf-8?B?MURmWU5xZG1oT1YrS0kxam5STHRpRXFjcVE4Y2czMHZFMWFXeUZQOW1qaXBT?=
 =?utf-8?B?eFc5OVVvb01VUGRCQlozVXJ2TXJJdTJkeGZySVpKdmFRV0NINGNOdnRzQzdI?=
 =?utf-8?B?QzRhT3ZuejRQd2RpUzNuWGg0c3E1NU0zQU5rY0NTaXczWGdaZWQyTXI3RWFy?=
 =?utf-8?B?MHVucnNPQnBhdTlYOGMrSythcFkrNnE1aUlEaXRKSmRJajhSeDFKTTQ5akE5?=
 =?utf-8?B?Ulp3OG9BTnZQbTlnSDhzekQ1dkpZM1JTMk85MmRnQWM1SzRidks3UTFpQWFS?=
 =?utf-8?B?NFIwNkdKNUEyTlVkMTIvQXdSRjJuTzVpaU9Wd0lwM2UyQ1h4b04vbDFmNlZL?=
 =?utf-8?B?c3NVOXZWd2dYYXJLbDV6bW9OMGNZYU4xWVFPV2xmNzVYL1M0Wk5zUUNqZ3JW?=
 =?utf-8?B?L0RVcXE3MEJBeDhnMEVsemh0aHJkVzFybmFMRUJBeHFsUWZQMmZDbFErYkth?=
 =?utf-8?B?elZQdWhEZFVGa2xJcUgrcXhQc1JxSktRMk1rcWJoZU9yMnl2ckRpamtHMHAw?=
 =?utf-8?B?Z2lJK1doQ05idk13K3VhYzkxVERwSHVBWDlTQXBld0hDcWtHaTd0QUllbUpD?=
 =?utf-8?B?dm82Z3VNNHI1dXZ2U29yMGdlVVRpNFAyMDkyMjljVlBMSnpJR1N2SFBrMlgz?=
 =?utf-8?B?QlVWcm9SdVBQL1diTk9uQkRlb2kvN2NJUjd4WFREMUNWZVZhem42QUxyRkVx?=
 =?utf-8?B?a0ErNWtVNlVxYW1KZ0VtWCtzZ0xFalYydmFrK3d4MzJsWnUxekpzaHlxcnFw?=
 =?utf-8?B?SHFoc1RTRDBHVnVFZ3B0Q0EwRnRSYTJkTngwN0o3eUxKcjJYeGtTWUxKS1JN?=
 =?utf-8?B?SkpzWlRoWDlHZm5UZm9qRGlQZHU5RkNGOU8rZDZCNkFZaVVKZE9qNDF3V3U4?=
 =?utf-8?B?Q0VwTHdwcExDMFg0d28xY2NzdDdFVEY3akxZdjRqbTNvWUo5RVpvUGNzQnVa?=
 =?utf-8?B?NHlQbU1HNjhNTXhHS0w4SGxITW5BSEZmS3Y2L1dvV2k0dm1DbVorUlhHVzVM?=
 =?utf-8?B?aFg2WmFjZnA4bUVQL1pkMDI5RllEN2V5cXZPUUVTVnl5U1V0V2JnM3pyKzBi?=
 =?utf-8?B?aTJzdEhMWnFRMkJMSzBOWGc0ajNIeHRhRU1EV1Y5M3FOZ1pRZXF4RDM3bi9s?=
 =?utf-8?B?Qjl2NURTNTlESTRSYkVqRzN0YldpTVFLODZUU2JoaTJiOGs3cVhDQ2ZteE8w?=
 =?utf-8?Q?htE0N0CrhQoOceG7+B4L6yzSZhrbNPHPvzMMJb3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NEpzRGdTRmJ0VGdYNG1XdHBtQnBsWWZFQngzVGVEU2JadFh4cU82NUp1cUhI?=
 =?utf-8?B?TUpWZEFIV0UzekF0aWxtdTJqM21GL1dDeTBBL3dPdFE3YXlWNmZETDB1OVRN?=
 =?utf-8?B?MzV2Mys5Rk45NlNnQjJic1FZNVBwT2pDYU1FSjNJcDVBd3Uzd2toNU5acHd0?=
 =?utf-8?B?TFlpTG8ySWVUNkhoWlo0M0JTSEZrZ3NMcWxhNS9PWVk5aXY4QU5WbzdMUmty?=
 =?utf-8?B?UFFRUkMzWGkwbmZjaHR3akhWdXVCN053bk9HNEJ2Qk5CRHpUYmhnRmFlUFAv?=
 =?utf-8?B?MnZUa0FQeTlrakJDV3hHem5mYlhLcG9lWExFTkhLNmRaOTNLdlVhd0dVYnJJ?=
 =?utf-8?B?YmZVVnNNSVJlaDQyT200QUJyYUEzUWp3alFSYzZSdEVOMHlocXhrZ0U3Vy83?=
 =?utf-8?B?YVJrM2VUVlgrRVkvMm04bUdrM3l5aWNidmZ5ZFI4SllSNFRNR2UwSFAyVUVv?=
 =?utf-8?B?b2pYallUbnZ5K0xkYi9vM2pLUmJoSE1qSlRZUkw3L3ByM3RoblAyVkcveTBa?=
 =?utf-8?B?N0tRL1IwYjU3dEhtRzVNSUZ6c2RPZkJtMFNPVXEwb0pWS2IyMCswdm1UcmJN?=
 =?utf-8?B?MGVTTkFBbHROajVobFFXUTlkUEZvVkZITUkwbmZ0WE45YmFidXVKYU52ZFZq?=
 =?utf-8?B?bnlPd0p1N2pQSjNtZVhrampmcE1COVQzUXY2UEpEWWViK1ZlRzk2eHFHemsv?=
 =?utf-8?B?cTQ2WEk5SGlKUHladVFacG5VaEcrTTdrNEEzYlZ5aGlyYktMV01FaUVnaHkv?=
 =?utf-8?B?RjNkd1l0RkUzZ21rQlRJZGhyQ2l0OGVGVnNnbFlTdjVmVElVT1gwRHdGYWF1?=
 =?utf-8?B?MHd2QmdoL0wzbUl4MWtsMlRhblFMVVR3emFWTUlYODd0NEJjenBlT0JFbm9t?=
 =?utf-8?B?UEdoNlBlREJNU2tOUzBkMU5SZVhKZGw1T3AzSTFSM0JqV0hpRnBMcDV3TUhs?=
 =?utf-8?B?UGN5ZnhZUnhPVlV6Z2hFMTRNQmpmeHQ3MzFCbjhaakI0NEEzY2tOVGZhZVM0?=
 =?utf-8?B?YS9EemlLOGFHYWNBRGo4Y1RPVDgwb0ZuWlN4UDRYUlkxbm5rT2lSZ0dkSFhJ?=
 =?utf-8?B?dUtmdHNWNU8zVEZOZ0hXY3NUbzlvbTk2SytTUFNxbVpTMWdvYVorcGVKQlpp?=
 =?utf-8?B?cXFxZjdwN0hwbTl6TFZWNkx6TDE4dFI0R2k2RXFNNmJSU2FJY3NyUU41VjND?=
 =?utf-8?B?YTNGcW1wVGd5OUZxQ3MyWm5lbTVrM2xhaWNST2ZTeHVXVGxaU2w1TTJ3N1R1?=
 =?utf-8?B?Skhsa1o4YlZzeW9XakdWNTNrb1RLcklhaUtPZ3djWGRzSi9xRm1KNnpqUlpu?=
 =?utf-8?B?L29tRVZVRXE5bHNRS2d2clhTN2VJeXVwVmcyZEhEWkZUTG93Y1hiUHpKUm9x?=
 =?utf-8?B?S3Zpa2F0OHdmWXA5SHdqV0ZCRGRXVzhkWmxxeHZzWVg4aUhtajB2dGhYZkNL?=
 =?utf-8?B?RkgwU2VSWjVEbzBQZEhtclVBcm5VMmZDSzUrd0dVVzY3TktibWFYMWFYSzRQ?=
 =?utf-8?B?ZGxkcU9UaCtFZlhYbFQ0VWlxRXRVRmZybTYyeHNNOStkQW1wK2s5MCtLQXhL?=
 =?utf-8?B?NlFrVmRIZTZPN0ZLeU03SkNOUlVFczRrNXRBUzZRZVdGcTljeWt2NVBnOE40?=
 =?utf-8?B?VDZEQWtJTEJWUGN6SlRLdTAxaHZ2UjA0c2xKS1BYdkRxeUpqdTRybDFuV1Nx?=
 =?utf-8?B?VHp6TmQzbVVtOGx6Tkh0SXdubGNGeS9ZRTE0R2tZN0xKWmp1S0hQNnprWnJT?=
 =?utf-8?B?emtQWWE3YXBEOWsvbkFzdGMzbjgxQTlBOHNyYUdZVDd5N1F6MFVLaGRoRHJx?=
 =?utf-8?B?SEwxa3MyYjBzNWtyem5SMEpLenN1REJwUncxUXFNZXExQ3dCMmp6OW4rYUFK?=
 =?utf-8?B?TnF0ZTMzQTlXaHB3SU9WYld1ZDBzbDRMSkhVTmtVa3hKSmNtVGp3NnhyOVh5?=
 =?utf-8?B?YUNuTXAzUXVGU3ZSbUZUNGlJS0QwdEZEWmZtanA0aG5UK25vVmdLVEdacW5Y?=
 =?utf-8?B?Y3M0RTlmNXZwWmI3U1Y5YTI5YXZqRFRNZ2tRbWhmalZIb3dKdU80RlBTcjhW?=
 =?utf-8?B?ZUEwOTRDRjErT25kOExtdmZwZzJZODcvVFZRVTAyT3BmTG13aTZPdmV0clhZ?=
 =?utf-8?Q?pkqRNm0hv61lYIg/PO7hyzbB4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa10e461-b673-4048-ec1d-08dcf8e74ecf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 13:32:32.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRzPJYREtLVQ5RXL/3lKyLA3Wy5Gxj9V3iaIVCRnnidyJa50k5xLb2E3a38RGcNa0ahzpicyK6iYuKsYw0Dy2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8977
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 13:32:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17122

On 30.10.24 14:20, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This allows to pick up all common features someone brings into the
> merged config, like we already do for qemu-amd64.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> This is actually a so far missed pre-condition for the EROFS changes in 
> https://lore.kernel.org/cip-dev/cover.1730289107.git.jan.kiszka@siemens.com
> 
>  conf/machine/qemu-arm.conf     | 2 +-

Grrr, too early for this arch at least, we are missing some more
switches in the merged config. Quirin is checking this again.

Jan

>  conf/machine/qemu-arm64.conf   | 2 +-
>  conf/machine/qemu-riscv64.conf | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
> index d2dd81f4..17c08832 100644
> --- a/conf/machine/qemu-arm.conf
> +++ b/conf/machine/qemu-arm.conf
> @@ -11,7 +11,7 @@ DISTRO_ARCH = "armhf"
>  
>  IMAGE_FSTYPES ?= "ext4"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
>  
>  # watchdog is not yet supported in our QEMU executor for this platform, disable it
>  WDOG_TIMEOUT = "0"
> diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
> index 7acf1079..a2c5e53e 100644
> --- a/conf/machine/qemu-arm64.conf
> +++ b/conf/machine/qemu-arm64.conf
> @@ -10,7 +10,7 @@ DISTRO_ARCH = "arm64"
>  
>  IMAGE_FSTYPES ?= "ext4"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"
>  
>  # watchdog is not yet supported in our QEMU executor for this platform, disable it
>  WDOG_TIMEOUT = "0"
> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
> index 02bb60a0..36d6d943 100644
> --- a/conf/machine/qemu-riscv64.conf
> +++ b/conf/machine/qemu-riscv64.conf
> @@ -14,7 +14,7 @@ DISTRO_ARCH = "riscv64"
>  IMAGE_FSTYPES ?= "ext4"
>  USE_CIP_KERNEL_CONFIG = "1"
>  
> -KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/qemu_riscv64_defconfig"
> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/cip_merged_defconfig"
>  
>  # watchdog is not yet supported in our QEMU executor for this platform, disable it
>  WDOG_TIMEOUT = "0"

-- 
Siemens AG, Technology
Linux Expert Center

