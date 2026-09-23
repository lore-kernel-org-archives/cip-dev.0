Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADB0C982EA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 09:37:00 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3235.1790156211397100432
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 02:36:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=m/DlbR2J;
 spf=pass (domain: siemens.com, ip: 52.101.69.4, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWxR0wpNia5P7l46TCLroyO6AAYZ91NneeMBQjQnhQBQiKcjum2D6rU+JhUsuPVCorrnhUZqABKXYNb9FojuKKdY8B8tU+ltOhcMHtjM8FOIisRNg0od7GcpBnF8kcfqKkNIBR7TViejfbByaS7slvE0Ipv2/HvWSeQxw7i4ERRFeNm2G5lJYmGJ/QVdf7I4yuKhDoAOY9dxevErVtKgsf6DPnqWVIVRCjtYw6pnM4/BOl3xTye1jphbb4cWC5hAa9wEiyXfpYGx06QHDMQKZrAYrHn9kzDSTvBmnFUd3QLd0yjeYy8WBKOjNgQejhZD+7SWQBlzhPfL5B9Nu3paMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSy2EptZLOjI7PlmqByiZ0rLJ0zX9U96QarLdAI1y3E=;
 b=K4NTwqOnTgMu23uTgZ3e7zjM7D/C+jvIICIitNlp3Gwd+cPFfuVBljj8zNb9HUolQvM1IsUhuWrrfXLPdGqYBpd0WjTozBGU/YAHy3LlOOAvmNohcKn/MUg2Jdusux9U2AT2aewI0ue9gfzbkwhFfFJPn5JZNJX4p3r+uOGpcCw623pFMuRVZ12Mqa6ZgS4//IaijhetPsM1OHhFcVfcPCyHlI7uWqz90TleUwLqR8eF5yCBjF8IzAV3Y9bL3aFE2JPbiOeJMaIWbNJvsFZh/u0fny0V+JBz2eAsew4nGeIl22Ep91YDiPakGCo/s5UVSgGV319rsdGKSs9AH9jN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSy2EptZLOjI7PlmqByiZ0rLJ0zX9U96QarLdAI1y3E=;
 b=m/DlbR2J6jta8MG6ZCYcXxhdbeyCteChNEjfQnQ2kvrak/9tkbf9wIoDCn4D6gYDLaOnO+LSSxnve0MdZbZNhfb69fHfDHT6qndkME38M98nSfy1K2eB5kTgY2gnw+Qnt/icYJQKtyfxhazOeEYbojNTHfk0xm1dEjqcEBF2T/M109NY1eoSzl3saRSttdhO4hC98MWQbifJo57TgqKrUd/XOtGAS4kbOawgtg/f9JJDyZ3H0yo0yRVQVFuz+jRfGOAD1BTpeDX/25+2MUnza83xk8itYqH8HZLrg8u5WVSkeqptCZ0Fhsh97lbOH93/VGRYULCNf4SoniBB/5FHjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by DB8PR10MB3879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 09:36:46 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 09:36:46 +0000
Message-ID: <73fefc27-b2d4-4b63-9c07-7c264a6f423d@siemens.com>
Date: Wed, 23 Sep 2026 11:36:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 3/7] cip-core-initramfs: Automatically
 deploy EFI secure boot certificates on first boot
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
 <fc5abf12e5ad07f9d69f20d83e41cd77bbfa3f38.1787757655.git.jan.kiszka@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <fc5abf12e5ad07f9d69f20d83e41cd77bbfa3f38.1787757655.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0100.eurprd09.prod.outlook.com
 (2603:10a6:803:78::23) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|DB8PR10MB3879:EE_
