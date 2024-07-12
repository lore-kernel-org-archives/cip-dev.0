Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4374DC2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 09:30:41 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.42])
 by mx.groups.io with SMTP id smtpd.web11.3940.1720776633850954268
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 02:30:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z7VOfVOi;
 spf=pass (domain: siemens.com, ip: 40.107.247.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQMetZT6QFo/ZhqHRbHZvQU2+6T6Ibe2mu+4B3/lgqK+P5ery21AIptxRF0gAtJd0w0N0PN+I1qYSlVPSoReXyOgEAysPwKqCampv87Xr74ZvJDrdEa7+hlJ7GboCPIXB/IUz+GqUb2fO3ZOlf7xQtmoYS2TTLL9TVmCuif0x7nLDRAxZia0DsyVc7hs5M00uyzsHmlNXAtipU8naXTdFtapksGBW47CkBVVL7AvcqLzLLlkVct9Z9nmBfZDkeC8OvJdNqa8F1OylbJQJbbpNVz1Ae5RzkBzPjM4lp26kV2zYSKUzs0+m1g5z7I2F6EamsWuuURy7ab9iBm31zksBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJDnvj4x6B0uLSwufSY4SaUqOsRtdUDS09NVuSti3sc=;
 b=opG/+sUBy6xUj3kj3gv36Sx/V5aE4OCqGl4+KbRAfYhYwNoBEdyQkHr96HuSFLvjRV3GAUJ3yoe0r2jl66wEGZFwSpTwQX8sopjZyBwqNFGgwVWrxrpBNmpmNnwMP0BPSVk/EjRrj/UbganxLaOHUu+H3ab9czWbhVedViCMbfFdDj3vxmNNYbL5kxzaPlTfGiNPsH5E22NnGu+SblnpXvAlyAmDKhWZ7ywj5P71IJEWPdwqgmLFPvuqSdkzww+EH5YQqu4JjXRn9QL1nNjwxM/88fFGt2akB63rK6I77yt60t11s0o4l7Ws9KMZnw/c76Sh0lKqoXPWwMwn8ll/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJDnvj4x6B0uLSwufSY4SaUqOsRtdUDS09NVuSti3sc=;
 b=z7VOfVOiG6zAr/ecMBgIlWVzyAJVFKfIGclwyV2UL2DASHOV0mv1JZ6GyNjUGqXKjfAgMDgNDe4gP6jb/wrG+c8PaBZkQnsWYunD6DSo8+Lhazrl1h+BTuNQjsq2UZV4bT2egQ6VvA3k2reNTSD/pSEWsROz+3Uv0QRu0xhx2MKs7fy1WBVa0oUxsE4wn4idzlD5vQ6BYUZVXJ2iuv28p9i7zx9PSq1n3X+opcL0srzgRLFzaSuN5TiRziR55uT7Nt7pkEu6TQxecFvCXHr5expdFVgkVzBnAfcHo6eRtoJBrA95yqBL29IEthMWwnVLK0lLOnZrsB/ZPYNFVSykiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GVXPR10MB8744.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 09:30:30 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:30:30 +0000
Message-ID: <9e19021b-d2d6-4319-aab4-e9153bead57e@siemens.com>
Date: Fri, 12 Jul 2024 11:30:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] initramfs-crypt-hook: Add missing mountpoint
 executable
