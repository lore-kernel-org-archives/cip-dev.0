Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EBFC87FC9
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 13:13:07 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.8])
 by mx.groups.io with SMTP id smtpd.web11.81133.1753708386344198189
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 06:13:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kK3iww2p;
 spf=pass (domain: siemens.com, ip: 52.101.65.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBQuekoQ2cnkvBcApKmI1MffKocN6ykDeT8YqoXbu0l2UUYBjj7RI/vGjVDqg8UfK+abIaey1S2P5e5RPOIY9nywg9n2ocia1BZXvtWj9WYcnyJhhlN6OrszQNSZNAD945UO2stz0vPb07lLoWbsKmmmTWrM609q2VTMPJqRJTiyJAoFpus896+JIcPormqITQIgrw0YwSOjk/R3DAUwr1uX0iCBGbhHZzAb3RUcENmdgt097O8bpplhx+8jUr/EaLOhxg2tyixf3KQUHsAyZuZ4eOhqXZ/hFaLlaoDGDaQbpjgC+2utdtBYrUZZHd1hzFYuHFBhr4rKjmdy0kG0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7hkNWpeAzGVVBrRiZBZeSI6D4EULJGb2ZWBrNyTnfg=;
 b=j9f5lJE+Q+WVhpn+2lqoU3yMjGJDScaqAMsBMZsU8rpSarAxpZvNIaExrGtE+O0N/ej0YFTrMGptWUO3QKwuGIZFv6dgdfJF/nbdHJXIo6LPN5Pa54MZtU1dbVqP1rAFMpkwiX1buE10jNWjxlbEOq5gg03wvOEsx5Z/UxYTgmGV2BZb1SAuKtr3GtlMfUTUIJ9WxUdmfWS95MYLrZW10CmM99uVaS+LKmjijeU/dp6J+RcBvUcDTD4N039aZZeYxHjAAEGUNf+OVoi0eN2pz8/dd7FfGIglPzMdnSaaEeuTEX7PjKV1VQmxzXk7ua6W4SZYTgLUyeFBPiZkHDU9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7hkNWpeAzGVVBrRiZBZeSI6D4EULJGb2ZWBrNyTnfg=;
 b=kK3iww2pSIU/V8QTC6D9qqenUUZKGkykU7p+XL8R9Ik5SuRh6WIaLfKrmVtkPcrpvvzAyvtrr1KxbGD9EOeiS8J/xxu/x8Sna6W8vRkK4Ld5IJb9rN0E1zvvoDQ2WExrCCsiNzqgTDAqmFowL68F6g5GPoFfnrqCG3fuLKRQzI9MU8q0QrZDR50AZ/ZtqRhTnd4JWB5rgOowmyxKM5VHqL2YqUC/VxBJz8AcsQqEYnVx1wCe2SN1fN4vH60dAmLEfYT4jLK+qJqIljqsf9zYQAS7xY95BLtrLy1QF7ypJnmDw00KpgAK44YQtI4Ol5h+gMOJZ4j3hQR1ChDkFIyroQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:13:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 13:13:03 +0000
Message-ID: <2f608ed5-b94e-41fa-90f4-832cf037f0c5@siemens.com>
Date: Mon, 28 Jul 2025 15:13:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] kas/opt: Add option for not install kernel
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1753432849-18257-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1753432849-18257-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0401.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd95f2c-3cea-4031-2ad2-08ddcdd87c08
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Ynk2Qk9SSlNRSGxJSENqdnFDRS9uUkR2VkR3MjdXeDNCb292VHNpSXJTRVFG?=
 =?utf-8?B?ZXdETFQwc0NRSElIU0FMamtmOElVcXlvZHVDREdSK1Y5SEFIR1c4QUk2QVVp?=
 =?utf-8?B?SFlkZWNFTDZER2pYSHNLR212cXorZXhES2hiS2N3Vm96ZDA4b2trTHpudDhi?=
 =?utf-8?B?c0ppM2tiSDJGdHZBek1DeSsyOFMwNVRyNXdJTEgrOVZWOTBYTXAyQlB0bkU5?=
 =?utf-8?B?dkZFaW1tUkllS1JtQmJxaVRpWnRNVkZrOWFzUHp2aWtNeWF0ZFFTTXVwN3NB?=
 =?utf-8?B?VVFqSm9rZ29hMTVrRm1CdDdhRFBOaFRWZkFVblpRcEhtZUlnb05STWtVRVoy?=
 =?utf-8?B?bHlOUHA5cS9DdzM5U21udVEvdWFIWDZ3aUhRd2g3ckFmekRaMUl1amRDcTZ2?=
 =?utf-8?B?ZEFyeTVkT1hDcmwyRGo1Nk5ZbUZPcWl1bENtckpHU3JkS0s4MVcwdXVKQnJT?=
 =?utf-8?B?N0NHVEtxMVI4M3NPUzRHdm5zWGJZMWJpRmJBKzBZbGd0aHFsUEEvUzBlVlU0?=
 =?utf-8?B?UHphU2pGdnBBdHpobkcweDBXc1ZJeVJTczVPcWo4UmJkYmJRbFNoQ1Y0d0dk?=
 =?utf-8?B?c053VTdkRXlTbVlxVUZKK29pUlUxL2VOZ25HK29WVmV5b1RncEpoWnErWWcz?=
 =?utf-8?B?Q1I5a0tMclF0bVhPN1ZTRkJPeVZETnAwNXJRazVzUlpTNFBsNnhzZGVWYWZP?=
 =?utf-8?B?R3hXRnJtNHQ2RTQwNUdVZDU4RmprZjVIbXZYak9STXByRXRMd09YUVBsdW03?=
 =?utf-8?B?SGl4YnlweEFvSEh2RDlPRU53Q3Bpc0VZcWg1dmNvRzMwMFFlZzFyaStqM3d3?=
 =?utf-8?B?OGRwSHNhL3NQUVRSQWV2WE1HSEc5aU5GMkFXbUpnMEo4TSsxWUk2VWcxRnZv?=
 =?utf-8?B?NlgvcWFma0tZVTNwWm1iQnIwQVJkR3QyU2I2UDFhV3ZyMERORTUwV01KZ2Rm?=
 =?utf-8?B?blBSc3hMR3hBMG8wcVdTT25kaDI0cjdqNEF0ZDI5ZVdMOWNhRnl5L1V4aC9O?=
 =?utf-8?B?YjJWaW4rMm51YUZzcXM4aWRkRkQxN1lKdGtQQkdUTWRVWGQ5Qm1CV2xFV0M0?=
 =?utf-8?B?Vnh1NDFOR0tkcFpHR056enZtcmxNL0ZobnBEUlh1bFY1cGJtU2V4cHNBTTdu?=
 =?utf-8?B?cHJMRlpWajB3My8xUFRJNzdDdVhDQ3B3WG1NSHhaZ1B5NzBrcUViUVgzbFdV?=
 =?utf-8?B?aXpONVhEQ2FkUzFzYS9leEZFVFY0R0FDRzlkQnpyK3plWEd3eDY3R2JKLzBz?=
 =?utf-8?B?T1R2ZzA3azFPMTFycWQ4azhIUzRmQll1cXU5R0FseWpkelM5cHFzTVk1Wk9q?=
 =?utf-8?B?V3VWTzRTV3hkOXFudXVZNVhGZXlUdEJwVTR1VEtlTGY1R0djRmtGTW5hWmMr?=
 =?utf-8?B?SzRQblBiZEx6TmdUSjBydFo5QnJCMlNxakJDK2I5c3dYZ01DZVJlcjF2NmRN?=
 =?utf-8?B?VXN6blE2cnlwWXE3bmtwZ2xROFNhdG14OXNFNGl3bFNucEROb0VVQjVYYmtS?=
 =?utf-8?B?RnFwYjEvK1JyMW5MVHFFQUZXV29FUUpHcjRlRDRHb3dRR2ZmNzBGR0JaSFFD?=
 =?utf-8?B?YXEzNVdtMXBkV1RMQ0NrM0FNME9teVVGdzlkcmNjTTU5cWpmNXRyMDlzTG9r?=
 =?utf-8?B?QjlZTXlMQ2pjNHZlS1k0OUpuK3FOMldLNWYrOWxncGNydVZ2c1F0anhEL0dX?=
 =?utf-8?B?S1FPWHhsWGViWTd5b2wvWjFzb2FXR3hzU2gxODViWWk5RTJrc3hyK0Z4V1Nz?=
 =?utf-8?B?NzBDckwwems0b0gwZThRQlMzbWJFanJsL29vMGg0cktvSVE4Sit2eUM2ZDFG?=
 =?utf-8?B?NlhFUjhic1hGYU5wbVRQaXREQkZNTUE1MXJkUlNqT2ZNWTVYT25DT0FBNTIy?=
 =?utf-8?B?czVKTG5TY1k1eGZEL24xZUVhSlo3OHlyVFF5KzFjQUtHU1E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkZZSjhQYWs5SUVUT3ZLaFZEZDI0eUtvdDIvSzRSTHRlZWpSZ3BYaks5a3FG?=
 =?utf-8?B?Ty9uM2UwS0JObHdLWnpSZjNneWhybmxsWVE4VVltSE5VWnhSVE5PNGxtaUtO?=
 =?utf-8?B?azFwVkRjak9DblFPa1RNbUg4ekVUbFd2NGJVSzlNMi85dUhUL2ZCOEE0aVhR?=
 =?utf-8?B?VXZHYUV1bnFoZWthaTJvRk8zS0I0NEIrSUJteE9sY3BLWE1DbnFlNWg5YllL?=
 =?utf-8?B?RGpmR1pGTE1GaTA2SllGRE11RlZ1ZnJBeUJqcUhNckR2cXJPdmZvYlpER25w?=
 =?utf-8?B?WWhxbDJwK2dFL1BkVVVVVFNCbVNOWjNHNHBHeTJyQ2FtS09XUlhJS2RSOSt0?=
 =?utf-8?B?NThBVUNKUG1VMWhqNi9ienZBeHpjZXdIUXVTeEpJWE9sakN5N215TWZVWGZy?=
 =?utf-8?B?cE5OaVBVK1MrTUUwTkF6bzRWaGJrNitRU0pueWVuMUpXTlB3dHdDN214eTQ0?=
 =?utf-8?B?UW16RkkyZmRQTnMxV0xRQnY3b0NsRTVCc1pUaUZCbWY0dFdTbjZ5ak1ibnRp?=
 =?utf-8?B?cVgvMXhNWmJ2Q2hpQ0xiRkthUTRlMXhtdXhUUkIwdk8wRjFKYW1ONm5QL2hq?=
 =?utf-8?B?YzlzMTZudmhpOXVBS1MwNUZIbU03UDdFRjcydTlNWXNHdjBuTU5LTitqdG1O?=
 =?utf-8?B?MjVESDFIelRGc21pL3Z2NThReEdsZmtaUTRmdGZocmYvS0Z1S3ZVbCswVytn?=
 =?utf-8?B?WDVCZWhpNGY4STIyZjd6VVlNZVhrU2lZRkVwdmFXOTFVYzdRTDdXMHB2Qjc0?=
 =?utf-8?B?d3VybFhMT1RodFNHMjU2dkVtaDlJNWIvYnlONmFwTWpYSjdQWlpXRHZlTjVv?=
 =?utf-8?B?b0F3UmtYSGdJdXh4SE40TzdHM09SbU5pODd4VUxVNFhBZm01TkRFNTlad1VT?=
 =?utf-8?B?bmFUVlZ0Yk5uRDhpc3gxMzZqVS9vMnhSQ3k2WE1wZ3BrSElVcDZ1L2lkRCtQ?=
 =?utf-8?B?U0I3SnFGaG9LVjYxd3pQUjVxN3VBY1RNVGVOKy8wYlllVGdRZ05YQVhXVkJh?=
 =?utf-8?B?dmE1Ri9XWGNRZTFDcTk2TmhiaysxVlZkQjMxelFHbWV3QnFNcFc1UU9FMy9q?=
 =?utf-8?B?eGEwVXBPcG5oRTllZElxUlhPMko3MFZzeUY0MVY2dVNvb0dtaUdSNzhWOENu?=
 =?utf-8?B?TGlldHRTYXY1UEJBYVNacEs1RzdJdWdabDVvTTBPNVFaWFJmNkxOUFJWeHpH?=
 =?utf-8?B?ODFPWHdEUGxiYjBQL2pQRlBLWjJwM2E0WDhldkhHbGg2QTdVeWdGcVhWN2Zp?=
 =?utf-8?B?UDVodHFXU2dNNFZQTVNQWVdaQlRjTldIcC9wd00rLys5aWEvN3oxWjlHREJl?=
 =?utf-8?B?WUdJaDd2OE1vYW5mQi9rR3paL1ZZakJCL25Md1cyUGhXNWNtNldoWTNQWEFR?=
 =?utf-8?B?WVVZb1Q2UVB1V1E0cTU4MUtvWFB1cDlvRTRSdUhzNWhjTjBhaHNzYkgrYUt1?=
 =?utf-8?B?NXpLU0IyVDZDeHlpZFBSVVNyOFA5OGJ0WjA1dWhVNjlWNWV0V29Ib1d5eWxr?=
 =?utf-8?B?TWE2a2NMa0dIVzJJUnFJUHN0cjhEeE5RS0tZbzl3ZEh2czdQdlEvR2dQbjVT?=
 =?utf-8?B?b2liY2tCZWxvSUlKUjYycTEzeG5WL0pWaUV2bVVJaE5JenROWTdJWmsweEtX?=
 =?utf-8?B?Znk3K2tkNkFUdXd2ZEZMalVCeG83M1dOVXo4TXlqMWZWdS80eUJvZ25MNVpq?=
 =?utf-8?B?M2ZDWXV1SGVOSExoUmpSWUdUSHdDYVFaem5ndWVDSmVzcDlKVzJ4ZTdkV05X?=
 =?utf-8?B?ZEN3WWVXb2NwTnZxMmk3cVV2MVQ4L1B3bXZJNE80V0d1Z1F4Y08yYmwxYVJG?=
 =?utf-8?B?M1FhWGI5Slg1NTY3ams4NnVKckFPT3A1YU9GY2g0K2RzdUl2aEZGQllJdzJS?=
 =?utf-8?B?STYvQ0tWR0xCQjJWNnlhMXlKemptMlRyNHMwTktSZ0NINmJNWnlhUzViam1T?=
 =?utf-8?B?SzlBeHczWU4xd2x2SzdudGRMdENYSWRWNGlhRk1xN3VXZElSY213MjB2aFBC?=
 =?utf-8?B?K0lOdWpQd21TTHYxN1h2ZzFjcEx2aElSYncrMEhGMUxRbklWMDVWT21Sa28r?=
 =?utf-8?B?ZnNXS0RmV0lvZHNIZnAxbThjWVJZb05Qcm1aKzFNQzkycXBIQUM0cW1Dc05N?=
 =?utf-8?B?NEdLcUxuUzJLbnIrTklwS1UrNXJYVXY4TllHZjMwUWl2cG9YaEJkc1ZtWjRx?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd95f2c-3cea-4031-2ad2-08ddcdd87c08
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:13:03.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0suTQaBB23D8yl6cJj74rOYz2B7lhx7f+wJlcFbDlSS6cABvCnijvgLa6hkAUnhb3FVwwfRQrKQdn3cYBeAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Jul 2025 13:13:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19600

