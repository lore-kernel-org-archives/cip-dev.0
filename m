Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A25EC61DBD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 08:18:08 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7684.1787732277682361274
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 01:17:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yZI5cfdb;
 spf=pass (domain: siemens.com, ip: 40.107.162.41, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qwx+KfZgPnP9JcV5PWTIwV5VXp2rEeK/uSceAPUWXJ8D4Y0TSIY6weYhPh+CxewdFlKoXEc2ostHjzV2R0kNDlobzOjGnQz4IJ8GKQdjkML8L+l4iV53my65+iiIkqWcSmEE7A2aYKGwafyfPamx1f4dEIVy9GyTNJ9CL9CiZBrG7EMHFzpB7DAApBf1bJbBexEYskI8hKtpLpXGutqG4P3Ra9X8NLeOZwX6w/JNW7WketYa5yPpIae2dxUlqCFGD0NG63qgmr85NuRjplsRvcfqB3R7umCTbNy4El2dHrFHFCePpR6d8nCuGarBaI179XhbffBj0nGMcADe9ttd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B4DlQ42zAEhG9/LUs8PE4Z28M7lJlBoJ7oia/32em8=;
 b=Dd+YRJPg9l7dCAowfqwETA0FLChgTkRVi/MwIAWSWqQXPEdj2hj0xCiNDpn49NuYYnqPnvBs259bGacr094mjtQxWB4bo4nUPa+LbKZAnh82dn8VurV6HHLCUQWvd4raX2RgP5xTXzoxzxY70foAQbVA2ZGV5JJVW5/9bQ7Zmt6I3wgB8wn9iWT/ZYBI8LNlBvyAxnfCWwV3j1yhHAW87vQ+4dl/c6LeeKvsFxBJ8TVwAe7sbG/16sDdtuWCbNI1vas7Rh1FC4VgwSrhhQa18O9Zp9kVZ79eoAmI42Z7o/ZFD4lqsf0z+Brw73wZECYdWMG5PhDicp/iN94PH07z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B4DlQ42zAEhG9/LUs8PE4Z28M7lJlBoJ7oia/32em8=;
 b=yZI5cfdbuz2+kWm6C7ZCRG8CwvAEKHmdPoi/0nF4rO/wLLdBvZK5awm713PMIPtDDyStH5u+7nUN1hp5gh5J4aimXXE6HxgvuKN6oHP/3YAKG8Sg1U6uv0iOvmXry87Tl6cAS4LZhNU5MN55zu7q/yLB3dZpbNbJHHRf0n1n+Ee0YJOQWsDCqwarE6gAn8wQVwe6xTDIwBS5nbTelCbA0Eg9KqAU/ksG7HK6B1yqB/AmyyleAHA4yJ42xUYA8QE8t05DvwVpZ2V1fzwde3JKxAYq9HrRoy99aWtkDqW5AxwUHdgqrgaqyUd20tiXPrEX2ikZnJlJAVxZKgs8MbOSCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by VI1PR10MB3694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 08:17:52 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 08:17:52 +0000
Message-ID: <6ac309bf-4031-4140-a91f-201364052d94@siemens.com>
Date: Wed, 26 Aug 2026 10:17:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/7] cip-core-initramfs: Automatically
 deploy secure boot keys on first boot
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
 <abb609c5b84dcb501c10737f47fe3a903dc09630.1787722904.git.jan.kiszka@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <abb609c5b84dcb501c10737f47fe3a903dc09630.1787722904.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::15) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|VI1PR10MB3694:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ce3ce8-38d2-4ae8-c7cb-08df034a8624
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|55112099003|11063799006|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	8RFQagKwLeass09KwRjKotO/0xpXzOShs+grReovFTCukvIsfl7HPOxVR55pWHcYNGqMsVE99xkr51VxYWh5fvAvJHGzaim3QMbJGapQ+UzKmNemzxIITkXws0VT4GwQhx9lFu8zG/RCbXTSVApmiKgHlRJJUNqIqxPjzASEjRWOYRZq2ghQhAcoR/PfSG9vMBo/x1OYEx7H8BjNTMNVmeNusX62m6kg9TURmQRsXgGuJ5thzy0ot/R6LWoqaWWwVWZ9/zSisAbIhtBQnUtI4qcLX1zRxhRTJhMRU1atnJDedz80IGRvlcUHLAZX3v3RCt1G/BAnsdcwQ96ynkYBh/tRbKq1rfuH6pJcgOc7/+yKFUT8TkSfu/fI4mbE4ahD/QNHuEFEPXiJriUbr9y3H2XmJ8N+lSXuR+D8jFhYXY9XEfFvKpiklDlpQmtvEblqaXXUfYeiLkkMpVTnSWg625OeYAwN9AzW6UQkPlmyNMeseOcvDHN79VK4FCxQkk/qWYo633j1vX8WyKULncnrcyCxCSJPJcm+T30X4o1KlzbE5rqoa0UQYGu9F6h/iB5/TUpIlTemQEna6fPRcnjQdXe0zGOxSHcNrAr0jB3Q/stLvIa0WObCbKv8wpUO4X7ABpb2ryRMyvvd5bttJaskyfjFVSC0bDSWGqVwLWXiLL4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bVJVRm54bFRZSzRneFdNTWdnTTEwc01pVFRXaGhSN1ZGRytpREE1dUlWUGhU?=
 =?utf-8?B?SVc4aFNDU29sSmV5djdLbjFoY0dkaWdHSS9UNzFQTTdjY1M5NUlrZEJrQTAx?=
 =?utf-8?B?QlU4Z1JVN1lraUNtQWxjK3hWVm5KTzAxRkdhMGhOYjR0STRnS0pNMmlnU2dK?=
 =?utf-8?B?VHE0QWR1OUVyYTV0cUxzWGVHb21RS21UU3I5dGRnUzZtWTA4aU1QLzB2L1Fl?=
 =?utf-8?B?WVVJbWdvalAwdzkyWnl3UTA2RjlWelZtZHgwdktFeFI2YWhYUkk5QTY0dGxT?=
 =?utf-8?B?S2lhL1hISURGRGE5ZXdjMjBBbmVqVHN3UlZHZ2Zxb3FzcGE3RWZOcmNzeHZj?=
 =?utf-8?B?OXpNMWJUb2l3Q3lkaGRsSytwTTAzY21kMUFhU28wSFZ4ZmtmbkdyQllsZzlm?=
 =?utf-8?B?RGZaZzNMWnZWandQS0FFVnRSL016UkZTODZGRGN3TWlJNTNjVTlLQVMwcDBl?=
 =?utf-8?B?RzJXalVCWERQVFA1SHRqWE05eExUcHNwa3BRcHAzNjFkdk5CRUluT01ISk0x?=
 =?utf-8?B?bVVQdzZOT1dkNlZ4dUpTd2dFajBhUkpSUk50L2w2TTdUZUM2VUJ1R3pVbFA0?=
 =?utf-8?B?b3gydFlZakttQTk5MTM4R1BEV0NaYnFTczJuRkhiYkRwU1NqYk1wZ2gzUFNm?=
 =?utf-8?B?aUtHZHlYSXhqWXF3LzRRZENJay9OK0gyVnNFeXlsNy9FZG1jelY4ZDVLQXBX?=
 =?utf-8?B?ZUxnTDlYY1hIaTNoQWNjTzhLektmS3hwaTYwVTEzNElad2loTWpuZDd5dXg0?=
 =?utf-8?B?K0lnZ1gwaklSMnNGSzZHZUxSY2lPSFk0c2o5amR4TXdBZFdzZGtWMGF1b3d2?=
 =?utf-8?B?SE5jeEQ1VWhMYTZmQk5ocDF6Q3RVeThyK2JIWjF0SVRJZFZrQmZ4Vnhaa0gx?=
 =?utf-8?B?aUJrN0Ivdzhwa0FhV0xrNnZReDVLVGtDOU5xY09ERnUxQjR5ODJEcW5QSzZv?=
 =?utf-8?B?V1pzQXVDNTh4VlpQMHVnWUdUSVo2VlNuTGtxdU1lYmgwK2dQR3NoTmF0WTZp?=
 =?utf-8?B?d041cUk2QldBT0lWNmh3dmNtTWx3cUhPRkFOdkdNZ0QyZ21vNVFPWWZOc0F6?=
 =?utf-8?B?YXZOaWJqT2xzSVUrLzRVR3FqMElONmY5SklxSTVqd0RIN0N2MVpPSmFDOEFw?=
 =?utf-8?B?Wjk5YVp4U3VJeDkxZFZ3NFNmU2lQOGQ4NDhaMmtFeUpRZXM4S01VWU8wT09t?=
 =?utf-8?B?Qk9sZG1zNncxZ0oxcFZoaTRkSFBBc2gydm9mbkpWN1pkRk1XeEZOR2VCVFUy?=
 =?utf-8?B?MTU2cldVS1BxY2tzN0FXYlNkSlU3K29qS25PVkRSd2d1YmJKTE9QUFl3anBY?=
 =?utf-8?B?SGhqK2psMnE3clFsY0Y4Snl4c0g0a0UvUWNGeXk2c2dRZE5MYXRVWUcvT3R3?=
 =?utf-8?B?MXQxYWJvVzNhckZWcCtNK21KSk95NW9LckpCc2ZPc2pyTGZvekdKT2RXZC9h?=
 =?utf-8?B?MlJzZ3dQNGpPcVlQWkJDaDJ3Q29XWVhyZnNFTCtNbG5oUTBQUC9HbWt6LzRL?=
 =?utf-8?B?VzVJdHpZUkRVd0hjcTV1RitJL0xkRFQ5U1I4U3VNNytSOVRlb3F4TEg1UE1q?=
 =?utf-8?B?TGxwWDh5Sm9JZWowT0dJZHFhbnlKajFwM0RhNFlvckhEeVA3ZTk3YUVFUXF0?=
 =?utf-8?B?SmpnZnRGOVFqZmpSbFVobVk4SytwelNaenpTZzkvYXMzUUYxZ3NScUlMZDVE?=
 =?utf-8?B?Yi9idmR2YVFKNEJlQjBiUnZwbWpoRlBpRElpSVlMRWs3TFFlQnd2MjdySHlB?=
 =?utf-8?B?R2ZEeFJQeVJvOUo3WVZrR1l1YXN6d29zL2sxTWhpUzZXbE5KeDBKVWlPODFi?=
 =?utf-8?B?NEF3KzM1VkttelZ3THFBRlhnOXFZZjluTkZ4Z3dJaitGcytURjA5ajkrSzNo?=
 =?utf-8?B?WUREMXp4VnEzWTM5N0JyOXRJT3VlUDgwek5WM3ZmanhFM3d3T0xCR1RrUkpS?=
 =?utf-8?B?S0tJVkF5R0FVSlNjVWRDTVdrRmliekRDWG5SVDFOZ1VOOW5icXlOaTBRQWE0?=
 =?utf-8?B?aG9xV3J3RUl5cGJicjhOMDlWeml5dFhUT1dIbTZEUVpxUUJmV3ZvMDArTFpv?=
 =?utf-8?B?QnoxZE8reUFvZ1lRaDlNNXBlTUVvUG0xOTVyN3BIZEZoS3J5eHRIZU5uSWFo?=
 =?utf-8?B?TkFuTjNqZWk5L09kL2NHdE40d3hwMHM0aGI3M0RBTFUxUmJKV0t2bk1OcFRB?=
 =?utf-8?B?aWJlU1JxaC8vMExZMUkxYU1JUjZkaDJHQmg4MjJvWGR6T3BsL21lNXhCK0Yy?=
 =?utf-8?B?VEFVNDBlSVZDUUxObitpeTRReVk0b0s3NEx4WEEyOXZwaDhzZjFwc2ZBMzYx?=
 =?utf-8?B?K0hLUlAwcGJsQ0lXMGd0dUNTb2hFQVJzOFhOdnlFNC93SXV2SVZqNEVmYXVT?=
 =?utf-8?Q?H4zRcpbsE6cdRZYI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ce3ce8-38d2-4ae8-c7cb-08df034a8624
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:17:52.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WYZXjuSEKNDmPvVNQ591MKA+ccmSDSXzZU/DysZ5qoGgKUdNJvwcGSlHVMToOMuH/wyvCcTnEFDJWSqTu9jHDOqJ03A610dazU3cW23bO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3694
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 08:18:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24016