To: Stefan Koch <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, christian.storm@siemens.com,
 michael.adler@siemens.com, simon.sudler@siemens.com
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
 <20240712081143.1376952-5-stefan-koch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240712081143.1376952-5-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GVXPR10MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f3a8b0-a7fa-4341-1690-08dca25545af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZXMwMVU4WTkvemJab3lkbkk0Qm9vT2xoektCOTNmTk5pWjBHdVlhRVkvOEk4?=
 =?utf-8?B?dDkrd1ZuUmNiY0hXLy9hTUw3U3NUQkFXc1J0U3hRdjc2WG9pTHdLOHpHRFdm?=
 =?utf-8?B?S1BxeWVnQWFsRVpJdERCODE3NzhoWFFsY3c3a01lVXNRbkxpaURwTk84bVNZ?=
 =?utf-8?B?SC81TjIxeEdyOWIvM3M3S0NlS2FnakVRRWlYbFhXWlVrd0RzMTRPRnFoY3Av?=
 =?utf-8?B?S0E4TncvTy9kenJMbFpzTWFkeTU0c3JVZWRmTm8xY2tGbndYSTh4eVlLMFlW?=
 =?utf-8?B?akplUWJ1dVV1Yjc3UUVFeGRJYWxkeDJMUnVLQnJtVVVYamhjeHhJN05VK2JI?=
 =?utf-8?B?Ymh2cllKeFhyVy9FSnppMnNMYVpJMzBFc29PcHdSeU1USXNyUmp0Qk9acmk2?=
 =?utf-8?B?QzlVK3VudUtzMjZiNlU2NTJPYVRWd3FlSW4yUnVja0tYNFpjclduS3E0Mnhl?=
 =?utf-8?B?SmRycHBZbXRzdHdVcjAxQjdtc0VLeTVMMHdBQlFzY25LMzFSTEJWMkNzeUU0?=
 =?utf-8?B?bDVPUnVhVlB5VEFxS0lYb25nRVJydFdLNS9HaGxySENHeTZzM0xRNitZQlA0?=
 =?utf-8?B?bzZHaWtKeGZJZ09KSG1hR3ZDZzNoeTZzRVFnYjEvcjlWUVYxdUY4RlgvSEFR?=
 =?utf-8?B?NUg2eVZ3cExXZmV2dCsxc05ubUZ1cGI5UElVZVlwTFVYSENZNXdjUlNjZXIw?=
 =?utf-8?B?aGRSaWg2K3J5RkRQMk95TDYzSEZKeCt1c0xNaHhaWnkrUzRSbzlPRGFMOWVV?=
 =?utf-8?B?REJLRkRnSjRsRkJDUXJDVzg3QzRNN0NHVlg4MW1lOXpHdUdycHkzejBCeStQ?=
 =?utf-8?B?RTd6RnZwQThJR2FkdVZoRFFPMktIeHlnR3ZkRC9uMVZwY3V6ZktVMm83SVhK?=
 =?utf-8?B?NUxYRVR6Z1lFUGRsYUgwSlpmSXdSbWMySmkwTXFpNU1RMVI2UkJVWElDeE0v?=
 =?utf-8?B?dkFPWElJTk5BNW43cWJ1QUE3LzM3Qm1oMFVmSjRiOXRITEVwaWxqVHVOc3JL?=
 =?utf-8?B?SkU0ejhSVUVPd0xoR2RRWDF2NVJIcmlhN3BwNDRGZzBKUXRha0J2dkI1ME9X?=
 =?utf-8?B?SCtheFAwR2E0eU5LNEU2M1M0WmZpdTk0TDlQUUNYZnRlbS9MZnlrRHZGUkJk?=
 =?utf-8?B?REJQZU5jOS9wNitUQW85OGlOZEpWRkx0ZG4zUDd0RHYvd251RGJOMzhoQmM0?=
 =?utf-8?B?SWZTTXU5QnBPUW94ci9SR3hGZmpvcXVneWpuNnl4dkpMMCsyZ0FGb1lsSDJm?=
 =?utf-8?B?WWM3azFHUnJteDFUWU9LUVhhdlh5WnJ1WFZ4MnZDUFR3eUoxNVVQZm4xZ0pT?=
 =?utf-8?B?TTducnV4eVZWRHFqYnp3TEg1YzRFdGF3aVprdmE0NDlISHZkcXFYTDZJSEF4?=
 =?utf-8?B?TjBDNDJCTmsxSUNKb3NiL3lqbXlZK2h2UW5IK0NtNjB2MjN2bG9EVDdyREp3?=
 =?utf-8?B?RXJ4NDVaa29Pd2FLck9JNHlsVjVnVFFuRlhNUElqSjVibU1CUmVudy85clNi?=
 =?utf-8?B?U0QvZmZ5dHN4eHZmZzJucis3ZktVZ1RsNHVoQlgreHJ0RldDdjFDaDhjZklS?=
 =?utf-8?B?TkVHNGJuakxNSWxsZjRVa1hqc2V5ODBMRmZlSkIydDhHUlBxRmtsSnIxK3Rw?=
 =?utf-8?B?Vldwa3A0UDJNQ0ZnMVpFN21IWElBa21oVUNpVWlOclJkK25SZ25ITEZkS1pT?=
 =?utf-8?B?eUpwcVdXQkpPSkM1d3RGOWkwZUYyRGlKdWd5MGtXaHJlMHRXMGNaYkdWT2dY?=
 =?utf-8?B?RjRMWHl5eWp6Z0hWUnFETWFOeTVsOFdXaDBlcHQ1UkZ1M0Q5a0FnUjNXbTU5?=
 =?utf-8?B?dmVtT0lkYmJab3FVeklZZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YWp2d29OeU1VK1A2YW01ZHNKUFdQaWJEQ083QWFyS1JTTzJiSE1BNFlaN3JY?=
 =?utf-8?B?UE5YY1J5K1plOHp6dlZtZml1TW9CTlVMbmVKaHIwZXVDSjR1MTZ4anVoQW9l?=
 =?utf-8?B?Mnk4a1BHaW5QblVIY1Bab0M0d3ZHZlpTbzdvYnk2ZTByTXQzbVl0Zk9NVW93?=
 =?utf-8?B?Smk0NlBiMGp4cGR0aTd3OVE1aVRjVEF1bjZFa2FDOW80Yng2d3JJTXZrRUg3?=
 =?utf-8?B?RjF2UzlzNHdEQ2k5Lys1NVNVdzdoSVpTdTM5aTRxcTRjanB2VTFJVyt1SWxa?=
 =?utf-8?B?WG13WU5GZVB2VFByUWdFbmtnT2VCTXRKbXBvd1liWWtGeldKRDhpMjdpbVRM?=
 =?utf-8?B?VzdXUFcyUzhGZ0g0QytYYTFuR2U2NGpqNDFMMi9TQ3pvV3p6OVJ2ZkMwRDl4?=
 =?utf-8?B?MGhOY2hRYVBVc05xZy9FTmp6WTBFeG9HcXZJeC9iRloweUMxbElqS1FzT0hD?=
 =?utf-8?B?S0xwYmVSaXVxU0QxbkdmWjl5cDl6QWNtV0lmVDEyaGxLWlY3ZHEvakJaQ2JB?=
 =?utf-8?B?RDlJZGErMVJ4b0NweDBkNHNRc3JCR1B4bTVEelBWVEU4NlliT2txdnJuNkRO?=
 =?utf-8?B?ODFTakpqUnFwOE1XYUN2YVkwMVRzaVN1Tm9RV2IyM2pTL0d3d0RIZk5ObHc1?=
 =?utf-8?B?M1RzVzBUMnB0NS9vTHVLRGZOdS90SU81SW5yL3VsQTJqd2lYWDhjdm9RR0Ru?=
 =?utf-8?B?QnlPeE4zRXBPMTJBVHBYZ0pEdXJMT2ZZb2J5dFFsOW5YYTdUV3ZlNmFCMEtV?=
 =?utf-8?B?NWZZS0NleDBtL2E1VGw3NVplYkIvWURkemc5clpXYlFSZEtiQ2ttcEJwbFJz?=
 =?utf-8?B?RHExWEhQWUk3NlhndGxSeFQ2S2tZcW1LZWtBRDFBeGdPNjhOK1hJRElDV3Zw?=
 =?utf-8?B?ZnJmRkNHYzJTOE9kOXhaMTZDbzFwYlZQUkFFdUNjbHVoekIyVkwzWEc4cWZI?=
 =?utf-8?B?YTlCUGt1akRwTEhOeGpQcWJzOGFSRHNkOWx5bXY0alBDNTVHWTg2YitZeUhM?=
 =?utf-8?B?TkdoYmtBL2FKUW5RSVgxMUFYQ3hweDNZQk84L1UwV0tDU2VRZVNoQ3ZlSk5E?=
 =?utf-8?B?NXZYWmtYeEZoS1Y4TStOMmtFdUNVTTBKMThiUU1mREcrQm1tS21UZ0F4RlE2?=
 =?utf-8?B?UllBdkVvWjVjam5vT0tRNVduWTdRWTgyTmFraHVvWWVZUHowWWtpNmVpc2NU?=
 =?utf-8?B?WWpqMUxnUkVMNEVXM1lMcUl0QU94VThkYUF0bml1Q2VRSVlNWW1OSkVTM2c3?=
 =?utf-8?B?eHFoYUtsSWZRWnhWamdyYnB0YnorYThxUXYrNWdaZ0JtNW50L0EzdlU5NWhm?=
 =?utf-8?B?am1FOHBBTTdnQWdTY29MWXRFVzVYODBvR2dJTVA0Z1dYZWJhMlZlelFTZE9w?=
 =?utf-8?B?dGVrb1JHYnVMLzdoTEdCaGpQNEpIajJMdXhVL2ROeVNOY0JJckl4b01oMVRs?=
 =?utf-8?B?bG10bExwWTF1NnRwZkl2ODVqNzVRMXBPM0IrOUdhb0xaOFIzaWFPQnU4K21p?=
 =?utf-8?B?UGh1VW9EcnNnbml2NDZhWGZUY05UazhqdUdnL1JzYWpPdFhxR1p1MXQ5bkxj?=
 =?utf-8?B?VzdBa013cFJUajV6L0FsakxHSDA2bkVJRHRDaTRCSmo1L3lZdVpZeGpZc2Uw?=
 =?utf-8?B?eEFUSVpJY2RvSE5DcTd0bkFVYloxQ2NtRFJ2UnB3Q0hxRlFLc1pWb2xscGZ5?=
 =?utf-8?B?N0JPSHZpdnBuRFZ5dlVhV0dJNjV5bitva2VZTm56UFNjRmZSeTErRGNRUmtK?=
 =?utf-8?B?Y2Z4SXlhMXExTUY3TFduVXJ5RFUxNS9CUEtkZTV6dFgrV0Q3YTUzOUpsU2d1?=
 =?utf-8?B?TWo0UEliQWYxTVFUd3Q1WkV6MUR2RlMwcTNJeCtPOVE1dWxXWmRPeHFKNmo3?=
 =?utf-8?B?bWVaeitzODMrSWJoNU5ITk5mMVFjN1ZRTlZNclc2WlBFU1VSN2UwRkd6ZG1j?=
 =?utf-8?B?d0hiMjBXTWV1UUhjSnMrekY4VU0zL2s4SnBqaHdrNit4L0licFAzQngvbmZT?=
 =?utf-8?B?b2JjdndxMG9nVGt4bGVKK0ZzcTlyNDJqUFhMYmtrSEF3WGNib2FMZmlweG5l?=
 =?utf-8?B?dFkxNVBKWGNRenBQN2ltTm5nalBKWTJLYUNWbkNlVEZJUEE1VWZkaXkwMk9F?=
 =?utf-8?B?VFVuNWRWSWdGWHdjL2FiVTJES0N6YzBOK2VNcXh1Z3hjV0FqWS9pb2lyVEZT?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f3a8b0-a7fa-4341-1690-08dca25545af
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:30:30.6606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eYn469tmFciW+8eYlMX2SP+akksx82IM3exihNnLYY6eQuMyd0EXXDLnADAuQi9XaO4HH0KSjv2bIdr8a+Edw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 09:30:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16465

This does not explain what the impact of the missing executable was so
far - or why it was not missed? And if it is a real fix, it should come
first.

Jan

On 12.07.24 10:11, Stefan Koch wrote:
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.clevis.hook    | 1 +
>  .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook   | 1 +
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb            | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> index 4e62ef7..275461d 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> @@ -45,6 +45,7 @@ copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
>  copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
>  copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
>  copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
>  copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>  copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
>  copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index 2ace533..4aa3e91 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -45,6 +45,7 @@ copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
>  copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
>  copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
>  copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
>  copy_exec /usr/bin/seq || hook_error "/usr/bin/seq not found"
>  copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
>  copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> index 76ce72c..1364248 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> @@ -12,7 +12,7 @@ inherit dpkg-raw
>  DEBIAN_DEPENDS = "initramfs-tools, mount, cryptsetup, \
>      awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
>      libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
> -    e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
> +    e2fsprogs, tpm2-tools, coreutils, util-linux, uuid-runtime"
>  
>  CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
>  

-- 
Siemens AG, Technology
Linux Expert Center


