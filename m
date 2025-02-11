Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21811C0219D
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 11:56:40 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.65])
 by mx.groups.io with SMTP id smtpd.web11.10572.1739274992711181390
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Feb 2025 03:56:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gCuqIzJC;
 spf=pass (domain: siemens.com, ip: 52.101.66.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ad1F08czhxixKA7yGuMRVcYYcE+n7IDPr6gFHOfYunadNA//14pJxl1+ngsU8H49gjD0Rk3GmyXPtXLWbSXtidrjyI9iwWIWbEjWRl/FuUqIvG6aS9krev0lFkl0pG3jQY+kJ0/B5sEtFo+rkgbmjpdzqF/tp7nkC0ICl8Il8rFc/IC5axWqeF/vxztU/ZpbUxbUSpnEBiymuGewsNHULAxvt2GcVc+aC1Rq9nyO2VATrXyalFHES/f6iXzfEDIa+4c0LQdLN0vKQtQJ85oWrmyOzWct+8ayKSx83Bqy/RxCgGb0lNqkEhJWnTsqi/DmdGmfBRdbR88kgcaN0+gBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqxN/ILgaP7pbvwXdY9eJNi7Ol6+0BLZ7KOROYqNbXo=;
 b=pj8z9M8Dk1/Z9bY0P23dhMhCkhj5M11sHOK9F1l+OXgAffxdv9d0FCLN1sfvwNQsh3vYTzOTssWlUr0BCj42K1B+ol89II1uJL9hb+QHXz4gBjQ/dcpIGW1Do53dxaAucV9Lalt1LOtsotDWVBOC7phNRISE70/Zeic1kTaXdKD9qXfHLxSWB2cM5bou3C/OGpNGM8V2zYvoZ/XZcTFx6lkkVYsNtWIcMt6eETaYod2rEW5F47IRPPm96TINkbnp47grn1FupIuDttdWvpmlacgmaIrQYmOEAxy8GFDDgRc8PlqlTWmzeUIYTd9UlRSxQrMlpj0SPyu6N7VVUwU80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqxN/ILgaP7pbvwXdY9eJNi7Ol6+0BLZ7KOROYqNbXo=;
 b=gCuqIzJC5uDvNuvlHdiM59sK25EuLF9hpH3cT4EF7tDvUkkAnUtZxAnRLZ6z2mId5y+vE+8qAY9kyOZNjIOBLYaSbl5/PitnaNWZrI9B5MYRi71MqGjprJlRZ1yHshTjUBorvLkV5uv40/hrggWnfli0Tv0ne/XQMv86HrfupIL/orTVs3SKKeUQurJ66No2/hgJssgYJTbBZU/Q97ZD62xzuZ/iVKX7PJPJ39QyLWlwKJ3izrluq/dbu6AT1wuafRZ4+JqmlzU/1cG3pZ8ExA2V8S//3eIcxCEvkSKqRQ/m0D09bicjxVA4fXxumR1fBB15eaK+Weqj/BAfz0c+DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Tue, 11 Feb
 2025 11:56:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 11:56:30 +0000
Message-ID: <abb03e85-248d-4e8b-8528-8b45b634cd2a@siemens.com>
Date: Tue, 11 Feb 2025 12:56:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 2/4] read-only-rootfs: add home
 partition with a variable
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 ludwig.nussel@siemens.com
References: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
 <20250211085125.22154-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250211085125.22154-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0394.namprd03.prod.outlook.com
 (2603:10b6:610:11b::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a317892-742d-42ac-524c-08dd4a931f2b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WkNEUXdLQXdyZngrRkE2ZXFabWQralpaNGZkWW5oeHZOOUs2RXVkaWl5N2Fy?=
 =?utf-8?B?RkdSWittOEdrUmVwUXpxemZkT3hmOGZTeVlGeEtJc2ZUVzFSbnpUbEJCaG9Y?=
 =?utf-8?B?MU1LQ0JpOUt0Q3MySzA4ZGxOT3ZUQ3lwS0daRHpmZUJobTZxZVRxWHlpZUp6?=
 =?utf-8?B?OWVFZ0RBUjdjVzYraE93RjFFME1TeTgyalZWNHp4TlpySDNJV3RpZGdvWGdp?=
 =?utf-8?B?d2JzdGhEa0lmTnhpb09HR2lqNnZjSER0Z0lKUE9yTDQ4MVNNUTJFeTRsVDNL?=
 =?utf-8?B?ZFZCbGZkWklWMVFBQmJOb0l5SzgxczlmcmFUYnB4R2F4NmxBNWtWb0M2V2Jo?=
 =?utf-8?B?S1NkTkVvWTNnMm9BUlhXYlQxdjEwbzFHN2NiQ2dQRWdUOFhTL2xMampKWCt3?=
 =?utf-8?B?eEhuM1FBaVJrdFUxckdsVmtGclc1N0k0SDBLVSs5ZndLK3Q2ZXR0NXdwUk1s?=
 =?utf-8?B?MzMyeHlDV0Q5WFQ0ME5BaHcxdlhLL2VYeVppVWhUTEVRMWhhSXhWK3FWVzZL?=
 =?utf-8?B?dzRQK01zbVFEYW82QXE2eFA2V1QxM2MxaWlscUJLeUxlcG5wN3hMb2VtekRC?=
 =?utf-8?B?em5wa3FhcWdhZVE5WkZQQ0tBZ1pHZlVxVjZmSzZrY0JpMmtNSGloQVRnVnIx?=
 =?utf-8?B?cDNGb2tjdGRZbEtrNFd3ZzBRRHZzS1lrQ09TWlF4c2ljQ0padVFwMEc5S3Fo?=
 =?utf-8?B?V3ZweXozeXJ1b2lLK0lCUE5NekxWVGt5TTJJOWJDTVNNeG8yTm1FMURYV0lr?=
 =?utf-8?B?dS9kcWhqbzNtVTZpMUV0UmQvZ2lORVJDV1pCdGZhdFhGbTFnRUVIVkNhWmpi?=
 =?utf-8?B?VUhKR1F5R1N2MFkyTGNDKy8yNkxibWh1eXVSWFZGa2RwT3RIQWxERHYzSFVJ?=
 =?utf-8?B?UU91eWVjM002WlpDNjZ0S1U5YWlDdjdHNDE1TjdYWitFK2xvWEM1ZjArWmVN?=
 =?utf-8?B?MlFFcW9oK3hieXU5V3FxcFRxdThoRU9IdnVZM2IwMkdYQTRiVXdCL2JXNFI0?=
 =?utf-8?B?QVhTZDBmbEQ3dis4alRlV0dIdU5DNVQrUGZucXdDd3ZVaFNrUHY1Q25vUFpl?=
 =?utf-8?B?aGlLWU1IQXRWRHZ6MUtWVGpmS1pUL05oYVFFVmhIclJCY3d0WG1BdDduNmpj?=
 =?utf-8?B?ZHFXYk91OXhlZlg4RGx2OFBjeDVldUpHSERYSCtSZTFHeEQycG5Ha3NzSjNE?=
 =?utf-8?B?eU5FYkt0Y0FWS0V0cUc4LzJpbHQrVmtwalUyZThiREdJcFpkUEVweE02dFpF?=
 =?utf-8?B?Sm9vd2t3S2hkM25Gc00vRGxyK1UwbGdNNlZ0U0NJL3UvTWRUUmoyNmdVOWJt?=
 =?utf-8?B?d0JyNFRYSTg4V3BrL3ZIeW1wdy81VU92a0pGbFNqaHVkMGJVWFRHeTd3aFpO?=
 =?utf-8?B?d1JWSUhrUEhrODUwU2haUzlzL1NNVmtQTU9FQ3NMOEpLMVV2WTN5OEN4ZCtU?=
 =?utf-8?B?MEUvRGVHUEVwK2JmdzFqaENjeU0vUGpRaStqYURRL1o3SjBjVS9LR2o3dVJJ?=
 =?utf-8?B?WnRnRFhCY1NKYmRydUJkbEJiUTJQR1N5TUV2RFdhY3VXbVBEeFF6ZlFqeDgx?=
 =?utf-8?B?MnprcGJJVjM1Q3l2NlBUWkZqeDZEVDZNeXpkcGRENWhMdUxrc09hT2NzdFQ5?=
 =?utf-8?B?QVVyQ05SazY1OHZxTXVGcHJSakhkSWl2SWxvMS9iUHNCU0lGdDM5VUhLTXJD?=
 =?utf-8?B?YzNING1KdTBnOEZINWRZUEU2TTRNZDkyS3ZtLzV3c3doN1NaU2ZlRGxXNHdR?=
 =?utf-8?B?TG5XM3FaMWNxei9PQjF3bVc5YWZ3TUJXNzZpNTNHL3J3QUFDT28vaG1uNFIx?=
 =?utf-8?B?R0w0b293VllIL096bFIwcENmNFh4MzY2Z2xiOVZKc3BRK0lVYWRqTjkvMmxk?=
 =?utf-8?Q?Qs73b2GS6845e?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZEkzUHNxWm1XV1NZdk1zUTJ6WERvQ2tlZzE3Wk10Ym5rTktOdmo3YXliOU1O?=
 =?utf-8?B?blJRZVZNUHBTRFhLS2VrMkl0V2t5REo1a3hzSnNFU2hENFVOcGl1VW1hbXlF?=
 =?utf-8?B?QlpMb1AzYVRrS0NGQVozT1RBcVhGalJCUHBkUnduQmxiZVdwS24zSEpZTjI0?=
 =?utf-8?B?czZUWTI2UUo5V0VMQmQrSm5uQ3k5OFFLWThQUlhzQ283c1JrdzBITVBzM0Js?=
 =?utf-8?B?UCthcGt0ZEt2bWxPQ3Y0a0hwVVpBWFZVczFma0lOY24yMDlBcUZTNk1NeTNR?=
 =?utf-8?B?Wjh0V2orektaT3EyLzIxR2pqd1ZqaWY3TVNFZHFuZXdRM0l2Y0JKbWxYc1pu?=
 =?utf-8?B?RkZVSGd2bnpmMU5CZ28rcTUvbWdLdEIvellOVnMyWDJEekRtWTJXaW81ZHVa?=
 =?utf-8?B?NDVWbWtldzZmaGpTb1IyRkZOTXlRdnp5alcvYVpoUHQxenJZT3VpR0I4RnpV?=
 =?utf-8?B?bm9VeGVxS1J1alo2dCtIN0pWVnUyWG9CL1BUM0hkQ3pzUHQybjZzbVhkT0Q3?=
 =?utf-8?B?TE5uZk9GU3Vlb0dkYzVaUm8xbXZiWjk5L2tYNWFBalNtellDMVYyaEN4bEJ1?=
 =?utf-8?B?bmVjUmFjbW1RMU03ZFd5KzRKVUdnK2dYcEoyV1RwT296RDlpS21mbUlKbi8w?=
 =?utf-8?B?em0wTlU2aDJFTXo5cGJyK083VGRIbitLSGJ6YmVpejRsS0Mva200RlRSRFBN?=
 =?utf-8?B?T0hZS0NlZHkzdWJ0bWZ6QXdYSmdtU3lxQmV6QVR0Z1NvVFJlaXBNckp3RjhD?=
 =?utf-8?B?bW8xQnozSVliWWpGbm8zdllHMEd5eVZLQnc0Ulo3bW5LOFA5VElUMzRRQzZZ?=
 =?utf-8?B?dkdlKzVXN0paOFJFN0VrVjhYNTBMM0VSUmlhLzBTRGI3N1RpSTNZS0FETkhD?=
 =?utf-8?B?UUliNXBkaWE3YUExcWVaWkJjRGg2N3J1UXZXSExZK0ZMbzh1bUZpUHoyMXBM?=
 =?utf-8?B?OG1TUStramlrdzB2Zi9EeVVSTDB0SHZSZ1dTejR4SUczc1Bkb1FMaVIzdCtj?=
 =?utf-8?B?bW5DYW5ZeVNYZ1o1a2RpMlZ0N1NmVXczNUZ2N1JqKzdUa2FTTmdjclByeXJU?=
 =?utf-8?B?MUJ1SGZxckdWYnJIUWtZSHVjR2diSUVCL2xhTzBQalZnWnFab2wwdGxZcGdo?=
 =?utf-8?B?UDZvejdxV3EwVVFNWXJod09OQkxQOWE0bTdnQmhjS1l1RDE5cis2WXpOY2pP?=
 =?utf-8?B?S3phSW5sQm1zZFNYVWoyM0ltcGx4STQyaXJOZ1BORHBrSDNHS0g0MHZudmRr?=
 =?utf-8?B?ek1uT1JMV0I0N0VtSEJ4SEpZaHVsMTBSNnBpSTNPZDVYbERsREU5dmVvNlJs?=
 =?utf-8?B?QlV5MDRhdGdOQXhxMGVwMzlMVnhnM0djU1F5TUFEVFlGOTQ5UThZaFJrZHow?=
 =?utf-8?B?ZzN5ZjVOZEd4b254K3hMWnRwMFJuYUR0cS8wSlhOUG5VWVZhSVJyaFNuYjd6?=
 =?utf-8?B?L3JwSUs1aUFhYkptMkRLenllakZEM2dLVm1tUm9hVHZDL3o2ZncwcUNUUmxG?=
 =?utf-8?B?amhTOTFIc2VDZGV5NWVhWTMzVTdZVFRTUDFqRkJYOTBLMU16bjEzcTJhQnA3?=
 =?utf-8?B?TmFydm91NUNlWDhNNS9zdDZZZE9rNGMxb2VYL2hOYlYyaURZQmc2N0pHeU0z?=
 =?utf-8?B?TnJtWUtTM29LaHZEb3hidWJVVFI0S2V4TStRbk1DZkRoYzRKV0FBY1N4QVNX?=
 =?utf-8?B?UE15MmJWVVk0ZUIvQlF2OG1vUCsyWExxK3A3Smd0anFGMEJtT3h5b0xqRWFL?=
 =?utf-8?B?Y2NSQSsrMmNWaGRJbHJqOGZSem5BVFVUazVXeVJNdDh5aWtpUTI5NENzS2NG?=
 =?utf-8?B?bUoveGV6U3dDV29pTkRqMklLWWw5cFlJYjF0dm9ScnNKRTZKMjdGQ29UN1hF?=
 =?utf-8?B?QmN5VjZyTnVaMml1RCtzVTZLVHA0WHdITmozVnk3QzlsMWRsMmZydzh6VFJO?=
 =?utf-8?B?ZUJGbXV1NEJsUUtlU1JNd1RHSDNlZE5MYnlQK2UvdHlpVzNLTGVQNHZ4L2Ji?=
 =?utf-8?B?ZzFObkxmVXd3b1IvS1dlTmZMTDZ5STJ1QU01UE1ZN2tjcSs4bUk1R3JadGRZ?=
 =?utf-8?B?ZWZhOWFMNlo2Rnd0TGk1WXlJNlJPTC9xb3lkNjZsRG1mbnFDNmwwcU9qdEhi?=
 =?utf-8?B?ZjN3S3pWOWh6VVdxRDdvRGF0TE81YWt4K0NmSGM5QmdBMFlqUHhSNmh1RDd1?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a317892-742d-42ac-524c-08dd4a931f2b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 11:56:30.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yABXyB6/UHp/6ka10/Y69btkjmDgvdCnYsT8Jb1hErSpU+zLhmWPKZRnGIfZkfSHMu8WCUs6uJUlIwuk9JLMsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8578
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 11:56:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17810

On 11.02.25 09:49, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows the user to disable the home partition to simplify
> the partition layout.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/read-only-rootfs.bbclass              | 1 +
>  wic/bbb-efibootguard.wks.in                   | 4 ++--
>  wic/hihope-rzg2m-efibootguard.wks.in          | 5 ++---
>  wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
>  wic/qemu-riscv64-efibootguard.wks.in          | 4 ++--
>  wic/x86-uefi-efibootguard-secureboot.wks.in   | 4 ++--
>  wic/x86-uefi-efibootguard.wks.in              | 5 ++---
>  8 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
> index acc04e0..99a2909 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -15,6 +15,7 @@ INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
>  do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>  
>  IMAGE_INSTALL += "home-fs"
> +HOME_PARTITION_CMD = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002"

How about WIC_HOME_PART? Sets the link to where this is used and avoid
"CMD" which sounds to me like running a shell command.

>  
>  IMAGE_INSTALL:append:buster   = " tmp-fs"
>  IMAGE_INSTALL:append:bullseye = " tmp-fs"
> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
> index e6c3e15..b5325d4 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -14,8 +14,8 @@ include ebg-sysparts.inc
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
> -# home and var are extra partitions
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +# var is a separate partition

This comment should move one line below. Or rephrase is like this: "var
and optional home are extra paritions".

> +${HOME_PARTITION_CMD}
>  part /var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
> index fb3f090..8ec6c84 100644
> --- a/wic/hihope-rzg2m-efibootguard.wks.in
> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
> @@ -6,9 +6,8 @@ include ebg-sysparts.inc
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
> -# home and var are extra partitions
> -
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +# var is a separate partition
> +${HOME_PARTITION_CMD}
>  part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 00d627d..ba4619d 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -3,8 +3,8 @@ include ebg-signed-sysparts.inc
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
> -# home and var are extra partitions
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +# var is a separate partition
> +${HOME_PARTITION_CMD}
>  part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt --append="panic=5"
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 17434d1..c6a0d8b 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -6,8 +6,8 @@ include ebg-sysparts.inc
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
> -# home and var are extra partitions
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +# var is a separate partition
> +${HOME_PARTITION_CMD}
>  part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt
> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
> index 1a2291e..0f951f2 100644
> --- a/wic/qemu-riscv64-efibootguard.wks.in
> +++ b/wic/qemu-riscv64-efibootguard.wks.in
> @@ -6,8 +6,8 @@ include ebg-sysparts.inc
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
> -# home and var are extra partitions
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +# var is a separate partition
> +${HOME_PARTITION_CMD}
>  part /var --fstype=ext4 --label var --align 1024  --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt
> diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
> index 0f4d637..470e783 100644
> --- a/wic/x86-uefi-efibootguard-secureboot.wks.in
> +++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
> @@ -3,8 +3,8 @@ include ebg-signed-sysparts.inc
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
> -# home and var are extra partitions
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +# var is a separate partition
> +${HOME_PARTITION_CMD}
>  part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
> diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
> index 9d344f8..a940f26 100644
> --- a/wic/x86-uefi-efibootguard.wks.in
> +++ b/wic/x86-uefi-efibootguard.wks.in
> @@ -6,9 +6,8 @@ include ebg-sysparts.inc
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
> -# home and var are extra partitions
> -
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +# var is a separate partition
> +${HOME_PARTITION_CMD}
>  part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

