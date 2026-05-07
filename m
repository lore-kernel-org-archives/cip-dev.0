Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718B7CD3439
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 15:01:15 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14083.1778166065988959912
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 08:01:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YYGwazW5;
 spf=pass (domain: siemens.com, ip: 52.101.84.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niOS5ZajeQ/V3iHTgOMMfgUuLZAljW3HqkVGUSBa+lbQvHpfZnPZsNG9gDl3Zb4RA9dfMl2JhQB5clrc8kxSZxYGlHz+IvQGWfVOrwCs1FniwhBWDVigORvaEhc/dJWJy6xqLjdwQRHf9CKvRMI6zQqfkNFQmWD6bZhb/QKcx28x43xCvkLcKphHIWL1LoIDi4851a/QYwdRYcr4WPmmE1LLZMKAWO2UcY6q6DVE2Q3O9ZMCQYVhuE1ueBiO3KV9Wf3cDZOrh0XoI1tB2PqHtIRNar7PhTlG6Phzdy2QO9YktDtfIbAqpvEcuon2dp6O26HYMG3HfcEUTfrCVrED9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHImIPuOhkv1NATOwhgsy0lN4TJuzgGpb6kXfUyTpN0=;
 b=hCEIEahqkzYnq+/nnPp1o9B9n6UI7m1+HkdEbJ7ptG5M7ioocb83QXL+Tcp2Leg0l/BR0bqZeaLETIn+6oeMNW/mIyJcAykTgn7LaiMQ1nyLI9dALiGn5ewsqL/kY0+QVZBI+SClSWqMOgaz1Wul05sDnLZPAvl9DNjpq3PxtgKrSiAI6ztBnfTs089i/evvcfgu7nSbz3NpsYSXnBuYxUsVnY2SfXwgNMbTJNFeVBrBD22uy96cAWpqu/DH8AIDBS1L4NslAHfDXK95Q5HnnTGSaS0JSx9WxK7KFp8VjPSSs/PE9uRCGVIrWZa9u8pAMWIHUB28ll3a4wONBhHd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHImIPuOhkv1NATOwhgsy0lN4TJuzgGpb6kXfUyTpN0=;
 b=YYGwazW5FDqk2hMfCzgeFlAYIQGKr2YRDWIlPrdQxxyXc1s662gmkbc1vOmTdZOMbUAjnEMQOiyfPUym1KTk2SB3LdWUYWgWFAydXM8rkXI5HJohKosSmc9JHe/g943SUCzv8jBJ/Jp+vbxkemcwq1Y+LVKlAjsGedIeRCOJams4XI/xmm/bR1iNP88O1BAHBx+Kcg652eyJOfq4IUEn/z3hQDbmxEUaSPCF649HKFgKBARC0X2R4rt2HxH99KYLoNfBUzpvp8XxBfc3+zhp0d+Y8LRzM/dZmmK/It7zD6qJOs357vnT8842fzjfQTrhrCMw7LC7Jb51mmCt3MWyfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6154.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 15:01:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 15:01:00 +0000
Message-ID: <1738efcd-5593-4eff-a09d-b85666ee0c35@siemens.com>
Date: Thu, 7 May 2026 17:00:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v8 3/8] Add factory-reset
 initramfs hook
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
 <20250925060009.1711605-4-Quirin.Gylstorff@siemens.com>
 <357ee0ef6de6cea2e0a7eceedbe6aff35a122315.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <357ee0ef6de6cea2e0a7eceedbe6aff35a122315.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a2362a-a941-4156-1f86-08deac4973b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	xoltlrVaxC/CXNQNRcO6NuZGNrFdRiQlMOO6lGgJALNi4JMoh4j7v2UFAl3y7V9tdDFUrbRFg7tx1LmdW64ZmAil3Iwmb+V4r9OsE6fdbxk+YvkGS2sDxCXZLK3GpLj7AoFCcKwyVlSqytPj3+8rdaQOIEkCGxX0N63TSzoiwq6OGSk57RxkFfzxiJ7tpZ6MlZB/mU1AovBV6eJDbBiUy1iXGoImmBde4Nr1FIn70v1DL9W0R1kGd8jRD76dQcdzf6uc6oAte9SIukhv/F0yqWzp6NFzgZVtIU9OniWU8mAl/+Ja72p6N2CTBM1KO4b4RItYSWNxVEVslVs1MKoIGP3LWsVchUR4xxmjTu4o1T58Xng2yGj1a3z20nwz3NO6FWFrBs0rnO9YVQVFps5zl1qB2FcTFIr5xw6SmMMMJtjAerc+4VEozJtt2l026BtLDvGQs241qkSKQycGfwGcRtEUT3oHe13V6CuxKFBhyqpKr7x/mcb97P1aj5YRF8mwzbCbDL/4C3rjBVNvbtgBwfl5eQArx75mlC8ll2ykbVUyG4bsLsgRXIqjrA9V8NX//rlmtNJiAoN2pUgOnGBhaTzewDpoeQ+LZDOqYyU8nf1I4rgsyorq/IPIVZf2gSjdh6HJCSSZINXLcFWQfoWVAK9HF96D2P204RguZdmzYCpOnSdNFsIer4hldXMKaOPp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RE5vcnJpeFJ1aUVhRjNhOUZ2TlFaMkhoNVhGWnFxdE91RjZmL1lNNm9vd3Nq?=
 =?utf-8?B?SVVYWnBlTzRHSmJ3ckZ3d0I3QXFzNXpIQ3NKMG9oVlZwREcxTzlsenExOW1E?=
 =?utf-8?B?L0xuWnFVcGZBYjY2LzlFT01mMjJtOHY4ODNMNVQ5aWV1VFptb25TK1dBL3RQ?=
 =?utf-8?B?MXFHRCtaY1RuRmVQWFlCWW1EeHJRTGFvMGpSenM1N05zOSt0dE9aV24zTXBI?=
 =?utf-8?B?SW9hR1BNZ1huZFltU2xNejBSWldWeXNKVDNObTlHUEUzdzUyc1E5Umt5c3Rv?=
 =?utf-8?B?dmVPSjlLVGVtZkpFT0F6Ykt2MDRtYkNRLzZ5dW41bU84S1Y3c2VUWVNMSjhU?=
 =?utf-8?B?aThRbk5vQk54QzQvOTBzMjBmSXUzN014emJRNXdMTHV6OTZ5SGlOb2I2ekxh?=
 =?utf-8?B?MUdnWXludmJDdXBRNzdBOGprcHhhaUladHJUakJDL0tPVFkxcHRNd01MMnlv?=
 =?utf-8?B?eFF3dEtEMU92dndXanVacklXMUpPemwrWjFTV1d3Ym1hSm1yY0FCRVlUQzUy?=
 =?utf-8?B?WnU0Vmg4UThia1NmN3R5cVBFUTFMWS9zM2tUaTFLUjlHVTVDRjdhVnYwL3BT?=
 =?utf-8?B?Ym1ZVyt0RC9kRHorSGFGeHNxVU56MkZTbmVPRHZndzBLMmVUZ2czRTgvS2JG?=
 =?utf-8?B?VlNoZzd1eG9hRXRpRVJLQ1RnSlBtVko2UGsyeGVpTkdpd2JsR2tKWjllRStU?=
 =?utf-8?B?S2Y5Nk9tM3EyeWNaSnpURm1TMUl5Tk1UQXNILzBaRHdmMjlqbWZQNlppbFpp?=
 =?utf-8?B?WGhnRHd0QzdFY0hqQjNMMWxTRnlURWhFL3l1RHlQRG1Zd3BoUEw4cFRrdVlR?=
 =?utf-8?B?SEEwZkgrN0dzbXFEREM1WWtsNFc2MmpxcWhhR2tDZjRYaUpyaEZSNjk5VFZD?=
 =?utf-8?B?enRUMFYwUlNadkdjZmFjS05EWVlmRW94QmxXN2JIeUxoQ0NZak9YOGtBYm1Q?=
 =?utf-8?B?dTN4Y0hROXJUSWR5TEhBdk1UVGljenBkUFRzWUtBTVdCU2gyT0tOaXhWRHc4?=
 =?utf-8?B?cVYwLzJKaU04dzAyeU5raHhoQVpmeWgrTzZQcUttZU5RQ0hnaHJjd290MFNy?=
 =?utf-8?B?azJUTlVjSVhRbG5lNmFJb2FhdHZmZnpvRUFzSjJiaGpLY2pRRzNFUGVYdHNX?=
 =?utf-8?B?YlBUa2FxK3JxSEN1R3FLdUlRbFRNN3hVVjJqOXRxQjFLWVFXYnFmbzd1QkFx?=
 =?utf-8?B?NTBMVHNUL1N1NHNlbFd3TW5pQ0Nnb0Q0YnRxVXA2V1lCTWVlWWlGT3FqV0tB?=
 =?utf-8?B?V1BvV0EreEdYLzI0dmdQbFN6RkRTOTRKZEZyZm91UG9UdHJ4VDJTOTdwbDdq?=
 =?utf-8?B?dlVaWkdwVERzaFJKMEtrUnBmbS9CL05BZkxwaWlBTWFIc1JNYVdycnpyQU9o?=
 =?utf-8?B?dkFzN2xqMXFWaWE0YXd1bFVrcXc4eHJnZ3N1WXZkQ3RPcHJFQktnUmthMkht?=
 =?utf-8?B?R1BaUnVYNnI3YWNZQUovcmk1YkZiZGVjNERSenFtM1I0QU1ucGFGWk9EUFY1?=
 =?utf-8?B?UERmU2lzRGlvUEYzRjA5M0VHdGkzempNdUZzYy9zMXlMRUtLeEgrV2trTjJt?=
 =?utf-8?B?bnhuSFBDZ1Azak1Ld3NncTRmcUhCQ0hRRUxHYXdTVUpLVm50YU1namxCN1l0?=
 =?utf-8?B?a1RJakJPTjIrUmJhWENoekVLaVNCQW0yTW5XcDJPSjFYSk1vaUp1QkNRamdy?=
 =?utf-8?B?Q1BwUEhNS0JadDlwelVzcXRnVTBqMVByQXhRYmJTS1JWY2ZOZng0K0JIemlG?=
 =?utf-8?B?TWpKb0dQWDErTTFiT0d5REVZSHBGbXAyZW5KbWIvVVNtR3hLdFdGQmdFa1ZF?=
 =?utf-8?B?dzdNdzBpSHh1UFlaVU5XeW9abkRkZ2ExMGx6QmVXNTRlYnRpbnZKUDNHN05F?=
 =?utf-8?B?VkVrck5tRlZYQmJIY25COUc1YmVxcks5bTNMc0oycFhFSkhJR0p0RVg3TWJv?=
 =?utf-8?B?eUZyOUx0aFd0YXFQdnVKL0pjVi84VzdaeW5FdGEwaHhVKzA2eHpvTG8rTTVq?=
 =?utf-8?B?RXQ5RWJwckpOMEJnMWRVKzlGdXg3clAzV0pTVEVrWS95VzBNQ2E2US9rbzJH?=
 =?utf-8?B?QUp5WTFlUUJVWGNONTFqR2k0N1VrR01iOFYrd1pIbXNVYjhQSFpzdlIvdFBB?=
 =?utf-8?B?Y09sNjRpbVJPTTEweUs3MjlERVpwS1ZCWnlROVRyRzh2L1haakRaQXVVUFhn?=
 =?utf-8?B?NWJZS2cva1dHUFc2Ny9jQ2p6RG0xUXd4WFk3RVFnRXRMZmxzTEx6V2RwcDFp?=
 =?utf-8?B?bTVTTmNQWUJjWFJtY21wSFp1Q2g4NEEyM2cyYW5JbEhrcXBZVk94R1hxYm9D?=
 =?utf-8?B?RXNJd1U0blhkOWgvZzdoS3ZDKzk0SE5yczVSVG5NdzVBZ3REQlFPUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a2362a-a941-4156-1f86-08deac4973b0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:01:00.8463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8T5FOyLkA1qDIBrSkSmB6MOhmVLXH0EPsrMaeBAEVTIHviwEoGnQaPwuTpSoEmchg80hlGSIdEFgFBWKZxxEpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 15:01:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22908