X-MS-Office365-Filtering-Correlation-Id: dede8b1c-692c-49d2-d72c-08df19562f74
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|6133799003|10067099003|56012099006|11063799006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	YLGkV79ow3yAgPy5bd95LBzJ+sk6H/T0lNWpbkKX1sXgoz15DzILs0PU6S1hYVD6Zaojue4F2NOSIFToleAd9OgpAE5hd54l80bV1UQW64YekJB6PUHIhEHeX/fX+LgyGlbNn/dBDGa46Xawhw0vmwdHYrT1cHPY+FWoJIGXpc6tAbjmgXCzFR5rTHkXWn1Cvvyn+ZkaGuuVav10RCVull6wkrmTYHDYjUBNGeyq2rkmJLtvb2VDp/FxcBN5NBS2yxfp/A6O80fTCZpu3zV+by/JWkV5p9i3XjCLW/s9payuLhi1n2dw9mIDOqfmKfd/SXkF8BSISbA/h1jCZd4vQO32UlhSQsM7+fD0Zw4PmTlJzZnJQb24/XsWX4uFh/oMJK0ZLEIFGAeY+Tpd3E8EnbzsJUP5NzOY6Z1W5YPU41qI6XkFjygZ+63OLjwLqbMANQpyR8SWHc/7Y7pIQc+Ritwt7m5yx/PPPTgPAjKOgTKqui+zBx4I6u+u8LKfBv8VuJ3gjPEqzCIo6kjpfss4ek9/0kBSv7ZCp2ETpcInbsQxGmp/44eAWXwu4tHtXXPRLaOWxBbwOr1DSgqL2m3Z4/W1R2o+U8srdCYbOCV03hY6HL+6t/ntraH++MExDxTGeixuOxqYugnL4GIQQfLtV4MWnAFKDYr11AVlelnOhDM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eHB5WVpld1pnZitFM1hMWC82TlIybWNLMDJlOEY1VHBmcnRPcjZGbXRpODlL?=
 =?utf-8?B?REJmYUtyMHdLcEl6bjlPZmdSYW9ZQWpWN28xd2tpQ3lTWFpES3pRaXM3ckdP?=
 =?utf-8?B?OXVSa25TSkE2VmYwZFdRYWZSMmlxSUtQdFBpSHBySHBVK2FsQ1laMkVEZVhj?=
 =?utf-8?B?ZGJ4cFVYZGlIVTl0RDNPT3d0SFMydjNpcjVCaDdGa0FCVXpWYUVrUWNrR241?=
 =?utf-8?B?RnVNa1dhZXpQbWdNQVhwOFc2WDkvQlgvOFB3OHVPUWJWV0RjNGhIT09mdHJE?=
 =?utf-8?B?M3lvN2paTmVYWndnYXhZK1pXMExmQzlUYUxhT0dDV3dJS04xWmIzbVFpZGha?=
 =?utf-8?B?ekd4cUNsS0p2M1I5ZHBhcTJzR09zdVo2c3R1cktvYyttYWhEMU5Qek5NL0Rx?=
 =?utf-8?B?Vll0SWNEdmg3WGpCK3lXUFU0V1JyekVQK2cyNHZxdXI3VFpFWFRYWHNHdHhH?=
 =?utf-8?B?QU9ya0V3NkVSZzZxTVFXeFdyNEZUbjlaTXcwUEJUVFdwc1Y0OVdBR2RscjlD?=
 =?utf-8?B?OEZpREtaKzdmOFR4dTI2VzNRZmVic29XUEVIVGtZcThrTDJJenprdjdKZ3o3?=
 =?utf-8?B?NDNMTDdZNzNWZkFGNDgrTnhmVWJpV3Y4QnY1SDlnc1FoZjlrMHRVN3FVeFRO?=
 =?utf-8?B?ekJkdXYrM3RNWTg4SjNLTkc3cW10VEN5TFNFTlliUFE4OTRIcnhheWFOT1du?=
 =?utf-8?B?YVFnWU4rWlFFdEVOQXgrQWpkbENMMGNINVlsNE4rSXJ2Z0FUaS9qeWJlNDBn?=
 =?utf-8?B?VTZzWkFrK3U2cWxMZEl2SUhaMStocXI2cmg0Q25LMGJLUVhSOGphVHN0UlVG?=
 =?utf-8?B?ZTdpSFFFc0doejlWUDcvQkRLTFZEcnZEemU0aElqSmFyMC9ReDZ0R2dYeUtt?=
 =?utf-8?B?cVJKOTlUVTZEbGVsNHcxelUxT0xEUW96bDJTY2k4WjVBNDRDNVFBcWFQRWJw?=
 =?utf-8?B?Nlh4RHMvMkRlTXpXRUgxMlJJa2MxQVQ5bFdsejNIZFlCOVJDd1FpdGZOeGF3?=
 =?utf-8?B?MnZzVCtqWjU1Zy9iV2hxckF0TjZsbVdhaWVzVXIveGNJSG9vR2h0Wno5cXRn?=
 =?utf-8?B?RWRqVEQ0SFhZSjZONXhZbUNiK0xrajJ5Rk8zOFVwVnR3QVVST1d5K29RdTkw?=
 =?utf-8?B?RFBkbU1JSTFxbGFyM2swUngvVDlRNytHbHd2V0dhQkF0NGZIK1ZMU3RWNkY5?=
 =?utf-8?B?eUZmOGc4NE8wNklGREFBVHpNdVlreXlyaFNIbms0K3piTHdFMmwzeWNjQlgv?=
 =?utf-8?B?YkdQaHd3d1FQSVNETld3bzg2dWF1ZGVzWlRYaWpCNTYySFpXY1R3anhlVGE3?=
 =?utf-8?B?VHJGWlpDbTgwRHZ6OUVIZDZZTnlDeEdKTDl2MHZWTThCNXZjYWd0eTVpQ2Rw?=
 =?utf-8?B?ekFhVDFZYXFXNnJTMklKaU83aWJjcHMySGhwcmVDeTJ0WnJZSk1iaHR4NjV0?=
 =?utf-8?B?QmFyb0FJV0R1Q2ZleVhGWklOd2FhNitSRStDZmdIQ3VvbzVDZFZHQk0xU1Rm?=
 =?utf-8?B?KzEzaWxLZGlFSFdFRzhybTY0algxaDkwQjY3OTBpamI5RENlcWo5R0s3V3Ju?=
 =?utf-8?B?bFgxcGU3VGF6ZUJTYkErdGpXMzVwclRzc1RiV09ZUERRU1VNVnVIT1NxL2Yz?=
 =?utf-8?B?N0VEUGczVTlXdy9Sci9DSE9VdDhCQXM1bVVTRkxKa283K1NCOVRLWWlvNmRy?=
 =?utf-8?B?L0Vic1V1WUQxTXlwNEttNnJxUHIyQmcvRUs4bEdEeVY5U0ZoTytISzgyWEdx?=
 =?utf-8?B?N2JVc3lDRlJJSWgzcldkdnNQUWpwNlhMMkorQXJYZTJIQnp5cE5za2o5ckFU?=
 =?utf-8?B?T2RjNHB4VFY0VjZEdlNmc3JGc0ZIWllOMFBCeXBQamQvOWJvMm1GdkVjd3Q1?=
 =?utf-8?B?NWlVODZsM1hsME5uWEd4cE9tUzhFL0Q5TEJ2M3B5b2JmQnhtUGphWm93SFp4?=
 =?utf-8?B?WFp2T3oxQ2Y3TDlHdzlGOTJkMUVId21ESnlrcytsNzJUeTNHOThmbTRGS0pv?=
 =?utf-8?B?QVh6dWVJVkxCaWVQZkJJVyt3Qm1tL0YxMmhWNm9kdUFpWjBWUzlhTGViQ2ho?=
 =?utf-8?B?ZWN4TmRiR1c2a3Q2NjV4TXYrcWlWYzhieFZQeFJaSVczMmY0Qy9jTUJRTlhO?=
 =?utf-8?B?eUluSzE2SnJyTHdsRHBRamZsSCt3SXpMYXo0N3d3OFZENm90UEhpMXduU08w?=
 =?utf-8?B?akNQRkVlK1FPSlk3TUQ4ZVZ6b3RWNDVteEljY00wZTc1VFN4aEVObUxlRjNv?=
 =?utf-8?B?eEtnd2JWdldrY3JkNGhkUlV6OHBOOFZMVHlYWmF4aXNDRjM2dVd1K1hTdko5?=
 =?utf-8?B?cjhuZ2FkYmROeXNlWFZjVHlYOElRYk94alRwOWlSbTQxOFRGbTlLczJ4SFQr?=
 =?utf-8?Q?lCKZc6co0D+8pAhA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dede8b1c-692c-49d2-d72c-08df19562f74
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:36:46.5236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jdr1jJ+0YNw9JipEFCIgxxc5/RLnmKCKZoFwh/bp5UhMrQr8QGi4yyFiEzvedZxekFNUkBI9WnrF7ikyYUm46a+CsHx49smV3GFXeXEuXuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3879
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 09:37:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24272



