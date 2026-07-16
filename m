Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B3C44501
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 05:38:43 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6369.1784180318630208774
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 22:38:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tnJR+Bbg;
 spf=pass (domain: siemens.com, ip: 40.107.130.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjosC+9LmlLKcSANlAtUt3dh7OQjI5bJDFki0ERLjVSB+o6AbFTwq/4aH4ZaIaQc6I/zJ7DZ3KyDFw7oRcFYuAWT7crUbsorOEcwQOz4fo3jZHTVxV1w2UZRbP0iEhqt9YxbP4TYzkuWvkv9LotKFSe3IRilpujlwRBFFEyj0AJDUNPjri9ld4A88UniDqV5lupdoy/1DcQU7fELfY3mOTF3MJSBFeqeOFpqFJzvJEkt1XVGTUakC6Zt4OAyZKXlxvXWwfS1QUKmGWI2BE86odlUF2xpbj+FgF1VytSJw6Nl71TRzYsyFmYECu2bZF55jIjoiPt3GjqsHGVsIpLTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5ijzfv+UGbBlzfh2mwp7FKI2ASBgd2CA6nTeBGBCXY=;
 b=kle4z+NfbniOPHomayX6u7VHBmzKU4RoliGiGeTEf9K3JHnRf+lReVHd8FZKiL69EV0Alc08vwSkl+1GioBqMJVhdmVw8TzkOILurZ2wMGtQILoPpbT5hPWAojM8gYsF1OhuIug1z72ZzR7UIL3Mqs0bHqowRwu4kpqhgko5Ul8pIh5V4aX5ArQNS/O5Qm/WvkCnWmLRelFfgCXu031zq9KBd4ZaCuvYYjnd6L3qvViID2Lh76o+tL30GSoVXnrFv52+GO4yyKNmg2dyH9vIkIUuSWOcBwGPuEQRTz7m5WoGh7OYiUoXso1B6WbEL2y5D6cqqGzuxoGn9iforryHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5ijzfv+UGbBlzfh2mwp7FKI2ASBgd2CA6nTeBGBCXY=;
 b=tnJR+BbgM21y7Tx/WtO/ysDxN4ZwGzHA+O7oO23G5EsUGSsSz4kialc27pN1LhGDkYlbBXP/1rvlk0LK+xZOomzgrKA10I5BXkPzHQDol0+UI9B5zdUotsHnZk4RX+cXWNAZ5aEm5/edMlMyE2K0D5zJ09e91WK4hJD3Vc2TNNvmhTvgG2/RK3xum/tH38AjsBdQnYHlAH97rmWzop6a6RChPn6AFzwC26laP2kfzeOCzNdEvB8vDebb3524/oexnAE5sRhPCZpsVu9IgPLotLOido3qHSy8osEnwSdvlW6uGquk4YqRNIX+V0e05ELPXJuu2daoDet1HBj4LkgwEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 05:38:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 05:38:34 +0000
Message-ID: <170f960f-3867-4520-9cda-d11f4ab8a109@siemens.com>
Date: Thu, 16 Jul 2026 07:38:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 2/2] ci: Add rzt2h-evk build target
To: Hung Tran <hung.tran.jy@renesas.com>, cip-dev@lists.cip-project.org
References: <20260715115810.2379-1-hung.tran.jy@renesas.com>
 <20260715115810.2379-3-hung.tran.jy@renesas.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260715115810.2379-3-hung.tran.jy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc89ca9-865b-4922-8b13-08dee2fc79ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|55112099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	ApueTq0oTpBljDUOnNCMFEBkRpZo42UwZJXOFNpH25e3/xZYRtAezsBluEtyfXZwFUaa0PknkHXqvWUPVrFhh4bSKcGcA8+zFgqfdeBWgZzGfakx8ihWKcAK9MttT4f5SVW6IiTpWBfi5zI1FEABsoNKHUgDXlzA6SsxgNL0dIk0FIEewdCsxgHItD5kfgOR+/9SRtjxg1XGoGrt+DBOZkFuVB2k3/w3DU2SqaPwOajv0WxKZpq6LLKOdXE/+N6dxBCEB1vHA5NCAmqLgIx1H71kh8LdMFc6eauIrtsSSUWpjBz7UDfPmiFcxkloG92yZdwQyBv6SekwnMMUgPyT+ojmbf21lBLOEOo8rUd/uEk5HhLRplSPiba4b8ERD1PPiKZ6qcYIFuES9Dv9BDFzkEKyMrQmVDgxeNYS7asZwiiSDl32qPUCgaSvfhdCIppje251E5iN+COMHUi8mVU5xo5USqn0JGAgeC6QAbA6mPLBJoRPu4S8CEfybuBbrFCiQYRnuNSu7dtJk1ME1QLMtLu/y8jXO33SKU/d736kHsPIy022iAyU03LDhJkhze7Tq2dWGTSudkGRd+42F6s9PP4RQ7Evyv63Nb3a/gES5mEWvidxQm+/R1xAvAtf+i5vaSjQ2bG+MXseYNsZ/LPS7/LRZ/SYuXicyzsur9WM8yk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(55112099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZW03WFpYaWZCYW1vU08vMFBDaysvdUZZY1RvL3VkYm5UUWNrK3VnUFhGZEIw?=
 =?utf-8?B?TTRZMlRiUVBwN0pHUHdmK09PVytwSzV5OHlyaGpTODdzbnhIWkhVVzdpenBz?=
 =?utf-8?B?L3JUYjlJL1dhR0RmNE9BNVdtakVPeXhPak45RjNNMXRTcWlZYm02RHJPYnlZ?=
 =?utf-8?B?MzVzMzJQNTcwdHJISElkQWtXM2YybExIVXp1ekpLWEpqeVQ5elBENWpYb2dB?=
 =?utf-8?B?VG9oK2FwV3kvQ3AyZmRSQ3pGREJQeXBySFFrYWplditkaHpYMWtDZWYvcXEw?=
 =?utf-8?B?eEpaMklFanRXdzgyUXFuN3BOd25ka3FTSXNmYTlxU0xlV2dGSzZpUTBiVENI?=
 =?utf-8?B?OHJQYVZWbGpocXpSR0Q5UzZ2UXdXSUtEMXpmUmlGMno4b1pER3gxNnoxck1t?=
 =?utf-8?B?RjZraUdrN1hQVnMrRmhkdFlvcEV0Wm1HV3BxS3Nnc3Zzd3kzZjNXdHJrZ0ha?=
 =?utf-8?B?UWQ3TzhZY256ZUl3ZXk5VHg5NlZFRFgzQzVxQVBLQlh4RG83ZnNvbDV0TEF6?=
 =?utf-8?B?dmM0dXVmcm1kdWZuQ0tPVmJFZndrL01kU3JqTzJ0WWxIK2l2UTY5VHZ6RVVT?=
 =?utf-8?B?N3lWT1FuaXdVTDZDWExkK3k5cEZqN1pOMk10Y2t4SDhiWXUvd3lUSHQ3WVg1?=
 =?utf-8?B?dzV2RjJqNU5jUS84VklSUjVkajloU3p0ZU9tR3RqNDIrandGaUlEb0t4RmQ3?=
 =?utf-8?B?bFBlWlBhVDdla3ZnblNrdUFxNmZLQk9HOWtERGorZStQUnpKK2tkRXp3NGdJ?=
 =?utf-8?B?V242ZXF2VGZZTUFMOG0vVGVjd1lhck8zMWNtaWoyd2cyblN4OGhCekpwTS9F?=
 =?utf-8?B?RWZmaHZ0SG5raDBkMjJHSzJwZjZTeFRMY0VicmZEV2owSko3M2tMK2Vibi9V?=
 =?utf-8?B?Uyt5UWxvSDV4UFhsMjBhV0laNUhpT2JDQW0wYlpidVpQYmZicnZsZENGbHRG?=
 =?utf-8?B?SHBvbS9OTm1vRXBwMWp2R0xvNm14WisxS1FESVliWks2T2l2aHhZZVhrR0dC?=
 =?utf-8?B?enZxZC9OUi9aSEI3cFljM0Flem5XcGhEVThnOUg4RkpqOFZzdWk4VmtrUDJR?=
 =?utf-8?B?bXNtUTZrRlVMOVhUdkNoVzJnQ3orWEFSTG1yN2Y5aG05V1g2RDljblQrelMx?=
 =?utf-8?B?bmt3Wmd5MFlNclBUSXdIT05kZVd1aisybUloR2NmTTFJLzNWMTYrZys4MzNJ?=
 =?utf-8?B?RC9vOURVd2s0QzlsbjNMcGtqbWxUenNYM0FRdjQxTlBML3pMaEtJZWtFNkNC?=
 =?utf-8?B?Ui9KNkZiZU1RWVJVQUVLaE95Tkw3Vk50ajZTcTc0VWxQcDZjZWdVdGxLTTNy?=
 =?utf-8?B?MGpodzJxZk1vcndhQkp4dW5GdExpUkRrckt6eW00TDU3QnIxd1luKzlvTTFx?=
 =?utf-8?B?N2dJTjIrQ3o0dWlXOFJ3dkxhblQxbk9BUzdCcmJUbi9LS0o0d0Q0YktKclNl?=
 =?utf-8?B?NGE4ZUg1TU5oUTVIdzZRQTVrcDRuSE5NemN2UnZDRDd6Y0VwOWE5d3lEK2E2?=
 =?utf-8?B?VnZ1NDA0V1BiT2o3TUdhaXhZejRhSGpCbUt6YWxXWUl3Qi9tcUhJRXpKU3hS?=
 =?utf-8?B?NWIvL3VkY1BEVDRxTmNqOFI2cWIzVWpkK2x4STNTWXlnT3FHaVIzT0RNMXRt?=
 =?utf-8?B?aDU3ZWU5djl3eFBaTG53RnRnMlZCRFd1ZTJBKzFGTm5WQVZ1c3hBUCtvUDJ6?=
 =?utf-8?B?S1p2K2JtWUtid2p4TVMzcmJDaDVGK0FIL1F1K3FkYWFDSGMxSjlpcUF2Ym0x?=
 =?utf-8?B?ZUwrQmpkN3YvWHpBUnkxMXJnNGlVQ09jZUw2KzVuWnRxNmVVd0tDSHBpRi9O?=
 =?utf-8?B?eWNrSXVubjFVc21UK2tpOHB5Yk84aHRtVHpwbmxOd1VMY3lsdFN3SmdCVCtV?=
 =?utf-8?B?YnJFdUNWWWNTZWY5Nkx6Yi8rZjZVai9naTU5UWFaNkEyd2JiQjBWR0pveStH?=
 =?utf-8?B?TXIvMXZUVjltL0N0Nm93OXQzNVVjWEViSW4yeFAwZ2E2MDFUQnFTaWRBaWxm?=
 =?utf-8?B?cUh0QWZvU2JhaWxTZEpuUEM5aDQydWpjNTRsRnJLeW1SS3puRjV1K3l2Z2dC?=
 =?utf-8?B?WWxhRFdsRmdXNVFqVy9CVmYwMTRxbmVHeGo4emZHdC8xYklHeXEwbGNwSDhm?=
 =?utf-8?B?dElDdUVtSkg1MzV4cDJmUlpOQkJFOEFOcEVuVGplUXdiQStuTE84MzRvOW9T?=
 =?utf-8?B?RTc2SkV5SE9lU3NjTUF2bU9jNUI3WDBCcXZra0FEd3hpRXdvR1U2dW83cng1?=
 =?utf-8?B?RTBNdis4OVZucFN3TTBnOXU0Mk1kU3VpbS9salZnczgrQm1JaEJCWnQ2OUZh?=
 =?utf-8?B?SGhDL3BUNitDRmZwbjFyYTRXS1gxSW94eGZXR3NsN0RxdVN6SnNJUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc89ca9-865b-4922-8b13-08dee2fc79ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:38:34.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85P7kmJtsmBK8jCeLxPf36z53SUZU93ScMOkuoFMr3eGLFMRJagQsmKGLunPeV9b2MRfDNCggw9CPBw71IiI9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5834
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 05:38:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23603

On 15.07.26 13:58, Hung Tran wrote:
> Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
> ---
>  .gitlab-ci.yml | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 5a20ad6..f33184b 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -122,6 +122,13 @@ build:hihope-rzg2m-base:
>      target: hihope-rzg2m
>      dtb: r8a774a1-hihope-rzg2m-ex.dtb
>  
> +build:rzt2h-evk-base:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: rzt2h-evk
> +    dtb: r9a09g077m44-rzt2h-evk.dtb
> +
>  build:qemu-amd64-base:
>    extends:
>      - .build_base
> @@ -196,6 +203,14 @@ build:hihope-rzg2m-test:
>      extension: test
>      dtb: r8a774a1-hihope-rzg2m-ex.dtb
>  
> +build:rzt2h-evk-test:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: rzt2h-evk
> +    extension: test
> +    dtb: r9a09g077m44-rzt2h-evk.dtb
> +
>  build:qemu-amd64-test-nokernel:
>    extends:
>      - .build_base
> @@ -292,6 +307,14 @@ build:hihope-rzg2m-bookworm:
>      dtb: r8a774a1-hihope-rzg2m-ex.dtb
>      release: bookworm
>  
> +build:rzt2h-evk-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: rzt2h-evk
> +    dtb: r9a09g077m44-rzt2h-evk.dtb
> +    release: bookworm
> +
>  # bullseye images
>  build:iwg20m-bullseye:
>    extends:
> @@ -309,6 +332,14 @@ build:hihope-rzg2m-bullseye:
>      dtb: r8a774a1-hihope-rzg2m-ex.dtb
>      release: bullseye
>  
> +build:rzt2h-evk-bullseye:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: rzt2h-evk
> +    dtb: r9a09g077m44-rzt2h-evk.dtb
> +    release: bullseye
> +
>  build:qemu-amd64-secure-boot-bullseye:
>    extends:
>      - .build_base
> @@ -337,6 +368,14 @@ build:hihope-rzg2m-buster:
>      dtb: r8a774a1-hihope-rzg2m-ex.dtb
>      release: buster
>  
> +build:rzt2h-evk-buster:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: rzt2h-evk
> +    dtb: r9a09g077m44-rzt2h-evk.dtb
> +    release: buster
> +
>  build:qemu-amd64-secure-boot-buster:
>    extends:
>      - .build_base

The board's kernel support is limited to 6.12. While it generally works
to use newer kernels with older Debian images, I don't see the need to
cover that in CI here. So, limit to a trixie build, or do you have other
reasons to spread this out?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