On 07.05.26 16:51, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Thu, 2025-09-25 at 07:59 +0200, Quirin Gylstorff via lists.cip-
> project.org wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows to reset the device back to first boot by
>> formatting the persistent partitions.
>>
>> The reset occurs if a file defined by the variable
>> INITRAMFS_FACTORY_RESET_MARKER
>> exists in the device INITRAMFS_FACTORY_RESET_MARKER_DEVICE.
>>
>> In case of disk encryption it will invalidate the keys
>> stored in the TPM if INITRAMFS_FACTORY_RESET_CLEAR_TPM is set
>> to `1`.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  .../initramfs-factory-reset-hook/files/hook   |  5 ++
>>  .../files/local-bottom                        | 48 +++++++++++++++++
>>  .../files/local-top                           | 52 +++++++++++++++++++
>>  .../files/reset-env.tmpl                      |  3 ++
>>  .../initramfs-factory-reset-hook_0.1.bb       | 40 ++++++++++++++
>>  5 files changed, 148 insertions(+)
>>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
>>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
>>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-top
>>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
>>
>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/hook b/recipes-initramfs/initramfs-factory-reset-hook/files/hook
>> new file mode 100644
>> index 0000000..5ea3288
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/hook
>> @@ -0,0 +1,5 @@
>> +# Copyright (C) Siemens AG, 2025
>> +#
>> +# SPDX-License-Identifier: MIT
>>
> 
> [...]
> 
>> +RDEPENDS = "factory-reset-helper"
>> +DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, factory-reset-helper, findutils"
> 
> This unconditionally adds a dependency to btrfs-progs. This is
> problematic for two reasons:
> 
> 1. the dependency bloats the initrd
> 2. the dependency pulls in a tree of transitive dependencies
> 
> This is much better modeled in initramfs-crypt-hook, where the btrfs
> dependency is configurable.
> 
> Note, that we also unconditionally pull in btrfs-progs into the rootfs
> via expand-on-first-boot, but this can already be configured.
> 

See, we are working hard on making btrfs inevitable. ;)

Fair enough, this should be consistently configurable. Open for patches.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