Am 26.08.2026 um 17:20 schrieb Jan Kiszka:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This both simplifies the initial deployment of secure boot to a device
> as well as makes sure that we will always seal the disk encryption key
> against the right state.
> 
> We only deploy if secure boot is off and the db is found empty. So this
> hook is not intended to be used for key exchange or db extensions. The
> former will be once handled via SWUpdate packages, the latter might be
> considered given a concrete use case.
> 
> Note that due to the primitive implementation of efivarfs detection in
> efitools, we need to deploy a horrible hack to make it work against the
> mount implementation of busybox in the initramfs. A patch to improve
> that issue is pending upstream.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Although already applied to master, but for sake of completeness:

Tested-by: Alexander Heinisch <alexander.heinisch@siemens.com> on 
SIMATIC IPC227g

> ---
>   .../cip-core-initramfs/cip-core-initramfs.bb  |  1 +
>   .../initramfs-sbcerts-hook/files/hook         | 16 +++++++++
>   .../initramfs-sbcerts-hook/files/local-top    | 34 +++++++++++++++++++
>   .../initramfs-sbcerts-hook/files/mount-stub   | 13 +++++++
>   .../initramfs-sbcerts-hook_0.1.bb             | 32 +++++++++++++++++
>   5 files changed, 96 insertions(+)
>   create mode 100644 recipes-initramfs/initramfs-sbcerts-hook/files/hook
>   create mode 100644 recipes-initramfs/initramfs-sbcerts-hook/files/local-top
>   create mode 100755 recipes-initramfs/initramfs-sbcerts-hook/files/mount-stub
>   create mode 100644 recipes-initramfs/initramfs-sbcerts-hook/initramfs-sbcerts-hook_0.1.bb
> 
> diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> index b686185c..7e77a205 100644
> --- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> @@ -22,6 +22,7 @@ INITRAMFS_INSTALL:append:factory-reset = " initramfs-factory-reset-hook"
>   INITRAMFS_INSTALL:append:ftpm-stmm = " initramfs-tee-ftpm-hook"
>   INITRAMFS_INSTALL:append:swupdate = " initramfs-abrootfs-hook"
>   INITRAMFS_INSTALL:append:swupdate = " initramfs-${RO_ROOTFS_TYPE}-hook"
> +INITRAMFS_INSTALL:append:secureboot = " initramfs-sbcerts-hook"
>   INITRAMFS_INSTALL:append:secureboot = " initramfs-verity-hook"
>   # abrootfs cannot be installed together with verity
>   INITRAMFS_INSTALL:remove:secureboot = "initramfs-abrootfs-hook"
> diff --git a/recipes-initramfs/initramfs-sbcerts-hook/files/hook b/recipes-initramfs/initramfs-sbcerts-hook/files/hook
> new file mode 100644
> index 00000000..df645134
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-sbcerts-hook/files/hook
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
> +copy_file binary /usr/share/secure-boot-efi-certs/db.auth
> +copy_file binary /usr/share/secure-boot-efi-certs/KEK.auth
> +copy_file binary /usr/share/secure-boot-efi-certs/PK.auth
> +
> +copy_file binary /usr/share/initramfs-sbcerts-hook/mount
> diff --git a/recipes-initramfs/initramfs-sbcerts-hook/files/local-top b/recipes-initramfs/initramfs-sbcerts-hook/files/local-top
> new file mode 100644
> index 00000000..e3b7a0fc
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-sbcerts-hook/files/local-top
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
> +export PATH="/usr/share/initramfs-sbcerts-hook:$PATH"
> +
> +if ! efi-readvar -v db | grep -q "has no entries"; then
> +	export PATH="$ORIG_PATH"
> +	log_warning_msg "Not securely booting, but certificates already deployed"
> +	exit 0
> +fi
> +
> +log_begin_msg "Deploying EFI secure boot certificates"
> +efi-updatevar -f /usr/share/secure-boot-efi-certs/db.auth db
> +efi-updatevar -f /usr/share/secure-boot-efi-certs/KEK.auth KEK
> +efi-updatevar -f /usr/share/secure-boot-efi-certs/PK.auth PK
> +log_end_msg
> +
> +log_success_msg "Rebooting after certificate deployment..."
> +reboot
> diff --git a/recipes-initramfs/initramfs-sbcerts-hook/files/mount-stub b/recipes-initramfs/initramfs-sbcerts-hook/files/mount-stub
> new file mode 100755
> index 00000000..408b584e
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-sbcerts-hook/files/mount-stub
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
> diff --git a/recipes-initramfs/initramfs-sbcerts-hook/initramfs-sbcerts-hook_0.1.bb b/recipes-initramfs/initramfs-sbcerts-hook/initramfs-sbcerts-hook_0.1.bb
> new file mode 100644
> index 00000000..d7a3abcf
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-sbcerts-hook/initramfs-sbcerts-hook_0.1.bb
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
> +DESCRIPTION = "Initramfs hook to deploy UEFI secure boot certificates during early boot"
> +
> +DEPENDS = "secure-boot-efi-certs initramfs-cip-functions"
> +DEBIAN_DEPENDS .= ", secure-boot-efi-certs, efitools, initramfs-cip-functions"
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