On 25.07.25 10:40, Nobuhiro Iwamatsu wrote:
> This adds an option to create an image that does not contain the kernel.
> This is mainly intended to provide images for kernel testing.
> When testing the kernel, kernel image files that are not used for testing
> are not necessary in rootfs. Providing images with these files removed
> allows you to reduce the size of the rootfs image.
> 
> wo_kernel is false:
>   -rw-r--r-- 1 iwamatsu iwamatsu 351M Jul 25 17:31 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> no_kernel is true:
>   -rw-r--r-- 1 iwamatsu iwamatsu 275M Jul 25 17:09 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> 

Thanks, will look into this after 1.8.

Jan

> ---
> 
> v3:
>   - Update commit message.
> v2:
>   - Use KERNEL_NAME instead of IMAGE_INSTALL:remove
>   - Add build:qemu-riscv64-test-nokerne; pipeline
> 
>  .gitlab-ci.yml             | 36 ++++++++++++++++++++++++++++-
>  kas/opt/no_kernel.yml      | 17 ++++++++++++++
>  scripts/deploy-cip-core.sh | 47 +++++++++++++++++++++++++++-----------
>  3 files changed, 86 insertions(+), 14 deletions(-)
>  create mode 100644 kas/opt/no_kernel.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 7c05ad4..53c9a2e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -28,6 +28,7 @@ variables:
>    swupdate_version: default
>    test_function: swupdate
>    separate_home_partition: disable
> +  no_kernel: disable
>  
>  stages:
>    - build
> @@ -69,9 +70,10 @@ default:
>      - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>      - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>      - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
> +    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
>      - if [ "${build_swu_v2}" = "enable" ]; then
>            mkdir build/previous-image;
>            if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
> @@ -229,6 +231,38 @@ build:qemu-arm-test:
>      target:  qemu-arm
>      extension: test
>  
> +build:qemu-amd64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-amd64
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-arm64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm64
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-arm-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-riscv64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-riscv64
> +    extension: test
> +    no_kernel: enable
> +
>  build:x86-uefi-secure-boot:
>    extends:
>      - .build_base
> diff --git a/kas/opt/no_kernel.yml b/kas/opt/no_kernel.yml
> new file mode 100644
> index 0000000..7bba6a5
> --- /dev/null
> +++ b/kas/opt/no_kernel.yml
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2025
> +#
> +# Authors:
> +#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  kernel-version: |
> +    KERNEL_NAME = ""
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 6e4dfd7..6cb4968 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -13,9 +13,10 @@ fi
>  RELEASE=$1
>  TARGET=$2
>  EXTENSION=$3
> -DTB=$4
> -REF=$5
> -DEPLOY=$6
> +NO_KERNEL=$4
> +DTB=$5
> +REF=$6
> +DEPLOY=$7
>  
>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
>  if [ "${EXTENSION}" != "none" ]; then
> @@ -29,6 +30,23 @@ fi
>  BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
>  S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
>  
> +if [ "${NO_KERNEL}" = "enable" ]; then
> +	__BASE_PATH=${BASE_PATH}
> +	BASE_PATH="${BASE_PATH}-nokernel"
> +
> +	echo "Rename from ${BASE_FILENAME}.* to ${BASE_FILENAME}-nokernel.*"
> +
> +	if [ -f "${__BASE_PATH}.tar.gz" ]; then
> +		mv "${__BASE_PATH}.tar.gz" "${BASE_PATH}.tar.gz"
> +	fi
> +	if [ -f "${__BASE_PATH}.swu" ]; then
> +		mv "${__BASE_PATH}.swu" "${BASE_PATH}.swu"
> +	fi
> +	if [ -f "${__BASE_PATH}.wic" ]; then
> +		mv "${__BASE_PATH}.wic" "${BASE_PATH}.wic"
> +	fi
> +fi
> +
>  if [ -f "${BASE_PATH}.wic" ]; then
>  	echo "Uploading artifacts..."
>  	if [ "$DEPLOY" = "swu" ]; then
> @@ -48,17 +66,20 @@ else
>  		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
>  	fi
>  
> -	KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> -	# iwg20m workaround
> -	if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> -		KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> -	fi
> -	# shellcheck disable=SC2086
> -	aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> -	aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
> +	if [ "$NO_KERNEL" = "false" ]; then
> +		KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> +		# iwg20m workaround
> +		if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> +			KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> +		fi
>  
> -	if [ "$DTB" != "none" ]; then
> -		aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		# shellcheck disable=SC2086
> +		aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> +		aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
> +
> +		if [ "$DTB" != "none" ]; then
> +			aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		fi
>  	fi
>  fi
>  


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

