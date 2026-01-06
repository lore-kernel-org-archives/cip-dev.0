Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A22C47BF6
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 14:05:20 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.90430.1767708311541927053
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 06:05:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TYVAN8jp;
 spf=pass (domain: siemens.com, ip: 52.101.84.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPzXxEwM8xNVpJgfAAtlC+joG9DybK9obUR/qT5pMKN5dnwVmvdSf0uvKGoo7a2UULdgAJNnMkC6L5ueN7h/noukxG3CqstZxZG2HvdPlwASiVk8gwxiDpnUF3xr+olaeozxjShRTiLK5p1FsPUWXM5hSWNjGPzUWJhCAqgeAqLPYXSrtm9TIEkuQyaB/DN2uChLpLpxXMcxwd1VrZWJvLS3K3Ej9bMea9mvmhQKVSZYggnhzHF0uJih7HS8KO6JDJWgpU2Qg9dxHl9tArFbq1Z5GVkMEAOIuwvAIiiNJXngRuQs8AQIT1xlqPr0Mz69v2DExwJJXjNU49BKjdf3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdNpAgEKdgHpwLBPPQymMzysW9SmC6hWfH5jK/siXHs=;
 b=fJlnyZ6kM1inDb/iE2eGw12YR70BZ5Yq+QSv2swcyLVsu+FeSRJ8VKcc6RsJg+rZGQBa3QPa7ZAnJ/qqnq593Qu5KSBwRPlL5DCLUL/U2k73snlVcTV978DeSFGd3iv0veF4a1UENZx0e/+6VeMDrUTBs7k1sQW5i3858unyjrWD1peWAf9mXhkdBpzuR5YxTgbiH6wLtG2aAvNDOaaAbLnr6QbhB2eGpvyk0ktT0UaQOB+rY3RND39PXl96wcCS5hFJrs0x0EGC/qimRaYfBdVLNUgC2aos0f9CBBT7ZhRDbOGSQEGFRuTaSLi1AzpMvgg4BUVXoyXA7yH955ZqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdNpAgEKdgHpwLBPPQymMzysW9SmC6hWfH5jK/siXHs=;
 b=TYVAN8jpC/FbnTaBjDgc/8+ArO3Z8Lgop4CvUEzL/Nym81MEdXV+UEVeFav0pbwaolR36bz2jhzojlI5VCXCkBZEN9oYXwDKQClCmhzniyCKrUSJqlWcdNcD7Z5fjyKrRmpFkiHbK1iiQC4YmXGpgKhd13Xq7T0CftsXeqbksLBmK7rKkjcuOMpvkB7O3anRBOWAIpmnYVw1MRCZLA5jKvfVjee2/Ruwb9ysuyvgdoYaORNWZtKpf+NVf4Oh+5CVxpej1sHR34YV+h9kXkd7bzkRSf8wg4nMw/0t03Ja1cvZdE5pBvdmb9H015V92wtEBpmMo3GlEaMCY3k8TFWOHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8468.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 14:05:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 14:05:08 +0000
Message-ID: <282d486f-6853-4235-b226-0dad9481b145@siemens.com>
Date: Tue, 6 Jan 2026 15:05:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update kernel config revision
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260106041149.270874-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260106041149.270874-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cea0bf9-4cd6-47c3-1527-08de4d2c9970
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NHhXRXppbGx2OU5WUmlockdEOVp1MXZRbGJ6NXpwdWNPVHkxK0tGVkVETHlU?=
 =?utf-8?B?WWtCZytyd3hwMlhHVkRTTGluV3VPUExCLy8vNDNGaWxheTJhUEx6MHowL3Bm?=
 =?utf-8?B?N0tiNTN5N3RWRUFjZkFtMm5Wck9tVGQxOFljbDR6QkRFWU5xd2lBMVN4akZp?=
 =?utf-8?B?endTOFQ0WFFqL2RnNFlLNE9yc2lBcVRHVGxXMGNKTW9YRlJLZUtMOWVmNUNj?=
 =?utf-8?B?MW9tZGRjT20xQVBlM09IWWxtT2hJYXZTOUZjWG9TaVZ1Z25VbGhYTDkrZWZm?=
 =?utf-8?B?c21qdWs0bTN3MXB4RDY3QndENlFBOCtSSlIxY2xXYlFZVjk0dDMrRlQwMVBV?=
 =?utf-8?B?UGZ0MkpFR3BCb2FyQ0s3ZXlmT1EwenpqUTNDOGRuenJXRGpNT1ZXbnc4Ulll?=
 =?utf-8?B?c1FPWSthZUd1ZW5ESlQ3dGdCUFBnYUttNlVVcTYzM0FIcWFwSDRHNnVvRHdI?=
 =?utf-8?B?Sjl4V2R6ZDJFN293VHZWS1pNaWxLN0VUSnlzUkJEa2Q5RzNJenFsRWlKdDNB?=
 =?utf-8?B?Q09XbC8xRE5UclJJdFdEVnk3UThkZ1FiNjl5MG1PZnc4ZG4xNEUyNWRER1Ru?=
 =?utf-8?B?VTNGVTF1eDNYRXRqOUM1UVFhejRtTVBLVlRWYVFjUVNkekpNMEMweloyYk5B?=
 =?utf-8?B?SVBKVVRsTWtZLytPSDlQeWd0WDV4c0JkclNiS0dJeWtiRUdkWG1CUCtLY0tY?=
 =?utf-8?B?ZHhUbGRmQ2c1VzZQazc1NGxUMnJKOTNxbnJtK1VDb2NQdVpxeTBZOVIydUFi?=
 =?utf-8?B?aSszL05EbmFtQkdlK2M4b2VDY0hDYTR2UWlSUlFvU1d4cFgxZzBjUlV3Um54?=
 =?utf-8?B?S1JpdFpxL24vMTdiUWVya2JCVkU4QlI0T0R4VG5TWWZOZERKWWZHb3ROeWJq?=
 =?utf-8?B?dWNONWpEVXdiV28zNkhNVC9rVlBaSEV3OU1uUWVDNWROZnJFdlBVRUc1L0ts?=
 =?utf-8?B?OFgrZkpSRUJqRlppTXdNVVgzekJZR2dIMlkvT1lpdy8yMnFoT054N3k4L3Mw?=
 =?utf-8?B?Ky94RytRZS8wMmU0L29LZXNVTW5NZWU4anUwSjZkeC9ZYWpDemF0b3RJNWRK?=
 =?utf-8?B?UFFUb0gvUVFaNW4yM2dCNHlaYkFzZys2QWhWa2NGTmNzbWw5QkxHUHYwWkcx?=
 =?utf-8?B?QURyS2UrV0d3YkJUbnJNZEZtRUs4cEdibXNuLzJrWEZ2MjZ2Z3lhcys2M0lY?=
 =?utf-8?B?RnJxNkZBTmZESUNWMkpqV0pTcDBpLzl4enVjbjRkVng2Mmcxa0JoSnNlbzdh?=
 =?utf-8?B?U0R5aEJOZStXd0VkT3JQcHRiMTRCN2UvRHJQQXEzR0NGWThXcXR5T2ZyVzJ2?=
 =?utf-8?B?Z0s2dU1NMjlBRzg1NnF3MHhQcVh4eWZKMjVULzJYV3RhRkRENFhXK3RJVzM2?=
 =?utf-8?B?WHVxdldjM3EwRi9mZUZkUXBRK0x4czJ1TlNtRkhvMThDYmE5QW4zL3kzanFu?=
 =?utf-8?B?ZmZjNEM3NnljcVpjRXpORVpnR2QveUZSM29hVGJ6TlFoSzVaMThMbHgrdDE3?=
 =?utf-8?B?bEtWMy9wSUkwSlBTNFB4elBkMVdoY3ZqNSsrWmx5ajV1TktXYzZEc1o4NzBq?=
 =?utf-8?B?Sk03d21UT2M1WEZNZUU3NEwwL1UxYUg1T2xJQ3VpVXhiS2lha2pVT1pqREQr?=
 =?utf-8?B?N1BDbFFXV1BBZThMcHZ0eU1iTklrS2RkWXdQRjRRKzUreGNVd29vMUhIdXBK?=
 =?utf-8?B?ZnJGWjE2TEFJak5taHVxNFkvdFRNaU5xQzF0dHE3Q3VHZmo2K1ZYczlXMmls?=
 =?utf-8?B?YURlU09JYjk3ZmtsaW9wbVpCaTZVUWZjYksydWY5V0NKbHF1ckpWYmQrcVl2?=
 =?utf-8?B?UzRrNk1oZHFSMVMxOXJBN3BiMExtQnh6TDZXUnNwdkdISUkzQUE4aDQyT2Vu?=
 =?utf-8?B?SlBYaVdrSHZuNmh4dWxMSjU4QUpKRUo0MENLeHcySTRPZTkzSThnR1VRcGFF?=
 =?utf-8?Q?3D0ERngKxXhpZsgz/xJ2Yq+XQRVqY4Nf?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWpSZS9zVG83OG5yaTM3SUUyK2lnRkxWcGJFTGVPYVhLSXpVZCsxMHFVRnA3?=
 =?utf-8?B?VTUwMVFuRjBrekRCNmorTmRJWnQ4c3ViRFlYYUFUSHpubzZJVjk4UkFUczYx?=
 =?utf-8?B?YWJxNC8yeWk3Zk5neHNsSGpUQkNWWnZXbUk0bGY5MVdWalM0ckJuZEw5SUZM?=
 =?utf-8?B?RVRmQkxWbWw2UG9IeVpQNHR0WFh3ZGFwbE01bHN2NmtjU3FNOCt2cmU5Skgv?=
 =?utf-8?B?RkpPWTFkTGloVGlBMnV1cFJTcWIvWlBGdFQ3aVRQSHdjSWRkdUc5ejRDbE5V?=
 =?utf-8?B?TEJtM1VOTS9MUzBuc013cnNrdFNHUmZ6bmJoeDBabGRDWG15cFcvQTlmd3Ez?=
 =?utf-8?B?RGo3aDZXL2JNNktoUlplUVhSNk1iVjlNVHZDYU5NcUV0MmdjaXVSNmM5b2th?=
 =?utf-8?B?TlZaQ2lBTSs0UnUraksrazNyNnlQU3ZaRTYvbFYyZS8wc1cwL0FhUlNCQnhZ?=
 =?utf-8?B?MEN2NGJkbHRYcDNQcld3ZnlJWXBHd2c0SVNOclMzZ0hDMEZ5T0p2NlhaZlQ4?=
 =?utf-8?B?WkJiNFRmV0RKT0R0ajFEUHdHcG5zK1EzL1loQlpheVhDcCtFNUpxQm9tTGk2?=
 =?utf-8?B?VFRTV1JxNGZXbzFiRUdLNmxLa1JZTm1KUzdYa0owM2IxODAyaDd6Y0hIV2xj?=
 =?utf-8?B?MEN5V0U3UFNCNHNKakRTOTMwYVdkNHFkcXB4emwyV2VKRjVLSE9Zd2RmTXFJ?=
 =?utf-8?B?dFZxWlkyTUtwd3VreFZCQTlGZlpRNmVzRlk0UWFuVXdYL0NidkVyOHpsUnFW?=
 =?utf-8?B?YVVqcTZiaTMyaTJKcmZRZG1wR0VXZm1yNTZydGVDalFuSTkySDRtNTdrOEdD?=
 =?utf-8?B?OTl2ZXlQbFJLTVBuYlprd1AvUlBGczR6ZXZsMWphZ0FPTWdmcHRmd3NESGc2?=
 =?utf-8?B?TVVXN2NJTFY4TDBvTithdUNaRjRaN09NRGs2bVlPT1BtaXhZUlpGWmhlVTBz?=
 =?utf-8?B?aWhIakhYdHYra25PVkdnWlUxQUtBQyt3WjJkOFVXc096L0k4RDNNWE9CUVhV?=
 =?utf-8?B?ejdIaWFIZkRxbFhuaEx2dzliTHpXaHRzZUoyNzd2aHVrcUlRWVFpZWNuU3dG?=
 =?utf-8?B?czljb1F1S3dRZVVsSjBSem12RG5UbDVjSjVqYmdsN3EwRE5JL1lDQWFtcERt?=
 =?utf-8?B?UE04akJwaHFTTi9kYmhzR290NUpvc3p6ZzdhTkdsUE5HYWNLVnVlR090S1hY?=
 =?utf-8?B?MlkrWDZkeGZ0d2Zpano0N1BlaXFuSyt6K1k1aDhOdHFHaGZUS215SXBDMGxi?=
 =?utf-8?B?QTRlK2pQWGw5a2NJN25reGZ6WjRNYTh3YU9XaFdNNlNUcGVSOWREUjNKaGxE?=
 =?utf-8?B?djF6Nkh5Z2dNVXp2UmpoWXFQZ0pGVFp1b3plSG1uYldzN3dxc2QyQmE3QVNu?=
 =?utf-8?B?ZVQwS1BTbFNTQjhiaEdISzM2eDlWRWQ0RUEzVk9UdklVSnpNcnQ1Tzl1MkN6?=
 =?utf-8?B?YVpsWmF3WldnNTlLZ3VNSjdjS0ttVUFQa1BoV3puQUZQTXBJVjZjSVg5cnF2?=
 =?utf-8?B?cStTc3FwdjdNazlNUG02MEpmNi9JbWFxSUpybnJ6eDc4ZUx1MktSVzMrWVE2?=
 =?utf-8?B?WUN5WlYrQkJGbmZCMGdTUElCZ2pMU2NFdFpIamVYTER2L0hOTElqcmJBRjU5?=
 =?utf-8?B?dkVNQlF2enUwQlpQVElYR29ja1FRY0NqWEpKY0NLbWVoTGtleUowVHkwWStl?=
 =?utf-8?B?bDhPSE5XZjJyR3RQOWZaVEVkYjRPNXE1cGhMclpyMy83NURwVGhTMDAxa28r?=
 =?utf-8?B?RTdVUG9nZlJHVU9wcEpaSXo0dTA2dDd5MFZFVUYrTlZWWkZaWUhkMit3S0FB?=
 =?utf-8?B?aWhmMm5KRUpQR0VTR3M3RERFd1JMQXhwVEI5bzdJbDZXRi90ODdWMjdmT2xx?=
 =?utf-8?B?b3hIY1h3MkFSaDZ3bnV5RFB4L1QwUUd5aDJGZTN4d2NLMnpCZ2poWGJPc3lq?=
 =?utf-8?B?TjJkMkxhYi9uK0d4aE1NU2J6U2Zpd0hQTkVwNVV4UG1iampNdkpka0xkdGhR?=
 =?utf-8?B?alNqbWliN3ByL3BkSU1rTlN5ODZQNVJKK2FYcjVTUkR0WEVibmg1ZEtIS1Iy?=
 =?utf-8?B?N3ZoWnhUQmEvNkE1bElvZ29rSEpNR21PYmYzNlZraXZxQ2lQRnVlRUlsSGNW?=
 =?utf-8?B?WWIwU1RhdDUyV3dqQ2JXN0hHbVUzUjJFRWZIYm5ncnllK255dkdHVDNOMCtm?=
 =?utf-8?B?ZE04SGhGNlpUek9vNEZHWGlBQVliK2FSd0JBemE5em41RTR4RGs1MFVXaytv?=
 =?utf-8?B?UlpMZmJsZ0hCelg2b3lHZk1sbFNzUE5FQ01TU1d1MENHM2txb3BjR0taK0xV?=
 =?utf-8?B?TC9XaFN6Zk94eW55QmdpODl1bzcwNUtXMnh1cld0WWMvU0owbVd4Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cea0bf9-4cd6-47c3-1527-08de4d2c9970
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 14:05:08.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpJm6mJ0ZD8PZd3mvSHyN4ordAJ/CfdTw2fjH0ufob1QzNkzLHsoPo9zUj/Pzn35ueXqpvpv536OKfI3lZLCig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8468
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 14:05:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21384

On 06.01.26 05:11, Badrikesh Prusty wrote:
> On 6.12.y CIP kernels, CONFIG_MATOM=y as set in 6.12.y-cip/x86/cip-merged-config
> causes the kernel to fail booting on CPUs that are not Intel Atom, because Atom
> specific code is initialized unconditionally.
> 
> This enables CONFIG_GENERIC_CPU in cip-merged-defconfig, allowing the kernel to
> initialize generic x86 CPUs and ensure successful boot on non-Atom CPUs, while
> retaining Atom optimizations when available.
> 
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  recipes-kernel/linux/cip-kernel-config.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
> index c69c054..0e0326f 100644
> --- a/recipes-kernel/linux/cip-kernel-config.inc
> +++ b/recipes-kernel/linux/cip-kernel-config.inc
> @@ -15,7 +15,7 @@ SRC_URI:append = " ${@ \
>      if bb.utils.to_boolean(d.getVar('USE_CIP_KERNEL_CONFIG')) else '' \
>      }"
>  
> -SRCREV_cip-kernel-config ?= "fd712bb82f87c73dd9c0b4f0970edf5dacfe028f"
> +SRCREV_cip-kernel-config ?= "cda3f5841dec33b81f24cedcc32ea09bb58bbfb5"
>  
>  do_fetch[vardeps] += "SRCREV_cip-kernel-config"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