Am 26.08.2026 um 07:41 schrieb Jan Kiszka:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This both simplifies the initial deployment of secure boot to a device
> as well as makes sure that we will always seal the disk encryption key
> against the right state.
> 
> We only deploy if secure boot is off and the db is found empty. So this
> hook is not intended to be used for key exchange or key db extensions.
> The former will be once handled via SWUpdate packages, the latter might
> be considered given a concrete use case.
> 
> Note that due to the primitive implementation of efivarfs detection in
> efitools, we need to deploy a horrible hack to make it work against the
> mount implementation of busybox in the initramfs. A patch to improve
> that issue is pending upstream.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   .../cip-core-initramfs/cip-core-initramfs.bb  |  1 +
>   .../initramfs-sbkeys-hook/files/hook          | 16 +++++++++
>   .../initramfs-sbkeys-hook/files/local-top     | 34 +++++++++++++++++++
>   .../initramfs-sbkeys-hook/files/mount-stub    | 13 +++++++
>   .../initramfs-sbkeys-hook_0.1.bb              | 32 +++++++++++++++++
>   5 files changed, 96 insertions(+)
>   create mode 100644 recipes-initramfs/initramfs-sbkeys-hook/files/hook
>   create mode 100644 recipes-initramfs/initramfs-sbkeys-hook/files/local-top
>   create mode 100755 recipes-initramfs/initramfs-sbkeys-hook/files/mount-stub
>   create mode 100644 recipes-initramfs/initramfs-sbkeys-hook/initramfs-sbkeys-hook_0.1.bb
> 
> diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> index b686185c..241e6af6 100644
> --- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> @@ -22,6 +22,7 @@ INITRAMFS_INSTALL:append:factory-reset = " initramfs-factory-reset-hook"
>   INITRAMFS_INSTALL:append:ftpm-stmm = " initramfs-tee-ftpm-hook"
>   INITRAMFS_INSTALL:append:swupdate = " initramfs-abrootfs-hook"
>   INITRAMFS_INSTALL:append:swupdate = " initramfs-${RO_ROOTFS_TYPE}-hook"
> +INITRAMFS_INSTALL:append:secureboot = " initramfs-sbkeys-hook"
>   INITRAMFS_INSTALL:append:secureboot = " initramfs-verity-hook"
>   # abrootfs cannot be installed together with verity
>   INITRAMFS_INSTALL:remove:secureboot = "initramfs-abrootfs-hook"
> diff --git a/recipes-initramfs/initramfs-sbkeys-hook/files/hook b/recipes-initramfs/initramfs-sbkeys-hook/files/hook
> new file mode 100644
> index 00000000..770d4454
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-sbkeys-hook/files/hook
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +copy_file binary /usr/share/secure-boot-efi-keys/db.auth
> +copy_file binary /usr/share/secure-boot-efi-keys/KEK.auth
> +copy_file binary /usr/share/secure-boot-efi-keys/PK.auth
> +
> +copy_file binary /usr/share/initramfs-sbkeys-hook/mount
> diff --git a/recipes-initramfs/initramfs-sbkeys-hook/files/local-top b/recipes-initramfs/initramfs-sbkeys-hook/files/local-top
> new file mode 100644
> index 00000000..48fe45d4
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-sbkeys-hook/files/local-top
> @@ -0,0 +1,34 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +. /scripts/cip-initramfs-functions
> +
> +if secure_boot_enabled; then
> +	exit 0
> +fi
> +
> +ORIG_PATH="$PATH"
> +export PATH="/usr/share/initramfs-sbkeys-hook:$PATH"
> +
> +if ! efi-readvar -v db | grep -q "has no entries"; then
> +	export PATH="$ORIG_PATH"
> +	log_warning_msg "Not securely booting, but keys already deployed"
> +	exit 0
> +fi
> +
> +log_begin_msg "Deploying EFI secure boot keys"
> +efi-updatevar -f /usr/share/secure-boot-efi-keys/db.auth db
> +efi-updatevar -f /usr/share/secure-boot-efi-keys/KEK.auth KEK
> +efi-updatevar -f /usr/share/secure-boot-efi-keys/PK.auth PK
> +log_end_msg
> +
> +log_success_msg "Rebooting after key deployment..."
> +reboot
> diff --git a/recipes-initramfs/initramfs-sbkeys-hook/files/mount-stub b/recipes-initramfs/initramfs-sbkeys-hook/files/mount-stub
> new file mode 100755
> index 00000000..408b584e
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-sbkeys-hook/files/mount-stub
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +echo "none on /sys/firmware/efi/efivars type efivarfs"
what about "cat /proc/mounts" to get the actual systems mount points 
instead of mocking expected behaviour?

> diff --git a/recipes-initramfs/initramfs-sbkeys-hook/initramfs-sbkeys-hook_0.1.bb b/recipes-initramfs/initramfs-sbkeys-hook/initramfs-sbkeys-hook_0.1.bb
> new file mode 100644
> index 00000000..bcbaf97b
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-sbkeys-hook/initramfs-sbkeys-hook_0.1.bb
> @@ -0,0 +1,32 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit initramfs-hook
> +
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +DESCRIPTION = "Initramfs hook to deploy UEFI secure boot keys during early boot"
> +
> +DEPENDS = "secure-boot-efi-keys initramfs-cip-functions"
> +DEBIAN_DEPENDS .= ", secure-boot-efi-keys, efitools, initramfs-cip-functions"
> +
> +HOOK_COPY_EXECS = "cmp mountpoint efi-readvar efi-updatevar grep"
> +
> +HOOK_ADD_MODULES = "efivarfs"
> +
> +SRC_URI += " \
> +    file://hook \
> +    file://local-top \
> +    file://mount-stub"
> +
> +do_install[cleandirs] += "${D}/usr/share/${BPN}"
> +do_install:append() {
> +    install "${WORKDIR}/mount-stub" "${D}/usr/share/${BPN}/mount"
> +}


