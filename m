Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132E1C71137
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 16:52:08 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.3])
 by mx.groups.io with SMTP id smtpd.web11.364.1749660721939808710
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 09:52:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JuDvCWuu;
 spf=pass (domain: siemens.com, ip: 52.101.84.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnMk3KGw9Cw7j962nRJewquMpOAwYagVxbUAzl0+E3+YS+zdhcaRpL1hRq3B0rq+VzZDjClL+mXgaGOj+llm706IlHYN/8/d+FY7wXt3WgCDrMJYsCbQwDWNgHOHzvpEdJM0myPswxT94sxaVxBoiP1sZTs3zwUIIapfVc3gltVzrAHpIPUcHUdOI81a3By0ITFDz1eAoWbG1hrhtuKL/MdZpUhqLpVlr64XJ/PWYGsHj1Yv8GQp0oEO5TOfyrx6gHGPTIStKcbYCIT8BLQ4oXA243oA0DHYgGCnkB4fKP8HVD5H0S3CDo6Q9N4RQn3Cm9a0dWw26BBvm+Hz+k61wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHnny10Pzzd2ACXwwh56SV38zoZ8DRGBxBMWnAamDDQ=;
 b=Ulr/Oo5bxG0ugaC6FsY0N6+oOLpchBZsN/G/RBk+R0bcsE1UzXGifiF3Tlo60bVXdQ+h0h5fTTCy753BUL/W+tEyw0Tz9h9LfBL+a7z+A9VJf+aj0QaIWTevs5+40JdItjwkxrqxlva/PLAO4de14Hbc5kCsfcuCmI44aj4hVjNGprjvd9XU4PyBVuOcBGnjnP7CA8TK6yY29EOazAfQpxOW/xSHngOspWe1KlIqVC5Ix+tPeqhHkM1EEbblAO9lb5uTwsffWnIq6Ww/H+GEr+VqZj5YJYeTysvBQvMOxAgQRac4PmOP64JMUIjsWiM6TqugxoQZVdkby9leMtkOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHnny10Pzzd2ACXwwh56SV38zoZ8DRGBxBMWnAamDDQ=;
 b=JuDvCWuuIgJ2u4cjXuCaMHRkd/CiaxY4Za5Z4XftQWzrzA2KkXUZuuevWjjpRyPiyR9owx8BGi0F6lN4Q1Ds1yQJWjCjJACO93L3zqDkZBG3HIPrr3v1Vow/1j9tpjUKKjzxiPthEazv3cWMiNivYMDsVHnIK5TCXquRKD9bLBS5sTsRdfyE4jUWHDvtp0SkTTEI1hBVH9JhBCmh9wqvBzIEbMMf9L6tvMh4A7I8ETN3CZAvVUO/dZrvIKOqPOqI3UUCqtvoS77zoBrb9bqXSLPPK7tK6pLF8Jj6DmG/pyiKl4lh2lArS4f9+D9awYDUSKXq/CcQ3WGAIpJyXjOCXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6763.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:430::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 11 Jun
 2025 16:51:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 16:51:57 +0000
Message-ID: <52de56fe-75f0-47e2-bc27-c69899c2eaee@siemens.com>
Date: Wed, 11 Jun 2025 18:51:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] fix: overlay-hook: add missing
 dependency to e2fsprogs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250611162745.741481-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250611162745.741481-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: a8388196-f564-431c-aca2-08dda9084708
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YThIdVdoTG5sVkt5bHdHaTF0WHpRSFovSEg1UlFKSHVrcEdQUDIwVS9EWW5U?=
 =?utf-8?B?U1NwTzJ1Y0VRNmMzU2J5U3NqbnYvS1VBWkhVRWNDL3FLb1QzN21oUWRTSTJp?=
 =?utf-8?B?UHZvYy8wOEZzR0tBZEdxUFlvMFRqSGRWOXlqSDA2SzV1RCtpWkp6WDZlU3dl?=
 =?utf-8?B?a0NyUzlHcXJraER4S0lEcFBvayttbnVkcEFtenRMekpJaHZWdXcycmtuR0F5?=
 =?utf-8?B?U0hwMmhDTTZLZmVVRFpGNThVd2xGWWJ0ZzNRMVNGc0RmeHExM2ZrVWthdHAx?=
 =?utf-8?B?MGorT2MxK2l3dEdobGxIZE5jMHFtT3VRb2M0dDU4VUN6WFhJQ3BzTXd6dm1D?=
 =?utf-8?B?L1VhQzA3ME5Rc2toanFsY3ZYT01tZ21LSldzOVVrS2dNNEpWelRCa2FNNkpk?=
 =?utf-8?B?UW5NZE50T0M0TXgwOXNOZk02bW1ZVnlLeDhsVW9IY1NoQ28rUFVQYkFGQmg4?=
 =?utf-8?B?ZU5qTjVmd2ltU1Y2ekIrcEsxM0lyNEdjVFF3ZUIwb2xzYkhSblhlZUpUMmFo?=
 =?utf-8?B?QWVsNVZkc0hLOEY1MTdNL0tJbnFIMGJXUDFpdTFMRXFXaS9SNmtHVGo1dCtR?=
 =?utf-8?B?QnFqQXl4VXV2V2lzQjNGMGNvN1ZRNGFrSXlXL1N3SW00aHJNMEVpSGZHNTNK?=
 =?utf-8?B?RVplb1d5REJJQ3JXRjFWWnFaWUJLRVMvWHVQd2s2RkFBN2RNMWlhSkZqUWRz?=
 =?utf-8?B?U2srTG1sQnlERjB5OVRDbkFYbUZnbE9HdzBJUUxVdGpjK2N4cEFYYzlkMjg4?=
 =?utf-8?B?ekxWUmFnbGQ5NC9JYnBRSTFndVErMG4xY0RqL04ybEpJTXoyNlZPQm9kcjcv?=
 =?utf-8?B?OEdNQVJzZ0RxdUhkQVB1cFVhUjkvTTNFbmJsc2R5SnNqU3h5eDZ3UVA3R3c4?=
 =?utf-8?B?cCtIQm5TaXdxQlVPb0NNT1B2MWxMbUtBTnZMbFNsN2NWcWRCbEIrN0hkQURx?=
 =?utf-8?B?Rnh5MjR6ZWdZRm1XM2dISFhsRW55VnI4YmQ1WVNXN1lPV244TmJBSnRRRStp?=
 =?utf-8?B?YmNveEFaU25kYXlwOXBKWUQ1b0U2bWozWjBFZDZiWnRsc2JETzRLSXdPS1hv?=
 =?utf-8?B?Wkx3MlJwZjVxb0RURGJEcDNUbklLK2RuR085eDhrYzA0TENmamZlcVlkeTVT?=
 =?utf-8?B?d2VCd2NmZkJrTDlNNkxsMXE5ampaMDQ2blFUNlJoRkl4TDM4VkZKaGVWTExu?=
 =?utf-8?B?OUs5THIyNGYzN3B5UmkydWJYY3NBTE0vZVFEZk0vS2lmR21ZbVJpa3lhTGVo?=
 =?utf-8?B?M2F2TjIxU3ptcGJyMjVybDFoeTRjUUhKTm50NGFtalJyOFhuclAwTjVjZzdl?=
 =?utf-8?B?eXF1N1k2azlnUHNyRFFlTGcyMGNNLzdDcm42VFNZT3BObG9hSDlaMGtEcWMx?=
 =?utf-8?B?eGhsT0pLaldWQWpHTGVncnpXTFEwWVJVemkraUJwemtPRUx3cCs4Nk83bGFN?=
 =?utf-8?B?VnJVUmhNSEdFVHhNK3JlcFdwMjM1ekhwZGhacnllMkt2a1VzR3RHam5qdyt1?=
 =?utf-8?B?d1BGajg4ZVh3RVpmaXdyVWFBQkdCME9rZ1ZqU1N6cGpRVkhuWkVaY3plTnBE?=
 =?utf-8?B?RWZmOCthRXVsTW9YS05tSnhQb2pxYWRRMGdTK04xUlNaelhNdjhpa2FqYitZ?=
 =?utf-8?B?bzFRQWlVQ3VMcnBROEhQWnZFMWhYdm9HU2ZIanMybHJWN3NSOHFjNU15QjV2?=
 =?utf-8?B?L2ZHdU1PbzVMbUFycHJIOXJEOUxuRXBpWXU5ekdad0VJdStsc0YveGp1YlVq?=
 =?utf-8?B?OVBOYU1iSWVZOFprb0Fwa09OOFRWeDdrYVNMTFZoZnczVU51WjhVSFdjd2h1?=
 =?utf-8?B?T3gxcCsrR0pib3BuREN6M3Ezak9oeERCd29raHZaUjhodU4yeU44dk12Q004?=
 =?utf-8?B?RlR1SWpmNVFHcjFWQ1NFQ3hYTE1BQVJHTFJIQjNxM3RNMDdISFZQTE9nZHhQ?=
 =?utf-8?Q?yrvojONqoHw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGk0eEtnMUdYenpwM3JsaTdpTVNBUjNGVGlGMTRScFhvbzBlbzdLbUJoOXho?=
 =?utf-8?B?VkdwRnVwUVVuejVmWHFzWSthREtKYWtLS0pQT0x2dWcvNnZYeHRjaG5qRU1h?=
 =?utf-8?B?U29kQXZzaTBNSUV0ZFNZbDgxandWem5va2l5c0wveHZuaDk4V2Qwd2dtY3Fx?=
 =?utf-8?B?SUhpaGU5RkFEb2JBS0NmMlNJWmFsYkJEdjRrMTJkS3hSV3NzRFh0enZDVHVT?=
 =?utf-8?B?TG9lQkpDVkFsbWFDbG1Ja0g3QkVWSUpVVjVwUFh3VVBrSGIra1ExaGtTQkxX?=
 =?utf-8?B?b1dBcDhOenQ0Ujg4QkloSmZiMG81REdwVzFuNmFVazdGRUxWRUdoY1pERUl0?=
 =?utf-8?B?dk1vdGJ3eEgwdG1tU3dBMGtiM3pOdWZwclBaUWlFU3NLNzJINE11Y01SUTZY?=
 =?utf-8?B?QjJKYnJ2WlVZM0hoQWxQdjViS0l2dnZ2Nk1XcjZ0ZW01TnZYdlNIVTZNMU40?=
 =?utf-8?B?ZWN2T1NZZGZVeE5vV3V5VFJ6aUczV1pRdUdBL3V4NFMydHNPbjh2ZC91RERM?=
 =?utf-8?B?b0tiVkZ4WU81OSt5aG1MRm4yYUNjUnhDdHVmMzdhZCtjN0NBZHNNb0hCck5V?=
 =?utf-8?B?ZzJxRDJUcUk1eGszSUZuVmxKOWdrU2VGeUxRMmdwTEFmY1VWalhTWHMzcWlF?=
 =?utf-8?B?SE1kYXF0REkzQU5xbENvQjZVclNoT2tOaFlwMW0zRzRkS21wQmJQVVJVa2xE?=
 =?utf-8?B?N25sSVc0SENGK0l2WUVvKzFYVXAycER6bHA2ZWdYNjQyMzlQMmdtM3NsRTlk?=
 =?utf-8?B?TUlnQmhyOWpqZWFqbE8xd3d6U053bDhRbm93Y1VGS2ZrMHpsQkpGc0R4S3BD?=
 =?utf-8?B?dVFDMU9qa0tDSVFkZ3FKK3kxZllYMFB6VGJKWkkzNzV4YUxQTjRFSjBHKzJI?=
 =?utf-8?B?NlhoUXdNV1M1N1pMOE1BeTBhb2lublhldC9CMGRPdFo0UXhPZFR5WEVVVmtx?=
 =?utf-8?B?RFpzRlJ6S1hyVDd4UzR4RERycTdhS1hGRFdBeUliK1pST0tLeU9LTGFYbkl0?=
 =?utf-8?B?NnY1M1RVYkp5SlJRNHZxdVhVbllVcUZKcEg1OGkvN1lscERUbTcwSmxKaTZm?=
 =?utf-8?B?TTZGQ0w3RmJuTWtaaGw0RXhwTWtwVDdZazBZMWdUaDcwSEgrZTZJS1VjelBX?=
 =?utf-8?B?UDdpUzZEVmMyYW9wWVZURk1aYnpuU2xsVC9naWhYaFBYQ2JRU3F5MU90Q1V0?=
 =?utf-8?B?Y0cxclBUM2dMYnpyWi9OSUYvZkY5TmF0UFBtb1djOU5ZMkhSSG85VWxCdG1z?=
 =?utf-8?B?b2p4VlZpekQ3UHBPcVRWakZCSTZnMlVPL0gvY0tMditlL3c2RklKaUxRc0tk?=
 =?utf-8?B?bDd3dWJVbFo5UTJ1L0lCak84bGJVTllPdEtrNHREdi8yaXZyaXJ5cXVYbEtU?=
 =?utf-8?B?S1NqNUZNdUdYWXhTMUlQU2VBYmxKbG14Y2ltek52QkUzbFVyb3phUmxMaGg0?=
 =?utf-8?B?NXZQMnIxTmNpYU1Tb0ZobUJGamFCeDRwZ25JbHhDY2ZMOUFFUTQzRGlLQ1lB?=
 =?utf-8?B?YmNSN1FHSS9sU2pOK2R3SWpVR011a0hGVmh6ZHB3NWt4NWFvZjZwaEtYRFJr?=
 =?utf-8?B?RFlxQitKUXl6ZXJ6ZW5TcHE5b0NYbWNJbEhSTXE4Y1lTMyswaXdXWWZOZk1l?=
 =?utf-8?B?ZjdVZElXRzU5R2swWjF3WC9Lb0Zta1JWRDB4MmxFM2toaG1HUjBsbFN5VHp1?=
 =?utf-8?B?OEw4RUw0cjB1WitIbGQrOFFYZWRINmUyRXR6cXBLbmNmRVFpQVRlWUVuYXVM?=
 =?utf-8?B?MGhMUENTNTdlTzBlZ3ByWmRMQ1Juem11N2FaSEpVR0RzYUhZc1JxRlYzRTJP?=
 =?utf-8?B?MVVma2ZNSXNNeVlWUDlHYzkwUjNmRXBBcW5kVUtWWUVNMml1YjBNN3lQamFn?=
 =?utf-8?B?aUJyVmx3T1BYM0lvRUN4Nit6Z2tsY2VKMEFPcDZodWRaM3NkQ1dTMmY4dnpE?=
 =?utf-8?B?THBEQ1hCMkRxRWN1Wlp5bmRjZGUrMElwamNxaXh2cmtjN1JmanFWSk40NjE4?=
 =?utf-8?B?cE5UT0l4OGg2RjJkY0dGZmEwVjR1NFhlZ1gvOHJJeHAyTC93ZlB4STdLZk9n?=
 =?utf-8?B?aXlBSHFZR3BGaGdXRGltNzVWRFdJdjh1bTFZL0h0VTZtU0s5eDN5STZYNmdx?=
 =?utf-8?B?SzRsNGh1WmxJWHVqMU5Vb1JCU0FqNHQwbFVlbUVsRlRhNzBOY2dFcHA2NFlB?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8388196-f564-431c-aca2-08dda9084708
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 16:51:57.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/IZetKMANYvqRoNBKs7N9a9WecNHgk3+W8r+7cL/SrBV0yWHBOjC+k5T25VzGaAclZ6vpfnCP9VHHg7Mw9qYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6763
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 16:52:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19034

On 11.06.25 18:26, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The overlay-hook uses the e2fsck and mke2fs but has no
> dependency to e2fsprogs.
> 
> This failed the qemu-riscv64 build as e2fsprogs are no longer required
> in trixie, see
> https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/commit/debian/control?h=debian/master&id=af35afe3dac341134e0a38c3c80d745efb80658d
> 
> Fixes: 8644fb16dbc45baae23941f001c5c5d4701fae87 (initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE)

I've shortened the hash to 12 digits.

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - Add fixes information and reason why it failed in trixie
> 
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
> index ec7f85b..a5b39d9 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
> @@ -42,7 +42,7 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>      INITRAMFS_OVERLAY_MOUNT_OPTION \
>      INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>  
> -DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
> +DEBIAN_DEPENDS .= ", awk, coreutils, util-linux, e2fsprogs"
>  
>  HOOK_ADD_MODULES = "overlay"
>  HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

